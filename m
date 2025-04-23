Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EADFC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UTI-0002gW-2p; Wed, 23 Apr 2025 03:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7UTF-0002fF-5A; Wed, 23 Apr 2025 03:24:37 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7UTD-0001IR-HM; Wed, 23 Apr 2025 03:24:36 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Apr
 2025 15:23:52 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 23 Apr 2025 15:23:52 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v5 06/11] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Date: Wed, 23 Apr 2025 15:23:42 +0800
Message-ID: <20250423072350.541742-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce "aspeed_load_vbootrom()" to support loading a virtual boot ROM image
into the vbootrom memory region, using the "-bios" command-line option.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index b70a120e62..b5831ef4c1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -27,6 +27,7 @@
 #include "system/reset.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
+#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "hw/qdev-clock.h"
 #include "system/system.h"
@@ -305,6 +306,35 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                    rom_size, &error_abort);
 }
 
+#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
+
+/*
+ * This function locates the vbootrom image file specified via the command line
+ * using the -bios option. It loads the specified image into the vbootrom
+ * memory region and handles errors if the file cannot be found or loaded.
+ */
+static void aspeed_load_vbootrom(MachineState *machine, uint64_t rom_size,
+                                 Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(machine);
+    const char *bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
+    g_autofree char *filename = NULL;
+    AspeedSoCState *soc = bmc->soc;
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
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
                                       unsigned int count, int unit0)
 {
@@ -483,6 +513,11 @@ static void aspeed_machine_init(MachineState *machine)
         }
     }
 
+    if (amc->vbootrom) {
+        rom_size = memory_region_size(&bmc->soc->vbootrom);
+        aspeed_load_vbootrom(machine, rom_size, &error_abort);
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
-- 
2.43.0


