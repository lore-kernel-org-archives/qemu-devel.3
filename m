Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C122BCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9c-0001Rz-HN; Thu, 23 Oct 2025 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9b-0001RY-2X; Thu, 23 Oct 2025 06:02:43 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9Y-0003D7-Sj; Thu, 23 Oct 2025 06:02:42 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 10/13] hw/arm/aspeed: Split Sonorapass machine into a
 separate source file for maintainability
Date: Thu, 23 Oct 2025 18:01:43 +0800
Message-ID: <20251023100150.295370-11-jamin_lin@aspeedtech.com>
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

This commit moves the Sonorapass BMC machine implementation out of
aspeed.c and into a new standalone file aspeed_ast2500_sonorapass.c.

The refactor continues the effort to modularize Aspeed platform support
by separating each board’s implementation into its own source file.
This improves maintainability, readability, and simplifies future
updates to individual machine configurations.

Key updates include:
- Moved SONORAPASS_BMC_HW_STRAP1 definition into the new file.
- Moved sonorapass_bmc_i2c_init() and all I²C device initialization
logic from aspeed.c into aspeed_ast2500_sonorapass.c.
- Moved aspeed_machine_sonorapass_class_init() and type registration
into the new file.
- Added the new file to the build system (meson.build).
- Removed all Sonorapass-specific code and definitions from aspeed.c

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                    |  81 -----------------------
 hw/arm/aspeed_ast2500_sonorapass.c | 101 +++++++++++++++++++++++++++++
 hw/arm/meson.build                 |   1 +
 3 files changed, 102 insertions(+), 81 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 91d59e0d2d..f01d71db8f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -101,21 +101,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
         SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
 
-/* Sonorapass hardware value: 0xF100D216 */
-#define SONORAPASS_BMC_HW_STRAP1 (                                      \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
-        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
-        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2500_HW_STRAP_RESERVED1)
-
 /* Quanta-Q71l hardware value */
 #define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
@@ -489,50 +474,6 @@ I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9554, addr);
 }
 
-static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /* bus 2 : */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
-    /* bus 2 : pca9546 @ 0x73 */
-
-    /* bus 3 : pca9548 @ 0x70 */
-
-    /* bus 4 : */
-    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
-                          eeprom4_54);
-    /* PCA9539 @ 0x76, but PCA9552 is compatible */
-    create_pca9552(soc, 4, 0x76);
-    /* PCA9539 @ 0x77, but PCA9552 is compatible */
-    create_pca9552(soc, 4, 0x77);
-
-    /* bus 6 : */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
-    /* bus 6 : pca9546 @ 0x73 */
-
-    /* bus 8 : */
-    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
-                          eeprom8_56);
-    create_pca9552(soc, 8, 0x60);
-    create_pca9552(soc, 8, 0x61);
-    /* bus 8 : adc128d818 @ 0x1d */
-    /* bus 8 : adc128d818 @ 0x1f */
-
-    /*
-     * bus 13 : pca9548 @ 0x71
-     *      - channel 3:
-     *          - tmm421 @ 0x4c
-     *          - tmp421 @ 0x4e
-     *          - tmp421 @ 0x4f
-     */
-
-}
-
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1318,24 +1259,6 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
-                                                 const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
-    mc->deprecation_reason = "use 'ast2500-evb' instead";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
-    amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->default_ram_size       = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1701,10 +1624,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_sonorapass_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_sonorapass.c b/hw/arm/aspeed_ast2500_sonorapass.c
new file mode 100644
index 0000000000..6c7f2da5cc
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_sonorapass.c
@@ -0,0 +1,101 @@
+/*
+ * OCP SonoraPass
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
+#include "hw/i2c/smbus_eeprom.h"
+
+/* Sonorapass hardware value: 0xF100D216 */
+#define SONORAPASS_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_BIOS_ROM |                                     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
+static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /* bus 2 : */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
+    /* bus 2 : pca9546 @ 0x73 */
+
+    /* bus 3 : pca9548 @ 0x70 */
+
+    /* bus 4 : */
+    uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
+                          eeprom4_54);
+    /* PCA9539 @ 0x76, but PCA9552 is compatible */
+    create_pca9552(soc, 4, 0x76);
+    /* PCA9539 @ 0x77, but PCA9552 is compatible */
+    create_pca9552(soc, 4, 0x77);
+
+    /* bus 6 : */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
+    /* bus 6 : pca9546 @ 0x73 */
+
+    /* bus 8 : */
+    uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
+                          eeprom8_56);
+    create_pca9552(soc, 8, 0x60);
+    create_pca9552(soc, 8, 0x61);
+    /* bus 8 : adc128d818 @ 0x1d */
+    /* bus 8 : adc128d818 @ 0x1f */
+
+    /*
+     * bus 13 : pca9548 @ 0x71
+     *      - channel 3:
+     *          - tmm421 @ 0x4c
+     *          - tmp421 @ 0x4e
+     *          - tmp421 @ 0x4f
+     */
+
+}
+
+static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
+                                                 const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OCP SonoraPass BMC (ARM1176)";
+    mc->deprecation_reason = "use 'ast2500-evb' instead";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = sonorapass_bmc_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_sonorapass_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sonorapass_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_sonorapass_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d3726d1b9d..94f8a82f17 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -46,6 +46,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2400.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
+  'aspeed_ast2500_sonorapass.c',
   'aspeed_ast2500_tiogapass.c',
   'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
-- 
2.43.0


