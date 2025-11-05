Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EE9CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGibh-00049P-RX; Wed, 05 Nov 2025 13:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib6-0003zc-FS
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:10 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib2-0003Cb-P3
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so93368f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 10:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762368663; x=1762973463;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNQLK4ewOJjPgvmOfboyv0uwibkrxNDgkc5qo0Kq6ic=;
 b=c795NHVRCD5Aq7kV4fgeE+GW7F1tIODpU+uSpG7R7kuJUZTa3mdLtg8l5h2WYtNNob
 8tjf5+2Abkq0daLjM4GjCa/do7AfRX3tC31aUayYoXSGiha85EBGwSSSWFBuNuQGY4WE
 bfGQrs1qJcmYS7IjzM2G0PQiq59IkEgUyPctIGHo3Okh+DGMU2NFqhtCpy3WwXYXxR6m
 iWQnWLiLfTa3L+2v5KgHAhZHMVpYOF783/2h4L0ifBnksayx92yBl2VG/BhMIb8MgQZ1
 T5yms+5TEE0byZwlev/zxqIUsYnNzYUpMTDEE6Gu9Qb3kznrCpTGva6BBH5xSBjtlTAn
 qYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762368663; x=1762973463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNQLK4ewOJjPgvmOfboyv0uwibkrxNDgkc5qo0Kq6ic=;
 b=t9J/HBz9qTOS+7x0dRcYCZLzs9Ms2vfysoyvkt5GC3rY50xiKv3R+gawBa4L6EZrb8
 natByfuK99qT2Rn9UEuDBuUwctDcAcOY+yKPJjZO2LmN+fAwoyV/BZaCkgReSvLqHbZC
 VazrbTtFBBtszytw4Ch0ycQDcbo+8OPGEQkMaDSgQYLtAgqBVnMeXJ4CVPPPX0Q4RDrk
 U/5jfjmYrpQIMc9T1uTVbG/DD0Kt/S1HlLpGBucRcYw0C4ZqUxnTb8lrM9R2hosx59SD
 DmdGJDvl3gYqDBJs3uBaGK56PzShLw7MaBOdmhtDhO8SZCt6gz1F+J4JmDxPw0YZbCrG
 zcAA==
X-Gm-Message-State: AOJu0YwcGLzPMwxh81O9CFzaU22EwUPqhGTPaQCeEb7P/bZxuiUkiUWV
 yvAstGhKM3GDeII5kWcEpHf/rs3kPg8l7sDBgfPJdzHlzSl2yCWPI7LyhfPOXvVGrgoYpVM7d1z
 0/1shwMM=
X-Gm-Gg: ASbGncvyn7PGmQVPDBPVg5Q6GNJZY72G1k0RKesjNOIsh5SX01unwIiqXngLj+H5BqL
 5CDs0As4z4qFHRhR6lMNJwdWjdTEdznjeDN9nnV/9iC+b56O8axHmUYqiI6J3pCHmihTwbP8TU2
 11xKP9q0yEx0O2OrTm2QIxjuTOZKSt+SJrWyCy14gSoQr068Yw4VfS40v7t7s3YMmlpzXAJJ/53
 AckbLlegsaAZOKntEwnmSFKPVkW3j/ggiCG9vAskNXei+ydMFubk4Flo4xsDaHlhb2bmEwO787+
 qpp9Kv7aiWX6mYN+sOT3HxJce3KjT/Tu0BMr7WOJWU8cRb9ihCTtpGir3iw5C2Maw234TyT1dwT
 glzLhVY0+UziGQNndDRkUByOgO6m/4N4vnt5UtsmU5eGCc8aQflu80HyYw847NQ7dKt8/zZUjAC
 S6JG6D
X-Google-Smtp-Source: AGHT+IE3PY8op3oneZRy/BQm+NSnglC+QUnd4qY5GO3Uah5o5BrC5OrfXSS7h0N0uQo5yC0uj+AF3Q==
X-Received: by 2002:a05:6000:2dc6:b0:429:dbed:28fb with SMTP id
 ffacd0b85a97d-429e32e46aamr3825800f8f.23.1762368662831; 
 Wed, 05 Nov 2025 10:51:02 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a354sm270622f8f.20.2025.11.05.10.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:51:02 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v3 4/5] hw/ssi: add NEORV32 SPI controller (SSI master,
 CS command)
