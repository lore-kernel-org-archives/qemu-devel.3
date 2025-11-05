Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2E4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGibQ-000486-8Z; Wed, 05 Nov 2025 13:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib5-0003zb-DZ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib1-0003CR-Ew
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso739165e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762368662; x=1762973462;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coXM3aabJBT21GBiTqQtXzlDQRzt3k5zaMleXYUcg/A=;
 b=28JqkVzo6laD33qWHbvEnGvgE56xMTqkfNUKSEE5+9OFfcvWvEow41wYI7RY2l7+yH
 qCdrIWB+nGrpXcVwe6lFNb4+jTHM6hjc5JfMzxNKAS190qTL6dwvFsX5qMoSuJ6RTcu9
 zOhsmjgm/hR1Y62bnC2oT+Ckgu0geBWYUZSXWdg6448X71eeZ2sHFsChFossxK38a22/
 uNFWC5niqa9Glh+z29V7lFgZ1mrwJDGvLLP/oT7sYY2IiSmoyhoLbfiPWNJgVgIeVyVI
 mvUTAWP66GGlVUPvgR/hVX8uXOeL0Nwb/QC40LMIUELgHumOf3/QPDQGNGMaWu5eJmk7
 BAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762368662; x=1762973462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coXM3aabJBT21GBiTqQtXzlDQRzt3k5zaMleXYUcg/A=;
 b=nOXfoyT8baqT+qejKrVuwBrSBgsJXXnO9db0JvbZBWN9zlTuffTJZTH6U/XadBzKOf
 DULb6w1VlYd3oUhgnyZVeGeQik8jQ0QbOA1+vOoGVd1zhPwR76pkDMicUFZodp4Jn7Un
 veQ0s7TnZ/wqI0v0YGyEJXWGwr4JrAPHrfglIHtFJLmAtVnIMx1TVOO5JAwHHCHf2tqe
 lp7yPfDkS5WRdZrQ63Kp49KJpX5hnH/qD46oLVlHAoliZq+pTUB9YaJbkk2JBV7dUR6K
 EW1O0rqq5tfvscx3Z++n8Hpn+fkieidfBLEizi0qzLiZmkPXt3Vr6jhOdotGApQtXs7d
 HpXg==
X-Gm-Message-State: AOJu0YznatakrNaT89TYIl7NRnf5IWWnyUMIuCQrp1ZcjtJeg3d8pqtt
 ly5CxetOkApKEbMZvGkoc6UR6dxidwTtb+VEBcLqVPJRzmHKrSJTIrvVoBFPjqLqsiJmjJZuwUt
 0+cehiC8=
X-Gm-Gg: ASbGncsMP04kVYFPwXr2Q+qe+lbr0ARBkJUHZ4YTsUCHqFC7XKpKBFeW8+EzZR6VBZy
 5Y9QjtIQqjvatbZg2fg7QHPCjgrX8bRPr4OLyi3Ww8wqV3TPFjgLw2UKVIr8me2daWNUqodqhsU
 cqDCyuPWz/jzYtepFCGtOljngkW5X7TG6yie6TlHIB2hUD5+4e5e7VJL4QV85LYOYA1oJY0jsgF
 aStDgtVdj4DFTgtiYxyYTnm4CCvtQ6zuEo+iKCWI+r+Q59je+pdsKSo+zjDQsVlRNHGr+xWCj4q
 A+t8kgPhI/VPcBVgsrTHxjkc+N949RJ/lYSQ0zC11aCTPIbOjJhnIUuRlMt9LVel/b1govHdk/U
 NdMuiz2VXkprE5yUQF4lol8ZIZn4be1mQ5/IunG9LJJB2cJUe1R0IsJpM6VZ9Yc/nptpYfU1Qji
 LFEjf/
X-Google-Smtp-Source: AGHT+IGUpsQef6CswpzqnC03cj5TO5S5MaTiNXw8E+nSB9nEM787Ddm0M2MFcpG5ecy8AZ+G/ilOmw==
X-Received: by 2002:a05:600c:1e1d:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4775cdf54e7mr39292695e9.22.1762368661666; 
 Wed, 05 Nov 2025 10:51:01 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a354sm270622f8f.20.2025.11.05.10.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:51:01 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v3 3/5] hw/char: add NEORV32 UART (CTRL/DATA, fifo, chardev)
