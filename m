Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB00CAC592
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh20-0006Ic-Tn; Tue, 16 Sep 2025 21:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1y-0006Hh-TV; Tue, 16 Sep 2025 21:32:23 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1w-0006vf-KY; Tue, 16 Sep 2025 21:32:22 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:45 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:45 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 6/6] hw/arm/aspeed: Model AST1700 IO expander I2C on AST27x0
Date: Wed, 17 Sep 2025 09:31:41 +0800
Message-ID: <20250917013143.1600377-7-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
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

Each AST1700 IO expander integrates a multi-function I2C controller
with 16 buses. Model this controller in the AST1700 child and expose
its MMIO on AST27x0 machines.

Addressing:
- slot 0 (IO0): 0x30000000 + 0x00C0F000 = 0x30C0F000
- slot 1 (IO1): 0x50000000 + 0x00C0F000 = 0x50C0F000

Interrupts:
- add IO expander I2C interrupt sources and connect per-bus IRQs
  (bits 0-15) to the AST27x0 interrupt fabric, following the same
  fan-out used by on-SoC I2C. Each AST1700 I2C bus i emits one IRQ
  which is wired via ASPEED_DEV_IOEXP{0,1}_I2C index i.

Enumeration:
- the on-SoC AST27x0 exposes 16 I2C adapters (i2c-0 ~ i2c-15)
- first AST1700 expands to i2c-16 ~ i2c-31
- second AST1700 expands to i2c-32 ~ i2c-47

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 +
 hw/arm/aspeed_ast27x0.c     | 73 +++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 290bb7a6cf..c1702c96e3 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -307,6 +307,8 @@ enum {
     ASPEED_DEV_IPC1,
     ASPEED_DEV_LTPI_CTRL1,
     ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_IOEXP0_I2C,
+    ASPEED_DEV_IOEXP1_I2C,
     ASPEED_DEV_IOEXP0_INTCIO,
     ASPEED_DEV_IOEXP1_INTCIO,
 };
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d192534e9e..5f54858046 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -201,6 +201,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_ETH3]      = 196,
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
+    [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP1_I2C] = 200,
 };
 
 /* GICINT 128 */
@@ -260,6 +262,28 @@ static const int ast2700_gic133_gic197_intcmap[] = {
     [ASPEED_DEV_PECI]      = 4,
 };
 
+/* Primary AST1700 Interrupts */
+/* A1: GICINT 198 */
+static const int ast2700_gic198_intcmap[] = {
+    [ASPEED_DEV_IOEXP0_I2C]       = 0, /* 0 - 15 */
+};
+
+/* Primary AST1700 Interrupts */
+/* A1: GINTC 199 */
+static const int ast2700_gic199_intcmap[] = {
+};
+
+/* Secondary AST1700 Interrupts */
+/* A1: GINTC 200 */
+static const int ast2700_gic200_intcmap[] = {
+    [ASPEED_DEV_IOEXP1_I2C]       = 0, /* 0 - 15 */
+};
+
+/* Secondary AST1700 Interrupts */
+/* A1: GINTC 201 */
+static const int ast2700_gic201_intcmap[] = {
+};
+
 /* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
@@ -276,10 +300,10 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {195, 1, 3, ast2700_gic131_gic195_intcmap},
     {196, 1, 4, ast2700_gic132_gic196_intcmap},
     {197, 1, 5, ast2700_gic133_gic197_intcmap},
-    {198, 1, 6, NULL},
-    {199, 1, 7, NULL},
-    {200, 1, 8, NULL},
-    {201, 1, 9, NULL},
+    {198, 2, 0, ast2700_gic198_intcmap},
+    {199, 2, 1, ast2700_gic199_intcmap},
+    {200, 3, 0, ast2700_gic200_intcmap},
+    {201, 3, 1, ast2700_gic201_intcmap},
     {128, 0, 1, ast2700_gic128_gic192_intcmap},
     {129, 0, 2, NULL},
     {130, 0, 3, ast2700_gic130_gic194_intcmap},
@@ -557,8 +581,18 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
 static void aspeed_ast2700_ast1700_init(AspeedSoCState *s, int i)
 {
+    char socname[8];
+    char typename[64];
+
+    if (sscanf(object_get_typename(OBJECT(s)), "%7s", socname) != 1) {
+        g_assert_not_reached();
+    }
+
     object_initialize_child(OBJECT(s), "uart[*]", &s->ioexp[i].uart,
                             TYPE_SERIAL_MM);
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
+    object_initialize_child(OBJECT(s), "ioexp-i2c[*]", &s->ioexp[i].i2c,
+                            typename);
     object_initialize_child(OBJECT(s), "ltpi-ctrl[*]",
                             &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
 }
@@ -652,8 +686,11 @@ static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
     int i;
     hwaddr uart_base = sc->memmap[ASPEED_DEV_LTPI_IO0 + index] +
                        aspeed_soc_ast1700_memmap[ASPEED_DEV_UART12];
+    AspeedI2CClass *i2c_ctl = ASPEED_I2C_GET_CLASS(&s->ioexp[index].i2c);
     AspeedLTPIState *ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[index]);
     hwaddr ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + index];
+    qemu_irq irq;
+
     smm = &s->ioexp[index].uart;
 
     /* Chardev property is set by the machine. */
@@ -683,6 +720,34 @@ static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
     }
 
     aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, uart_base);
+
+    /* I2C */
+    object_property_set_link(OBJECT(&s->ioexp[index].i2c), "dram",
+                             OBJECT(s->dram_mr), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[index].i2c), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ioexp[index].i2c), 0,
+                    sc->memmap[ASPEED_DEV_LTPI_IO0 + index] +
+                    aspeed_soc_ast1700_memmap[ASPEED_DEV_I2C]);
+    for (i = 0; i < i2c_ctl->num_busses; i++) {
+        /*
+         * For I2C on AST1700:
+         * I2C bus interrupts are connected to the OR gate from bit 0 to bit
+         * 15, and the OR gate output pin is connected to the input pin of
+         * GICINT192 of IO expander Interrupt controller (INTC2/3). Then,
+         * the output pin is connected to the INTC (CPU Die) input pin, and
+         * its output pin is connected to the GIC.
+         *
+         * I2C bus 0 is connected to the OR gate at bit 0.
+         * I2C bus 15 is connected to the OR gate at bit 15.
+         */
+        irq = aspeed_soc_ast2700_get_irq_index(s,
+                                               ASPEED_DEV_IOEXP0_I2C + index,
+                                               i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[index].i2c.busses[i]),
+                           0, irq);
+    }
 }
 
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


