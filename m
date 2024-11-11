Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE98FD2E9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVAU-0003YS-4N; Mon, 11 Nov 2024 09:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAVAM-0003XQ-Og
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:13:21 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tAVAI-0006az-HN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:13:18 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so3627237a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731334392; x=1731939192;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PABMslX+KLHqaOC/KHgbO/71apQglvqkKGKbkO0zsxQ=;
 b=roeoE4lJl8ut1zNl9RgliJNNdwPuETmzFwNk38eeDh++JI6YlVE+JWNaqFI1/1yp50
 b5TDGYH2IY9a8VuCvh9XN4d9F245dH5iY4alM5+FPrjy2i5m+LARbcuS8SkDfErGKfkp
 gHCiaYKkzHUnFJrW7sIY1bahgG1ytMSm+kzVL0tKxAQbwtvlhtQW+wqKzpJc+GMSSQyJ
 PZF0VlmKvubG9pSRMxKlgY5k0YyRXbZV2QHyJS4n2DGwcTG899F+VqE72dyWvpn+KOWL
 tPc+YIcbnblsRmyIbprDgYqHy0Vu4V5dzniYGXn5rNPyWyPe10rdv/iWy60RtruzA+xL
 6drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731334392; x=1731939192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PABMslX+KLHqaOC/KHgbO/71apQglvqkKGKbkO0zsxQ=;
 b=l2GQ54TZY8a1Xl4VAzdr9UAZqt5SAZGfW/u82ygqXMPoRwoiUwHFOj1epihJVpELib
 kZdFdbdAOJ//m3PPnlsuR/WjNaoIpGtta/A4hMLDnMK4FYBkgb2eZvwT76PDuWfKDEGd
 /v8Rt417yshyWsvys9YBbh3APGTyTTAbhBvMRTlGYFUwSfMpf+bujSWumEJ80/QIeGhH
 hQiTX4tS8Kn0XzC4fuFMcWaPgFucIeHc2ioeISNRvqQrghlMA1lDEz4B6gRso4SNh5XT
 YZ3OfXIa31zdFeVwACt2jbqktqFNGD1RFK/NneJu5ZqtUDJ1e7fIP4LPekP08tMxFZj+
 mxFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAwPDbdMgrt142iumvjZdiqHSbzXWZxhj14QmY73HG6sc+2hUjrh15iIYMWFCZb7e5eUh9dp6mT6cS@nongnu.org
X-Gm-Message-State: AOJu0Yzu6syTyMJElbxEI9z92T63RKTui8N8lKIe9K1ynHpEbJVfTbY+
 sO1mMgZDEA2TkpvfcrexiHvwHR0wAAMsyn5+DSsVqhoF/FNDeNJ/K9z1cVxC2E9xzMUfTwkNlBu
 LkL8Nlf0N/9XoMIldvD+5wPaO8Q56x9Qu3Zbw
X-Google-Smtp-Source: AGHT+IGUWIgHKElXCnJ+tP9p4nEgREZ6J338sCefMauPHUnBLHfU3OabHb38VNTHLyZ08/dr+ZDd/CM/AKa1tFE3M40=
X-Received: by 2002:a17:90a:d604:b0:2e2:e530:508d with SMTP id
 98e67ed59e1d1-2e9b1728859mr17588783a91.19.1731334392291; Mon, 11 Nov 2024
 06:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20241110215519.49150-1-phil@philjordan.eu>
 <20241110215519.49150-2-phil@philjordan.eu>
 <e9077b66-33f0-42a0-9ef2-a6f2b5569997@daynix.com>
