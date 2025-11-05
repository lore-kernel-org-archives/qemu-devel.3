Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEEECCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUgo-00082y-CX; Tue, 04 Nov 2025 23:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgm-00082h-GR; Tue, 04 Nov 2025 23:00:04 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgk-0008AS-Nv; Tue, 04 Nov 2025 23:00:04 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:04 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:04 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 13/17] hw/arm/aspeed: Attach I2C device to AST1700 model
Date: Wed, 5 Nov 2025 11:58:51 +0800
Message-ID: <20251105035859.3709907-14-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Connect the I2C controller to the AST1700 model by mapping its MMIO
region and wiring its interrupt line.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h      |  2 ++
 include/hw/misc/aspeed_ast1700.h |  1 +
 hw/arm/aspeed_ast27x0.c          | 39 ++++++++++++++++++++++++++++++--
 hw/misc/aspeed_ast1700.c         | 17 ++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 66a6a073f6..464ef2d755 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -283,6 +283,8 @@ enum {
     ASPEED_DEV_IPC1,
     ASPEED_DEV_LTPI_CTRL1,
     ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_IOEXP0_I2C,
+    ASPEED_DEV_IOEXP1_I2C,
     ASPEED_DEV_IOEXP0_INTCIO,
     ASPEED_DEV_IOEXP1_INTCIO,
 };
diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index 37bbb7932f..4aefb7ea35 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -38,6 +38,7 @@ struct AspeedAST1700SoCState {
     AspeedADCState adc;
     AspeedSCUState scu;
     AspeedGPIOState gpio;
+    AspeedI2CState i2c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index fb03fbebfd..a5d98f541b 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -199,6 +199,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_ETH3]      = 196,
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
+    [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP1_I2C] = 200,
 };
 
 /* GICINT 128 */
@@ -259,6 +261,17 @@ static const int ast2700_gic133_gic197_intcmap[] = {
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
 /* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
@@ -275,9 +288,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {195, 1, 3, ast2700_gic131_gic195_intcmap},
     {196, 1, 4, ast2700_gic132_gic196_intcmap},
     {197, 1, 5, ast2700_gic133_gic197_intcmap},
-    {198, 1, 6, NULL},
+    {198, 2, 0, ast2700_gic198_intcmap},
     {199, 1, 7, NULL},
-    {200, 1, 8, NULL},
+    {200, 3, 0, ast2700_gic200_intcmap},
     {201, 1, 9, NULL},
     {128, 0, 1, ast2700_gic128_gic192_intcmap},
     {129, 0, 2, NULL},
@@ -708,6 +721,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     qemu_irq irq;
     int uart;
     int j;
+    AspeedI2CClass *i2c_ctl;
     AspeedLTPIState *ltpi_ctrl;
     hwaddr ltpi_base;
 
@@ -1102,6 +1116,27 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         /* GPIO */
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,
                            aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
+
+        /* I2C */
+        i2c_ctl = ASPEED_I2C_GET_CLASS(&s->ioexp[i].i2c);
+        for (j = 0; j < i2c_ctl->num_busses; j++) {
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
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index 2b2934155b..6c7483c88c 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -25,6 +25,7 @@ enum {
     ASPEED_AST1700_DEV_ADC,
     ASPEED_AST1700_DEV_SCU,
     ASPEED_AST1700_DEV_GPIO,
+    ASPEED_AST1700_DEV_I2C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
     ASPEED_AST1700_DEV_SPI0_MEM,
@@ -36,6 +37,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
     [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
     [ASPEED_AST1700_DEV_GPIO]      =  0x00C0B000,
+    [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
@@ -126,6 +128,16 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
+    /* I2C */
+    object_property_set_link(OBJECT(&s->i2c), "dram",
+                             OBJECT(&s->iomem), &error_abort);
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
@@ -166,6 +178,11 @@ static void aspeed_ast1700_instance_init(Object *obj)
     /* GPIO */
     snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
     object_initialize_child(obj, "ioexp-gpio[*]", &s->gpio, typename);
+
+    /* I2C */
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
+    object_initialize_child(obj, "ioexp-i2c[*]", &s->i2c,
+                            typename);
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
-- 
2.43.0


