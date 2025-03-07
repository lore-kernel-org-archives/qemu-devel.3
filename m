Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F149C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 04:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqOty-0001pv-R5; Thu, 06 Mar 2025 23:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOtm-0001RN-9D; Thu, 06 Mar 2025 23:01:23 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOtk-00053C-Gg; Thu, 06 Mar 2025 23:01:22 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 7 Mar
 2025 11:59:53 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 7 Mar 2025 11:59:53 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 20/29] hw/arm/aspeed_ast27x0: Define an Array of
 AspeedINTCState with Two Instances
Date: Fri, 7 Mar 2025 11:59:29 +0800
Message-ID: <20250307035945.3698802-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Updated Aspeed27x0SoCState to include an intc[2] array instead of a single
AspeedINTCState instance. Modified aspeed_soc_ast2700_get_irq and
aspeed_soc_ast2700_get_irq_index to correctly reference the corresponding
interrupt controller instance and OR gate index.

Currently, only GIC 192 to 201 are supported, and their source interrupts are
from INTCIO and connected to INTC at input pin 0 and output pins 0 to 9 for
GIC 192-201.

To support both AST2700 A1 and A0, INTC input pins 1 to 9 and output pins
10 to 18 remain to support GIC 128-136, which source interrupts from INTC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  2 +-
 hw/arm/aspeed_ast27x0.c     | 58 +++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 689f52dae8..1ac99269ae 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,7 +128,7 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc;
+    AspeedINTCState intc[2];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 343fe87921..90545215e2 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -178,32 +178,48 @@ static const int ast2700_gic133_gic197_intcmap[] = {
 /* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
+    int intc_idx;
+    int orgate_idx;
     const int *ptr;
 };
 
 static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
-    {128,  ast2700_gic128_gic192_intcmap},
-    {129,  NULL},
-    {130,  ast2700_gic130_gic194_intcmap},
-    {131,  ast2700_gic131_gic195_intcmap},
-    {132,  ast2700_gic132_gic196_intcmap},
-    {133,  ast2700_gic133_gic197_intcmap},
-    {134,  NULL},
-    {135,  NULL},
-    {136,  NULL},
+    {192, 1, 0, ast2700_gic128_gic192_intcmap},
+    {193, 1, 1, NULL},
+    {194, 1, 2, ast2700_gic130_gic194_intcmap},
+    {195, 1, 3, ast2700_gic131_gic195_intcmap},
+    {196, 1, 4, ast2700_gic132_gic196_intcmap},
+    {197, 1, 5, ast2700_gic133_gic197_intcmap},
+    {198, 1, 6, NULL},
+    {199, 1, 7, NULL},
+    {200, 1, 8, NULL},
+    {201, 1, 9, NULL},
+    {128, 0, 1, ast2700_gic128_gic192_intcmap},
+    {129, 0, 2, NULL},
+    {130, 0, 3, ast2700_gic130_gic194_intcmap},
+    {131, 0, 4, ast2700_gic131_gic195_intcmap},
+    {132, 0, 5, ast2700_gic132_gic196_intcmap},
+    {133, 0, 6, ast2700_gic133_gic197_intcmap},
+    {134, 0, 7, NULL},
+    {135, 0, 8, NULL},
+    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
         if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
             assert(ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                ast2700_gic_intcmap[i].ptr[dev]);
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_gic_intcmap[i].ptr[dev]);
         }
     }
 
@@ -215,12 +231,16 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
         if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
             assert(ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
                                     ast2700_gic_intcmap[i].ptr[dev] + index);
         }
     }
@@ -390,7 +410,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     object_initialize_child(obj, "sli", &s->sli, TYPE_ASPEED_2700_SLI);
     object_initialize_child(obj, "sliio", &s->sliio, TYPE_ASPEED_2700_SLIIO);
-    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_2700_INTC);
+    object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -502,7 +522,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);
+    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc[0]);
     g_autofree char *sram_name = NULL;
     qemu_irq irq;
 
@@ -533,23 +553,23 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     }
 
     /* INTC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
-        qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
-                              qdev_get_gpio_in(DEVICE(&a->intc), i));
+        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
     }
 
     /* INTC -> GIC192 - GIC201 */
     /* INTC -> GIC128 - GIC136 */
     for (i = 0; i < ic->num_outpins; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
                                             ast2700_gic_intcmap[i].irq));
     }
-- 
2.43.0