Date: Wed,  5 Nov 2025 20:50:54 +0200
Message-ID: <20251105185056.23565-4-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105185056.23565-1-michael@videogpu.com>
References: <20251105185056.23565-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32d;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

From: Michael <michael@videogpu.com>

Add NEORV32 UART device: CTRL/DATA registers, RX FIFO, TX to chardev.
Includes Kconfig/meson and public header.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 hw/char/Kconfig                |   3 +
 hw/char/meson.build            |   1 +
 hw/char/neorv32_uart.c         | 285 +++++++++++++++++++++++++++++++++
 include/hw/char/neorv32_uart.h |  54 +++++++
 4 files changed, 343 insertions(+)
 create mode 100644 hw/char/neorv32_uart.c
 create mode 100644 include/hw/char/neorv32_uart.h

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..1fd39c2b30 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config NEORV32_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index a9e1dc26c0..2f5bf827a7 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -31,6 +31,7 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 system_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
+system_ss.add(when: 'CONFIG_NEORV32_UART', if_true: files('neorv32_uart.c'))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
diff --git a/hw/char/neorv32_uart.c b/hw/char/neorv32_uart.c
new file mode 100644
index 0000000000..a21066d194
--- /dev/null
+++ b/hw/char/neorv32_uart.c
@@ -0,0 +1,285 @@
+/*
+ * Neorv32-specific UART.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/irq.h"
+#include "hw/char/neorv32_uart.h"
+#include "hw/qdev-properties-system.h"
+
+#define NEORV32_UART_IO_REGION_SIZE  (32)
+
+static Property neorv32_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", Neorv32UARTState, chr),
+};
+
+enum {
+    NEORV32_UART_CTRL = 0,  /**< offset 0: control register */
+    NEORV32_UART_DATA = 4  /**< offset 4: data register  */
+};
+
+/** UART control register bits */
+enum NEORV32_UART_CTRL_enum {
+    UART_CTRL_EN            = 0,  /* enable */
+    UART_CTRL_SIM_MODE      = 1,  /* sim override */
+    UART_CTRL_HWFC_EN       = 2,  /* RTS/CTS */
+    UART_CTRL_PRSC_LSB      = 3,  /* prescaler sel LSB */
+    UART_CTRL_PRSC_MSB      = 5,  /* prescaler sel MSB */
+    UART_CTRL_BAUD_LSB      = 6,  /* baud div LSB */
+    UART_CTRL_BAUD_MSB      = 15, /* baud div MSB */
+    UART_CTRL_RX_NEMPTY     = 16, /* RX not empty */
+    UART_CTRL_RX_FULL       = 17, /* RX full */
+    UART_CTRL_TX_EMPTY      = 18, /* TX empty */
+    UART_CTRL_TX_NFULL      = 19, /* TX not full */
+    UART_CTRL_IRQ_RX_NEMPTY = 20, /* IRQ on RX not empty */
+    UART_CTRL_IRQ_RX_FULL   = 21, /* IRQ on RX full */
+    UART_CTRL_IRQ_TX_EMPTY  = 22, /* IRQ on TX empty */
+    UART_CTRL_IRQ_TX_NFULL  = 23, /* IRQ on TX not full */
+
+    UART_CTRL_RX_OVER       = 30, /* RX overflow */
+    UART_CTRL_TX_BUSY       = 31  /* TX busy or not empty */
+};
+
+/**  bits */
+enum NEORV32_UART_DATA_enum {
+    UART_DATA_RTX_LSB = 0, /**< (r/w): UART rx/tx data, LSB */
+    UART_DATA_RTX_MSB = 7, /**< (r/w): UART rx/tx data, MSB */
+
+    UART_DATA_RX_FIFO_SIZE_LSB = 8, /**< (r/-): log2(RX FIFO size), LSB */
+    UART_DATA_RX_FIFO_SIZE_MSB = 11, /**< (r/-): log2(RX FIFO size), MSB */
+
+    UART_DATA_TX_FIFO_SIZE_LSB = 12, /**< (r/-): log2(RX FIFO size), LSB */
+    UART_DATA_TX_FIFO_SIZE_MSB = 15, /**< (r/-): log2(RX FIFO size), MSB */
+};
+/**@}*/
+
+static void neorv32_uart_update_irq(Neorv32UARTState *s)
+{
+    int cond = 0;
+    if ((s->ie & NEORV32_UART_IE_TXWM) ||
+       ((s->ie & NEORV32_UART_IE_RXWM) && s->rx_fifo_len)) {
+        cond = 1;
+    }
+    if (cond) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint64_t
+neorv32_uart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+  Neorv32UARTState *s = opaque;
+  unsigned char r;
+
+    switch (addr) {
+    case NEORV32_UART_CTRL:
+        if (s->rx_fifo_len) {
+            s->CTRL |= (1 << UART_CTRL_RX_NEMPTY); /* set data available */
+        } else {
+            s->CTRL &= ~(1 << UART_CTRL_RX_NEMPTY); /* clear data available */
+        }
+        /* TODO: assuming here TX is always avalable, fix it. */
+        s->CTRL |= (1 << UART_CTRL_TX_NFULL); /* set TX not full */
+
+        return s->CTRL;
+
+    case NEORV32_UART_DATA:
+        if (s->rx_fifo_len) {
+            r = s->rx_fifo[0];
+            memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
+            s->rx_fifo_len--;
+            qemu_chr_fe_accept_input(&s->chr);
+            s->DATA = r;
+
+            neorv32_uart_update_irq(s); /* TODO: check if need to call */
+            return r;
+        }
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr = 0x%x\n",
+    __func__, (int)addr);
+    return 0;
+}
+
+
+
+static void
+neorv32_uart_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
+{
+    Neorv32UARTState *s = opaque;
+    uint32_t value = val64;
+    unsigned char ch = value;
+
+    /* TODO: check if need to update data and control bits */
+    switch (addr) {
+    case NEORV32_UART_CTRL:
+        s->CTRL = value;
+        /* TODO: check if need to call, depending on IRQ flags */
+        /* neorv32_uart_update_irq(s); */
+        return;
+    case NEORV32_UART_DATA:
+        s->DATA = value;
+        qemu_chr_fe_write(&s->chr, &ch, 1);
+        /* neorv32_uart_update_irq(s); TODO: check if need to call */
+    return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr = 0x%x v = 0x%x\n",
+    __func__, (int)addr, (int)value);
+}
+
+static const MemoryRegionOps neorv32_uart_ops = {
+    .read = neorv32_uart_read,
+    .write = neorv32_uart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+    .min_access_size = 4,
+    .max_access_size = 4
+    }
+};
+
+static void neorv32_uart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    Neorv32UARTState *s = NEORV32_UART(obj);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_uart_ops, s,
+    TYPE_NEORV32_UART, NEORV32_UART_IO_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+
+static void neorv32_uart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    Neorv32UARTState *s = opaque;
+
+    /* Got a byte.  */
+    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
+        printf("WARNING: UART dropped char.\n");
+        return;
+    }
+    s->rx_fifo[s->rx_fifo_len++] = *buf;
+
+    neorv32_uart_update_irq(s);
+}
+
+static int neorv32_uart_can_rx(void *opaque)
+{
+    Neorv32UARTState *s = opaque;
+
+    return s->rx_fifo_len < sizeof(s->rx_fifo);
+}
+
+static void neorv32_uart_event(void *opaque, QEMUChrEvent event)
+{
+}
+
+static int  neorv32_uart_be_change(void *opaque)
+{
+    Neorv32UARTState *s = opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
+    neorv32_uart_event, neorv32_uart_be_change, s,
+    NULL, true);
+
+    return 0;
+}
+
+static void neorv32_uart_realize(DeviceState *dev, Error **errp)
+{
+    Neorv32UARTState *s = NEORV32_UART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, neorv32_uart_can_rx, neorv32_uart_rx,
+    neorv32_uart_event, neorv32_uart_be_change, s,
+    NULL, true);
+}
+
+static const VMStateDescription vmstate_neorv32_uart = {
+    .name = TYPE_NEORV32_UART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+    VMSTATE_UINT8_ARRAY(rx_fifo, Neorv32UARTState,
+    NEORV32_UART_RX_FIFO_SIZE),
+    VMSTATE_UINT8(rx_fifo_len, Neorv32UARTState),
+    VMSTATE_UINT32(ie, Neorv32UARTState),
+    VMSTATE_END_OF_LIST()
+    },
+};
+
+static void neorv32_uart_reset_enter(Object *obj, ResetType type)
+{
+    Neorv32UARTState *s = NEORV32_UART(obj);
+    s->rx_fifo_len = 0;
+    s->ie = 0;
+}
+
+static void neorv32_uart_reset_hold(Object *obj, ResetType type)
+{
+    Neorv32UARTState *s = NEORV32_UART(obj);
+    qemu_irq_lower(s->irq);
+}
+
+static void neorv32_uart_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    dc->realize = neorv32_uart_realize;
+    dc->vmsd = &vmstate_neorv32_uart;
+    rc->phases.enter = neorv32_uart_reset_enter;
+    rc->phases.hold = neorv32_uart_reset_hold;
+    device_class_set_props(dc, neorv32_uart_properties);
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo neorv32_uart_info = {
+    .name = TYPE_NEORV32_UART,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Neorv32UARTState),
+    .instance_init = neorv32_uart_init,
+    .class_init = neorv32_uart_class_init,
+};
+
+static void neorv32_uart_register_types(void)
+{
+    type_register_static(&neorv32_uart_info);
+}
+
+type_init(neorv32_uart_register_types)
+/*
+ * Create UART device.
+ */
+Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
+  Chardev *chr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+    bool succed = false;
+
+    dev = qdev_new("riscv.neorv32.uart");
+
+    qdev_prop_set_chr(dev, "chardev", chr);
+    s = SYS_BUS_DEVICE(dev);
+    succed = sysbus_realize_and_unref(s, &error_fatal);
+
+    if (succed) {
+        memory_region_add_subregion(address_space, base,
+        sysbus_mmio_get_region(s, 0));
+        return NEORV32_UART(dev);
+    } else {
+        return NULL;
+    }
+} /* neorv32_uart_create */
diff --git a/include/hw/char/neorv32_uart.h b/include/hw/char/neorv32_uart.h
new file mode 100644
index 0000000000..fa33906724
--- /dev/null
+++ b/include/hw/char/neorv32_uart.h
@@ -0,0 +1,54 @@
+/*
+ * Neorv32-specific UART.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NEORV32_UART_H
+#define HW_NEORV32_UART_H
+
+#include "chardev/char-fe.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_NEORV32_UART "riscv.neorv32.uart"
+OBJECT_DECLARE_SIMPLE_TYPE(Neorv32UARTState, NEORV32_UART)
+
+#define QEMU_UART_DATA_RX_FIFO_SIZE_LSB  8  /* log2 RX FIFO size LSB */
+#define QEMU_UART_DATA_RX_FIFO_SIZE_MSB  11  /* log2 RX FIFO size MSB */
+
+#define NEORV32_UART_RX_FIFO_SIZE  32 /* in HW it is 2048 + 256 = _MSB + _LSB */
+
+enum {
+    NEORV32_UART_IE_TXWM = 1, /* Transmit watermark interrupt enable */
+    NEORV32_UART_IE_RXWM = 2  /* Receive watermark interrupt enable */
+};
+
+enum {
+    NEORV32_UART_IP_TXWM = 1, /* Transmit watermark interrupt pending */
+    NEORV32_UART_IP_RXWM = 2  /* Receive watermark interrupt pending */
+};
+
+
+
+struct Neorv32UARTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    qemu_irq irq;
+    MemoryRegion mmio;
+    CharFrontend chr;
+    uint8_t rx_fifo[NEORV32_UART_RX_FIFO_SIZE];
+    uint8_t rx_fifo_len;
+    uint32_t ie; /* interrupt enable */
+    uint32_t CTRL;
+    uint32_t DATA;
+};
+
+Neorv32UARTState *neorv32_uart_create(MemoryRegion *address_space, hwaddr base,
+    Chardev *chr);
+
+#endif /* HW_NEORV32_UART_H */
-- 
2.51.1


