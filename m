Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB424CCF9E5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 11:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCyUi-0000DM-Et; Sun, 26 Oct 2025 07:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUX-0000C2-8Q
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:57 -0400
Received: from mail-m83244.xmail.ntesmail.com ([156.224.83.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyUT-0001De-Ip
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:00:52 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown [117.67.70.197])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2734efe93;
 Sun, 26 Oct 2025 18:53:33 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v3 3/3] hw/arm/stm32f407: Add PWR device to stm32f407 SoC
Date: Sun, 26 Oct 2025 18:53:20 +0800
Message-ID: <20251026105320.5591-4-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026105320.5591-1-fanyihao@rt-thread.org>
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2026ec0603a4kunmcecdce756fba16
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT00ZVhgeGE1LHUxMQxpOHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSkxVTUxVTEtVSkJMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=LeSv9dIE7r+kD8x2p89LehFf14dQXQWBwvEmfakyPeh38c6ZH+XKgvWp7uMYK28i9LbmZt2S3cn0JiXbmdvA3ZXgA6d4mm7NnPvmX9InGdkA2BmqwaiKDHSY/03wle9AfeIguSbZ/vVmRfsH5m0/5cg2J5oTFSd5PSuidZplT6D67RwUyySzL5KVLvB2j9U7gcY/MGZAzC7Gfg7qIeLhjERs0l6C0vBy/FYaf0jo1pjYH+zbq+MOX9ML6QqdqfYpQmwemsUiMvZmw9KCsKmRl4kFmOSZolT5QRt2sQDumqmxWo7nJBbkz5QovcYp748CUjkNWDmAUr6eYUl3k3PGYQ==;
 s=default; c=relaxed/relaxed; d=rt-thread.org; v=1; 
 bh=OPeNH0YZQT3ge2lXtgrOwVZ7h5TGBUtzJOp/6Nywh3M=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=156.224.83.244;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m83244.xmail.ntesmail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the Power supply configuration device to the stm32f407 SoC.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---
 docs/system/arm/stm32.rst       |   1 +
 hw/arm/Kconfig                  |   1 +
 hw/arm/stm32f407_soc.c          |   9 +++
 hw/misc/Kconfig                 |   3 +
 hw/misc/meson.build             |   1 +
 hw/misc/stm32f4xx_pwr.c         | 111 ++++++++++++++++++++++++++++++++
 include/hw/arm/stm32f407_soc.h  |   3 +
 include/hw/misc/stm32f4xx_pwr.h |  40 ++++++++++++
 8 files changed, 169 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_pwr.c
 create mode 100644 include/hw/misc/stm32f4xx_pwr.h

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 3f085eb35ee..c83276f6c12 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -38,6 +38,7 @@ Supported devices
  * System configuration (SYSCFG)
  * Timer controller (TIMER)
  * Reset and Clock Controller (RCC) (STM32F4 only, reset and enable only)
+ * Power supply configuration (PWR) (STM32F4 only)
 
 Missing devices
 ---------------
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ddb2da45ae9..2c07220eb0b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -417,6 +417,7 @@ config STM32F407_SOC
     select ARM_V7M
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
+    select STM32F4XX_PWR
 
 config B_L475E_IOT01A
     bool
diff --git a/hw/arm/stm32f407_soc.c b/hw/arm/stm32f407_soc.c
index 8e20ddcd5b1..1512d922e5e 100644
--- a/hw/arm/stm32f407_soc.c
+++ b/hw/arm/stm32f407_soc.c
@@ -51,6 +51,7 @@ static void stm32f407_soc_initfn(Object *obj)
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32F4XX_EXTI);
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32_RCC);
+    object_initialize_child(obj, "pwr", &s->pwr, TYPE_STM32F4XX_PWR);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
         object_initialize_child(obj, "usart[*]", &s->usart[i],
@@ -183,6 +184,14 @@ static void stm32f407_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
     }
 
+    /* PWR controller */
+    dev = DEVICE(&s->pwr);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pwr), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, PWR_BASE_ADDR);
+
 }
 
 static void stm32f407_soc_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468b..ff4dc58b4d3 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -108,6 +108,9 @@ config STM32F4XX_SYSCFG
 config STM32F4XX_EXTI
     bool
 
