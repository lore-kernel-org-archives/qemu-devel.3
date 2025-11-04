Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53175CCFA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCSa-0000Ss-Rr; Tue, 04 Nov 2025 03:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSX-0000S3-NF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSU-0003R4-Az
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMPTLEvCndFw94CWkZNCn1Y7IntPSYyFo4J60Z/rGXk=;
 b=HYqv9OD1HaVMRWJK/P9/MHlGwgxGRuLCpB8DAmdMbRjEKVU+Zxce+vXsvycFM7g2MJnkn4
 vJHxx8yr0nscsLN6CwYJIp1ASMOdDRGoPGHQo6HmHA6010zDYeO/ki82zluXIoJ5UeJ7cA
 9qfojp5UhCY+eQsPJQzXDzfQQPU7VZo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-dS3zAaxrODuHVVfAR5qXKw-1; Tue,
 04 Nov 2025 03:32:01 -0500
X-MC-Unique: dS3zAaxrODuHVVfAR5qXKw-1
X-Mimecast-MFC-AGG-ID: dS3zAaxrODuHVVfAR5qXKw_1762245120
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B5619560AD; Tue,  4 Nov 2025 08:32:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFDB019560A2; Tue,  4 Nov 2025 08:31:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/30] hw/arm/aspeed: Split FP5280G2 machine into a separate
 source file for maintenance
Date: Tue,  4 Nov 2025 09:31:19 +0100
Message-ID: <20251104083144.187806-6-clg@redhat.com>
In-Reply-To: <20251104083144.187806-1-clg@redhat.com>
References: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                  | 66 ------------------------
 hw/arm/aspeed_ast2500_fp5280g2.c | 88 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build               |  1 +
 3 files changed, 89 insertions(+), 66 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 59416eb5ae6c..3dcd5fc54040 100644
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
index 000000000000..858e0388714b
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_fp5280g2.c
@@ -0,0 +1,88 @@
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
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 61c66ee2d0bc..ed637f268725 100644
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
2.51.1


