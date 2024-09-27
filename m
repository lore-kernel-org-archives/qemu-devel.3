Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4023CDD1BA
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 15:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suCa8-0002yf-GP; Fri, 27 Sep 2024 11:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCa5-0002vm-9T; Fri, 27 Sep 2024 11:08:29 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1suCa2-0002Eg-Uf; Fri, 27 Sep 2024 11:08:29 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so2964582e87.1; 
 Fri, 27 Sep 2024 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727449704; x=1728054504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/Cw+xlGaOoTh4XIy2fnANG0i3JjzxFFPGTfIaId9U4=;
 b=Q5ceO/ELwEUciG+L5ICBdEeOACcmSCYXxCpcLKzoSVOzc53yLr+XTmv+OHi+DwkZnu
 yHyQHlR4rhgTx/G4fnoCiOT/nSipCPYcV69kVSYfRfQqKMWYta53AFkl4ZLXaYDHR6Ts
 g1txd1BjGVgfGNHCOvvl15UdjOut0wU/u+4gc/q316kIG5Ggh85RXi6wnqN2QdwRgvXZ
 AJD9vOiUqlC+mb/rwcgQImbErJnTqq9DVnG/R/vCuBvz68P0aiL2IZL+zaOatBda3BcI
 zdkmy/k/U1BLzxqka4Mada4rFpXjCXZXODjq6mPC6Sl0NIH6oImTthA4Xs+E9DzOVB9Z
 OM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727449704; x=1728054504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/Cw+xlGaOoTh4XIy2fnANG0i3JjzxFFPGTfIaId9U4=;
 b=UMrhAs00cUQT5C/rfDx6qofBlz8lZmvGGSGyBodtJaDVxfqPwsfoiyhKEpAUMoie6g
 cd5uxjM8SJpl5qtRBCn1B+gJaD0Hl3iaLR1pbb2S795HUOKKhgILt1AMSHcrnGz2ff4P
 DWZhY/K72FgVtVeD5zMwyU81ofOrpJsFrZ/NRacVl12Ga7P6Wi+z1gxQBMAB8qn7gxMF
 MGZX24RPDUVmCeFHHRw0v7CIulcCNJXm0ZOvQM81NsmXBYlLWVehQbkw+GEtYACkndeu
 z90KFDETK1ONoPCN8Dz3qR8+Ox/yhLVU0Mk09AlW+0G6hDHc+SqdIh6hheDkyIvm7Hx/
 n8OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7xfOhan9w2G4cFASSAhvcxCCdsR6uIhO4DH1JSe8zWsKhftwdGexz/QzpGik+jb1VvODtD3drDiRv@nongnu.org
X-Gm-Message-State: AOJu0YyHz6+aQOKtqSRc5SPf9jgsKvuvMJqKpS2fQtjqC9tc8XXixAhg
 zhCxqzW0yyjWoDJ71NCBeDI9yAuLeVpF5LfnvunjAzZLWrYA63D4U0PGLrI2
X-Google-Smtp-Source: AGHT+IEetzqNvkE+GUEXJWJx/B+wTesL5R+7CGHC48RBGYVFF6WseT7M49sYltPJM2bWg8nsOtxBnQ==
X-Received: by 2002:a05:6512:401e:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-5389fc634c5mr2056622e87.43.1727449704098; 
 Fri, 27 Sep 2024 08:08:24 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-192-199.telecable.es.
 [93.156.192.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dd2e97sm29525905e9.4.2024.09.27.08.08.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 08:08:23 -0700 (PDT)
From: =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
To: qemu-arm@nongnu.org
Cc: alistair@alistair23.me, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Rom=C3=A1n=20C=C3=A1rdenas=20Rodr=C3=ADguez?=
 <rcardenas.rod@gmail.com>
Subject: [PATCH 1/4] STM32F4: new RCC device
Date: Fri, 27 Sep 2024 17:07:36 +0200
Message-Id: <20240927150738.57786-1-rcardenas.rod@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=rcardenas.rod@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Generic RCC class for STM32 devices. It can be used for most of STM32 chips.
Note that it only implements enable and reset capabilities.

Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>
---
 hw/misc/Kconfig             |   3 +
 hw/misc/meson.build         |   1 +
 hw/misc/stm32_rcc.c         | 162 ++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events        |   6 ++
 include/hw/misc/stm32_rcc.h |  91 ++++++++++++++++++++
 5 files changed, 263 insertions(+)
 create mode 100644 hw/misc/stm32_rcc.c
 create mode 100644 include/hw/misc/stm32_rcc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b83..6bdc77cbe5 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -82,6 +82,9 @@ config IMX
     select SSI
     select USB_EHCI_SYSBUS
 
+config STM32_RCC
+    bool
+
 config STM32F2XX_SYSCFG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca8717be2..e3cc4c34e3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -106,6 +106,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
 system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
   'xlnx-versal-trng.c',
 ))
