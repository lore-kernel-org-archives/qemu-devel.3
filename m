Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7443ED637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJeJ-0005Cf-TA; Wed, 13 Nov 2024 15:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBJeI-0005Bs-1F
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:07:34 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBJeF-0005Fp-Er
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:07:33 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2a97c2681so5715052a91.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731528450; x=1732133250;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P0p/ygDgvsCLmEFXP4oawAmFjFJhKFFd/SgliTl4ghM=;
 b=iMoQz01GrSNrbOomK9hnl4s+ecBsiEcHg46zx5FCU+Ecf4lndsVKltWR3kPn8vntNK
 q3RoNvIiIX0rGxIM5Zu5wcee6f6djrjrliigmomK31HVpFr/eI7BJcg9+z67HTewaLxT
 kpPnwMU3vmWCmEc/GhTiPsEICErEEUjctKfOe7PfI4nNMP0Vl05aAGRX1l2vEtIwLats
 T4Gu7yEcGGkt9qVQmdsdZphR4Ae6XuO4qyDYgOwgUOIJh/2QexVVodQIOZwYf7mKvBqe
 LBfBAXv1PIpUNCximPfVTOcO3xyZa2uQIzy1emirK2YxciMCmvVLpBOnUVSyY6Jow2ee
 UpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528450; x=1732133250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0p/ygDgvsCLmEFXP4oawAmFjFJhKFFd/SgliTl4ghM=;
 b=hkOcNmIGKwgKw5Q47Zu0JJhLFyuSPuY7bx7TUOfzf0/vEuV69iZDrNTiTJ2SLL76py
 dCZnIccoZ1+NJXauJ3Lt1yheeg9QNT8kiOQZ1Mg9vIE9J/tZ/3TFB9y1Gj07Td9b+GTb
 D+EhcQCJ/CAC4DQ9+N0noH4lwPNOH4CrbSqQ3cO1rTe/LG8ZBHvGk01KO/D6dASd+BAS
 7wxAjTikUuYEXzRPcweYLphezSNh3VCSOUstz1QsvpSrlDVs6aMzCFWMCXx9pwc910m5
 sBHvI5MKyeLxdE6c7S/IyKO1yaUs5FbjuQc31fbYe+0NcJsuXOkqKcAtD6YtPu0yj+cc
 OWJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IOM9inQqqPEUdUCcs1YnEaRFJ9yE24HDFoz4Yhsj27r5H/ls0AsdTsdPL2Bf0l/XoCZMO34fdBLf@nongnu.org
X-Gm-Message-State: AOJu0YxcTM1kGhvIobj5YOMIpREY24/GBTY2/0G1rD7yBMyQmh4+EsyM
 fdhw4My6otnwXq+s9krhMDHyOus+ODeT59q1gjZBA2IflQn1XmqCpWcY4sB+ycmJ/OsUIUCb+ay
 gDoglKBG9EIRwlf0dxil/XkoLHRY5mvCI3Ofv
X-Google-Smtp-Source: AGHT+IHdYDf07BS0qJ2aCuf2Mnjd72Ubd6faiuwOdtAZ3dC7fOraCv9it/NVG5/A/w481Ym/iqtuM6+mHdVHCq3wkno=
X-Received: by 2002:a17:90b:35c9:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e9e4adeffcmr10861507a91.16.1731528449634; Wed, 13 Nov 2024
 12:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
 <CABgObfbCF7q_ATWmWw2yCmYhTQK7tKmgGKR73s4u3W5Kvqj2Cw@mail.gmail.com>
