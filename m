Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F138DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTt2-0004nT-Uj; Mon, 29 Jan 2024 10:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUTsw-0004a1-GE
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:49:23 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUTsu-0005q7-8e
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:49:22 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso1661243a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706543358; x=1707148158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HnSM2ykj872+1I10ufPqjP1oHcQy/chu5lfcrju4WM=;
 b=ZXDyLYd91EoBy9hWTmhOB9xFmTzIyLpxx0zxyeVOF+4+eGP36KlJtzNcVM/K9Ikd/d
 7vBPtdoa54yXuFSbmdPn1oHKX9eOr3AzWRhK2um91kCEQozpmT8ykjyoCEgde4+iCIEt
 WQTlS4tAKpAdN6b5JtiOcbgNxTYpuevEinnbVlvG8MmdH9ob1TmPtVP8yYSvgBTlVHn3
 7nFF4lgMAsixKkhhYa48PvVJU6Fd8LtuSFfQSWYvcnG69MR18uBp6fNX0L72obG8lAD0
 2FfuhUOLXkDbWWadrOqL+JNH2kPGEUn0fn4yHRzaaK5Dqov3WTYoI5VMS0LDD2R16cAq
 6LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543358; x=1707148158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HnSM2ykj872+1I10ufPqjP1oHcQy/chu5lfcrju4WM=;
 b=jQXREV2FWCcSIVJPIRrxvJ6PmM46WUXY4SBiVat+8VNMvY4yCOZhR8fH9xOd4XqvKh
 uglEnuGLbYbxQR3j/o7cd/bbTzpM6XdK3TDUVhgR67K03jgzqPdyYMsjoLc+S8PLwfxy
 mT2ix7pv3BWIYV6uOKsbnKvD264vV1uim/JX4y+Rw5zf3UAfEQo6zYxf6VKodh8jQubX
 t/cqoCEtbN3Qe3vgL/+P/Tk9FIJMWaJDlHnFOaHpqT9eEb8G8NeLI6ikzi2SFuYQktLP
 REuwFBiUVo2UX2l3Xxb0nHCTzMpEVSnqYtyCtbefubYEAxsO28zfbzjWmo2TLH1R61zQ
 CelQ==
X-Gm-Message-State: AOJu0YyOB6kZHYWVEGlFI+vUobLa/XrkseYvTPu3TF0O6tpXjI7E4p4+
 w0mVHow9KbbuWtvKTeoeOIlbPfoCKKuxRsgdLEkItOXOmhK17/SOGHcTTMJMOu8=
X-Google-Smtp-Source: AGHT+IHyhLA4tuuRS9/n/a6qtwsgp5rlSHZyYVl5xo7QsaRDPsuxKAg5cEOxAKIK7KWG2TiWOf6WEw==
X-Received: by 2002:a05:6a20:9c8e:b0:19c:a0f9:4f8a with SMTP id
 mj14-20020a056a209c8e00b0019ca0f94f8amr4428887pzb.20.1706543357574; 
 Mon, 29 Jan 2024 07:49:17 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a170902c70100b001d90143a21fsm34213plp.263.2024.01.29.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:49:17 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 1/2] hw/ssi: Implement BCM2835 SPI Controller
Date: Mon, 29 Jan 2024 21:19:07 +0530
Message-Id: <20240129154908.2761091-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129154908.2761091-1-rayhan.faizel@gmail.com>
References: <20240129154908.2761091-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pg1-x52c.google.com
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

This patch creates the SPI controller for the BCM2835. Polling and interrupt modes
of transfer are supported. DMA and LoSSI modes are currently unimplemented.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 docs/system/arm/raspi.rst    |   3 +-
 hw/ssi/Kconfig               |   4 +
 hw/ssi/bcm2835_spi.c         | 288 +++++++++++++++++++++++++++++++++++
 hw/ssi/meson.build           |   1 +
 include/hw/ssi/bcm2835_spi.h |  81 ++++++++++
 5 files changed, 375 insertions(+), 2 deletions(-)
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 include/hw/ssi/bcm2835_spi.h

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 922fe375a6..b8198bbd54 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -33,11 +33,10 @@ Implemented devices
  * USB2 host controller (DWC2 and MPHI)
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
-
+ * Peripheral SPI controller (SPI)
 
 Missing devices
 ---------------
 
- * Peripheral SPI controller (SPI)
  * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 7d90a02181..110533255b 100644
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
\ No newline at end of file
diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
new file mode 100644
index 0000000000..757ebc90fa
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


