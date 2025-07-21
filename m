Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13568C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwzy-0004sk-5g; Mon, 21 Jul 2025 16:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyQ-0003AE-JZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:19:02 -0400
Received: from mail-m81138.xmail.ntesmail.com ([156.224.81.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyL-0000YP-Rv
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:18:56 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown
 [IPV6:240e:360:9379:c800:30:bacc:21c0:5559])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1cc453b69;
 Tue, 22 Jul 2025 04:11:39 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v2 3/3] Add STM32F4xx USART device model
Date: Tue, 22 Jul 2025 04:11:34 +0800
Message-ID: <20250721201134.13270-4-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721201134.13270-1-fanyihao@rt-thread.org>
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk0eVkJDQx5IQkIeSR9MSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kWGg
 8SFR0UWUFZT0tIVUpLSUJDQ0lVSktLVUtZBg++
X-HM-Tid: 0a982e9d085b03a4kunm518c726929260ee
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6LTo*KjEaSTo9GQgPFTIR
 UTMKClZVSlVKTE5ISklDTEtLTENKVTMWGhIXVR0aFQISExoUOwkPVg8TCR4aH1UUCRxFWVdZEgtZ
 QVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kIAVlBSk9NSkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=Sn98J4Huq/s8rG4aCtWUMLDwrp8LwyHWkvsJc3LHme0dkRAt7/Da2GN1wvK2yZBZ9X3uRbtQvUQCbqHIzGxR3A+90VXZgvCCu/WhAku86LSTS8jm4kbDC37bvU61D0tF8Ao5Rv7M+g8GWg36SHMseG37jJOX3BfC4eMoYIetem4ULAibKSZPP90SEqXJisZpKVIa82JYFyNGip9+nl7X3UMSmdFyIHbBLQDkhjBMZg1lhLzPvHh7EK34TRpVNhMf5dEIDUEfwUAZUXVWgcsecWje9/P0vHUB9rECTUoi8ns/X8x+9ByNSIDRKuQIb+3oZaWucRShc5kKo1DBhh+/Sw==;
 c=relaxed/relaxed; s=default; d=rt-thread.org; v=1; 
 bh=TYZjORxpLCC8uEWGuup+3RHrlZ5+JlH9+aCu7j/4njA=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=156.224.81.138;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m81138.xmail.ntesmail.com
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

This patch adds support for the STM32F407 USART controllers device model.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 MAINTAINERS                       |   2 +
 hw/arm/Kconfig                    |   1 +
 hw/arm/stm32f407_soc.c            |  25 +++
 hw/char/Kconfig                   |   3 +
 hw/char/meson.build               |   1 +
 hw/char/stm32f4xx_usart.c         | 236 ++++++++++++++++++++++++++++++
 include/hw/arm/stm32f407_soc.h    |   8 +
 include/hw/char/stm32f4xx_usart.h |  60 ++++++++
 8 files changed, 335 insertions(+)
 create mode 100644 hw/char/stm32f4xx_usart.c
 create mode 100644 include/hw/char/stm32f4xx_usart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dc7c7bf60..2054aba27e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1150,6 +1150,8 @@ M: Yihao Fan <fanyihao@rt-thread.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/stm32f407_soc.c
+F: hw/char/stm32f4xx_usart.c
+F: include/hw/char/stm32f4xx_usart.h
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3706a65286..c6a4919266 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -403,6 +403,7 @@ config STM32F407_SOC
     select ARM_V7M
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
+    select STM32F4XX_USART
 
 config B_L475E_IOT01A
     bool
diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
index 0a91d4bb10..8a929674af 100644
--- a/hw/arm/stm32f407_soc.c
+++ b/hw/arm/stm32f407_soc.c
@@ -20,6 +20,13 @@ static const int exti_irq[] = {
     40, 40, 40, 40, 40
 };
 
+static const uint32_t usart_addr[STM_NUM_USARTS] = {
+    STM32F407_USART1, STM32F407_USART2, STM32F407_USART3,
+    STM32F407_USART6
+};
+static const int usart_irq[STM_NUM_USARTS] = {
+    37, 38, 39, 71
+};
 
 static void stm32f407_soc_initfn(Object *obj)
 {
@@ -32,6 +40,12 @@ static void stm32f407_soc_initfn(Object *obj)
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
 
+   for (i = 0; i < STM_NUM_USARTS; i++) {
+        object_initialize_child(obj, "usart[*]", &s->usart[i],
+                                TYPE_STM32F4XX_USART);
+    }
+
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
 }
@@ -105,6 +117,18 @@ static void stm32f407_soc_realize(DeviceState *dev_soc, Error **errp)
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
     }
 
+    /* USART controllers */
+    for (i = 0; i < STM_NUM_USARTS; i) {
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
 }
 
 static void stm32f407_soc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 9d517f3e28..25a0483fb3 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -51,6 +51,9 @@ config VIRTIO_SERIAL
 config STM32F2XX_USART
     bool
 
+config STM32F4XX_USART
+    bool
+
 config STM32L4X5_USART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 4e439da8b9..3372e77bbc 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -32,6 +32,7 @@ system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
