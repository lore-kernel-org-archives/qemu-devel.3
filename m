Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724ABCA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 04:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usw3A-0006b2-AH; Mon, 01 Sep 2025 00:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqH-0002mo-Bz; Mon, 01 Sep 2025 00:08:31 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1usvqF-000862-6h; Mon, 01 Sep 2025 00:08:29 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 12:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 12:08:09 +0800
To: "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/4] hw/intc/aspeed: Remove GIC 128 - 136
Date: Mon, 1 Sep 2025 12:08:06 +0800
Message-ID: <20250901040808.1454742-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GIC interrupts 128 - 136 were only used by the AST2700 A0 SoC.
Since the AST2700 A0 has been deprecated, these interrupt
definitions are no longer needed. This commit removes them to
clean up the codebase.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 40 +++++++++------------------------
 hw/intc/aspeed_intc.c   | 49 +----------------------------------------
 2 files changed, 12 insertions(+), 77 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2e47e2f860..b0b6849fbb 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -137,37 +137,32 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_SDHCI]     = 197,
 };
 
-/* GICINT 128 */
 /* GICINT 192 */
-static const int ast2700_gic128_gic192_intcmap[] = {
+static const int ast2700_gic192_intcmap[] = {
     [ASPEED_DEV_LPC]       = 0,
     [ASPEED_DEV_IBT]       = 2,
     [ASPEED_DEV_KCS]       = 4,
 };
 
-/* GICINT 129 */
 /* GICINT 193 */
 
-/* GICINT 130 */
 /* GICINT 194 */
-static const int ast2700_gic130_gic194_intcmap[] = {
+static const int ast2700_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
 };
 
-/* GICINT 131 */
 /* GICINT 195 */
-static const int ast2700_gic131_gic195_intcmap[] = {
+static const int ast2700_gic195_intcmap[] = {
     [ASPEED_DEV_I3C]       = 0,
     [ASPEED_DEV_WDT]       = 16,
     [ASPEED_DEV_FMC]       = 25,
     [ASPEED_DEV_PWM]       = 29,
 };
 
-/* GICINT 132 */
 /* GICINT 196 */
-static const int ast2700_gic132_gic196_intcmap[] = {
+static const int ast2700_gic196_intcmap[] = {
     [ASPEED_DEV_ETH1]      = 0,
     [ASPEED_DEV_ETH2]      = 1,
     [ASPEED_DEV_ETH3]      = 2,
@@ -187,14 +182,12 @@ static const int ast2700_gic132_gic196_intcmap[] = {
     [ASPEED_DEV_EHCI4]     = 29,
 };
 
-/* GICINT 133 */
 /* GICINT 197 */
-static const int ast2700_gic133_gic197_intcmap[] = {
+static const int ast2700_gic197_intcmap[] = {
     [ASPEED_DEV_SDHCI]     = 1,
     [ASPEED_DEV_PECI]      = 4,
 };
 
-/* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
@@ -204,25 +197,16 @@ struct gic_intc_irq_info {
 };
 
 static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
-    {192, 1, 0, ast2700_gic128_gic192_intcmap},
+    {192, 1, 0, ast2700_gic192_intcmap},
     {193, 1, 1, NULL},
-    {194, 1, 2, ast2700_gic130_gic194_intcmap},
-    {195, 1, 3, ast2700_gic131_gic195_intcmap},
-    {196, 1, 4, ast2700_gic132_gic196_intcmap},
-    {197, 1, 5, ast2700_gic133_gic197_intcmap},
+    {194, 1, 2, ast2700_gic194_intcmap},
+    {195, 1, 3, ast2700_gic195_intcmap},
+    {196, 1, 4, ast2700_gic196_intcmap},
+    {197, 1, 5, ast2700_gic197_intcmap},
     {198, 1, 6, NULL},
     {199, 1, 7, NULL},
     {200, 1, 8, NULL},
     {201, 1, 9, NULL},
-    {128, 0, 1, ast2700_gic128_gic192_intcmap},
-    {129, 0, 2, NULL},
-    {130, 0, 3, ast2700_gic130_gic194_intcmap},
-    {131, 0, 4, ast2700_gic131_gic195_intcmap},
-    {132, 0, 5, ast2700_gic132_gic196_intcmap},
-    {133, 0, 6, ast2700_gic133_gic197_intcmap},
-    {134, 0, 7, NULL},
-    {135, 0, 8, NULL},
-    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
@@ -266,8 +250,7 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
     }
 
     /*
-     * Invalid OR gate index, device IRQ should be between 128 to 136
-     * and 192 to 201.
+     * Invalid OR gate index, device IRQ should be between 192 to 201.
      */
     g_assert_not_reached();
 }
@@ -622,7 +605,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     }
 
     /* INTC -> GIC192 - GIC201 */
-    /* INTC -> GIC128 - GIC136 */
     for (i = 0; i < ic->num_outpins; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 5cd786dee6..d003566762 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -21,24 +21,6 @@
  * because its memory region is start at 0x1000
  *
  */
-REG32(GICINT128_EN,         0x000)
-REG32(GICINT128_STATUS,     0x004)
-REG32(GICINT129_EN,         0x100)
-REG32(GICINT129_STATUS,     0x104)
-REG32(GICINT130_EN,         0x200)
-REG32(GICINT130_STATUS,     0x204)
-REG32(GICINT131_EN,         0x300)
-REG32(GICINT131_STATUS,     0x304)
-REG32(GICINT132_EN,         0x400)
-REG32(GICINT132_STATUS,     0x404)
-REG32(GICINT133_EN,         0x500)
-REG32(GICINT133_STATUS,     0x504)
-REG32(GICINT134_EN,         0x600)
-REG32(GICINT134_STATUS,     0x604)
-REG32(GICINT135_EN,         0x700)
-REG32(GICINT135_STATUS,     0x704)
-REG32(GICINT136_EN,         0x800)
-REG32(GICINT136_STATUS,     0x804)
 REG32(GICINT192_201_EN,         0xB00)
 REG32(GICINT192_201_STATUS,     0xB04)
 
@@ -507,29 +489,9 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     trace_aspeed_intc_write(name, offset, size, data);
 
     switch (reg) {
-    case R_GICINT128_EN:
-    case R_GICINT129_EN:
-    case R_GICINT130_EN:
-    case R_GICINT131_EN:
-    case R_GICINT132_EN:
-    case R_GICINT133_EN:
-    case R_GICINT134_EN:
-    case R_GICINT135_EN:
-    case R_GICINT136_EN:
     case R_GICINT192_201_EN:
         aspeed_intc_enable_handler(s, offset, data);
         break;
-    case R_GICINT128_STATUS:
-    case R_GICINT129_STATUS:
-    case R_GICINT130_STATUS:
-    case R_GICINT131_STATUS:
-    case R_GICINT132_STATUS:
-    case R_GICINT133_STATUS:
-    case R_GICINT134_STATUS:
-    case R_GICINT135_STATUS:
-    case R_GICINT136_STATUS:
-        aspeed_intc_status_handler(s, offset, data);
-        break;
     case R_GICINT192_201_STATUS:
         aspeed_intc_status_handler_multi_outpins(s, offset, data);
         break;
@@ -891,15 +853,6 @@ static const TypeInfo aspeed_intc_info = {
 
 static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_GICINT192_201_EN, R_GICINT192_201_STATUS},
-    {1, 10, 1, R_GICINT128_EN, R_GICINT128_STATUS},
-    {2, 11, 1, R_GICINT129_EN, R_GICINT129_STATUS},
-    {3, 12, 1, R_GICINT130_EN, R_GICINT130_STATUS},
-    {4, 13, 1, R_GICINT131_EN, R_GICINT131_STATUS},
-    {5, 14, 1, R_GICINT132_EN, R_GICINT132_STATUS},
-    {6, 15, 1, R_GICINT133_EN, R_GICINT133_STATUS},
-    {7, 16, 1, R_GICINT134_EN, R_GICINT134_STATUS},
-    {8, 17, 1, R_GICINT135_EN, R_GICINT135_STATUS},
-    {9, 18, 1, R_GICINT136_EN, R_GICINT136_STATUS},
 };
 
 static void aspeed_2700_intc_class_init(ObjectClass *klass, const void *data)
@@ -910,7 +863,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
     aic->num_inpins = 10;
-    aic->num_outpins = 19;
+    aic->num_outpins = 10;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0xB08 >> 2;
     aic->reg_offset = 0x1000;
-- 
2.43.0


