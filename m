Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DC7C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKXT-00031X-Qo; Thu, 02 Jul 2026 12:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXJ-000306-25; Thu, 02 Jul 2026 12:45:14 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXH-0003SB-8T; Thu, 02 Jul 2026 12:45:12 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id D79B22003D0;
 Thu,  2 Jul 2026 18:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783010708;
 bh=KVn3pfojn/SSy3VeER7AZPSblfzzaQRHTzxEQsnS/7w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DxnD/YkqNMM6rMkYmyY4UiL+4Sk4MCgLcxls9OCVZaQEWhdikgrBWLm30aNAfyZBD
 estB0pcK/xCR7PXkVHX7DGi+89KTJ0IpmjB4kBz8OcaLKiKpaXcNp4hrg8UaPrCemW
 1fkM1qV27n5HQIPZD9lRsP8Byrn9GsFGm5jgi7mdNxQUh3ZXboD5Y2/aUX1PObfopJ
 CK+s3M3+qRmQxh/gCnX81AJ6PJLV8W8rThv6lMgtt+KrlKe3r6YP8EUstNkkuYsvH/
 JayMVn6xxxOFCc8glHOz21nvpbvhIxDo9L61wckkqBhNiRHVbXCIa3ecbGPqYnI+ZF
 9JQjstJytM9Sg==
From: Emmanuel BLOT <emmanuel.blot@free.fr>
Date: Thu, 02 Jul 2026 18:44:28 +0200
Subject: [PATCH 1/4] hw/arm: sanmiguel-bmc: add Facebook SanMiguel BMC machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-sanmiguel-bmc-v1-1-b176b840aee3@free.fr>
References: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
In-Reply-To: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010682; l=6219;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=KVn3pfojn/SSy3VeER7AZPSblfzzaQRHTzxEQsnS/7w=;
 b=phJi9LeMVssplgYEid2lIAk6towy9JbE9wS0rccLwDjZD68eIgLJGOUAaZf/tfecIezLbtQzG
 eveq0RcJSCnBZikPuzgXM2SbcOsZJjKp7iZFAiv/GSTtUkorigkio0G
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a new AST2600-based QEMU machine for the Facebook SanMiguel BMC
platform, derived from the aspeed-bmc-facebook-sanmiguel.dts device
tree.

I2C topology populates buses 2, 5, 6, 7, 9, 10, 11, 13, 14 with IO
expanders (PCA9552 as PCA9555 stand-in, PCA9554 as TCA6408 stand-in),
LM75 temperature sensors, AT24C FRU EEPROMs, a PCA9546 I2C mux, and
an NCT3018Y RTC (DS1338 stand-in).

Machine properties: 2 GiB RAM, dual mx66l1g45g 128 MB FMC flash,
MAC0 with RGMII.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_sanmiguel.c | 144 ++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build                |   1 +
 2 files changed, 145 insertions(+)

diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
new file mode 100644
index 0000000000..1893d83626
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_sanmiguel.c
@@ -0,0 +1,144 @@
+/*
+ * Facebook SanMiguel BMC
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
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
+#include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9554.h"
+#include "hw/nvram/eeprom_at24c.h"
+#include "hw/sensor/tmp105.h"
+
+/* SanMiguel hardware values */
+#define SANMIGUEL_BMC_HW_STRAP1 0x00002002
+#define SANMIGUEL_BMC_HW_STRAP2 0x00000000
+#define SANMIGUEL_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+
+#define TYPE_TMP75 TYPE_TMP105
+#define TYPE_DS1338 "ds1338"
+
+static void sanmiguel_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference: aspeed-bmc-facebook-sanmiguel.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+
+    for (int idx = 0; idx < ARRAY_SIZE(i2c); idx++) {
+        i2c[idx] = aspeed_i2c_get_bus(&soc->i2c, idx);
+    }
+
+    /* &i2c0 */
+    /* ssif-bmc@10 — no QEMU model */
+
+    /* &i2c1 — empty */
+
+    /* &i2c2 — HPM0 */
+    /* hpm0_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x20);
+    /* hpm0_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9552, 0x21);
+
+    /* &i2c3 — empty */
+    /* &i2c4 — empty */
+
+    /* &i2c5 — SMM */
+    /* smm_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9552, 0x20);
+    /* smm_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9552, 0x21);
+    /* smm_temp: lm75@48 */
+    i2c_slave_create_simple(i2c[5], TYPE_TMP75, 0x48);
+    /* smm_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[5], 0x50, 16 * KiB);
+    /* rtc@6f — nct3018y (ds1338 stand-in) */
+    i2c_slave_create_simple(i2c[5], TYPE_DS1338, 0x6f);
+
+    /* &i2c6 — HMC */
+    /* hmc_ioexp: tca6408@20 (pca9554 stand-in) */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9554, 0x20);
+    /* i2c-mux@70 (PCA9546) — 4 channels (imux16-19), all empty */
+    i2c_slave_create_simple(i2c[6], TYPE_PCA9546, 0x70);
+
+    /* &i2c7 — HPM1 */
+    /* hpm1_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9552, 0x20);
+    /* hpm1_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9552, 0x21);
+
+    /* &i2c8 — empty */
+
+    /* &i2c9 — PDB */
+    /* mp5926@10-16, lm5066i@11-17 — no QEMU model (power monitors) */
+    /* pdb_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9552, 0x20);
+    /* pdb_temp: lm75@4e */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP75, 0x4e);
+    /* pdb_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[9], 0x50, 16 * KiB);
+
+    /* &i2c10 — SCM */
+    /* scm_temp: lm75@48 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP75, 0x48);
+    /* scm_fru: eeprom@50 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[10], 0x50, 16 * KiB);
+
+    /* &i2c11 — Switch Config */
+    /* sw_config: eeprom@50 (24c64 = 8 KiB) */
+    at24c_eeprom_init(i2c[11], 0x50, 8 * KiB);
+
+    /* &i2c12 — empty */
+
+    /* &i2c13 — SMM extension */
+    /* mctp@10 — no QEMU model */
+    /* smm_ext_ioexp: pca9554@38 */
+    i2c_slave_create_simple(i2c[13], TYPE_PCA9554, 0x38);
+    /* smm_ext_fru: eeprom@55 (24c128 = 16 KiB) */
+    at24c_eeprom_init(i2c[13], 0x55, 16 * KiB);
+
+    /* &i2c14 — FIO */
+    /* fio_ioexp: pca9555@20 */
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9552, 0x20);
+    /* fio_fru: eeprom@50 (24c64 = 8 KiB) */
+    at24c_eeprom_init(i2c[14], 0x50, 8 * KiB);
+
+    /* &i2c15 — empty */
+}
+
+static void aspeed_machine_sanmiguel_class_init(ObjectClass *oc,
+                                                const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook SanMiguel BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = SANMIGUEL_BMC_HW_STRAP1;
+    amc->hw_strap2 = SANMIGUEL_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON;
+    amc->i2c_init  = sanmiguel_bmc_i2c_init;
+    mc->default_ram_size = SANMIGUEL_BMC_RAM_SIZE;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_sanmiguel_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("sanmiguel-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_sanmiguel_class_init,
+        .interfaces    = arm_machine_interfaces,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_sanmiguel_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4233a800be..2d5f4a0fe4 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -65,6 +65,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
+  'aspeed_ast2600_sanmiguel.c',
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
   'aspeed_ast1040.c',

-- 
2.50.1