In-Reply-To: <CABgObfbCF7q_ATWmWw2yCmYhTQK7tKmgGKR73s4u3W5Kvqj2Cw@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 13 Nov 2024 21:07:18 +0100
Message-ID: <CAGCz3vu6oCnMu8nirRc7bSJyKeEmJrC0xRHYdK-7T3v-teJ4Ag@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 agraf@csgraf.de, peter.maydell@linaro.org, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, akihiko.odaki@daynix.com, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000028cb630626d0e276"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1035;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000028cb630626d0e276
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 at 19:36, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Nov 13, 2024 at 7:16=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
> > > int main(int argc, char **argv)
> > > {
> > > +    QemuThread main_loop_thread;
> > > +
> > >     qemu_init(argc, argv);
> > > -    return qemu_main();
> > > +    if (qemu_main) {
> > > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > > +                           call_qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > > +        bql_unlock();
> > > +        return qemu_main();
> > > +    } else {
> > > +        qemu_default_main();
> >
> > I think you need 'return qemu_default_main()' here but I'm a bit confus=
ed
> > by all this wrapping of qemu_default_main in call_qemu_default_main. I
> see
> > that may be needed because qemu_thread_create takes a different functio=
n
> > but now that qemu_default main is static and not replaced externally
> could
> > that be changed to the right type and avoid this confusion and simplify
> > this a bit?
>
> Note that qemu_default_main() expects the BQL to be locked, whereas
> qemu_main() and call_qemu_default_main() do not (because they run in a
> separate thread).
>
> But you're right, we could push bql_lock()/bql_unlock() into
> qemu_default_main(), and do
>
>      bql_unlock();
>      if (qemu_main) {
>         qemu_thread_create(&main_loop_thread, "qemu_main",
>                            call_qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
>         return qemu_main();
>     } else {
>         return qemu_default_main();
>     }
>
>
Good point, if it's safe to drop the lock on thread 0 and re-lock it on
another thread before running qemu_main_loop() there, it's also safe to
momentarily drop the lock on thread 0 and re-take it before calling into
qemu_main_loop(). I'll take that as a starting point and see how far I can
simplify things.

Thanks to both of you for the feedback!

Paolo
>
> > Regards,
> > BALATON Zoltan
> >
> > > +    }
> > > }
> > > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > > index 4c2dd335323..30b8920d929 100644
> > > --- a/ui/cocoa.m
> > > +++ b/ui/cocoa.m
> > > @@ -73,6 +73,8 @@
> > >     int height;
> > > } QEMUScreen;
> > >
> > > +@class QemuCocoaPasteboardTypeOwner;
> > > +
> > > static void cocoa_update(DisplayChangeListener *dcl,
> > >                          int x, int y, int w, int h);
> > >
> > > @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener
> *dcl,
> > > static NSInteger cbchangecount =3D -1;
> > > static QemuClipboardInfo *cbinfo;
> > > static QemuEvent cbevent;
> > > +static QemuCocoaPasteboardTypeOwner *cbowner;
> > >
> > > // Utility functions to run specified code block with the BQL held
> > > typedef void (^CodeBlock)(void);
> > > @@ -1321,8 +1324,10 @@ - (void) dealloc
> > > {
> > >     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
> > >
> > > -    if (cocoaView)
> > > -        [cocoaView release];
> > > +    [cocoaView release];
> > > +    [cbowner release];
> > > +    cbowner =3D nil;
> > > +
> > >     [super dealloc];
> > > }
> > >
> > > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender
> provideDataForType:(NSPasteboardType)t
> > >
> > > @end
> > >
> > > -static QemuCocoaPasteboardTypeOwner *cbowner;
> > > -
> > > static void cocoa_clipboard_notify(Notifier *notifier, void *data);
> > > static void cocoa_clipboard_request(QemuClipboardInfo *info,
> > >                                     QemuClipboardType type);
> > > @@ -2002,43 +2005,8 @@ static void
> cocoa_clipboard_request(QemuClipboardInfo *info,
> > >     }
> > > }
> > >
> > > -/*
> > > - * The startup process for the OSX/Cocoa UI is complicated, because
> > > - * OSX insists that the UI runs on the initial main thread, and so w=
e
> > > - * need to start a second thread which runs the qemu_default_main():
> > > - * in main():
> > > - *  in cocoa_display_init():
> > > - *   assign cocoa_main to qemu_main
> > > - *   create application, menus, etc
> > > - *  in cocoa_main():
> > > - *   create qemu-main thread
> > > - *   enter OSX run loop
> > > - */
> > > -
> > > -static void *call_qemu_main(void *opaque)
> > > -{
> > > -    int status;
> > > -
> > > -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
> > > -    bql_lock();
> > > -    status =3D qemu_default_main();
> > > -    bql_unlock();
> > > -    COCOA_DEBUG("Second thread: qemu_default_main() returned,
> exiting\n");
> > > -    [cbowner release];
> > > -    exit(status);
> > > -}
> > > -
> > > static int cocoa_main(void)
> > > {
> > > -    QemuThread thread;
> > > -
> > > -    COCOA_DEBUG("Entered %s()\n", __func__);
> > > -
> > > -    bql_unlock();
> > > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> > > -                       NULL, QEMU_THREAD_DETACHED);
> > > -
> > > -    // Start the main event loop
> > >     COCOA_DEBUG("Main thread: entering OSX run loop\n");
> > >     [NSApp run];
> > >     COCOA_DEBUG("Main thread: left OSX run loop, which should never
> happen\n");
> > > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds=
,
> DisplayOptions *opts)
> > >
> > >     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> > >
> > > -    qemu_main =3D cocoa_main;
> > > -
> > >     // Pull this console process up to being a fully-fledged graphica=
l
> > >     // app with a menubar and Dock icon
> > >     ProcessSerialNumber psn =3D { 0, kCurrentProcess };
> > > @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState
> *ds, DisplayOptions *opts)
> > >     qemu_clipboard_peer_register(&cbpeer);
> > >
> > >     [pool release];
> > > +
> > > +    /*
> > > +     * The Cocoa UI will run the NSApplication runloop on the main
> thread
> > > +     * rather than the default Core Foundation one.
> > > +     */
> > > +    qemu_main =3D cocoa_main;
> > > }
> > >
> > > static QemuDisplay qemu_display_cocoa =3D {
> > > diff --git a/ui/gtk.c b/ui/gtk.c
> > > index bf9d3dd679a..fbf20161f36 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -38,6 +38,7 @@
> > > #include "qemu/cutils.h"
> > > #include "qemu/error-report.h"
> > > #include "qemu/main-loop.h"
> > > +#include "qemu-main.h"
> > >
> > > #include "ui/console.h"
> > > #include "ui/gtk.h"
> > > @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState *ds,
> DisplayOptions *opts)
> > > #ifdef CONFIG_GTK_CLIPBOARD
> > >     gd_clipboard_init(s);
> > > #endif /* CONFIG_GTK_CLIPBOARD */
> > > +
> > > +    /*
> > > +     * GTK+ calls must happen on the main thread at least on some
> platforms,
> > > +     * and on macOS the main runloop is polled via GTK+'s event
> handling.
> > > +     * Don't allow QEMU's event loop to be moved off the main thread=
.
> > > +     */
> > > +    qemu_main =3D NULL;
> > > }
> > >
> > > static void early_gtk_display_init(DisplayOptions *opts)
> > > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > > index bd4f5a9da14..44ab2762262 100644
> > > --- a/ui/sdl2.c
> > > +++ b/ui/sdl2.c
> > > @@ -34,6 +34,7 @@
> > > #include "sysemu/sysemu.h"
> > > #include "ui/win32-kbd-hook.h"
> > > #include "qemu/log.h"
> > > +#include "qemu-main.h"
> > >
> > > static int sdl2_num_outputs;
> > > static struct sdl2_console *sdl2_console;
> > > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds,
> DisplayOptions *o)
> > >     }
> > >
> > >     atexit(sdl_cleanup);
> > > +
> > > +    /* SDL's event polling (in dpy_refresh) must happen on the main
> thread. */
> > > +    qemu_main =3D NULL;
> > > }
> > >
> > > static QemuDisplay qemu_display_sdl2 =3D {
> > >
> >
>
>
>

--00000000000028cb630626d0e276
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, 13 Nov 2024 at 19:36, Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Wed, Nov 13, 2024 at 7:16=E2=80=AF=
PM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blan=
k">balaton@eik.bme.hu</a>&gt; wrote:<br>
&gt; &gt; int main(int argc, char **argv)<br>
&gt; &gt; {<br>
&gt; &gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt; &gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt; &gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_th=
read, &quot;qemu_main&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_qemu_default_main, NULL, QEMU_THREAD=
_DETACHED);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main();<br>
&gt;<br>
&gt; I think you need &#39;return qemu_default_main()&#39; here but I&#39;m=
 a bit confused<br>
&gt; by all this wrapping of qemu_default_main in call_qemu_default_main. I=
 see<br>
&gt; that may be needed because qemu_thread_create takes a different functi=
on<br>
&gt; but now that qemu_default main is static and not replaced externally c=
ould<br>
&gt; that be changed to the right type and avoid this confusion and simplif=
y<br>
&gt; this a bit?<br>
<br>
Note that qemu_default_main() expects the BQL to be locked, whereas<br>
qemu_main() and call_qemu_default_main() do not (because they run in a<br>
separate thread).<br>
<br>
But you&#39;re right, we could push bql_lock()/bql_unlock() into<br>
qemu_default_main(), and do<br>
<br>
=C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_main) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_thread, &quot=
;qemu_main&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0call_qemu_default_main, NULL, QEMU_THREAD_DETACHED)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
=C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_default_main();<br>
=C2=A0 =C2=A0 }<br>
<br></blockquote><div><br></div><div>Good point, if it&#39;s safe to drop t=
he lock on thread 0 and re-lock it on another thread before running qemu_ma=
in_loop() there, it&#39;s also safe to momentarily drop the lock on thread =
0 and re-take it before calling into qemu_main_loop(). I&#39;ll take that a=
s a starting point and see how far I can simplify things.</div><div><br></d=
iv><div>Thanks to both of you for the feedback!</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Paolo<br>
<br>
&gt; Regards,<br>
&gt; BALATON Zoltan<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; }<br>
&gt; &gt; diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
&gt; &gt; index 4c2dd335323..30b8920d929 100644<br>
&gt; &gt; --- a/ui/cocoa.m<br>
&gt; &gt; +++ b/ui/cocoa.m<br>
&gt; &gt; @@ -73,6 +73,8 @@<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int height;<br>
&gt; &gt; } QEMUScreen;<br>
&gt; &gt;<br>
&gt; &gt; +@class QemuCocoaPasteboardTypeOwner;<br>
&gt; &gt; +<br>
&gt; &gt; static void cocoa_update(DisplayChangeListener *dcl,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h);<br>
&gt; &gt;<br>
&gt; &gt; @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListene=
r *dcl,<br>
&gt; &gt; static NSInteger cbchangecount =3D -1;<br>
&gt; &gt; static QemuClipboardInfo *cbinfo;<br>
&gt; &gt; static QemuEvent cbevent;<br>
&gt; &gt; +static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt; &gt;<br>
&gt; &gt; // Utility functions to run specified code block with the BQL hel=
d<br>
&gt; &gt; typedef void (^CodeBlock)(void);<br>
&gt; &gt; @@ -1321,8 +1324,10 @@ - (void) dealloc<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaAppController: deal=
loc\n&quot;);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 if (cocoaView)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView release];<br>
&gt; &gt; +=C2=A0 =C2=A0 [cocoaView release];<br>
&gt; &gt; +=C2=A0 =C2=A0 [cbowner release];<br>
&gt; &gt; +=C2=A0 =C2=A0 cbowner =3D nil;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[super dealloc];<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender p=
rovideDataForType:(NSPasteboardType)t<br>
&gt; &gt;<br>
&gt; &gt; @end<br>
&gt; &gt;<br>
&gt; &gt; -static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt; &gt; -<br>
&gt; &gt; static void cocoa_clipboard_notify(Notifier *notifier, void *data=
);<br>
&gt; &gt; static void cocoa_clipboard_request(QemuClipboardInfo *info,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuClipb=
oardType type);<br>
&gt; &gt; @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuCl=
ipboardInfo *info,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; -/*<br>
&gt; &gt; - * The startup process for the OSX/Cocoa UI is complicated, beca=
use<br>
&gt; &gt; - * OSX insists that the UI runs on the initial main thread, and =
so we<br>
&gt; &gt; - * need to start a second thread which runs the qemu_default_mai=
n():<br>
&gt; &gt; - * in main():<br>
&gt; &gt; - *=C2=A0 in cocoa_display_init():<br>
&gt; &gt; - *=C2=A0 =C2=A0assign cocoa_main to qemu_main<br>
&gt; &gt; - *=C2=A0 =C2=A0create application, menus, etc<br>
&gt; &gt; - *=C2=A0 in cocoa_main():<br>
&gt; &gt; - *=C2=A0 =C2=A0create qemu-main thread<br>
&gt; &gt; - *=C2=A0 =C2=A0enter OSX run loop<br>
&gt; &gt; - */<br>
&gt; &gt; -<br>
&gt; &gt; -static void *call_qemu_main(void *opaque)<br>
&gt; &gt; -{<br>
&gt; &gt; -=C2=A0 =C2=A0 int status;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: calling qemu_defa=
ult_main()\n&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 bql_lock();<br>
&gt; &gt; -=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt; &gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: qemu_default_main=
() returned, exiting\n&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 [cbowner release];<br>
&gt; &gt; -=C2=A0 =C2=A0 exit(status);<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt; static int cocoa_main(void)<br>
&gt; &gt; {<br>
&gt; &gt; -=C2=A0 =C2=A0 QemuThread thread;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Entered %s()\n&quot;, __func__);=
<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_thread_create(&amp;thread, &quot;qemu_main&qu=
ot;, call_qemu_main,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL, QEMU_THREAD_DETACHED);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 // Start the main event loop<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: entering OSX ru=
n loop\n&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[NSApp run];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: left OSX run lo=
op, which should never happen\n&quot;);<br>
&gt; &gt; @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState=
 *ds, DisplayOptions *opts)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;qemu_cocoa: cocoa_display_in=