Date: Wed,  5 Nov 2025 20:50:55 +0200
Message-ID: <20251105185056.23565-5-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105185056.23565-1-michael@videogpu.com>
References: <20251105185056.23565-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::432;
 envelope-from=michael@videogpu.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add NEORV32 SPI controller: CTRL/DATA, tiny TX/RX FIFOs, command-mode CS (active-low),
SSI master bus, and helper to attach n25q flash when an MTD drive is provided.
Includes Kconfig/meson and public header.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 hw/ssi/Kconfig               |   4 +
 hw/ssi/meson.build           |   1 +
 hw/ssi/neorv32_spi.c         | 478 +++++++++++++++++++++++++++++++++++
 include/hw/ssi/neorv32_spi.h |  57 +++++
 4 files changed, 540 insertions(+)
 create mode 100644 hw/ssi/neorv32_spi.c
 create mode 100644 include/hw/ssi/neorv32_spi.h

diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..5b1a03f3c4 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config NEORV32_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..5139cc1ca0 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
+system_ss.add(when: 'CONFIG_NEORV32_SPI', if_true: files('neorv32_spi.c'))
diff --git a/hw/ssi/neorv32_spi.c b/hw/ssi/neorv32_spi.c
new file mode 100644
index 0000000000..954788a5de
--- /dev/null
+++ b/hw/ssi/neorv32_spi.c
@@ -0,0 +1,478 @@
+/*
+ * QEMU implementation of the Neorv32 SPI block.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "qemu/fifo8.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace/trace-root.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/ssi/neorv32_spi.h"
+#include "system/blockdev.h"
+
+/* SPI control register bits */
+enum NEORV32_SPI_CTRL_enum {
+  SPI_CTRL_EN           =  0, /* (r/w): SPI unit enable */
+  SPI_CTRL_CPHA         =  1, /* (r/w): Clock phase */
+  SPI_CTRL_CPOL         =  2, /* (r/w): Clock polarity */
+  SPI_CTRL_PRSC0        =  3, /* (r/w): Clock prescaler select bit 0 */
+  SPI_CTRL_PRSC1        =  4, /* (r/w): Clock prescaler select bit 1 */
+  SPI_CTRL_PRSC2        =  5, /* (r/w): Clock prescaler select bit 2 */
+  SPI_CTRL_CDIV0        =  6, /* (r/w): Clock divider bit 0 */
+  SPI_CTRL_CDIV1        =  7, /* (r/w): Clock divider bit 1 */
+  SPI_CTRL_CDIV2        =  8, /* (r/w): Clock divider bit 2 */
+  SPI_CTRL_CDIV3        =  9, /* (r/w): Clock divider bit 3 */
+
+  SPI_CTRL_RX_AVAIL     = 16, /* (r/-): RX FIFO data available (not empty) */
+  SPI_CTRL_TX_EMPTY     = 17, /* (r/-): TX FIFO empty */
+  SPI_CTRL_TX_FULL      = 18, /* (r/-): TX FIFO full */
+
+  SPI_CTRL_FIFO_LSB     = 24, /* (r/-): log2(FIFO size), LSB */
+  SPI_CTRL_FIFO_MSB     = 27, /* (r/-): log2(FIFO size), MSB */
+
+  SPI_CS_ACTIVE         = 30, /* (r/-): At least one CS line is active */
+  SPI_CTRL_BUSY         = 31  /* (r/-): serial PHY busy or TX FIFO not empty */
+};
+
+/* SPI data register bits */
+enum NEORV32_SPI_DATA_enum {
+  SPI_DATA_LSB  =  0, /* (r/w): Data byte LSB */
+  SPI_DATA_CSEN =  3, /* (-/w): Chip select enable (command-mode) */
+  SPI_DATA_MSB  =  7, /* (r/w): Data byte MSB */
+  SPI_DATA_CMD  = 31  /* (-/w): 1=command, 0=data */
+};
+
+/* Register offsets */
+#define NEORV32_SPI_CTRL          0x00
+#define NEORV32_SPI_DATA          0x04
+#define NEORV32_SPI_MMIO_SIZE     0x8  /* ctrl + data (8 bytes total) */
+/* Various constants */
+#define NEORV32_SPI_MAX_CS_LINES  7
+#define NEORV32_SPI_FIFO_CAPACITY 8
+
+/* Utility functions to get/set bits in ctrl register */
+static inline bool get_ctrl_bit(NEORV32SPIState *s, int bit)
+{
+    return (s->ctrl & (1 << bit)) != 0;
+}
+
+static inline void set_ctrl_bit(NEORV32SPIState *s, int bit, bool val)
+{
+    if (val) {
+        s->ctrl |= (1 << bit);
+    } else {
+        s->ctrl &= ~(1 << bit);
+    }
+}
+
+static inline bool get_data_bit(uint32_t v, int bit)
+{
+    return (v >> bit) & 1;
+}
+
+/* Update read-only status bits in CTRL register */
+static void neorv32_spi_update_status(NEORV32SPIState *s)
+{
+    /* RX_AVAIL: set if RX FIFO not empty */
+    set_ctrl_bit(s, SPI_CTRL_RX_AVAIL, !fifo8_is_empty(&s->rx_fifo));
+
+    /* TX_EMPTY: set if TX FIFO empty */
+    set_ctrl_bit(s, SPI_CTRL_TX_EMPTY, fifo8_is_empty(&s->tx_fifo));
+
+    /* TX_FULL: set if TX FIFO full */
+    set_ctrl_bit(s, SPI_CTRL_TX_FULL, fifo8_is_full(&s->tx_fifo));
+
+
+    /*
+     * BUSY: We'll consider SPI busy if TX FIFO is not empty
+     * or currently shifting data.
+     * For simplicity, if TX is not empty we say busy.
+     */
+    bool busy = !fifo8_is_empty(&s->tx_fifo);
+    set_ctrl_bit(s, SPI_CTRL_BUSY, busy);
+
+    /* Update CS status */
+    if (s->cmd_cs_active) {
+        s->ctrl |= (1u << SPI_CS_ACTIVE);
+    } else {
+        s->ctrl &= ~(1u << SPI_CS_ACTIVE);
+    }
+
+}
+
+/* Update chip select lines based on command-mode CS (active-low on the wire) */
+static void neorv32_spi_update_cs(NEORV32SPIState *s)
+{
+    /* Check that input valid */
+    if (!s->cs_lines || s->num_cs <= 0) {
+        return;
+    }
+
+    /* Deassert all CS lines (inactive = high) */
+    for (int i = 0; i < s->num_cs; i++) {
+        qemu_set_irq(s->cs_lines[i], 1);
+    }
+
+    /* If DATA command says CS active, assert selected line (low = active) */
+    if (s->cmd_cs_active) {
+        int cs_idx = s->current_cs;
+        if (cs_idx < 0 || cs_idx >= s->num_cs) {
+            /* Out of range: keep all deasserted, but warn once per event */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: CS index %d out of range (num_cs=%d)\n",
+                          __func__, cs_idx, s->num_cs);
+            return;
+        }
+        /* Active-low when enabled */
+        qemu_set_irq(s->cs_lines[cs_idx], 0);
+    }
+
+}
+
+/* Update IRQ based on conditions */
+static void neorv32_spi_update_irq(NEORV32SPIState *s)
+{
+    /*
+     * Conditions for IRQ:
+     * IRQ if RX data available and IRQ_RX_AVAIL is set:
+     *    if (!RX FIFO empty && SPI_CTRL_IRQ_RX_AVAIL set)
+     *
+     * IRQ if TX empty and IRQ_TX_EMPTY is set:
+     *    if (TX empty && SPI_CTRL_IRQ_TX_EMPTY set)
+     *
+     * IRQ if TX < half full and IRQ_TX_HALF is set:
+     *    if (TX < half full && SPI_CTRL_IRQ_TX_HALF set)
+     */
+
+    bool rx_irq = !fifo8_is_empty(&s->rx_fifo);
+    bool tx_empty_irq = fifo8_is_empty(&s->tx_fifo);
+    int  used = fifo8_num_used(&s->tx_fifo);
+    bool tx_half_irq = (used < (s->fifo_capacity / 2));
+
+    bool irq_level = rx_irq || tx_empty_irq || tx_half_irq;
+    qemu_set_irq(s->irq, irq_level ? 1 : 0);
+}
+
+/*
+ * Flush the TX FIFO to the SPI bus:
+ * For each byte in TX FIFO, send it out via ssi_transfer.
+ * If direction is not explicitly given, we assume:
+ *   - On write to DATA, we push to TX FIFO and then transfer out.
+ *   - On receiving data back from ssi_transfer, we push it into RX FIFO
+ *     if SPI is enabled.
+ */
+static void neorv32_spi_flush_txfifo(NEORV32SPIState *s)
+{
+    if (!get_ctrl_bit(s, SPI_CTRL_EN)) {
+        /* SPI not enabled, do nothing */
+        return;
+    }
+
+    while (!fifo8_is_empty(&s->tx_fifo)) {
+        uint8_t tx = fifo8_pop(&s->tx_fifo);
+        uint8_t rx = ssi_transfer(s->bus, tx);
+
+        /* Push received byte into RX FIFO if not full */
+        if (!fifo8_is_full(&s->rx_fifo)) {
+            fifo8_push(&s->rx_fifo, rx);
+        }
+    }
+}
+
+/* Reset the device state */
+static void neorv32_spi_reset(DeviceState *d)
+{
+    NEORV32SPIState *s = NEORV32_SPI(d);
+
+    s->ctrl = 0;
+    s->data = 0;
+
+    /* Reset FIFOs */
+    fifo8_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_cs(s);
+    neorv32_spi_update_irq(s);
+}
+
+/* MMIO read handler */
+static uint64_t neorv32_spi_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    NEORV32SPIState *s = opaque;
+    uint32_t r = 0;
+
+    switch (addr) {
+    case NEORV32_SPI_CTRL:
+        /* Return the current CTRL register value (including status bits) */
+        neorv32_spi_update_status(s);
+        r = s->ctrl;
+        break;
+
+    case NEORV32_SPI_DATA:
+        /* If RX FIFO is empty, return some default, else pop from RX FIFO */
+        if (fifo8_is_empty(&s->rx_fifo)) {
+            /*
+             * No data available,
+             * could return 0xFFFFFFFF or 0x00000000 as "no data"
+             */
+            r = 0x00000000;
+        } else {
+            r = fifo8_pop(&s->rx_fifo);
+        }
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read at address 0x%"
+                       HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_irq(s);
+
+    return r;
+}
+
+/* MMIO write handler */
+static void neorv32_spi_write(void *opaque, hwaddr addr,
+                              uint64_t val64, unsigned int size)
+{
+    NEORV32SPIState *s = opaque;
+    uint32_t value = val64;
+
+    switch (addr) {
+    case NEORV32_SPI_CTRL: {
+
+        /*
+         * Writing control register:
+         * Some bits are read-only (e.g., status bits).
+         * We should mask them out or ignore writes to them.
+         * For simplicity, we overwrite ctrl except for RO bits.
+         */
+
+
+        /*
+         * Save old RO bits: RX_AVAIL, TX_EMPTY, TX_NHALF, TX_FULL, BUSY
+         * and FIFO size bits
+         */
+        uint32_t ro_mask = ((1 << SPI_CTRL_BUSY)      |
+                            (1 << SPI_CTRL_TX_EMPTY)  |
+                            (1 << SPI_CTRL_TX_FULL)   |
+                            (1 << SPI_CTRL_RX_AVAIL));
+
+        /*
+         * FIFO size bits might be hardwired read-only.
+         * Assume we do not change them:
+         * FIFO size: bits [SPI_CTRL_FIFO_LSB..SPI_CTRL_FIFO_MSB],
+         * here assume read-only.
+         */
+        uint32_t fifo_size_mask = 0;
+        for (int b = SPI_CTRL_FIFO_LSB; b <= SPI_CTRL_FIFO_MSB; b++) {
+            fifo_size_mask |= (1 << b);
+        }
+        ro_mask |= fifo_size_mask;
+
+        uint32_t ro_bits = s->ctrl & ro_mask;
+        s->ctrl = (value & ~ro_mask) | ro_bits;
+
+        neorv32_spi_update_cs(s);
+        break;
+    } /* NEORV32_SPI_CTRL */
+
+    case NEORV32_SPI_DATA:
+    {
+        /* If CMD=1, this write is a command, not payload */
+        const bool is_cmd = get_data_bit(value, SPI_DATA_CMD);
+
+        if (is_cmd) {
+            /*
+             * DATA command format:
+             *   bit 31: CMD = 1
+             *   bit  3: CSEN (1=assert CS, 0=deassert All)
+             *   bits [2:0]: CS index (0..7) when asserting
+             */
+            const bool csen = get_data_bit(value, SPI_DATA_CSEN);
+            const int  cs_index = (int)(value & 0x7);
+
+            if (csen) {
+                /* Select and assert a single CS */
+                s->current_cs    = cs_index;  /* range checking  update_cs() */
+                s->cmd_cs_active = true;
+            } else {
+                /* Deassert all CS lines */
+                s->cmd_cs_active = false;
+            }
+
+            /* Drive the wires */
+            neorv32_spi_update_cs(s);
+            /* Update status (SPI_CS_ACTIVE is read-only status bit) */
+            neorv32_spi_update_status(s);
+            neorv32_spi_update_irq(s);
+            break; /* no FIFO push on command */
+        }
+
+        /* Writing DATA puts a byte into TX FIFO if not full */
+        if (!fifo8_is_full(&s->tx_fifo)) {
+            uint8_t tx_byte = (uint8_t)value;
+
+            fifo8_push(&s->tx_fifo, tx_byte);
+            /* After pushing data, flush TX to SPI bus */
+            neorv32_spi_flush_txfifo(s);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: TX FIFO full, cannot write 0x%x\n",
+                          __func__, value);
+        }
+        break;
+    } /* NEORV32_SPI_DATA */
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write at address 0x%"
+                      HWADDR_PRIx " value=0x%x\n", __func__, addr, value);
+        break;
+
+    } /* switch (addr) */
+
+    neorv32_spi_update_status(s);
+    neorv32_spi_update_irq(s);
+} /* neorv32_spi_write */
+
+static const MemoryRegionOps neorv32_spi_ops = {
+    .read = neorv32_spi_read,
+    .write = neorv32_spi_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void neorv32_spi_init(Object *obj)
+{
+    NEORV32SPIState *s = NEORV32_SPI(obj);
+    s->ctrl          = 0;
+    s->data          = 0;
+    s->fifo_capacity = NEORV32_SPI_FIFO_CAPACITY;
+    s->num_cs        = NEORV32_SPI_MAX_CS_LINES; /* Default to 1 CS line */
+    s->cmd_cs_active = false;
+    s->current_cs    = 0; /* Use CS0 by default */
+}
+
+/* Realize the device */
+static void neorv32_spi_realize(DeviceState *dev, Error **errp)
+{
+    NEORV32SPIState *s = NEORV32_SPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Create the SSI master bus */
+    s->bus = ssi_create_bus(dev, "neorv32-spi-bus");
+
+    /* 1) IRQ inputs: first the main IRQ, then each CS line */
+    sysbus_init_irq(sbd, &s->irq);
+    s->cs_lines = g_new0(qemu_irq, s->num_cs);
+    for (int i = 0; i < s->num_cs; i++) {
+        sysbus_init_irq(sbd, &s->cs_lines[i]);
+        qemu_set_irq(s->cs_lines[i], 1);  /* deassert CS (high) */
+    }
+
+    /* 2) Now map the MMIO region */
+    memory_region_init_io(&s->mmio, OBJECT(s), &neorv32_spi_ops, s,
+                          TYPE_NEORV32_SPI, NEORV32_SPI_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+
+    /* Initialize FIFOs */
+    fifo8_create(&s->tx_fifo, s->fifo_capacity);
+    fifo8_create(&s->rx_fifo, s->fifo_capacity);
+
+    /*
+     * Set FIFO size bits (log2 of FIFO size = 3 for capacity=8)
+     *
+     * FIFO size bits: from SPI_CTRL_FIFO_LSB to SPI_CTRL_FIFO_MSB
+     * We'll store a value of 3 (log2(8)=3)
+     */
+    int fifo_size_log2 = 3;
+    for (int b = SPI_CTRL_FIFO_LSB; b <= SPI_CTRL_FIFO_MSB; b++) {
+        int shift = b - SPI_CTRL_FIFO_LSB;
+        if (fifo_size_log2 & (1 << shift)) {
+            s->ctrl |= (1 << b);
+        } else {
+            s->ctrl &= ~(1 << b);
+        }
+    }
+}
+
+/* Device properties can be added if needed. For now, none. */
+static Property neorv32_spi_properties[] = {
+    DEFINE_PROP_UINT32("num-cs", NEORV32SPIState, num_cs, 1),
+};
+
+static void neorv32_spi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, neorv32_spi_properties);
+    device_class_set_legacy_reset(dc, neorv32_spi_reset);
+    dc->realize = neorv32_spi_realize;
+}
+
+static const TypeInfo neorv32_spi_type_info = {
+    .name           = TYPE_NEORV32_SPI,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(NEORV32SPIState),
+    .instance_init  = neorv32_spi_init,
+    .class_init     = neorv32_spi_class_init,
+};
+
+static void neorv32_spi_register_types(void)
+{
+    type_register_static(&neorv32_spi_type_info);
+}
+
+type_init(neorv32_spi_register_types)
+
+
+
+NEORV32SPIState *neorv32_spi_create(MemoryRegion *sys_mem, hwaddr base_addr)
+{
+    /* Allocate and initialize the SPI state object */
+    NEORV32SPIState *s = g_new0(NEORV32SPIState, 1);
+    object_initialize(&s->parent_obj, sizeof(*s), TYPE_NEORV32_SPI);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(&s->parent_obj);
+
+    /* Realize the SPI controller (sets up mmio, irq, SSI bus, cs_lines) */
+    sysbus_realize_and_unref(sbd, &error_fatal);
+
+    /* Map the MMIO region into the system address space */
+    sysbus_mmio_map(sbd, 0, base_addr);
+
+    /* Attach an SPI flash to SPI0 if a drive image is provided */
+    DriveInfo *dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        /* Create the flash device and bind the MTD backend */
+        DeviceState *flash = qdev_new("n25q512a11");
+        qdev_prop_set_drive_err(flash, "drive",
+                                blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+
+        /* Realize flash on the same SSI bus created on  controller realize */
+        qdev_realize_and_unref(flash, BUS(s->bus), &error_fatal);
+
+        /* Retrieve and wire the flash's CS input line to CS0 output */
+        qemu_irq flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+        sysbus_connect_irq(sbd, 1, flash_cs);
+    }
+
+    return s;
+}
+
diff --git a/include/hw/ssi/neorv32_spi.h b/include/hw/ssi/neorv32_spi.h
new file mode 100644
index 0000000000..8b94d2f1cf
--- /dev/null
+++ b/include/hw/ssi/neorv32_spi.h
@@ -0,0 +1,57 @@
+/*
+ * QEMU implementation of the Neorv32 SPI block.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef NEORV32_SPI_H
+#define NEORV32_SPI_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+
+#define TYPE_NEORV32_SPI "neorv32.spi"
+#define NEORV32_SPI(obj) OBJECT_CHECK(NEORV32SPIState, (obj), TYPE_NEORV32_SPI)
+
+typedef struct  NEORV32SPIState {
+    SysBusDevice parent_obj;
+
+    /* Memory-mapped registers */
+    MemoryRegion mmio;
+
+    /* IRQ line */
+    qemu_irq irq;
+
+    /* SPI bus (master) */
+    SSIBus *bus;
+
+    /* Chip selects (assume up to 3 CS lines) */
+    qemu_irq *cs_lines;
+    uint32_t num_cs;
+
+    /*
+     * Registers:
+     * Assume:
+     * 0x00: CTRL (r/w)
+     * 0x04: DATA (r/w)
+     */
+    uint32_t ctrl;
+    uint32_t data;
+
+    /* FIFOs */
+    Fifo8 tx_fifo;
+    Fifo8 rx_fifo;
+
+    /* FIFO capacity */
+    int fifo_capacity;
+    /* Track CS state driven by command writes */
+    bool cmd_cs_active;  /* true = CS asserted (active-low on wire) */
+    int  current_cs;     /* which CS line is active; default 0 for now */
+} NEORV32SPIState;
+
+
+
+NEORV32SPIState *neorv32_spi_create(MemoryRegion *sys_mem, hwaddr base_addr);
+
+#endif /* NEORV32_SPI_H */
-- 
2.51.1


