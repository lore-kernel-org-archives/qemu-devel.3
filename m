Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD70CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1y-0006HO-DQ; Tue, 16 Sep 2025 21:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1v-0006Fj-Lj; Tue, 16 Sep 2025 21:32:19 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1t-0006vf-6e; Tue, 16 Sep 2025 21:32:19 -0400
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
Subject: [PATCH v1 5/6] hw/arm/aspeed: Model AST1700 IO expander interrupt
 controllers on AST27x0
Date: Wed, 17 Sep 2025 09:31:40 +0800
Message-ID: <20250917013143.1600377-6-kane_chen@aspeedtech.com>
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

AST27x0 boards may host up to two AST1700 IO expander cards. Model the
per-expander interrupt controller (INTCIO) instances and map their MMIO
windows in the SoC.

This reserves the IO expander interrupt controller address space so that
firmware can later route and handle interrupts for AST1700-based boards.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h   |  4 ++-
 include/hw/intc/aspeed_intc.h |  2 ++
 hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++
 hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 648c8d5c00..290bb7a6cf 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -151,7 +151,7 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc[2];
+    AspeedINTCState intc[4];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
@@ -307,6 +307,8 @@ enum {
     ASPEED_DEV_IPC1,
     ASPEED_DEV_LTPI_CTRL1,
     ASPEED_DEV_LTPI_CTRL2,
+    ASPEED_DEV_IOEXP0_INTCIO,
+    ASPEED_DEV_IOEXP1_INTCIO,
 };
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
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
index d63a331c0a..d192534e9e 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -84,7 +84,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
     [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
+    [ASPEED_DEV_IOEXP0_INTCIO] = 0x30C18000,
     [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
+    [ASPEED_DEV_IOEXP1_INTCIO] = 0x50C18000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
@@ -504,6 +506,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_INTC);
     object_initialize_child(obj, "intcio", &a->intc[1],
                             TYPE_ASPEED_2700_INTCIO);
+    object_initialize_child(obj, "intcioexp0", &a->intc[2],
+                            TYPE_ASPEED_2700_INTCIOEXP1);
+    object_initialize_child(obj, "intcioexp1", &a->intc[3],
+                            TYPE_ASPEED_2700_INTCIOEXP2);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -642,6 +648,8 @@ static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
                                                int index, Error **errp)
 {
     SerialMM *smm;
+    AspeedINTCClass *icio = ASPEED_INTC_GET_CLASS(&a->intc[2 + index]);
+    int i;
     hwaddr uart_base = sc->memmap[ASPEED_DEV_LTPI_IO0 + index] +
                        aspeed_soc_ast1700_memmap[ASPEED_DEV_UART12];
     AspeedLTPIState *ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[index]);
@@ -661,6 +669,19 @@ static void aspeed_soc_ast2700_ast1700_realize(Aspeed27x0SoCState *a,
         return;
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
+
+    /* INTC2/3 internal: orgate[i] -> input[i] */
+    for (i = 0; i < icio->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[2 + index].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[2 + index]), i));
+    }
+
+    /* INTC2/3 output[i] -> INTC0.orgate[0].input[i] */
+    for (i = 0; i < icio->num_outpins; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[2 + index]), i,
+                           qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
+    }
+
     aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, uart_base);
 }
 
@@ -717,6 +738,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
+    /* INTCIOEXP0 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[2]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[2]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
+
+    /* INTCIOEXP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[3]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[3]), 0,
+                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
+
     /* irq sources -> orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
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


