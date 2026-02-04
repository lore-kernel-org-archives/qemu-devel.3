Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A6E95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCU-0003JN-3s; Wed, 04 Feb 2026 05:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBz-0002J1-IV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBx-0004Bg-K5
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0rFcvwj4yKk1qff0VXoGxN4bPKszZ5E/TLKHC096Hs=;
 b=Q5B9du0IDLQ5aQbGPbbU5xJk7eiMmTggYCo3QibVYjnC2hPAO0JIwIA6hD6AoKIdj2Vioz
 V03Nzx4rFm/E6+g5Mdzi9+HPuJDAETOhVrJgJpBJga4LuayRSkeoUBmDhE2f22/PlFXAIQ
 7CvOdvJbEYKqn6fuhq6mUS6/bHnQUAY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-zRiSc9CsMFODM1aTFPE50g-1; Wed,
 04 Feb 2026 05:32:59 -0500
X-MC-Unique: zRiSc9CsMFODM1aTFPE50g-1
X-Mimecast-MFC-AGG-ID: zRiSc9CsMFODM1aTFPE50g_1770201178
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC90719560A7; Wed,  4 Feb 2026 10:32:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38A1618003F6; Wed,  4 Feb 2026 10:32:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/45] hw/arm/aspeed: attach I2C device to AST1700 model
Date: Wed,  4 Feb 2026 11:31:28 +0100
Message-ID: <20260204103136.1795455-38-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kane Chen <kane_chen@aspeedtech.com>

Connect the I2C controller to the AST1700 model by mapping its MMIO
region and wiring its interrupt line.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-15-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 ++
 include/hw/arm/aspeed_soc.h     |  2 ++
 hw/arm/aspeed_ast1700.c         | 19 ++++++++++++
 hw/arm/aspeed_ast27x0.c         | 51 +++++++++++++++++++++++++++++++--
 4 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 63cfcb4c245a..1005ce63645f 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -12,6 +12,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/adc/aspeed_adc.h"
 #include "hw/gpio/aspeed_gpio.h"
+#include "hw/i2c/aspeed_i2c.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/char/serial-mm.h"
@@ -35,6 +36,7 @@ struct AspeedAST1700SoCState {
     AspeedADCState adc;
     AspeedSCUState scu;
     AspeedGPIOState gpio;
+    AspeedI2CState i2c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b051d0eb3a0a..4ea252104137 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -290,6 +290,8 @@ enum {
     ASPEED_DEV_LTPI_CTRL2,
     ASPEED_DEV_LTPI_IO0,
     ASPEED_DEV_LTPI_IO1,
+    ASPEED_DEV_IOEXP0_I2C,
+    ASPEED_DEV_IOEXP1_I2C,
     ASPEED_DEV_IOEXP0_INTCIO,
     ASPEED_DEV_IOEXP1_INTCIO,
 };
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 7efce450f60f..e264b2200bc3 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -22,6 +22,7 @@ enum {
     ASPEED_AST1700_DEV_ADC,
     ASPEED_AST1700_DEV_SCU,
     ASPEED_AST1700_DEV_GPIO,
+    ASPEED_AST1700_DEV_I2C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -33,6 +34,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
     [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
     [ASPEED_AST1700_DEV_GPIO]      =  0x00C0B000,
+    [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -113,6 +115,19 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
+    /* I2C */
+    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);
+    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);
+
+    object_property_set_link(OBJECT(&s->i2c), "dram",
+                             OBJECT(s->dram_mr), errp);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), 0));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -146,6 +161,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-gpio", &s->gpio,
                             "aspeed.gpio-ast2700");
 
+    /* I2C */
+    object_initialize_child(obj, "ioexp-i2c", &s->i2c,
+                            "aspeed.i2c-ast2700");
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index cd4028fcd4c7..8242258df442 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -157,6 +157,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_EHCI4]     = 196,
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
+    [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP1_I2C] = 200,
 };
 
 /* GICINT 192 */
@@ -213,6 +215,18 @@ static const int ast2700_gic197_intcmap[] = {
     [ASPEED_DEV_PECI]      = 4,
 };
 
+/* Primary AST1700 Interrupts */
+/* A1: GICINT 198 */
+static const int ast2700_gic198_intcmap[] = {
+    [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
+};
+
+/* Secondary AST1700 Interrupts */
+/* A1: GINTC 200 */
+static const int ast2700_gic200_intcmap[] = {
+    [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
+};
+
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
@@ -228,9 +242,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {195, 1, 3, ast2700_gic195_intcmap},
     {196, 1, 4, ast2700_gic196_intcmap},
     {197, 1, 5, ast2700_gic197_intcmap},
-    {198, 1, 6, NULL},
+    {198, 2, 0, ast2700_gic198_intcmap},
     {199, 1, 7, NULL},
-    {200, 1, 8, NULL},
+    {200, 3, 0, ast2700_gic200_intcmap},
     {201, 1, 9, NULL},
 };
 
@@ -263,14 +277,23 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
     int or_idx;
     int idx;
     int i;
+    OrIRQState *porgates;
 
     for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
         if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
             assert(ast2700_gic_intcmap[i].ptr);
             or_idx = ast2700_gic_intcmap[i].orgate_idx;
             idx = ast2700_gic_intcmap[i].intc_idx;
-            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+            if (idx < ASPEED_INTC_NUM) {
+                porgates = &a->intc[idx].orgates[or_idx];
+                return qdev_get_gpio_in(DEVICE(porgates),
+                                    ast2700_gic_intcmap[i].ptr[dev] + index);
+            } else {
+                idx -= ASPEED_INTC_NUM;
+                porgates = &a->intcioexp[idx].orgates[or_idx];
+                return qdev_get_gpio_in(DEVICE(porgates),
                                     ast2700_gic_intcmap[i].ptr[dev] + index);
+            }
         }
     }
 
@@ -1025,6 +1048,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* IO Expander */
     for (i = 0; i < sc->ioexp_num; i++) {
+        AspeedI2CClass *i2c_ctl;
+
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
         object_property_set_link(OBJECT(&s->ioexp[i]), "dram",
                                  OBJECT(s->dram_mr), &error_abort);
@@ -1057,6 +1082,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,
                            aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
 
+        /* I2C */
+        i2c_ctl = ASPEED_I2C_GET_CLASS(&s->ioexp[i].i2c);
+        for (int j = 0; j < i2c_ctl->num_busses; j++) {
+            /*
+             * For I2C on AST1700:
+             * I2C bus interrupts are connected to the OR gate from bit 0 to bit
+             * 15, and the OR gate output pin is connected to the input pin of
+             * GICINT192 of IO expander Interrupt controller (INTC2/3). Then,
+             * the output pin is connected to the INTC (CPU Die) input pin, and
+             * its output pin is connected to the GIC.
+             *
+             * I2C bus 0 is connected to the OR gate at bit 0.
+             * I2C bus 15 is connected to the OR gate at bit 15.
+             */
+            irq = aspeed_soc_ast2700_get_irq_index(s,
+                                                   ASPEED_DEV_IOEXP0_I2C + i,
+                                                   j);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].i2c.busses[j]),
+                               0, irq);
+        }
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
-- 
2.52.0