+system_ss.add(when: 'CONFIG_STM32F4XX_USART', if_true: files('stm32f4xx_usart.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
diff --git a/hw/char/stm32f4xx_usart.c b/hw/char/stm32f4xx_usart.c
new file mode 100644
index 0000000000..c3d2690275
--- /dev/null
+++ b/hw/char/stm32f4xx_usart.c
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "hw/char/stm32f4xx_usart.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/module.h"
+
+#ifndef STM_USART_ERR_DEBUG
+#define STM_USART_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(lvl, fmt, args...) do { \
+    if (STM_USART_ERR_DEBUG >= lvl) { \
+        qemu_log("%s: " fmt, __func__, ## args); \
+    } \
+} while (0)
+
+#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+
+static int stm32f4xx_usart_can_receive(void *opaque)
+{
+    STM32F4XXUsartState *s = opaque;
+
+    if (!(s->usart_sr & USART_SR_RXNE)) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static void stm32f4xx_usart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    STM32F4XXUsartState *s = opaque;
+
+    s->usart_dr = *buf;
+
+    if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
+        /* USART not enabled - drop the chars */
+        DB_PRINT("Dropping the chars\n");
+        return;
+    }
+
+    s->usart_sr |= USART_SR_RXNE;
+
+    if (s->usart_cr1 & USART_CR1_RXNEIE) {
+        qemu_set_irq(s->irq, 1);
+    }
+
+    DB_PRINT("Receiving: %c\n", s->usart_dr);
+}
+
+static void stm32f4xx_usart_reset(DeviceState *dev)
+{
+    STM32F4XXUsartState *s = STM32F4XX_USART(dev);
+
+    s->usart_sr = USART_SR_RESET;
+    s->usart_dr = 0x00000000;
+    s->usart_brr = 0x00000000;
+    s->usart_cr1 = 0x00000000;
+    s->usart_cr2 = 0x00000000;
+    s->usart_cr3 = 0x00000000;
+    s->usart_gtpr = 0x00000000;
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static uint64_t stm32f4xx_usart_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    STM32F4XXUsartState *s = opaque;
+    uint64_t retvalue;
+
+    DB_PRINT("Read 0x%"HWADDR_PRIx"\n", addr);
+
+    switch (addr) {
+    case USART_SR:
+        retvalue = s->usart_sr;
+        qemu_chr_fe_accept_input(&s->chr);
+        return retvalue;
+    case USART_DR:
+        DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
+        s->usart_sr |= USART_SR_TXE;
+        s->usart_sr &= ~USART_SR_RXNE;
+        qemu_chr_fe_accept_input(&s->chr);
+        qemu_set_irq(s->irq, 0);
+        if (s->usart_cr1 & USART_CR1_M) {
+            return s->usart_dr & 0x1FF;
+        } else {
+            return s->usart_dr & 0xFF;
+        }
+    case USART_BRR:
+        return s->usart_brr;
+    case USART_CR1:
+        return s->usart_cr1;
+    case USART_CR2:
+        return s->usart_cr2;
+    case USART_CR3:
+        return s->usart_cr3;
+    case USART_GTPR:
+        return s->usart_gtpr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        return 0;
+    }
+
+    return 0;
+}
+
+static void stm32f4xx_usart_write(void *opaque, hwaddr addr,
+                                  uint64_t val64, unsigned int size)
+{
+    STM32F4XXUsartState *s = opaque;
+    uint32_t value = val64;
+    unsigned char ch;
+
+    DB_PRINT("Write 0x%" PRIx32 ", 0x%"HWADDR_PRIx"\n", value, addr);
+
+    switch (addr) {
+    case USART_SR:
+        if (value <= 0x3FF) {
+            s->usart_sr |= value;
+        } else {
+            s->usart_sr &= value;
+        }
+        if (!(s->usart_sr & USART_SR_RXNE)) {
+            qemu_set_irq(s->irq, 0);
+        }
+        return;
+    case USART_DR:
+        if (s->usart_cr1 & USART_CR1_M) {
+            ch = value & 0x1FF;
+        } else {
+            ch = value & 0xFF;
+        }
+        if (!(s->usart_cr1 & USART_CR1_TE)) {
+            return;
+        }
+        if ((s->usart_sr & USART_SR_TC)) {
+            s->usart_sr &= ~USART_SR_TC;
+        }
+        ch = value;
+        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        s->usart_sr |= USART_SR_TXE;
+        if (s->usart_cr1 & USART_CR1_TXEIE) {
+            qemu_set_irq(s->irq, 0);
+        }
+        s->usart_sr |= USART_SR_TC;
+        if (s->usart_cr1 & USART_CR1_TCIE) {
+            qemu_set_irq(s->irq, 0);
+        }
+        break;
+    case USART_BRR:
+        s->usart_brr |= value & 0xFFFF;
+        break;
+    case USART_CR1:
+        if (!(s->usart_cr1 & USART_CR1_TE) && (value & USART_CR1_TE)) {
+            s->usart_dr = 0xFF;
+        }
+        s->usart_cr1 |= value & 0xFFFF;
+        if (s->usart_cr1 & USART_CR1_RXNEIE &&
+            s->usart_sr & USART_SR_RXNE) {
+            qemu_set_irq(s->irq, 0);
+        }
+        break;
+    case USART_CR2:
+        s->usart_cr2 |= value & 0xFFFF;
+        break;
+    case USART_CR3:
+        s->usart_cr3 |= value;
+        break;
+    case USART_GTPR:
+        s->usart_gtpr |= value & 0xFFFF;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_usart_ops = {
+    .read = stm32f4xx_usart_read,
+    .write = stm32f4xx_usart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static Property stm32f4xx_usart_properties[] = {
+    DEFINE_PROP_CHR("chardev", STM32F4XXUsartState, chr),
+};
+
+static void stm32f4xx_usart_init(Object *obj)
+{
+    STM32F4XXUsartState *s = STM32F4XX_USART(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_usart_ops, s,
+                          TYPE_STM32F4XX_USART, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void stm32f4xx_usart_realize(DeviceState *dev, Error **errp)
+{
+    STM32F4XXUsartState *s = STM32F4XX_USART(dev);
+
+     qemu_chr_fe_set_handlers(&s->chr, stm32f4xx_usart_can_receive,
+                             stm32f4xx_usart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static void stm32f4xx_usart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, stm32f4xx_usart_reset);
+    device_class_set_props(dc, stm32f4xx_usart_properties);
+    dc->realize = stm32f4xx_usart_realize;
+}
+
+static const TypeInfo stm32f4xx_usart_info = {
+    .name          = TYPE_STM32F4XX_USART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4XXUsartState),
+    .instance_init = stm32f4xx_usart_init,
+    .class_init    = stm32f4xx_usart_class_init,
+};
+
+static void stm32f4xx_usart_register_types(void)
+{
+    type_register_static(&stm32f4xx_usart_info);
+}
+
+type_init(stm32f4xx_usart_register_types)
diff --git a/include/hw/arm/stm32f407_soc.h b/include/hw/arm/stm32f407_soc.h
index 19191dc44e..6599e8aa48 100644
--- a/include/hw/arm/stm32f407_soc.h
+++ b/include/hw/arm/stm32f407_soc.h
@@ -6,6 +6,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/misc/stm32f4xx_exti.h"
+#include "hw/char/stm32f4xx_usart.h"
 
 #include "qom/object.h"
 
@@ -20,6 +21,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F407State, STM32F407_SOC)
 #define SRAM_BASE_ADDRESS   0x20000000
 #define SRAM_SIZE           (192 * 1024)
 
+#define STM_NUM_USARTS      4
+#define STM32F407_USART1    0x40011000
+#define STM32F407_USART2    0x40004400
+#define STM32F407_USART3    0x40004800
+#define STM32F407_USART6    0x40011400
+
 
 struct STM32F407State {
     /*< private >*/
@@ -31,6 +38,7 @@ struct STM32F407State {
 
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
+    STM32F4XXUsartState usart[STM_NUM_USARTS];
 
     Clock *sysclk;
     Clock *refclk;
diff --git a/include/hw/char/stm32f4xx_usart.h b/include/hw/char/stm32f4xx_usart.h
new file mode 100644
index 0000000000..611906bd83
--- /dev/null
+++ b/include/hw/char/stm32f4xx_usart.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef HW_STM32F4XX_USART_H
+#define HW_STM32F4XX_USART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+
+#define USART_SR   0x00
+#define USART_DR   0x04
+#define USART_BRR  0x08
+#define USART_CR1  0x0C
+#define USART_CR2  0x10
+#define USART_CR3  0x14
+#define USART_GTPR 0x18
+
+#define USART_SR_RESET 0x00C0
+
+#define USART_SR_TXE  (1 << 7)
+#define USART_SR_TC   (1 << 6)
+#define USART_SR_RXNE (1 << 5)
+
+#define USART_CR1_UE      (1 << 13)
+#define USART_CR1_RXNEIE  (1 << 5)
+#define USART_CR1_TE      (1 << 3)
+#define USART_CR1_RE      (1 << 2)
+#define USART_CR1_M       (1 << 12)
+#define USART_CR1_TXEIE   (1 << 7)
+#define USART_CR1_TCIE    (1 << 6)
+
+#define USART_CR2_CLKEN   (1 << 11)
+#define USART_CR2_LINEN   (1 << 14)
+
+#define USART_CR3_SCEN    (1 << 5)
+#define USART_CR3_HDSEL   (1 << 3)
+#define USART_CR3_IREN    (1 << 1)
+
+#define TYPE_STM32F4XX_USART "stm32f4xx-usart"
+#define STM32F4XX_USART(obj) \
+    OBJECT_CHECK(STM32F4XXUsartState, (obj), TYPE_STM32F4XX_USART)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t usart_sr;
+    uint32_t usart_dr;
+    uint32_t usart_brr;
+    uint32_t usart_cr1;
+    uint32_t usart_cr2;
+    uint32_t usart_cr3;
+    uint32_t usart_gtpr;
+
+    CharBackend chr;
+    qemu_irq irq;
+} STM32F4XXUsartState;
+
+#endif
-- 
2.43.0


