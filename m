Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1824BCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9g-0001Wc-8K; Thu, 23 Oct 2025 06:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9d-0001UI-TS; Thu, 23 Oct 2025 06:02:46 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9b-0003D7-Th; Thu, 23 Oct 2025 06:02:45 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 11/13] hw/arm/aspeed: Split Romulus machine into a separate
 source file for maintainability
Date: Thu, 23 Oct 2025 18:01:44 +0800
Message-ID: <20251023100150.295370-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
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

This commit moves the Romulus BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2500_romulus.c.

The refactor continues the modularization of Aspeed platform
definitions, separating each board into its own C source file to
improve maintainability, readability, and reduce code clutter in
aspeed.c.

Key updates include:
- Moved ROMULUS_BMC_HW_STRAP1 definition to the new file.
- Moved romulus_bmc_i2c_init() and related I²C device setup.
- Moved aspeed_machine_romulus_class_init() and type registration
to aspeed_ast2500_romulus.c.
- Added the new file to the build system (meson.build).
- Removed all Romulus-specific code from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                 | 42 -----------------------
 hw/arm/aspeed_ast2500_romulus.c | 61 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |  1 +
 3 files changed, 62 insertions(+), 42 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_romulus.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f01d71db8f..a97d037acb 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -91,16 +91,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_MAC0_RGMII) &                                      \
         ~SCU_HW_STRAP_2ND_BOOT_WDT)
 
-/* Romulus hardware value: 0xF10AD206 */
-#define ROMULUS_BMC_HW_STRAP1 (                                         \
-        AST2500_HW_STRAP1_DEFAULTS |                                    \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
-
 /* Quanta-Q71l hardware value */
 #define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
@@ -451,17 +441,6 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
                      TYPE_TMP105, 0x4d);
 }
 
-static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /*
-     * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
-     * good enough
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
-}
-
 void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 {
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
@@ -1242,23 +1221,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_romulus_class_init(ObjectClass *oc,
-                                              const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OpenPOWER Romulus BMC (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = ROMULUS_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q256a";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->default_ram_size       = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1620,10 +1582,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("romulus-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_romulus_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
new file mode 100644
index 0000000000..6902319e37
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -0,0 +1,61 @@
+/*
+ * OpenPOWER Romulus
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+
+/* Romulus hardware value: 0xF10AD206 */
+#define ROMULUS_BMC_HW_STRAP1 (                                         \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
+
+static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /*
+     * The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
+     * good enough
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+}
+
+static void aspeed_machine_romulus_class_init(ObjectClass *oc,
+                                              const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Romulus BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = ROMULUS_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = romulus_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_romulus_types[] = {
+     {
+        .name          = MACHINE_TYPE_NAME("romulus-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_romulus_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_romulus_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 94f8a82f17..fdb825fd0e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -46,6 +46,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2400.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
+  'aspeed_ast2500_romulus.c',
   'aspeed_ast2500_sonorapass.c',
   'aspeed_ast2500_tiogapass.c',
   'aspeed_ast2500_witherspoon.c',
-- 
2.43.0


