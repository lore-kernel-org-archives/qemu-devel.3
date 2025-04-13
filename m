Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8236C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 08:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3sS5-0008Ny-C3; Sun, 13 Apr 2025 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3sS3-0008NO-QE; Sun, 13 Apr 2025 04:12:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3sS1-0008NC-JK; Sun, 13 Apr 2025 04:12:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso27525045ad.3; 
 Sun, 13 Apr 2025 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744531943; x=1745136743; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hHYxAPG4HscecFbl3SvusMDS+87Gf+gDrve/uesEeXY=;
 b=iFBPMKznKFjb0Bj/ze1qPOphHSSEmOZ4hxtyNYgZE3TX7lnwtD6eaXBYhsiCYywaQE
 kZX3gYykOEl1JLp726AgagljaL5Ya7Dl8Pv1f1FGXy0JZOAOJfowMDV1VkcAiY0A9lDZ
 v3Uu67qiOdmVdQOGrqMiZasRuhO0j9qcA5me4hPmBIUOqsdlTarMsZDSIAu0K4gTHnhg
 KloGR79q6B6iSZKHSl9pjeAf9xU5EIVgwFqlUypKgdBx/39U129SH4tbhzi4hZzYgMRe
 Tdg2tiKiSzWSmN1ci2lI6vt5W39auvyAcZE+TwMvmG3AnMMnufFPbpfMA9FeXlIT2xzl
 Aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744531943; x=1745136743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHYxAPG4HscecFbl3SvusMDS+87Gf+gDrve/uesEeXY=;
 b=rG9OnLcvxfpUSBeQoehGkOnz5WP9KAjAYkJmGr8WqCvW8zAT9ez8DdVdg8yzZQqm54
 a0okeETYzg+pesSm6N3HMutEeEEpIGHzElw5DClx/QCO/c8sjPdb1uLL2UxHv3Ti/sD1
 bgzpSBZCaVxBbquBp+dytrpqu4cq5fqDovGekObY7+p9stqxtEfJ0HU5i5UFXRUHwFWc
 0vVL+AORSATuwFd6zi02CXPOU3mKZudPjizlU54/cTllUtMo2GTtLtkHlKG/LCpLJw2E
 nsJpUxS3d9zswsz+eHmnzwwEFU20YhEI8UB0Ie+Hm6NsuKH0Ee8e+zq7fW2y0rtNrhDA
 /czg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUC3X38YT9flB1K0oL5/q7LM/rs4AaJkgxqcc057ePuUKC/jnxkDUpm8bFsYUXXuIrxszhWFtbnoNdww==@nongnu.org,
 AJvYcCWH6ta6f6Vegw+e9jyvqU+TwQnWxsS68r9Aq2+5/7ZHhMKX1oiZeKFbvICVHGDMXufaDsbcU7sMCg==@nongnu.org,
 AJvYcCXRrJyRRnuIdSifV3pEFwFET2ZUC+qWnhEFfdUe9k1SXb67zN09eVYpdrTYHp+cwpjYzfCIb1M3HWLQBA==@nongnu.org,
 AJvYcCXxgLS1kH9aGxxsVXnuGa5aCRLRHn35dZ5H1VbqRkbEtcxHQJqQlQyqSYzvGPCxAHKxy4ihQMDjr7CeAg==@nongnu.org
X-Gm-Message-State: AOJu0YwYrZgm/fnyPhsPOk0bZyW9MXtBRIgrif4mGz/L0drXERpyJqJU
 PxXlN/UwAF78DOwLhtaKzRZpcAJZVV3Bf2s/3Ii7dQnauFaPnsD3dpBVypb8yVE2UbWWItkQhja
 bDC1HMJ7UjuoUNCaI7rPnaeso030=
X-Gm-Gg: ASbGncuC8Vec8p2O0JrRAK69u4WDYpnWUrqLPEs1pBUjepnJJ+/zpjt0+QC5/pzi2Pf
 YUoHIKjipi28JOeaYpt8ZIQJQwfA2Bj2r8ROdS5F311Jj2+yPrEiediHwSeSFVpeeut3rQuJ50J
 L3VETLY8SUcc0ZSWCI6OXkfAs/1cdMLjjQ9WZgn8sYQLFQo7fx8+HyDpN//HkcE90=
X-Google-Smtp-Source: AGHT+IHy0gvR1OFRk8acELSes8+gRhq2dCuronrYZVqAn7WS9DbS+UAmjnsgmS/ItTPvKZeQdoLA36F8fXZ73YBaIew=
X-Received: by 2002:a17:903:904:b0:227:ac2a:1dcf with SMTP id
 d9443c01a7336-22bea4bd870mr117487785ad.23.1744531942469; Sun, 13 Apr 2025
 01:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2441396.svyq9LpYvz@silver> <1881242.gqbg26PhFk@silver>
 <2555565.yjhJSkacHZ@silver>
