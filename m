Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AE9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TF-0004Mu-Pn; Wed, 17 Jul 2024 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2Sc-0001Pr-CV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:38 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SZ-0006zM-Ip
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:38 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id A536838F9C9; Wed, 17 Jul 2024 13:04:06 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 phil@philjordan.eu, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 3/8] ui/cocoa: Adds non-app runloop on main thread mode
Date: Wed, 17 Jul 2024 13:03:21 +0200
Message-Id: <20240717110326.45230-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240717110326.45230-1-phil@philjordan.eu>
References: <20240717110326.45230-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

Various system frameworks on macOS and other Apple platforms
require a main runloop to be processing events on the process’s
main thread. The Cocoa UI’s requirement to run the process as a
Cocoa application automatically enables this runloop, but it
can be useful to have the runloop handling events even without
the Cocoa UI active.

This change adds a non-app runloop mode to the cocoa_main
function. This can be requested by other code, while the Cocoa UI
additionally enables app mode. This arrangement ensures there is
only one qemu_main function switcheroo, and the Cocoa UI’s app
mode requirement and other subsystems’ runloop requests don’t
conflict with each other.

The main runloop is required for the AppleGFX PV graphics device,
so the runloop request call has been added to its initialisation.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m |  3 +++
 include/qemu-main.h    |  2 ++
 ui/cocoa.m             | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 564f3df6fd..b1a8a9f649 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -14,6 +14,7 @@
 
 #include "apple-gfx.h"
 #include "trace.h"
+#include "qemu-main.h"
 #include "qemu/main-loop.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
@@ -290,6 +291,8 @@ void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
             error_report_err(local_err);
         }
     }
+
+    cocoa_enable_runloop_on_main_thread();
 }
 
 static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
diff --git a/include/qemu-main.h b/include/qemu-main.h
index 940960a7db..da4516e69e 100644
--- a/include/qemu-main.h
+++ b/include/qemu-main.h
@@ -8,4 +8,6 @@
 int qemu_default_main(void);
 extern int (*qemu_main)(void);
 
+void cocoa_enable_runloop_on_main_thread(void);
+
 #endif /* QEMU_MAIN_H */
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd33532..40f65d7a45 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2028,6 +2028,7 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
     exit(status);
 }
 
+static bool run_as_cocoa_app = false;
 static int cocoa_main(void)
 {
     QemuThread thread;
@@ -2040,7 +2041,11 @@ static int cocoa_main(void)
 
     // Start the main event loop
     COCOA_DEBUG("Main thread: entering OSX run loop\n");
-    [NSApp run];
+    if (run_as_cocoa_app) {
+        [NSApp run];
+    } else {
+        CFRunLoopRun();
+    }
     COCOA_DEBUG("Main thread: left OSX run loop, which should never happen\n");
 
     abort();
@@ -2114,13 +2119,19 @@ static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
     });
 }
 
+void cocoa_enable_runloop_on_main_thread(void)
+{
+    qemu_main = cocoa_main;
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
-    qemu_main = cocoa_main;
+    run_as_cocoa_app = true;
+    cocoa_enable_runloop_on_main_thread();
 
     // Pull this console process up to being a fully-fledged graphical
     // app with a menubar and Dock icon
-- 
2.39.3 (Apple Git-146)


