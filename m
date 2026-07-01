Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E74C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1F7-0001ua-8s; Wed, 01 Jul 2026 16:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weyma-0008WJ-8y; Wed, 01 Jul 2026 13:31:32 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weymW-00079t-4R; Wed, 01 Jul 2026 13:31:30 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5F4FD2003EF;
 Wed,  1 Jul 2026 19:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1782927085;
 bh=d2xU5ugaq0WYvWO+htoe62DpMagP1np2F5de6Z3kIPE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jgtMba+BGQzvNbdokQlvOv43yndpDuD9hMraeqs4CK9nvBINyPnKSL7WjewFBKhXJ
 t7HZW2jYi8mL8P10Jol5zxWASqSdGX8cqbZxOiFvS53JMBQ0fbTPRUkFlq00Rt+j2a
 iBSTTnahOANj+rQ5z5y1sERF5MXOzxdbn1G7u6qBP6Cuce0Sw0Tr7QbsUyH2MaLJhx
 IQQIjSysmopnAj4R3VhsJpaPXh11q9CypO+iYtwRbunXGEbqMXtcPtwddk/+gSfNso
 /fJESRNq+hEbJbNrIzvP+aA1H6CltAyDFokpel0+6RdVXf3PpWiTI2M2Q1EAk67tRT
 jkcM2GJFeHgqg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Wed, 01 Jul 2026 19:28:37 +0200
Subject: [PATCH v5 7/8] hw/arm: anacapa: add ADC128D818 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-i2c-adc128d818-anacapa-v5-7-fe8292d86b38@free.fr>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, 
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Corey Minyard <cminyard@mvista.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782926919; l=3268;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=d2xU5ugaq0WYvWO+htoe62DpMagP1np2F5de6Z3kIPE=;
 b=G2f9UbP78E3/mm4inv3n5CAYgd2cWd0wg5TGMKQkpapZb2fSs+Fx0xh4uiV4TT3HMp49mwKj1
 3k6r3XSVIBLCYDIlryOSewDARS8guROYNXgmkaK9ywYLVoCgiZwxCcz
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2026 16:09:06 -0400
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

Wire up the two ADC128D818 instances that appear in the Anacapa DTS:
one on i2c8 mux channel 0 and one on i2c13 mux channel 3.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/Kconfig                  |  1 +
 hw/arm/aspeed_ast2600_anacapa.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fb798ccbee..04ecf5d473 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -553,6 +553,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select ADC128D818
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index a1c8111a93..18f759f5f8 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -1,13 +1,14 @@
 /*
  * Facebook Anacapa
  *
- * Copyright (c) Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/sensor/adc128d818.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
@@ -15,7 +16,6 @@
 #include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
 
-/* Anacapa hardware value */
 #define ANACAPA_BMC_HW_STRAP1 0x00002002
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
 #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
@@ -221,6 +221,17 @@ static const uint8_t hpm_brd_id_eeprom[] = {
 };
 static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
 
+static void anacapa_add_adc128d818(I2CBus *bus, uint8_t addr,
+                                   const char *description)
+{
+    DeviceState *dev = DEVICE(i2c_slave_new(TYPE_ADC128D818, addr));
+    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
+
+    qdev_prop_set_string(dev, "description", description);
+    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
+}
+
 static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 {
     /* Reference: aspeed-bmc-facebook-anacapa.dts */
@@ -259,7 +270,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
 
     /* i2c8mux ch0 */
-    /* adc128d818@1f — no model */
+    /* adc128d818@1f — R-PDB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -320,7 +332,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
 
     /* i2c13mux ch3 */
-    /* adc128d818@1f - no model */
+    /* adc128d818@1f — MB ADC (mode 1: 8 voltage channels) */
+    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
 
     /* i2c13mux ch4 */
     /* eeprom@51 */

-- 
2.50.1