In-Reply-To: <2555565.yjhJSkacHZ@silver>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sun, 13 Apr 2025 17:12:10 +0900
X-Gm-Features: ATxdqUFCEpYT280w1rb2J-M5TCyeizlaYvOi8cl4BFqwoKHudFfCjvr67FXjTsk
Message-ID: <CAEDrbUYKJvXVpaBjyde5=Lp9+rAv1oBJbYf9ZewepQgMhegXZg@mail.gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000baf7aa0632a47e35"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000baf7aa0632a47e35
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

> > > > Emscripten's fiber does not support submitting coroutines to other
> > > > threads. So this commit modifies hw/9pfs/coth.h to disable this
behavior
> > > > when compiled with Emscripten.
> > >
> > > The lack of being able to dispatch a coroutine to a worker thread is
one
> > > thing, however it would probably still make sense to use fibers in
9pfs as
> > > replacement of its coroutines mechanism.
> > >
> > > In 9pfs coroutines are used to dispatch blocking fs I/O syscalls from
main
> > > thread to worker thread(s):
> > >
> > > https://wiki.qemu.org/Documentation/9p#Control_Flow
> > >
> > > If you just remove the coroutine code entirely, 9p server might hang
for
> > good,
> > > and with it QEMU's main thread.
> > >
> > > By using fibers instead, it would not hang, as it seems as if I/O
> > syscalls are
> > > emulated in Emscripten, right?
> >
> > Thank you for the feedback. Yes, it would be great if Emscripten's fiber
> > could be used to address this limitation. Since Emscripten's fiber is
> > cooperative, I believe a blocking code_block can still block the 9pfs
server
> > unless an explicit yield occurs within it. I'll continue exploring
better
> > solutions for this. Please let me know if I'm missing anything.
>
> As far as I understand it, the I/O syscalls are emulated, and when being
> called by fibers, blocking syscalls would imply to yield under the hood,
> without explicit yield by application that is.
>
> If that's true, it would only require little code changes for this to
work.

Thank you for the information. Yes, I/O syscalls are emulated by
Emscripten. While I haven't found documentation or implementation details on
whether Fibers implicitly yield on blocking syscalls, I'll continue to
explore this approach.

> > Let my answer my own question: I just checked the wasi sources. The
errno
> > values are hard coded by the wasi API, consistent over systems. So the
current
> > mapping of this patch is wrong. macOS uses a different mapping than the
wasi
> > API.
> >
> >
https://github.com/WebAssembly/wasi-libc/blob/main/libc-bottom-half/headers/public/__errno_values.h
> >
> >
https://github.com/emscripten-core/emscripten/blob/4af36cf80647f9a82be617a0ff32f3e56f220e41/system/include/wasi/api.h#L116
> >
> > So please use a correct mapping as defined in that header file.
> >
> > /Christian
> >
> > > Alternatively 9p2000.u protocol variant could be used for Emscripten.
Not
> > > ideal, as this 9p protocol version is somewhat a legacy protocol from
QEMU
> > > perspective, reduced performance, less reliable, but it transmits
error
> > > strings to client which it can map to correct errno values by itself.
Linux 9p
> > > client uses a hash map for this errno translation of 9p2000.u error
strings.
>
> Stupid me. That's host errno -> Linux errno translation. So your values
are
> obviously correct, sorry!
>
> However still worth comparing the Linux vs. wasi header files on this.
>
> And I would avoid duplicating the macOS translation code. Instead I would
just
> do a one-line change:
>
> #elif defined(CONFIG_DARWIN) || defined(EMSCRIPTEN)
> ...
>
> And probably leave a comment with a link to the wasi API header file
there, so
> in case new errno translations are added for macOS, that people also check
> whether those macros exist in the wasi header file as well.

Thanks again for the suggestion. I'll apply this change in the next version
of the series.

