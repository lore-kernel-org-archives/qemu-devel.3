Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F27FF60F7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VkN-00080N-AH; Tue, 31 Mar 2026 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w7Vk8-0007wp-1b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:50:41 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w7Vk5-0007uu-Lc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:50:39 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2c7e5f38b37so833740eec.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774950634; cv=none;
 d=google.com; s=arc-20240605;
 b=Rao7UiKQnqoqUgvWuOs5k9m2Z5FpELw6dhbW5BftBgOtJ4ZAtB7iXlrWi60DSoB6Bo
 ToI6mYuBDytaZPklaf0jm3juzrsBrRksjgoOT/RLXv+YnStKrnb5I2uEThsyQZjvy4Ic
 LvqzBlO4RDUqwtBbKrlp+mYuwMVpPEDBfv9Hd/u/RDQcCoSDHz8lHxQpVtxMiHrcvSSX
 vSShI+KYVgA7g9so6ey14vccV8XXhe/jxUIUL9QOWVKtU0x3xc5fTTPWgIE4p6BP+sAw
 Guthr8oJoNSXa3kbIcDo4uoA77MIEeQJHdvZSTlNVDEz7TQX0drQELp8sFpC6zamSSRk
 hjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=abRzHSUrFbgkPXutS4N0BEfl4YMunFlE4WAnmeRtVYc=;
 fh=EOstN047P43BMWYiYfNjXAFqxVDAuquNnj26iYRON0Q=;
 b=iI9/gLEFkp2UX89Y5+HSBxmr1e5uwX74UN3W3nxzzfHjK5ggdBQUlu0zEIERvRxnUz
 oA9pX9xdeio/Jy99i83+T32wGg8zHGoVVb2k26toi89mSMOzqcJykcaqfXyU1vn7XBve
 1QstqX2rNbqfp5vm6HkX+kq2che19y1nArpCJT3jTx68fBwoWSYhY9yAHoWCRnb152sJ
 HCDcMsIgAsi4s/BAFc5BXnNvv9r8lJM8wLOErt8xiJeWTB8ti2qos7BSnIkokwPz/52n
 qoNq+FUJlwF5naMhxXBb2whL/f6YVxzA/R+bqf55AxMglCCFCx15phmmqzSfcLyPzl37
 3RBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774950634; x=1775555434; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abRzHSUrFbgkPXutS4N0BEfl4YMunFlE4WAnmeRtVYc=;
 b=jyraxdZWOuY0xbcjGbv4iwkRDVDE/2LD9bgltQLREL7zmCrY46/KNeCdDEwYY8BqNs
 aInMVACYXxwwVspLmcpR6CIkokPiEPD0HFeB27OQg/T0XZTCEhTnk84IoeR5tlCvqcRh
 DyNattfVvu2JCb61xaLdO0AcEry+36osv8SQrlXOzgCDYL/U0spsk3khQLtHDYILNAUv
 9ioZeVCB35uDGh378CtE6J4TEW9+XaajBDDoLEeP6ReG7fJoIZcmelZIedCZIyoiXk72
 IF4Q/NICn33+u8hVvBoXYhkiF41OEpmoBgkl+tGi2BG15AJsUFQbE2+Dfvjig8ihxace
 n72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774950634; x=1775555434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abRzHSUrFbgkPXutS4N0BEfl4YMunFlE4WAnmeRtVYc=;
 b=kkYFX0a0PiiZqDUd/hmPgJM+PkXSmLDBLDCL7FVgXe9SJSgRgu7n0RjwayAlKRB0fS
 BtKaw6bZDdvFWjgBN+QIUg3o1lnqpQu4y2Gq7NvcDCzIwwx+H34pzYHIqOZppEElKzlD
 DTeNbGlzu4NxqMiJpUsFPAn9G+P4HF8glTPb9lgOUtkScKgNmT7LZEM9STycWm1thTph
 JFpimg3HPcAsHuUsX41dtkmeP4e+BlFQvtbSQixdDdch37a4ps55F4nn22PIcNZ1moUn
 ZE/TxejkR2/o7C1F5klGGkm0UIlWb9PvSg6SmY7R1otyNZMR9rg7cv+jR576H2KQhqoZ
 Mb2g==
X-Gm-Message-State: AOJu0YwgwfL0VwNGNlViC0H2UiuMnqzAakHde10hm71SDs1UdDy8zyuO
 fHGYl9+HFFN+EZpjiDJSmp9H1sh0Fyg5DyVcqpd7mdxaiFwE6yvAk98ILNmR0Q8j1dMwJsUtCpd
 vnvdN4kkRN4R7guLMQaL8Kw5sZrqQo84=
X-Gm-Gg: ATEYQzzl5LROvc700y0L48d4lpDFC320UdDzyHl8bg9qBYbpOh3buyOJNdwNbd+gt7C
 Ybjhc+bGzI68ttqPcFfcKrjLuYjxHo+Uoa0OoSR3guDnsAHLlhbc/+geucq+RZXWVW3V7pLBGn8
 0HEQXJonOFkBNziQoXEATlJalKPZS5888QeQR4J6IYuNQjdYEKOB9AvqD+rbs6tGq9co14Wq4/B
 CDjqKdFERq50qD2Dye7HVxwsLksLR2nzSIqkVBBXS4hCD/9h2VGiIRvHdN9NoVpiUzq7ldmc2D3
 XtypNMINrScE2ZRVhLvIyur1V4vnwXPProB65iCYYukjMu3JmA==
