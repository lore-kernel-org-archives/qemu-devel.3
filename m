Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF33CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCUf-0003rG-OB; Tue, 04 Nov 2025 03:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTE-0001JU-Js
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCTB-0003cQ-8a
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vj+VwP+Od1S6YA1UQ53Xq4AYaBg5RRWaPnk4JSIb6uU=;
 b=DWC//6xdweMNDuCTQvIszzBE4lkMjF09rb6Sb+eQIvX8FsqHfCJA2cAycFc4GlC8haQ3Px
 y8MqB0YPkdl5vxtIm17tORFaofRS+mPkdqk+Kn21TQD1VdDhXpEvXQLI47Unw8dP78LS8s
 GcwhlM7MJUOY8XCHUtGW0CWL8prX7rM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-8sGpNhuFNgW404tY_pya3Q-1; Tue,
 04 Nov 2025 03:32:47 -0500
X-MC-Unique: 8sGpNhuFNgW404tY_pya3Q-1
X-Mimecast-MFC-AGG-ID: 8sGpNhuFNgW404tY_pya3Q_1762245166
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3839719560A7; Tue,  4 Nov 2025 08:32:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FF9919560A2; Tue,  4 Nov 2025 08:32:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/30] hw/arm/aspeed: Split Rainier machine into a separate
 source file for maintainability
Date: Tue,  4 Nov 2025 09:31:39 +0100
Message-ID: <20251104083144.187806-26-clg@redhat.com>
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

This commit moves the IBM Rainier BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_rainier.c.

This refactor continues the modularization effort for Aspeed platform
support, placing each board’s logic and FRUID data in its own dedicated
source file. It improves maintainability, readability, and simplifies
future development for new Aspeed-based systems without cluttering
aspeed.c.

Key updates include:
- Removed RAINIER_BMC_HW_STRAP1 and RAINIER_BMC_HW_STRAP2 macro definitions.
- Moved rainier_bmc_i2c_init() and all related I2C device setup code
  into the new aspeed_ast2600_rainier.c file.
- Moved aspeed_machine_rainier_class_init() and type registration logic
  out of aspeed.c.
- Deleted aspeed_eeprom.h and aspeed_eeprom.c; their FRUID data and
  length definitions are now handled directly in the new Rainier file.
- Added aspeed_ast2600_rainier.c to the Meson build system (meson.build).

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-26-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_eeprom.h          |  15 ---
 hw/arm/aspeed.c                 | 133 ---------------------
 hw/arm/aspeed_ast2600_rainier.c | 198 ++++++++++++++++++++++++++++++++
 hw/arm/aspeed_eeprom.c          |  54 ---------
 hw/arm/meson.build              |   2 +-
 5 files changed, 199 insertions(+), 203 deletions(-)
 delete mode 100644 hw/arm/aspeed_eeprom.h
 create mode 100644 hw/arm/aspeed_ast2600_rainier.c
 delete mode 100644 hw/arm/aspeed_eeprom.c

diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
deleted file mode 100644
index 86b97e4c6d98..000000000000
--- a/hw/arm/aspeed_eeprom.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (c) Meta Platforms, Inc. and affiliates.
- *
- * SPDX-License-Identifier: GPL-2.0-only
- */
-
-#ifndef ASPEED_EEPROM_H
-#define ASPEED_EEPROM_H
-
-extern const uint8_t rainier_bb_fruid[];
-extern const size_t rainier_bb_fruid_len;
-extern const uint8_t rainier_bmc_fruid[];
-extern const size_t rainier_bmc_fruid_len;
-
-#endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 77a4095f7d35..56600be916ee 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -14,7 +14,6 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/arm/aspeed_eeprom.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
@@ -48,10 +47,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define AST2700_EVB_HW_STRAP2 0x00000700
 #endif
 
-/* Rainier hardware value: (QEMU prototype) */
-#define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
-#define RAINIER_BMC_HW_STRAP2 0x80000848
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -300,110 +295,6 @@ I2CSlave *aspeed_create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
                             TYPE_PCA9554, addr);
 }
 
