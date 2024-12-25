Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655A5E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQGpC-00081k-Qi; Tue, 24 Dec 2024 21:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGpA-00081J-RA; Tue, 24 Dec 2024 21:08:37 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGp7-0002ew-J2; Tue, 24 Dec 2024 21:08:35 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 25 Dec
 2024 10:03:13 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 25 Dec 2024 10:03:13 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <steven_lee@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH 3/5] aspeed: Introduce AST27x0 SoC with Cortex-M4 support
Date: Wed, 25 Dec 2024 10:03:09 +0800
Message-ID: <20241225020311.3718080-4-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This initial module adds support for the AST27x0 SoC, which features
four Cortex-A35 cores and two Cortex-M4 cores. The patch enables emulation
of the Cortex-M4 cores, laying the groundwork for co-processor support.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-cm4.c | 397 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 include/hw/arm/aspeed_soc.h |  23 +++
 3 files changed, 421 insertions(+)
 create mode 100644 hw/arm/aspeed_ast27x0-cm4.c

diff --git a/hw/arm/aspeed_ast27x0-cm4.c b/hw/arm/aspeed_ast27x0-cm4.c
new file mode 100644
index 0000000000..591e54f0a7
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-cm4.c
@@ -0,0 +1,397 @@
+/*
+ * ASPEED Ast27x0 CM4 SoC
+ *
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Implementation extracted from the AST2600 and adapted for Ast10x0.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+
+#define ASPEED_SOC_IOMEM_SIZE 0x00200000
+
+static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
+    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_INTC]      =  0x72100000,
+    [ASPEED_DEV_INTC0]     =  0x72102000,
+    [ASPEED_DEV_INTC1]     =  0x72102100,
+    [ASPEED_DEV_INTC2]     =  0x72102200,
+    [ASPEED_DEV_INTC3]     =  0x72102300,
+    [ASPEED_DEV_INTC4]     =  0x72102400,
+    [ASPEED_DEV_INTC5]     =  0x72102500,
+    [ASPEED_DEV_INTC6]     =  0x72102600,
+    [ASPEED_DEV_INTC7]     =  0x72102700,
+    [ASPEED_DEV_INTC8]     =  0x72102800,
+    [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_UART0]     =  0X74C33000,
+    [ASPEED_DEV_UART1]     =  0X74C33100,
+    [ASPEED_DEV_UART2]     =  0X74C33200,
+    [ASPEED_DEV_UART3]     =  0X74C33300,
+    [ASPEED_DEV_UART4]     =  0X72C1A000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C000,
+    [ASPEED_DEV_IPC1]      =  0x72C1C200,
+    [ASPEED_DEV_IPC2]      =  0x72C1C800,
+    [ASPEED_DEV_UART5]     =  0X74C33400,
+    [ASPEED_DEV_UART6]     =  0X74C33500,
+    [ASPEED_DEV_UART7]     =  0X74C33600,
+    [ASPEED_DEV_UART8]     =  0X74C33700,
+    [ASPEED_DEV_UART9]     =  0X74C33800,
+    [ASPEED_DEV_UART10]    =  0X74C33900,
+    [ASPEED_DEV_UART11]    =  0X74C33A00,
+    [ASPEED_DEV_UART12]    =  0X74C33B00,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+};
+
+static const int aspeed_soc_ast27x0ssp_irqmap[] = {
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_UART0]     = 132,
+    [ASPEED_DEV_UART1]     = 132,
+    [ASPEED_DEV_UART2]     = 132,
+    [ASPEED_DEV_UART3]     = 132,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_UART5]     = 132,
+    [ASPEED_DEV_UART6]     = 140,
+    [ASPEED_DEV_UART7]     = 132,
+    [ASPEED_DEV_UART8]     = 132,
+    [ASPEED_DEV_UART9]     = 132,
+    [ASPEED_DEV_UART10]    = 132,
+    [ASPEED_DEV_UART11]    = 132,
+    [ASPEED_DEV_UART12]    = 132,
+    [ASPEED_DEV_TIMER1]    = 16,
+};
+
+static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
+    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_INTC]      =  0x72100000,
+    [ASPEED_DEV_INTC0]     =  0x72103000,
+    [ASPEED_DEV_INTC1]     =  0x72103100,
+    [ASPEED_DEV_INTC2]     =  0x72103200,
+    [ASPEED_DEV_INTC3]     =  0x72103300,
+    [ASPEED_DEV_INTC4]     =  0x72103400,
+    [ASPEED_DEV_INTC5]     =  0x72103500,
+    [ASPEED_DEV_INTC6]     =  0x72103600,
+    [ASPEED_DEV_INTC7]     =  0x72103700,
+    [ASPEED_DEV_INTC8]     =  0x72103800,
+    [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_UART0]     =  0X74C33000,
+    [ASPEED_DEV_UART1]     =  0X74C33100,
+    [ASPEED_DEV_UART2]     =  0X74C33200,
+    [ASPEED_DEV_UART3]     =  0X74C33300,
+    [ASPEED_DEV_UART4]     =  0X72C1A000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C400,
+    [ASPEED_DEV_IPC1]      =  0x72C1C600,
+    [ASPEED_DEV_IPC2]      =  0x72C1C800,
+    [ASPEED_DEV_UART5]     =  0X74C33400,
+    [ASPEED_DEV_UART6]     =  0X74C33500,
+    [ASPEED_DEV_UART7]     =  0X74C33600,
+    [ASPEED_DEV_UART8]     =  0X74C33700,
+    [ASPEED_DEV_UART9]     =  0X74C33800,
+    [ASPEED_DEV_UART10]    =  0X74C33900,
+    [ASPEED_DEV_UART11]    =  0X74C33A00,
+    [ASPEED_DEV_UART12]    =  0X74C33B00,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+};
+
+static const int aspeed_soc_ast27x0tsp_irqmap[] = {
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_UART0]     = 132,
+    [ASPEED_DEV_UART1]     = 132,
+    [ASPEED_DEV_UART2]     = 132,
+    [ASPEED_DEV_UART3]     = 132,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_UART5]     = 132,
+    [ASPEED_DEV_UART6]     = 140,
+    [ASPEED_DEV_UART7]     = 132,
+    [ASPEED_DEV_UART8]     = 132,
+    [ASPEED_DEV_UART9]     = 132,
+    [ASPEED_DEV_UART10]    = 132,
+    [ASPEED_DEV_UART11]    = 132,
+    [ASPEED_DEV_UART12]    = 132,
+    [ASPEED_DEV_TIMER1]    = 16,
+};
+
+static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(s);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
+}
+
+static void aspeed_soc_ast27x0ssp_init(Object *obj)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(obj);
+    AspeedSoCState *s = ASPEED_SOC(obj);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    char socname[8];
+    char typename[64];
+    int i;
+
+    if (sscanf(sc->name, "%7s", socname) != 1) {
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
+    object_initialize_child(obj, "timerctrl", &s->timerctrl,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "intc", &s->intc,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc", &s->ipc,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+}
+
+static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    DeviceState *armv7m;
+    Error *err = NULL;
+    g_autofree char *sram_name = NULL;
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /* AST27X0 SSP Core */
+    armv7m = DEVICE(&a->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);
+    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    object_property_set_link(OBJECT(&a->armv7m), "memory",
+                             OBJECT(s->memory), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
+
+    /* Internal SRAM */
+    sram_name = g_strdup_printf("aspeed.sram.%d",
+                                CPU(a->armv7m.cpu)->cpu_index);
+    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(s->memory,
+                                sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram);
+
+    /* SCU */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+
+    /* UART */
+    if (!aspeed_soc_uart_realize(s, errp)) {
+        return;
+    }
+
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+                                  "aspeed.timerctrl",
+                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->intc),
+                                  "aspeed.intc",
+                                  sc->memmap[ASPEED_DEV_INTC], 0x4000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ipc),
+                                  "aspeed.ipc",
+                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
+}
+
+static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast27x0ssp_realize;
+
+    sc->name = "ast2700ssp-a0";
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST2700_A0_SILICON_REV;
+    sc->sram_size = 0x1000000;
+    sc->spis_num = 0;
+    sc->ehcis_num = 0;
+    sc->wdts_num = 0;
+    sc->macs_num = 0;
+    sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART0;
+    sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
+    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
+    sc->num_cpus = 1;
+    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
+}
+
+static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedSoCState *s, int dev)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(s);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
+}
+
+static void aspeed_soc_ast27x0tsp_init(Object *obj)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(obj);
+    AspeedSoCState *s = ASPEED_SOC(obj);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    char socname[8];
+    char typename[64];
+    int i;
+
+    if (sscanf(sc->name, "%7s", socname) != 1) {
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
+    object_initialize_child(obj, "timerctrl", &s->timerctrl,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "intc", &s->intc,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ipc", &s->ipc,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+}
+
+static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed27x0CM4SoCState *a = ASPEED27X0CM4_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    DeviceState *armv7m;
+    Error *err = NULL;
+    g_autofree char *sram_name = NULL;
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /* AST27X0 TSP Core */
+    armv7m = DEVICE(&a->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);
+    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    object_property_set_link(OBJECT(&a->armv7m), "memory",
+                             OBJECT(s->memory), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
+
+    /* Internal SRAM */
+    sram_name = g_strdup_printf("aspeed.sram.%d",
+                                CPU(a->armv7m.cpu)->cpu_index);
+    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(s->memory,
+                                sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram);
+
+    /* SCU */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+
+    /* UART */
+    if (!aspeed_soc_uart_realize(s, errp)) {
+        return;
+    }
+
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+                                  "aspeed.timerctrl",
+                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->intc),
+                                  "aspeed.intc",
+                                  sc->memmap[ASPEED_DEV_INTC], 0x4000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ipc),
+                                  "aspeed.ipc",
+                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
+}
+
+static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize = aspeed_soc_ast27x0tsp_realize;
+
+    sc->name = "ast2700tsp-a0";
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev = AST2700_A0_SILICON_REV;
+    sc->sram_size = 0x1000000;
+    sc->spis_num = 0;
+    sc->ehcis_num = 0;
+    sc->wdts_num = 0;
+    sc->macs_num = 0;
+    sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART0;
+    sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
+    sc->memmap = aspeed_soc_ast27x0tsp_memmap;
+    sc->num_cpus = 1;
+    sc->get_irq = aspeed_soc_ast27x0tsp_get_irq;
+}
+
+
+static const TypeInfo aspeed_soc_ast27x0cm4_types[] = {
+    {
+        .name           = TYPE_ASPEED27X0CM4_SOC,
+        .parent         = TYPE_ASPEED_SOC,
+        .instance_size  = sizeof(Aspeed27x0CM4SoCState),
+        .abstract       = true,
+    }, {
+        .name           = "ast2700ssp-a0",
+        .parent         = TYPE_ASPEED27X0CM4_SOC,
+        .instance_init  = aspeed_soc_ast27x0ssp_init,
+        .class_init     = aspeed_soc_ast27x0ssp_class_init,
+    }, {
+        .name           = "ast2700tsp-a0",
+        .parent         = TYPE_ASPEED27X0CM4_SOC,
+        .instance_init  = aspeed_soc_ast27x0tsp_init,
+        .class_init     = aspeed_soc_ast27x0tsp_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_soc_ast27x0cm4_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 490234b3b8..cd7780b997 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,6 +43,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
+  'aspeed_ast27x0-cm4.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index bf885da3fc..7de69dc57d 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -101,6 +101,8 @@ struct AspeedSoCState {
     UnimplementedDeviceState sgpiom;
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
+    UnimplementedDeviceState intc;
+    UnimplementedDeviceState ipc;
     AspeedAPB2OPBState fsi[2];
 };
 
@@ -127,6 +129,15 @@ struct Aspeed2600SoCState {
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
 
+struct Aspeed27x0CM4SoCState {
+    AspeedSoCState parent;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0CM4_SOC "aspeed27x0cm4-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CM4SoCState, ASPEED27X0CM4_SOC)
+
 struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
@@ -201,6 +212,15 @@ enum {
     ASPEED_DEV_EHCI2,
     ASPEED_DEV_VIC,
     ASPEED_DEV_INTC,
+    ASPEED_DEV_INTC0,
+    ASPEED_DEV_INTC1,
+    ASPEED_DEV_INTC2,
+    ASPEED_DEV_INTC3,
+    ASPEED_DEV_INTC4,
+    ASPEED_DEV_INTC5,
+    ASPEED_DEV_INTC6,
+    ASPEED_DEV_INTC7,
+    ASPEED_DEV_INTC8,
     ASPEED_DEV_SDMC,
     ASPEED_DEV_SCU,
     ASPEED_DEV_ADC,
@@ -253,6 +273,9 @@ enum {
     ASPEED_DEV_SCUIO,
     ASPEED_DEV_SLI,
     ASPEED_DEV_SLIIO,
+    ASPEED_DEV_IPC0,
+    ASPEED_DEV_IPC1,
+    ASPEED_DEV_IPC2,
     ASPEED_GIC_DIST,
     ASPEED_GIC_REDIST,
 };
-- 
2.34.1


