Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A08CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BM1-0007yL-Ve; Mon, 13 Oct 2025 01:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BM0-0007y4-Nb; Mon, 13 Oct 2025 01:44:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BLx-0002DU-Lp; Mon, 13 Oct 2025 01:44:16 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 13 Oct
 2025 13:43:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 13:43:37 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 08/16] hw/arm/aspeed: Remove the aspeed_soc_get_irq and
 class get_irq hook
Date: Mon, 13 Oct 2025 13:43:20 +0800
Message-ID: <20251013054334.955331-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
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

Remove the the common aspeed_soc_get_irq. Call sites are updated to use the
SoC-specific get_irq helpers directly (aspeed_soc_ast1030_get_irq(),
_aspeed2400_get_irq(), _ast2600_get_irq(), _ast27x0ssp_get_irq(),
_ast27x0tsp_get_irq(), and _ast2700_get_irq())

This makes the IRQ lookup explicit per-SoC and drops the exported
API that depended on AspeedSoCState, reducing cross-module coupling
in the common layer.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 --
 hw/arm/aspeed_ast10x0.c     | 17 ++++++++---------
 hw/arm/aspeed_ast2400.c     | 31 +++++++++++++++----------------
 hw/arm/aspeed_ast2600.c     | 34 +++++++++++++++++-----------------
 hw/arm/aspeed_ast27x0-ssp.c |  3 +--
 hw/arm/aspeed_ast27x0-tsp.c |  3 +--
 hw/arm/aspeed_ast27x0.c     | 27 +++++++++++++--------------
 hw/arm/aspeed_soc_common.c  |  5 -----
 8 files changed, 55 insertions(+), 67 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 47341ea2fd..0e07c079f0 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -198,7 +198,6 @@ struct AspeedSoCClass {
     const int *irqmap;
     const hwaddr *memmap;
     uint32_t num_cpus;
-    qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
     bool (*boot_from_emmc)(AspeedSoCState *s);
 };
 
@@ -303,7 +302,6 @@ enum {
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
-qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
 bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
                              const hwaddr addr, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index ff781379c1..7f49c13391 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -284,7 +284,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_PECI));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -295,7 +295,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_LPC));
 
     /*
      * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
@@ -323,7 +323,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast1030_get_irq(s, uart));
     }
 
     /* Timer */
@@ -335,7 +335,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -346,7 +346,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_ADC));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram),
@@ -359,7 +359,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_FMC));
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
@@ -390,7 +390,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_HACE));
 
     /* Watch dog */
     for (i = 0; i < sc->wdts_num; i++) {
@@ -412,7 +412,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
                                   "aspeed.pwm",
@@ -463,7 +463,6 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
     sc->irqmap = aspeed_soc_ast1030_irqmap;
     sc->memmap = aspeed_soc_ast1030_memmap;
     sc->num_cpus = 1;
-    sc->get_irq = aspeed_soc_ast1030_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast10x0_types[] = {
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 8d4d6564c7..b1b826b7e0 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -313,7 +313,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -324,7 +324,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        qemu_irq irq = aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -335,7 +335,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
     for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
@@ -344,7 +344,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast2400_get_irq(s, uart));
     }
 
     /* I2C */
@@ -356,7 +356,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
                     sc->memmap[ASPEED_DEV_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_I2C));
 
     /* PECI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
@@ -365,7 +365,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_PECI));
 
     /* FMC, The number of CS is set at the board level */
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
@@ -378,7 +378,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -405,7 +405,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_ast2400_get_irq(s,
+                                                      ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
@@ -443,7 +444,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_ETH1 + i));
     }
 
     /* XDMA */
@@ -453,7 +454,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
@@ -462,7 +463,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_GPIO));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -471,7 +472,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_SDHCI));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -482,7 +483,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
     /* Connect the LPC IRQ to the VIC */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_LPC));
 
     /*
      * On the AST2400 and AST2500 the one LPC IRQ is shared between all of the
@@ -514,7 +515,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_ast2400_get_irq(s, ASPEED_DEV_HACE));
 }
 
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
@@ -542,7 +543,6 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
     sc->irqmap       = aspeed_soc_ast2400_irqmap;
     sc->memmap       = aspeed_soc_ast2400_memmap;
     sc->num_cpus     = 1;
-    sc->get_irq      = aspeed_soc_ast2400_get_irq;
 }
 
 static void aspeed_soc_ast2500_class_init(ObjectClass *oc, const void *data)
@@ -570,7 +570,6 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, const void *data)
     sc->irqmap       = aspeed_soc_ast2500_irqmap;
     sc->memmap       = aspeed_soc_ast2500_memmap;
     sc->num_cpus     = 1;
-    sc->get_irq      = aspeed_soc_ast2400_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast2400_types[] = {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index f508bf53e7..498d1ecc07 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -464,7 +464,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_RTC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -475,7 +475,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        irq = aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -486,7 +486,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
     for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
@@ -495,7 +495,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast2600_get_irq(s, uart));
     }
 
     /* I2C */
