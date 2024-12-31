Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D16E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSin3-0007BM-DF; Tue, 31 Dec 2024 15:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimw-0006v4-Tz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:27 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimu-0000z1-HU
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:26 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso8735122f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676663; x=1736281463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL6CqFV2XJ8KJ3BBRtLlQRb5c8u0PDVdJeqa3ko7D9c=;
 b=kHNDxQcwANRCbNSydJZ8sh/6CXV4szL2+JDzcO4J+a4mUb1KEu9EWB0sjt6cXN9UNe
 yWidApsKkxYNJEVD3U2JP9hscwsZR+7B5O4YKMmoOSTXkmXaiRH07/IxPMT5bt22+JjO
 iErW6hbhUzrv9x5Pd9/+1bGmGP7u9zEtqmaNYvZbcFIgiIGT9cL7Tprg9OMld7yKUMC5
 J2Rwy1r4XAwQdgNH3EF2rA2nBITfzTzRwJsY29ucrtmKOJMqoY2WqLiugy1Om3hi+K4i
 sQmplWXHEiWHxrFtoZjs+nrmXpbgmluZui41ywSZM1ogbDt8fkj+EOYTFWxr5IEZoN5l
 ur0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676663; x=1736281463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL6CqFV2XJ8KJ3BBRtLlQRb5c8u0PDVdJeqa3ko7D9c=;
 b=cFYM8glUNMBD5duKhIs6vvgGfuoq8QT3PFJVh6HgQxvvyfu5A9xS+c+cgWoGTNNufS
 vS0tZunS3QCXvxG27guDLkcEjandvUo5jKrU6PMBnhPij1TFpnVNBjaqsG6UuOzfalke
 g/ARod0AE/oct2YK8tDHVVtIToBCmXRapezauDck/s2Knv+cbjr8cbMoECFJ3fGKuCNa
 KP2hqyx0qjD7BRw9IsKuMZGzqY1+6Ur5zyKP0x/HVPYxJ9xSIHOFfH7ReB4rvQHpuFxL
 lhbkPMvqaQwqaeQ+YllBSTNbyJ54nm0vC12vl03KbpIvP0nZtMUnLL4Sl1QxZ4Jz3fGV
 iAwQ==
X-Gm-Message-State: AOJu0YwW1ZcwkwbqAcgFzduNHifw6a0xLo/DgKY6KYu6lLx2lXrMoVai
 L3gy0yB0o9f8VbVcf4NDhPY/sSrkgKMJ6ctn3bxlvOu9MygffLnV95Bl2VDJMj9eCBauUwXHekS
 j+sg=
X-Gm-Gg: ASbGncvONJnOGHVsmXI9+/adBnnDMxZ9dcOWqGspJlCtmGGvaag0ohSuSupXWSUnJtT
 EUwI9x++dpbKMc1wcwXHzZr66qyRZDA7AaWFFVAweyif8zY529AoB1xhLsIqh/UeQ88+aw8630P
 4mIrb6G9bOuNmDXfRFR/Kta85Mec3dw39+FPznF40k3PSMykIJueRxdpa3lEtDSZxzrGdcxZJ0X
 ol8pZkkFugbvqK+ja7/2alrYNrXhnPaV+GGDhj6yfbdBeA371DHSazIblGr5n6mX8CBBhCaPAJr
 Eo95+rmhi+8yf3Go3wYcuwx86f1Dj5g=
X-Google-Smtp-Source: AGHT+IECK/qFYG0Q8wLL0DenYZUI9CGRg+ne66vPW8DM0IQ2aqo91J1h2I3HOcgAmZrKbdM7pyBQ2w==
X-Received: by 2002:a5d:6d8b:0:b0:385:eb7c:5d0f with SMTP id
 ffacd0b85a97d-38a221f2fdemr37967117f8f.26.1735676662510; 
 Tue, 31 Dec 2024 12:24:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c4esm432602465e9.4.2024.12.31.12.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/29] ui & main loop: Redesign of system-specific main thread
 event handling
Date: Tue, 31 Dec 2024 21:22:22 +0100
Message-ID: <20241231202228.28819-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

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
Message-ID: <20241223221645.29911-2-phil@philjordan.eu>
[PMD: Declare 'qemu_main' symbol in tests/qtest/fuzz/fuzz.c,
      add missing g_assert_not_reached() call in main()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu-main.h     | 14 ++++++++++-
 system/main.c           | 38 ++++++++++++++++++++++++++---
 tests/qtest/fuzz/fuzz.c |  1 +
 ui/gtk.c                |  4 +++
 ui/sdl2.c               |  4 +++
 ui/cocoa.m              | 54 ++++++++++-------------------------------
 6 files changed, 69 insertions(+), 46 deletions(-)

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
index 4923520741c..ecb12fd397c 100644
--- a/system/main.c
+++ b/system/main.c
@@ -24,26 +24,56 @@
 
 #include "qemu/osdep.h"
 #include "qemu-main.h"
+#include "qemu/main-loop.h"
 #include "system/system.h"
 
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
+        g_assert_not_reached();
+    }
 }
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 8274000bd55..ca248a51a6c 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -41,6 +41,7 @@ static FuzzTargetList *fuzz_target_list;
 static FuzzTarget *fuzz_target;
 static QTestState *fuzz_qts;
 
+int (*qemu_main)(void);
 
 
 void flush_events(QTestState *s)
diff --git a/ui/gtk.c b/ui/gtk.c
index 0d38c070e40..c0237431489 100644
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
index 1fb72f67a6f..445eb1dd9f9 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -34,6 +34,7 @@
 #include "system/system.h"
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
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3a88535374d..23b7a736d70 100644
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
-- 
2.47.1


