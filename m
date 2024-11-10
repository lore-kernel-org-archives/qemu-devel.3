Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8BDD5E39B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 07:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA23u-00064D-UB; Sun, 10 Nov 2024 02:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tA23p-00063D-2R
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:08:37 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tA23g-0005sQ-NH
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 02:08:32 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84fd01c9defso1448669241.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731222507; x=1731827307;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nYGULGlBeYzM47BQXKvLIkfDz+kE3q2q+ggr4QlGcEg=;
 b=1nivpqGa+WF60Qi472no6nCvXWlxl8U82IzT/Ki2icT2Cqy1DR1OwtE/lHkM871k0S
 +a3NpGGw9p5iOnRG7F6FLXJyz8jChGnoJ3zoBa9BMA/bARAVrVsCCfNtrKszeiopZtwE
 +5H6G2vQpIEcljFKNHVvuFI3CaU5oE1NrG7jj/WquPffAJNunzlgPBaKKcq0wwDqHfvc
 NaKdtAN60pjEaWv8y/Zt/rka6IbhIUX75b+UPC6CZHusYaHsTmwOQSSlVEKXE95nV/Yi
 86K1CLrKJU6M58sXLnHidu7LY38yVhq4aywB+nFhQOoCH927F1wHXQQzgY8eOY/r0W6U
 Vrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731222507; x=1731827307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYGULGlBeYzM47BQXKvLIkfDz+kE3q2q+ggr4QlGcEg=;
 b=HRqyEhFaqDAYIIUQlG82CZ9jl+V9YigagBZ2TR6A49nQAlgnE4a3A9oGTXIXTyjX+T
 fnzipYdhAI7LBEjjWQqHCLXoqgkYnAt0WMk8uEUHYPipV709TKxv94WYiffG8r71UsOI
 f+FK65gzp9uSEx8qFZVH03HSAxWW9G4daFN1mw5ILVqagm7RZhr9LKtzId9OyI+pvd7r
 WINmwsxXNqC5xAIPzXGAqXCGyeDVVnJMf5SRMgv64ZcHmczem4lO/PTnHl6rr9m6VxBX
 jP9/dYGKL7r1Ftx9hEZW7d9My3ds4w+v1BzQFXpZNlowCqTiqJFxDLN7FmIEKtCIuLB5
 j85g==
X-Gm-Message-State: AOJu0YyWNS5bVQA/JiOt2+7YgyYZiU8m9ZnoBFLpHafQDUOpszGuqClH
 q1odMyj1E3zYFukvJEvQEmN08uD61kSn9W+B/OJHzWO+v8xnqHRs8/v9gXsoJ2JzFLJwKfJEDj9
 MX/fDzgE9gHYx3GkgTHwxhMYr9UQCfvCxLbku
X-Google-Smtp-Source: AGHT+IHMTM3YXPdo94G+TA0WUq6CB7W4y9EZDywjJVy8k2cxIl3axDxoaTDwd+6Y+N4ZpxYWRYm+NtflA5TFKGctLyc=
X-Received: by 2002:a05:6102:26c9:b0:4a3:ef1e:8530 with SMTP id
 ada2fe7eead31-4aae1384ademr7956099137.10.1731222506924; Sat, 09 Nov 2024
 23:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
In-Reply-To: <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 10 Nov 2024 08:08:16 +0100
Message-ID: <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008d88f2062689a6c5"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::935;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x935.google.com
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

--0000000000008d88f2062689a6c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
> > macOS's Cocoa event handling must be done on the initial (main) thread
> > of the process. Furthermore, if library or application code uses
> > libdispatch, the main dispatch queue must be handling events on the mai=
n
> > thread as well.
> >
> > So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> > in different ways: the Cocoa UI replaces the default qemu_main function
> > with one that spins Qemu's internal main event loop off onto a
> > background thread. SDL (which uses Cocoa internally) on the other hand
> > uses a polling approach within Qemu's main event loop. Events are
> > polled during the SDL UI's dpy_refresh callback, which happens to run
> > on the main thread by default.
>
> GTK should also do the same as SDL and requires treatment; I forgot to
> note that in previous reviews.


Although it=E2=80=98s possible to build Qemu with GTK support enabled on ma=
cOS,
that UI doesn=E2=80=99t actually work on macOS at all, and apparently hasn=
=E2=80=99t been
supported since 2018, see:
https://stackoverflow.com/a/51474795

