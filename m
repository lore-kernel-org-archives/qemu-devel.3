Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4B7CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BLz-0007xg-9Y; Mon, 13 Oct 2025 01:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BLw-0007x3-Oe; Mon, 13 Oct 2025 01:44:12 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BLu-0002DU-NF; Mon, 13 Oct 2025 01:44:12 -0400
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
Subject: [PATCH v3 07/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_soc_uart_realize() API
Date: Mon, 13 Oct 2025 13:43:19 +0800
Message-ID: <20251013054334.955331-8-jamin_lin@aspeedtech.com>
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

Refactor aspeed_soc_uart_realize() to take MemoryRegion *, SerialMM *,
and MMIO base addr instead of AspeedSoCState *, decoupling the helper
from SoC state and making it reusable per-UART.

The helper now realizes a single UART instance and maps its MMIO.
IRQ wiring and iteration over all UARTs are moved to callers.

Update call sites in AST1030, AST2400, AST2600, AST27x0 SSP/TSP, and
AST2700 to loop over UARTs, call the new helper, and connect IRQ via
aspeed_soc_get_irq().

This simplifies the UART realize path and reduces cross-module coupling.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed_ast10x0.c     | 10 ++++++++--
 hw/arm/aspeed_ast2400.c     | 10 ++++++++--
 hw/arm/aspeed_ast2600.c     | 10 ++++++++--
 hw/arm/aspeed_ast27x0-ssp.c | 10 ++++++++--
 hw/arm/aspeed_ast27x0-tsp.c | 10 ++++++++--
 hw/arm/aspeed_ast27x0.c     | 10 ++++++++--
 hw/arm/aspeed_soc_common.c  | 28 ++++++++++------------------
 8 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 957362b88d..47341ea2fd 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -304,7 +304,8 @@ enum {
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
-bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
+bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
+                             const hwaddr addr, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
                              int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e861b6dad6..ff781379c1 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -192,6 +192,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     Error *err = NULL;
+    int uart;
     int i;
     g_autofree char *sram_name = NULL;
 
@@ -316,8 +317,13 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* Timer */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index e0604851a5..8d4d6564c7 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -251,6 +251,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     g_autofree char *sram_name = NULL;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -337,8 +338,13 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* I2C */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index ed0985a16e..f508bf53e7 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -362,6 +362,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     qemu_irq irq;
     g_autofree char *sram_name = NULL;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -488,8 +489,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* I2C */
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 99a3de15b5..7420ae04ac 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -164,6 +164,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
+    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -237,8 +238,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 568d7555e2..b764147a33 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -164,6 +164,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
+    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -237,8 +238,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9b645c6c55..96882b8755 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -687,6 +687,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     AspeedINTCClass *icio = ASPEED_INTC_GET_CLASS(&a->intc[1]);
     g_autofree char *name = NULL;
     qemu_irq irq;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -788,8 +789,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* FMC, The number of CS is set at the board level */
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index e7d0a9c290..a785a50609 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -35,27 +35,19 @@ qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
     return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
 }
 
-bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
+bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
+                             const hwaddr addr, Error **errp)
 {
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    SerialMM *smm;
-
-    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
-        smm = &s->uart[i];
-
-        /* Chardev property is set by the machine. */
-        qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
-        qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
-        qdev_set_legacy_instance_id(DEVICE(smm), sc->memmap[uart], 2);
-        qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
-        if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
-            return false;
-        }
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
-        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
+    /* Chardev property is set by the machine. */
+    qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
+    qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
+    qdev_set_legacy_instance_id(DEVICE(smm), addr, 2);
+    qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
+        return false;
     }
 
+    aspeed_mmio_map(memory, SYS_BUS_DEVICE(smm), 0, addr);
     return true;
 }
 
-- 
2.43.0


