Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5A5D68B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBbFu-00063Y-3Y; Thu, 14 Nov 2024 09:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBbFr-00062h-S7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:55:31 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tBbFl-0002oa-N0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:55:30 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so488584b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731596120; x=1732200920;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rq5nVn5+6ltQZz9e9ShF7Qubf2RqxJTl/DxE+o7RtiY=;
 b=MGa6XrmM26afkxiu2wV7BDQtCznKWIJaOmMbxW8LjbU3lMM2KhCD3DyAK1nl8IvYoh
 ibhvtwlQQCLe3BjfGMdnnRxHC7s8yX8jVmw8EbFHOgRn7nBd1TcW13SWIT0zOQt0dL+X
 N5Kqc00TSb+v3mNj/FgiyWPs9Gw/A9OEcrcccs3z3Q3sOdSy2cAkpF2QPjrhnoDMZFW7
 ZH/Jc7Eyqju7cpb4T5Xi5LkYAKwsiw7SOKBmJIQbnZkIYsnrLnTACqUK/vkt3lY2MHvE
 diGTkyLXC1EtEuiqIVOk0s8irc7hXVj48FU+bQ/s5veQodZpXtx7a4lEI8eRF4Og8qjh
 bYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731596120; x=1732200920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rq5nVn5+6ltQZz9e9ShF7Qubf2RqxJTl/DxE+o7RtiY=;
 b=VqapRgg6Gq1z2o3V6U9HbQOt52oYinzFLplmugRx3f+F8S/iOAWbC9K/tqWslwsqUU
 HFUCNqGi6dnen8qS9/8uzJ2YFQMkof42Fq45LhGvWsaGCk3hMt4JVcDk9nFnmhz1/kCk
 pZIX5VOckdGYmnt8nPwSD8JwNjkzOfXgh8A4nK9Xy55X2UMpcKm62UySkW6JAcoUtyYD
 FpL6rGCE4ZIoEfrHfhwgKQqS1s5pVgayC7NvQXoPSzZcR4k8oUxYt+r6FqzYODVHA4l5
 Tq1FrOQsHq04QVmlxi/wsM6buU+lnpGtujawo8KDTZZFQcfwbYY7Kta+Kl5qqMmAqzLT
 xpzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgT8StpOSAh4gB0rGAkScNWgNln0tzB5t/WReFQBjDnJ1kBpmZ2WIcUMA8Q+GEnxJnlWyIOtbSCmAL@nongnu.org
X-Gm-Message-State: AOJu0YwQkRwl5qa+cBVoCBzxmwwDHtnB4VZSw0RtaUAN8j5YGMrTYUcR
 43jFzHeNjQkqRP5fNyiE0++dM9JPJDo2nVU1OdpeYtsd0CIePFJo1cAesdI09/bvFfm8egWJ4vv
 KRSuF3jOIxJ0QnA7z7mJx3pfqCrVulVgEwj0X
X-Google-Smtp-Source: AGHT+IFOwT46oKuzbLBYVMHYQiB/3CUAvfHh/1pArdzgKrNTjm1DSRPHARJ8OBFn9evxIlPYNwMZiQF/m2eYs/594l8=
X-Received: by 2002:a17:90b:4d11:b0:2da:88b3:d001 with SMTP id
 98e67ed59e1d1-2ea06388504mr2538757a91.18.1731596120401; Thu, 14 Nov 2024
 06:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
 <CAAibmn2PJ0Q0E3KEGZqu9ogbMt+qiBLRuXa6C74ud=2S4G8DSA@mail.gmail.com>
 <fa7ecd3a-d156-b64b-a16b-8593f24c1731@eik.bme.hu>
In-Reply-To: <fa7ecd3a-d156-b64b-a16b-8593f24c1731@eik.bme.hu>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 14 Nov 2024 15:55:09 +0100
Message-ID: <CAGCz3vugVoXVYBezNf6CaAuvLOu5DLK49Xh-ut3CQ5n4NssLXg@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: BALATON Zoltan <balaton@eik.bme.hu>
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
 berrange@redhat.com, akihiko.odaki@daynix.com, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a6ce870626e0a303"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::42f;
 envelope-from=lists@philjordan.eu; helo=mail-pf1-x42f.google.com
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