X-Received: by 2002:a05:693c:3005:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-2c185f3905emr8614841eec.27.1774950633875; Tue, 31 Mar 2026
 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
 <CAMxuvaygbUf3eS+r-6=dxiZfHp5KrD7_QLhhnTf7KHfxU+CjPw@mail.gmail.com>
 <CAMxuvax+1omtWMs964yg1ZgFrHn_f2JP98540hY8uPfD-HF8Mg@mail.gmail.com>
 <DB8P190MB0714A01F3BAE878AA0F7888BDB52A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB8P190MB0714A01F3BAE878AA0F7888BDB52A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Mar 2026 13:50:21 +0400
X-Gm-Features: AQROBzAzaipCiOaudZN1I32TEckBBi0qo30iRlTeuGVOu5VXwmzl3BGffT04YDY
Message-ID: <CAJ+F1CLUzOV5Sv-xCuDJz8eapBs3=GV9XcSFgLynRbJqq1sTMQ@mail.gmail.com>
Subject: Re: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
To: Anton Kuchin <antonkuchin@nebius.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132a.google.com
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

Hi

On Mon, Mar 30, 2026 at 7:30=E2=80=AFPM Anton Kuchin <antonkuchin@nebius.co=
m> wrote:
>
> Hi Marc-Andr=C3=A9!
> Thanks for the quick review.
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Sent: Monday, March 30, 2026 12:27:29 pm
> >
> > Could you check if this is good enough and resend:
> > -if not have_system or audio_modinfo_files.length() =3D=3D 0
> > +if not have_system
> >    subdir_done()
> >  endif
> >
> >  modinfo_dep =3D not_found
> > -if enable_modules
> > +if enable_modules and audio_modinfo_files.length() !=3D 0
> >      modinfo_src =3D custom_target('modinfo.c',
> >                                  output: 'modinfo.c',
> >                                  input: audio_modinfo_files,
>
> I checked this and configure passes, but then build fails with:
>
> FAILED: tests/audio/test-audio
> clang -m64  -o tests/audio/test-audio libqemuaudio.a.p/audio_audio.c.o li=
bqemuaudio.a.p/audio_audio-be.c.o libqemuaudio.a.p/audio_audio-mixeng-be.c.=
o libqemuaudio.a.p/audio_mixeng.c.o libqemuaudio.a.p/audio_noaudio.c.o libq=
emuaudio.a.p/audio_wavaudio.c.o libqom.a.p/qom_container.c.o libqom.a.p/qom=
_object.c.o libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject=
.c.o libevent-loop-base.a.p/event-loop-base.c.o tests/audio/test-audio.p/te=
st-audio.c.o tests/audio/test-audio.p/audio-stubs.c.o -Wl,--as-needed -Wl,-=
-no-undefined -pie -Wl,-z,relro -Wl,-z,now -g -O2 -fdebug-prefix-map=3D/hom=
e/antonkuchin/src/qemu-upstream/build-with-fix/..=3D. -Wformat -Werror=3Dfo=
rmat-security -Wdate-time -D_FORTIFY_SOURCE=3D2 -DVENDOR_UBUNTU -Wl,-Bsymbo=
lic-functions -Wl,-z,relro -Wl,--as-needed -Wl,--start-group libqemuutil.a =
subprojects/libvhost-user/libvhost-user-glib.a subprojects/libvhost-user/li=
bvhost-user.a -lnuma /usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-=
dynamic /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread /usr/lib/x86_6=
4-linux-gnu/libgnutls.so -lm /usr/lib/x86_64-linux-gnu/libpixman-1.so -Wl,-=
-end-group
> /usr/bin/ld: tests/audio/test-audio.p/test-audio.c.o: in function `main':
> /home/antonkuchin/src/qemu-upstream/build-with-fix/../tests/audio/test-au=
dio.c:588:(.text+0xff): undefined reference to `qemu_modinfo'
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
>
> I think that's because "executable('test-audio',..." is outside of condit=
ional block and it doesn't work with "modinfo_dep =3D not_found".
> If I move "executable('test-audio',..." inside the block configure and bu=
ild work but I'm not sure if this is what we want here.
> From the structure of the original patch I assume that test-audio is supp=
osed to be built even when enable_modules is False. Does it?

yes, both cases should work.

There are two issues with empty modinfo atm:
1. modinfo-generate.py requires non-empty modinfo files list
2. meson @INPUT@ require non-empty list

I will modify your patch this way, I tested it works and will send it for m=
erge:
--- /dev/null
+++ b/tests/audio/modinfo-stub.c
@@ -0,0 +1,5 @@
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+const QemuModinfo qemu_modinfo[] =3D {
+  { /* end of list */ }
+};
diff --git a/tests/audio/meson.build b/tests/audio/meson.build
index 84754bde221..be96313a63e 100644
--- a/tests/audio/meson.build
+++ b/tests/audio/meson.build
@@ -6,12 +6,14 @@ endif

 modinfo_dep =3D not_found
 if enable_modules
-    modinfo_src =3D custom_target('modinfo.c',
-                                output: 'modinfo.c',
-                                input: audio_modinfo_files,
-                                command: [modinfo_generate,
'--skip-missing-deps', '@INPUT@'],
-                                capture: true)
-
+    modinfo_src =3D 'modinfo-stub.c'
+    if audio_modinfo_files.length() !=3D 0
+        modinfo_src =3D custom_target('modinfo.c',
+                                    output: 'modinfo.c',
+                                    input: audio_modinfo_files,
+                                    command: [modinfo_generate,
'--skip-missing-deps', '@INPUT@'],
+                                    capture: true)
+    endif
     modinfo_lib =3D static_library('modinfo.c', modinfo_src)


> Or should we build test-audio only when modules are enabled?
>
> --
> Anton



--=20
Marc-Andr=C3=A9 Lureau