In-Reply-To: <e9077b66-33f0-42a0-9ef2-a6f2b5569997@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 11 Nov 2024 15:13:01 +0100
Message-ID: <CAGCz3vuG367ZEfKQK3HcQ6ir92LHRXa-JTEn2nozCPsiLr8_GQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/16] ui & main loop: Redesign of system-specific main
 thread event handling
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1036;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Mon, 11 Nov 2024 at 05:45, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/11/11 6:55, Phil Dennis-Jordan wrote:
> > macOS's Cocoa event handling must be done on the initial (main) thread
> > of the process. Furthermore, if library or application code uses
> > libdispatch, the main dispatch queue must be handling events on the main
> > thread as well.
> >
> > So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> > in different ways: the Cocoa UI replaces the default qemu_main function
> > with one that spins Qemu's internal main event loop off onto a
> > background thread. SDL (which uses Cocoa internally) on the other hand
> > uses a polling approach within Qemu's main event loop. Events are
> > polled during the SDL UI's dpy_refresh callback, which happens to run
> > on the main thread by default.
> >
> > As UIs are mutually exclusive, this works OK as long as nothing else
> > needs platform-native event handling. In the next patch, a new device is
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
> >   * The GTK UI also overrides the qemu_main function to NULL.
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
> > v9:
> >
> >   * Set qemu_main to NULL for GTK UI as well.
> >
> >   include/qemu-main.h     |  3 +--
> >   include/qemu/typedefs.h |  1 +
> >   system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
> >   ui/cocoa.m              | 54 ++++++++++-------------------------------
> >   ui/gtk.c                |  3 +++
> >   ui/sdl2.c               |  4 +++
> >   6 files changed, 67 insertions(+), 48 deletions(-)
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
> > -int (*qemu_main)(void) = qemu_default_main;
> > +/*
> > + * Various macOS system libraries, including the Cocoa UI and anything using
> > + * libdispatch, such as ParavirtualizedGraphics.framework, requires that the
> > + * main runloop, on the main (initial) thread be running or at least regularly
> > + * polled for events. A special mode is therefore supported, where the QEMU
> > + * main loop runs on a separate thread and the main thread handles the
> > + * CF/Cocoa runloop.
> > + */
> > +
> > +static void *call_qemu_default_main(void *opaque)
> > +{
> > +    int status;
> > +
> > +    bql_lock();
> > +    status = qemu_default_main();
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
> > +qemu_main_fn qemu_main = os_darwin_cfrunloop_main;
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
> > +                           call_qemu_default_main, NULL, QEMU_THREAD_DETACHED);
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
> > @@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
> >   static NSInteger cbchangecount = -1;
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
> > +    cbowner = nil;
> > +
> >       [super dealloc];
> >   }
> >
> > @@ -1938,8 +1943,6 @@ - (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSPasteboardType)t
> >
> >   @end
> >
> > -static QemuCocoaPasteboardTypeOwner *cbowner;
> > -
> >   static void cocoa_clipboard_notify(Notifier *notifier, void *data);
> >   static void cocoa_clipboard_request(QemuClipboardInfo *info,
> >                                       QemuClipboardType type);
> > @@ -2002,43 +2005,8 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
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
> > -    status = qemu_default_main();
> > -    bql_unlock();
> > -    COCOA_DEBUG("Second thread: qemu_default_main() returned, exiting\n");
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
> >       COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
> > @@ -2120,8 +2088,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
> >
> >       COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
> >
> > -    qemu_main = cocoa_main;
> > -
> >       // Pull this console process up to being a fully-fledged graphical
> >       // app with a menubar and Dock icon
> >       ProcessSerialNumber psn = { 0, kCurrentProcess };
> > @@ -2185,6 +2151,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
> >       qemu_clipboard_peer_register(&cbpeer);
> >
> >       [pool release];
> > +
> > +    /*
> > +     * The Cocoa UI will run the NSApplication runloop on the main thread
> > +     * rather than the default Core Foundation one.
> > +     */
> > +    qemu_main = cocoa_main;
> >   }
> >
> >   static QemuDisplay qemu_display_cocoa = {
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index bf9d3dd679a..1694146ae37 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -38,6 +38,7 @@
> >   #include "qemu/cutils.h"
> >   #include "qemu/error-report.h"
> >   #include "qemu/main-loop.h"
> > +#include "qemu-main.h"
> >
> >   #include "ui/console.h"
> >   #include "ui/gtk.h"
> > @@ -2485,6 +2486,8 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
> >   #ifdef CONFIG_GTK_CLIPBOARD
> >       gd_clipboard_init(s);
> >   #endif /* CONFIG_GTK_CLIPBOARD */
> > +
> > +    qemu_main = NULL;
>
> Add a comment that corresponds to one in: ui/sdl2.c

I've now got this:

    /*
     * GTK+ calls must happen on the main thread at least on some platforms,
     * and on macOS the main runloop is polled via GTK+'s event handling.
     * Don't allow Qemu's event loop to be moved off the main thread.
     */

It's carefully worded to only say things I know to be true - it seems
like the GTK+ UI integration doesn't actually consistently follow the
rule, which is why that UI currently doesn't work properly on macOS.

> >   }
> >
> >   static void early_gtk_display_init(DisplayOptions *opts)
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
> > @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
> >       }
> >
> >       atexit(sdl_cleanup);
> > +
> > +    /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
> > +    qemu_main = NULL;
> >   }
> >
> >   static QemuDisplay qemu_display_sdl2 = {
>
>

