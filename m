Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6KlA-0001pq-Go; Tue, 07 Oct 2025 23:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl7-0001oU-Rs; Tue, 07 Oct 2025 23:22:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl4-0000T8-6b; Tue, 07 Oct 2025 23:22:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:09 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 05/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_mmio_map() API
Date: Wed, 8 Oct 2025 11:21:50 +0800
Message-ID: <20251008032207.593353-6-jamin_lin@aspeedtech.com>
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

Refactor aspeed_mmio_map() to take MemoryRegion * instead of
AspeedSoCState *, making the MMIO mapping helper more generic and
decoupled from SoC state.

Update all call sites to pass s->memory (or equivalent) explicitly.
Touched files include: headers, aspeed_soc_common.c, and SoC realize
paths in AST10x0/2400/2600/27x0 (SSP/TSP) and AST2700.

This reduces coupling, improves reuse across variants, and clarifies the
API boundary between SoC state and memory mapping.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  3 +-
 hw/arm/aspeed_ast10x0.c     | 37 ++++++++++++---------
 hw/arm/aspeed_ast2400.c     | 47 +++++++++++++++------------
 hw/arm/aspeed_ast2600.c     | 65 +++++++++++++++++++++----------------
 hw/arm/aspeed_ast27x0-ssp.c |  7 ++--
 hw/arm/aspeed_ast27x0-tsp.c |  7 ++--
 hw/arm/aspeed_ast27x0.c     | 60 +++++++++++++++++++---------------
 hw/arm/aspeed_soc_common.c  |  8 ++---
 8 files changed, 133 insertions(+), 101 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 385b657b50..606cf6bb61 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -308,7 +308,8 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
                              int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
-void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr);
+void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
+                     hwaddr addr);
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                    const char *name, hwaddr addr,
                                    uint64_t size);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index dab012aa95..caa9feb667 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -242,7 +242,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* I2C */
 
@@ -251,7 +252,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&a->armv7m),
                                         sc->irqmap[ASPEED_DEV_I2C] + i);
@@ -263,7 +265,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
+                    sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&a->armv7m),
                                         sc->irqmap[ASPEED_DEV_I3C] + i);
@@ -275,7 +278,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -284,7 +287,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -320,7 +324,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -331,7 +335,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -341,8 +346,9 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -354,9 +360,9 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -364,7 +370,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV_SBC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
+                    sc->memmap[ASPEED_DEV_SBC]);
 
     /* HACE */
     object_property_set_link(OBJECT(&s->hace), "dram", OBJECT(&s->sram),
@@ -372,7 +379,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
@@ -387,14 +394,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 53c2a5156d..6690752215 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -289,13 +289,15 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* VIC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->vic), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->vic), 0, sc->memmap[ASPEED_DEV_VIC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->vic), 0,
+                    sc->memmap[ASPEED_DEV_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 0,
                        qdev_get_gpio_in(DEVICE(&a->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 1,
@@ -305,7 +307,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -315,7 +318,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -326,7 +329,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -341,7 +345,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
 
@@ -349,7 +354,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -360,8 +365,9 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -377,9 +383,9 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -388,7 +394,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -398,7 +404,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
@@ -411,7 +417,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* RAM  */
@@ -426,7 +432,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -436,7 +442,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->xdma), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
@@ -445,7 +451,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -454,7 +460,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -463,7 +469,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the VIC */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -496,7 +503,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 0299d97929..bf0ecde051 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -324,7 +324,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[0]), errp)) {
         return false;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
                     sc->memmap[ASPEED_DEV_PCIE_PHY1]);
 
     object_property_set_int(OBJECT(&s->pcie[0]), "dram-base",
@@ -335,7 +335,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[0]), errp)) {
         return false;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[0]), 0,
                     sc->memmap[ASPEED_DEV_PCIE0]);
 
     irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
@@ -414,7 +414,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                             &error_abort);
 
     sysbus_realize(SYS_BUS_DEVICE(&a->a7mpcore), &error_abort);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->a7mpcore), 0,
+                    ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < sc->num_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&a->a7mpcore);
@@ -448,13 +449,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -464,7 +467,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -475,7 +478,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -490,7 +494,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I2C] + i);
@@ -502,7 +507,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -518,8 +523,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -537,9 +543,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -548,7 +554,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -558,7 +564,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
@@ -571,7 +577,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* RAM */
@@ -586,7 +592,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -597,7 +603,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->mii[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->mii[i]), 0,
                         sc->memmap[ASPEED_DEV_MII1 + i]);
     }
 
@@ -605,7 +611,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->xdma), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
@@ -614,7 +620,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -622,7 +628,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                     sc->memmap[ASPEED_DEV_GPIO_1_8V]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
@@ -631,7 +637,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -640,7 +646,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->emmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
@@ -649,7 +655,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -685,7 +692,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
@@ -694,7 +701,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
+                    sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
         irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I3C] + i);
@@ -706,14 +714,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV_SBC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
+                    sc->memmap[ASPEED_DEV_SBC]);
 
     /* FSI */
     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fsi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
                         sc->memmap[ASPEED_DEV_FSI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 490e98b924..83cf3c14b6 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -196,14 +196,15 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -211,7 +212,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq source orgates -> INTC0 */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index d83f90ef00..86aa565608 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -196,14 +196,15 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -211,7 +212,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq source orgates -> INTC */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2f018e9e58..8db67dc806 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -589,9 +589,9 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
         return false;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->gic), 0,
                     sc->memmap[ASPEED_GIC_DIST]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->gic), 1,
                     sc->memmap[ASPEED_GIC_REDIST]);
 
     for (i = 0; i < sc->num_cpus; i++) {
@@ -647,7 +647,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[i]), errp)) {
             return false;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE_PHY0 + i]);
 
         object_property_set_int(OBJECT(&s->pcie[i]), "dram-base",
@@ -658,7 +658,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[i]), errp)) {
             return false;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE0 + i]);
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
@@ -719,7 +719,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -727,7 +727,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq sources -> orgates -> INTC */
@@ -777,13 +777,14 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* SCU1 */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scuio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scuio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scuio), 0,
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
     /* UART */
@@ -800,8 +801,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -819,9 +821,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI0 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -830,7 +832,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -848,7 +850,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* RAM */
@@ -865,7 +867,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -876,7 +878,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->mii[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->mii[i]), 0,
                         sc->memmap[ASPEED_DEV_MII1 + i]);
     }
 
@@ -890,26 +892,28 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* SLI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sli), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sli), 0, sc->memmap[ASPEED_DEV_SLI]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sli), 0,
+                    sc->memmap[ASPEED_DEV_SLI]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sliio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sliio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sliio), 0,
                     sc->memmap[ASPEED_DEV_SLIIO]);
 
     /* ADC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -919,7 +923,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         /*
          * The AST2700 I2C controller has one source INTC per bus.
@@ -948,7 +953,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -957,7 +962,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -965,7 +971,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -974,7 +980,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->emmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
@@ -985,7 +991,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -998,7 +1004,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 16c7c4bb78..ca4e589dce 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -53,7 +53,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
         }
 
         sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
     }
 
     return true;
@@ -111,10 +111,10 @@ bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
     return true;
 }
 
-void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr)
+void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
+                     hwaddr addr)
 {
-    memory_region_add_subregion(s->memory, addr,
-                                sysbus_mmio_get_region(dev, n));
+    memory_region_add_subregion(memory, addr, sysbus_mmio_get_region(dev, n));
 }
 
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
-- 
2.43.0


