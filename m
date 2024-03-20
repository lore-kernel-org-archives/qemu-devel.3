Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E48C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 18:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0zA-0003gb-MA; Wed, 20 Mar 2024 14:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn0z8-0003g0-MP
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:48:23 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balbi@kernel.org>) id 1rn0z5-0007KY-J3
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:48:22 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 283C560FDD;
 Wed, 20 Mar 2024 18:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECAAC43390;
 Wed, 20 Mar 2024 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710960490;
 bh=vEJseGEGOfaRgubWOgywJBa+3ifeIYRNEezqXa5TSho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EeSICF2S1yZvJkE4C9OPTpFkQJGZ7NbkBT1rKj/MlmZTib9rNnttFDoB15kEWaLjZ
 HRBEAVR61QJH1iCLyYY19xYZ8K3RtgZtYqZV5b5z6PRAD1qP7vwyBohiHVkOnlADze
 +xYRhHVDnv++BRqt1Y1enXZFQOpr2CP8WdaNFXeNFOPYqgFc1E0hDxI0Ikj50B1vdK
 0RY1LXI7nIh6vAggzGbg7pd8qw+PkEVARGZt/6ztg4Be/3AVErLPhbiTOFhT16FKth
 YqRd2/HAEisFMPjnYC3r70orcrKRIC67mCaQHQ9OWVVxGGp4Er74o6xvRJivCYCIHz
 5RrG671i6onZQ==
From: Felipe Balbi <balbi@kernel.org>
To: qemu-devel@nongnu.org
Cc: Felipe Balbi <felipe@balbi.sh>
Subject: [PATCH 1/2] hw/arm: Add support for stm32g000 SoC family
Date: Wed, 20 Mar 2024 20:47:58 +0200
Message-ID: <20240320184759.754619-2-balbi@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320184759.754619-1-balbi@kernel.org>
References: <20240320184759.754619-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=balbi@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Felipe Balbi <felipe@balbi.sh>

Minimal support with USARTs and SPIs working. This SoC will be used to
create and nucleo-g071rb board.

Signed-off-by: Felipe Balbi <felipe@balbi.sh>
---
 hw/arm/Kconfig                 |   6 +
 hw/arm/meson.build             |   1 +
 hw/arm/stm32g000_soc.c         | 246 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32g000_soc.h |  62 +++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 hw/arm/stm32g000_soc.c
 create mode 100644 include/hw/arm/stm32g000_soc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66b9..28a46d2b1ad3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -463,6 +463,12 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config STM32G000_SOC
+    bool
+    select ARM_V7M
+    select STM32F2XX_USART
+    select STM32F2XX_SPI
+
 config B_L475E_IOT01A
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 6808135c1f79..9c4137a988e1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -34,6 +34,7 @@ arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c',
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_ss.add(when: 'CONFIG_STM32G000_SOC', if_true: files('stm32g000_soc.c'))
 arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
 arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