I don=E2=80=99t think there=E2=80=99s any point making adjustments to the G=
TK code by
guessing what might be needed if someone did fix that to work with macOS at
some point.

>

> > As UIs are mutually exclusive, this works OK as long as nothing else
> > needs platform-native event handling. In the next patch, a new device i=
s
> > introduced based on the ParavirtualizedGraphics.framework in macOS.
> > This uses libdispatch internally, and only works when events are being
> > handled on the main runloop. With the current system, it works when
> > using either the Cocoa or the SDL UI. However, it does not when running
> > headless. Moreover, any attempt to install a similar scheme to the
> > Cocoa UI's main thread replacement fails when combined with the SDL
> > UI.
> >
> > This change tidies up main thread management to be more flexible.
> >
> >   * The qemu_main global function pointer is a custom function for the
> >     main thread, and it may now be NULL. When it is, the main thread
> >     runs the main Qemu loop. This represents the traditional setup.
> >   * When non-null, spawning the main Qemu event loop on a separate
> >     thread is now done centrally rather than inside the Cocoa UI code.
> >   * For most platforms, qemu_main is indeed NULL by default, but on
> >     Darwin, it defaults to a function that runs the CFRunLoop.
> >   * The Cocoa UI sets qemu_main to a function which runs the
> >     NSApplication event handling runloop, as is usual for a Cocoa app.
> >   * The SDL UI overrides the qemu_main function to NULL, thus
> >     specifying that Qemu's main loop must run on the main
> >     thread.
> >   * For other UIs, or in the absence of UIs, the platform's default
> >     behaviour is followed.
> >
> > This means that on macOS, the platform's runloop events are always
> > handled, regardless of chosen UI. The new PV graphics device will
> > thus work in all configurations. There is no functional change on other
> > operating systems.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >
> > v5:
> >
> >   * Simplified the way of setting/clearing the main loop by going back
> >     to setting qemu_main directly, but narrowing the scope of what it
> >     needs to do, and it can now be NULL.
> >
> > v6:
> >
> >   * Folded function qemu_run_default_main_on_new_thread's code into
> >     main()
> >   * Removed whitespace changes left over on lines near code removed
> >     between v4 and v5
> >
> >   include/qemu-main.h     |  3 +--
> >   include/qemu/typedefs.h |  1 +
> >   system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
> >   ui/cocoa.m              | 54 ++++++++++------------------------------=
-
> >   ui/sdl2.c               |  4 +++
> >   5 files changed, 64 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/qemu-main.h b/include/qemu-main.h
> > index 940960a7dbc..4bd0d667edc 100644
> > --- a/include/qemu-main.h
> > +++ b/include/qemu-main.h
> > @@ -5,7 +5,6 @@
> >   #ifndef QEMU_MAIN_H
> >   #define QEMU_MAIN_H
> >
> > -int qemu_default_main(void);
> > -extern int (*qemu_main)(void);
> > +extern qemu_main_fn qemu_main;
> >
> >   #endif /* QEMU_MAIN_H */
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 3d84efcac47..b02cfe1f328 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> > @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
> >    * Function types
> >    */
> >   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> > +typedef int (*qemu_main_fn)(void);
> >
> >   #endif /* QEMU_TYPEDEFS_H */
> > diff --git a/system/main.c b/system/main.c
> > index 9b91d21ea8c..d9397a6d5d0 100644
> > --- a/system/main.c
> > +++ b/system/main.c
> > @@ -24,13 +24,14 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qemu-main.h"
> > +#include "qemu/main-loop.h"
> >   #include "sysemu/sysemu.h"
> >
> > -#ifdef CONFIG_SDL
> > -#include <SDL.h>
> > +#ifdef CONFIG_DARWIN
> > +#include <CoreFoundation/CoreFoundation.h>
> >   #endif
> >
> > -int qemu_default_main(void)
> > +static int qemu_default_main(void)
> >   {
> >       int status;
> >
> > @@ -40,10 +41,49 @@ int qemu_default_main(void)
> >       return status;
> >   }
> >
> > -int (*qemu_main)(void) =3D qemu_default_main;
> > +/*
> > + * Various macOS system libraries, including the Cocoa UI and anything
> using
> > + * libdispatch, such as ParavirtualizedGraphics.framework, requires
> that the
> > + * main runloop, on the main (initial) thread be running or at least
> regularly
> > + * polled for events. A special mode is therefore supported, where the
> QEMU
> > + * main loop runs on a separate thread and the main thread handles the
> > + * CF/Cocoa runloop.
> > + */
> > +
> > +static void *call_qemu_default_main(void *opaque)
> > +{
> > +    int status;
> > +
> > +    bql_lock();
> > +    status =3D qemu_default_main();
> > +    bql_unlock();
> > +
> > +    exit(status);
> > +}
> > +
> > +#ifdef CONFIG_DARWIN
> > +static int os_darwin_cfrunloop_main(void)
> > +{
> > +    CFRunLoopRun();
> > +    abort();
> > +}
> > +
> > +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;
> > +#else
> > +qemu_main_fn qemu_main;
> > +#endif
> >
> >   int main(int argc, char **argv)
> >   {
> > +    QemuThread main_loop_thread;
> > +
> >       qemu_init(argc, argv);
> > -    return qemu_main();
> > +    if (qemu_main) {
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           call_qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > +        bql_unlock();
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main();
> > +    }
> >   }
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index 4c2dd335323..30b8920d929 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -73,6 +73,8 @@
> >       int height;
> >   } QEMUScreen;
> >
> > +@class QemuCocoaPasteboardTypeOwner;
> > +
> >   static void cocoa_update(DisplayChangeListener *dcl,
> >                            int x, int y, int w, int h);
> >
> > @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl=
,
> >   static NSInteger cbchangecount =3D -1;
> >   static QemuClipboardInfo *cbinfo;
> >   static QemuEvent cbevent;
> > +static QemuCocoaPasteboardTypeOwner *cbowner;
> >
> >   // Utility functions to run specified code block with the BQL held
> >   typedef void (^CodeBlock)(void);
> > @@ -1321,8 +1324,10 @@ - (void) dealloc
> >   {
> >       COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
> >
> > -    if (cocoaView)
> > -        [cocoaView release];
> > +    [cocoaView release];
> > +    [cbowner release];
> > +    cbowner =3D nil;
> > +
> >       [super dealloc];
> >   }
> >
> > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender
> provideDataForType:(NSPasteboardType)t
> >
> >   @end
> >
> > -static QemuCocoaPasteboardTypeOwner *cbowner;
> > -
> >   static void cocoa_clipboard_notify(Notifier *notifier, void *data);
> >   static void cocoa_clipboard_request(QemuClipboardInfo *info,
> >                                       QemuClipboardType type);
> > @@ -2002,43 +2005,8 @@ static void
> cocoa_clipboard_request(QemuClipboardInfo *info,
> >       }
> >   }
> >
> > -/*
> > - * The startup process for the OSX/Cocoa UI is complicated, because
> > - * OSX insists that the UI runs on the initial main thread, and so we
> > - * need to start a second thread which runs the qemu_default_main():
> > - * in main():
> > - *  in cocoa_display_init():
> > - *   assign cocoa_main to qemu_main
> > - *   create application, menus, etc
> > - *  in cocoa_main():
> > - *   create qemu-main thread
> > - *   enter OSX run loop
> > - */
> > -
> > -static void *call_qemu_main(void *opaque)
> > -{
> > -    int status;
> > -
> > -    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
> > -    bql_lock();
> > -    status =3D qemu_default_main();
> > -    bql_unlock();
> > -    COCOA_DEBUG("Second thread: qemu_default_main() returned,
> exiting\n");
> > -    [cbowner release];
> > -    exit(status);
> > -}
> > -
> >   static int cocoa_main(void)
> >   {
> > -    QemuThread thread;
> > -
> > -    COCOA_DEBUG("Entered %s()\n", __func__);
> > -
> > -    bql_unlock();
> > -    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> > -                       NULL, QEMU_THREAD_DETACHED);
> > -
> > -    // Start the main event loop
> >       COCOA_DEBUG("Main thread: entering OSX run loop\n");
> >       [NSApp run];
> >       COCOA_DEBUG("Main thread: left OSX run loop, which should never
> happen\n");
> > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >
> >       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> >
> > -    qemu_main =3D cocoa_main;
> > -
> >       // Pull this console process up to being a fully-fledged graphica=
l
> >       // app with a menubar and Dock icon
> >       ProcessSerialNumber psn =3D { 0, kCurrentProcess };
> > @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >       qemu_clipboard_peer_register(&cbpeer);
> >
> >       [pool release];
> > +
> > +    /*
> > +     * The Cocoa UI will run the NSApplication runloop on the main
> thread
> > +     * rather than the default Core Foundation one.
> > +     */
> > +    qemu_main =3D cocoa_main;
> >   }
> >
> >   static QemuDisplay qemu_display_cocoa =3D {
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index bd4f5a9da14..44ab2762262 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -34,6 +34,7 @@
> >   #include "sysemu/sysemu.h"
> >   #include "ui/win32-kbd-hook.h"
> >   #include "qemu/log.h"
> > +#include "qemu-main.h"
> >
> >   static int sdl2_num_outputs;
> >   static struct sdl2_console *sdl2_console;
> > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds,
> DisplayOptions *o)
> >       }
> >
> >       atexit(sdl_cleanup);
> > +
> > +    /* SDL's event polling (in dpy_refresh) must happen on the main
> thread. */
> > +    qemu_main =3D NULL;
> >   }
> >
> >   static QemuDisplay qemu_display_sdl2 =3D {
>
>

--0000000000008d88f2062689a6c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun 10. Nov 2024 at 08:01, Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">On 2024/11/08 23:46, Phil Dennis-Jordan wrote:<br>
&gt; macOS&#39;s Cocoa event handling must be done on the initial (main) th=
read<br>
&gt; of the process. Furthermore, if library or application code uses<br>
&gt; libdispatch, the main dispatch queue must be handling events on the ma=
in<br>
&gt; thread as well.<br>
&gt; <br>
&gt; So far, this has affected Qemu in both the Cocoa and SDL UIs, although=
<br>
&gt; in different ways: the Cocoa UI replaces the default qemu_main functio=
n<br>
&gt; with one that spins Qemu&#39;s internal main event loop off onto a<br>
&gt; background thread. SDL (which uses Cocoa internally) on the other hand=
<br>
&gt; uses a polling approach within Qemu&#39;s main event loop. Events are<=
br>
&gt; polled during the SDL UI&#39;s dpy_refresh callback, which happens to =
run<br>
&gt; on the main thread by default.<br>
<br>
GTK should also do the same as SDL and requires treatment; I forgot to <br>
note that in previous reviews.</blockquote><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Although it=E2=80=98s possible to build Qemu with GTK support=
 enabled on macOS, that UI doesn=E2=80=99t actually work on macOS at all, a=
nd apparently hasn=E2=80=99t been supported since 2018, see:</div><div dir=
=3D"auto"><div><a href=3D"https://stackoverflow.com/a/51474795">https://sta=
ckoverflow.com/a/51474795</a></div><br></div><div dir=3D"auto">I don=E2=80=
=99t think there=E2=80=99s any point making adjustments to the GTK code by =
guessing what might be needed if someone did fix that to work with macOS at=
 some point.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;b=
order-left-color:rgb(204,204,204)" dir=3D"auto"></blockquote><div dir=3D"au=
to"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;borde=
r-left-color:rgb(204,204,204)" dir=3D"auto"><br>
&gt; As UIs are mutually exclusive, this works OK as long as nothing else<b=
r>
&gt; needs platform-native event handling. In the next patch, a new device =
is<br>
&gt; introduced based on the ParavirtualizedGraphics.framework in macOS.<br=
>
&gt; This uses libdispatch internally, and only works when events are being=
<br>
&gt; handled on the main runloop. With the current system, it works when<br=
>
&gt; using either the Cocoa or the SDL UI. However, it does not when runnin=
g<br>
&gt; headless. Moreover, any attempt to install a similar scheme to the<br>
&gt; Cocoa UI&#39;s main thread replacement fails when combined with the SD=
L<br>
&gt; UI.<br>
&gt; <br>
&gt; This change tidies up main thread management to be more flexible.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* The qemu_main global function pointer is a custom functi=
on for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0main thread, and it may now be NULL. When it is, th=
e main thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0runs the main Qemu loop. This represents the tradit=
ional setup.<br>
&gt;=C2=A0 =C2=A0* When non-null, spawning the main Qemu event loop on a se=
parate<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread is now done centrally rather than inside the=
 Cocoa UI code.<br>
&gt;=C2=A0 =C2=A0* For most platforms, qemu_main is indeed NULL by default,=
 but on<br>
&gt;=C2=A0 =C2=A0 =C2=A0Darwin, it defaults to a function that runs the CFR=
unLoop.<br>
&gt;=C2=A0 =C2=A0* The Cocoa UI sets qemu_main to a function which runs the=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0NSApplication event handling runloop, as is usual f=
or a Cocoa app.<br>
&gt;=C2=A0 =C2=A0* The SDL UI overrides the qemu_main function to NULL, thu=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0specifying that Qemu&#39;s main loop must run on th=
e main<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread.<br>
&gt;=C2=A0 =C2=A0* For other UIs, or in the absence of UIs, the platform&#3=
9;s default<br>
&gt;=C2=A0 =C2=A0 =C2=A0behaviour is followed.<br>
&gt; <br>
&gt; This means that on macOS, the platform&#39;s runloop events are always=
<br>
&gt; handled, regardless of chosen UI. The new PV graphics device will<br>
&gt; thus work in all configurations. There is no functional change on othe=
r<br>
&gt; operating systems.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; v5:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Simplified the way of setting/clearing the main loop by =
going back<br>
&gt;=C2=A0 =C2=A0 =C2=A0to setting qemu_main directly, but narrowing the sc=
ope of what it<br>
&gt;=C2=A0 =C2=A0 =C2=A0needs to do, and it can now be NULL.<br>
&gt; <br>
&gt; v6:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Folded function qemu_run_default_main_on_new_thread&#39;=
s code into<br>
&gt;=C2=A0 =C2=A0 =C2=A0main()<br>
&gt;=C2=A0 =C2=A0* Removed whitespace changes left over on lines near code =
removed<br>
&gt;=C2=A0 =C2=A0 =C2=A0between v4 and v5<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/qemu-main.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +--<br>
&gt;=C2=A0 =C2=A0include/qemu/typedefs.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50=
 ++++++++++++++++++++++++++++++++++----<br>
&gt;=C2=A0 =C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 54 ++++++++++-------------------------------<br>
&gt;=C2=A0 =C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 4 +++<br>
&gt;=C2=A0 =C2=A05 files changed, 64 insertions(+), 48 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt; index 940960a7dbc..4bd0d667edc 100644<br>
&gt; --- a/include/qemu-main.h<br>
&gt; +++ b/include/qemu-main.h<br>
&gt; @@ -5,7 +5,6 @@<br>
&gt;=C2=A0 =C2=A0#ifndef QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0#define QEMU_MAIN_H<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void);<br>
&gt; -extern int (*qemu_main)(void);<br>
&gt; +extern qemu_main_fn qemu_main;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_MAIN_H */<br>
&gt; diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h<br>
&gt; index 3d84efcac47..b02cfe1f328 100644<br>
&gt; --- a/include/qemu/typedefs.h<br>
&gt; +++ b/include/qemu/typedefs.h<br>
&gt; @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;<br>
&gt;=C2=A0 =C2=A0 * Function types<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0typedef void (*qemu_irq_handler)(void *opaque, int n, int =
level);<br>
&gt; +typedef int (*qemu_main_fn)(void);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* QEMU_TYPEDEFS_H */<br>
&gt; diff --git a/system/main.c b/system/main.c<br>
&gt; index 9b91d21ea8c..d9397a6d5d0 100644<br>
&gt; --- a/system/main.c<br>
&gt; +++ b/system/main.c<br>
&gt; @@ -24,13 +24,14 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu-main.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#ifdef CONFIG_SDL<br>
&gt; -#include &lt;SDL.h&gt;<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int qemu_default_main(void)<br>
&gt; +static int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -40,10 +41,49 @@ int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
&gt; +/*<br>
&gt; + * Various macOS system libraries, including the Cocoa UI and anythin=
g using<br>
&gt; + * libdispatch, such as ParavirtualizedGraphics.framework, requires t=
hat the<br>
&gt; + * main runloop, on the main (initial) thread be running or at least =
regularly<br>
&gt; + * polled for events. A special mode is therefore supported, where th=
e QEMU<br>
&gt; + * main loop runs on a separate thread and the main thread handles th=
e<br>
&gt; + * CF/Cocoa runloop.<br>
&gt; + */<br>
&gt; +<br>
&gt; +static void *call_qemu_default_main(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int status;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +static int os_darwin_cfrunloop_main(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt; +=C2=A0 =C2=A0 abort();<br>
&gt; +}<br>
&gt; +<br>
&gt; +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;<br>
&gt; +#else<br>
&gt; +qemu_main_fn qemu_main;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_thread,=
 &quot;qemu_main&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_qemu_default_main, NULL, QEMU_THREAD_DETAC=
HED);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
&gt; index 4c2dd335323..30b8920d929 100644<br>
&gt; --- a/ui/cocoa.m<br>
&gt; +++ b/ui/cocoa.m<br>
&gt; @@ -73,6 +73,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int height;<br>
&gt;=C2=A0 =C2=A0} QEMUScreen;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +@class QemuCocoaPasteboardTypeOwner;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void cocoa_update(DisplayChangeListener *dcl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dc=
l,<br>
&gt;=C2=A0 =C2=A0static NSInteger cbchangecount =3D -1;<br>
&gt;=C2=A0 =C2=A0static QemuClipboardInfo *cbinfo;<br>
&gt;=C2=A0 =C2=A0static QemuEvent cbevent;<br>
&gt; +static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0// Utility functions to run specified code block with the =
BQL held<br>
&gt;=C2=A0 =C2=A0typedef void (^CodeBlock)(void);<br>
&gt; @@ -1321,8 +1324,10 @@ - (void) dealloc<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaAppController: de=
alloc\n&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (cocoaView)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView release];<br>
&gt; +=C2=A0 =C2=A0 [cocoaView release];<br>
&gt; +=C2=A0 =C2=A0 [cbowner release];<br>
&gt; +=C2=A0 =C2=A0 cbowner =3D nil;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[super dealloc];<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provid=
eDataForType:(NSPasteboardType)t<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0@end<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static QemuCocoaPasteboardTypeOwner *cbowner;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static void cocoa_clipboard_notify(Notifier *notifier, voi=
d *data);<br>
&gt;=C2=A0 =C2=A0static void cocoa_clipboard_request(QemuClipboardInfo *inf=
o,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QemuCl=
ipboardType type);<br>
&gt; @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboa=
rdInfo *info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/*<br>
&gt; - * The startup process for the OSX/Cocoa UI is complicated, because<b=
r>
&gt; - * OSX insists that the UI runs on the initial main thread, and so we=
<br>
&gt; - * need to start a second thread which runs the qemu_default_main():<=
br>
&gt; - * in main():<br>
&gt; - *=C2=A0 in cocoa_display_init():<br>
&gt; - *=C2=A0 =C2=A0assign cocoa_main to qemu_main<br>
&gt; - *=C2=A0 =C2=A0create application, menus, etc<br>
&gt; - *=C2=A0 in cocoa_main():<br>
&gt; - *=C2=A0 =C2=A0create qemu-main thread<br>
&gt; - *=C2=A0 =C2=A0enter OSX run loop<br>
&gt; - */<br>
&gt; -<br>
&gt; -static void *call_qemu_main(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 int status;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: calling qemu_default_m=
ain()\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 bql_lock();<br>
&gt; -=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Second thread: qemu_default_main() re=
turned, exiting\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 [cbowner release];<br>
&gt; -=C2=A0 =C2=A0 exit(status);<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static int cocoa_main(void)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 QemuThread thread;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 COCOA_DEBUG(&quot;Entered %s()\n&quot;, __func__);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 bql_unlock();<br>
&gt; -=C2=A0 =C2=A0 qemu_thread_create(&amp;thread, &quot;qemu_main&quot;, =
call_qemu_main,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, QEMU_THREAD_DETACHED);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 // Start the main event loop<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: entering OSX =
run loop\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NSApp run];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;Main thread: left OSX run =
loop, which should never happen\n&quot;);<br>
&gt; @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds,=
 DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;qemu_cocoa: cocoa_display_=
