Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A109ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7V1-0002bI-08; Mon, 03 Nov 2025 22:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7UT-0002Tz-Oe; Mon, 03 Nov 2025 22:13:50 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7UQ-00031V-HF; Mon, 03 Nov 2025 22:13:49 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:28 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v4 05/30] hw/arm/aspeed: Split FP5280G2 machine into a
 separate source file for maintenance
Date: Tue, 4 Nov 2025 11:12:43 +0800
Message-ID: <20251104031325.146374-6-jamin_lin@aspeedtech.com>
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

This commit moves the FP5280G2 BMC machine implementation from
aspeed.c into a new standalone file aspeed_ast2500_fp5280g2.c.

The change improves code organization and prepares the Aspeed
machine framework for future expansion and easier maintenance.

Key updates include:
- Moved fp5280g2_bmc_i2c_init() and related machine class init
functions into aspeed_ast2500_fp5280g2.c.
- Added new file to hw/arm/meson.build for compilation.
- Removed obsolete FP5280G2 definitions from aspeed.c

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                  | 66 -----------------------
 hw/arm/aspeed_ast2500_fp5280g2.c | 89 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build               |  1 +
 3 files changed, 90 insertions(+), 66 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 59416eb5ae..3dcd5fc540 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -131,21 +131,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
         SCU_AST2500_HW_STRAP_RESERVED1)
 
-/* FP5280G2 hardware value: 0XF100D286 */
-#define FP5280G2_BMC_HW_STRAP1 (                                      \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
-        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
-        SCU_HW_STRAP_MAC1_RGMII |                                       \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2500_HW_STRAP_RESERVED1)
-
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -686,33 +671,6 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 }
 
-static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CSlave *i2c_mux;
-
-    /* The at24c256 */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
-
-    /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
-                     0x49);
-
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                     "pca9546", 0x70);
-    /* It expects a TMP112 but a TMP105 is compatible */
-    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
-                     0x4a);
-
-    /* It expects a ds3232 but a ds1338 is good enough */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
-
-    /* It expects a pca9555 but a pca9552 is compatible */
-    aspeed_create_pca9552(soc, 8, 0x30);
-}
-
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1608,25 +1566,6 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
-                                               const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
-    mc->deprecation_reason = "use 'ast2500-evb' instead";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 2;
-    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
-    amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->default_ram_size = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2015,11 +1954,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_fp5280g2_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_fp5280g2.c b/hw/arm/aspeed_ast2500_fp5280g2.c
new file mode 100644
index 0000000000..7952d677ac
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_fp5280g2.c
@@ -0,0 +1,89 @@
+/*
+ * Inspur FP5280G2
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
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/sensor/tmp105.h"
+
+/* FP5280G2 hardware value: 0XF100D286 */
+#define FP5280G2_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_MAC1_RGMII |                                       \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
+static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CSlave *i2c_mux;
+
+    /* The at24c256 */
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x50, 32768);
+
+    /* The fp5280g2 expects a TMP112 but a TMP105 is compatible */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), TYPE_TMP105,
+                     0x49);
+
+    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                     "pca9546", 0x70);
+    /* It expects a TMP112 but a TMP105 is compatible */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0), TYPE_TMP105,
+                     0x4a);
+
+    /* It expects a ds3232 but a ds1338 is good enough */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "ds1338", 0x68);
+
+    /* It expects a pca9555 but a pca9552 is compatible */
+    aspeed_create_pca9552(soc, 8, 0x30);
+}
+
+static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
+    mc->deprecation_reason = "use 'ast2500-evb' instead";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q512a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = fp5280g2_bmc_i2c_init;
+    mc->default_ram_size = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_fp5280g2_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("fp5280g2-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_fp5280g2_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_fp5280g2_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 61c66ee2d0..ed637f2687 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
+  'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
-- 
2.43.0


