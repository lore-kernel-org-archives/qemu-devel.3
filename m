Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07E0CCFA19
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGvgp-0003F4-UL; Thu, 06 Nov 2025 03:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgn-00036U-NB; Thu, 06 Nov 2025 03:49:53 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vGvgl-0005Sg-MN; Thu, 06 Nov 2025 03:49:53 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 6 Nov
 2025 16:49:28 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 6 Nov 2025 16:49:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 06/12] hw/arm/aspeed_ast10x0: Add common realize function
 for AST10x0 SoCs
Date: Thu, 6 Nov 2025 16:49:15 +0800
Message-ID: <20251106084925.1253704-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
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

Introduce a new common realize function aspeed_soc_ast10x0_realize()
for AST10x0 series SoCs. The shared initialization and realization logic
is now placed in this common function to improve code reuse and reduce
duplication between different SoCs in the same family.

The AST1030 realization function aspeed_soc_ast1030_realize() is
updated to call the new common routine and then perform realization of
its own specific devices such as LPC and PECI, which are not present on
future SoCs like AST1060.

This refactor simplifies maintenance and prepares the framework for
adding AST1060 support.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast10x0.c | 128 ++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 5941ebe00c..5bbe16af24 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -190,10 +190,9 @@ static void aspeed_soc_ast1030_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
-static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
+static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
 {
-    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
-    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(a);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     Error *err = NULL;
@@ -203,7 +202,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     if (!clock_has_source(s->sysclk)) {
         error_setg(errp, "sysclk clock must be wired up by the board code");
-        return;
+        return false;
     }
 
     /* General I/O memory space to catch all unimplemented device */
@@ -216,7 +215,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                   "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC],
                                   0x40000);
 
-    /* AST1030 CPU Core */
+    /* AST10x0 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
     qdev_prop_set_string(armv7m, "cpu-type",
@@ -232,7 +231,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM],
@@ -241,14 +240,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                            sc->secsram_size, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SECSRAM],
                                 &s->secsram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
                     sc->memmap[ASPEED_DEV_SCU]);
@@ -258,7 +257,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
                     sc->memmap[ASPEED_DEV_I2C]);
@@ -271,7 +270,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* I3C */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
                     sc->memmap[ASPEED_DEV_I3C]);
@@ -282,50 +281,11 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i3c.devices[i]), 0, irq);
     }
 
-    /* PECI */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
-                    sc->memmap[ASPEED_DEV_PECI]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_PECI));
-
-    /* LPC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
-                    sc->memmap[ASPEED_DEV_LPC]);
-
-    /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_LPC));
-
-    /*
-     * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
-     */
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_1,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_1));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_2,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_2));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_3,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_3));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_4,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
-
     /* UART */
     for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
         if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
                                      sc->memmap[uart], errp)) {
-            return;
+            return false;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
                            aspeed_soc_ast1030_get_irq(s, uart));
@@ -335,7 +295,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
@@ -346,7 +306,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* ADC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
@@ -357,7 +317,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram),
             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
                     sc->memmap[ASPEED_DEV_FMC]);
@@ -371,7 +331,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->spi[i]), "dram",
                                  OBJECT(&s->sram), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
@@ -383,7 +343,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* Secure Boot Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
                     sc->memmap[ASPEED_DEV_SBC]);
@@ -392,7 +352,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->hace), "dram", OBJECT(&s->sram),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
@@ -407,14 +367,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
@@ -442,6 +402,58 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
                                   "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG1], 0x20);
+
+    return true;
+}
+
+static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    if (!aspeed_soc_ast10x0_realize(a, errp)) {
+        return;
+    }
+
+    /* PECI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
+                    sc->memmap[ASPEED_DEV_PECI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_PECI));
+
+    /* LPC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
+
+    /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_LPC));
+
+    /*
+     * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_1,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_1));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_2,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_2));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_3,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_3));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_4,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 }
 
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