+system_ss.add(when: 'CONFIG_STM32_RCC', if_true: files('stm32_rcc.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
new file mode 100644
index 0000000000..26672b5b24
--- /dev/null
+++ b/hw/misc/stm32_rcc.c
@@ -0,0 +1,162 @@
+/*
+ * STM32 RCC (only reset and enable registers are implemented)
+ *
+ * Copyright (c) 2024 Román Cárdenas <rcardenas.rod@gmail.com>
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
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32_rcc.h"
+
+static void stm32_rcc_reset(DeviceState *dev)
+{
+    STM32RccState *s = STM32_RCC(dev);
+
+    for (int i = 0; i < STM32_RCC_NREGS; i++) {
+        s->regs[i] = 0;
+    }
+}
+
+static uint64_t stm32_rcc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    STM32RccState *s = STM32_RCC(opaque);
+
+    uint32_t value = 0;
+    if (addr > STM32_RCC_DCKCFGR2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+    } else {
+        value = s->regs[addr >> 2];
+    }
+    trace_stm32_rcc_read(addr, value);
+    return value;
+}
+
+static void stm32_rcc_write(void *opaque, hwaddr addr,
+                            uint64_t val64, unsigned int size)
+{
+    STM32RccState *s = STM32_RCC(opaque);
+    uint32_t value = val64;
+    uint32_t prev_value, new_value, irq_offset;
+
+    trace_stm32_rcc_write(value, addr);
+
+    if (addr > STM32_RCC_DCKCFGR2) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
+    switch (addr) {
+    case STM32_RCC_AHB1_RSTR...STM32_RCC_APB2_RSTR:
+        prev_value = s->regs[addr / 4];
+        s->regs[addr / 4] = value;
+
+        irq_offset = ((addr - STM32_RCC_AHB1_RSTR) / 4) * 32;
+        for (int i = 0; i < 32; i++) {
+            new_value = extract32(value, i, 1);
+            if (extract32(prev_value, i, 1) && !new_value) {
+                trace_stm32_rcc_pulse_reset(irq_offset + i, new_value);
+                qemu_set_irq(s->reset_irq[irq_offset + i], new_value);
+            }
+        }
+        return;
+    case STM32_RCC_AHB1_ENR...STM32_RCC_APB2_ENR:
+        prev_value = s->regs[addr / 4];
+        s->regs[addr / 4] = value;
+
+        irq_offset = ((addr - STM32_RCC_AHB1_ENR) / 4) * 32;
+        for (int i = 0; i < 32; i++) {
+            new_value = extract32(value, i, 1);
+            if (!extract32(prev_value, i, 1) && new_value) {
+                trace_stm32_rcc_pulse_enable(irq_offset + i, new_value);
+                qemu_set_irq(s->enable_irq[irq_offset + i], new_value);
+            }
+        }
+        return;
+    default:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: The RCC peripheral only supports enable and reset in QEMU\n",
+            __func__
+        );
+        s->regs[addr >> 2] = value;
+    }
+}
+
+static const MemoryRegionOps stm32_rcc_ops = {
+    .read = stm32_rcc_read,
+    .write = stm32_rcc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32_rcc_init(Object *obj)
+{
+    STM32RccState *s = STM32_RCC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32_rcc_ops, s,
+                          TYPE_STM32_RCC, STM32_RCC_PERIPHERAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_out(DEVICE(obj), s->reset_irq, STM32_RCC_NIRQS);
+    qdev_init_gpio_out(DEVICE(obj), s->enable_irq, STM32_RCC_NIRQS);
+
+    for (int i = 0; i < STM32_RCC_NIRQS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->reset_irq[i]);
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->enable_irq[i]);
+    }
+}
+
+static const VMStateDescription vmstate_stm32_rcc = {
+    .name = TYPE_STM32_RCC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, STM32RccState, STM32_RCC_NREGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32_rcc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_stm32_rcc;
+    device_class_set_legacy_reset(dc, stm32_rcc_reset);
+}
+
+static const TypeInfo stm32_rcc_info = {
+    .name          = TYPE_STM32_RCC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32RccState),
+    .instance_init = stm32_rcc_init,
+    .class_init    = stm32_rcc_class_init,
+};
+
+static void stm32_rcc_register_types(void)
+{
+    type_register_static(&stm32_rcc_info);
+}
+
+type_init(stm32_rcc_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1be0717c0c..b9fbcb0924 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -156,6 +156,12 @@ npcm7xx_pwm_write(const char *id, uint64_t offset, uint32_t value) "%s offset: 0
 npcm7xx_pwm_update_freq(const char *id, uint8_t index, uint32_t old_value, uint32_t new_value) "%s pwm[%u] Update Freq: old_freq: %u, new_freq: %u"
 npcm7xx_pwm_update_duty(const char *id, uint8_t index, uint32_t old_value, uint32_t new_value) "%s pwm[%u] Update Duty: old_duty: %u, new_duty: %u"
 
+# stm32_rcc.c
+stm32_rcc_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+stm32_rcc_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+stm32_rcc_pulse_enable(int line, int level) "Enable: %d to %d"
+stm32_rcc_pulse_reset(int line, int level) "Reset: %d to %d"
+
 # stm32f4xx_syscfg.c
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interrupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/include/hw/misc/stm32_rcc.h b/include/hw/misc/stm32_rcc.h
new file mode 100644
index 0000000000..ffbdf202ea
--- /dev/null
+++ b/include/hw/misc/stm32_rcc.h
@@ -0,0 +1,91 @@
+/*
+ * STM32 RCC (only reset and enable registers are implemented)
+ *
+ * Copyright (c) 2024 Román Cárdenas <rcardenas.rod@gmail.com>
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
+#ifndef HW_STM32_RCC_H
+#define HW_STM32_RCC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define STM32_RCC_CR 0x00
+#define STM32_RCC_PLL_CFGR 0x04
+#define STM32_RCC_CFGR 0x08
+#define STM32_RCC_CIR 0x0C
+#define STM32_RCC_AHB1_RSTR 0x10
+#define STM32_RCC_AHB2_RSTR 0x14
+#define STM32_RCC_AHB3_RSTR 0x18
+
+#define STM32_RCC_APB1_RSTR 0x20
+#define STM32_RCC_APB2_RSTR 0x24
+
+#define STM32_RCC_AHB1_ENR 0x30
+#define STM32_RCC_AHB2_ENR 0x34
+#define STM32_RCC_AHB3_ENR 0x38
+
+#define STM32_RCC_APB1_ENR 0x40
+#define STM32_RCC_APB2_ENR 0x44
+
+#define STM32_RCC_AHB1_LPENR 0x50
+#define STM32_RCC_AHB2_LPENR 0x54
+#define STM32_RCC_AHB3_LPENR 0x58
+
+#define STM32_RCC_APB1_LPENR 0x60
+#define STM32_RCC_APB2_LPENR 0x64
+
+#define STM32_RCC_BDCR 0x70
+#define STM32_RCC_CSR 0x74
+
+#define STM32_RCC_SSCGR 0x80
+#define STM32_RCC_PLLI2SCFGR 0x84
+#define STM32_RCC_PLLSAI_CFGR 0x88
+#define STM32_RCC_DCKCFGR 0x8C
+#define STM32_RCC_CKGATENR 0x90
+#define STM32_RCC_DCKCFGR2 0x94
+
+#define STM32_RCC_NREGS ((STM32_RCC_DCKCFGR2 >> 2) + 1)
+#define STM32_RCC_PERIPHERAL_SIZE 0x400
+#define STM32_RCC_NIRQS (32 * 5) /* 32 bits per reg, 5 en/rst regs */
+
+#define STM32_RCC_GPIO_IRQ_OFFSET 0
+
+#define TYPE_STM32_RCC "stm32.rcc"
+
+typedef struct STM32RccState STM32RccState;
+
+DECLARE_INSTANCE_CHECKER(STM32RccState, STM32_RCC, TYPE_STM32_RCC)
+
+#define NUM_GPIO_EVENT_IN_LINES 16
+
+struct STM32RccState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t regs[STM32_RCC_NREGS];
+
+    qemu_irq enable_irq[STM32_RCC_NIRQS];
+    qemu_irq reset_irq[STM32_RCC_NIRQS];
+};
+
+#endif /* HW_STM32_RCC_H */
-- 
2.39.3 (Apple Git-146)


