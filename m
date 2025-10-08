Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C66ECCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6KlF-0001r1-QR; Tue, 07 Oct 2025 23:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6KlE-0001qj-C3; Tue, 07 Oct 2025 23:22:40 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6KlB-0000T8-IQ; Tue, 07 Oct 2025 23:22:40 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 07/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_soc_get_irq() API
Date: Wed, 8 Oct 2025 11:21:52 +0800
Message-ID: <20251008032207.593353-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Refactor IRQ helper to decouple from SoC state. The public
aspeed_soc_get_irq() now takes a function pointer and opaque context
(qemu_irq (*fn)(void *ctx, int dev), void *ctx, int dev) instead of an
AspeedSoCState *.

Update AspeedSoCClass::get_irq signature to (void *ctx, int dev) and
convert all SoC-specific implementations (AST1030/2400/2600/27x0 SSP/TSP
and AST2700) to accept void *ctx.

Adjust all call sites to pass sc->get_irq and s explicitly, and wire
through in aspeed_soc_uart_realize() and relevant realize paths.

This change removes a hard dependency on AspeedSoCState, enabling reuse
from other classes and simplifying future refactors.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  5 +++--
 hw/arm/aspeed_ast10x0.c     | 18 ++++++++++--------
 hw/arm/aspeed_ast2400.c     | 32 ++++++++++++++++++--------------
 hw/arm/aspeed_ast2600.c     | 37 +++++++++++++++++++++----------------
 hw/arm/aspeed_ast27x0-ssp.c |  3 ++-
 hw/arm/aspeed_ast27x0-tsp.c |  3 ++-
 hw/arm/aspeed_ast27x0.c     | 27 +++++++++++++++------------
 hw/arm/aspeed_soc_common.c  |  8 +++++---
 8 files changed, 76 insertions(+), 57 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 957362b88d..427708c087 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -198,7 +198,7 @@ struct AspeedSoCClass {
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
-    qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
+    qemu_irq (*get_irq)(void *ctx, int dev);
     bool (*boot_from_emmc)(AspeedSoCState *s);
 };
 
@@ -303,7 +303,8 @@ enum {
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
-qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
+qemu_irq aspeed_soc_get_irq(qemu_irq (*fn)(void *ctx, int dev),
+                            void *ctx, int dev);
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
                              int uarts_num, Chardev *chr);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e861b6dad6..3ce866c66a 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -99,8 +99,9 @@ static const int aspeed_soc_ast1030_irqmap[] = {
     [ASPEED_DEV_JTAG1]     = 53,
 };
 
-static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast1030_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
@@ -283,7 +284,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -294,7 +295,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
 
     /*
      * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
@@ -329,7 +330,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_get_irq(sc->get_irq, s,
+                                          ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -340,7 +342,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram),
@@ -353,7 +355,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
@@ -384,7 +386,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
 
     /* Watch dog */
     for (i = 0; i < sc->wdts_num; i++) {
@@ -406,7 +408,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index e0604851a5..2910c40807 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -134,8 +134,9 @@ static const int aspeed_soc_ast2400_irqmap[] = {
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
 
-static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast2400_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed2400SoCState *a = ASPEED2400_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
@@ -312,7 +313,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -323,7 +324,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_get_irq(sc->get_irq, s,
+                                          ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -334,7 +336,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
 
     /* UART */
     if (!aspeed_soc_uart_realize(s, errp)) {
@@ -350,7 +352,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
                     sc->memmap[ASPEED_DEV_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_I2C));
 
     /* PECI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
@@ -359,7 +361,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
@@ -372,7 +374,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -399,7 +401,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
@@ -437,7 +440,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_ETH1 + i));
     }
 
     /* XDMA */
@@ -447,7 +451,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
@@ -456,7 +460,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -465,7 +469,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -476,7 +480,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
     /* Connect the LPC IRQ to the VIC */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
 
     /*
      * On the AST2400 and AST2500 the one LPC IRQ is shared between all of the
@@ -508,7 +512,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
 }
 
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index ed0985a16e..cd14dc95bb 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -144,8 +144,9 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_I3C]       = 102,   /* 102 -> 107 */
 };
 
-static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast2600_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed2600SoCState *a = ASPEED2600_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
@@ -463,7 +464,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -474,7 +475,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -485,7 +486,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
 
     /* UART */
     if (!aspeed_soc_uart_realize(s, errp)) {
@@ -514,7 +515,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PECI));
 
     /* PCIe Root Complex (RC) */
     if (!aspeed_soc_ast2600_pcie_realize(dev, errp)) {
@@ -532,7 +533,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -561,7 +562,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
@@ -599,7 +601,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
@@ -618,7 +621,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
@@ -627,7 +630,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
@@ -635,7 +638,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                     sc->memmap[ASPEED_DEV_GPIO_1_8V]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
+                       aspeed_soc_get_irq(sc->get_irq, s,
+                                          ASPEED_DEV_GPIO_1_8V));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -644,7 +648,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
 
     /* eMMC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
@@ -653,7 +657,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_EMMC));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -664,7 +668,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_LPC));
 
     /*
      * On the AST2600 LPC subdevice IRQs are connected straight to the GIC.
@@ -699,7 +703,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
 
     /* I3C */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
@@ -729,7 +733,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
                         sc->memmap[ASPEED_DEV_FSI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_FSI1 + i));
     }
 }
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 99a3de15b5..e63a4b3ad3 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -104,8 +104,9 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
     {136, 0, 9, NULL},
 };
 
-static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast27x0ssp_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 568d7555e2..9537ce121c 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -104,8 +104,9 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
     {136, 0, 9, NULL},
 };
 
-static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9b645c6c55..9a53f51ec5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -286,8 +286,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {136, 0, 9, NULL},
 };
 
-static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
+static qemu_irq aspeed_soc_ast2700_get_irq(void *ctx, int dev)
 {
+    AspeedSoCState *s = (AspeedSoCState *)ctx;
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int or_idx;
@@ -660,7 +661,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE0 + i]);
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
+        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_PCIE0 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
 
         mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[i].rc), 1);
@@ -806,7 +807,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -835,7 +836,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_EHCI1 + i));
     }
 
     /*
@@ -870,7 +872,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_get_irq(sc->get_irq, s,
+                                              ASPEED_DEV_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
@@ -915,7 +918,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_ADC));
 
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
@@ -956,7 +959,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_GPIO));
 
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
@@ -965,7 +968,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_RTC));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -974,7 +977,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_SDHCI));
 
     /* eMMC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
@@ -983,7 +986,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_EMMC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -994,7 +997,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        irq = aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -1007,7 +1010,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_get_irq(sc->get_irq, s, ASPEED_DEV_HACE));
 
     /* PCIe Root Complex (RC) */
     if (!aspeed_soc_ast2700_pcie_realize(dev, errp)) {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index e7d0a9c290..2bd872d9a6 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -30,9 +30,10 @@ const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types)
     return valid_cpu_types[0];
 }
 
-qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
+qemu_irq aspeed_soc_get_irq(qemu_irq (*fn)(void *ctx, int dev),
+                            void *ctx, int dev)
 {
-    return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
+    return fn(ctx, dev);
 }
 
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
@@ -52,7 +53,8 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
             return false;
         }
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
+        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0,
+                           aspeed_soc_get_irq(sc->get_irq, s, uart));
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
     }
 
-- 
2.43.0


