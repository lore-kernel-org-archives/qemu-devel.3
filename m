Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9497CCD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWIf-0003rn-GP; Fri, 05 Jun 2026 11:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVWIe-0003r9-5a
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:17:32 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVWIc-0005CN-8l
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:17:31 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6607e80a846so2281713d50.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780672649; cv=none;
 d=google.com; s=arc-20240605;
 b=Mn+IBsdsKKabxRkcH9DnDDNmtW4/puqGZ5vpUPNWcTF+PX3PAM5bGBirG7rYM6rZUw
 q9+QF4mJvYIRM0V/0f8HD72shP/qKDL1DP5hxgk3p6WJIa5IGSA/jd2yDk/O/TwuLIUr
 bMt8A4aQTd3lmizCYEULcGpnz2bDqo0HJ9S2dlRt5XuMItd5YOrWUSFWuC5+/KDa++TE
 AaFpfjYRJOu0L0KG1poiK8pH88e+Mm8MNjsj3b3BA3VnEWGq5SMxNpDdJP4guIfECqET
 erOc97OrtWbZ8A8g8ki5f6b23OtogAg8HORJX1VNMqly9lrABGKwl+HI7t344RRgYZay
 VMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TlV6uccuueVL0o7X6oXfHPstPNTZx+NZFCwWUlnenr8=;
 fh=Joi58iYGdNDSpwWHIA77WPmmoMvPov9M9TFNSuwpHxs=;
 b=hx0095TOEyTBKFbNQUQWAKDCgI3eqyyTwCds0oMy8pwmE6zDNPpZI7vsYCWZGqX2G/
 qAb88CrtXVFr9bwxacqagG+n86k+L8JVwIk4KvI4DaieX0xXXlGgWSSD4Eaceky2SCpO
 DejtkonezN+kpHl+7RbKvi/UtIOJFQrckd7w9m3qXC3Jv372iSmV52WYYq26DNlpPPJq
 5Ild90Df0c4uf8U3x7VsT27LhhbFnqZxJE5E9M0wJewUcm7OlkXz86KI67kmPDbWuJ0u
 3tyQfND0t4NB1v1bJIWCPmyqqL8PP/p2YMBUjLMo3sMI+l/5uvVks+Itu0X1wiaRzJSz
 QFmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780672649; x=1781277449; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TlV6uccuueVL0o7X6oXfHPstPNTZx+NZFCwWUlnenr8=;
 b=AxLZxvXPbt2g40cLdnIiR9UjNbTMfYqBhtm+a9hgdVdIslW3W/KBPoOxBdLvcjeCRC
 4cRQkpEQBMImrM/+mO1AF/N4k2stE1N8AIoWFDerBIXMK6Q9/9XydLV6GRnEJV985dOM
 49ImYB7a5Yt446Sv+9OET3YvHC6lA+RSwM+M8E7ZFWK868ZPhXfuenuGehx6trys4IGd
 Pp1I9zm+0cTkDKvLysuj04Zzq0tliLbaRac+YZPjoTA9mDslOAUpwBhzuxv5VV0+1LoT
 +2fgwfedbTuPUiH5e9GD6nU5HcsrRIjbGvtD2yLOIS1OyCDyZ339RDB7V2uAvXYI/C5P
 1RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780672649; x=1781277449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlV6uccuueVL0o7X6oXfHPstPNTZx+NZFCwWUlnenr8=;
 b=mtXchGHINPquFfCFyxa8gXnR1JKiTGW7KUCzFArQ3nREYK/fmsBFF2i38x9eR35Iep
 TkAGfvkMTr3olE0xrs0CRLVSVIzjbp2ga3Z15/bW2+WNRrxGKO8W2YLeKUeoQ5yKC8tx
 Gy0LwnQKzMw7Bgqx3KSm6DPuUGWDFeKEC7x4BIQu0uuNAJERJfKJjaeKcXxbAmK4HX9I
 JNsbjveqbBr1CzJM1W66L1tpYSykA7Os01Dw/yA/Jz4blhXAdObk8Q5L5Jxh362aFjS2
 ygGN8Xf5RFJy+7LH8sKj/mazBiYqHFiH6pnVl6vI0zt/F+T5WZxwrFuvm40cGmvv0X6B
 G8/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8077c4ozRxoMcGBT6XjkSKpILVPSEdxEFHTHY1pX8UWqDv7HrRAV8u3j7gOiTUGu54j6qbB2OycffJ@nongnu.org
X-Gm-Message-State: AOJu0YyJwNg1EjRCNo/QKGaiJP74SwUk0UWETLpRXVJvHKnw8W0v+fw1
 ovjoEq+ALk0W2yIbOTxtNmVDuRt/LB+7360rnly6jC+lVpBq/FVpxdioEgzs0Y0omyIgw5CHg6b
 jFT44eaOnBuMkcmBpjnSgmksvqEdTMPY=
X-Gm-Gg: Acq92OFHw8HKHLzbwmnPLxkbns/pW0rNR31sdqmIiOE64gMfEooNhUopURLiPH0+eqz
 6dVIHh3rc1NojjfG0wkbsnrOO/0M2VqrE0D2CM4JkNiaMrQfpSniTKhttvfK6ZcacBZzjIQ28FX
 fONLFCnWw3wv2aiOBcXweq++Fu+TQZHEoDSNxVIwsW6z3B30oRUiPLSNgqGHxf2xrVXu3g4kqhF
 1vikalga3I0uYSsxvm+QIz1Fer3fwb/wHYfC9cU2L6Y/n8JBI9/0Dx/NBwIgPBGF10/JBEROqtb
 i7F4VXv9xNhM6102DYzJXV2mxGPsrHOJwALON43D5cG409iBe0K6
