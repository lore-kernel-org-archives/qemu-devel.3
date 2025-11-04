Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08BCCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7XG-0000KR-Ve; Mon, 03 Nov 2025 22:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Wf-0007rE-R1; Mon, 03 Nov 2025 22:16:06 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Wa-0004m7-5d; Mon, 03 Nov 2025 22:16:05 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:43 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v4 27/30] hw/arm/aspeed: Split AST2600 EVB machine into a
 separate source file for maintainability
Date: Tue, 4 Nov 2025 11:13:05 +0800
Message-ID: <20251104031325.146374-28-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
References: <20251104031325.146374-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

This commit moves the Aspeed AST2600 EVB machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_evb.c.

This refactor continues the modularization effort of the Aspeed platform
machine definitions, separating each board’s initialization logic into its
own dedicated source file. It improves code maintainability, readability,
and reduces clutter in aspeed.c, simplifying future platform extensions.

Key updates include:
- Moved AST2600_EVB_HW_STRAP1 and AST2600_EVB_HW_STRAP2 macro definitions
  into the new aspeed_ast2600_evb.c file.
- Moved ast2600_evb_i2c_init() and related device initialization code into
  the new aspeed_ast2600_evb.c file.
- Moved aspeed_machine_ast2600_evb_class_init() and type registration logic
  out of aspeed.c.
- Added aspeed_ast2600_evb.c to the Meson build system (meson.build).
- Cleaned up all AST2600 EVB-specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             | 44 -------------------------
 hw/arm/aspeed_ast2600_evb.c | 66 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  1 +
 3 files changed, 67 insertions(+), 44 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ad3bb8cbac..ce3610ce5a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -33,10 +33,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-/* AST2600 evb hardware value */
-#define AST2600_EVB_HW_STRAP1 0x000000C0
-#define AST2600_EVB_HW_STRAP2 0x00000003
-
 #ifdef TARGET_AARCH64
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
@@ -268,19 +264,6 @@ static void aspeed_machine_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
-static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
-
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
-                          eeprom_buf);
-
-    /* LM75 is compatible with TMP105 driver */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
-                     TYPE_TMP105, 0x4d);
-}
-
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 {
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
@@ -449,28 +432,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_props_init(oc);
 }
 
-static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Aspeed AST2600 EVB (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
-    amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
-    amc->fmc_model = "w25q512jv";
-    amc->spi_model = "w25q512jv";
-    amc->num_cs    = 1;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON |
-                     ASPEED_MAC3_ON;
-    amc->sdhci_wp_inverted = true;
-    amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-    aspeed_machine_ast2600_class_emmc_init(oc);
-};
-
 #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
 /* Main SYSCLK frequency in Hz (200MHz) */
 #define SYSCLK_FRQ 200000000ULL
@@ -607,11 +568,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
 
 static const TypeInfo aspeed_machine_types[] = {
     {
-        .name          = MACHINE_TYPE_NAME("ast2600-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2600_evb_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }, {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
new file mode 100644
index 0000000000..54173e24e7
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -0,0 +1,66 @@
+/*
+ * ASPEED AST2600 EVB
+ *
+ * Copyright 2016 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/machines-qom.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "hw/sensor/tmp105.h"
+
+/* AST2600 evb hardware value */
+#define AST2600_EVB_HW_STRAP1 0x000000C0
+#define AST2600_EVB_HW_STRAP2 0x00000003
+
+static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
+                          eeprom_buf);
+
+    /* LM75 is compatible with TMP105 driver */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8),
+                     TYPE_TMP105, 0x4d);
+}
+
+static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Aspeed AST2600 EVB (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = AST2600_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2600_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q512jv";
+    amc->spi_model = "w25q512jv";
+    amc->num_cs    = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON |
+                     ASPEED_MAC3_ON;
+    amc->sdhci_wp_inverted = true;
+    amc->i2c_init  = ast2600_evb_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+};
+
+static const TypeInfo aspeed_ast2600_evb_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("ast2600-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_evb_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 6b79517ec9..dc7cde4bc1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600.c',
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_catalina.c',
+  'aspeed_ast2600_evb.c',
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
-- 
2.43.0


