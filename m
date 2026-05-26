Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D9CD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0W-0005LB-41; Tue, 26 May 2026 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0U-0005J8-5x
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0R-0007do-9z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HENlz6rGBDfEWGkKzrLllBmuGN58CBILanrFl7SOck=;
 b=TiTl1uL9wIBk0pSaM3BuDWTpDtMUXbPPg9mY0Ky0GysNFfQE7Tvkaaf4m189QPMVC9X9pI
 r2mVQoCNq/eGAtwgQDh6B2gOhZ9CRx5N8zXxXXbDX9fyUac9RGRGLPtIwXobVtGqKVYHnR
 B0KSzlj1IQOSdVjIP+KGpIrli2eK3jU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-Kby3isAYOECMCT-9sBdSqg-1; Tue,
 26 May 2026 04:19:16 -0400
X-MC-Unique: Kby3isAYOECMCT-9sBdSqg-1
X-Mimecast-MFC-AGG-ID: Kby3isAYOECMCT-9sBdSqg_1779783555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FBB219560AF; Tue, 26 May 2026 08:19:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCCF7180075B; Tue, 26 May 2026 08:19:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/37] hw/arm/aspeed: Introduce AST1040 A0 SoC model
Date: Tue, 26 May 2026 10:18:22 +0200
Message-ID: <20260526081848.651835-12-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST1040 is based on an ARM Cortex-M4F CPU core. Since QEMU
currently does not provide Cortex-M4F support, use the existing
Cortex-M4 CPU model as a temporary replacement.

This initial implementation provides the basic infrastructure
required to boot firmware and run a minimal firmware shell,
including:

- ARM Cortex-M4 CPU integration
- NVIC interrupt controller support
- Internal HyperRAM and SRAM memory regions
- SCU integration
- UART devices and interrupt wiring

AST1040 SCU behavior is compatible with the AST2700 SCUIO model,
so reuse the existing AST2700 SCUIO implementation directly
instead of introducing another identical SCU model. This reduces
duplicate code and helps minimize long-term codebase maintenance.

Several peripherals are currently modeled as unimplemented
devices and can be added incrementally in future updates.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1040.c | 254 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build      |   3 +-
 2 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/aspeed_ast1040.c

diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c
new file mode 100644
index 000000000000..8efcdad8f6a0
--- /dev/null
+++ b/hw/arm/aspeed_ast1040.c
@@ -0,0 +1,254 @@
+/*
+ * ASPEED AST1040 SoC
+ *
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+
+static const hwaddr aspeed_soc_ast1040_memmap[] = {
+    [ASPEED_DEV_SRAM1]     = 0x00000000, /* Hyper RAM */
+    [ASPEED_DEV_FMC]       = 0x74000000,
+    [ASPEED_DEV_SPI0]      = 0x74010000,
+    [ASPEED_DEV_SPI1]      = 0x74020000,
+    [ASPEED_DEV_PWM]       = 0x740C0000,
+    [ASPEED_DEV_UDC]       = 0x74120000,
+    [ASPEED_DEV_SRAM0]     = 0x74B80000,
+    [ASPEED_DEV_ADC]       = 0x74C00000,
+    [ASPEED_DEV_JTAG0]     = 0x74C01000,
+    [ASPEED_DEV_SCU]       = 0x74C02000,
+    [ASPEED_DEV_ESPI]      = 0x74C05000,
+    [ASPEED_DEV_JTAG1]     = 0x74C09000,
+    [ASPEED_DEV_GPIO]      = 0x74C0B000,
+    [ASPEED_DEV_SGPIOM0]   = 0x74C0C000,
+    [ASPEED_DEV_SGPIOM1]   = 0x74C0D000,
+    [ASPEED_DEV_I2C]       = 0x74C0F000,
+    [ASPEED_DEV_I3C]       = 0x74C20000,
+    [ASPEED_DEV_UART0]     = 0x74C33000,
+    [ASPEED_DEV_UART1]     = 0x74C33100,
+    [ASPEED_DEV_UART2]     = 0x74C33200,
+    [ASPEED_DEV_UART3]     = 0x74C33300,
+    [ASPEED_DEV_UART4]     = 0x74C33400,
+    [ASPEED_DEV_UART5]     = 0x74C33500,
+    [ASPEED_DEV_UART6]     = 0x74C33600,
+    [ASPEED_DEV_UART7]     = 0x74C33700,
+    [ASPEED_DEV_UART8]     = 0x74C33800,
+    [ASPEED_DEV_UART9]     = 0x74C33900,
+    [ASPEED_DEV_UART10]    = 0x74C33A00,
+    [ASPEED_DEV_UART11]    = 0x74C33B00,
+    [ASPEED_DEV_UART12]    = 0x74C33C00,
+    [ASPEED_DEV_WDT]       = 0x74C37000,
+    [ASPEED_DEV_TIMER1]    = 0x74C3A000,
+};
+
+static const int aspeed_soc_ast1040_irqmap[] = {
+    [ASPEED_DEV_ESPI]      = 10,
+    [ASPEED_DEV_I2C]       = 64, /* 64 ~ 77 */
+    [ASPEED_DEV_ADC]       = 80,
+    [ASPEED_DEV_GPIO]      = 82,
+    [ASPEED_DEV_SGPIOM0]   = 85,
+    [ASPEED_DEV_TIMER1]    = 92,
+    [ASPEED_DEV_I3C]       = 96, /* 96 ~ 103 */
+    [ASPEED_DEV_WDT]       = 112,
+    [ASPEED_DEV_FMC]       = 121,
+    [ASPEED_DEV_SPI0]      = 122,
+    [ASPEED_DEV_SPI1]      = 123,
+    [ASPEED_DEV_PWM]       = 125,
+    [ASPEED_DEV_UART0]     = 135,
+    [ASPEED_DEV_UART1]     = 136,
+    [ASPEED_DEV_UART2]     = 137,
+    [ASPEED_DEV_UART3]     = 138,
+    [ASPEED_DEV_UART4]     = 139,
+    [ASPEED_DEV_UART5]     = 140,
+    [ASPEED_DEV_UART6]     = 141,
+    [ASPEED_DEV_UART7]     = 142,
+    [ASPEED_DEV_UART8]     = 143,
+    [ASPEED_DEV_UART9]     = 144,
+    [ASPEED_DEV_UART10]    = 145,
+    [ASPEED_DEV_UART11]    = 146,
+    [ASPEED_DEV_UART12]    = 147,
+    [ASPEED_DEV_JTAG0]     = 162,
+};
+
+static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(s);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
+}
+
+static void aspeed_soc_ast1040_init(Object *obj)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
+    AspeedSoCState *s = ASPEED_SOC(obj);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int i;
+    object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+
+    /* AST1040 uses the AST2700 SCUIO model */
+    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCUIO);
+    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
+
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu), "hw-strap1");
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu), "hw-strap2");
+
+    for (i = 0; i < sc->uarts_num; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
+    }
+
+    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "sgpiom[0]", &s->sgpiom[0],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "sgpiom[1]", &s->sgpiom[1],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "jtag[0]", &s->jtag[0],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "jtag[1]", &s->jtag[1],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+}
+
+static void aspeed_soc_ast1040_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    g_autofree char *hyperram_name = NULL;
+    g_autofree char *sram_name = NULL;
+    DeviceState *armv7m;
+    Error *err = NULL;
+    int uart;
+    int i;
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /* AST1040 CPU Core */
+    armv7m = DEVICE(&a->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 256);
+    qdev_prop_set_string(armv7m, "cpu-type",
+                         aspeed_soc_cpu_type(sc->valid_cpu_types));
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    object_property_set_link(OBJECT(&a->armv7m), "memory",
+                             OBJECT(s->memory), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
+
+    /* Internal SRAM */
+    sram_name = g_strdup_printf("aspeed.sram.%d",
+                                CPU(a->armv7m.cpu)->cpu_index);
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
+                           sc->sram_size[0], &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],
+                                &s->sram[0]);
+
+    /* Internal Hyper RAM */
+    hyperram_name = g_strdup_printf("aspeed.hyperram.%d",
+                                    CPU(a->armv7m.cpu)->cpu_index);
+    memory_region_init_ram(&s->sram[1], OBJECT(s), hyperram_name,
+                           sc->sram_size[1], &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
+                                &s->sram[1]);
+
+    /* SCU */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
+
+    /* UART */
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_ast1040_get_irq(s, uart));
+    }
+
+    /* Unimplemented peripherals */
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
+                                  "aspeed.pwm",
+                                  sc->memmap[ASPEED_DEV_PWM], 0x10000);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),
+                                  "aspeed.espi",
+                                  sc->memmap[ASPEED_DEV_ESPI], 0x1000);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
+                                  "aspeed.udc",
+                                  sc->memmap[ASPEED_DEV_UDC], 0x4000);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[0]),
+                                  "aspeed.sgpiom0",
+                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x1000);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom[1]),
+                                  "aspeed.sgpiom1",
+                                  sc->memmap[ASPEED_DEV_SGPIOM1], 0x1000);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
+                                  "aspeed.jtag0",
+                                  sc->memmap[ASPEED_DEV_JTAG0], 0x100);
+
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
+                                  "aspeed.jtag1",
+                                  sc->memmap[ASPEED_DEV_JTAG1], 0x100);
+}
+
+static void aspeed_soc_ast1040_class_init(ObjectClass *klass, const void *data)
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
+    dc->realize = aspeed_soc_ast1040_realize;
+
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev     = AST1040_A0_SILICON_REV;
+    sc->sram_size[0]    = 128 * KiB;
+    sc->sram_size[1]    = 16 * MiB; /* Hyper RAM */
+    sc->uarts_num       = 13;
+    sc->uarts_base      = ASPEED_DEV_UART0;
+    sc->irqmap          = aspeed_soc_ast1040_irqmap;
+    sc->memmap          = aspeed_soc_ast1040_memmap;
+    sc->num_cpus        = 1;
+}
+
+static const TypeInfo aspeed_soc_ast1040_types[] = {
+    {
+        .name           = "ast1040-a0",
+        .parent         = TYPE_ASPEED10X0_SOC,
+        .instance_init  = aspeed_soc_ast1040_init,
+        .class_init     = aspeed_soc_ast1040_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_soc_ast1040_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4fe7efd189e2..1da08d198bee 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -63,7 +63,8 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
-  'aspeed_ast10x0_evb.c'))
+  'aspeed_ast10x0_evb.c',
+  'aspeed_ast1040.c'))
 arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
-- 
2.54.0


