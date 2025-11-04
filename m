Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E35CCFA15
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCU7-0002Em-50; Tue, 04 Nov 2025 03:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT5-0000wN-45
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCT2-0003ZZ-Kb
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU1bjCS796FgGMCNpFXyZhrKM4JsNNsAasa/KCb9pI8=;
 b=ALfsanweHaEK2dBUUQbAjLr045JIpvRYYyNof+T+JuCaUyWetYZCbcdbkxXrVe46PHYuDO
 klhaVrzaplfLOpmBG1jugwN43ppS6/xVr6PgEGe5zYvg1mgHsUIeUVWyU5VYWxJ6WGogi3
 TCLdMejRkFIMNLSBL3+jpHbo8VZX1C4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-VuvA8ZC4OVeNoX3u7StvLg-1; Tue,
 04 Nov 2025 03:32:36 -0500
X-MC-Unique: VuvA8ZC4OVeNoX3u7StvLg-1
X-Mimecast-MFC-AGG-ID: VuvA8ZC4OVeNoX3u7StvLg_1762245155
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3074418001E3; Tue,  4 Nov 2025 08:32:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D50819560B7; Tue,  4 Nov 2025 08:32:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/30] hw/arm/aspeed: Split Fuji machine into a separate source
 file for maintainability
Date: Tue,  4 Nov 2025 09:31:34 +0100
Message-ID: <20251104083144.187806-21-clg@redhat.com>
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

This commit moves the Facebook Fuji BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_fuji.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future development for
new platforms without cluttering aspeed.c.

Key updates include:
- Moved FUJI_BMC_HW_STRAP1 and FUJI_BMC_HW_STRAP2 macro definitions into the new file.
- Moved fuji_bmc_i2c_init() and its helper get_pca9548_channels() into the new file.
- Moved aspeed_machine_fuji_class_init() and type registration to aspeed_ast2600_fuji.c.
- Added aspeed_ast2600_fuji.c to the build system (meson.build).
- Cleaned up all Fuji-specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251104031325.146374-21-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c              | 117 -----------------------------
 hw/arm/aspeed_ast2600_fuji.c | 140 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build           |   1 +
 3 files changed, 141 insertions(+), 117 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_fuji.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e44aec69bd2b..29a036b675ea 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -52,10 +52,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
 #define RAINIER_BMC_HW_STRAP2 0x80000848
 
-/* Fuji hardware value */
-#define FUJI_BMC_HW_STRAP1    0x00000000
-#define FUJI_BMC_HW_STRAP2    0x00000000
-
 /* GB200NVL hardware value */
 #define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
 #define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
@@ -416,95 +412,8 @@ static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
     aspeed_create_pca9552(soc, 15, 0x60);
 }
 
-static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
-                                 I2CBus **channels)
-{
-    I2CSlave *mux = i2c_slave_create_simple(bus, "pca9548", mux_addr);
-    for (int i = 0; i < 8; i++) {
-        channels[i] = pca954x_i2c_get_bus(mux, i);
-    }
-}
-
 #define TYPE_LM75 TYPE_TMP105
 #define TYPE_TMP75 TYPE_TMP105
-#define TYPE_TMP422 "tmp422"
-
-static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CBus *i2c[144] = {};
-
-    for (int i = 0; i < 16; i++) {
-        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
-    }
-    I2CBus *i2c180 = i2c[2];
-    I2CBus *i2c480 = i2c[8];
-    I2CBus *i2c600 = i2c[11];
-
-    get_pca9548_channels(i2c180, 0x70, &i2c[16]);
-    get_pca9548_channels(i2c480, 0x70, &i2c[24]);
-    /* NOTE: The device tree skips [32, 40) in the alias numbering */
-    get_pca9548_channels(i2c600, 0x77, &i2c[40]);
-    get_pca9548_channels(i2c[24], 0x71, &i2c[48]);
-    get_pca9548_channels(i2c[25], 0x72, &i2c[56]);
-    get_pca9548_channels(i2c[26], 0x76, &i2c[64]);
-    get_pca9548_channels(i2c[27], 0x76, &i2c[72]);
-    for (int i = 0; i < 8; i++) {
-        get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
-    }
-
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
-    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
-
-    /*
-     * EEPROM 24c64 size is 64Kbits or 8 Kbytes
-     *        24c02 size is 2Kbits or 256 bytes
-     */
-    at24c_eeprom_init(i2c[19], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[20], 0x50, 256);
-    at24c_eeprom_init(i2c[22], 0x52, 256);
-
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
-    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
-    i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
-
-    at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
-    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
-
-    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
-    at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
-    i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);
-
-    i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);
-    i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);
-
-    at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
-    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);
-    at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
-
-    at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
-    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);
-    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);
-    at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[79], 0x52, 8 * KiB);
-    at24c_eeprom_init(i2c[28], 0x50, 256);
-
-    for (int i = 0; i < 8; i++) {
-        at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
-        i2c_slave_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
-        i2c_slave_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
-        i2c_slave_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
-    }
-}
-
 #define TYPE_TMP421 "tmp421"
 #define TYPE_DS1338 "ds1338"
 
@@ -955,27 +864,6 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
-
-static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc = "Facebook Fuji BMC (Cortex-A7)";
-    amc->soc_name = "ast2600-a3";
-    amc->hw_strap1 = FUJI_BMC_HW_STRAP1;
-    amc->hw_strap2 = FUJI_BMC_HW_STRAP2;
-    amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs = 2;
-    amc->macs_mask = ASPEED_MAC3_ON;
-    amc->i2c_init = fuji_bmc_i2c_init;
-    amc->uart_default = ASPEED_DEV_UART1;
-    mc->default_ram_size = FUJI_BMC_RAM_SIZE;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -1216,11 +1104,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
         .interfaces    = arm_machine_interfaces,
