Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F0BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 05:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IUo-0003z1-Pn; Wed, 24 Sep 2025 01:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUb-0003SK-2a; Wed, 24 Sep 2025 01:56:42 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUY-0000It-Bg; Wed, 24 Sep 2025 01:56:40 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Sep
 2025 13:56:04 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Sep 2025 13:56:04 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 4/7] hw/arm/aspeed: Move aspeed_load_vbootrom to common SoC
 code
Date: Wed, 24 Sep 2025 13:55:58 +0800
Message-ID: <20250924055602.294857-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the vbootrom loader helper into common SoC code so it can be reused
by all ASPEED boards, and decouple the API from AspeedMachineState.

Specifically:
- Move aspeed_load_vbootrom() to hw/arm/aspeed_soc_common.c and
declare it in include/hw/arm/aspeed_soc.h.
- Change the helper’s signature to take AspeedSoCState * instead of
AspeedMachineState *.
- Update aspeed_machine_init() call sites accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  4 ++++
 hw/arm/aspeed.c             | 31 +------------------------------
 hw/arm/aspeed_soc_common.c  | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index aea210a8e2..ed32efb543 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -43,6 +43,8 @@
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
 
+#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
+
 #define ASPEED_SPIS_NUM  3
 #define ASPEED_EHCIS_NUM 4
 #define ASPEED_WDTS_NUM  8
@@ -316,6 +318,8 @@ void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
                            Error **errp);
 void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
                              MemoryRegion *boot_rom, uint64_t rom_size);
+void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
+                          Error **errp);
 
 static inline int aspeed_uart_index(int uart_dev)
 {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 429f4c6d77..6046ec0bb2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -26,9 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "system/block-backend.h"
 #include "system/reset.h"
-#include "hw/loader.h"
 #include "qemu/error-report.h"
-#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
 #include "system/system.h"
@@ -263,33 +261,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
-
-/*
- * This function locates the vbootrom image file specified via the command line
- * using the -bios option. It loads the specified image into the vbootrom
- * memory region and handles errors if the file cannot be found or loaded.
- */
-static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
-                                 Error **errp)
-{
-    g_autofree char *filename = NULL;
-    AspeedSoCState *soc = bmc->soc;
-    int ret;
-
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (!filename) {
-        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
-        return;
-    }
-
-    ret = load_image_mr(filename, &soc->vbootrom);
-    if (ret < 0) {
-        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
-        return;
-    }
-}
-
 static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
                                bool boot_emmc)
 {
@@ -451,7 +422,7 @@ static void aspeed_machine_init(MachineState *machine)
 
     if (amc->vbootrom) {
         bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
-        aspeed_load_vbootrom(bmc, bios_name, &error_abort);
+        aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
     }
 
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 7f104f8de5..bc70e864fb 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -19,6 +19,7 @@
 #include "system/blockdev.h"
 #include "system/block-backend.h"
 #include "hw/loader.h"
+#include "qemu/datadir.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
@@ -195,6 +196,30 @@ void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
                           &error_abort);
 }
 
+/*
+ * This function locates the vbootrom image file specified via the command line
+ * using the -bios option. It loads the specified image into the vbootrom
+ * memory region and handles errors if the file cannot be found or loaded.
+ */
+void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
+                          Error **errp)
+{
+    g_autofree char *filename = NULL;
+    int ret;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
+        return;
+    }
+
+    ret = load_image_mr(filename, &soc->vbootrom);
+    if (ret < 0) {
+        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
+        return;
+    }
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.43.0


