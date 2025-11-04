Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3150ACCFA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCT2-0000nA-Fe; Tue, 04 Nov 2025 03:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSi-0000X8-EH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSg-0003UB-62
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+YjmRsDxLjixCVLrW+ZPrxCZlPcHLR5KtbI1Sci9DvQ=;
 b=flJjQon4iwSu87dcKM+YbTucnFpYDc1b4W5679Da8J7IiCS0fuMITytlc3pB7SeCvLItwF
 MyRGhjX87zcbgy6+pcuoSJx8LwrO3JbSppPf5jfj5Au8V/LIrnr28sMa/tDl6mzV4+3snM
 MvarDnZpdJZqj6O9L4Qr2vaGISfCxV4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-zopH58CBO2e-ASu7fXVQLw-1; Tue,
 04 Nov 2025 03:32:14 -0500
X-MC-Unique: zopH58CBO2e-ASu7fXVQLw-1
X-Mimecast-MFC-AGG-ID: zopH58CBO2e-ASu7fXVQLw_1762245134
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFD7C195608E; Tue,  4 Nov 2025 08:32:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52B9819560A2; Tue,  4 Nov 2025 08:32:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/30] hw/arm/aspeed: Split Romulus machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:25 +0100
Message-ID: <20251104083144.187806-12-clg@redhat.com>
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-12-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c                 | 43 -----------------------
 hw/arm/aspeed_ast2500_romulus.c | 62 +++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |  1 +
 3 files changed, 63 insertions(+), 43 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_romulus.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index df1a37ca3df7..c31b281f5584 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -92,16 +92,6 @@ static struct arm_boot_info aspeed_board_binfo = {
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
@@ -452,17 +442,6 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
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
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 {
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
@@ -1243,23 +1222,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
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
@@ -1625,11 +1587,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("romulus-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_romulus_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
new file mode 100644
index 000000000000..91b660e74bba
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -0,0 +1,62 @@
+/*
+ * OpenPOWER Romulus
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
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_romulus_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f59bfe5029dc..ff6a856523d9 100644
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
2.51.1


