Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CF9C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOr-00054e-AX; Thu, 13 Mar 2025 01:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOM-0004q3-S6; Thu, 13 Mar 2025 01:46:08 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOJ-0005Ve-2m; Thu, 13 Mar 2025 01:46:02 -0400
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
Subject: [PATCH 05/13] hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A0 SSP SoC
Date: Thu, 13 Mar 2025 13:40:09 +0800
Message-ID: <20250313054020.2583556-6-steven_lee@aspeedtech.com>
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

AST2700 SSP(Secondary Service Processor) is a Cortex-M4 coprocessor
The patch adds support for SSP with following update:

- Introduce Aspeed27x0SSPSoCState structure in aspeed_soc.h
- Define memory map and IRQ map for AST27x0 A0 SSP SoC
- Implement initialization and realization functions
- Add support for UART, INTC, and SCU devices
- Map unimplemented devices for IPC and SCUIO

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: If83e752873af393f3b71249176454399de0be40f
---
 include/hw/arm/aspeed_soc.h |  14 ++
 hw/arm/aspeed_ast27x0-ssp.c | 309 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 3 files changed, 324 insertions(+)
 create mode 100644 hw/arm/aspeed_ast27x0-ssp.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index c46ec6302d..83debb5e14 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -145,6 +145,18 @@ struct Aspeed10x0SoCState {
     ARMv7MState armv7m;
 };
 