diff --git a/hw/arm/stm32g000_soc.c b/hw/arm/stm32g000_soc.c
new file mode 100644
index 000000000000..8f97d8c89ad9
--- /dev/null
+++ b/hw/arm/stm32g000_soc.c
@@ -0,0 +1,246 @@
+/*
+ * STM32G000 SoC
+ *
+ * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/boot.h"
+#include "exec/address-spaces.h"
+#include "hw/arm/stm32g000_soc.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
+
+/* stm32g000_soc implementation is derived from stm32f100_soc */
+
+struct stm32g0_ip_config {
+    const char	*name;
+    uint32_t	addr;
+    uint32_t	irq;
+};
+
+#define STM32G0_DEFINE_IP(n, a, i)    \
+{                                     \
+    .name = (n),                      \
+    .addr = (a),                      \
+    .irq = (i),                       \
+}
+
+static const struct stm32g0_ip_config usart_config[STM_NUM_USARTS] = {
+    STM32G0_DEFINE_IP("USART1", 0x40013800, 27),
+    STM32G0_DEFINE_IP("USART2", 0x40004000, 28),
+    STM32G0_DEFINE_IP("USART3", 0x40004400, 29),
+    STM32G0_DEFINE_IP("USART4", 0x40004800, 29),
+    STM32G0_DEFINE_IP("USART5", 0x40004c00, 29),
+    STM32G0_DEFINE_IP("USART6", 0x40005000, 29),
+    STM32G0_DEFINE_IP("LPUSART1", 0x40008000, 29),
+    STM32G0_DEFINE_IP("LPUSART2", 0x40008400, 28),
+};
+
+static const struct stm32g0_ip_config spi_config[STM_NUM_SPIS] = {
+    STM32G0_DEFINE_IP("SPI1", 0x40013000, 25),
+    STM32G0_DEFINE_IP("SPI2", 0x40003800, 26),
+    /* STM32G0_DEFINE_IP("SPI3", 0x4003c000, 26), only on STM32G0B1xx and STM32G0C1xx */
+};
+
+static void stm32g000_soc_initfn(Object *obj)
+{
+    STM32G000State *s = STM32G000_SOC(obj);
+    int i;
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32F2XX_USART);
+    }
+
+    for (i = 0; i < STM_NUM_SPIS; i++) {
+        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2XX_SPI);
+    }
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+}
+
+static void stm32g000_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32G000State *s = STM32G000_SOC(dev_soc);
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
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
+    /*
+     * Init flash region
+     * Flash starts at 0x08000000 and then is aliased to boot memory at 0x0
+     */
+    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32G000.flash",
+                           FLASH_SIZE, &error_fatal);
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "STM32G000.flash.alias", &s->flash, 0, FLASH_SIZE);
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    /* Init SRAM region */
+    memory_region_init_ram(&s->sram, NULL, "STM32G000.sram", SRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    /* Init ARMv7m */
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 61);
+    qdev_prop_set_uint8(armv7m, "num-prio-bits", 4);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m0"));
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    /* Attach UART (uses USART registers) and USART controllers */
+    for (unsigned i = 0; i < STM_NUM_USARTS; i++) {
+        dev = DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, usart_config[i].addr);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_config[i].irq));
+    }
+
+    /* SPI 1 and 2
+     *
+     * REVISIT: STM32G0B1xx and STM32G0C1xx have a 3rd SPI
+     */
+    for (unsigned i = 0; i < STM_NUM_SPIS; i++) {
+        dev = DEVICE(&(s->spi[i]));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, spi_config[i].addr);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_config[i].irq));
+    }
+
+    /* Review addresses */
+    create_unimplemented_device("timer[2]",  0x40000000, 0x400);
+    create_unimplemented_device("timer[3]",  0x40000400, 0x400);
+    create_unimplemented_device("timer[4]",  0x40000800, 0x400);
+    create_unimplemented_device("timer[6]",  0x40001000, 0x400);
+    create_unimplemented_device("timer[7]",  0x40001400, 0x400);
+    create_unimplemented_device("RTC",       0x40002800, 0x400);
+    create_unimplemented_device("WWDG",      0x40002c00, 0x400);
+    create_unimplemented_device("IWDG",      0x40003000, 0x400);
+    create_unimplemented_device("USB",       0x40005000, 0x400);
+    create_unimplemented_device("FDCAN1",    0x40006400, 0x400);
+    create_unimplemented_device("FDCAN2",    0x40006800, 0x400);
+    create_unimplemented_device("CRS",       0x40006c00, 0x400);
+    create_unimplemented_device("PWR",       0x40007000, 0x400);
+    create_unimplemented_device("DAC",       0x40007400, 0x400);
+    create_unimplemented_device("CEC",       0x40007800, 0x400);
+    create_unimplemented_device("LPTIM1",    0x40007c00, 0x400);
+    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
+    create_unimplemented_device("LPUART2",   0x40008400, 0x400);
+    create_unimplemented_device("I2C3",      0x40008800, 0x400);
+    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
+    create_unimplemented_device("USB RAM1",  0x40009800, 0x400);
+    create_unimplemented_device("USB RAM2",  0x40009c00, 0x400);
+    create_unimplemented_device("UCPD1",     0x4000a000, 0x400);
+    create_unimplemented_device("UCPD2",     0x4000a400, 0x400);
+    create_unimplemented_device("TAMP",      0x4000b000, 0x400);
+    create_unimplemented_device("FDCAN",     0x4000b400, 0x800);
+    create_unimplemented_device("ADC",       0x40012400, 0x400);
+    create_unimplemented_device("timer[1]",  0x40012C00, 0x400);
+    create_unimplemented_device("timer[15]", 0x40014000, 0x400);
+    create_unimplemented_device("timer[16]", 0x40014400, 0x400);
+    create_unimplemented_device("timer[17]", 0x40014800, 0x400);
+    create_unimplemented_device("DMA1",      0x40020000, 0x400);
+    create_unimplemented_device("DMA2",      0x40020400, 0x400);
+    create_unimplemented_device("DMAMUX",    0x40020800, 0x800);
+    create_unimplemented_device("RCC",       0x40021000, 0x400);
+    create_unimplemented_device("EXTI",      0x40021800, 0x400);
+    create_unimplemented_device("FLASH",     0x40022000, 0x400);
+    create_unimplemented_device("CRC",       0x40023000, 0x400);
+    create_unimplemented_device("RNG",       0x40025000, 0x400);
+    create_unimplemented_device("AES",       0x40026000, 0x400);
+    create_unimplemented_device("GPIOA",     0x50000000, 0x400);
+    create_unimplemented_device("GPIOB",     0x50000400, 0x400);
+    create_unimplemented_device("GPIOC",     0x50000800, 0x400);
+    create_unimplemented_device("GPIOD",     0x50000c00, 0x400);
+    create_unimplemented_device("GPIOE",     0x50001000, 0x400);
+    create_unimplemented_device("GPIOF",     0x50001400, 0x400);
+}
+
+static void stm32g000_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32g000_soc_realize;
+    /* No vmstate or reset required: device has no internal state */
+}
+
+static const TypeInfo stm32g000_soc_info = {
+    .name          = TYPE_STM32G000_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32G000State),
+    .instance_init = stm32g000_soc_initfn,
+    .class_init    = stm32g000_soc_class_init,
+};
+
+static void stm32g000_soc_types(void)
+{
+    type_register_static(&stm32g000_soc_info);
+}
+
+type_init(stm32g000_soc_types)
diff --git a/include/hw/arm/stm32g000_soc.h b/include/hw/arm/stm32g000_soc.h
new file mode 100644
index 000000000000..dd3857c87189
--- /dev/null
+++ b/include/hw/arm/stm32g000_soc.h
@@ -0,0 +1,62 @@
+/*
+ * STM32G000 SoC
+ *
+ * Copyright (c) 2024 Felipe Balbi <felipe@balbi.sh>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_ARM_STM32G000_SOC_H
+#define HW_ARM_STM32G000_SOC_H
+
+#include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/char/stm32f2xx_usart.h"
+#include "hw/ssi/stm32f2xx_spi.h"
+#include "hw/arm/armv7m.h"
+#include "qom/object.h"
+#include "hw/clock.h"
+
+#define TYPE_STM32G000_SOC "stm32g000-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32G000State, STM32G000_SOC)
+
+#define STM_NUM_USARTS 8
+#define STM_NUM_SPIS 2
+
+#define FLASH_BASE_ADDRESS 0x08000000
+#define FLASH_SIZE (128 * 1024)
+#define SRAM_BASE_ADDRESS 0x20000000
+#define SRAM_SIZE (36 * 1024)
+
+struct STM32G000State {
+    SysBusDevice parent_obj;
+
+    ARMv7MState armv7m;
+
+    STM32F2XXUsartState usart[STM_NUM_USARTS];
+    STM32F2XXSPIState spi[STM_NUM_SPIS];
+
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+
+    Clock *sysclk;
+    Clock *refclk;
+};
+
+#endif
-- 
2.44.0


