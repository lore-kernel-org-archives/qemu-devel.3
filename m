Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C717C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 22:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUZyt-00015L-2E; Mon, 29 Jan 2024 17:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUZyr-00014l-Dd; Mon, 29 Jan 2024 17:19:53 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUZyo-0000k1-TQ; Mon, 29 Jan 2024 17:19:53 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so2763174b6e.1; 
 Mon, 29 Jan 2024 14:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706566789; x=1707171589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xRWbgluz8QGLyuoMtL1MfbyjzdswOe9CPPo5M5diPI=;
 b=DdU8f9EFNBhViMNr+8s1ZzJ4j4EblfOb2iWGySTwHiKaA+SXwLREyWtReySyWIHeHa
 8Bz8OJVqlbnLE5gUu6pU8XN/Gat/azoZdyXR7y0yLF7422N0UyNM+uazclKytxigNRTi
 YG8JgW/gd+Xr9pCYhGbMP3D6ThEbz3WJzvbmwY/FiJ/cudXW7kOrEAu9YinjqkCgVZiS
 T4DwHw9b5P1DJ2/r8KwhJOItqDyZfeTeqCPjU7uFtpbQhOKCO3XM27KcYTmmEeUi4VDX
 DaYsXpkWsfryI9U7Zmd4u+lzRy2pDpRunfq8gm592c84nCcaUL2+Rqu2PwhSQYTS6huh
 8pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706566789; x=1707171589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xRWbgluz8QGLyuoMtL1MfbyjzdswOe9CPPo5M5diPI=;
 b=s/3EcDdm9iS9gmftC+razphiAr/81phfHeHKjgxGLSUQBsTwZ/bB7/kzfxL1dNFT9/
 004mWQ5rCZtLX02LpqnoK75W5NFhjmNvffd6QU0jbCl1BC/tU6y9YPHcfT8uLnK+QtiS
 T29imTCYoNG2960d0PzGquld6ZQ2hY1iGz2aNc7MLnT8FBF8FKUglOa3lWl/Ur5II5mO
 dHcsAWqqcvoDcnM7qwb0bopaHJV0ISxiEn7ywjFEgGqpUGWRWGCMMWcgnJVbu1eZ5OdD
 ZOs0tXgLelJRdy/X7KzlXpVQ2e9xzEnns4X0S0QoOsoro4FqYPWZuML3kz5au/oIlH8R
 /Inw==
X-Gm-Message-State: AOJu0YwtMTZDouCdEJ9j+2X2DipiV+Ftl+oNPn2Ile88t2+1UjAKvYlf
 0fs+HJ2b8G//z+F8wOjRMv7gucin9k2/SxDE7oJLDeuDTtUckHVisF0JG7FSsUAurQ==
X-Google-Smtp-Source: AGHT+IHPdcrOkb6RqkpGtFM8tDCHCOT/bWe0ufiXB8xFlRdoSLIrenxjMcogLSh6od7uCxfIkQLBnw==
X-Received: by 2002:a05:6808:1997:b0:3be:494e:9379 with SMTP id
 bj23-20020a056808199700b003be494e9379mr4910410oib.16.1706566789129; 
 Mon, 29 Jan 2024 14:19:49 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78453000000b006ddc1ae04eesm6353084pfn.192.2024.01.29.14.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 14:19:48 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, alistair@alistair23.me,
 pbonzini@redhat.com, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v4 1/2] hw/ssi: Implement BCM2835 SPI Controller
Date: Tue, 30 Jan 2024 03:48:07 +0530
Message-Id: <20240129221807.2983148-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
References: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch adds the SPI controller for the BCM2835. Polling and interrupt modes
of transfer are supported. DMA and LoSSI modes are currently unimplemented.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 docs/system/arm/raspi.rst    |   2 +-
 hw/ssi/Kconfig               |   4 +
 hw/ssi/bcm2835_spi.c         | 288 +++++++++++++++++++++++++++++++++++
 hw/ssi/meson.build           |   1 +
 include/hw/ssi/bcm2835_spi.h |  81 ++++++++++
 5 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 include/hw/ssi/bcm2835_spi.h

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 922fe375a6..d0a6f08b2b 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -33,11 +33,11 @@ Implemented devices
  * USB2 host controller (DWC2 and MPHI)
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
+ * Peripheral SPI controller (SPI)
 
 
 Missing devices
 ---------------
 
