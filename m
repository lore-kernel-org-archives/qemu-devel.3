Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F05E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVlP-0003cH-CB; Wed, 11 Dec 2024 18:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlM-0003au-Nn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:05:01 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLVlK-0002Oc-Vb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:05:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:5829:0:640:f281:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A05E96145B;
 Thu, 12 Dec 2024 02:04:57 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:1227::1:8])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b4xnrS4GamI0-aTQBHnXU; Thu, 12 Dec 2024 02:04:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733958297;
 bh=Vid9eybyfHkBbtn2DvtJa1fgolplJfizmxOi8mOdV4s=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VUaXkpQuwgitdxYTmK62r2fe/46rjucr3JbG2UgPUm+jpAKYWZcT/faFRRNxsIusT
 qPWYMgIjTt3hQ7X6CppdOB34UiIEyHkddz1tnrGQhnfXSTCfcBpCYVbtnrTb0J8/HW
 C7Pht/9qfThgX35D5XA6xtDlLVpXbP1MVDY2BPmk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] sysemu: introduce a new MlockState enum
Date: Thu, 12 Dec 2024 02:04:32 +0300
Message-Id: <20241211230433.1371327-4-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Replace the boolean value enable_mlock with an enum and add a helper to
decide whether we should be calling os_mlock.

This is a stepping stone towards introducing a new mlock mode, which
will be the third possible state of this enum.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/virtio-mem.c   |  2 +-
 include/sysemu/sysemu.h  | 10 +++++++++-
 migration/postcopy-ram.c |  2 +-
 system/globals.c         |  7 ++++++-
 system/vl.c              |  9 +++++++--
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 80ada89551..78d27eb141 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -988,7 +988,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         error_setg(errp, "Incompatible with mlock");
         return;
     }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 7ec419ce13..f1c9895057 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -43,10 +43,18 @@ extern int display_opengl;
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
index 36ec6a3d75..a6a26a9cbb 100644
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
index 84ce943ac9..c6452d4a0d 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -31,10 +31,15 @@
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 
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
index f0b3ad0df7..a41306ac84 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -792,7 +792,7 @@ static QemuOptsList qemu_run_with_opts = {
 
 static void realtime_init(void)
 {
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         if (os_mlock(false) < 0) {
             error_report("locking memory failed");
             exit(1);
@@ -1858,13 +1858,18 @@ static void object_option_parse(const char *str)
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


