Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33BCCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCTP-0001uY-Ug; Tue, 04 Nov 2025 03:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSw-0000eZ-Bs
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSs-0003XM-Py
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGbxK9zq5GxFA12ijW9fLMcAXtmiPZpiixW4WSdcj9I=;
 b=NTzsJk+eihfcBH7MaXzMga4WNwWjaOsoa97O9kmYN1vlbju8DywjQQGVEPiNDY/yOiGxU/
 XLfS/kaEP5Pgdow/88H4vLgdwIZfVRjZrC1acVZCu4tPXFD0xNVGPdGbZNNFT8ex2H1fLP
 ENZH1uT7Mju+jGNQqhD2lxjb/H1Q14Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-Uk4JV9OuM72wX9jGzojxMw-1; Tue,
 04 Nov 2025 03:32:26 -0500
X-MC-Unique: Uk4JV9OuM72wX9jGzojxMw-1
X-Mimecast-MFC-AGG-ID: Uk4JV9OuM72wX9jGzojxMw_1762245146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D671119560B6; Tue,  4 Nov 2025 08:32:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0124E19540DE; Tue,  4 Nov 2025 08:32:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/30] hw/arm/aspeed: Split Palmetto machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:30 +0100
Message-ID: <20251104083144.187806-17-clg@redhat.com>
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

This commit moves the OpenPOWER Palmetto BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2400_palmetto.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future development for
new platforms without cluttering aspeed.c.

Key updates include:
- Moved PALMETTO_BMC_HW_STRAP1 macro definition from into the new file.
- Moved palmetto_bmc_i2c_init() I²C initialization logic into the new file.
- Moved aspeed_machine_palmetto_class_init() and type registration.
- Added aspeed_ast2400_palmetto.c to the build system (meson.build).
- Removed all Palmetto-specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-17-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                  | 60 ------------------------
 hw/arm/aspeed_ast2400_palmetto.c | 80 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build               |  1 +
 3 files changed, 81 insertions(+), 60 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2400_palmetto.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index fbd27020bd2d..15d3b045ac44 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -43,20 +43,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define ASPEED_RAM_SIZE(sz) (sz)
 #endif
 
-/* Palmetto hardware value: 0x120CE416 */
-#define PALMETTO_BMC_HW_STRAP1 (                                        \
-        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
-        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=6, CWL=5 */) | \
-        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
-        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
-        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
-        SCU_HW_STRAP_SPI_WIDTH |                                        \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
@@ -312,30 +298,6 @@ static void aspeed_machine_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
-static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    DeviceState *dev;
-    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
-
-    /*
-     * The palmetto platform expects a ds3231 RTC but a ds1338 is
-     * enough to provide basic RTC features. Alarms will be missing
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
-
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
-                          eeprom_buf);
-
-    /* add a TMP423 temperature sensor */
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
-                                         "tmp423", 0x4c));
-    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
-}
-
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1042,23 +1004,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_props_init(oc);
 }
 
-static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
-                                               const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OpenPOWER Palmetto BMC (ARM926EJ-S)";
-    amc->soc_name  = "ast2400-a1";
-    amc->hw_strap1 = PALMETTO_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q256a";
-    amc->spi_model = "mx25l25635f";
-    amc->num_cs    = 1;
-    amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->default_ram_size       = 256 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1405,11 +1350,6 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
 
 static const TypeInfo aspeed_machine_types[] = {
     {
-        .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_palmetto_class_init,
-        .interfaces    = arm_machine_interfaces,
-    }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
new file mode 100644
index 000000000000..776aa43a45de
--- /dev/null
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -0,0 +1,80 @@
+/*
+ * OpenPOWER Palmetto
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
+
+/* Palmetto hardware value: 0x120CE416 */
+#define PALMETTO_BMC_HW_STRAP1 (                                        \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=6, CWL=5 */) | \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
+static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    DeviceState *dev;
+    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
+
+    /*
+     * The palmetto platform expects a ds3231 RTC but a ds1338 is
+     * enough to provide basic RTC features. Alarms will be missing
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+                          eeprom_buf);
+
+    /* add a TMP423 temperature sensor */
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                                         "tmp423", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
+}
+
+static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Palmetto BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = PALMETTO_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx25l25635f";
+    amc->num_cs    = 1;
+    amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->default_ram_size       = 256 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2400_palmetto_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_palmetto_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2400_palmetto_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ea2d24af88a0..e52901108be2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
+  'aspeed_ast2400_palmetto.c',
   'aspeed_ast2400_quanta-q71l.c',
   'aspeed_ast2400_supermicrox11.c',
   'aspeed_ast2500_evb.c',
-- 
2.51.1