--000000000000a6ce870626e0a303
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 14:38, BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Thu, 14 Nov 2024, Phil Dennis-Jordan wrote:
> > On Wed, 13 Nov 2024 at 19:16, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >> On Wed, 13 Nov 2024, Phil Dennis-Jordan wrote:
> >>> macOS's Cocoa event handling must be done on the initial (main) thread
> >>> of the process. Furthermore, if library or application code uses
> >>> libdispatch, the main dispatch queue must be handling events on the
> main
> >>> thread as well.
> >>>
> >>> So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> >>> in different ways: the Cocoa UI replaces the default qemu_main function
> >>> with one that spins Qemu's internal main event loop off onto a
> >>> background thread. SDL (which uses Cocoa internally) on the other hand
> >>> uses a polling approach within Qemu's main event loop. Events are
> >>> polled during the SDL UI's dpy_refresh callback, which happens to run
> >>> on the main thread by default.
> >>>
> >>> As UIs are mutually exclusive, this works OK as long as nothing else
> >>> needs platform-native event handling. In the next patch, a new device
> is
> >>> introduced based on the ParavirtualizedGraphics.framework in macOS.
> >>> This uses libdispatch internally, and only works when events are being
> >>> handled on the main runloop. With the current system, it works when
> >>> using either the Cocoa or the SDL UI. However, it does not when running
> >>> headless. Moreover, any attempt to install a similar scheme to the
> >>> Cocoa UI's main thread replacement fails when combined with the SDL
> >>> UI.
> >>>
> >>> This change tidies up main thread management to be more flexible.
> >>>
> >>> * The qemu_main global function pointer is a custom function for the
> >>>   main thread, and it may now be NULL. When it is, the main thread
> >>>   runs the main Qemu loop. This represents the traditional setup.
> >>> * When non-null, spawning the main Qemu event loop on a separate
> >>>   thread is now done centrally rather than inside the Cocoa UI code.
> >>> * For most platforms, qemu_main is indeed NULL by default, but on
> >>>   Darwin, it defaults to a function that runs the CFRunLoop.
> >>> * The Cocoa UI sets qemu_main to a function which runs the
> >>>   NSApplication event handling runloop, as is usual for a Cocoa app.
> >>> * The SDL UI overrides the qemu_main function to NULL, thus
> >>>   specifying that Qemu's main loop must run on the main
> >>>   thread.
> >>> * The GTK UI also overrides the qemu_main function to NULL.
> >>> * For other UIs, or in the absence of UIs, the platform's default
> >>>   behaviour is followed.
> >>>
> >>> This means that on macOS, the platform's runloop events are always
> >>> handled, regardless of chosen UI. The new PV graphics device will
> >>> thus work in all configurations. There is no functional change on other
> >>> operating systems.
> >>>
> >>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> >>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>> ---
> >>>
> >>> v5:
> >>>
> >>> * Simplified the way of setting/clearing the main loop by going back
> >>>   to setting qemu_main directly, but narrowing the scope of what it
> >>>   needs to do, and it can now be NULL.
> >>>
> >>> v6:
> >>>
> >>> * Folded function qemu_run_default_main_on_new_thread's code into
> >>>   main()
> >>> * Removed whitespace changes left over on lines near code removed
> >>>   between v4 and v5
> >>>
> >>> v9:
> >>>
> >>> * Set qemu_main to NULL for GTK UI as well.
> >>>
> >>> v10:
> >>>
> >>> * Added comments clarifying the functionality and purpose of qemu_main.
> >>>
> >>> include/qemu-main.h     | 21 ++++++++++++++--
> >>> include/qemu/typedefs.h |  1 +
> >>> system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
> >>> ui/cocoa.m              | 54 ++++++++++-------------------------------
> >>> ui/gtk.c                |  8 ++++++
> >>> ui/sdl2.c               |  4 +++
> >>> 6 files changed, 90 insertions(+), 48 deletions(-)
> >>>
> >>> diff --git a/include/qemu-main.h b/include/qemu-main.h
> >>> index 940960a7dbc..fc70681c8b5 100644
> >>> --- a/include/qemu-main.h
> >>> +++ b/include/qemu-main.h
> >>> @@ -5,7 +5,24 @@
> >>> #ifndef QEMU_MAIN_H
> >>> #define QEMU_MAIN_H
> >>>
> >>> -int qemu_default_main(void);
> >>> -extern int (*qemu_main)(void);
> >>> +/*
> >>> + * The function to run on the main (initial) thread of the process.
> >>> + * NULL means QEMU's main event loop.
> >>> + * When non-NULL, QEMU's main event loop will run on a purposely
> created
> >>> + * thread, after which the provided function pointer will be invoked
> on
> >>> + * the initial thread.
> >>> + * This is useful on platforms which treat the main thread as special
> >>> + * (macOS/Darwin) and/or require all UI API calls to occur from a
> >>> + * specific thread.
> >>> + * Implementing this via a global function pointer variable is a bit
> >>> + * ugly, but it's probably worth investigating the existing UI thread
> >> rule
> >>> + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> >>> + * issues might precipitate requirements similar but not identical to
> >> those
> >>> + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge,
> >> which
> >>> + * can then be used as a basis for an overhaul. (In fact, it may turn
> >>> + * out to be simplest to split the UI/native platform event thread
> from
> >> the
> >>> + * QEMU main event loop on all platforms, with any UI or even none at
> >> all.)
> >>> + */
> >>> +extern qemu_main_fn qemu_main;
> >>
> >> qemu_main_fn is defined in typdefefs.h but not included here. Also
> coding
> >> style says typedefs should be CamelCase but maybe it's just not worth to
> >> define a type for this and you can just leave the existing line here
> only
> >> removing the qemu_default_main declaration and adding the comment.
> >>
> >>> #endif /* QEMU_MAIN_H */
> >>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> >>> index 3d84efcac47..b02cfe1f328 100644
> >>> --- a/include/qemu/typedefs.h
> >>> +++ b/include/qemu/typedefs.h
> >>> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
> >>>  * Function types
> >>>  */
> >>> typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> >>> +typedef int (*qemu_main_fn)(void);
> >>
> >> Then drop this change...
> >>
> >>> #endif /* QEMU_TYPEDEFS_H */
> >>> diff --git a/system/main.c b/system/main.c
> >>> index 9b91d21ea8c..d9397a6d5d0 100644
> >>> --- a/system/main.c
> >>> +++ b/system/main.c
> >>> @@ -24,13 +24,14 @@
> >>>
> >>> #include "qemu/osdep.h"
> >>> #include "qemu-main.h"
> >>> +#include "qemu/main-loop.h"
> >>> #include "sysemu/sysemu.h"
> >>>
> >>> -#ifdef CONFIG_SDL
> >>> -#include <SDL.h>
> >>> +#ifdef CONFIG_DARWIN
> >>> +#include <CoreFoundation/CoreFoundation.h>
> >>> #endif
> >>>
> >>> -int qemu_default_main(void)
> >>> +static int qemu_default_main(void)
> >>> {
> >>>     int status;
> >>>
> >>> @@ -40,10 +41,49 @@ int qemu_default_main(void)
> >>>     return status;
> >>> }
> >>>
> >>> -int (*qemu_main)(void) = qemu_default_main;
> >>
> >> ...and leave this line here without init to define the global variable
> and
> >> only put assigning the init value in the #ifdef if you don't want to
> >> repeat the function pointer definition twice (but that wouldn't be a
> >> problem either in my opinion to do it in the #ifdef this way).
> >>
> >>> +/*
> >>> + * Various macOS system libraries, including the Cocoa UI and anything
> >> using
> >>> + * libdispatch, such as ParavirtualizedGraphics.framework, requires
> >> that the
> >>> + * main runloop, on the main (initial) thread be running or at least
> >> regularly
> >>> + * polled for events. A special mode is therefore supported, where the
> >> QEMU
> >>> + * main loop runs on a separate thread and the main thread handles the
> >>> + * CF/Cocoa runloop.
> >>> + */
> >>> +
> >>> +static void *call_qemu_default_main(void *opaque)
> >>> +{
> >>> +    int status;
> >>> +
> >>> +    bql_lock();
> >>> +    status = qemu_default_main();
> >>> +    bql_unlock();
> >>> +
> >>> +    exit(status);
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_DARWIN
> >>> +static int os_darwin_cfrunloop_main(void)
> >>> +{
> >>> +    CFRunLoopRun();
> >>> +    abort();
> >>
> >> Is it better to use g_assert_not_reached() here?
> >>
> >>> +}
> >>> +
> >>> +qemu_main_fn qemu_main = os_darwin_cfrunloop_main;
> >>> +#else
> >>> +qemu_main_fn qemu_main;
> >>> +#endif
> >>>
> >>> int main(int argc, char **argv)
> >>> {
> >>> +    QemuThread main_loop_thread;
> >>> +
> >>>     qemu_init(argc, argv);
> >>> -    return qemu_main();
> >>> +    if (qemu_main) {
> >>> +        qemu_thread_create(&main_loop_thread, "qemu_main",
> >>> +                           call_qemu_default_main, NULL,
> >> QEMU_THREAD_DETACHED);
> >>> +        bql_unlock();
> >>> +        return qemu_main();
> >>> +    } else {
> >>> +        qemu_default_main();
> >>
> >> I think you need 'return qemu_default_main()' here but I'm a bit
> confused
> >> by all this wrapping of qemu_default_main in call_qemu_default_main. I
> see
> >> that may be needed because qemu_thread_create takes a different function
> >> but now that qemu_default main is static and not replaced externally
> could
> >> that be changed to the right type and avoid this confusion and simplify
> >> this a bit?
> >>
> >> Regards,
> >> BALATON Zoltan
> >>
> >>
> > Alright, I've gone ahead and worked through that, and it does indeed make
> > things simpler. This is what I have for include/qemu-main.h and
> > system/main.c now:
>
> I think it looks better (can't tell if it will work so leave review to
> others who know this better). Maybe just a couple of more nits below.
>
> > diff --git a/include/qemu-main.h b/include/qemu-main.h
> > index 940960a7dbc..e1041fe99b4 100644
> > --- a/include/qemu-main.h
> > +++ b/include/qemu-main.h
> > @@ -5,7 +5,29 @@
> > #ifndef QEMU_MAIN_H
> > #define QEMU_MAIN_H
> >
> > -int qemu_default_main(void);
> > +/*
> > + * The function to run on the main (initial) thread of the process.
> > + * NULL means QEMU's main event loop.
> > + * When non-NULL, QEMU's main event loop will run on a purposely created
> > + * thread, after which the provided function pointer will be invoked on
> > + * the initial thread.
> > + * This is useful on platforms which treat the main thread as special
> > + * (macOS/Darwin) and/or require all UI API calls to occur from a
> > + * specific thread.
> > + * In practice, this means that on macOS, it is initialised to a
> function
> > + * that runs the Core Foundation runloop. The Cocoa UI "upgrades" this
> > + * to the NSApplication-specific event processing variant. Other
> platforms
> > + * currently leave it at NULL; the SDL and GTK UIs reset it to NULL even
> > + * on macOS as they directly poll the runloop.
>
> I'm not sure this last paragraph below belongs here or maybe better put it
> somewhere else (but if nobody else objects it can be left here for
> reminder and later clean up). I know I suggested to add a comment to note
> this but this comment is a bit long and with a lot of uncertainity so
> maybe it's enough to put this paragraph in the commit message, but it
> could be it will be burried there and nobody will see it later so a
> comment is more prominent place. I'm OK with it either way.
>

You asked for a comment to be added. ;-)

I guess I went with a brain dump of:
 1. What this mechanism achieves.
 2. How it's currently used.
 3. What problems it doesn't solve yet.
 4. Possible approaches for a more general mechanism in future.

We could arguably remove (2) because every single use of the qemu_main
variable actually now has a comment directly there or very nearby, so a
simple code search by future code explorers should find those.


> > + * Implementing this via a global function pointer variable is a bit
> > + * ugly, but it's probably worth investigating the existing UI thread
> rule
> > + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> > + * issues might precipitate requirements similar but not identical to
> those
> > + * of the Cocoa UI; hopefully we'll see some kind of pattern emerge,
> which
> > + * can then be used as a basis for an overhaul. (In fact, it may turn
> > + * out to be simplest to split the UI/native platform event thread from
> the
> > + * QEMU main event loop on all platforms, with any UI or even none at
> all.)
> > + */
> > extern int (*qemu_main)(void);
> >
> > #endif /* QEMU_MAIN_H */
> > diff --git a/system/main.c b/system/main.c
> > index 9b91d21ea8c..2d9d144ed46 100644
> > --- a/system/main.c
> > +++ b/system/main.c
> > @@ -24,26 +24,48 @@
> >
> > #include "qemu/osdep.h"
> > #include "qemu-main.h"
> > +#include "qemu/main-loop.h"
> > #include "sysemu/sysemu.h"
> >
> > -#ifdef CONFIG_SDL
> > -#include <SDL.h>
> > +#ifdef CONFIG_DARWIN
> > +#include <CoreFoundation/CoreFoundation.h>
> > #endif
> >
> > -int qemu_default_main(void)
> > +static void *qemu_default_main(void *opaque)
> > {
> >     int status;
> >
> > +    bql_lock();
> >     status = qemu_main_loop();
> >     qemu_cleanup(status);
> > +    bql_unlock();
> >
> > -    return status;
> > +    exit(status);
> > }
> >
> > -int (*qemu_main)(void) = qemu_default_main;
>
> You could leave the definition without value here (what's now in the
> #else) and then only assign it in the #if so this line would become
>
> -int (*qemu_main)(void) = qemu_default_main;
> +int (*qemu_main)(void);
>
> > +#ifdef CONFIG_DARWIN
> > +static int os_darwin_cfrunloop_main(void)
> > +{
> > +    CFRunLoopRun();
> > +    g_assert_not_reached();
> > +}
> > +
> > +int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>
> and this would be
>
> qemu_main = os_darwin_cfrunloop_main;
>
> and no need for #else. Also the name of this darwin main is a bit long,
> maybe qemu_darwin_main or qemu_default_main_darwin could be better?
>

I guess I wanted to clarify that it's using the CFRunloop variant of macOS
event handling, in contrast to the Cocoa UI's, which uses [NSApp run];
which additionally performs all the Cocoa application bring-up before it
starts handling events.


> > +#else
> > +int (*qemu_main)(void);
> > +#endif
> >
> > int main(int argc, char **argv)
> > {
> > +    QemuThread main_loop_thread;
>
> This could be moved within the if (qemu_main) below as it's not needed
> outside.
>
> > +
> >     qemu_init(argc, argv);
> > -    return qemu_main();
> > +    bql_unlock();
>
> What locks the bql at this point? I could not find the part in qemu_init
> that makes it necessary to unlock it here. If nothing else is called
> before this, is it needed to take the lock and then unlock it here or can
> it be assumed to be unlocked yet?
>

It looks like that happens in qemu_init_subsystems(), right after the BQL
is created inside qemu_init_cpu_loop():

https://gitlab.com/qemu-project/qemu/-/blob/master/system/runstate.c?ref_type=heads#L866



> Regards,
> BALATON Zoltan
>
> > +    if (qemu_main) {
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main(NULL);
> > +    }
> > }
> >
>
>

--000000000000a6ce870626e0a303
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 14 Nov 2024 at 14:38, BALATON=
 Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu,=
 14 Nov 2024, Phil Dennis-Jordan wrote:<br>
&gt; On Wed, 13 Nov 2024 at 19:16, BALATON Zoltan &lt;<a href=3D"mailto:bal=
aton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wrote:<br>
&gt;&gt; On Wed, 13 Nov 2024, Phil Dennis-Jordan wrote:<br>
&gt;&gt;&gt; macOS&#39;s Cocoa event handling must be done on the initial (=
main) thread<br>
&gt;&gt;&gt; of the process. Furthermore, if library or application code us=
es<br>
&gt;&gt;&gt; libdispatch, the main dispatch queue must be handling events o=
n the main<br>
&gt;&gt;&gt; thread as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So far, this has affected Qemu in both the Cocoa and SDL UIs, =
although<br>
&gt;&gt;&gt; in different ways: the Cocoa UI replaces the default qemu_main=
 function<br>
&gt;&gt;&gt; with one that spins Qemu&#39;s internal main event loop off on=
to a<br>
&gt;&gt;&gt; background thread. SDL (which uses Cocoa internally) on the ot=
her hand<br>
&gt;&gt;&gt; uses a polling approach within Qemu&#39;s main event loop. Eve=
nts are<br>
&gt;&gt;&gt; polled during the SDL UI&#39;s dpy_refresh callback, which hap=
pens to run<br>
&gt;&gt;&gt; on the main thread by default.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; As UIs are mutually exclusive, this works OK as long as nothin=
g else<br>
&gt;&gt;&gt; needs platform-native event handling. In the next patch, a new=
 device is<br>
&gt;&gt;&gt; introduced based on the ParavirtualizedGraphics.framework in m=
acOS.<br>
&gt;&gt;&gt; This uses libdispatch internally, and only works when events a=
re being<br>
&gt;&gt;&gt; handled on the main runloop. With the current system, it works=
 when<br>
&gt;&gt;&gt; using either the Cocoa or the SDL UI. However, it does not whe=
n running<br>
&gt;&gt;&gt; headless. Moreover, any attempt to install a similar scheme to=
 the<br>
&gt;&gt;&gt; Cocoa UI&#39;s main thread replacement fails when combined wit=
h the SDL<br>
&gt;&gt;&gt; UI.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This change tidies up main thread management to be more flexib=
le.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; * The qemu_main global function pointer is a custom function f=
or the<br>
&gt;&gt;&gt;=C2=A0 =C2=A0main thread, and it may now be NULL. When it is, t=
he main thread<br>
&gt;&gt;&gt;=C2=A0 =C2=A0runs the main Qemu loop. This represents the tradi=
tional setup.<br>
&gt;&gt;&gt; * When non-null, spawning the main Qemu event loop on a separa=
te<br>
&gt;&gt;&gt;=C2=A0 =C2=A0thread is now done centrally rather than inside th=
e Cocoa UI code.<br>
&gt;&gt;&gt; * For most platforms, qemu_main is indeed NULL by default, but=
 on<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Darwin, it defaults to a function that runs the CF=
RunLoop.<br>
&gt;&gt;&gt; * The Cocoa UI sets qemu_main to a function which runs the<br>
&gt;&gt;&gt;=C2=A0 =C2=A0NSApplication event handling runloop, as is usual =
for a Cocoa app.<br>
&gt;&gt;&gt; * The SDL UI overrides the qemu_main function to NULL, thus<br=
>
&gt;&gt;&gt;=C2=A0 =C2=A0specifying that Qemu&#39;s main loop must run on t=
he main<br>
&gt;&gt;&gt;=C2=A0 =C2=A0thread.<br>
&gt;&gt;&gt; * The GTK UI also overrides the qemu_main function to NULL.<br=
>
&gt;&gt;&gt; * For other UIs, or in the absence of UIs, the platform&#39;s =
default<br>
&gt;&gt;&gt;=C2=A0 =C2=A0behaviour is followed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This means that on macOS, the platform&#39;s runloop events ar=
e always<br>
&gt;&gt;&gt; handled, regardless of chosen UI. The new PV graphics device w=
ill<br>
&gt;&gt;&gt; thus work in all configurations. There is no functional change=
 on other<br>
&gt;&gt;&gt; operating systems.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@p=
hiljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;&gt;&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki=
@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v5:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; * Simplified the way of setting/clearing the main loop by goin=
g back<br>
&gt;&gt;&gt;=C2=A0 =C2=A0to setting qemu_main directly, but narrowing the s=
cope of what it<br>
&gt;&gt;&gt;=C2=A0 =C2=A0needs to do, and it can now be NULL.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v6:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; * Folded function qemu_run_default_main_on_new_thread&#39;s co=
de into<br>
&gt;&gt;&gt;=C2=A0 =C2=A0main()<br>
&gt;&gt;&gt; * Removed whitespace changes left over on lines near code remo=
ved<br>
&gt;&gt;&gt;=C2=A0 =C2=A0between v4 and v5<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v9:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; * Set qemu_main to NULL for GTK UI as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v10:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; * Added comments clarifying the functionality and purpose of q=
emu_main.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; include/qemu-main.h=C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++++--<b=
r>
&gt;&gt;&gt; include/qemu/typedefs.h |=C2=A0 1 +<br>
&gt;&gt;&gt; system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 +++=
+++++++++++++++++++++++++++++++----<br>
&gt;&gt;&gt; ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5=
4 ++++++++++-------------------------------<br>
&gt;&gt;&gt; ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 8 ++++++<br>
&gt;&gt;&gt; ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 4 +++<br>
&gt;&gt;&gt; 6 files changed, 90 insertions(+), 48 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt;&gt;&gt; index 940960a7dbc..fc70681c8b5 100644<br>
&gt;&gt;&gt; --- a/include/qemu-main.h<br>
&gt;&gt;&gt; +++ b/include/qemu-main.h<br>
&gt;&gt;&gt; @@ -5,7 +5,24 @@<br>
&gt;&gt;&gt; #ifndef QEMU_MAIN_H<br>
&gt;&gt;&gt; #define QEMU_MAIN_H<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int qemu_default_main(void);<br>
&gt;&gt;&gt; -extern int (*qemu_main)(void);<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * The function to run on the main (initial) thread of the pr=
ocess.<br>
&gt;&gt;&gt; + * NULL means QEMU&#39;s main event loop.<br>
&gt;&gt;&gt; + * When non-NULL, QEMU&#39;s main event loop will run on a pu=
rposely created<br>
&gt;&gt;&gt; + * thread, after which the provided function pointer will be =
invoked on<br>
&gt;&gt;&gt; + * the initial thread.<br>
&gt;&gt;&gt; + * This is useful on platforms which treat the main thread as=
 special<br>
&gt;&gt;&gt; + * (macOS/Darwin) and/or require all UI API calls to occur fr=
om a<br>
&gt;&gt;&gt; + * specific thread.<br>
&gt;&gt;&gt; + * Implementing this via a global function pointer variable i=
s a bit<br>
&gt;&gt;&gt; + * ugly, but it&#39;s probably worth investigating the existi=
ng UI thread<br>
&gt;&gt; rule<br>
&gt;&gt;&gt; + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fix=
ing those<br>
&gt;&gt;&gt; + * issues might precipitate requirements similar but not iden=
tical to<br>
&gt;&gt; those<br>
&gt;&gt;&gt; + * of the Cocoa UI; hopefully we&#39;ll see some kind of patt=
ern emerge,<br>
&gt;&gt; which<br>
&gt;&gt;&gt; + * can then be used as a basis for an overhaul. (In fact, it =
may turn<br>
&gt;&gt;&gt; + * out to be simplest to split the UI/native platform event t=
hread from<br>
&gt;&gt; the<br>
&gt;&gt;&gt; + * QEMU main event loop on all platforms, with any UI or even=
 none at<br>
&gt;&gt; all.)<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +extern qemu_main_fn qemu_main;<br>
&gt;&gt;<br>
&gt;&gt; qemu_main_fn is defined in typdefefs.h but not included here. Also=
 coding<br>
&gt;&gt; style says typedefs should be CamelCase but maybe it&#39;s just no=
t worth to<br>
&gt;&gt; define a type for this and you can just leave the existing line he=
re only<br>
&gt;&gt; removing the qemu_default_main declaration and adding the comment.=
<br>
&gt;&gt;<br>
&gt;&gt;&gt; #endif /* QEMU_MAIN_H */<br>
&gt;&gt;&gt; diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h=
<br>
&gt;&gt;&gt; index 3d84efcac47..b02cfe1f328 100644<br>
&gt;&gt;&gt; --- a/include/qemu/typedefs.h<br>
&gt;&gt;&gt; +++ b/include/qemu/typedefs.h<br>
&gt;&gt;&gt; @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;<br>
&gt;&gt;&gt;=C2=A0 * Function types<br>
&gt;&gt;&gt;=C2=A0 */<br>
&gt;&gt;&gt; typedef void (*qemu_irq_handler)(void *opaque, int n, int leve=
l);<br>
&gt;&gt;&gt; +typedef int (*qemu_main_fn)(void);<br>
&gt;&gt;<br>
&gt;&gt; Then drop this change...<br>
&gt;&gt;<br>
&gt;&gt;&gt; #endif /* QEMU_TYPEDEFS_H */<br>
&gt;&gt;&gt; diff --git a/system/main.c b/system/main.c<br>
&gt;&gt;&gt; index 9b91d21ea8c..d9397a6d5d0 100644<br>
&gt;&gt;&gt; --- a/system/main.c<br>
&gt;&gt;&gt; +++ b/system/main.c<br>
&gt;&gt;&gt; @@ -24,13 +24,14 @@<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; #include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt; #include &quot;qemu-main.h&quot;<br>
&gt;&gt;&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;&gt;&gt; #include &quot;sysemu/sysemu.h&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -#ifdef CONFIG_SDL<br>
&gt;&gt;&gt; -#include &lt;SDL.h&gt;<br>
&gt;&gt;&gt; +#ifdef CONFIG_DARWIN<br>
&gt;&gt;&gt; +#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>
&gt;&gt;&gt; #endif<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int qemu_default_main(void)<br>
&gt;&gt;&gt; +static int qemu_default_main(void)<br>
&gt;&gt;&gt; {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -40,10 +41,49 @@ int qemu_default_main(void)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0return status;<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
&gt;&gt;<br>
&gt;&gt; ...and leave this line here without init to define the global vari=
able and<br>
&gt;&gt; only put assigning the init value in the #ifdef if you don&#39;t w=
ant to<br>
&gt;&gt; repeat the function pointer definition twice (but that wouldn&#39;=
t be a<br>
&gt;&gt; problem either in my opinion to do it in the #ifdef this way).<br>
&gt;&gt;<br>
&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt; + * Various macOS system libraries, including the Cocoa UI and=
 anything<br>
&gt;&gt; using<br>
&gt;&gt;&gt; + * libdispatch, such as ParavirtualizedGraphics.framework, re=
quires<br>
&gt;&gt; that the<br>
&gt;&gt;&gt; + * main runloop, on the main (initial) thread be running or a=
t least<br>
&gt;&gt; regularly<br>
&gt;&gt;&gt; + * polled for events. A special mode is therefore supported, =
where the<br>
&gt;&gt; QEMU<br>
&gt;&gt;&gt; + * main loop runs on a separate thread and the main thread ha=
ndles the<br>
&gt;&gt;&gt; + * CF/Cocoa runloop.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +static void *call_qemu_default_main(void *opaque)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 int status;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 status =3D qemu_default_main();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +#ifdef CONFIG_DARWIN<br>
&gt;&gt;&gt; +static int os_darwin_cfrunloop_main(void)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 abort();<br>
&gt;&gt;<br>
&gt;&gt; Is it better to use g_assert_not_reached() here?<br>
&gt;&gt;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;<br>
&gt;&gt;&gt; +#else<br>
&gt;&gt;&gt; +qemu_main_fn qemu_main;<br>
&gt;&gt;&gt; +#endif<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; int main(int argc, char **argv)<br>
&gt;&gt;&gt; {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop=
_thread, &quot;qemu_main&quot;,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_qemu_default_main, NULL,<br>
&gt;&gt; QEMU_THREAD_DETACHED);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main();<br>
&gt;&gt;<br>
&gt;&gt; I think you need &#39;return qemu_default_main()&#39; here but I&#=
39;m a bit confused<br>
&gt;&gt; by all this wrapping of qemu_default_main in call_qemu_default_mai=
n. I see<br>
&gt;&gt; that may be needed because qemu_thread_create takes a different fu=
nction<br>
&gt;&gt; but now that qemu_default main is static and not replaced external=
ly could<br>
&gt;&gt; that be changed to the right type and avoid this confusion and sim=
plify<br>
&gt;&gt; this a bit?<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; BALATON Zoltan<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Alright, I&#39;ve gone ahead and worked through that, and it does inde=
ed make<br>
&gt; things simpler. This is what I have for include/qemu-main.h and<br>
&gt; system/main.c now:<br>
<br>
I think it looks better (can&#39;t tell if it will work so leave review to =
<br>
others who know this better). Maybe just a couple of more nits below.<br>
<br>
&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt; index 940960a7dbc..e1041fe99b4 100644<br>
&gt; --- a/include/qemu-main.h<br>
&gt; +++ b/include/qemu-main.h<br>
&gt; @@ -5,7 +5,29 @@<br>
&gt; #ifndef QEMU_MAIN_H<br>
&gt; #define QEMU_MAIN_H<br>
&gt;<br>
&gt; -int qemu_default_main(void);<br>
&gt; +/*<br>
&gt; + * The function to run on the main (initial) thread of the process.<b=
r>
&gt; + * NULL means QEMU&#39;s main event loop.<br>
&gt; + * When non-NULL, QEMU&#39;s main event loop will run on a purposely =
created<br>
&gt; + * thread, after which the provided function pointer will be invoked =
on<br>
&gt; + * the initial thread.<br>
&gt; + * This is useful on platforms which treat the main thread as special=
<br>
&gt; + * (macOS/Darwin) and/or require all UI API calls to occur from a<br>
&gt; + * specific thread.<br>
&gt; + * In practice, this means that on macOS, it is initialised to a func=
tion<br>
&gt; + * that runs the Core Foundation runloop. The Cocoa UI &quot;upgrades=
&quot; this<br>
&gt; + * to the NSApplication-specific event processing variant. Other plat=
forms<br>
&gt; + * currently leave it at NULL; the SDL and GTK UIs reset it to NULL e=
ven<br>
&gt; + * on macOS as they directly poll the runloop.<br>
<br>
I&#39;m not sure this last paragraph below belongs here or maybe better put=
 it <br>
somewhere else (but if nobody else objects it can be left here for <br>
reminder and later clean up). I know I suggested to add a comment to note <=
br>
this but this comment is a bit long and with a lot of uncertainity so <br>
maybe it&#39;s enough to put this paragraph in the commit message, but it <=
br>
could be it will be burried there and nobody will see it later so a <br>
comment is more prominent place. I&#39;m OK with it either way.<br></blockq=
uote><div><br></div><div>You asked for a comment to be added. ;-)</div><div=
><br></div><div>I guess I went with a brain dump of:</div><div>=C2=A01. Wha=
t this mechanism achieves.</div><div>=C2=A02. How it&#39;s currently used.<=
/div><div>=C2=A03. What problems it doesn&#39;t solve yet.</div><div>=C2=A0=
4. Possible approaches for a more general mechanism in future.</div><div><b=
r></div><div>We could arguably remove (2) because every single use of the q=
emu_main variable actually now has a comment directly there or very nearby,=
 so a simple code search by future code explorers should find those.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; + * Implementing this via a global function pointer variable is a bit<=
br>
&gt; + * ugly, but it&#39;s probably worth investigating the existing UI th=
read rule<br>
&gt; + * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing thos=
e<br>
&gt; + * issues might precipitate requirements similar but not identical to=
 those<br>
&gt; + * of the Cocoa UI; hopefully we&#39;ll see some kind of pattern emer=
ge, which<br>
&gt; + * can then be used as a basis for an overhaul. (In fact, it may turn=
<br>
&gt; + * out to be simplest to split the UI/native platform event thread fr=
om the<br>
&gt; + * QEMU main event loop on all platforms, with any UI or even none at=
 all.)<br>
&gt; + */<br>
&gt; extern int (*qemu_main)(void);<br>
&gt;<br>
&gt; #endif /* QEMU_MAIN_H */<br>
&gt; diff --git a/system/main.c b/system/main.c<br>
&gt; index 9b91d21ea8c..2d9d144ed46 100644<br>
&gt; --- a/system/main.c<br>
&gt; +++ b/system/main.c<br>
&gt; @@ -24,26 +24,48 @@<br>
&gt;<br>
&gt; #include &quot;qemu/osdep.h&quot;<br>
&gt; #include &quot;qemu-main.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; #include &quot;sysemu/sysemu.h&quot;<br>
&gt;<br>
&gt; -#ifdef CONFIG_SDL<br>
&gt; -#include &lt;SDL.h&gt;<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>
&gt; #endif<br>
&gt;<br>
&gt; -int qemu_default_main(void)<br>
&gt; +static void *qemu_default_main(void *opaque)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0status =3D qemu_main_loop();<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_cleanup(status);<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return status;<br>
&gt; +=C2=A0 =C2=A0 exit(status);<br>
&gt; }<br>
&gt;<br>
&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
<br>
You could leave the definition without value here (what&#39;s now in the <b=
r>
#else) and then only assign it in the #if so this line would become<br>
<br>
-int (*qemu_main)(void) =3D qemu_default_main;<br>
+int (*qemu_main)(void);<br>
<br>
&gt; +#ifdef CONFIG_DARWIN<br>
&gt; +static int os_darwin_cfrunloop_main(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CFRunLoopRun();<br>
&gt; +=C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +}<br>
&gt; +<br>
&gt; +int (*qemu_main)(void) =3D os_darwin_cfrunloop_main;<br>
<br>
and this would be<br>
<br>
qemu_main =3D os_darwin_cfrunloop_main;<br>
<br>
and no need for #else. Also the name of this darwin main is a bit long, <br=
>
maybe qemu_darwin_main or qemu_default_main_darwin could be better?<br></bl=
ockquote><div>=C2=A0</div><div>I guess I wanted to clarify that it&#39;s us=
ing the CFRunloop variant of macOS event handling, in contrast to the Cocoa=
 UI&#39;s, which uses [NSApp run]; which additionally performs all the Coco=
a application bring-up before it starts handling events.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +#else<br>
&gt; +int (*qemu_main)(void);<br>
&gt; +#endif<br>
&gt;<br>
&gt; int main(int argc, char **argv)<br>
&gt; {<br>
&gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
<br>
This could be moved within the if (qemu_main) below as it&#39;s not needed =
<br>
outside.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
&gt; -=C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
<br>
What locks the bql at this point? I could not find the part in qemu_init <b=
r>
that makes it necessary to unlock it here. If nothing else is called <br>
before this, is it needed to take the lock and then unlock it here or can <=
br>
it be assumed to be unlocked yet?<br></blockquote><div><br></div><div>It lo=
oks like that happens in=C2=A0qemu_init_subsystems(), right after the BQL i=
s created inside qemu_init_cpu_loop():</div><div><br></div><div><a href=3D"=
https://gitlab.com/qemu-project/qemu/-/blob/master/system/runstate.c?ref_ty=
pe=3Dheads#L866">https://gitlab.com/qemu-project/qemu/-/blob/master/system/=
runstate.c?ref_type=3Dheads#L866</a> </div><div><br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; +=C2=A0 =C2=A0 if (qemu_main) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_thread_create(&amp;main_loop_thread,=
 &quot;qemu_main&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_default_main, NULL, QEMU_THREAD_DETACHED);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_main();<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_default_main(NULL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; }<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000a6ce870626e0a303--

