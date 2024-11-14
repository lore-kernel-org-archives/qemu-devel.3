Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A4ED68B01
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZMb-0004bm-5e; Thu, 14 Nov 2024 07:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBZMW-0004R9-9m
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:54:16 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tBZMQ-0006B6-6K
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:54:16 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-856d47976d9so193111241.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731588848; x=1732193648;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzQmOlhVtHYq01wXZpayPTTzUs7TEDCb5AZ4owwhhT0=;
 b=J5M6TuABpb8sqsT409kiYkpKN0mCl/GCQzXUz13ok4rAtydB4wlmjQ07kV14l4pgt2
 YLIZPoOFu2vpAQeMz+GW48K+s4qB9TnrrO4BcaPRuCgr+TmYDgJD2ZR7MpF7TTd/EOHJ
 CWECrc5XbpilfcHkN1tLVhp6D2P7LIGINO2uuznW9t/ESMuiOv4WbpymuvvmXZxKVcmD
 klmlBYk0gl3nMWKnwW9lW5A9pwUX/xTWprviL1EQpZk0WMqL5xMNc17FOEpa47I01TDp
 agRctvbgEBQhAnNmCzZGE5FSEQ8Ht1u5wo0NdYm+HrHGWxmJWNlaL4LHJiIbBympkqNN
 lP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588848; x=1732193648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzQmOlhVtHYq01wXZpayPTTzUs7TEDCb5AZ4owwhhT0=;
 b=oN0e1348o4fMDtFOXsKSwtFMhmXQeGSkw2R1zdEBbfUg3tJ1vfz1aData0xOKXldvW
 zSGMTI9zwslHXg3FxHjl2lfSDXAChb3obhONyevYBTfV4YOGZ+FXsNx1gESEkbapyKzS
 mgebzCXO85DsnwWqzu5AhAa2vZNitsR07u7UxwmBoEL7L1xk80yn/qy07cTfbhg7TKWo
 XiJOdZoiuVBmtgnmZ2t51PHErjR4cK3Yb0qk4mWE6/vSUnlt8fSxuKphTCm1tIa4rOfM
 C9pdkF9El5MJ9GpL3aQiJmiMser3nnk9fnnGPh96OCO42NWoSUSEKXaWG2rFpD4jdd5R
 W9jA==
X-Gm-Message-State: AOJu0YwbKO53WDtCov2olmbuTAVSkiZm+sc3uAYKWvwdJDLr42p6DzAv
 iL0ganrxjlSRBad3UiyexzwhMWrZ9+TulbBNNe4Rdd7N6vil07oRGqcYmWAg3WJqeFauF6RNcvU
 +aJ0+ECm5vBOp1maTtZLGqugpy5AoUHuNc7+h
X-Google-Smtp-Source: AGHT+IEukBwTkvDALH/1x856xceds/zUDzXTnY7YVpV7H4lIy727bUO8HGdRrZc92vU6md0nPdaDlscy9oohOxJe34U=
X-Received: by 2002:a05:6102:32cb:b0:4a4:8fc3:9c8 with SMTP id
 ada2fe7eead31-4ad468ad19emr7337057137.10.1731588847989; Thu, 14 Nov 2024
 04:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
 <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
In-Reply-To: <9dd5c736-e1b8-a025-745a-52e9aacb4b9b@eik.bme.hu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Thu, 14 Nov 2024 13:53:57 +0100
Message-ID: <CAAibmn2PJ0Q0E3KEGZqu9ogbMt+qiBLRuXa6C74ud=2S4G8DSA@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002e8b8b0626def2f4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92d;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92d.google.com
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