init\n&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// Pull this console process up to being a f=
ully-fledged graphical<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0// app with a menubar and Dock icon<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ProcessSerialNumber psn =3D { 0, kCurrentPro=
cess };<br>
&gt; @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds=
, DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clipboard_peer_register(&amp;cbpeer);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[pool release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The Cocoa UI will run the NSApplication runloop=
 on the main thread<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* rather than the default Core Foundation one.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 qemu_main =3D cocoa_main;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_cocoa =3D {<br>
&gt; diff --git a/ui/sdl2.c b/ui/sdl2.c<br>
&gt; index bd4f5a9da14..44ab2762262 100644<br>
&gt; --- a/ui/sdl2.c<br>
&gt; +++ b/ui/sdl2.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;ui/win32-kbd-hook.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;qemu-main.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int sdl2_num_outputs;<br>
&gt;=C2=A0 =C2=A0static struct sdl2_console *sdl2_console;<br>
&gt; @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, Di=
splayOptions *o)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atexit(sdl_cleanup);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* SDL&#39;s event polling (in dpy_refresh) must happen=
 on the main thread. */<br>
&gt; +=C2=A0 =C2=A0 qemu_main =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static QemuDisplay qemu_display_sdl2 =3D {<br>
<br>
</blockquote></div></div>

--0000000000008d88f2062689a6c5--