-static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CSlave *i2c_mux;
-
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
-
-    aspeed_create_pca9552(soc, 3, 0x61);
-
-    /* The rainier expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x49);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
-                     0x4a);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
-                                      "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
-    aspeed_create_pca9552(soc, 4, 0x60);
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
-                     0x49);
-    aspeed_create_pca9552(soc, 5, 0x60);
-    aspeed_create_pca9552(soc, 5, 0x61);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
-                                      "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4a);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
-                     0x4b);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
-                                      "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
-
-    aspeed_create_pca9552(soc, 7, 0x30);
-    aspeed_create_pca9552(soc, 7, 0x31);
-    aspeed_create_pca9552(soc, 7, 0x32);
-    aspeed_create_pca9552(soc, 7, 0x33);
-    aspeed_create_pca9552(soc, 7, 0x60);
-    aspeed_create_pca9552(soc, 7, 0x61);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
-    /* Bus 7: TODO si7021-a20@20 */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
-                     0x4a);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
-                          64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
-    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
-                          64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
-    aspeed_create_pca9552(soc, 8, 0x60);
-    aspeed_create_pca9552(soc, 8, 0x61);
-    /* Bus 8: ucd90320@11 */
-    /* Bus 8: ucd90320@b */
-    /* Bus 8: ucd90320@c */
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
-
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x48);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
-                     0x49);
-    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
-                                      "pca9546", 0x70);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
-    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
-    aspeed_create_pca9552(soc, 11, 0x60);
-
-
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 13, 0x60);
-
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 14, 0x60);
-
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
-    aspeed_create_pca9552(soc, 15, 0x60);
-}
-
 #define TYPE_LM75 TYPE_TMP105
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
@@ -760,25 +651,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "IBM Rainier BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = RAINIER_BMC_HW_STRAP1;
-    amc->hw_strap2 = RAINIER_BMC_HW_STRAP2;
-    amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
-    amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->default_ram_size = 1 * GiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-    aspeed_machine_ast2600_class_emmc_init(oc);
-};
-
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -939,11 +811,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("rainier-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_rainier_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
new file mode 100644
index 000000000000..8f0a412ddcfb
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -0,0 +1,198 @@
+/*
+ * IBM Rainier
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
+/* Rainier hardware value: (QEMU prototype) */
+#define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
+#define RAINIER_BMC_HW_STRAP2 0x80000848
+
+static const uint8_t rainier_bb_fruid[] = {
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84,
+    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 0x44, 0x02,
+    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 0x00, 0x37,
+    0x00, 0x4a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x52, 0x54,
+    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x38, 0x56, 0x49, 0x4e, 0x49,
+    0x00, 0x00, 0x81, 0x00, 0x3a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x53,
+    0x59, 0x53, 0x00, 0x00, 0xbb, 0x00, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x56, 0x43, 0x45, 0x4e, 0x00, 0x00, 0xe2, 0x00, 0x27, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x56, 0x53, 0x42, 0x50, 0x00, 0x00, 0x09, 0x01, 0x19, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x01, 0x00, 0x00, 0x00, 0x36, 0x00,
+    0x52, 0x54, 0x04, 0x56, 0x49, 0x4e, 0x49, 0x44, 0x52, 0x04, 0x44, 0x45,
+    0x53, 0x43, 0x48, 0x57, 0x02, 0x30, 0x31, 0x43, 0x43, 0x04, 0x33, 0x34,
+    0x35, 0x36, 0x46, 0x4e, 0x04, 0x46, 0x52, 0x34, 0x39, 0x53, 0x4e, 0x04,
+    0x53, 0x52, 0x31, 0x32, 0x50, 0x4e, 0x04, 0x50, 0x52, 0x39, 0x39, 0x50,
+    0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x00, 0x52, 0x54,
+    0x04, 0x56, 0x53, 0x59, 0x53, 0x53, 0x45, 0x07, 0x49, 0x42, 0x4d, 0x53,
+    0x59, 0x53, 0x31, 0x54, 0x4d, 0x08, 0x32, 0x32, 0x32, 0x32, 0x2d, 0x32,
+    0x32, 0x32, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23,
+    0x00, 0x52, 0x54, 0x04, 0x56, 0x43, 0x45, 0x4e, 0x53, 0x45, 0x07, 0x31,
+    0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x46, 0x43, 0x08, 0x31, 0x31, 0x31,
+    0x31, 0x2d, 0x31, 0x31, 0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x15, 0x00, 0x52, 0x54, 0x04, 0x56, 0x53, 0x42, 0x50, 0x49,
+    0x4d, 0x04, 0x50, 0x00, 0x10, 0x01, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00,
+    0x00, 0x00,
+};
+static const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
+
+/* Rainier BMC FRU */
+static const uint8_t rainier_bmc_fruid[] = {
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84,
+    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 0x44, 0x02,
+    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 0x00, 0x37,
+    0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x52, 0x54,
+    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x0e, 0x56, 0x49, 0x4e, 0x49,
+    0x00, 0x00, 0x57, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46,
+    0x01, 0x00, 0x00, 0x00, 0x1a, 0x00, 0x52, 0x54, 0x04, 0x56, 0x49, 0x4e,
+    0x49, 0x44, 0x52, 0x04, 0x44, 0x45, 0x53, 0x43, 0x48, 0x57, 0x02, 0x30,
+    0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+static const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
+
+static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CSlave *i2c_mux;
+
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
+
+    aspeed_create_pca9552(soc, 3, 0x61);
+
+    /* The rainier expects a TMP275 but a TMP105 is compatible */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+                     0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), TYPE_TMP105,
+                     0x4a);
+    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4),
+                                      "pca9546", 0x70);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x52, 64 * KiB);
+    aspeed_create_pca9552(soc, 4, 0x60);
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), TYPE_TMP105,
+                     0x49);
+    aspeed_create_pca9552(soc, 5, 0x60);
+    aspeed_create_pca9552(soc, 5, 0x61);
+    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                                      "pca9546", 0x70);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+                     0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), TYPE_TMP105,
+                     0x4b);
+    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6),
+                                      "pca9546", 0x70);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 2), 0x50, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 3), 0x51, 64 * KiB);
+
+    aspeed_create_pca9552(soc, 7, 0x30);
+    aspeed_create_pca9552(soc, 7, 0x31);
+    aspeed_create_pca9552(soc, 7, 0x32);
+    aspeed_create_pca9552(soc, 7, 0x33);
+    aspeed_create_pca9552(soc, 7, 0x60);
+    aspeed_create_pca9552(soc, 7, 0x61);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "dps310", 0x76);
+    /* Bus 7: TODO si7021-a20@20 */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "max31785", 0x52);
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50, 64 * KiB);
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x51, 64 * KiB);
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
+                     0x4a);
+    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
+                          64 * KiB, rainier_bb_fruid, rainier_bb_fruid_len);
+    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
+                          64 * KiB, rainier_bmc_fruid, rainier_bmc_fruid_len);
+    aspeed_create_pca9552(soc, 8, 0x60);
+    aspeed_create_pca9552(soc, 8, 0x61);
+    /* Bus 8: ucd90320@11 */
+    /* Bus 8: ucd90320@b */
+    /* Bus 8: ucd90320@c */
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4d);
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 9), 0x50, 128 * KiB);
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4d);
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 10), 0x50, 128 * KiB);
+
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
+                     0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), TYPE_TMP105,
+                     0x49);
+    i2c_mux = i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11),
+                                      "pca9546", 0x70);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 0), 0x50, 64 * KiB);
+    at24c_eeprom_init(pca954x_i2c_get_bus(i2c_mux, 1), 0x51, 64 * KiB);
+    aspeed_create_pca9552(soc, 11, 0x60);
+
+
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 13), 0x50, 64 * KiB);
+    aspeed_create_pca9552(soc, 13, 0x60);
+
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 14), 0x50, 64 * KiB);
+    aspeed_create_pca9552(soc, 14, 0x60);
+
+    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 15), 0x50, 64 * KiB);
+    aspeed_create_pca9552(soc, 15, 0x60);
+}
+
+static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "IBM Rainier BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = RAINIER_BMC_HW_STRAP1;
+    amc->hw_strap2 = RAINIER_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
+    amc->i2c_init  = rainier_bmc_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+    aspeed_machine_ast2600_class_emmc_init(oc);
+};
+
+static const TypeInfo aspeed_ast2600_rainier_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("rainier-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_rainier_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_rainier_types)
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
deleted file mode 100644
index 85a2aa40365a..000000000000
--- a/hw/arm/aspeed_eeprom.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright (c) Meta Platforms, Inc. and affiliates.
- *
- * SPDX-License-Identifier: GPL-2.0-only
- */
-
-#include "qemu/osdep.h"
-#include "aspeed_eeprom.h"
-
-const uint8_t rainier_bb_fruid[] = {
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84,
-    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 0x44, 0x02,
-    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 0x00, 0x37,
-    0x00, 0x4a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 0x52, 0x54,
-    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x38, 0x56, 0x49, 0x4e, 0x49,
-    0x00, 0x00, 0x81, 0x00, 0x3a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x53,
-    0x59, 0x53, 0x00, 0x00, 0xbb, 0x00, 0x27, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x56, 0x43, 0x45, 0x4e, 0x00, 0x00, 0xe2, 0x00, 0x27, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x56, 0x53, 0x42, 0x50, 0x00, 0x00, 0x09, 0x01, 0x19, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x01, 0x00, 0x00, 0x00, 0x36, 0x00,
-    0x52, 0x54, 0x04, 0x56, 0x49, 0x4e, 0x49, 0x44, 0x52, 0x04, 0x44, 0x45,
-    0x53, 0x43, 0x48, 0x57, 0x02, 0x30, 0x31, 0x43, 0x43, 0x04, 0x33, 0x34,
-    0x35, 0x36, 0x46, 0x4e, 0x04, 0x46, 0x52, 0x34, 0x39, 0x53, 0x4e, 0x04,
-    0x53, 0x52, 0x31, 0x32, 0x50, 0x4e, 0x04, 0x50, 0x52, 0x39, 0x39, 0x50,
-    0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x00, 0x52, 0x54,
-    0x04, 0x56, 0x53, 0x59, 0x53, 0x53, 0x45, 0x07, 0x49, 0x42, 0x4d, 0x53,
-    0x59, 0x53, 0x31, 0x54, 0x4d, 0x08, 0x32, 0x32, 0x32, 0x32, 0x2d, 0x32,
-    0x32, 0x32, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23,
-    0x00, 0x52, 0x54, 0x04, 0x56, 0x43, 0x45, 0x4e, 0x53, 0x45, 0x07, 0x31,
-    0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x46, 0x43, 0x08, 0x31, 0x31, 0x31,
-    0x31, 0x2d, 0x31, 0x31, 0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x15, 0x00, 0x52, 0x54, 0x04, 0x56, 0x53, 0x42, 0x50, 0x49,
-    0x4d, 0x04, 0x50, 0x00, 0x10, 0x01, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00,
-    0x00, 0x00,
-};
-
-/* Rainier BMC FRU */
-const uint8_t rainier_bmc_fruid[] = {
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84,
-    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 0x44, 0x02,
-    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 0x00, 0x37,
-    0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x52, 0x54,
-    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x0e, 0x56, 0x49, 0x4e, 0x49,
-    0x00, 0x00, 0x57, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46,
-    0x01, 0x00, 0x00, 0x00, 0x1a, 0x00, 0x52, 0x54, 0x04, 0x56, 0x49, 0x4e,
-    0x49, 0x44, 0x52, 0x04, 0x44, 0x45, 0x53, 0x43, 0x48, 0x57, 0x02, 0x30,
-    0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
-};
-
-const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
-const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
-
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d229e4850091..d7e4d87dc8af 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -63,8 +63,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_qcom-dc-scm-v1.c',
   'aspeed_ast2600_qcom-firework.c',
+  'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
-  'aspeed_eeprom.c',
   'fby35.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast27x0.c',
-- 
2.51.1