X-Received: by 2002:a05:690e:1514:b0:660:6318:eec8 with SMTP id
 956f58d0204a3-66106f89b2bmr3767009d50.56.1780672648758; Fri, 05 Jun 2026
 08:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com> <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Jun 2026 17:17:16 +0200
X-Gm-Features: AVHnY4JcqpDYLub8_8wPU29zStbbhcGH8sdT2jqueQJnsE185kLpS_82lfvts7c
Message-ID: <CANNYZj9X4bSFxOMapsL7fB=q-GEO6oJMtwz3oPkfcX1ww1oaMw@mail.gmail.com>
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=alex.kanavin@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 5 Jun 2026 at 15:08, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> > Note that the environment we run in is X11 without wayland, e.g. a
> > XTigervnc server that provides a X11 display.
>
> Cc'ing Pierre-Eric Pelloux-Prayer
>
> My best bet is that SDL_HINT_VIDEO_X11_FORCE_EGL triggered the host
> issue, but the stack trace cited above contradicts with that. I don't
> exclude the possibility of a QEMU bug either.
>
> Can you confirm the stack trace is from a run with X11? If so, the next
> step would be to symbolize the stack trace. Otherwise, re-generating the
> stack trace with X11 may help.

Please note the comment above about the environment - it is x11
without wayland, provided by xtigervnc.

I got a stack trace with symbols:

#0  0x00007ffff721b4f4 in pthread_mutex_lock () from
/home/akanavin/bitbake-builds/poky-master/build/tmp/sysroots-uninative/x86_64-linux/lib/libc.so.6
#1  0x00007ffff5a9a9e6 in wl_proxy_create_wrapper
(proxy=0x5555583f2940) at
../sources/wayland-1.25.0/src/wayland-client.c:2800
#2  0x00007ffff58bf994 in dri2_initialize_wayland_drm
(disp=0x555559548070) at
../sources/mesa-26.0.6/src/egl/drivers/dri2/platform_wayland.c:2680
#3  0x00007ffff58c0e7e in dri2_initialize_wayland
(disp=disp@entry=0x555559548070) at
../sources/mesa-26.0.6/src/egl/drivers/dri2/platform_wayland.c:3288
#4  0x00007ffff58b899d in dri2_initialize
(disp=disp@entry=0x555559548070) at
../sources/mesa-26.0.6/src/egl/drivers/dri2/egl_dri2.c:895
#5  0x00007ffff58abc3b in eglInitialize (dpy=<optimized out>,
major=0x0, minor=0x0) at
../sources/mesa-26.0.6/src/egl/main/eglapi.c:697
#6  0x00007ffff7cc77f5 in SDL_EGL_LoadLibrary
(_this=_this@entry=0x5555584054a0, egl_path=egl_path@entry=0x0,
native_display=0x5555583f2940, platform=platform@entry=0)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/video/SDL_egl.c:547
#7  0x00007ffff7cf4695 in X11_GLES_LoadLibrary
(_this=_this@entry=0x5555584054a0, path=path@entry=0x0)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/video/x11/SDL_x11opengles.c:56
#8  0x00007ffff7cf3ec8 in X11_GL_LoadLibrary (_this=0x5555584054a0,
path=<optimized out>)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/video/x11/SDL_x11opengl.c:270
#9  0x00007ffff7cd4734 in SDL_GL_LoadLibrary_REAL (path=path@entry=0x0)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/video/SDL_video.c:3493
#10 0x00007ffff7cd66c3 in SDL_CreateWindow_REAL (title=0x555556029e87
"", x=536805376, y=536805376, w=1, h=1, flags=42)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/video/SDL_video.c:1717
#11 0x00007ffff7c52688 in SDL_CreateWindow (a=a@entry=0x555556029e87
"", b=b@entry=536805376, c=c@entry=536805376, d=<optimized out>,
e=e@entry=1, f=f@entry=42)
    at /home/akanavin/bitbake-builds/poky-master/build/tmp/work/x86_64-linux/libsdl2-native/2.32.10/sources/SDL2-2.32.10/src/dynapi/SDL_dynapi_procs.h:545
#12 0x0000555555be7b04 in sdl2_window_create
(scon=scon@entry=0x5555584240f0) at
../sources/qemu-11.0.0/ui/sdl2.c:106
#13 0x0000555555be92de in sdl2_gl_console_init (scon=0x5555584240f0)
at ../sources/qemu-11.0.0/ui/sdl2-gl.c:306
#14 0x0000555555be78e9 in sdl2_display_init (ds=<optimized out>,
o=0x555557124140 <dpy>) at ../sources/qemu-11.0.0/ui/sdl2.c:957
#15 0x0000555555b2938f in qemu_init_displays () at
../sources/qemu-11.0.0/system/vl.c:2689
#16 qemu_init (argc=<optimized out>, argv=<optimized out>) at
../sources/qemu-11.0.0/system/vl.c:3847
#17 0x0000555555892529 in main (argc=<optimized out>, argv=<optimized
out>) at ../sources/qemu-11.0.0/system/main.c:71


To me it seems like forcing EGL triggers those wayland code paths
where the crash happens.

Alex