-    }, {
-        .name          = MACHINE_TYPE_NAME("fuji-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_fuji_class_init,
-        .interfaces    = arm_machine_interfaces,
     }, {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
new file mode 100644
index 000000000000..37db252e2769
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -0,0 +1,140 @@
+/*
+ * Facebook Fuji
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
+#include "hw/i2c/i2c_mux_pca954x.h"
+#include "hw/sensor/tmp105.h"
+#include "hw/nvram/eeprom_at24c.h"
+
+#define TYPE_LM75 TYPE_TMP105
+#define TYPE_TMP75 TYPE_TMP105
+#define TYPE_TMP422 "tmp422"
+
+/* Fuji hardware value */
+#define FUJI_BMC_HW_STRAP1    0x00000000
+#define FUJI_BMC_HW_STRAP2    0x00000000
+#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
+                                 I2CBus **channels)
+{
+    I2CSlave *mux = i2c_slave_create_simple(bus, "pca9548", mux_addr);
+    for (int i = 0; i < 8; i++) {
+        channels[i] = pca954x_i2c_get_bus(mux, i);
+    }
+}
+
+static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[144] = {};
+
+    for (int i = 0; i < 16; i++) {
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+    I2CBus *i2c180 = i2c[2];
+    I2CBus *i2c480 = i2c[8];
+    I2CBus *i2c600 = i2c[11];
+
+    get_pca9548_channels(i2c180, 0x70, &i2c[16]);
+    get_pca9548_channels(i2c480, 0x70, &i2c[24]);
+    /* NOTE: The device tree skips [32, 40) in the alias numbering */
+    get_pca9548_channels(i2c600, 0x77, &i2c[40]);
+    get_pca9548_channels(i2c[24], 0x71, &i2c[48]);
+    get_pca9548_channels(i2c[25], 0x72, &i2c[56]);
+    get_pca9548_channels(i2c[26], 0x76, &i2c[64]);
+    get_pca9548_channels(i2c[27], 0x76, &i2c[72]);
+    for (int i = 0; i < 8; i++) {
+        get_pca9548_channels(i2c[40 + i], 0x76, &i2c[80 + i * 8]);
+    }
+
+    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4c);
+    i2c_slave_create_simple(i2c[17], TYPE_LM75, 0x4d);
+
+    /*
+     * EEPROM 24c64 size is 64Kbits or 8 Kbytes
+     *        24c02 size is 2Kbits or 256 bytes
+     */
+    at24c_eeprom_init(i2c[19], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[20], 0x50, 256);
+    at24c_eeprom_init(i2c[22], 0x52, 256);
+
+    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x48);
+    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x49);
+    i2c_slave_create_simple(i2c[3], TYPE_LM75, 0x4a);
+    i2c_slave_create_simple(i2c[3], TYPE_TMP422, 0x4c);
+
+    at24c_eeprom_init(i2c[8], 0x51, 8 * KiB);
+    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x4a);
+
+    i2c_slave_create_simple(i2c[50], TYPE_LM75, 0x4c);
+    at24c_eeprom_init(i2c[50], 0x52, 8 * KiB);
+    i2c_slave_create_simple(i2c[51], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(i2c[52], TYPE_TMP75, 0x49);
+
+    i2c_slave_create_simple(i2c[59], TYPE_TMP75, 0x48);
+    i2c_slave_create_simple(i2c[60], TYPE_TMP75, 0x49);
+
+    at24c_eeprom_init(i2c[65], 0x53, 8 * KiB);
+    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(i2c[66], TYPE_TMP75, 0x48);
+    at24c_eeprom_init(i2c[68], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[69], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[70], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[71], 0x52, 8 * KiB);
+
+    at24c_eeprom_init(i2c[73], 0x53, 8 * KiB);
+    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x49);
+    i2c_slave_create_simple(i2c[74], TYPE_TMP75, 0x48);
+    at24c_eeprom_init(i2c[76], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[77], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[78], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[79], 0x52, 8 * KiB);
+    at24c_eeprom_init(i2c[28], 0x50, 256);
+
+    for (int i = 0; i < 8; i++) {
+        at24c_eeprom_init(i2c[81 + i * 8], 0x56, 64 * KiB);
+        i2c_slave_create_simple(i2c[82 + i * 8], TYPE_TMP75, 0x48);
+        i2c_slave_create_simple(i2c[83 + i * 8], TYPE_TMP75, 0x4b);
+        i2c_slave_create_simple(i2c[84 + i * 8], TYPE_TMP75, 0x4a);
+    }
+}
+
+static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Facebook Fuji BMC (Cortex-A7)";
+    amc->soc_name = "ast2600-a3";
+    amc->hw_strap1 = FUJI_BMC_HW_STRAP1;
+    amc->hw_strap2 = FUJI_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs = 2;
+    amc->macs_mask = ASPEED_MAC3_ON;
+    amc->i2c_init = fuji_bmc_i2c_init;
+    amc->uart_default = ASPEED_DEV_UART1;
+    mc->default_ram_size = FUJI_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2600_fuji_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("fuji-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_fuji_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_fuji_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4abfbffb45fa..e6f6ab424547 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600.c',
   'aspeed_ast2600_bletchley.c',
   'aspeed_ast2600_fby35.c',
+  'aspeed_ast2600_fuji.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.51.1


