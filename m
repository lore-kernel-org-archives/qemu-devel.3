Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF3AC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tE-00055I-EH; Wed, 12 Aug 2026 08:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tB-0004s2-L1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t8-00008f-Uf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49978908b35so6612545e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537013; x=1787141813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vLzCtO/q0xkPG+tEhvDl6lmMcAmm/+QbfRTYtGckE5A=;
 b=QbuOM7lDuU7Q8WwL2tmr2E6EklstOgYVHT85Y1ho8DdqlyzUjTJzQVsKvAt/2U8pKI
 nyTTXyh2VwboggYKuI44+mpts2ScfQEDvXsCZIO7ESvHb7vV8j5hRCmOLSsgJJ005rfc
 /bB873dDhH+JOoAMOqdimZj/h+hyU6sgCaXdu5c5Z687/yQaZdPJ+Jnv21HptpN6Ryyo
 EP5LXUr8ZsVKGrqOPvWATdFqd9O41UyQWLzLMOTB6oI4cajz4Oo6WU/aUSBcfjMHNZNL
 ArUDiJ3RXUF2wx6PMC1GIEfKMh6wnEByRxnkZgcUlwnc7ojeE0D3OJ6suSNumg08iTlO
 ytdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537013; x=1787141813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vLzCtO/q0xkPG+tEhvDl6lmMcAmm/+QbfRTYtGckE5A=;
 b=h4fIj3AW5o3T+tHJdkj78K17p5TKhYaV2sUMJ72GZJkuukKlgsFjbp2HfeJLEROotO
 IlDoxPsPcP7fsUoDjJvWe1YoHo2SikC6QbMJuiODhHVPGTfYstHzoG8h1zXICjR4rLYU
 zMP/pJcFVdJZ6mfi4qKUNgm/Ues3bBv6qdHO4EWV7iGVxCFYtdXkS0wOIqQ4GaHoRYL4
 mkuw74XAko5f3Gqlz/PPJaANDmO2CCSjGd2Q8H5XX28WeX7Nx2SYmzDDYG+X0RIFQ2f9
 AD5X7r6J0sih/93voF4DngG1c7boxtkoKgj3ibrZINzwL9EwRe60AHieNYwzLOAGcqul
 EKyA==
X-Gm-Message-State: AOJu0YwkdsgiqU5SVmkqxsEj7R03CcMwqPkL+HrLJksbxUh6xKMApEPx
 t2aHz4v2mCZXhNtMbz60V/rFTtXOL2ZfGBoNP3b5r51xDhjxpojSTg7p48YC1xWewayCB4ji00V
 Qfuh3
X-Gm-Gg: AR+sD11NLt2QSqkCQ30nwgTOmgTiaGEQMb/Sr2y20A+KXCCDn6l5Og9WY+pjbeDNPHE
 bns55tldP9fYVyBZyU7gekDhzI/E1E05gpOLTtgD/k1KGJ+88xn6eAXeneWwhy1BEq0Rx02ltMn
 A2xMa7RWa4Z6tazxrmQdQC4barvPVzEaDBuQaMuTzoucIAqPBZJlwIkf9KAw3vRiOgWFajkTnl3
 EP46O0LcjJX+aMSuO9NTSnb1+o39P6MpnRNHRKNFmhsjToZC2N8C1++nEpUqUrc1HxkjhNnpD+w
 drbCxG99Cwto3Fj3HukhnQh5YWhGSRYbJaJwih9rWW7V1Y7k7WJZlQT8/N4FWYXiqhIkygUoDTT
 P0rDml0wnoPsXhKhw6ztlIBVWY3uSSh7YsDfS9G7FaYAC84SmBc/k7Uajmvcmtped84ChRGjXKs
 dhwz/dAANjD9xs9+8TRZrpyttpKhLnL149poHx4R/Gw//C9cSB4mcjH3i2T7A/N2Vn9MANA/b6r
 3OMdRoalPKWjQj6pT4AjlxgJlKc+NozmQ7gZSwulzKe4h41+0kQYeoQwgOmLKOvyg+NXA==
