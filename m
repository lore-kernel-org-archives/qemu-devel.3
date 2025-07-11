Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270BFC83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuf-0005aF-Ud; Fri, 11 Jul 2025 09:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtg-0004Mu-7U
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtd-0002xH-Hz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so16213885e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240876; x=1752845676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wK0R7sFv53iD9d97HEP4+jyy3hoUoi+aPZFmxHOWO04=;
 b=YRJRIjjmKu7Nk/uh3+5+qUvIAF2Le1fSImKnd8dXnOk0tZTQ0tBKimfhewRep1ziQL
 eYUg6AK0dwVcx9PW6F9fX9uZRX3ferRzCjOpgcMf3G/C4ieU7wyh4dhV3xUedWBCOmYy
 TN7akYpU2jRKHYl7F3ZtttCblN1gzCa9skspBjQge4tM16QnGtAFCi7ihjixRtUgDXkO
 3S65dryY6E6azpvNE2nnK0TSgrleh9iCd18kdhn9laO7huAs4SPuvbKrHP8nRhxHunZc
 PmLc8Ziv43RuteF0x1KVtNaTZ+c56bOqXlPysPFEK+1MowRnZnLJtVy7QTcN6MDPZW1U
 BjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240876; x=1752845676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wK0R7sFv53iD9d97HEP4+jyy3hoUoi+aPZFmxHOWO04=;
 b=bOBVNEYv7QVf2g3wFAJRIt1YFxNb0POSsfvH73VyjWAZAbGN+u1snI0VroFUDFRCAL
 F1pwnIeYF+0FUVdet3783u3Gj8tK5O9p72hVM96HKEicqERarrOXeWKXUYRLqWJYUtgY
 W5j1Qc8MGbu0gIBcuYeeTLINPkkzTIl/OLiM4rc/CTdxc7MW+mcdViuKgtlZD25Q/r8G
 zihdPYCOL9U3W93RtdRnvlWFmg3x5Py/gTstFKLC+kcG6sOeXuw1PoA8Wiv26eSspttL
 CQ6kJpmvmIr4HCk7rGlU74Q0wlYz9UHn4JRDddyXEuSUenGpOsmfJFbdUa9FNU5oqQEt
 91VA==
X-Gm-Message-State: AOJu0YxcgagCZrajiYo4WHWC264FDoIvSLE5qpFvmbNFL56BQehcJA3c
 Aga8dMtOYM8WqZDVrrXvm2VmJc/5X9160vi/OksGy/DrnmZ+KFr4Ee/F82V2Lh5ZofzBIG+y3AS
 TuaUQ
X-Gm-Gg: ASbGncuB0+NmCXTW6oUX45SwwphPhZUNm5350+XKL/MhfWLn/Jl6v5B9rlPtstT2o+B
 p+5Olpl9NzXLLDvnsxYkbvyAo+LJXeIvCPIPcK/pwWjpyJUzquH7m4GIo8DarWoslQC3/iCvnR6
 Mo8AOpCoTbZpxzmfoAxTpY+Hh2oo1j8rhG426waGfpt8PWH19t+nHBFnscDSZNYfYW7+TQ60F10
 7nmxjfIIDu49mmXy9gv4fk9zpU3zjbXXqSjcGEuzr6JBsDvN6/BiN18teEDwfTI0rIKTY2qOIRy
 PHs9BOcMXQ7d464q+S9Xiv/NwFt1RNEHAvWYI71uJ5zY6+n3VeV2OngeKXyxQkRGbjKpJtXgOBF
 uLn3xZBqljDkmE6L9dcrRFeub2jdg
X-Google-Smtp-Source: AGHT+IEwq7yAfVMaXpTHS2+i57yjJLJdPMgTl2peEw7NYc+mqwcxOhqHj/knU5xTTvXHtC/nprAs6w==
X-Received: by 2002:a05:600c:8483:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-455bd879b86mr20466615e9.21.1752240875802; 
 Fri, 11 Jul 2025 06:34:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] MAX78000: UART Implementation
Date: Fri, 11 Jul 2025 14:33:57 +0100
Message-ID: <20250711133429.1423030-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit implements UART support for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704223239.248781-5-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/max78000_uart.h |  78 +++++++++
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   1 +
 hw/char/Kconfig                 |   3 +
 hw/char/meson.build             |   1 +
 5 files changed, 368 insertions(+)
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 hw/char/max78000_uart.c

