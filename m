Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B9C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPR-0005u6-OL; Sun, 06 Sep 2026 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPP-0005nj-Jl
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPN-0000Mo-Nz
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUxA5/qQPN5AJZY2D8e+vLynfT1bwKinpHHNt+5akDk=;
 b=QNBGo2d2Jd3xewcKTsbsUNcNGd4t3uC+sKWlOI0tYaVpmngDY4tVI3SQzJCFcrZR2XSKfv
 y0JS7vkgrgk9Tb6mOjDXqunQ45HNQoKOEEB+TT+7/Lu6AIZRTjyIyhHTvBDpa99v+cP/vh
 e52cWjG3apDNgLQsf0jtMWlE4jrJV6c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-l_EBx1P5PSeFg9DFpbiw9w-1; Sun,
 06 Sep 2026 13:11:45 -0400
X-MC-Unique: l_EBx1P5PSeFg9DFpbiw9w-1
X-Mimecast-MFC-AGG-ID: l_EBx1P5PSeFg9DFpbiw9w_1788714701
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 914F81800D9D; Sun,  6 Sep 2026 17:11:41 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E5871955F06; Sun,  6 Sep 2026 17:11:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/40] hw/arm: sanmiguel: add Facebook SanMiguel BMC machine
Date: Sun,  6 Sep 2026 19:10:17 +0200
Message-ID: <20260906171021.26568-37-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Add an AST2600-based machine for the Facebook SanMiguel BMC, derived
from the aspeed-bmc-facebook-sanmiguel.dts device tree.

The board wires up three TMP75 temperature sensors across its I2C buses,
alongside IO expanders, FRU EEPROMs, an I2C mux and an RTC, with 2 GiB
RAM, dual FMC flash and RGMII networking.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-12-1266926ba769@free.fr
[ clg: - adjusted on upstream ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_sanmiguel.c | 140 ++++++++++++++++++++++++++++++
 hw/arm/meson.build                |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 hw/arm/aspeed_ast2600_sanmiguel.c

diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
new file mode 100644
index 000000000000..ca07a0deaada
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_sanmiguel.c
@@ -0,0 +1,140 @@
+/*
+ * Facebook SanMiguel BMC
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
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
+#define TYPE_DS1338 "ds1338"
+
+static void sanmiguel_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    /* Reference: aspeed-bmc-facebook-sanmiguel.dts */
+
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[16] = {};
+
+    for (unsigned idx = 0; idx < ARRAY_SIZE(i2c); idx++) {
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
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x20);
+    /* hpm0_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[2], TYPE_PCA9555, 0x21);
+
+    /* &i2c3 — empty */
+    /* &i2c4 — empty */
+
+    /* &i2c5 — SMM */
+    /* smm_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9555, 0x20);
+    /* smm_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[5], TYPE_PCA9555, 0x21);
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
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9555, 0x20);
+    /* hpm1_ioexp_21: pca9555@21 */
+    i2c_slave_create_simple(i2c[7], TYPE_PCA9555, 0x21);
+
+    /* &i2c8 — empty */
+
+    /* &i2c9 — PDB */
+    /* mp5926@10-16, lm5066i@11-17 — no QEMU model (power monitors) */
+    /* pdb_ioexp_20: pca9555@20 */
+    i2c_slave_create_simple(i2c[9], TYPE_PCA9555, 0x20);
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
+    i2c_slave_create_simple(i2c[14], TYPE_PCA9555, 0x20);
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
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2600_sanmiguel_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 78acb04c8b9f..bcc068de0403 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -64,6 +64,7 @@ arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_fuji.c',
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
+  'aspeed_ast2600_sanmiguel.c',
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
   'aspeed_ast1040.c',
-- 
2.55.0