--000000000000baf7aa0632a47e35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Christian,</div><br>&gt; &gt; &gt; &gt=
; Emscripten&#39;s fiber does not support submitting coroutines to other<br=
>&gt; &gt; &gt; &gt; threads. So this commit modifies hw/9pfs/coth.h to dis=
able this behavior<br>&gt; &gt; &gt; &gt; when compiled with Emscripten.<br=
>&gt; &gt; &gt;<br>&gt; &gt; &gt; The lack of being able to dispatch a coro=
utine to a worker thread is one<br>&gt; &gt; &gt; thing, however it would p=
robably still make sense to use fibers in 9pfs as<br>&gt; &gt; &gt; replace=
ment of its coroutines mechanism.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; In 9p=
fs coroutines are used to dispatch blocking fs I/O syscalls from main<br>&g=
t; &gt; &gt; thread to worker thread(s):<br>&gt; &gt; &gt;<br>&gt; &gt; &gt=
; <a href=3D"https://wiki.qemu.org/Documentation/9p#Control_Flow">https://w=
iki.qemu.org/Documentation/9p#Control_Flow</a><br>&gt; &gt; &gt;<br>&gt; &g=
t; &gt; If you just remove the coroutine code entirely, 9p server might han=
g for<br>&gt; &gt; good,<br>&gt; &gt; &gt; and with it QEMU&#39;s main thre=
ad.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; By using fibers instead, it would n=
ot hang, as it seems as if I/O<br>&gt; &gt; syscalls are<br>&gt; &gt; &gt; =
emulated in Emscripten, right?<br>&gt; &gt;<br>&gt; &gt; Thank you for the =
feedback. Yes, it would be great if Emscripten&#39;s fiber<br>&gt; &gt; cou=
ld be used to address this limitation. Since Emscripten&#39;s fiber is<br>&=
gt; &gt; cooperative, I believe a blocking code_block can still block the 9=
pfs server<br>&gt; &gt; unless an explicit yield occurs within it. I&#39;ll=
 continue exploring better<br>&gt; &gt; solutions for this. Please let me k=
now if I&#39;m missing anything.<br>&gt;<br>&gt; As far as I understand it,=
 the I/O syscalls are emulated, and when being<br>&gt; called by fibers, bl=
ocking syscalls would imply to yield under the hood,<br>&gt; without explic=
it yield by application that is.<br>&gt;<br>&gt; If that&#39;s true, it wou=
ld only require little code changes for this to work.<br><br>Thank you for =
the information. Yes, I/O syscalls are emulated by<br>Emscripten. While I h=
aven&#39;t found documentation or implementation details on<br>whether Fibe=
rs implicitly yield on blocking syscalls, I&#39;ll continue to<br>explore t=
his approach.<br><br>&gt; &gt; Let my answer my own question: I just checke=
d the wasi sources. The errno<br>&gt; &gt; values are hard coded by the was=
i API, consistent over systems. So the current<br>&gt; &gt; mapping of this=
 patch is wrong. macOS uses a different mapping than the wasi<br>&gt; &gt; =
API.<br>&gt; &gt; <br>&gt; &gt; <a href=3D"https://github.com/WebAssembly/w=
asi-libc/blob/main/libc-bottom-half/headers/public/__errno_values.h">https:=
//github.com/WebAssembly/wasi-libc/blob/main/libc-bottom-half/headers/publi=
c/__errno_values.h</a><br>&gt; &gt; <br>&gt; &gt; <a href=3D"https://github=
.com/emscripten-core/emscripten/blob/4af36cf80647f9a82be617a0ff32f3e56f220e=
41/system/include/wasi/api.h#L116">https://github.com/emscripten-core/emscr=
ipten/blob/4af36cf80647f9a82be617a0ff32f3e56f220e41/system/include/wasi/api=
.h#L116</a><br>&gt; &gt; <br>&gt; &gt; So please use a correct mapping as d=
efined in that header file.<br>&gt; &gt; <br>&gt; &gt; /Christian<br>&gt; &=
gt; <br>&gt; &gt; &gt; Alternatively 9p2000.u protocol variant could be use=
d for Emscripten. Not<br>&gt; &gt; &gt; ideal, as this 9p protocol version =
is somewhat a legacy protocol from QEMU<br>&gt; &gt; &gt; perspective, redu=
ced performance, less reliable, but it transmits error<br>&gt; &gt; &gt; st=
rings to client which it can map to correct errno values by itself. Linux 9=
p<br>&gt; &gt; &gt; client uses a hash map for this errno translation of 9p=
2000.u error strings.<br>&gt; <br>&gt; Stupid me. That&#39;s host errno -&g=
t; Linux errno translation. So your values are<br>&gt; obviously correct, s=
orry!<br>&gt; <br>&gt; However still worth comparing the Linux vs. wasi hea=
der files on this.<br>&gt; <br>&gt; And I would avoid duplicating the macOS=
 translation code. Instead I would just<br>&gt; do a one-line change:<br>&g=
t; <br>&gt; #elif defined(CONFIG_DARWIN) || defined(EMSCRIPTEN)<br>&gt; ...=
<br>&gt; <br>&gt; And probably leave a comment with a link to the wasi API =
header file there, so<br>&gt; in case new errno translations are added for =
macOS, that people also check<br>&gt; whether those macros exist in the was=
i header file as well.<br><br>Thanks again for the suggestion. I&#39;ll app=
ly this change in the next version<br>of the series.<br><br></div>

--000000000000baf7aa0632a47e35--

