Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F4CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCT5-0000uD-3I; Tue, 04 Nov 2025 03:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSg-0000W0-LT
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSe-0003TQ-3j
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8RTifue5xReHeqWdEHm2SbiFv8tc6LgLyPGi6xDiaFA=;
 b=jTU933TTTHp4h2VJGo0P75/wgxz2hBgOq2+z00wODfocik7LLi2c2deGT9uBtcjIshpP8W
 S7EoV2iQDhTZB4RhzO8Ul/MENpt2X927BN/xmAfIN73WZiiBrO+OZVLUkFJ6DqDFfpRa+o
 Gs6QTxG/yWi4wZu4UfQ8rq5CHRZEK7E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-QqUJycJrNvav6lbTz1MHhg-1; Tue,
 04 Nov 2025 03:32:10 -0500
X-MC-Unique: QqUJycJrNvav6lbTz1MHhg-1
X-Mimecast-MFC-AGG-ID: QqUJycJrNvav6lbTz1MHhg_1762245129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7175F180034C; Tue,  4 Nov 2025 08:32:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA9EA19560A2; Tue,  4 Nov 2025 08:32:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/30] hw/arm/aspeed: Split Witherspoon machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:23 +0100
Message-ID: <20251104083144.187806-10-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

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
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                     |  82 --------------------
 hw/arm/aspeed_ast2500_witherspoon.c | 112 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   1 +
 3 files changed, 113 insertions(+), 82 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 731ca7a1aa59..74eb8077da7d 100644
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
index 000000000000..28d437fec086
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -0,0 +1,112 @@
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
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8d9f1e160908..c235c8aed34d 100644
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
2.51.1


