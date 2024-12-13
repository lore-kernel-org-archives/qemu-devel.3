Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54389E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7Sg-0006M0-1C; Fri, 13 Dec 2024 10:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rp-0004cH-Vi
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:25 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rg-0005Fz-3Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:21 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aab925654d9so21383966b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103150; x=1734707950;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmgJyWpCuCi2HoyxP/grcFhqMBy46PCyGsue2fZsSxs=;
 b=iNTLhDTUTvBUkAVGSp8N8kgJvGrbBZwC2rX+bErHv8ETawvUy9vWaDRrgcp41wLJtM
 RMX1eSreMb/bC76sFtx+YLDtEHR9UKSt4VAxivDFG2CO7Nd6t+px4CCkz1eu6TzQiaVD
 +5kAEcfpkgclnwp9c1rpqwtVYow6tfsEqY/HueilaZNExO3RWeeITcK95J0tD45rRB6u
 rwD7LTT/cB2Gx7bBjSlAl4wpjufSQYpAHSY7oeYb5vFHneFUlnrs+GpiQdhx0vMPgK7Q
 8FhnHw+1Pe/JbL/VqqA3yrJUKwqhGQFnEmnZyP54Fse72xP52Bn5itnbg+yNaGQpXIVZ
 oHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103150; x=1734707950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmgJyWpCuCi2HoyxP/grcFhqMBy46PCyGsue2fZsSxs=;
 b=ucwzGD9u78tz2FbSCRdfCAw2H+qV0HMDWPDE4k6P5rffrrlGkHPQ4b4cg1toEUguMn
 p634/wtr9cuwL8onNhNYulEOajMWJd5c0lMUFHIDqwmAXY6n29mg570ZqdKdICVDHNBk
 4HnhVJncGfgEzYxJSDUIlhHza+hnkBdx3pjgnwZFtwbYH6VcHOhYvxywr1cEwI1hzfqr
 CbYcpchQf+B8D6HTYU7xdONRB4xiE44OgYtf5qw87nIIdmZhINkW2ZF8rd8YyyZP9c9j
 Mstswdyh/1gk+modAVIU9FlYctfkUV+wK015XkvwJOHhwP6o9Gr3Y8tyWB0e54zlVm6M
 QFbg==
X-Gm-Message-State: AOJu0YwOOBsVS95aeYZ1O4walmTbLX1iZvI6n09rVhldAIlibDJVMQGR
 A/xCpBZPXFdSThKMyzZetXeSFyKr4uxIKnhaVTiUx4XXOrA4jpgUp4875isRlO6FlesrXYBuACS
 i4Q==
X-Gm-Gg: ASbGnculxpICUtj7iMM98v9wQTfvbk/WX1u+p2qi7r8mHulflotQYYDZeu43MyRnoVG
 wb+GWiZsfDqAiPgc14d+By2AYmQu9un/w8hu5zdg7JRxc4+zGxKEnxv/DhrAeFNW0kTLVkeNvzd
 TaeeFi5Px5bGL64ruLoob+hX0zwQQchw8vtY2gmVPbRSwdgUasvgYVXCX8PXGuGwe843bE1nw2t
 yI9zjcNYQFx/6kNdnU5cSnKctOJCnqn7+S+IZWqVqcot7dHI+OzJ7TfAXYM+qXSCQIqj6QWUgYp
 EbcW/+v1/R45OMCn6XB1k2/vYRgrRadp