X-Received: by 2002:a7b:c7ca:0:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-4997c13c8ccmr46608175e9.15.1786537013338; 
 Wed, 12 Aug 2026 05:16:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/26] hw/gpio: Add Cadence GPIO controller
Date: Wed, 12 Aug 2026 13:16:13 +0100
Message-ID: <20260812121622.649730-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

This patch add a new model for Cadence GPIO controller which
supports 32 pins and interrupts for level-triggered/edge-triggered type on
input pins.

Also define new trace functions for analysis purpose and new configuration to
enable this model.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Message-id: 20260713073033.3883619-8-kchiu@axiado.com
[PMM: drop unnecessary <private> and <public> marker comments]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/Kconfig                |   3 +
 hw/gpio/cadence_gpio.c         | 292 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 hw/gpio/trace-events           |   5 +
 include/hw/gpio/cadence_gpio.h |  53 ++++++
 5 files changed, 354 insertions(+)
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 include/hw/gpio/cadence_gpio.h

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20..fcc7c70bd5 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -30,3 +30,6 @@ config PCF8574
 
 config ZAURUS_SCOOP
     bool
+
+config CADENCE_GPIO
+    bool
diff --git a/hw/gpio/cadence_gpio.c b/hw/gpio/cadence_gpio.c
new file mode 100644
index 0000000000..ce8256b381
--- /dev/null
+++ b/hw/gpio/cadence_gpio.c
@@ -0,0 +1,292 @@
+/*
+ * Cadence GPIO emulation.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/cadence_gpio.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "trace.h"
+
+static void cdns_gpio_update_irq(CadenceGPIOState *s)
+{
+    qemu_set_irq(s->irq, s->isr ? 1 : 0);
+}
+
+static void cdns_gpio_update_isr_with_inpvr(CadenceGPIOState *s, uint32_t new)
+{
+    uint32_t new_isr = 0;
+    uint32_t any_edges, rising_edges, falling_edges, deassert_mask;
+
+    /*
+     * If ITR is set, this is level triggered:
+     * set corresponding ISR bits when IVR matches new inpvr value.
+     */
+    new_isr |= s->itr & ~(s->ivr ^ new);
+
+    /*
+     * If ITR is not set, this is edge-triggered:
+     * If IOAR bit is set, trigger on any edge;
+     * otherwise trigger on rising edge if IVR is set,
+     * trigger on falling edge if IVR bit is 0.
+     */
+    any_edges = s->ioar & (s->inpvr ^ new);
+    rising_edges = s->ivr & ~s->inpvr & new;
+    falling_edges = ~s->ivr & s->inpvr & ~new;
+    new_isr |= ~s->itr & (any_edges | rising_edges | falling_edges);
+
+    /*
+     * In bypass mode or if this isn't an input pin, the corresponding ISR
+     * bit is forced to zero.
+     */
+    deassert_mask = s->bmr | ~s->dmr | s->imr;
+
+    new_isr &= ~deassert_mask;
+    s->isr = new_isr;
+
+    cdns_gpio_update_irq(s);
+}
+
+static void cdns_gpio_update_isr(CadenceGPIOState *s)
+{
+    cdns_gpio_update_isr_with_inpvr(s, s->inpvr);
+}
+
+static void cdns_gpio_set(void *opaque, int line, int level)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+    uint32_t new_inpvr = deposit32(s->inpvr, line, 1, level ? 1 : 0);
+
+    trace_cdns_gpio_set(DEVICE(s)->canonical_path, line, level);
+
+    cdns_gpio_update_isr_with_inpvr(s, new_inpvr);
+
+    /* Sync INPVR with new value */
+    s->inpvr = new_inpvr;
+}
+
+static inline void cdns_gpio_update_output_irq(CadenceGPIOState *s)
+{
+    uint32_t is_output = ~s->bmr & ~s->dmr & s->oer;
+
+    for (int i = 0; i < CDNS_GPIO_NUM; i++) {
+        if (extract32(is_output, i, 1)) {
+            /* Forward the output value to corresponding irq */
+            qemu_set_irq(s->output[i], extract32(s->ovr, i, 1));
+        }
+    }
+}
+
+static uint64_t cdns_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+    uint32_t reg_value = 0x0;
+
+    switch (offset) {
+    case CDNS_GPIO_BYPASS_MODE:
+        reg_value = s->bmr;
+        break;
+
+    case CDNS_GPIO_DIRECTION_MODE:
+        reg_value = s->dmr;
+        break;
+
+    case CDNS_GPIO_OUTPUT_EN:
+        reg_value = s->oer;
+        break;
+
+    case CDNS_GPIO_OUTPUT_VALUE:
+        reg_value = s->ovr;
+        break;
+
+    case CDNS_GPIO_INPUT_VALUE:
+        reg_value = s->inpvr;
+        break;
+
+    case CDNS_GPIO_IRQ_MASK:
+        reg_value = s->imr;
+        break;
+
+    case CDNS_GPIO_IRQ_STATUS:
+        reg_value = s->isr;
+        break;
+
+    case CDNS_GPIO_IRQ_TYPE:
+        reg_value = s->itr;
+        break;
+
+    case CDNS_GPIO_IRQ_VALUE:
+        reg_value = s->ivr;
+        break;
+
+    case CDNS_GPIO_IRQ_ANY_EDGE:
+        reg_value = s->ioar;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_CADENCE_GPIO, __func__, offset);
+        break;
+    }
+
+    trace_cdns_gpio_read(DEVICE(s)->canonical_path, offset, reg_value);
+
+    return reg_value;
+}
+
+static void cdns_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                            unsigned size)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(opaque);
+
+    trace_cdns_gpio_write(DEVICE(s)->canonical_path, offset, value);
+
+    switch (offset) {
+    case CDNS_GPIO_BYPASS_MODE:
+        s->bmr = value;
+        cdns_gpio_update_output_irq(s);
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_DIRECTION_MODE:
+        s->dmr = value;
+        cdns_gpio_update_output_irq(s);
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_OUTPUT_EN:
+        s->oer = value;
+        cdns_gpio_update_output_irq(s);
+        break;
+
+    case CDNS_GPIO_OUTPUT_VALUE:
+        s->ovr = value;
+        cdns_gpio_update_output_irq(s);
+        break;
+
+    case CDNS_GPIO_IRQ_EN:
+        s->imr &= ~value;
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_IRQ_DIS:
+        s->imr |= value;
+        cdns_gpio_update_isr(s);
+        break;
+
+    case CDNS_GPIO_IRQ_TYPE:
+        s->itr = value;
+        break;
+
+    case CDNS_GPIO_IRQ_VALUE:
+        s->ivr = value;
+        break;
+
+    case CDNS_GPIO_IRQ_ANY_EDGE:
+        s->ioar = value;
+        break;
+
+    case CDNS_GPIO_INPUT_VALUE:
+    case CDNS_GPIO_IRQ_MASK:
+    case CDNS_GPIO_IRQ_STATUS:
+        /* Read-Only */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
+                      HWADDR_PRIx "\n", TYPE_CADENCE_GPIO, __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps cdns_gpio_ops = {
+    .read = cdns_gpio_read,
+    .write = cdns_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static const VMStateDescription vmstate_cdns_gpio = {
+    .name = TYPE_CADENCE_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(bmr, CadenceGPIOState),
+        VMSTATE_UINT32(dmr, CadenceGPIOState),
+        VMSTATE_UINT32(oer, CadenceGPIOState),
+        VMSTATE_UINT32(ovr, CadenceGPIOState),
+        VMSTATE_UINT32(inpvr, CadenceGPIOState),
+        VMSTATE_UINT32(imr, CadenceGPIOState),
+        VMSTATE_UINT32(isr, CadenceGPIOState),
+        VMSTATE_UINT32(itr, CadenceGPIOState),
+        VMSTATE_UINT32(ivr, CadenceGPIOState),
+        VMSTATE_UINT32(ioar, CadenceGPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void cdns_gpio_reset(DeviceState *dev)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(dev);
+
+    s->bmr      = 0;
+    s->dmr      = 0;
+    s->oer      = 0;
+    s->ovr      = 0;
+    s->inpvr    = 0;
+    s->imr      = 0xffffffff;
+    s->isr      = 0;
+    s->itr      = 0;
+    s->ivr      = 0;
+    s->ioar     = 0;
+}
+
+static void cdns_gpio_init(Object *obj)
+{
+    CadenceGPIOState *s = CADENCE_GPIO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cdns_gpio_ops, s,
+                          TYPE_CADENCE_GPIO, CDNS_GPIO_REG_SIZE);
+
+    qdev_init_gpio_in(DEVICE(s), cdns_gpio_set, CDNS_GPIO_NUM);
+    qdev_init_gpio_out(DEVICE(s), s->output, CDNS_GPIO_NUM);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void cdns_gpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, cdns_gpio_reset);
+    dc->vmsd = &vmstate_cdns_gpio;
+    dc->desc = "Cadence GPIO controller";
+}
+
+static const TypeInfo cdns_gpio_info = {
+    .name = TYPE_CADENCE_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CadenceGPIOState),
+    .instance_init = cdns_gpio_init,
+    .class_init = cdns_gpio_class_init,
+};
+
+static void cdns_gpio_register_types(void)
+{
+    type_register_static(&cdns_gpio_info);
+}
+
+type_init(cdns_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6a67ee958f..0555f44b6a 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_CADENCE_GPIO', if_true: files('cadence_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index cea896b28f..80ca783a03 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -46,3 +46,8 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%s addr: 0x%" PRIx64 " "
 stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_idr) "GPIO%s from: 0x%x to: 0x%x"
 stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
