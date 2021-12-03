import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String Change(int u) {
    if (u < 10) {
      return '0$u';
    } else {
      return '$u';
    }
  }

  List<String> song = [
    'Arms.mp3',
    'Peaches.mp3',
    'Woman.mp3',
    'Badguy.mp3',
    'Badhabits.mp3',
    'Letmedownslowly.mp3',
    'Levitating.mp3',
    'Me.mp3',
    'Stealmygirl.mp3',
    'Worthit.mp3'
  ];
  int n = 0;
  List<String> songname = [
    'Into Your Arms-Witt Lowry',
    'Peaches-Justin Beiber',
    'Woman-Doja Cat',
    'Bad Guy-Billie Eilish',
    'Bad Habits-Ed Sheeran',
    'Let Me Down Slowly-Alac Benjamin',
    'Levitating-Dua Lipa',
    'Me!-Taylor Swift',
    'Steal My Girl-One Direction',
    'Worth it-Fifth Harmony'
  ];
  List<String> img = [
    'arms.jpg',
    'Peaches.jpg',
    'Woman.jpg',
    'Badguy.jpg',
    'Badhabits.jpg',
    'Letmedownslowly.jpg',
    'Levitating.jpg',
    'Me.jpg',
    'Stealmygirl.jpg',
    'Worthit.jpg'
  ];
  var i1 = Icons.pause_circle_filled;
  var i2 = Icons.play_circle_outline;
  var i = Icons.play_circle_outline;
  bool play = false;
  late AudioPlayer _player;
  late AudioCache cache;
  Duration pos = new Duration();
  Duration len = new Duration();

  SeektoSec(int s) {
    Duration newpos = Duration(seconds: s);
    _player.seek(newpos);
    setState(() {
      pos = newpos;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    _player.durationHandler = (d) {
      setState(() {
        len = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        pos = p;
      });
    };
    _player.onPlayerCompletion.listen((event) {
      setState(() {
        if (n == (song.length) - 1) {
          n = 0;
        } else {
          n = n + 1;
        }
        cache.play(song[n]);
        play = true;
        i = i1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.black54,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MY MUSIC',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'All your favourite songs at one place',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  height: 200,
                  width: 200,
                  image: AssetImage('assets/' + img[n]),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black12,
                            Colors.black,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(20.0)),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if ((pos < Duration(seconds: 3)) ||
                                        (play == false)) {
                                      if (n == 0) {
                                        n = (song.length) - 1;
                                        cache.play(song[n]);
                                        play = true;
                                        i = i1;
                                      } else {
                                        n = n - 1;
                                        cache.play(song[n]);
                                        play = true;
                                        i = i1;
                                      }
                                    } else {
                                      setState(() {
                                        SeektoSec(0);
                                        cache.play(song[n]);
                                        play = true;
                                        i = i1;
                                      });
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 30.0,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (play == false) {
                                      play = true;
                                    } else {
                                      play = false;
                                    }
                                    if (play == true) {
                                      cache.play(song[n]);
                                      i = i1;
                                    } else {
                                      _player.pause();
                                      i = i2;
                                    }
                                  });
                                },
                                icon: Icon(
                                  i,
                                  color: Colors.white,
                                  size: 40.0,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (n == (song.length) - 1) {
                                      n = 0;
                                    } else {
                                      n = n + 1;
                                    }
                                    cache.play(song[n]);
                                    play = true;
                                    i = i1;
                                  });
                                },
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 30.0,
                                )),
                            IconButton(
                              onPressed: () {
                                Random random = new Random();
                                int randomNumber =
                                    random.nextInt(song.length - 1);
                                setState(() {
                                  n = randomNumber;
                                  cache.play(song[n]);
                                  play = true;
                                  i = i1;
                                });
                              },
                              icon: Icon(
                                Icons.shuffle,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${pos.inMinutes}:${Change(pos.inSeconds.remainder(60))}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SliderTheme(
                              data: SliderThemeData(
                                  thumbColor: Colors.white,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 6.0,
                                  )),
                              child: Slider.adaptive(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.grey,
                                  value: pos.inSeconds.toDouble(),
                                  min: 0,
                                  max: len.inSeconds.toDouble(),
                                  onChanged: (value) => setState(() {
                                        SeektoSec(value.toInt());
                                        value = value;
                                      })),
                            ),
                            Text(
                              '${len.inMinutes}:${Change(len.inSeconds.remainder(60))}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Text(
                          songname[n],
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                'Next Song: ${songname[(songname.length - 1 == n) ? 0 : n + 1]}',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