X-Google-Smtp-Source: AGHT+IE87ed/KYgzfuMDvj/kYyF+apybNVcnyAN7xOlS6enMJWm+XuMRb835wxqYQIw7R5y57LnOug==
X-Received: by 2002:a17:907:94cd:b0:aa6:8a1b:8b74 with SMTP id
 a640c23a62f3a-aab77ec424cmr271245666b.53.1734103149675; 
 Fri, 13 Dec 2024 07:19:09 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:19:09 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Subject: [PATCH v14 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
Date: Fri, 13 Dec 2024 16:18:07 +0100
Message-Id: <20241213151821.65748-18-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::635;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x635.google.com
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

macOS's Cocoa event handling must be done on the initial (main) thread
of the process. Furthermore, if library or application code uses
libdispatch, the main dispatch queue must be handling events on the main
thread as well.

So far, this has affected Qemu in both the Cocoa and SDL UIs, although
in different ways: the Cocoa UI replaces the default qemu_main function
with one that spins Qemu's internal main event loop off onto a
background thread. SDL (which uses Cocoa internally) on the other hand
uses a polling approach within Qemu's main event loop. Events are
polled during the SDL UI's dpy_refresh callback, which happens to run
on the main thread by default.

As UIs are mutually exclusive, this works OK as long as nothing else
needs platform-native event handling. In the next patch, a new device is
introduced based on the ParavirtualizedGraphics.framework in macOS.
This uses libdispatch internally, and only works when events are being
handled on the main runloop. With the current system, it works when
using either the Cocoa or the SDL UI. However, it does not when running
headless. Moreover, any attempt to install a similar scheme to the
Cocoa UI's main thread replacement fails when combined with the SDL
UI.

This change tidies up main thread management to be more flexible.

 * The qemu_main global function pointer is a custom function for the
   main thread, and it may now be NULL. When it is, the main thread
   runs the main Qemu loop. This represents the traditional setup.
 * When non-null, spawning the main Qemu event loop on a separate
   thread is now done centrally rather than inside the Cocoa UI code.
 * For most platforms, qemu_main is indeed NULL by default, but on
   Darwin, it defaults to a function that runs the CFRunLoop.
 * The Cocoa UI sets qemu_main to a function which runs the
   NSApplication event handling runloop, as is usual for a Cocoa app.
 * The SDL UI overrides the qemu_main function to NULL, thus
   specifying that Qemu's main loop must run on the main
   thread.
 * The GTK UI also overrides the qemu_main function to NULL.
 * For other UIs, or in the absence of UIs, the platform's default
   behaviour is followed.

This means that on macOS, the platform's runloop events are always
handled, regardless of chosen UI. The new PV graphics device will
thus work in all configurations. There is no functional change on other
operating systems.

Implementing this via a global function pointer variable is a bit
ugly, but it's probably worth investigating the existing UI thread rule
violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
issues might precipitate requirements similar but not identical to those
of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
can then be used as a basis for an overhaul. (In fact, it may turn
out to be simplest to split the UI/native platform event thread from the
QEMU main event loop on all platforms, with any UI or even none at all.)

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v5:

 * Simplified the way of setting/clearing the main loop by going back
   to setting qemu_main directly, but narrowing the scope of what it
   needs to do, and it can now be NULL.

v6:

 * Folded function qemu_run_default_main_on_new_thread's code into
   main()
 * Removed whitespace changes left over on lines near code removed
   between v4 and v5

v9:

 * Set qemu_main to NULL for GTK UI as well.

v10:

 * Added comments clarifying the functionality and purpose of qemu_main.

v11:

 * Removed the qemu_main_fn typedef again.
 * Consolidation of main, qemu_default_main, and call_qemu_default_main
   so that the latter has been eliminated altogether.
 * Reinstated the #include <SDL.h> directive, added comment saying
   why it's needed.
 * Improved the comment on the qemu_main global variable.
 * Expanded the commit message.

v12:

 * More precise wording of code comments.

 include/qemu-main.h | 14 +++++++++++-
 system/main.c       | 37 +++++++++++++++++++++++++++----
 ui/cocoa.m          | 54 +++++++++++----------------------------------
 ui/gtk.c            |  4 ++++
 ui/sdl2.c           |  4 ++++
 5 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/include/qemu-main.h b/include/qemu-main.h
index 940960a7dbc..2ee83bedff3 100644
--- a/include/qemu-main.h
+++ b/include/qemu-main.h
@@ -5,7 +5,19 @@
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
+ * (macOS/Darwin) and/or require all UI API calls to occur from the main
+ * thread. Those platforms can initialise it to a specific function,
+ * while UI implementations may reset it to NULL during their init if they
+ * will handle system and UI events on the main thread via QEMU's own main
+ * event loop.
+ */
 extern int (*qemu_main)(void);
 
 #endif /* QEMU_MAIN_H */
diff --git a/system/main.c b/system/main.c
index 9b91d21ea8c..668d0ecfe8c 100644
--- a/system/main.c
+++ b/system/main.c
@@ -24,26 +24,55 @@
 
 #include "qemu/osdep.h"
 #include "qemu-main.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 
 #ifdef CONFIG_SDL
+/*
+ * SDL insists on wrapping the main() function with its own implementation on
+ * some platforms; it does so via a macro that renames our main function, so
+ * <SDL.h> must be #included here even with no SDL code called from this file.
+ */
 #include <SDL.h>
 #endif
 
-int qemu_default_main(void)
+#ifdef CONFIG_DARWIN
+#include <CoreFoundation/CoreFoundation.h>
+#endif
+
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
+int (*qemu_main)(void);
+
+#ifdef CONFIG_DARWIN
+static int os_darwin_cfrunloop_main(void)
+{
+    CFRunLoopRun();
+    g_assert_not_reached();
+}
+int (*qemu_main)(void) = os_darwin_cfrunloop_main;
+#endif
 
 int main(int argc, char **argv)
 {
     qemu_init(argc, argv);
-    return qemu_main();
+    bql_unlock();
+    if (qemu_main) {
+        QemuThread main_loop_thread;
+        qemu_thread_create(&main_loop_thread, "qemu_main",
+                           qemu_default_main, NULL, QEMU_THREAD_DETACHED);
+        return qemu_main();
+    } else {
+        qemu_default_main(NULL);
+    }
 }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index dd88115dc6f..0a9ad824aa5 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -73,6 +73,8 @@
     int height;
 } QEMUScreen;
 
