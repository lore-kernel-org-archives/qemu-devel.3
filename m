Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E14CCFA05
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 03:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG7V4-0002dz-5C; Mon, 03 Nov 2025 22:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Uj-0002WW-SD; Mon, 03 Nov 2025 22:14:11 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vG7Ud-00034Q-Qe; Mon, 03 Nov 2025 22:14:03 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 4 Nov
 2025 11:13:31 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 4 Nov 2025 11:13:31 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v4 09/30] hw/arm/aspeed: Split Witherspoon machine into a
 separate source file for maintainability
Date: Tue, 4 Nov 2025 11:12:47 +0800
Message-ID: <20251104031325.146374-10-jamin_lin@aspeedtech.com>
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

This commit moves the Witherspoon BMC machine implementation out of
aspeed.c and into a new dedicated file aspeed_ast2500_witherspoon.c.

To support splitting Witherspoon into a dedicated source file,
a new WITHERSPOON_BMC_HW_STRAP1 macro is added as a copy of
ROMULUS_BMC_HW_STRAP1.

The change is part of a broader effort to modularize Aspeed board
definitions, allowing each machine type to be maintained and updated
independently. By isolating Witherspoon logic, the aspeed.c file
becomes cleaner and easier to manage as more platforms are added.

Key updates include:

- Moved witherspoon_bmc_i2c_init() and related LED setup code into
aspeed_ast2500_witherspoon.c.
- Added WITHERSPOON_BMC_HW_STRAP1 replacement macro for local use.
- Removed aspeed_machine_witherspoon_class_init() and type
registration from aspeed.c.
- Added the new file to meson.build for compilation.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                     |  82 --------------------
 hw/arm/aspeed_ast2500_witherspoon.c | 113 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   1 +
 3 files changed, 114 insertions(+), 82 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 731ca7a1aa..74eb8077da 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -117,9 +117,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2500_HW_STRAP_RESERVED1)
 
-/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
-#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
-
 /* Quanta-Q71l hardware value */
 #define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
@@ -537,63 +534,6 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 
 }
 
-static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    static const struct {
-        unsigned gpio_id;
-        LEDColor color;
-        const char *description;
-        bool gpio_polarity;
-    } pca1_leds[] = {
-        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
-        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
-        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
-    };
-    AspeedSoCState *soc = bmc->soc;
-    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
-    DeviceState *dev;
-    LEDState *led;
-
-    /* Bus 3: TODO bmp280@77 */
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
-    qdev_prop_set_string(dev, "description", "pca1");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 3),
-                                &error_fatal);
-
-    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
-        led = led_create_simple(OBJECT(bmc),
-                                pca1_leds[i].gpio_polarity,
-                                pca1_leds[i].color,
-                                pca1_leds[i].description);
-        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
-                              qdev_get_gpio_in(DEVICE(led), 0));
-    }
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
-
-    /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
-                     0x4a);
-
-    /*
-     * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
-     * good enough
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
-
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
-                          eeprom_buf);
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
-    qdev_prop_set_string(dev, "description", "pca0");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 11),
-                                &error_fatal);
-    /* Bus 11: TODO ucd90160@64 */
-}
-
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1397,23 +1337,6 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
-    amc->fmc_model = "mx25l25635f";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->default_ram_size = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1789,11 +1712,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_witherspoon_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
new file mode 100644
index 0000000000..52f7ced70a
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -0,0 +1,113 @@
+/*
+ * OpenPOWER Witherspoon
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
+#include "hw/misc/led.h"
+#include "hw/sensor/tmp105.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "hw/gpio/pca9552.h"
+
+/* Witherspoon hardware value: 0xF10AD216 */
+#define WITHERSPOON_BMC_HW_STRAP1 (                                     \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
+
+static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    static const struct {
+        unsigned gpio_id;
+        LEDColor color;
+        const char *description;
+        bool gpio_polarity;
+    } pca1_leds[] = {
+        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
+        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
+        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
+    };
+    AspeedSoCState *soc = bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+    DeviceState *dev;
+    LEDState *led;
+
+    /* Bus 3: TODO bmp280@77 */
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    qdev_prop_set_string(dev, "description", "pca1");
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 3),
+                                &error_fatal);
+
+    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
+        led = led_create_simple(OBJECT(bmc),
+                                pca1_leds[i].gpio_polarity,
+                                pca1_leds[i].color,
+                                pca1_leds[i].description);
+        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
+                              qdev_get_gpio_in(DEVICE(led), 0));
+    }
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+
+    /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
+                     0x4a);
+
+    /*
+     * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
+     * good enough
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
+                          eeprom_buf);
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    qdev_prop_set_string(dev, "description", "pca0");
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 11),
+                                &error_fatal);
+    /* Bus 11: TODO ucd90160@64 */
+}
+
+static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635f";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = witherspoon_bmc_i2c_init;
+    mc->default_ram_size = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_witherspoon_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_witherspoon_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8d9f1e1609..c235c8aed3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -47,6 +47,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_tiogapass.c',
+  'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
-- 
2.43.0


