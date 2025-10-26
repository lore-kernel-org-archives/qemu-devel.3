Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CD8CCD193
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 11:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCyUT-000098-Pn; Sun, 26 Oct 2025 07:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUN-00008S-Hg
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:45 -0400
Received: from mail-m82109.xmail.ntesmail.com ([156.224.82.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUK-0001DM-3u
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:43 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown [117.67.70.197])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2734efe8d;
 Sun, 26 Oct 2025 18:53:29 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v3 1/3] hw/arm: Add support for the STM32F407 SoC|
Date: Sun, 26 Oct 2025 18:53:18 +0800
Message-ID: <20251026105320.5591-2-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026105320.5591-1-fanyihao@rt-thread.org>
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2026dd6d03a4kunmcecdce756fb9d0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxgYVkNIQ09NSklCT09PS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSkxVTUxVTEtVSkJMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=GOxTajplREGhFfSNDdN3lp8E1EKwpuIoYqbhkv+IUMRxXNKEQkizghIOixDVDhyJAhIAbHAvmSdSxpYnyR6ABBHsgKS3nzXqmdrFaw06PjZ1HDRA1QrtAgPDo8F54zE+WYJvZuAXZ8HsC6U0s6hojX7WkgrHXh9E3kzZVRuXX7s6ou9g4yvAoyFD3O2B1x9kylGB01ffJaEw+G5SGtQ/Lzv6qopW9svsiIirqLp/D2acTcoIJBGunVWGwOsDwiPCpQ9M81yHyzjNv5bJN4sJu/6vxGTIXUjKws1So2bYLdBkS6D5zb2Fv9uC76ruIscJesKNTf/JzNuX8kiBa6WWNg==;
 s=default; c=relaxed/relaxed; d=rt-thread.org; v=1; 
 bh=sGVPZ8gA5r2Nwvf5BhQZjT1d9gQGdKW8aQGO0W3CrmM=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=156.224.82.109;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m82109.xmail.ntesmail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yihao Fan <fanyihao@rt-thread.org>

This patch introduces a new QEMU machine type for the STM32F407 SoC featuring a Cortex-M4 core.
This will be used by the RT-Spark to create a machine.
Furthermore, I have updated the reusable USART, timer,
and RCC drivers to align with the existing driver implementations.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 MAINTAINERS                    |   7 ++
 hw/arm/Kconfig                 |   6 +
 hw/arm/meson.build             |   1 +
 hw/arm/stm32f407_soc.c         | 208 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32f407_soc.h |  74 ++++++++++++
 5 files changed, 296 insertions(+)
 create mode 100644 hw/arm/stm32f407_soc.c
 create mode 100644 include/hw/arm/stm32f407_soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eef27b419..ceef177740b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1163,6 +1163,13 @@ F: hw/misc/stm32f4xx_exti.c
 F: hw/misc/stm32_rcc.c
 F: include/hw/misc/stm32_rcc.h
 
+STM32F407
+M: yanl1229 <yanl1229@rt-thread.org>
+M: Yihao Fan <fanyihao@rt-thread.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32f407_soc.c
+
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b44b85f4361..bbf675c158c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -406,6 +406,12 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config STM32F407_SOC
+    bool
+    select ARM_V7M
+    select STM32F4XX_SYSCFG
+    select STM32F4XX_EXTI
+
 config B_L475E_IOT01A
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b88b5b06d7e..1de2642620a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -33,6 +33,7 @@ arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_common_ss.add(when: 'CONFIG_STM32F407_SOC', if_true: files('stm32f407_soc.c'))
 arm_common_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
 arm_common_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