- * Peripheral SPI controller (SPI)
  * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 7d90a02181..83ee53c1d0 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -20,3 +20,7 @@ config XILINX_SPIPS
 config STM32F2XX_SPI
     bool
     select SSI
+
+config BCM2835_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
new file mode 100644
index 0000000000..6ecb42d4e3
--- /dev/null
+++ b/hw/ssi/bcm2835_spi.c
@@ -0,0 +1,288 @@
+/*
+ * BCM2835 SPI Master Controller
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
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
+#include "qemu/fifo8.h"
+#include "hw/ssi/bcm2835_spi.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+
+static void bcm2835_spi_update_int(BCM2835SPIState *s)
+{
+    int do_interrupt = 0;
+
+    /* Interrupt on DONE */
+    if (s->cs & BCM2835_SPI_CS_INTD && s->cs & BCM2835_SPI_CS_DONE) {
+        do_interrupt = 1;
+    }
+    /* Interrupt on RXR */
+    if (s->cs & BCM2835_SPI_CS_INTR && s->cs & BCM2835_SPI_CS_RXR) {
+        do_interrupt = 1;
+    }
+    qemu_set_irq(s->irq, do_interrupt);
+}
+
+static void bcm2835_spi_update_rx_flags(BCM2835SPIState *s)
+{
+    /* Set RXD if RX FIFO is non empty */
+    if (!fifo8_is_empty(&s->rx_fifo)) {
+        s->cs |= BCM2835_SPI_CS_RXD;
+    } else {
+        s->cs &= ~BCM2835_SPI_CS_RXD;
+    }
+
+    /* Set RXF if RX FIFO is full */
+    if (fifo8_is_full(&s->rx_fifo)) {
+        s->cs |= BCM2835_SPI_CS_RXF;
+    } else {
+        s->cs &= ~BCM2835_SPI_CS_RXF;
+    }
+
+    /* Set RXR if RX FIFO is 3/4th used or above */
+    if (fifo8_num_used(&s->rx_fifo) >= FIFO_SIZE_3_4) {
+        s->cs |= BCM2835_SPI_CS_RXR;
+    } else {
+        s->cs &= ~BCM2835_SPI_CS_RXR;
+    }
+}
+
+static void bcm2835_spi_update_tx_flags(BCM2835SPIState *s)
+{
+    /* Set TXD if TX FIFO is not full */
+    if (fifo8_is_full(&s->tx_fifo)) {
+        s->cs &= ~BCM2835_SPI_CS_TXD;
+    } else {
+        s->cs |= BCM2835_SPI_CS_TXD;
+    }
+
+    /* Set DONE if in TA mode and TX FIFO is empty */
+    if (fifo8_is_empty(&s->tx_fifo) && s->cs & BCM2835_SPI_CS_TA) {
+        s->cs |= BCM2835_SPI_CS_DONE;
+    } else {
+        s->cs &= ~BCM2835_SPI_CS_DONE;
+    }
+}
+
+static void bcm2835_spi_flush_tx_fifo(BCM2835SPIState *s)
+{
+    uint8_t tx_byte, rx_byte;
+
+    while (!fifo8_is_empty(&s->tx_fifo) && !fifo8_is_full(&s->rx_fifo)) {
+        tx_byte = fifo8_pop(&s->tx_fifo);
+        rx_byte = ssi_transfer(s->bus, tx_byte);
+        fifo8_push(&s->rx_fifo, rx_byte);
+    }
+
+    bcm2835_spi_update_tx_flags(s);
+    bcm2835_spi_update_rx_flags(s);
+}
+
+static uint64_t bcm2835_spi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BCM2835SPIState *s = opaque;
+    uint32_t readval = 0;
+
+    switch (addr) {
+    case BCM2835_SPI_CS:
+        readval = s->cs & 0xffffffff;
+        break;
+    case BCM2835_SPI_FIFO:
+        bcm2835_spi_flush_tx_fifo(s);
+        if (s->cs & BCM2835_SPI_CS_RXD) {
+            readval = fifo8_pop(&s->rx_fifo);
+            bcm2835_spi_update_rx_flags(s);
+        }
+
+        bcm2835_spi_update_int(s);
+        break;
+    case BCM2835_SPI_CLK:
+        readval = s->clk & 0xffff;
+        break;
+    case BCM2835_SPI_DLEN:
+        readval = s->dlen & 0xffff;
+        break;
+    case BCM2835_SPI_LTOH:
+        readval = s->ltoh & 0xf;
+        break;
+    case BCM2835_SPI_DC:
+        readval = s->dc & 0xffffffff;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+    return readval;
+}
+
+static void bcm2835_spi_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned int size)
+{
+    BCM2835SPIState *s = opaque;
+
+    switch (addr) {
+    case BCM2835_SPI_CS:
+        s->cs = (value & ~RO_MASK) | (s->cs & RO_MASK);
+        if (!(s->cs & BCM2835_SPI_CS_TA)) {
+            /* Clear DONE and RXR if TA is off */
+            s->cs &= ~(BCM2835_SPI_CS_DONE);
+            s->cs &= ~(BCM2835_SPI_CS_RXR);
+        }
+
+        /* Clear RX FIFO */
+        if (s->cs & BCM2835_SPI_CLEAR_RX) {
+            fifo8_reset(&s->rx_fifo);
+            bcm2835_spi_update_rx_flags(s);
+        }
+
+        /* Clear TX FIFO*/
+        if (s->cs & BCM2835_SPI_CLEAR_TX) {
+            fifo8_reset(&s->tx_fifo);
+            bcm2835_spi_update_tx_flags(s);
+        }
+
+        /* Set Transfer Active */
+        if (s->cs & BCM2835_SPI_CS_TA) {
+            bcm2835_spi_update_tx_flags(s);
+        }
+
+        if (s->cs & BCM2835_SPI_CS_DMAEN) {
+            qemu_log_mask(LOG_UNIMP, "%s: " \
+                          "DMA not supported\n", __func__);
+        }
+
+        if (s->cs & BCM2835_SPI_CS_LEN) {
+            qemu_log_mask(LOG_UNIMP, "%s: " \
+                          "LoSSI not supported\n", __func__);
+        }
+
+        bcm2835_spi_update_int(s);
+        break;
+    case BCM2835_SPI_FIFO:
+        /*
+         * According to documentation, writes to FIFO without TA controls
+         * CS and DLEN registers. This is supposed to be used in DMA mode
+         * which is currently unimplemented. Moreover, Linux does not make
+         * use of this and directly modifies the CS and DLEN registers.
+         */
+        if (s->cs & BCM2835_SPI_CS_TA) {
+            if (s->cs & BCM2835_SPI_CS_TXD) {
+                fifo8_push(&s->tx_fifo, value & 0xff);
+                bcm2835_spi_update_tx_flags(s);
+            }
+
+            bcm2835_spi_flush_tx_fifo(s);
+            bcm2835_spi_update_int(s);
+        }
+        break;
+    case BCM2835_SPI_CLK:
+        s->clk = value & 0xffff;
+        break;
+    case BCM2835_SPI_DLEN:
+        s->dlen = value & 0xffff;
+        break;
+    case BCM2835_SPI_LTOH:
+        s->ltoh = value & 0xf;
+        break;
+    case BCM2835_SPI_DC:
+        s->dc = value & 0xffffffff;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps bcm2835_spi_ops = {
+    .read = bcm2835_spi_read,
+    .write = bcm2835_spi_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2835_spi_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835SPIState *s = BCM2835_SPI(dev);
+    s->bus = ssi_create_bus(dev, "spi");
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_spi_ops, s,
+                          TYPE_BCM2835_SPI, 0x18);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    fifo8_create(&s->tx_fifo, FIFO_SIZE);
+    fifo8_create(&s->rx_fifo, FIFO_SIZE);
+}
+static void bcm2835_spi_reset(DeviceState *dev)
+{
+    BCM2835SPIState *s = BCM2835_SPI(dev);
+
+    fifo8_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
+
+    /* Reset values according to BCM2835 Peripheral Documentation */
+    s->cs = BCM2835_SPI_CS_TXD | BCM2835_SPI_CS_REN;
+    s->clk = 0;
+    s->dlen = 0;
+    s->ltoh = 0x1;
+    s->dc = 0x30201020;
+}
+
+static const VMStateDescription vmstate_bcm2835_spi = {
+    .name = TYPE_BCM2835_SPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FIFO8(tx_fifo, BCM2835SPIState),
+        VMSTATE_FIFO8(rx_fifo, BCM2835SPIState),
+        VMSTATE_UINT32(cs, BCM2835SPIState),
+        VMSTATE_UINT32(clk, BCM2835SPIState),
+        VMSTATE_UINT32(dlen, BCM2835SPIState),
+        VMSTATE_UINT32(ltoh, BCM2835SPIState),
+        VMSTATE_UINT32(dc, BCM2835SPIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = bcm2835_spi_reset;
+    dc->realize = bcm2835_spi_realize;
+    dc->vmsd = &vmstate_bcm2835_spi;
+}
+
+static const TypeInfo bcm2835_spi_info = {
+    .name = TYPE_BCM2835_SPI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835SPIState),
+    .class_init = bcm2835_spi_class_init,
+};
+
+static void bcm2835_spi_register_types(void)
+{
+    type_register_static(&bcm2835_spi_info);
+}
+
+type_init(bcm2835_spi_register_types)
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 0aebcdd614..b999aeb027 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -11,3 +11,4 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
+system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
diff --git a/include/hw/ssi/bcm2835_spi.h b/include/hw/ssi/bcm2835_spi.h
new file mode 100644
index 0000000000..d3f8cec111
--- /dev/null
+++ b/include/hw/ssi/bcm2835_spi.h
@@ -0,0 +1,81 @@
+/*
+ * BCM2835 SPI Master Controller
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
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
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+
+#define TYPE_BCM2835_SPI "bcm2835-spi"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835SPIState, BCM2835_SPI)
+
+/*
+ * Though BCM2835 documentation says FIFOs have a capacity of 16,
+ * FIFOs are actually 16 words in size or effectively 64 bytes when operating
+ * in non DMA mode.
+ */
+#define FIFO_SIZE               64
+#define FIFO_SIZE_3_4           48
+
+#define RO_MASK                 0x1f0000
+
+#define BCM2835_SPI_CS          0x00
+#define BCM2835_SPI_FIFO        0x04
+#define BCM2835_SPI_CLK         0x08
+#define BCM2835_SPI_DLEN        0x0c
+#define BCM2835_SPI_LTOH        0x10
+#define BCM2835_SPI_DC          0x14
+
+#define BCM2835_SPI_CS_RXF      BIT(20)
+#define BCM2835_SPI_CS_RXR      BIT(19)
+#define BCM2835_SPI_CS_TXD      BIT(18)
+#define BCM2835_SPI_CS_RXD      BIT(17)
+#define BCM2835_SPI_CS_DONE     BIT(16)
+#define BCM2835_SPI_CS_LEN      BIT(13)
+#define BCM2835_SPI_CS_REN      BIT(12)
+#define BCM2835_SPI_CS_INTR     BIT(10)
+#define BCM2835_SPI_CS_INTD     BIT(9)
+#define BCM2835_SPI_CS_DMAEN    BIT(8)
+#define BCM2835_SPI_CS_TA       BIT(7)
+#define BCM2835_SPI_CLEAR_RX    BIT(5)
+#define BCM2835_SPI_CLEAR_TX    BIT(4)
+
+struct BCM2835SPIState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    SSIBus *bus;
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t cs;
+    uint32_t clk;
+    uint32_t dlen;
+    uint32_t ltoh;
+    uint32_t dc;
+
+    Fifo8 tx_fifo;
+    Fifo8 rx_fifo;
+};
-- 
2.34.1