@@ -520,7 +520,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_PECI));
 
     /* PCIe Root Complex (RC) */
     if (!aspeed_soc_ast2600_pcie_realize(dev, errp)) {
@@ -538,7 +538,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -567,7 +567,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_ast2600_get_irq(s,
+                                                      ASPEED_DEV_EHCI1 + i));
     }
 
     /* SDMC - SDRAM Memory Controller */
@@ -605,7 +606,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
@@ -624,7 +625,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_XDMA));
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
@@ -633,7 +634,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_GPIO));
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
@@ -641,7 +642,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                     sc->memmap[ASPEED_DEV_GPIO_1_8V]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_GPIO_1_8V));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -650,7 +651,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SDHCI));
 
     /* eMMC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
@@ -659,7 +660,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EMMC));
 
     /* LPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
@@ -670,7 +671,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_LPC));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_LPC));
 
     /*
      * On the AST2600 LPC subdevice IRQs are connected straight to the GIC.
@@ -705,7 +706,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));
 
     /* I3C */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
@@ -735,7 +736,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
                         sc->memmap[ASPEED_DEV_FSI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
+                           aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_FSI1 + i));
     }
 }
 
@@ -771,7 +772,6 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
     sc->memmap       = aspeed_soc_ast2600_memmap;
     sc->num_cpus     = 2;
-    sc->get_irq      = aspeed_soc_ast2600_get_irq;
     sc->boot_from_emmc = aspeed_soc_ast2600_boot_from_emmc;
 }
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 7420ae04ac..f90d144372 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -244,7 +244,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast27x0ssp_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
@@ -286,7 +286,6 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *dat
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
     sc->memmap = aspeed_soc_ast27x0ssp_memmap;
     sc->num_cpus = 1;
-    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index b764147a33..8643f82683 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -244,7 +244,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast27x0tsp_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
@@ -286,7 +286,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
     sc->memmap = aspeed_soc_ast27x0tsp_memmap;
     sc->num_cpus = 1;
-    sc->get_irq = aspeed_soc_ast27x0tsp_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 96882b8755..c484bcd4e2 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -660,7 +660,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE0 + i]);
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
+        irq = aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_PCIE0 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
 
         mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[i].rc), 1);
@@ -795,7 +795,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_get_irq(s, uart));
+                           aspeed_soc_ast2700_get_irq(s, uart));
     }
 
     /* FMC, The number of CS is set at the board level */
@@ -812,7 +812,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_FMC));
 
     /* Set up an alias on the FMC CE0 region (boot default) */
     MemoryRegion *fmc0_mmio = &s->fmc.flashes[0].mmio;
@@ -841,7 +841,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
+                           aspeed_soc_ast2700_get_irq(s,
+                                                      ASPEED_DEV_EHCI1 + i));
     }
 
     /*
@@ -876,7 +877,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
-                           aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
@@ -921,7 +922,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC));
 
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
@@ -962,7 +963,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO));
 
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
@@ -971,7 +972,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
                     sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_RTC));
 
     /* SDHCI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
@@ -980,7 +981,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SDHCI));
 
     /* eMMC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
@@ -989,7 +990,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
@@ -1000,7 +1001,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
-        irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
+        irq = aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_TIMER1 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
     }
 
@@ -1013,7 +1014,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
-                       aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
+                       aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_HACE));
 
     /* PCIe Root Complex (RC) */
     if (!aspeed_soc_ast2700_pcie_realize(dev, errp)) {
@@ -1068,7 +1069,6 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a0_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
-    sc->get_irq      = aspeed_soc_ast2700_get_irq;
 }
 
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
@@ -1097,7 +1097,6 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
-    sc->get_irq      = aspeed_soc_ast2700_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast27x0_types[] = {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a785a50609..78b6ae18f8 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -30,11 +30,6 @@ const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types)
     return valid_cpu_types[0];
 }
 
-qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
-{
-    return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
-}
-
 bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
                              const hwaddr addr, Error **errp)
 {
-- 
2.43.0


