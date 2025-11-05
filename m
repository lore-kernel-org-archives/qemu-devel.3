Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F07CCFA15
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUg9-0007WX-P8; Tue, 04 Nov 2025 22:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg7-0007VL-1B; Tue, 04 Nov 2025 22:59:23 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg5-0006sZ-BK; Tue, 04 Nov 2025 22:59:22 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 05/17] hw/arm/aspeed: Integrate interrupt controller for
 AST1700
Date: Wed, 5 Nov 2025 11:58:43 +0800
Message-ID: <20251105035859.3709907-6-kane_chen@aspeedtech.com>
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

Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling
the propagation of AST1700-originated interrupts to the host SoC.

This patch does not implement interrupt sources in AST1700 itself,
only the wiring into AST27X0.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h   |  2 +-
 include/hw/intc/aspeed_intc.h |  2 ++
 hw/arm/aspeed_ast27x0.c       | 36 +++++++++++++++++++++
 hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 00cd8df038..66a6a073f6 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -143,7 +143,7 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc[2];
+    AspeedINTCState intc[4];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 51288384a5..4565bbab84 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -15,6 +15,8 @@
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
+#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "ast2700-ioexp1"
+#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "ast2700-ioexp2"
 #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
 #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
 #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 054864467d..11625e165a 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -505,6 +505,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
     object_initialize_child(obj, "intcio", &a->intc[1],
                             TYPE_ASPEED_2700_INTCIO);
+    object_initialize_child(obj, "intcioexp0", &a->intc[2],
+                            TYPE_ASPEED_2700_INTCIOEXP1);
+    object_initialize_child(obj, "intcioexp1", &a->intc[3],
+                            TYPE_ASPEED_2700_INTCIOEXP2);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -701,6 +705,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     g_autofree char *name = NULL;
     qemu_irq irq;
     int uart;
+    int j;
     AspeedLTPIState *ltpi_ctrl;
     hwaddr ltpi_base;
 
@@ -746,6 +751,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
+    /* INTCIOEXP0 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[2]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[2]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
+
+    /* INTCIOEXP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[3]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[3]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
+
     /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
@@ -1054,6 +1075,21 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
                         sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
+
+        icio = ASPEED_INTC_GET_CLASS(&a->intc[2 + i]);
+        /* INTC2/3 internal: orgate[i] -> input[i] */
+        for (j = 0; j < icio->num_inpins; j++) {
+            irq = qdev_get_gpio_in(DEVICE(&a->intc[2 + i]), j);
+            qdev_connect_gpio_out(DEVICE(&a->intc[2 + i].orgates[j]), 0,
+                                  irq);
+        }
+
+        /* INTC2/3 output[i] -> INTC0.orgate[0].input[i] */
+        for (j = 0; j < icio->num_outpins; j++) {
+            irq = qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[2 + i]), j,
+                               irq);
+        }
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 5cd786dee6..a04005ee7c 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -924,6 +924,64 @@ static const TypeInfo aspeed_2700_intc_info = {
     .class_init = aspeed_2700_intc_class_init,
 };
 
+static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
+    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
+};
+
+static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 IOEXP2 INTC Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 2;
+    aic->num_outpins = 10;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x58 >> 2;
+    aic->reg_offset = 0x100;
+    aic->reg_ops = &aspeed_intcio_ops;
+    aic->irq_table = aspeed_2700_intcioexp2_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
+}
+
+static const TypeInfo aspeed_2700_intcioexp2_info = {
+    .name = TYPE_ASPEED_2700_INTCIOEXP2,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intcioexp2_class_init,
+};
+
+static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
+    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
+};
+
+static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
+                                              const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 IOEXP1 INTC Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 2;
+    aic->num_outpins = 10;
+    aic->mem_size = 0x400;
+    aic->nr_regs = 0x58 >> 2;
+    aic->reg_offset = 0x100;
+    aic->reg_ops = &aspeed_intcio_ops;
+    aic->irq_table = aspeed_2700_intcioexp1_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
+}
+
+static const TypeInfo aspeed_2700_intcioexp1_info = {
+    .name = TYPE_ASPEED_2700_INTCIOEXP1,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intcioexp1_class_init,
+};
+
 static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
     {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
@@ -1099,6 +1157,8 @@ static void aspeed_intc_register_types(void)
     type_register_static(&aspeed_intc_info);
     type_register_static(&aspeed_2700_intc_info);
     type_register_static(&aspeed_2700_intcio_info);
+    type_register_static(&aspeed_2700_intcioexp1_info);
+    type_register_static(&aspeed_2700_intcioexp2_info);
     type_register_static(&aspeed_2700ssp_intc_info);
     type_register_static(&aspeed_2700ssp_intcio_info);
     type_register_static(&aspeed_2700tsp_intc_info);
-- 
2.43.0


