Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B0C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az9-00039v-Cc; Fri, 04 Sep 2026 16:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az6-000399-Eu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:04 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az2-0007y0-5B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:04 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id CC927807A6;
 Fri, 04 Sep 2026 23:57:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-sXWwhiev; Fri, 04 Sep 2026 23:57:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555478;
 bh=d4dbH53MPfx1q2KRu2EkXixZG7sgb64R8Vc62UI24tE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=GyPgqZ7MvXGQH7Gtor95cAcKddxNx/X1P3pEfHMxA5VU21Xmn0YmTgiiDegKmKvU5
 KIf8vsAV4eNJfo4zaoiSWzAci5XoV+KfQSiwfs5Rk9QzG1/LdODz4xlVswzmBp0mcY
 tDX8rkjuCZfR3g1e4dPRH9fA769FII9YIm+B1nj0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 6/6] runstate: make runstate actions private
Date: Fri,  4 Sep 2026 23:57:49 +0300
Message-ID: <20260904205749.510493-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904205749.510493-1-vsementsov@yandex-team.ru>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The action variables are now used only within system/runstate.c.
Move them and qmp_set_action() there, make the variables static,
and remove runstate-action.c and its header.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 MAINTAINERS                      |  1 -
 include/system/runstate-action.h | 19 -------------
 monitor/qmp-cmds.c               |  1 -
 system/meson.build               |  1 -
 system/runstate-action.c         | 46 --------------------------------
 system/runstate.c                | 34 ++++++++++++++++++++++-
 system/vl.c                      |  2 +-
 ui/cocoa.m                       |  1 -
 ui/sdl2.c                        |  1 -
 9 files changed, 34 insertions(+), 72 deletions(-)
 delete mode 100644 include/system/runstate-action.h
 delete mode 100644 system/runstate-action.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6aa..2cee4c71b7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,7 +3514,6 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/main-loop.h
 F: include/system/runstate.h
-F: include/system/runstate-action.h
 F: util/main-loop.c
 F: util/qemu-timer*.c
 F: system/vl.c
diff --git a/include/system/runstate-action.h b/include/system/runstate-action.h
deleted file mode 100644
index db4e3099ae5..00000000000
--- a/include/system/runstate-action.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (c) 2020 Oracle and/or its affiliates.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef RUNSTATE_ACTION_H
-#define RUNSTATE_ACTION_H
-
-#include "qapi/qapi-commands-run-state.h"
-
-/* in system/runstate-action.c */
-extern RebootAction reboot_action;
-extern ShutdownAction shutdown_action;
-extern PanicAction panic_action;
-
-#endif /* RUNSTATE_ACTION_H */
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 6d0ba75ff16..f89237eb238 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -22,7 +22,6 @@
 #include "system/system.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
-#include "system/runstate-action.h"
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-init-commands.h"
diff --git a/system/meson.build b/system/meson.build
index 41e2e4a292d..dd4622ae08c 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -22,7 +22,6 @@ system_ss.add(files(
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-  'runstate-action.c',
   'runstate.c',
   'watchpoint.c',
 ))
diff --git a/system/runstate-action.c b/system/runstate-action.c
deleted file mode 100644
index f912bc837f2..00000000000
--- a/system/runstate-action.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (c) 2020 Oracle and/or its affiliates.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/runstate-action.h"
-#include "system/watchdog.h"
-#include "qemu/config-file.h"
-#include "qapi/error.h"
-#include "qemu/option_int.h"
-
-RebootAction reboot_action = REBOOT_ACTION_RESET;
-ShutdownAction shutdown_action = SHUTDOWN_ACTION_POWEROFF;
-PanicAction panic_action = PANIC_ACTION_SHUTDOWN;
-
-/*
- * Receives actions to be applied for specific guest events
- * and sets the internal state as requested.
- */
-void qmp_set_action(bool has_reboot, RebootAction reboot,
-                    bool has_shutdown, ShutdownAction shutdown,
-                    bool has_panic, PanicAction panic,
-                    bool has_watchdog, WatchdogAction watchdog,
-                    Error **errp)
-{
-    if (has_reboot) {
-        reboot_action = reboot;
-    }
-
-    if (has_panic) {
-        panic_action = panic;
-    }
-
-    if (has_watchdog) {
-        qmp_watchdog_set_action(watchdog, errp);
-    }
-
-    /* Process shutdown last, in case the panic action needs to be altered */
-    if (has_shutdown) {
-        shutdown_action = shutdown;
-    }
-}
diff --git a/system/runstate.c b/system/runstate.c
index 5d10ff0df99..a5f16da975e 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -2,6 +2,7 @@
  * QEMU main system emulation loop
  *
  * Copyright (c) 2003-2020 QEMU contributors
+ * Copyright (c) 2020 Oracle and/or its affiliates.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -58,7 +59,6 @@
 #include "system/replay.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "system/runstate-action.h"
 #include "system/confidential-guest-support.h"
 #include "system/system.h"
 #include "system/tpm.h"
@@ -75,6 +75,10 @@ static RunState current_run_state = RUN_STATE_PRELAUNCH;
 static RunState vmstop_requested = RUN_STATE__MAX;
 static QemuMutex vmstop_lock;
 
+static RebootAction reboot_action = REBOOT_ACTION_RESET;
+static ShutdownAction shutdown_action = SHUTDOWN_ACTION_POWEROFF;
+static PanicAction panic_action = PANIC_ACTION_SHUTDOWN;
+
 typedef struct {
     RunState from;
     RunState to;
@@ -277,6 +281,34 @@ StatusInfo *qmp_query_status(Error **errp)
     return info;
 }
 
+/*
+ * Receives actions to be applied for specific guest events
+ * and sets the internal state as requested.
+ */
+void qmp_set_action(bool has_reboot, RebootAction reboot,
+                    bool has_shutdown, ShutdownAction shutdown,
+                    bool has_panic, PanicAction panic,
+                    bool has_watchdog, WatchdogAction watchdog,
+                    Error **errp)
+{
+    if (has_reboot) {
+        reboot_action = reboot;
+    }
+
+    if (has_panic) {
+        panic_action = panic;
+    }
+
+    if (has_watchdog) {
+        qmp_watchdog_set_action(watchdog, errp);
+    }
+
+    /* Process shutdown last, in case the panic action needs to be altered */
+    if (has_shutdown) {
+        shutdown_action = shutdown;
+    }
+}
+
 bool qemu_vmstop_requested(RunState *r)
 {
     qemu_mutex_lock(&vmstop_lock);
diff --git a/system/vl.c b/system/vl.c
index 9bd7664b85c..e1bb105514f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -44,7 +44,6 @@
 #include "qemu/uuid.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "system/runstate-action.h"
 #include "system/seccomp.h"
 #include "system/tcg.h"
 #include "system/xen.h"
@@ -136,6 +135,7 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qapi-commands-ui.h"
 #include "block/qdict.h"
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 5447fb637ad..94bb094ff13 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -37,7 +37,6 @@
 #include "ui/kbd-state.h"
 #include "system/system.h"
 #include "system/runstate.h"
-#include "system/runstate-action.h"
 #include "system/cpu-throttle.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
diff --git a/ui/sdl2.c b/ui/sdl2.c
index d647905a379..72ec8819fb1 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -30,7 +30,6 @@
 #include "ui/input.h"
 #include "ui/sdl2.h"
 #include "system/runstate.h"
-#include "system/runstate-action.h"
 #include "system/system.h"
 #include "qemu/log.h"
 #include "qemu-main.h"
-- 
2.43.0