it\n&quot;);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt; &gt; -<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0// Pull this console process up to being a ful=
ly-fledged graphical<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0// app with a menubar and Dock icon<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0ProcessSerialNumber psn =3D { 0, kCurrentProce=
ss };<br>
&gt; &gt; @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayStat=
e *ds, DisplayOptions *opts)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0qemu_clipboard_peer_register(&amp;cbpeer);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[pool release];<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* The Cocoa UI will run the NSApplication ru=
nloop on the main thread<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* rather than the default Core Foundation on=
e.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; static QemuDisplay qemu_display_cocoa =3D {<br>
&gt; &gt; diff --git a/ui/gtk.c b/ui/gtk.c<br>
&gt; &gt; index bf9d3dd679a..fbf20161f36 100644<br>
&gt; &gt; --- a/ui/gtk.c<br>
&gt; &gt; +++ b/ui/gtk.c<br>
&gt; &gt; @@ -38,6 +38,7 @@<br>
&gt; &gt; #include &quot;qemu/cutils.h&quot;<br>
&gt; &gt; #include &quot;qemu/error-report.h&quot;<br>
&gt; &gt; #include &quot;qemu/main-loop.h&quot;<br>
&gt; &gt; +#include &quot;qemu-main.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; #include &quot;ui/console.h&quot;<br>
&gt; &gt; #include &quot;ui/gtk.h&quot;<br>
&gt; &gt; @@ -2485,6 +2486,13 @@ static void gtk_display_init(DisplayState =
*ds, DisplayOptions *opts)<br>
&gt; &gt; #ifdef CONFIG_GTK_CLIPBOARD<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0gd_clipboard_init(s);<br>
&gt; &gt; #endif /* CONFIG_GTK_CLIPBOARD */<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* GTK+ calls must happen on the main thread =
at least on some platforms,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* and on macOS the main runloop is polled vi=
a GTK+&#39;s event handling.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Don&#39;t allow QEMU&#39;s event loop to b=
e moved off the main thread.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; static void early_gtk_display_init(DisplayOptions *opts)<br>
&gt; &gt; diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
&gt; &gt; index bd4f5a9da14..44ab2762262 100644<br>
&gt; &gt; --- a/ui/sdl2.c<br>
&gt; &gt; +++ b/ui/sdl2.c<br>
&gt; &gt; @@ -34,6 +34,7 @@<br>
&gt; &gt; #include &quot;sysemu/sysemu.h&quot;<br>
&gt; &gt; #include &quot;ui/win32-kbd-hook.h&quot;<br>
&gt; &gt; #include &quot;qemu/log.h&quot;<br>
&gt; &gt; +#include &quot;qemu-main.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; static int sdl2_num_outputs;<br>
&gt; &gt; static struct sdl2_console *sdl2_console;<br>
&gt; &gt; @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *d=
s, DisplayOptions *o)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0atexit(sdl_cleanup);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 /* SDL&#39;s event polling (in dpy_refresh) must h=
appen on the main thread. */<br>
&gt; &gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; static QemuDisplay qemu_display_sdl2 =3D {<br>
&gt; &gt;<br>
&gt;<br>
<br>
<br>
</blockquote></div></div>

--00000000000028cb630626d0e276--

