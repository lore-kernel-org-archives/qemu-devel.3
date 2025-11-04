Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52750CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCTD-000176-6d; Tue, 04 Nov 2025 03:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSt-0000Ze-5k
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSq-0003WM-Vl
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tp8yEqgHCkGvsq0EA6sImb2lx2K+JuV7eVs2Qydr6NM=;
 b=UtbJKndgGoSVpdtlTT25bXgwKQgCj6gR+0oJhRTolBAkAF3YPwyWYqLXPpU6HZB/QtAkSq
 iQUXBCJ/UAw50reZB8kYMOtbKSodnxz0xphNOKT81R0JCM982TtOxhZGl0LhX9FtDlRbTp
 KZ0C/CxwfMU5rSGlZMUQSUOhIciBEQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-Tfgj1b-7OdCDoPo8uVQMOw-1; Tue,
 04 Nov 2025 03:32:21 -0500
X-MC-Unique: Tfgj1b-7OdCDoPo8uVQMOw-1
X-Mimecast-MFC-AGG-ID: Tfgj1b-7OdCDoPo8uVQMOw_1762245140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F52F195606F; Tue,  4 Nov 2025 08:32:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C54DF19560B2; Tue,  4 Nov 2025 08:32:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/30] hw/arm/aspeed: Split Quanta-Q71L machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:28 +0100
Message-ID: <20251104083144.187806-15-clg@redhat.com>
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

This commit moves the Quanta-Q71L BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2400_quanta-q71l.c.

This refactor continues the modularization effort for Aspeed platform
support, placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future
development for new platforms without cluttering aspeed.c

Key updates include:

- Moved QUANTA_Q71L_BMC_HW_STRAP1 macro definition into the new file.
- Moved quanta_q71l_bmc_i2c_init() I²C initialization logic into the new file.
- Moved aspeed_machine_quanta_q71l_class_init() and type registration.
- Added aspeed_ast2400_quanta-q71l.c to the build system (meson.build).
- Removed all Quanta-Q71L–specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                     | 67 ----------------------
 hw/arm/aspeed_ast2400_quanta-q71l.c | 86 +++++++++++++++++++++++++++++
 hw/arm/meson.build                  |  1 +
 3 files changed, 87 insertions(+), 67 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7d26d9241cb2..f9e6d8c4c6dc 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -71,19 +71,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
-/* Quanta-Q71l hardware value */
-#define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
-        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
-        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2/* DDR3 with CL=6, CWL=5 */) | \
-        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
-        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_24M_IN) |       \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_PASS_THROUGH) |          \
-        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
-        SCU_HW_STRAP_SPI_WIDTH |                                        \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_8M_DRAM) |                        \
-        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
@@ -363,38 +350,6 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
     object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
 }
 
-static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-
-    /*
-     * The quanta-q71l platform expects tmp75s which are compatible with
-     * tmp105s.
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
-
-    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
-    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
-    /* TODO: Add Memory Riser i2c mux and eeproms. */
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
-
-    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
-
-    /* i2c-7 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
-    /*        - i2c@0: pmbus@59 */
-    /*        - i2c@1: pmbus@58 */
-    /*        - i2c@2: pmbus@58 */
-    /*        - i2c@3: pmbus@59 */
-
-    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
-    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
-}
-
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1118,23 +1073,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Quanta-Q71l BMC (ARM926EJ-S)";
-    amc->soc_name  = "ast2400-a1";
-    amc->hw_strap1 = QUANTA_Q71L_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q256a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 1;
-    amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->default_ram_size       = 128 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
                                                         const void *data)
 {
@@ -1523,11 +1461,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_qcom_firework_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_quanta_q71l_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
new file mode 100644
index 000000000000..42ad2a2303f7
--- /dev/null
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -0,0 +1,86 @@
+/*
+ * Quanta Q71l
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
+
+/* Quanta-Q71l hardware value */
+#define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2/* DDR3 with CL=6, CWL=5 */) | \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_24M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_PASS_THROUGH) |          \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_8M_DRAM) |                        \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
+static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+
+    /*
+     * The quanta-q71l platform expects tmp75s which are compatible with
+     * tmp105s.
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
+
+    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
+    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
+    /* TODO: Add Memory Riser i2c mux and eeproms. */
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
+
+    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
+
+    /* i2c-7 */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
+    /*        - i2c@0: pmbus@59 */
+    /*        - i2c@1: pmbus@58 */
+    /*        - i2c@2: pmbus@58 */
+    /*        - i2c@3: pmbus@59 */
+
+    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
+    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
+}
+
+static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Quanta-Q71l BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = QUANTA_Q71L_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q256a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->i2c_init  = quanta_q71l_bmc_i2c_init;
+    mc->default_ram_size       = 128 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2400_quanta_q71l_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2400_quanta_q71l_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 021daba2865a..5467ee673db7 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
+  'aspeed_ast2400_quanta-q71l.c',
   'aspeed_ast2500_evb.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
-- 
2.51.1


