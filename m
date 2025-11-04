Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE10DCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCUQ-0002mo-Mu; Tue, 04 Nov 2025 03:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTD-0001CF-Be
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT9-0003bo-Jl
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6USLPg02T+BCIwtJCXV6iRyPvzK/HMnBun2NmkS24zM=;
 b=dOURZts+Qefr6vUiPrQTM/OiiFxfQeu2bvMQn0tJQn5XOQvoh0lBzkAqIBeLwC9xOAsLAm
 uqo1DikRdt+rg8JKU2+Bo3Hxyv5fKC80u7UD2I2ucHgHyC1SnGJBCPm7nv+TPWyPjYus7N
 Fn72omc8RoDLSFh4vxHW/Hzj7zCKywo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-gbQKuaS3MXK6y4wwZ55Wdw-1; Tue,
 04 Nov 2025 03:32:45 -0500
X-MC-Unique: gbQKuaS3MXK6y4wwZ55Wdw-1
X-Mimecast-MFC-AGG-ID: gbQKuaS3MXK6y4wwZ55Wdw_1762245164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F94219560B5; Tue,  4 Nov 2025 08:32:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A3EC19560B2; Tue,  4 Nov 2025 08:32:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/30] hw/arm/aspeed: Split GB200NVL machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:38 +0100
Message-ID: <20251104083144.187806-25-clg@redhat.com>
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

This commit moves the Nvidia GB200NVL BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_gb200nvl.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s initialization logic in its own dedicated source file.
It improves code maintainability, readability, and simplifies adding new
platforms without increasing the complexity of aspeed.c.

Key updates include:
- Moved GB200NVL_BMC_HW_STRAP1 and GB200NVL_BMC_HW_STRAP2 macro definitions into the new file.
- Moved gb200nvl_bmc_i2c_init() and its related FRUID setup into the new file.
- Moved aspeed_machine_gb200nvl_class_init() and type registration logic out of aspeed.c.
- Removed gb200nvl_bmc_fruid[] and its length definition from aspeed_eeprom.c/h.
- Added aspeed_ast2600_gb200nvl.c to the Meson build system (meson.build).
- Cleaned up all GB200NVL-specific code and data from aspeed.c and aspeed_eeprom.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-25-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_eeprom.h           |   3 -
 hw/arm/aspeed.c                  |  72 --------------------
 hw/arm/aspeed_ast2600_gb200nvl.c | 111 +++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c           |  20 ------
 hw/arm/meson.build               |   1 +
 5 files changed, 112 insertions(+), 95 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c

diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index 7207bb2cbd39..86b97e4c6d98 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -12,7 +12,4 @@ extern const size_t rainier_bb_fruid_len;
 extern const uint8_t rainier_bmc_fruid[];
 extern const size_t rainier_bmc_fruid_len;
 
-extern const uint8_t gb200nvl_bmc_fruid[];
-extern const size_t gb200nvl_bmc_fruid_len;
-
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2f385290a419..77a4095f7d35 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -52,10 +52,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
 #define RAINIER_BMC_HW_STRAP2 0x80000848
 
-/* GB200NVL hardware value */
-#define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
-#define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -586,44 +582,6 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
 }
 
-static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CBus *i2c[15] = {};
-    DeviceState *dev;
-    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
-        if ((i == 11) || (i == 12) || (i == 13)) {
-            continue;
-        }
-        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
-    }
-
-    /* Bus 5 Expander */
-    aspeed_create_pca9554(soc, 4, 0x21);
-
-    /* Mux I2c Expanders */
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
-    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
-
-    /* Bus 10 */
-    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
-
-    /* Set FPGA_READY */
-    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
-
-    aspeed_create_pca9554(soc, 9, 0x21);
-    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
-    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
-
-    /* Bus 11 */
-    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
-                          gb200nvl_bmc_fruid_len);
-}
-
 static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
 {
     return ASPEED_MACHINE(obj)->mmio_exec;
@@ -841,31 +799,6 @@ static void aspeed_machine_catalina_class_init(ObjectClass *oc,
     aspeed_machine_ast2600_class_emmc_init(oc);
 }
 
-#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
-
-static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
-                                               const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
-    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
-    amc->fmc_model = "mx66u51235f";
-    amc->spi_model = "mx66u51235f";
-    amc->num_cs    = 2;
-
-    amc->spi2_model = "mx66u51235f";
-    amc->num_cs2   = 1;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
-    amc->i2c_init  = gb200nvl_bmc_i2c_init;
-    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
-    aspeed_machine_class_init_cpus_defaults(mc);
-    aspeed_machine_ast2600_class_emmc_init(oc);
-}
-
 #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
 /* Main SYSCLK frequency in Hz (200MHz) */
 #define SYSCLK_FRQ 200000000ULL
@@ -1011,11 +944,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_gb200nvl_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
new file mode 100644
index 000000000000..ad9a10110b89
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -0,0 +1,111 @@
+/*
+ * Nvidia GB200NVL
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
+
+/* GB200NVL hardware value */
+#define GB200NVL_BMC_HW_STRAP1 0x000000C0
+#define GB200NVL_BMC_HW_STRAP2 0x00000003
+#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
+
+static const uint8_t gb200nvl_bmc_fruid[] = {
+    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
+    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
+    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
+    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
+    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
+    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
+    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
+    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
+    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
+    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
+    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
+    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
+    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+
+};
+static const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
+
+static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[15] = {};
+    DeviceState *dev;
+    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
+        if ((i == 11) || (i == 12) || (i == 13)) {
+            continue;
+        }
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Bus 5 Expander */
+    aspeed_create_pca9554(soc, 4, 0x21);
+
+    /* Mux I2c Expanders */
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
+    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
+
+    /* Bus 10 */
+    dev = DEVICE(aspeed_create_pca9554(soc, 9, 0x20));
+
+    /* Set FPGA_READY */
+    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
+
+    aspeed_create_pca9554(soc, 9, 0x21);
+    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
+    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
+
+    /* Bus 11 */
+    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
+                          gb200nvl_bmc_fruid_len);
+}
+
+static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
+    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66u51235f";
+    amc->spi_model = "mx66u51235f";
+    amc->num_cs    = 2;
+
+    amc->spi2_model = "mx66u51235f";
+    amc->num_cs2   = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = gb200nvl_bmc_i2c_init;
+    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+}
+
+static const TypeInfo aspeed_ast2600_gb200nvl_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_gb200nvl_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_gb200nvl_types)
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index 53c9b0d56f03..85a2aa40365a 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -49,26 +49,6 @@ const uint8_t rainier_bmc_fruid[] = {
     0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-const uint8_t gb200nvl_bmc_fruid[] = {
-    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
-    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
-    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
-    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
-    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
-    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
-    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
-    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
-    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
-    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
-    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
-    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
-    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-
-};
-
 const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
 const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
-const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 588a72bdf28d..d229e4850091 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_fby35.c',
   'aspeed_ast2600_fuji.c',
+  'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_qcom-dc-scm-v1.c',
   'aspeed_ast2600_qcom-firework.c',
   'aspeed_ast10x0.c',
-- 
2.51.1