diff --git a/include/hw/char/max78000_uart.h b/include/hw/char/max78000_uart.h
new file mode 100644
index 00000000000..cf90d51dbfa
--- /dev/null
+++ b/include/hw/char/max78000_uart.h
@@ -0,0 +1,78 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_UART_H
+#define HW_MAX78000_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "qemu/fifo8.h"
+#include "qom/object.h"
+
+#define UART_CTRL       0x0
+#define UART_STATUS     0x4
+#define UART_INT_EN     0x8
+#define UART_INT_FL     0xc
+#define UART_CLKDIV     0x10
+#define UART_OSR        0x14
+#define UART_TXPEEK     0x18
+#define UART_PNR        0x1c
+#define UART_FIFO       0x20
+#define UART_DMA        0x30
+#define UART_WKEN       0x34
+#define UART_WKFL       0x38
+
+/* CTRL */
+#define UART_CTF_DIS    (1 << 7)
+#define UART_FLUSH_TX   (1 << 8)
+#define UART_FLUSH_RX   (1 << 9)
+#define UART_BCLKEN     (1 << 15)
+#define UART_BCLKRDY    (1 << 19)
+
+/* STATUS */
+#define UART_RX_LVL     8
+#define UART_TX_EM      (1 << 6)
+#define UART_RX_FULL    (1 << 5)
+#define UART_RX_EM      (1 << 4)
+
+/* PNR (Pin Control Register) */
+#define UART_CTS        1
+#define UART_RTS        (1 << 1)
+
+/* INT_EN / INT_FL */
+#define UART_RX_THD     (1 << 4)
+#define UART_TX_HE      (1 << 6)
+
+#define UART_RXBUFLEN   0x100
+#define TYPE_MAX78000_UART "max78000-uart"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000UartState, MAX78000_UART)
+
+struct Max78000UartState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t int_en;
+    uint32_t int_fl;
+    uint32_t clkdiv;
+    uint32_t osr;
+    uint32_t txpeek;
+    uint32_t pnr;
+    uint32_t fifo;
+    uint32_t dma;
+    uint32_t wken;
+    uint32_t wkfl;
+
+    Fifo8 rx_fifo;
+
+    CharBackend chr;
+    qemu_irq irq;
+};
+#endif /* HW_STM32F2XX_USART_H */
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
new file mode 100644
index 00000000000..19506d52ef9
--- /dev/null
+++ b/hw/char/max78000_uart.c
@@ -0,0 +1,285 @@
+/*
+ * MAX78000 UART
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/max78000_uart.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+
+static int max78000_uart_can_receive(void *opaque)
+{
+    Max78000UartState *s = opaque;
+    if (!(s->ctrl & UART_BCLKEN)) {
+        return 0;
+    }
+    return fifo8_num_free(&s->rx_fifo);
+}
+
+static void max78000_update_irq(Max78000UartState *s)
+{
+    int interrupt_level;
+
+    interrupt_level = s->int_fl & s->int_en;
+    qemu_set_irq(s->irq, interrupt_level);
+}
+
+static void max78000_uart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    Max78000UartState *s = opaque;
+
+    assert(size <= fifo8_num_free(&s->rx_fifo));
+
+    fifo8_push_all(&s->rx_fifo, buf, size);
+
+    uint32_t rx_threshold = s->ctrl & 0xf;
+
+    if (fifo8_num_used(&s->rx_fifo) >= rx_threshold) {
+        s->int_fl |= UART_RX_THD;
+    }
+
+    max78000_update_irq(s);
+}
+
+static void max78000_uart_reset_hold(Object *obj, ResetType type)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+
+    s->ctrl = 0;
+    s->status = UART_TX_EM | UART_RX_EM;
+    s->int_en = 0;
+    s->int_fl = 0;
+    s->osr = 0;
+    s->txpeek = 0;
+    s->pnr = UART_RTS;
+    s->fifo = 0;
+    s->dma = 0;
+    s->wken = 0;
+    s->wkfl = 0;
+    fifo8_reset(&s->rx_fifo);
+}
+
+static uint64_t max78000_uart_read(void *opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    Max78000UartState *s = opaque;
+    uint64_t retvalue = 0;
+    switch (addr) {
+    case UART_CTRL:
+        retvalue = s->ctrl;
+        break;
+    case UART_STATUS:
+        retvalue = (fifo8_num_used(&s->rx_fifo) << UART_RX_LVL) |
+                    UART_TX_EM |
+                    (fifo8_is_empty(&s->rx_fifo) ? UART_RX_EM : 0);
+        break;
+    case UART_INT_EN:
+        retvalue = s->int_en;
+        break;
+    case UART_INT_FL:
+        retvalue = s->int_fl;
+        break;
+    case UART_CLKDIV:
+        retvalue = s->clkdiv;
+        break;
+    case UART_OSR:
+        retvalue = s->osr;
+        break;
+    case UART_TXPEEK:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_peek(&s->rx_fifo);
+        }
+        break;
+    case UART_PNR:
+        retvalue = s->pnr;
+        break;
+    case UART_FIFO:
+        if (!fifo8_is_empty(&s->rx_fifo)) {
+            retvalue = fifo8_pop(&s->rx_fifo);
+            max78000_update_irq(s);
+        }
+        break;
+    case UART_DMA:
+        /* DMA not implemented */
+        retvalue = s->dma;
+        break;
+    case UART_WKEN:
+        retvalue = s->wken;
+        break;
+    case UART_WKFL:
+        retvalue = s->wkfl;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        break;
+    }
+
+    return retvalue;
+}
+
+static void max78000_uart_write(void *opaque, hwaddr addr,
+                                  uint64_t val64, unsigned int size)
+{
+    Max78000UartState *s = opaque;
+
+    uint32_t value = val64;
+    uint8_t data;
+
+    switch (addr) {
+    case UART_CTRL:
+        if (value & UART_FLUSH_RX) {
+            fifo8_reset(&s->rx_fifo);
+        }
+        if (value & UART_BCLKEN) {
+            value = value | UART_BCLKRDY;
+        }
+        s->ctrl = value & ~(UART_FLUSH_RX | UART_FLUSH_TX);
+
+        /*
+         * Software can manage UART flow control manually by setting hfc_en
+         * in UART_CTRL. This would require emulating uart at a lower level,
+         * and is currently unimplemented.
+         */
+
+        return;
+    case UART_STATUS:
+        /* UART_STATUS is read only */
+        return;
+    case UART_INT_EN:
+        s->int_en = value;
+        return;
+    case UART_INT_FL:
+        s->int_fl = s->int_fl & ~(value);
+        max78000_update_irq(s);
+        return;
+    case UART_CLKDIV:
+        s->clkdiv = value;
+        return;
+    case UART_OSR:
+        s->osr = value;
+        return;
+    case UART_PNR:
+        s->pnr = value;
+        return;
+    case UART_FIFO:
+        data = value & 0xff;
+        /*
+         * XXX this blocks entire thread. Rewrite to use
+         * qemu_chr_fe_write and background I/O callbacks
+         */
+        qemu_chr_fe_write_all(&s->chr, &data, 1);
+
+        /* TX is always empty */
+        s->int_fl |= UART_TX_HE;
+        max78000_update_irq(s);
+
+        return;
+    case UART_DMA:
+        /* DMA not implemented */
+        s->dma = value;
+        return;
+    case UART_WKEN:
+        s->wken = value;
+        return;
+    case UART_WKFL:
+        s->wkfl = value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps max78000_uart_ops = {
+    .read = max78000_uart_read,
+    .write = max78000_uart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const Property max78000_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Max78000UartState, chr),
+};
+
+static const VMStateDescription max78000_uart_vmstate = {
+    .name = TYPE_MAX78000_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000UartState),
+        VMSTATE_UINT32(status, Max78000UartState),
+        VMSTATE_UINT32(int_en, Max78000UartState),
+        VMSTATE_UINT32(int_fl, Max78000UartState),
+        VMSTATE_UINT32(clkdiv, Max78000UartState),
+        VMSTATE_UINT32(osr, Max78000UartState),
+        VMSTATE_UINT32(txpeek, Max78000UartState),
+        VMSTATE_UINT32(pnr, Max78000UartState),
+        VMSTATE_UINT32(fifo, Max78000UartState),
+        VMSTATE_UINT32(dma, Max78000UartState),
+        VMSTATE_UINT32(wken, Max78000UartState),
+        VMSTATE_UINT32(wkfl, Max78000UartState),
+        VMSTATE_FIFO8(rx_fifo, Max78000UartState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_uart_init(Object *obj)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+    fifo8_create(&s->rx_fifo, 8);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_uart_ops, s,
+                          TYPE_MAX78000_UART, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void max78000_uart_realize(DeviceState *dev, Error **errp)
+{
+    Max78000UartState *s = MAX78000_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, max78000_uart_can_receive,
+                             max78000_uart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static void max78000_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_uart_reset_hold;
+
+    device_class_set_props(dc, max78000_uart_properties);
+    dc->realize = max78000_uart_realize;
+
+    dc->vmsd = &max78000_uart_vmstate;
+}
+
+static const TypeInfo max78000_uart_info = {
+    .name          = TYPE_MAX78000_UART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000UartState),
+    .instance_init = max78000_uart_init,
+    .class_init    = max78000_uart_class_init,
+};
+
+static void max78000_uart_register_types(void)
+{
+    type_register_static(&max78000_uart_info);
+}
+
+type_init(max78000_uart_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 035568a085e..7e3610dca8f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -367,6 +367,7 @@ config MAX78000_SOC
     bool
     select ARM_V7M
     select MAX78000_ICC
+    select MAX78000_UART
 
 config RASPI
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 9d517f3e287..020c0a84bb6 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -48,6 +48,9 @@ config VIRTIO_SERIAL
     default y
     depends on VIRTIO
 
+config MAX78000_UART
+    bool
+
 config STM32F2XX_USART
     bool
 
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 4e439da8b9e..a9e1dc26c0f 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -26,6 +26,7 @@ system_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
 system_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
+system_ss.add(when: 'CONFIG_MAX78000_UART', if_true: files('max78000_uart.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
-- 
2.43.0