+struct Aspeed27x0SSPSoCState {
+    AspeedSoCState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
+
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
 
@@ -255,6 +267,8 @@ enum {
     ASPEED_DEV_SLIIO,
     ASPEED_GIC_DIST,
     ASPEED_GIC_REDIST,
+    ASPEED_DEV_IPC0,
+    ASPEED_DEV_IPC1,
 };
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
new file mode 100644
index 0000000000..88f27b9459
--- /dev/null
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -0,0 +1,309 @@
+/*
+ * ASPEED Ast27x0 SSP SoC
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+
+#define AST2700_SSP_RAM_SIZE (32 * MiB)
+
+static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
+    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_INTC]      =  0x72100000,
+    [ASPEED_DEV_SCU]       =  0x72C02000,
+    [ASPEED_DEV_SCUIO]     =  0x74C02000,
+    [ASPEED_DEV_UART0]     =  0x74C33000,
+    [ASPEED_DEV_UART1]     =  0x74C33100,
+    [ASPEED_DEV_UART2]     =  0x74C33200,
+    [ASPEED_DEV_UART3]     =  0x74C33300,
+    [ASPEED_DEV_UART4]     =  0x72C1A000,
+    [ASPEED_DEV_INTCIO]    =  0x74C18000,
+    [ASPEED_DEV_IPC0]      =  0x72C1C000,
+    [ASPEED_DEV_IPC1]      =  0x74C39000,
+    [ASPEED_DEV_UART5]     =  0x74C33400,
+    [ASPEED_DEV_UART6]     =  0x74C33500,
+    [ASPEED_DEV_UART7]     =  0x74C33600,
+    [ASPEED_DEV_UART8]     =  0x74C33700,
+    [ASPEED_DEV_UART9]     =  0x74C33800,
+    [ASPEED_DEV_UART10]    =  0x74C33900,
+    [ASPEED_DEV_UART11]    =  0x74C33A00,
+    [ASPEED_DEV_UART12]    =  0x74C33B00,
+    [ASPEED_DEV_TIMER1]    =  0x72C10000,
+};
+
+static const int aspeed_soc_ast27x0a0ssp_irqmap[] = {
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
+/* SSPINT 164 */
+static const int ast2700_ssp132_ssp164_intcmap[] = {
+    [ASPEED_DEV_UART0]     = 7,
+    [ASPEED_DEV_UART1]     = 8,
+    [ASPEED_DEV_UART2]     = 9,
+    [ASPEED_DEV_UART3]     = 10,
+    [ASPEED_DEV_UART5]     = 11,
+    [ASPEED_DEV_UART6]     = 12,
+    [ASPEED_DEV_UART7]     = 13,
+    [ASPEED_DEV_UART8]     = 14,
+    [ASPEED_DEV_UART9]     = 15,
+    [ASPEED_DEV_UART10]    = 16,
+    [ASPEED_DEV_UART11]    = 17,
+    [ASPEED_DEV_UART12]    = 18,
+};
+
+struct nvic_intc_irq_info {
+    int irq;
+    int intc_idx;
+    int orgate_idx;
+    const int *ptr;
+};
+
+static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
+    {160, 1, 0, NULL},
+    {161, 1, 1, NULL},
+    {162, 1, 2, NULL},
+    {163, 1, 3, NULL},
+    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
+    {165, 1, 5, NULL},
+    {166, 1, 6, NULL},
+    {167, 1, 7, NULL},
+    {168, 1, 8, NULL},
+    {169, 1, 9, NULL},
+    {128, 0, 1, NULL},
+    {129, 0, 2, NULL},
+    {130, 0, 3, NULL},
+    {131, 0, 4, NULL},
+    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
+    {133, 0, 6, NULL},
+    {134, 0, 7, NULL},
+    {135, 0, 8, NULL},
+    {136, 0, 9, NULL},
+};
+
+static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedSoCState *s, int dev)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(s);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    int or_idx;
+    int idx;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(ast2700_ssp_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_ssp_intcmap[i].irq) {
+            assert(ast2700_ssp_intcmap[i].ptr);
+            or_idx = ast2700_ssp_intcmap[i].orgate_idx;
+            idx = ast2700_ssp_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_ssp_intcmap[i].ptr[dev]);
+        }
+    }
+
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
+}
+
+static void aspeed_soc_ast27x0a0ssp_init(Object *obj)
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
+static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed27x0SSPSoCState *a = ASPEED27X0SSP_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    DeviceState *armv7m;
+    Error *err = NULL;
+    g_autofree char *sram_name = NULL;
+    int i;
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
+    sram_name = g_strdup_printf("aspeed.dram.%d",
+                                CPU(a->armv7m.cpu)->cpu_index);
+
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
+                                &err)) {
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
+    /* INTC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+                    sc->memmap[ASPEED_DEV_INTC]);
+
+    /* INTCIO */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[1]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+                    sc->memmap[ASPEED_DEV_INTCIO]);
+
+    /* irq source orgates -> INTC0 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
+    }
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_outpins; i++) {
+        assert(i < ARRAY_SIZE(ast2700_ssp_intcmap));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
+                           qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                            ast2700_ssp_intcmap[i].irq));
+    }
+    /* irq source orgates -> INTCIO */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[1].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[1]), i));
+    }
+    /* INTCIO -> INTC */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_outpins; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
+                        qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
+    }
+    /* UART */
+    if (!aspeed_soc_uart_realize(s, errp)) {
+        return;
+    }
+
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+                                  "aspeed.timerctrl",
+                                  sc->memmap[ASPEED_DEV_TIMER1], 0x200);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+                                  "aspeed.ipc0",
+                                  sc->memmap[ASPEED_DEV_IPC0], 0x1000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+                                  "aspeed.ipc1",
+                                  sc->memmap[ASPEED_DEV_IPC1], 0x1000);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+                                  "aspeed.scuio",
+                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
+}
+
+static void aspeed_soc_ast27x0a0ssp_class_init(ObjectClass *klass, void *data)
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
+    sc->silicon_rev = AST2700_A0_SILICON_REV;
+    sc->sram_size = AST2700_SSP_RAM_SIZE;
+    sc->spis_num = 0;
+    sc->ehcis_num = 0;
+    sc->wdts_num = 0;
+    sc->macs_num = 0;
+    sc->uarts_num = 13;
+    sc->uarts_base = ASPEED_DEV_UART0;
+    sc->irqmap = aspeed_soc_ast27x0a0ssp_irqmap;
+    sc->memmap = aspeed_soc_ast27x0ssp_memmap;
+    sc->num_cpus = 1;
+    sc->get_irq = aspeed_soc_ast27x0ssp_get_irq;
+}
+
+static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
+    {
+        .name           = TYPE_ASPEED27X0SSP_SOC,
+        .parent         = TYPE_ASPEED_SOC,
+        .instance_size  = sizeof(Aspeed27x0SSPSoCState),
+        .abstract       = true,
+    }, {
+        .name           = "ast2700ssp-a0",
+        .parent         = TYPE_ASPEED27X0SSP_SOC,
+        .instance_init  = aspeed_soc_ast27x0a0ssp_init,
+        .class_init     = aspeed_soc_ast27x0a0ssp_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_soc_ast27x0ssp_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cd..aec0a0b98d 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
+  'aspeed_ast27x0-ssp.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.34.1