--0000000000002e8b8b0626def2f4
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 19:16, BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Wed, 13 Nov 2024, Phil Dennis-Jordan wrote:
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
> > * The qemu_main global function pointer is a custom function for the
> >   main thread, and it may now be NULL. When it is, the main thread
> >   runs the main Qemu loop. This represents the traditional setup.
> > * When non-null, spawning the main Qemu event loop on a separate
> >   thread is now done centrally rather than inside the Cocoa UI code.
> > * For most platforms, qemu_main is indeed NULL by default, but on
> >   Darwin, it defaults to a function that runs the CFRunLoop.
> > * The Cocoa UI sets qemu_main to a function which runs the
> >   NSApplication event handling runloop, as is usual for a Cocoa app.
> > * The SDL UI overrides the qemu_main function to NULL, thus
> >   specifying that Qemu's main loop must run on the main
> >   thread.
> > * The GTK UI also overrides the qemu_main function to NULL.
> > * For other UIs, or in the absence of UIs, the platform's default
> >   behaviour is followed.
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
> > * Simplified the way of setting/clearing the main loop by going back
> >   to setting qemu_main directly, but narrowing the scope of what it
> >   needs to do, and it can now be NULL.
> >
> > v6:
> >
> > * Folded function qemu_run_default_main_on_new_thread's code into
> >   main()
> > * Removed whitespace changes left over on lines near code removed
> >   between v4 and v5
> >
> > v9:
> >
> > * Set qemu_main to NULL for GTK UI as well.
> >
> > v10:
> >
> > * Added comments clarifying the functionality and purpose of qemu_main.
> >
> > include/qemu-main.h     | 21 ++++++++++++++--
> > include/qemu/typedefs.h |  1 +
> > system/main.c           | 50 ++++++++++++++++++++++++++++++++++----
> > ui/cocoa.m              | 54 ++++++++++-------------------------------
> > ui/gtk.c                |  8 ++++++
> > ui/sdl2.c               |  4 +++
> > 6 files changed, 90 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/qemu-main.h b/include/qemu-main.h
> > index 940960a7dbc..fc70681c8b5 100644
> > --- a/include/qemu-main.h
> > +++ b/include/qemu-main.h
> > @@ -5,7 +5,24 @@
> > #ifndef QEMU_MAIN_H
> > #define QEMU_MAIN_H
> >
> > -int qemu_default_main(void);
> > -extern int (*qemu_main)(void);
> > +/*
> > + * The function to run on the main (initial) thread of the process.
> > + * NULL means QEMU's main event loop.
> > + * When non-NULL, QEMU's main event loop will run on a purposely created
> > + * thread, after which the provided function pointer will be invoked on
> > + * the initial thread.
> > + * This is useful on platforms which treat the main thread as special
> > + * (macOS/Darwin) and/or require all UI API calls to occur from a
> > + * specific thread.
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
> > +extern qemu_main_fn qemu_main;
>
> qemu_main_fn is defined in typdefefs.h but not included here. Also coding
> style says typedefs should be CamelCase but maybe it's just not worth to
> define a type for this and you can just leave the existing line here only
> removing the qemu_default_main declaration and adding the comment.
>
> > #endif /* QEMU_MAIN_H */
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 3d84efcac47..b02cfe1f328 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> > @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
> >  * Function types
> >  */
> > typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> > +typedef int (*qemu_main_fn)(void);
>
> Then drop this change...
>
> > #endif /* QEMU_TYPEDEFS_H */
> > diff --git a/system/main.c b/system/main.c
> > index 9b91d21ea8c..d9397a6d5d0 100644
> > --- a/system/main.c
> > +++ b/system/main.c
> > @@ -24,13 +24,14 @@
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
> > +static int qemu_default_main(void)
> > {
> >     int status;
> >
> > @@ -40,10 +41,49 @@ int qemu_default_main(void)
> >     return status;
> > }
> >
> > -int (*qemu_main)(void) = qemu_default_main;
>
> ...and leave this line here without init to define the global variable and
> only put assigning the init value in the #ifdef if you don't want to
> repeat the function pointer definition twice (but that wouldn't be a
> problem either in my opinion to do it in the #ifdef this way).
>
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
>
> Is it better to use g_assert_not_reached() here?
>
> > +}
> > +
> > +qemu_main_fn qemu_main = os_darwin_cfrunloop_main;
> > +#else
> > +qemu_main_fn qemu_main;
> > +#endif
> >
> > int main(int argc, char **argv)
> > {
> > +    QemuThread main_loop_thread;
> > +
> >     qemu_init(argc, argv);
> > -    return qemu_main();
> > +    if (qemu_main) {
> > +        qemu_thread_create(&main_loop_thread, "qemu_main",
> > +                           call_qemu_default_main, NULL,
> QEMU_THREAD_DETACHED);
> > +        bql_unlock();
> > +        return qemu_main();
> > +    } else {
> > +        qemu_default_main();
>
> I think you need 'return qemu_default_main()' here but I'm a bit confused
> by all this wrapping of qemu_default_main in call_qemu_default_main. I see
> that may be needed because qemu_thread_create takes a different function
> but now that qemu_default main is static and not replaced externally could
> that be changed to the right type and avoid this confusion and simplify
> this a bit?
>
> Regards,
> BALATON Zoltan
>
>
Alright, I've gone ahead and worked through that, and it does indeed make
things simpler. This is what I have for include/qemu-main.h and
system/main.c now:

diff --git a/include/qemu-main.h b/include/qemu-main.h
index 940960a7dbc..e1041fe99b4 100644
--- a/include/qemu-main.h
+++ b/include/qemu-main.h
@@ -5,7 +5,29 @@
 #ifndef QEMU_MAIN_H
 #define QEMU_MAIN_H

-int qemu_default_main(void);
+/*
+ * The function to run on the main (initial) thread of the process.
+ * NULL means QEMU's main event loop.
+ * When non-NULL, QEMU's main event loop will run on a purposely created
+ * thread, after which the provided function pointer will be invoked on
+ * the initial thread.
+ * This is useful on platforms which treat the main thread as special
+ * (macOS/Darwin) and/or require all UI API calls to occur from a
+ * specific thread.
+ * In practice, this means that on macOS, it is initialised to a function
+ * that runs the Core Foundation runloop. The Cocoa UI "upgrades" this
+ * to the NSApplication-specific event processing variant. Other platforms
+ * currently leave it at NULL; the SDL and GTK UIs reset it to NULL even
+ * on macOS as they directly poll the runloop.
+ * Implementing this via a global function pointer variable is a bit
+ * ugly, but it's probably worth investigating the existing UI thread rule
+ * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
+ * issues might precipitate requirements similar but not identical to those
+ * of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
+ * can then be used as a basis for an overhaul. (In fact, it may turn
+ * out to be simplest to split the UI/native platform event thread from the
+ * QEMU main event loop on all platforms, with any UI or even none at all.)
+ */
 extern int (*qemu_main)(void);

 #endif /* QEMU_MAIN_H */
diff --git a/system/main.c b/system/main.c
index 9b91d21ea8c..2d9d144ed46 100644
--- a/system/main.c
+++ b/system/main.c
@@ -24,26 +24,48 @@

 #include "qemu/osdep.h"
 #include "qemu-main.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"

-#ifdef CONFIG_SDL
-#include <SDL.h>
+#ifdef CONFIG_DARWIN
+#include <CoreFoundation/CoreFoundation.h>
 #endif

-int qemu_default_main(void)
+static void *qemu_default_main(void *opaque)
 {
     int status;

+    bql_lock();
     status = qemu_main_loop();
     qemu_cleanup(status);
+    bql_unlock();

-    return status;
+    exit(status);
 }

-int (*qemu_main)(void) = qemu_default_main;
+#ifdef CONFIG_DARWIN
+static int os_darwin_cfrunloop_main(void)
+{
+    CFRunLoopRun();
+    g_assert_not_reached();
+}
+
+int (*qemu_main)(void) = os_darwin_cfrunloop_main;
+#else
+int (*qemu_main)(void);
+#endif

 int main(int argc, char **argv)
 {
+    QemuThread main_loop_thread;
+
     qemu_init(argc, argv);
-    return qemu_main();
+    bql_unlock();
+    if (qemu_main) {
+        qemu_thread_create(&main_loop_thread, "qemu_main",
+                           qemu_default_main, NULL, QEMU_THREAD_DETACHED);
+        return qemu_main();
+    } else {
+        qemu_default_main(NULL);
+    }
 }

--0000000000002e8b8b0626def2f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, 13 Nov 2024 at 19:16, BALATON Zoltan &lt;<a href=3D"mail=
to:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Wed, 13 Nov 2024, Phil Dennis-J=
ordan wrote:<br>
&gt; macOS&#39;s Cocoa event handling must be done on the initial (main) th=
read<br>
&gt; of the process. Furthermore, if library or application code uses<br>
&gt; libdispatch, the main dispatch queue must be handling events on the ma=
in<br>
&gt; thread as well.<br>
&gt;<br>
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
&gt;<br>
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
&gt;<br>
&gt; This change tidies up main thread management to be more flexible.<br>
&gt;<br>
&gt; * The qemu_main global function pointer is a custom function for the<b=
r>
&gt;=C2=A0 =C2=A0main thread, and it may now be NULL. When it is, the main =
thread<br>
&gt;=C2=A0 =C2=A0runs the main Qemu loop. This represents the traditional s=
etup.<br>
&gt; * When non-null, spawning the main Qemu event loop on a separate<br>
&gt;=C2=A0 =C2=A0thread is now done centrally rather than inside the Cocoa =
UI code.<br>
&gt; * For most platforms, qemu_main is indeed NULL by default, but on<br>
&gt;=C2=A0 =C2=A0Darwin, it defaults to a function that runs the CFRunLoop.=
<br>
&gt; * The Cocoa UI sets qemu_main to a function which runs the<br>
&gt;=C2=A0 =C2=A0NSApplication event handling runloop, as is usual for a Co=
coa app.<br>
&gt; * The SDL UI overrides the qemu_main function to NULL, thus<br>
&gt;=C2=A0 =C2=A0specifying that Qemu&#39;s main loop must run on the main<=
br>
&gt;=C2=A0 =C2=A0thread.<br>
&gt; * The GTK UI also overrides the qemu_main function to NULL.<br>
&gt; * For other UIs, or in the absence of UIs, the platform&#39;s default<=
br>
&gt;=C2=A0 =C2=A0behaviour is followed.<br>
&gt;<br>
&gt; This means that on macOS, the platform&#39;s runloop events are always=
<br>
&gt; handled, regardless of chosen UI. The new PV graphics device will<br>
&gt; thus work in all configurations. There is no functional change on othe=
r<br>
&gt; operating systems.<br>
&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; v5:<br>
&gt;<br>
&gt; * Simplified the way of setting/clearing the main loop by going back<b=
r>
&gt;=C2=A0 =C2=A0to setting qemu_main directly, but narrowing the scope of =
what it<br>
&gt;=C2=A0 =C2=A0needs to do, and it can now be NULL.<br>
&gt;<br>
&gt; v6:<br>
&gt;<br>
&gt; * Folded function qemu_run_default_main_on_new_thread&#39;s code into<=
br>
&gt;=C2=A0 =C2=A0main()<br>
&gt; * Removed whitespace changes left over on lines near code removed<br>
&gt;=C2=A0 =C2=A0between v4 and v5<br>
&gt;<br>
&gt; v9:<br>
&gt;<br>
&gt; * Set qemu_main to NULL for GTK UI as well.<br>
&gt;<br>
&gt; v10:<br>
&gt;<br>
&gt; * Added comments clarifying the functionality and purpose of qemu_main=
.<br>
&gt;<br>
&gt; include/qemu-main.h=C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++++--<br>
&gt; include/qemu/typedefs.h |=C2=A0 1 +<br>
&gt; system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 +++++++++++=
+++++++++++++++++++++++----<br>
&gt; ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 54 ++++++=
++++-------------------------------<br>
&gt; ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 8 ++++++<br>
&gt; ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +++<br>
&gt; 6 files changed, 90 insertions(+), 48 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/qemu-main.h b/include/qemu-main.h<br>
&gt; index 940960a7dbc..fc70681c8b5 100644<br>
&gt; --- a/include/qemu-main.h<br>
&gt; +++ b/include/qemu-main.h<br>
&gt; @@ -5,7 +5,24 @@<br>
&gt; #ifndef QEMU_MAIN_H<br>
&gt; #define QEMU_MAIN_H<br>
&gt;<br>
&gt; -int qemu_default_main(void);<br>
&gt; -extern int (*qemu_main)(void);<br>
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
&gt; +extern qemu_main_fn qemu_main;<br>
<br>
qemu_main_fn is defined in typdefefs.h but not included here. Also coding <=
br>
style says typedefs should be CamelCase but maybe it&#39;s just not worth t=
o <br>
define a type for this and you can just leave the existing line here only <=
br>
removing the qemu_default_main declaration and adding the comment.<br>
<br>
&gt; #endif /* QEMU_MAIN_H */<br>
&gt; diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h<br>
&gt; index 3d84efcac47..b02cfe1f328 100644<br>
&gt; --- a/include/qemu/typedefs.h<br>
&gt; +++ b/include/qemu/typedefs.h<br>
&gt; @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;<br>
&gt;=C2=A0 * Function types<br>
&gt;=C2=A0 */<br>
&gt; typedef void (*qemu_irq_handler)(void *opaque, int n, int level);<br>
&gt; +typedef int (*qemu_main_fn)(void);<br>
<br>
Then drop this change...<br>
<br>
&gt; #endif /* QEMU_TYPEDEFS_H */<br>
&gt; diff --git a/system/main.c b/system/main.c<br>
&gt; index 9b91d21ea8c..d9397a6d5d0 100644<br>
&gt; --- a/system/main.c<br>
&gt; +++ b/system/main.c<br>
&gt; @@ -24,13 +24,14 @@<br>
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
&gt; +static int qemu_default_main(void)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int status;<br>
&gt;<br>
&gt; @@ -40,10 +41,49 @@ int qemu_default_main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0return status;<br>
&gt; }<br>
&gt;<br>
&gt; -int (*qemu_main)(void) =3D qemu_default_main;<br>
<br>
...and leave this line here without init to define the global variable and =
<br>
only put assigning the init value in the #ifdef if you don&#39;t want to <b=
r>
repeat the function pointer definition twice (but that wouldn&#39;t be a <b=
r>
problem either in my opinion to do it in the #ifdef this way).<br>
<br>
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
<br>
Is it better to use g_assert_not_reached() here?<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +qemu_main_fn qemu_main =3D os_darwin_cfrunloop_main;<br>
&gt; +#else<br>
&gt; +qemu_main_fn qemu_main;<br>
&gt; +#endif<br>
&gt;<br>
&gt; int main(int argc, char **argv)<br>
&gt; {<br>
&gt; +=C2=A0 =C2=A0 QemuThread main_loop_thread;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>
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
<br>
I think you need &#39;return qemu_default_main()&#39; here but I&#39;m a bi=
t confused <br>
by all this wrapping of qemu_default_main in call_qemu_default_main. I see =
<br>
that may be needed because qemu_thread_create takes a different function <b=
r>
but now that qemu_default main is static and not replaced externally could =
<br>
that be changed to the right type and avoid this confusion and simplify <br=
>
this a bit?<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br></blockquote><div><br></div><div>Alright, I&#39;ve gone ahead and worke=
d through that, and it does indeed make things simpler. This is what I have=
 for include/qemu-main.h and system/main.c now:<br></div><div><br></div><di=
v>diff --git a/include/qemu-main.h b/include/qemu-main.h<br>index 940960a7d=
bc..e1041fe99b4 100644<br>--- a/include/qemu-main.h<br>+++ b/include/qemu-m=
ain.h<br>@@ -5,7 +5,29 @@<br>=C2=A0#ifndef QEMU_MAIN_H<br>=C2=A0#define QEM=
U_MAIN_H<br>=C2=A0<br>-int qemu_default_main(void);<br>+/*<br>+ * The funct=
ion to run on the main (initial) thread of the process.<br>+ * NULL means Q=
EMU&#39;s main event loop.<br>+ * When non-NULL, QEMU&#39;s main event loop=
 will run on a purposely created<br>+ * thread, after which the provided fu=
nction pointer will be invoked on<br>+ * the initial thread.<br>+ * This is=
 useful on platforms which treat the main thread as special<br>+ * (macOS/D=
arwin) and/or require all UI API calls to occur from a<br>+ * specific thre=
ad.<br>+ * In practice, this means that on macOS, it is initialised to a fu=
nction<br>+ * that runs the Core Foundation runloop. The Cocoa UI &quot;upg=
rades&quot; this<br>+ * to the NSApplication-specific event processing vari=
ant. Other platforms<br>+ * currently leave it at NULL; the SDL and GTK UIs=
 reset it to NULL even<br>+ * on macOS as they directly poll the runloop.<b=
r>+ * Implementing this via a global function pointer variable is a bit<br>=
+ * ugly, but it&#39;s probably worth investigating the existing UI thread =
rule<br>+ * violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing t=
hose<br>+ * issues might precipitate requirements similar but not identical=
 to those<br>+ * of the Cocoa UI; hopefully we&#39;ll see some kind of patt=
ern emerge, which<br>+ * can then be used as a basis for an overhaul. (In f=
act, it may turn<br>+ * out to be simplest to split the UI/native platform =
event thread from the<br>+ * QEMU main event loop on all platforms, with an=
y UI or even none at all.)<br>+ */<br>=C2=A0extern int (*qemu_main)(void);<=
br>=C2=A0<br>=C2=A0#endif /* QEMU_MAIN_H */<br>diff --git a/system/main.c b=
/system/main.c<br>index 9b91d21ea8c..2d9d144ed46 100644<br>--- a/system/mai=
n.c<br>+++ b/system/main.c<br>@@ -24,26 +24,48 @@<br>=C2=A0<br>=C2=A0#inclu=
de &quot;qemu/osdep.h&quot;<br>=C2=A0#include &quot;qemu-main.h&quot;<br>+#=
include &quot;qemu/main-loop.h&quot;<br>=C2=A0#include &quot;sysemu/sysemu.=
h&quot;<br>=C2=A0<br>-#ifdef CONFIG_SDL<br>-#include &lt;SDL.h&gt;<br>+#ifd=
ef CONFIG_DARWIN<br>+#include &lt;CoreFoundation/CoreFoundation.h&gt;<br>=
=C2=A0#endif<br>=C2=A0<br>-int qemu_default_main(void)<br>+static void *qem=
u_default_main(void *opaque)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0int status;<=
br>=C2=A0<br>+ =C2=A0 =C2=A0bql_lock();<br>=C2=A0 =C2=A0 =C2=A0status =3D q=
emu_main_loop();<br>=C2=A0 =C2=A0 =C2=A0qemu_cleanup(status);<br>+ =C2=A0 =
=C2=A0bql_unlock();<br>=C2=A0<br>- =C2=A0 =C2=A0return status;<br>+ =C2=A0 =
=C2=A0exit(status);<br>=C2=A0}<br>=C2=A0<br>-int (*qemu_main)(void) =3D qem=
u_default_main;<br>+#ifdef CONFIG_DARWIN<br>+static int os_darwin_cfrunloop=
_main(void)<br>+{<br>+ =C2=A0 =C2=A0CFRunLoopRun();<br>+ =C2=A0 =C2=A0g_ass=
ert_not_reached();<br>+}<br>+<br>+int (*qemu_main)(void) =3D os_darwin_cfru=
nloop_main;<br>+#else<br>+int (*qemu_main)(void);<br>+#endif<br>=C2=A0<br>=
=C2=A0int main(int argc, char **argv)<br>=C2=A0{<br>+ =C2=A0 =C2=A0QemuThre=
ad main_loop_thread;<br>+<br>=C2=A0 =C2=A0 =C2=A0qemu_init(argc, argv);<br>=
- =C2=A0 =C2=A0return qemu_main();<br>+ =C2=A0 =C2=A0bql_unlock();<br>+ =C2=
=A0 =C2=A0if (qemu_main) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_crea=
te(&amp;main_loop_thread, &quot;qemu_main&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_=
default_main, NULL, QEMU_THREAD_DETACHED);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return qemu_main();<br>+ =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qemu_default_main(NULL);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0</di=
v></div></div>

--0000000000002e8b8b0626def2f4--