+@class QemuCocoaPasteboardTypeOwner;
+
 static void cocoa_update(DisplayChangeListener *dcl,
                          int x, int y, int w, int h);
 
@@ -107,6 +109,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static NSInteger cbchangecount = -1;
 static QemuClipboardInfo *cbinfo;
 static QemuEvent cbevent;
+static QemuCocoaPasteboardTypeOwner *cbowner;
 
 // Utility functions to run specified code block with the BQL held
 typedef void (^CodeBlock)(void);
@@ -1326,8 +1329,10 @@ - (void) dealloc
 {
     COCOA_DEBUG("QemuCocoaAppController: dealloc\n");
 
-    if (cocoaView)
-        [cocoaView release];
+    [cocoaView release];
+    [cbowner release];
+    cbowner = nil;
+
     [super dealloc];
 }
 
@@ -1943,8 +1948,6 @@ - (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSPasteboardType)t
 
 @end
 
-static QemuCocoaPasteboardTypeOwner *cbowner;
-
 static void cocoa_clipboard_notify(Notifier *notifier, void *data);
 static void cocoa_clipboard_request(QemuClipboardInfo *info,
                                     QemuClipboardType type);
@@ -2007,43 +2010,8 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
     }
 }
 
-/*
- * The startup process for the OSX/Cocoa UI is complicated, because
- * OSX insists that the UI runs on the initial main thread, and so we
- * need to start a second thread which runs the qemu_default_main():
- * in main():
- *  in cocoa_display_init():
- *   assign cocoa_main to qemu_main
- *   create application, menus, etc
- *  in cocoa_main():
- *   create qemu-main thread
- *   enter OSX run loop
- */
-
-static void *call_qemu_main(void *opaque)
-{
-    int status;
-
-    COCOA_DEBUG("Second thread: calling qemu_default_main()\n");
-    bql_lock();
-    status = qemu_default_main();
-    bql_unlock();
-    COCOA_DEBUG("Second thread: qemu_default_main() returned, exiting\n");
-    [cbowner release];
-    exit(status);
-}
-
 static int cocoa_main(void)
 {
-    QemuThread thread;
-
-    COCOA_DEBUG("Entered %s()\n", __func__);
-
-    bql_unlock();
-    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
-                       NULL, QEMU_THREAD_DETACHED);
-
-    // Start the main event loop
     COCOA_DEBUG("Main thread: entering OSX run loop\n");
     [NSApp run];
     COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
@@ -2125,8 +2093,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
-    qemu_main = cocoa_main;
-
     // Pull this console process up to being a fully-fledged graphical
     // app with a menubar and Dock icon
     ProcessSerialNumber psn = { 0, kCurrentProcess };
@@ -2190,6 +2156,12 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
     qemu_clipboard_peer_register(&cbpeer);
 
     [pool release];
+
+    /*
+     * The Cocoa UI will run the NSApplication runloop on the main thread
+     * rather than the default Core Foundation one.
+     */
+    qemu_main = cocoa_main;
 }
 
 static QemuDisplay qemu_display_cocoa = {
diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679a..c8dcd95350c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu-main.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
@@ -2485,6 +2486,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 #ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
 #endif /* CONFIG_GTK_CLIPBOARD */
+
+    /* GTK's event polling must happen on the main thread. */
+    qemu_main = NULL;
 }
 
 static void early_gtk_display_init(DisplayOptions *opts)
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da14..44ab2762262 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -34,6 +34,7 @@
 #include "sysemu/sysemu.h"
 #include "ui/win32-kbd-hook.h"
 #include "qemu/log.h"
+#include "qemu-main.h"
 
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
@@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     }
 
     atexit(sdl_cleanup);
+
+    /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
+    qemu_main = NULL;
 }
 
 static QemuDisplay qemu_display_sdl2 = {
-- 
2.39.5 (Apple Git-154)