new file mode 100644
index 00000000000..8e20ddcd5b1
--- /dev/null
+++ b/hw/arm/stm32f407_soc.c
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Copyright (c) liang yan <yanl1229@rt-thread.org>
+ * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
+ * The reference used is the STMicroElectronics RM0090 Reference manual
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/documentation.html
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "system/address-spaces.h"
+#include "system/system.h"
+#include "hw/arm/stm32f407_soc.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "hw/sd/sd.h"
+#include "hw/boards.h"
+#include "qom/object.h"
+
+static const uint32_t syscfg_addr = 0x40013800;
+static const uint32_t exti_addr = 0x40013C00;
+static const uint32_t usart_addr[STM_NUM_USARTS] = {
+    STM32F407_USART1, STM32F407_USART2, STM32F407_USART3,
+    STM32F407_USART6
+};
+/* At the moment only Timer 2 to 5 are modelled */
+static const uint32_t timer_addr[STM_NUM_TIMERS] = {
+    STM32F407_TIM2, STM32F407_TIM3, STM32F407_TIM4,
+    STM32F407_TIM5
+};
+static const int syscfg_irq = 71;
+static const int exti_irq[] = {
+    6, 7, 8, 9, 10, 23, 23, 23, 23, 23, 40,
+    40, 40, 40, 40, 40
+};
+static const int usart_irq[STM_NUM_USARTS] = {
+    37, 38, 39, 71
+};
+static const int timer_irq[STM_NUM_TIMERS] = {
+    28, 29, 30, 50
+};
+
+static void stm32f407_soc_initfn(Object *obj)
+{
+    int i;
+
+    STM32F407State *s = STM32F407_SOC(obj);
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+    object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
+    object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
+    object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32_RCC);
+
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32F2XX_USART);
+    }
+
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        object_initialize_child(obj, "timer[*]", &s->timer[i],
+                                TYPE_STM32F2XX_TIMER);
+    }
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+}
+
+static void stm32f407_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32F407State *s = STM32F407_SOC(dev_soc);
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    DriveInfo *dinfo;
+    int i, j;
+
+    MemoryRegion *system_memory = get_system_memory();
+
+    /*
+     * We use s->refclk internally and only define it with qdev_init_clock_in()
+     * so it is correctly parented and not leaked on an init/deinit; it is not
+     * intended as an externally exposed clock.
+     */
+    if (clock_has_source(s->refclk)) {
+        error_setg(errp, "refclk clock must not be wired up by the board code");
+        return;
+    }
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /*
+     * TODO: ideally we should model the SoC RCC and its ability to
+     * change the sysclk frequency and define different sysclk sources.
+     */
+
+    /* The refclk always runs at frequency HCLK / 8 */
+    clock_set_mul_div(s->refclk, 8, 1);
+    clock_set_source(s->refclk, s->sysclk);
+
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F407.flash",
+                           FLASH_SIZE, &error_fatal);
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32F407.flash.alias", &s->flash, 0, FLASH_SIZE);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    memory_region_init_ram(&s->sram, NULL, "STM32F407.sram", SRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    memory_region_init_ram(&s->ccm, NULL, "STM32F407.ccm", CCM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, CCM_BASE_ADDRESS, &s->ccm);
+
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 98);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    /* Reset and clock controller */
+    dev = DEVICE(&s->rcc);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rcc), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, RCC_BASE_ADDR);
+
+    /* System configuration controller */
+    dev = DEVICE(&s->syscfg);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, syscfg_addr);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, syscfg_irq));
+
+    /* EXTI device */
+    dev = DEVICE(&s->exti);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, exti_addr);
+    for (i = 0; i < 16; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+    for (i = 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
+    }
+
+    /* Attach UART (uses USART registers) and USART controllers */
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        dev = DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, usart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
+    }
+
+    /* Timer 2 to 5 contoller */
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        dev = DEVICE(&(s->timer[i]));
+        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, timer_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
+    }
+
+}
+
+static void stm32f407_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32f407_soc_realize;
+}
+
+static const TypeInfo stm32f407_soc_info = {
+    .name          = TYPE_STM32F407_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F407State),
+    .instance_init = stm32f407_soc_initfn,
+    .class_init    = stm32f407_soc_class_init,
+};
+
+static void stm32f407_soc_types(void)
+{
+    type_register_static(&stm32f407_soc_info);
+}
+
+type_init(stm32f407_soc_types)
diff --git a/include/hw/arm/stm32f407_soc.h b/include/hw/arm/stm32f407_soc.h
new file mode 100644
index 00000000000..3497e91aa1c
--- /dev/null
+++ b/include/hw/arm/stm32f407_soc.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Copyright (c) liang yan <yanl1229@rt-thread.org>
+ * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
+ * The reference used is the STMicroElectronics RM0090 Reference manual
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/documentation.html
+ */
+
+#ifndef STM32F407_SOC_H
+#define STM32F407_SOC_H
+
+#include "hw/or-irq.h"
+#include "hw/arm/armv7m.h"
+#include "hw/misc/stm32f4xx_syscfg.h"
+#include "hw/misc/stm32f4xx_exti.h"
+#include "hw/char/stm32f2xx_usart.h"
+#include "hw/timer/stm32f2xx_timer.h"
+#include "hw/misc/stm32_rcc.h"
+#include "qom/object.h"
+
+#define TYPE_STM32F407_SOC "stm32f407-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32F407State, STM32F407_SOC)
+
+#define STM_NUM_USARTS      4
+#define STM32F407_USART1    0x40011000
+#define STM32F407_USART2    0x40004400
+#define STM32F407_USART3    0x40004800
+#define STM32F407_USART6    0x40011400
+
+#define STM_NUM_TIMERS      4
+#define STM32F407_TIM1      0x40010000
+#define STM32F407_TIM2      0x40000000
+#define STM32F407_TIM3      0x40000400
+#define STM32F407_TIM4      0x40000800
+#define STM32F407_TIM5      0x40000c00
+
+#define RCC_BASE_ADDR       0x40023800
+#define SYSCFG_BASE_ADDRESS 0x40013800
+#define SYSCFG_IRQ  71
+#define EXIT_BASE_ADDRESS 0x40013C00
+
+#define FLASH_BASE_ADDRESS  0x8000000
+#define FLASH_SIZE          0x100000
+#define SRAM_BASE_ADDRESS   0x20000000
+#define SRAM_SIZE           (192 * 1024)
+#define CCM_BASE_ADDRESS    0x10000000
+#define CCM_SIZE            (64 * 1024)
+
+typedef struct STM32F407State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    ARMv7MState armv7m;
+
+    STM32RccState rcc;
+    STM32F4xxSyscfgState syscfg;
+    STM32F4xxExtiState exti;
+    STM32F2XXUsartState usart[STM_NUM_USARTS];
+    STM32F2XXTimerState timer[STM_NUM_TIMERS];
+
+    MemoryRegion ccm;
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+
+    Clock *sysclk;
+    Clock *refclk;
+
+
+} STM32F407State;
+
+#endif
-- 
2.43.0