+
+# cadence_gpio.c
+cdns_gpio_read(const char *path, uint64_t offset, uint32_t value) "%s:reg[0x%04" PRIx64 "] -> 0x%" PRIx32
+cdns_gpio_write(const char *path, uint64_t offset, uint64_t value) "%s:reg[0x%04" PRIx64 "] <- 0x%04" PRIx64
+cdns_gpio_set(const char *path, int line, int level) "%s:[%d] <- %d"
diff --git a/include/hw/gpio/cadence_gpio.h b/include/hw/gpio/cadence_gpio.h
new file mode 100644
index 0000000000..69646ba639
--- /dev/null
+++ b/include/hw/gpio/cadence_gpio.h
@@ -0,0 +1,53 @@
+/*
+ * Cadence GPIO registers definition.
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CADENCE_GPIO_H
+#define CADENCE_GPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_CADENCE_GPIO "cadence_gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(CadenceGPIOState, CADENCE_GPIO)
+
+#define CDNS_GPIO_REG_SIZE      0x400
+#define CDNS_GPIO_NUM           32
+
+#define CDNS_GPIO_BYPASS_MODE           0x00
+#define CDNS_GPIO_DIRECTION_MODE        0x04
+#define CDNS_GPIO_OUTPUT_EN             0x08
+#define CDNS_GPIO_OUTPUT_VALUE          0x0c
+#define CDNS_GPIO_INPUT_VALUE           0x10
+#define CDNS_GPIO_IRQ_MASK              0x14
+#define CDNS_GPIO_IRQ_EN                0x18
+#define CDNS_GPIO_IRQ_DIS               0x1c
+#define CDNS_GPIO_IRQ_STATUS            0x20
+#define CDNS_GPIO_IRQ_TYPE              0x24
+#define CDNS_GPIO_IRQ_VALUE             0x28
+#define CDNS_GPIO_IRQ_ANY_EDGE          0x2c
+
+struct CadenceGPIOState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t bmr;
+    uint32_t dmr;
+    uint32_t oer;
+    uint32_t ovr;
+    uint32_t inpvr;
+    uint32_t imr;
+    uint32_t isr;
+    uint32_t itr;
+    uint32_t ivr;
+    uint32_t ioar;
+    qemu_irq irq;
+    qemu_irq output[CDNS_GPIO_NUM];
+};
+
+#endif /* CADENCE_GPIO_H */
-- 
2.43.0


