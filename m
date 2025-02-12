Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA7EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDuC-000293-Hw; Wed, 12 Feb 2025 09:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu7-00027f-BM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:55 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu4-000811-Ut
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:54 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 69ABB6117D;
 Wed, 12 Feb 2025 17:39:51 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ddQHZB0Id8c0-6ZYBEN7u; Wed, 12 Feb 2025 17:39:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739371190;
 bh=LHVJkeRgJzCWlwQJpNDZyKo0KBJKb/s9XQXyF5ZbvLA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pF7YDQLURKsMuOAryQKWU8UAEX0tY74/qO0u15kipoLw0e/ypMyEvbVRonuYd+uOb
 xjhV18S8pmcNJhY6U8vq8FJPCQf0k0zH62dO7T/NH4qn+vSfodEKDGuJYph1WS1xYe
 BRH3Ml1wrS+trWV8YXeLeZJ4msWZZTViBboCyyBg=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 3/4] system: introduce a new MlockState enum
Date: Wed, 12 Feb 2025 17:39:19 +0300
Message-Id: <20250212143920.1269754-4-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the boolean value enable_mlock with an enum and add a helper to
decide whether we should be calling os_mlock.

This is a stepping stone towards introducing a new mlock mode, which
will be the third possible state of this enum.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/virtio-mem.c   |  2 +-
 include/system/system.h  | 10 +++++++++-
 migration/postcopy-ram.c |  2 +-
 system/globals.c         |  7 ++++++-
 system/vl.c              |  9 +++++++--
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b1a003736b..7b140add76 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -991,7 +991,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         error_setg(errp, "Incompatible with mlock");
         return;
     }
diff --git a/include/system/system.h b/include/system/system.h
index 0cbb43ec30..dc7628357a 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -44,10 +44,18 @@ extern int display_opengl;
 extern const char *keyboard_layout;
 extern int old_param;
 extern uint8_t *boot_splash_filedata;
-extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
 
+typedef enum {
+    MLOCK_OFF = 0,
+    MLOCK_ON,
+} MlockState;
+
+bool should_mlock(MlockState);
+
+extern MlockState mlock_state;
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fc4d8a10df..04068ee039 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -651,7 +651,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_fault_thread = false;
     }
 
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         if (os_mlock(false) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
diff --git a/system/globals.c b/system/globals.c
index 4867c93ca6..adeff38348 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -31,10 +31,15 @@
 #include "system/cpus.h"
 #include "system/system.h"
 
+bool should_mlock(MlockState state)
+{
+    return state == MLOCK_ON;
+}
+
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout;
-bool enable_mlock;
+MlockState mlock_state;
 bool enable_cpu_pm;
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
diff --git a/system/vl.c b/system/vl.c
index 72a40985f5..2895824c1a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -796,7 +796,7 @@ static QemuOptsList qemu_run_with_opts = {
 
 static void realtime_init(void)
 {
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         if (os_mlock(false) < 0) {
             error_report("locking memory failed");
             exit(1);
@@ -1878,13 +1878,18 @@ static void object_option_parse(const char *str)
 static void overcommit_parse(const char *str)
 {
     QemuOpts *opts;
+    bool enable_mlock;
 
     opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
                                    str, false);
     if (!opts) {
         exit(1);
     }
-    enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
+
+    enable_mlock = qemu_opt_get_bool(opts, "mem-lock",
+                                     should_mlock(mlock_state));
+    mlock_state = enable_mlock ? MLOCK_ON : MLOCK_OFF;
+
     enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
 }
 
-- 
2.34.1


