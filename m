Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A434DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOp-00051h-VJ; Thu, 13 Mar 2025 01:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOP-0004qF-MY; Thu, 13 Mar 2025 01:46:08 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbON-0005Ve-WC; Thu, 13 Mar 2025 01:46:05 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Mar
 2025 13:40:22 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Mar 2025 13:40:22 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <yunlin.tang@aspeedtech.com>
Subject: [PATCH 06/13] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
Date: Thu, 13 Mar 2025 13:40:10 +0800
Message-ID: <20250313054020.2583556-7-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AST2700 SSP (Secondary Service Processor) is a Cortex-M4 coprocessor.
This patch adds support for A1 SSP with the following updates:

- Defined IRQ maps for AST27x0 A1 SSP SoC
- Implemented initialization functions

The IRQ mapping is similar to AST2700 CA35 SoC, featuring a two-level
interrupt controller.

Difference from AST2700:

    - AST2700
      - Support GICINT128 to GICINT136 in INTC
      - The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
          Bit 0 -> GIC 192
          Bit 1 -> GIC 193
          Bit 2 -> GIC 194
          Bit 3 -> GIC 195
          Bit 4 -> GIC 196

    - AST2700-ssp
      - Support SSPINT128 to SSPINT136 in INTC
      - The INTCIO SSPINT_160_169 has 10 output pins, mapped as follows:
          Bit 0 -> SSPINT 160
          Bit 1 -> SSPINT 161
          Bit 2 -> SSPINT 162
          Bit 3 -> SSPINT 163
          Bit 4 -> SSPINT 164

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Ic5121dd78c5dacf1ec4b4e791cc7bf476a8b608f
---
 hw/arm/aspeed_ast27x0-ssp.c | 91 +++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 88f27b9459..5553190a62 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -60,6 +60,24 @@ static const int aspeed_soc_ast27x0a0ssp_irqmap[] = {
     [ASPEED_DEV_TIMER1]    = 16,
 };
 
+static const int aspeed_soc_ast27x0a1ssp_irqmap[] = {
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_UART0]     = 164,
+    [ASPEED_DEV_UART1]     = 164,
+    [ASPEED_DEV_UART2]     = 164,
+    [ASPEED_DEV_UART3]     = 164,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_UART5]     = 164,
+    [ASPEED_DEV_UART6]     = 164,
+    [ASPEED_DEV_UART7]     = 164,
+    [ASPEED_DEV_UART8]     = 164,
+    [ASPEED_DEV_UART9]     = 164,
+    [ASPEED_DEV_UART10]    = 164,
+    [ASPEED_DEV_UART11]    = 164,
+    [ASPEED_DEV_UART12]    = 164,
+    [ASPEED_DEV_TIMER1]    = 16,
+};
+
 /* SSPINT 164 */
 static const int ast2700_ssp132_ssp164_intcmap[] = {
     [ASPEED_DEV_UART0]     = 7,
@@ -167,6 +185,46 @@ static void aspeed_soc_ast27x0a0ssp_init(Object *obj)
                             TYPE_UNIMPLEMENTED_DEVICE);
 }
 
+static void aspeed_soc_ast27x0a1ssp_init(Object *obj)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(obj);
+    AspeedSoCState *s = ASPEED_SOC(obj);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    char socname[8];
+    char typename[64];
+    int i;
+
+    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
+        g_assert_not_reached();
+    }
+
+    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+
+    snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
+    object_initialize_child(obj, "scu", &s->scu, typename);
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
+
+    for (i = 0; i < sc->uarts_num; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
+    }
+
+    object_initialize_child(obj, "intc0", &a->intc[0],
+                            TYPE_ASPEED_2700SSP_INTC);
+    object_initialize_child(obj, "intc1", &a->intc[1],
+                            TYPE_ASPEED_2700SSP_INTCIO);
+
+    object_initialize_child(obj, "timerctrl", &s->timerctrl,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc0", &a->ipc[0],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc1", &a->ipc[1],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "scuio", &a->scuio,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+}
+
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 {
     Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
@@ -292,6 +350,34 @@ static void aspeed_soc_ast27x0a0ssp_class_init(ObjectClass *klass, void *data)
     sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
 }
 
+static void aspeed_soc_ast27x0a1ssp_class_init(ObjectClass *klass, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast27x0ssp_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST2700_A1_SILICON_REV;
+    sc->sram_size = AST2700_SSP_RAM_SIZE;
+    sc->spis_num = 0;
+    sc->ehcis_num = 0;
+    sc->wdts_num = 0;
+    sc->macs_num = 0;
+    sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART0;
+    sc->irqmap = aspeed_soc_ast27x0a1ssp_irqmap;
+    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
+    sc->num_cpus = 1;
+    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
+}
+
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
     {
         .name           = TYPE_ASPEED27X0SSP_SOC,
@@ -303,6 +389,11 @@ static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
         .parent         = TYPE_ASPEED27X0SSP_SOC,
         .instance_init  = aspeed_soc_ast27x0a0ssp_init,
         .class_init     = aspeed_soc_ast27x0a0ssp_class_init,
+    }, {
+        .name           = "ast2700ssp-a1",
+        .parent         = TYPE_ASPEED27X0SSP_SOC,
+        .instance_init  = aspeed_soc_ast27x0a1ssp_init,
+        .class_init     = aspeed_soc_ast27x0a1ssp_class_init,
     },
 };
 
-- 
2.34.1