+config STM32F4XX_PWR
+    bool
+
 config STM32L4X5_EXTI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2a..0e0f5c3a275 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -112,6 +112,7 @@ system_ss.add(when: 'CONFIG_STM32_RCC', if_true: files('stm32_rcc.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
+system_ss.add(when: 'CONFIG_STM32F4XX_PWR', if_true: files('stm32f4xx_pwr.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_exti.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_SYSCFG', if_true: files('stm32l4x5_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_RCC', if_true: files('stm32l4x5_rcc.c'))
diff --git a/hw/misc/stm32f4xx_pwr.c b/hw/misc/stm32f4xx_pwr.c
new file mode 100644
index 00000000000..83ce0e6a0a9
--- /dev/null
+++ b/hw/misc/stm32f4xx_pwr.c
@@ -0,0 +1,111 @@
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
+#include "qemu/log.h"
+#include "hw/misc/stm32f4xx_pwr.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+
+#ifndef STM32F4XX_PWR_DEBUG
+#define STM32F4XX_PWR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(lvl, fmt, args...) do { \
+    if (STM32F4XX_PWR_DEBUG >= lvl) { \
+        qemu_log("%s: " fmt, __func__, ## args); \
+    } \
+} while (0);
+
+#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+
+static uint64_t stm32f4xx_pwr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    STM32F4XXPwrState *s = opaque;
+
+    switch (offset) {
+    case PWR_CR:
+        return s->pwr_cr;
+    case PWR_CSR:
+        return s->pwr_csr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "STM32F4XX PWR: Bad read offset 0x%lx\n", offset);
+        return 0;
+    }
+}
+
+static void stm32f4xx_pwr_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
+{
+    STM32F4XXPwrState *s = opaque;
+
+    switch (offset) {
+    case PWR_CR:
+        s->pwr_cr = value;
+        if (value & PWR_CR_ODEN)
+            s->pwr_csr |= PWR_CSR_ODRDY;
+        if (value & PWR_CR_ODSWEN)
+            s->pwr_csr |= PWR_CSR_ODSWRDY;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "STM32F4XX PWR: Bad write offset 0x%lx\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_pwr_ops = {
+    .read = stm32f4xx_pwr_read,
+    .write = stm32f4xx_pwr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void stm32f4xx_pwr_init(Object *obj)
+{
+    STM32F4XXPwrState *s = STM32F4XX_PWR(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_pwr_ops, s, TYPE_STM32F4XX_PWR, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void stm32f4xx_pwr_reset(DeviceState *dev)
+{
+    STM32F4XXPwrState *s = STM32F4XX_PWR(dev);
+
+    s->pwr_cr  = 0x0000;
+    s->pwr_csr = 0x0000;
+}
+
+static void stm32f4xx_pwr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, stm32f4xx_pwr_reset);
+}
+
+static const TypeInfo stm32f4xx_pwr_info = {
+    .name          = TYPE_STM32F4XX_PWR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4XXPwrState),
+    .instance_init = stm32f4xx_pwr_init,
+    .class_init    = stm32f4xx_pwr_class_init,
+};
+
+static void stm32f4xx_pwr_register_types(void)
+{
+    type_register_static(&stm32f4xx_pwr_info);
+}
+
+type_init(stm32f4xx_pwr_register_types)
diff --git a/include/hw/arm/stm32f407_soc.h b/include/hw/arm/stm32f407_soc.h
index 3497e91aa1c..f7e39ffaceb 100644
--- a/include/hw/arm/stm32f407_soc.h
+++ b/include/hw/arm/stm32f407_soc.h
@@ -17,6 +17,7 @@
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/misc/stm32_rcc.h"
+#include "hw/misc/stm32f4xx_pwr.h"
 #include "qom/object.h"
 
 #define TYPE_STM32F407_SOC "stm32f407-soc"
@@ -39,6 +40,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F407State, STM32F407_SOC)
 #define SYSCFG_BASE_ADDRESS 0x40013800
 #define SYSCFG_IRQ  71
 #define EXIT_BASE_ADDRESS 0x40013C00
+#define PWR_BASE_ADDR       0x40007000
 
 #define FLASH_BASE_ADDRESS  0x8000000
 #define FLASH_SIZE          0x100000
@@ -57,6 +59,7 @@ typedef struct STM32F407State {
     STM32RccState rcc;
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
+    STM32F4XXPwrState pwr;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
     STM32F2XXTimerState timer[STM_NUM_TIMERS];
 
diff --git a/include/hw/misc/stm32f4xx_pwr.h b/include/hw/misc/stm32f4xx_pwr.h
new file mode 100644
index 00000000000..889fbc26ab0
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_pwr.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Copyright (c) liang yan <yanl1229@rt-thread.org>
+ * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
+ * The reference used is the STMicroElectronics RM0090 Reference manual
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/documentation.html
+ */
+
+#ifndef STM32F4XX_PWR_H
+#define STM32F4XX_PWR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define PWR_CR      0x00
+#define PWR_CSR     0x04
+
+#define PWR_CR_DBP      (1 << 8)
+#define PWR_CR_ODEN     (1 << 16)
+#define PWR_CR_ODSWEN   (1 << 17)
+
+#define PWR_CSR_ODRDY   (1 << 16)
+#define PWR_CSR_ODSWRDY (1 << 17)
+
+#define TYPE_STM32F4XX_PWR "stm32f4xx-pwr"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32F4XXPwrState, STM32F4XX_PWR)
+
+struct STM32F4XXPwrState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t pwr_cr;
+    uint32_t pwr_csr;
+};
+
+#endif
-- 
2.43.0


