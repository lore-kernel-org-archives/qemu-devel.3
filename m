Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AF5D1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38BJ-0005pQ-DE; Tue, 22 Oct 2024 02:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38BI-0005oN-5S; Tue, 22 Oct 2024 02:15:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t38BG-0001uo-5r; Tue, 22 Oct 2024 02:15:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0F6E9ACA4;
 Tue, 22 Oct 2024 09:15:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CE6C9159B66;
 Tue, 22 Oct 2024 09:15:33 +0300 (MSK)
Received: (nullmailer pid 1304533 invoked by uid 1000);
 Tue, 22 Oct 2024 06:15:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Tudor Gheorghiu <tudor.reda@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 5/5] replace error_setg(&error_fatal, ...) with error_report()
Date: Tue, 22 Oct 2024 09:15:33 +0300
Message-Id: <20241022061533.1304493-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022061533.1304493-1-mjt@tls.msk.ru>
References: <20241022061533.1304493-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Tudor Gheorghiu <tudor.reda@gmail.com>

According to include/qapi/error.h:
* Please don't error_setg(&error_fatal, ...), use error_report() and
* exit(), because that's more obvious.

Patch updates all instances of error_setg(&error_fatal, ...) with
error_report(...), adds the explicit exit(1) and removes redundant
return statements.

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2587
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: also fold __func__ to previous line)
---
 hw/arm/allwinner-a10.c    | 6 +++---
 hw/arm/allwinner-h3.c     | 5 ++---
 hw/arm/allwinner-r40.c    | 5 ++---
 hw/arm/xlnx-versal-virt.c | 4 ++--
 hw/audio/soundhw.c        | 3 ++-
 system/vl.c               | 3 ++-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 9eb1aa7366..52327d9210 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/char/serial-mm.h"
 #include "hw/sysbus.h"
@@ -50,9 +51,8 @@ void allwinner_a10_bootrom_setup(AwA10State *s, BlockBackend *blk)
     g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
-                   __func__);
-        return;
+        error_report("%s: failed to read BlockBackend data", __func__);
+        exit(1);
     }
 
     rom_add_blob("allwinner-a10.bootrom", buffer, rom_size,
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 9bc57cd266..fd7638dbe8 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -182,9 +182,8 @@ void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
     g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
-                   __func__);
-        return;
+        error_report("%s: failed to read BlockBackend data", __func__);
+        exit(1);
     }
 
     rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index ced73009d6..c6f7cab1da 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -231,9 +231,8 @@ bool allwinner_r40_bootrom_setup(AwR40State *s, BlockBackend *blk, int unit)
     struct boot_file_head *head = (struct boot_file_head *)buffer;
 
     if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
-        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
-                   __func__);
-        return false;
+        error_report("%s: failed to read BlockBackend data", __func__);
+        exit(1);
     }
 
     /* we only check the magic string here. */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 962f98fee2..8b12d3e7cb 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -761,9 +761,9 @@ static void versal_virt_init(MachineState *machine)
             if (!flash_klass ||
                 object_class_is_abstract(flash_klass) ||
                 !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
-                error_setg(&error_fatal, "'%s' is either abstract or"
+                error_report("'%s' is either abstract or"
                        " not a subtype of m25p80", s->ospi_model);
-                return;
+                exit(1);
             }
         }
 
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index b387b0ef7d..d18fd9fa05 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -88,7 +88,8 @@ void select_soundhw(const char *name, const char *audiodev)
     struct soundhw *c;
 
     if (selected) {
-        error_setg(&error_fatal, "only one -soundhw option is allowed");
+        error_report("only one -soundhw option is allowed");
+        exit(1);
     }
 
     for (c = soundhw; c->name; ++c) {
diff --git a/system/vl.c b/system/vl.c
index e83b3b2608..d217b3d64d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1841,7 +1841,8 @@ static void object_option_parse(const char *str)
 
         type = qemu_opt_get(opts, "qom-type");
         if (!type) {
-            error_setg(&error_fatal, QERR_MISSING_PARAMETER, "qom-type");
+            error_report(QERR_MISSING_PARAMETER, "qom-type");
+            exit(1);
         }
         if (user_creatable_print_help(type, opts)) {
             exit(0);
-- 
2.39.5


