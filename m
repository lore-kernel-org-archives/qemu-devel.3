Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F45D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVyH-00015L-7N; Mon, 08 Dec 2025 02:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwU-0007Kn-3F; Mon, 08 Dec 2025 02:46:08 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwS-0000As-Aj; Mon, 08 Dec 2025 02:45:57 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:42 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:42 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 14/18] hw/arm/aspeed: attach I2C device to AST1700 model
Date: Mon, 8 Dec 2025 15:44:26 +0800
Message-ID: <20251208074436.1871180-15-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Connect the I2C controller to the AST1700 model by mapping its MMIO
region and wiring its interrupt line.

This patch also adds a bus_label property to distinguish I2C buses on
the BMC from those on external boards. This prevents user-specified
I2C devices from being attached to the wrong bus when provided via CLI.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 ++
 include/hw/arm/aspeed_soc.h     |  2 ++
 include/hw/i2c/aspeed_i2c.h     |  1 +
 hw/arm/aspeed_ast1700.c         | 18 ++++++++++++
 hw/arm/aspeed_ast27x0.c         | 49 ++++++++++++++++++++++++++++++---
 hw/i2c/aspeed_i2c.c             | 19 +++++++++++--
 6 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index 7ea6ff4c1a..d4b7abee7d 100644
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
@@ -34,6 +35,7 @@ struct AspeedAST1700SoCState {
     AspeedADCState adc;
     AspeedSCUState scu;
     AspeedGPIOState gpio;
+    AspeedI2CState i2c;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cebd8c21c8..602ce3924d 100644
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
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 2daacc10ce..babbad5ed9 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -269,6 +269,7 @@ struct AspeedI2CState {
     uint32_t intr_status;
     uint32_t ctrl_global;
     uint32_t new_clk_divider;
+    char *bus_label;
     MemoryRegion pool_iomem;
     uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
 
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 1cb3cc4f7c..bd677727f5 100644
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
@@ -108,6 +110,18 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
+    /* I2C */
+    snprintf(dev_name, sizeof(dev_name), "ioexp%d", s->board_idx);
+    qdev_prop_set_string(DEVICE(&s->i2c), "bus-label", dev_name);
+    object_property_set_link(OBJECT(&s->i2c), "dram",
+                             OBJECT(&s->iomem), errp);
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
@@ -141,6 +155,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "ioexp-gpio[*]", &s->gpio,
                             "aspeed.gpio-ast2700");
 
+    /* I2C */
+    object_initialize_child(obj, "ioexp-i2c[*]", &s->i2c,
+                            "aspeed.i2c-ast2700");
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 402799416f..7433d365a3 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -205,6 +205,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_ETH3]      = 196,
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
+    [ASPEED_DEV_IOEXP0_I2C] = 198,
+    [ASPEED_DEV_IOEXP1_I2C] = 200,
 };
 
 /* GICINT 128 */
@@ -267,6 +269,18 @@ static const int ast2700_gic133_gic197_intcmap[] = {
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
 /* GICINT 128 ~ 136 */
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
@@ -283,9 +297,9 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
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
@@ -333,8 +347,13 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
             assert(ast2700_gic_intcmap[i].ptr);
             or_idx = ast2700_gic_intcmap[i].orgate_idx;
             idx = ast2700_gic_intcmap[i].intc_idx;
-            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
-                                    ast2700_gic_intcmap[i].ptr[dev] + index);
+            if (idx < ASPEED_INTC_NUM) {
+                return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                        ast2700_gic_intcmap[i].ptr[dev] + index);
+            } else {
+                return qdev_get_gpio_in(DEVICE(&a->intcioexp[idx - ASPEED_INTC_NUM].orgates[or_idx]),
+                                        ast2700_gic_intcmap[i].ptr[dev] + index);
+            }
         }
     }
 
@@ -1098,6 +1117,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* IO Expander */
     for (i = 0; i < sc->ioexp_num; i++) {
+        AspeedI2CClass *i2c_ctl;
+
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
             return;
@@ -1128,6 +1149,26 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
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
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 83fb906bdc..ca84068bb4 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -1261,6 +1261,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_i2c_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_STRING("bus-label", AspeedI2CState, bus_label),
 };
 
 static void aspeed_i2c_class_init(ObjectClass *klass, const void *data)
@@ -1421,14 +1422,28 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, Error **errp)
 {
     AspeedI2CBus *s = ASPEED_I2C_BUS(dev);
     AspeedI2CClass *aic;
-    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
-    g_autofree char *pool_name = g_strdup_printf("%s.pool", name);
+    g_autofree char *name = NULL;
+    g_autofree char *pool_name = NULL;
 
     if (!s->controller) {
         error_setg(errp, TYPE_ASPEED_I2C_BUS ": 'controller' link not set");
         return;
     }
 
+    /*
+     * I2C bus naming:
+     *   - Empty bus_label -> BMC internal controller, use default name.
+     *   - Non-empty bus_label -> external/addon controller, prefix with label
+     *     to avoid conflicts and show bus origin.
+     */
+    if (!s->controller->bus_label || (strlen(s->controller->bus_label) == 0)) {
+        name = g_strdup_printf(TYPE_ASPEED_I2C_BUS ".%d", s->id);
+    } else {
+        name = g_strdup_printf("aspeed.%s.i2c.bus.%d",
+                               s->controller->bus_label, s->id);
+    }
+    pool_name = g_strdup_printf("%s.pool", name);
+
     aic = ASPEED_I2C_GET_CLASS(s->controller);
 
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-- 
2.43.0


