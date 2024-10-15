Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECBDCFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ews-0006jx-85; Tue, 15 Oct 2024 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewX-0006fL-0E
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0005wG-O6
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso1687208e87.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988695; x=1729593495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NV8FrfPKy1rST641Beu5x0DD2xYERXJgKbZNb3mL5SE=;
 b=cHUCnObe5nuGW5vZjnt3cG3I83ZZ6goWUMJd8cEJKjDHoTcRBO2Cfba2U5L417ryLJ
 tjbRX+WG+pKJpdlafRNhhxsRgLU8v3vcbtQ2T6+I7ZSMGbwQJb6rSreovMXzqZoVZVli
 TrXR05f+BtKCcDMUiLKzUAAOEGnB3VK+UHbuluh8Of9fSdnJoNFZl8YMWCsVW388PLQD
 66KbhcxM3u8RbeEbtHA9UxLCaVHUs3xQ714BhakQNAuPV0J9/rn+t6DH1EbBq71RoJBG
 b5dfXLq72ZdTJ1adKiBrsjnLpClvebThD5GqvjP7+UaZskgdsleTJccgJt20CBKCe0F1
 beHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988695; x=1729593495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NV8FrfPKy1rST641Beu5x0DD2xYERXJgKbZNb3mL5SE=;
 b=lGCNUzd8afz+f9VJnsQBv1Xc1edq3XtKWjqgUL9jlQgpV+uUJmvPkQnkSIptg2azbV
 cqAQeqOiF0bNukt2OmaX1763oN9JgneFdiRedYkY0lkWfelI+OB54qEdws8pxLom1KBL
 Ln8txZVZ5r9OBUlA0qTd70o1beyO0B9Tn5PBC/hbDZRJuJCCsWZaYMRlNjC8vJrYdtgF
 z2F1OazpntWGAJ6TmUX0ULbfLv7cHB6WA6KdOPkr7RGFtImjdsY0BSD9UcfK4L3GbgXg
 ILtALQsuNXWlOM3N4JVRhM8WqSij1EVRfetorQK7lQx03c5xcj/VstOXClBzK1cPY2up
 D9tg==
X-Gm-Message-State: AOJu0YxcjR06xXN7uPprSsNn6N31CRQKDJqvpNif+4Y03rg16v6eXW6P
 Br6u0PkZJgffVBQmLIrPmV4v/UKyYSJss/c4Vf5qO0kD7D1O2CZ1P7vz8wrWJTnCId4z5jEZUmv
 T
X-Google-Smtp-Source: AGHT+IGAZcvNlm04dAFIccP2+zNWjPZmX0XiBqr0T05vrrOtjJ4yLYA8mAUwSeh9b73dA1nxfuL0xw==
X-Received: by 2002:a05:6512:685:b0:539:d1d4:9c3b with SMTP id
 2adb3069b0e04-539da3c5e45mr6801501e87.14.1728988694555; 
 Tue, 15 Oct 2024 03:38:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/28] hw/ssi: Allwinner A10 SPI emulation
Date: Tue, 15 Oct 2024 11:37:50 +0100
Message-Id: <20241015103808.133024-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

From: Strahinja Jankovic <strahinjapjankovic@gmail.com>

This patch implements Allwinner A10 SPI controller emulation.
Only master-mode functionality is implemented.

Since U-Boot and Linux SPI drivers for Allwinner A10 perform only
byte-wide CPU access (no DMA) to the transmit and receive registers of
the peripheral, the emulated controller does not implement DMA control,
and supports only byte-wide access to transmit and receive registers
(half-word and word accesses will be treated as byte accesses).

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20241001221349.8319-2-strahinja.p.jankovic@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/allwinner-a10-spi.h |  57 +++
 hw/ssi/allwinner-a10-spi.c         | 561 +++++++++++++++++++++++++++++
 hw/ssi/Kconfig                     |   4 +
 hw/ssi/meson.build                 |   1 +
 hw/ssi/trace-events                |  10 +
 5 files changed, 633 insertions(+)
 create mode 100644 include/hw/ssi/allwinner-a10-spi.h
 create mode 100644 hw/ssi/allwinner-a10-spi.c

diff --git a/include/hw/ssi/allwinner-a10-spi.h b/include/hw/ssi/allwinner-a10-spi.h
new file mode 100644
index 00000000000..da46e29a278
--- /dev/null
+++ b/include/hw/ssi/allwinner-a10-spi.h
@@ -0,0 +1,57 @@
+/*
+ *  Allwinner SPI Bus Serial Interface registers definition
+ *
+ *  Copyright (C) 2024 Strahinja Jankovic. <strahinja.p.jankovic@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ALLWINNER_A10_SPI_H
+#define ALLWINNER_A10_SPI_H
+
+#include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
+#include "qemu/fifo8.h"
+#include "qom/object.h"
+
+/** Size of register I/O address space used by SPI device */
+#define AW_A10_SPI_IOSIZE (0x1000)
+
+/** Total number of known registers */
+#define AW_A10_SPI_REGS_NUM    (AW_A10_SPI_IOSIZE / sizeof(uint32_t))
+#define AW_A10_SPI_FIFO_SIZE   (64)
+#define AW_A10_SPI_CS_LINES_NR (4)
+
+#define TYPE_AW_A10_SPI        "allwinner.spi"
+OBJECT_DECLARE_SIMPLE_TYPE(AWA10SPIState, AW_A10_SPI)
+
+struct AWA10SPIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    SSIBus *bus;
+    qemu_irq irq;
+    qemu_irq cs_lines[AW_A10_SPI_CS_LINES_NR];
+
+    uint32_t regs[AW_A10_SPI_REGS_NUM];
+
+    Fifo8 rx_fifo;
+    Fifo8 tx_fifo;
+};
+
+#endif /* ALLWINNER_A10_SPI_H */
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
new file mode 100644
index 00000000000..3eb50b44ac5
--- /dev/null
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -0,0 +1,561 @@
+/*
+ *  Allwinner SPI Bus Serial Interface Emulation
+ *
+ *  Copyright (C) 2024 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/ssi/allwinner-a10-spi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+/* Allwinner SPI memory map */
+#define SPI_RXDATA_REG   0x00 /* receive data register */
+#define SPI_TXDATA_REG   0x04 /* transmit data register */
+#define SPI_CTL_REG      0x08 /* control register */
+#define SPI_INTCTL_REG   0x0c /* interrupt control register */
+#define SPI_INT_STA_REG  0x10 /* interrupt status register */
+#define SPI_DMACTL_REG   0x14 /* DMA control register */
+#define SPI_WAIT_REG     0x18 /* wait clock counter register */
+#define SPI_CCTL_REG     0x1c /* clock rate control register */
+#define SPI_BC_REG       0x20 /* burst control register */
+#define SPI_TC_REG       0x24 /* transmit counter register */
+#define SPI_FIFO_STA_REG 0x28 /* FIFO status register */
+
+/* Data register */
+#define SPI_DATA_RESET 0
+
+/* Control register */
+#define SPI_CTL_SDC      (1 << 19)
+#define SPI_CTL_TP_EN    (1 << 18)
+#define SPI_CTL_SS_LEVEL (1 << 17)
+#define SPI_CTL_SS_CTRL  (1 << 16)
+#define SPI_CTL_DHB      (1 << 15)
+#define SPI_CTL_DDB      (1 << 14)
+#define SPI_CTL_SS       (3 << 12)
+#define SPI_CTL_SS_SHIFT 12
+#define SPI_CTL_RPSM     (1 << 11)
+#define SPI_CTL_XCH      (1 << 10)
+#define SPI_CTL_RF_RST   (1 << 9)
+#define SPI_CTL_TF_RST   (1 << 8)
+#define SPI_CTL_SSCTL    (1 << 7)
+#define SPI_CTL_LMTF     (1 << 6)
+#define SPI_CTL_DMAMC    (1 << 5)
+#define SPI_CTL_SSPOL    (1 << 4)
+#define SPI_CTL_POL      (1 << 3)
+#define SPI_CTL_PHA      (1 << 2)
+#define SPI_CTL_MODE     (1 << 1)
+#define SPI_CTL_EN       (1 << 0)
+#define SPI_CTL_MASK     0xFFFFFu
+#define SPI_CTL_RESET    0x0002001Cu
+
+/* Interrupt control register */
+#define SPI_INTCTL_SS_INT_EN          (1 << 17)
+#define SPI_INTCTL_TX_INT_EN          (1 << 16)
+#define SPI_INTCTL_TF_UR_INT_EN       (1 << 14)
+#define SPI_INTCTL_TF_OF_INT_EN       (1 << 13)
+#define SPI_INTCTL_TF_E34_INT_EN      (1 << 12)
+#define SPI_INTCTL_TF_E14_INT_EN      (1 << 11)
+#define SPI_INTCTL_TF_FL_INT_EN       (1 << 10)
+#define SPI_INTCTL_TF_HALF_EMP_INT_EN (1 << 9)
+#define SPI_INTCTL_TF_EMP_INT_EN      (1 << 8)
+#define SPI_INTCTL_RF_UR_INT_EN       (1 << 6)
+#define SPI_INTCTL_RF_OF_INT_EN       (1 << 5)
+#define SPI_INTCTL_RF_E34_INT_EN      (1 << 4)
+#define SPI_INTCTL_RF_E14_INT_EN      (1 << 3)
+#define SPI_INTCTL_RF_FU_INT_EN       (1 << 2)
+#define SPI_INTCTL_RF_HALF_FU_INT_EN  (1 << 1)
+#define SPI_INTCTL_RF_RDY_INT_EN      (1 << 0)
+#define SPI_INTCTL_MASK               0x37F7Fu
+#define SPI_INTCTL_RESET              0
+
+/* Interrupt status register */
+#define SPI_INT_STA_INT_CBF (1 << 31)
+#define SPI_INT_STA_SSI     (1 << 17)
+#define SPI_INT_STA_TC      (1 << 16)
+#define SPI_INT_STA_TU      (1 << 14)
+#define SPI_INT_STA_TO      (1 << 13)
+#define SPI_INT_STA_TE34    (1 << 12)
+#define SPI_INT_STA_TE14    (1 << 11)
+#define SPI_INT_STA_TF      (1 << 10)
+#define SPI_INT_STA_THE     (1 << 9)
+#define SPI_INT_STA_TE      (1 << 8)
+#define SPI_INT_STA_RU      (1 << 6)
+#define SPI_INT_STA_RO      (1 << 5)
+#define SPI_INT_STA_RF34    (1 << 4)
+#define SPI_INT_STA_RF14    (1 << 3)
+#define SPI_INT_STA_RF      (1 << 2)
+#define SPI_INT_STA_RHF     (1 << 1)
+#define SPI_INT_STA_RR      (1 << 0)
+#define SPI_INT_STA_MASK    0x80037F7Fu
+#define SPI_INT_STA_RESET   0x00001B00u
+
+/* DMA control register - not implemented */
+#define SPI_DMACTL_RESET 0
+
+/* Wait clock register */
+#define SPI_WAIT_REG_WCC_MASK 0xFFFFu
+#define SPI_WAIT_RESET        0
+
+/* Clock control register - not implemented */
+#define SPI_CCTL_RESET 2
+
+/* Burst count register */
+#define SPI_BC_BC_MASK 0xFFFFFFu
+#define SPI_BC_RESET   0
+
+/* Transmi counter register */
+#define SPI_TC_WTC_MASK 0xFFFFFFu
+#define SPI_TC_RESET    0
+
+/* FIFO status register */
+#define SPI_FIFO_STA_CNT_MASK     0x7F
+#define SPI_FIFO_STA_TF_CNT_SHIFT 16
+#define SPI_FIFO_STA_RF_CNT_SHIFT 0
+#define SPI_FIFO_STA_RESET        0
+
+#define REG_INDEX(offset)         (offset / sizeof(uint32_t))
+
+
+static const char *allwinner_a10_spi_get_regname(unsigned offset)
+{
+    switch (offset) {
+    case SPI_RXDATA_REG:
+        return "RXDATA";
+    case SPI_TXDATA_REG:
+        return "TXDATA";
+    case SPI_CTL_REG:
+        return "CTL";
+    case SPI_INTCTL_REG:
+        return "INTCTL";
+    case SPI_INT_STA_REG:
+        return "INT_STA";
+    case SPI_DMACTL_REG:
+        return "DMACTL";
+    case SPI_WAIT_REG:
+        return "WAIT";
+    case SPI_CCTL_REG:
+        return "CCTL";
+    case SPI_BC_REG:
+        return "BC";
+    case SPI_TC_REG:
+        return "TC";
+    case SPI_FIFO_STA_REG:
+        return "FIFO_STA";
+    default:
+        return "[?]";
+    }
+}
+
+static bool allwinner_a10_spi_is_enabled(AWA10SPIState *s)
+{
+    return s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_EN;
+}
+
+static void allwinner_a10_spi_txfifo_reset(AWA10SPIState *s)
+{
+    fifo8_reset(&s->tx_fifo);
+    s->regs[REG_INDEX(SPI_INT_STA_REG)] |= (SPI_INT_STA_TE | SPI_INT_STA_TE14 |
+                                            SPI_INT_STA_THE | SPI_INT_STA_TE34);
+    s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~(SPI_INT_STA_TU | SPI_INT_STA_TO);
+}
+
+static void allwinner_a10_spi_rxfifo_reset(AWA10SPIState *s)
+{
+    fifo8_reset(&s->rx_fifo);
+    s->regs[REG_INDEX(SPI_INT_STA_REG)] &=
+        ~(SPI_INT_STA_RU | SPI_INT_STA_RO | SPI_INT_STA_RF | SPI_INT_STA_RR |
+          SPI_INT_STA_RHF | SPI_INT_STA_RF14 | SPI_INT_STA_RF34);
+}
+
+static uint8_t allwinner_a10_spi_selected_channel(AWA10SPIState *s)
+{
+    return (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SS) >> SPI_CTL_SS_SHIFT;
+}
+
+static void allwinner_a10_spi_reset_hold(Object *obj, ResetType type)
+{
+    AWA10SPIState *s = AW_A10_SPI(obj);
+
+    s->regs[REG_INDEX(SPI_RXDATA_REG)] = SPI_DATA_RESET;
+    s->regs[REG_INDEX(SPI_TXDATA_REG)] = SPI_DATA_RESET;
+    s->regs[REG_INDEX(SPI_CTL_REG)] = SPI_CTL_RESET;
+    s->regs[REG_INDEX(SPI_INTCTL_REG)] = SPI_INTCTL_RESET;
+    s->regs[REG_INDEX(SPI_INT_STA_REG)] = SPI_INT_STA_RESET;
+    s->regs[REG_INDEX(SPI_DMACTL_REG)] = SPI_DMACTL_RESET;
+    s->regs[REG_INDEX(SPI_WAIT_REG)] = SPI_WAIT_RESET;
+    s->regs[REG_INDEX(SPI_CCTL_REG)] = SPI_CCTL_RESET;
+    s->regs[REG_INDEX(SPI_BC_REG)] = SPI_BC_RESET;
+    s->regs[REG_INDEX(SPI_TC_REG)] = SPI_TC_RESET;
+    s->regs[REG_INDEX(SPI_FIFO_STA_REG)] = SPI_FIFO_STA_RESET;
+
+    allwinner_a10_spi_txfifo_reset(s);
+    allwinner_a10_spi_rxfifo_reset(s);
+}
+
+static void allwinner_a10_spi_update_irq(AWA10SPIState *s)
+{
+    bool level;
+
+    if (fifo8_is_empty(&s->rx_fifo)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_RR;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RR;
+    }
+
+    if (fifo8_num_used(&s->rx_fifo) >= (AW_A10_SPI_FIFO_SIZE >> 2)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RF14;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_RF14;
+    }
+
+    if (fifo8_num_used(&s->rx_fifo) >= (AW_A10_SPI_FIFO_SIZE >> 1)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RHF;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_RHF;
+    }
+
+    if (fifo8_num_free(&s->rx_fifo) <= (AW_A10_SPI_FIFO_SIZE >> 2)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RF34;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_RF34;
+    }
+
+    if (fifo8_is_full(&s->rx_fifo)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RF;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_RF;
+    }
+
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TE;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_TE;
+    }
+
+    if (fifo8_num_free(&s->tx_fifo) >= (AW_A10_SPI_FIFO_SIZE >> 2)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TE14;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_TE14;
+    }
+
+    if (fifo8_num_free(&s->tx_fifo) >= (AW_A10_SPI_FIFO_SIZE >> 1)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_THE;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_THE;
+    }
+
+    if (fifo8_num_used(&s->tx_fifo) <= (AW_A10_SPI_FIFO_SIZE >> 2)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TE34;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_TE34;
+    }
+
+    if (fifo8_is_full(&s->rx_fifo)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TF;
+    } else {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~SPI_INT_STA_TF;
+    }
+
+    level = (s->regs[REG_INDEX(SPI_INT_STA_REG)] &
+             s->regs[REG_INDEX(SPI_INTCTL_REG)]) != 0;
+
+    qemu_set_irq(s->irq, level);
+
+    trace_allwinner_a10_spi_update_irq(level);
+}
+
+static void allwinner_a10_spi_flush_txfifo(AWA10SPIState *s)
+{
+    uint32_t burst_count = s->regs[REG_INDEX(SPI_BC_REG)];
+    uint32_t tx_burst = s->regs[REG_INDEX(SPI_TC_REG)];
+    trace_allwinner_a10_spi_burst_length(tx_burst);
+
+    trace_allwinner_a10_spi_flush_txfifo_begin(fifo8_num_used(&s->tx_fifo),
+                                               fifo8_num_used(&s->rx_fifo));
+
+    while (!fifo8_is_empty(&s->tx_fifo)) {
+        uint8_t tx = fifo8_pop(&s->tx_fifo);
+        uint8_t rx = 0;
+        bool fill_rx = true;
+
+        trace_allwinner_a10_spi_tx(tx);
+
+        /* Write one byte at a time */
+        rx = ssi_transfer(s->bus, tx);
+
+        trace_allwinner_a10_spi_rx(rx);
+
+        /* Check DHB here to determine if RX bytes should be stored */
+        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_DHB) {
+            /* Store rx bytes only after WTC transfers */
+            if (tx_burst > 0u) {
+                fill_rx = false;
+                tx_burst--;
+            }
+        }
+
+        if (fill_rx) {
+            if (fifo8_is_full(&s->rx_fifo)) {
+                s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_RF;
+            } else {
+                fifo8_push(&s->rx_fifo, rx);
+            }
+        }
+
+        allwinner_a10_spi_update_irq(s);
+
+        burst_count--;
+
+        if (burst_count == 0) {
+            s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TC;
+            s->regs[REG_INDEX(SPI_CTL_REG)] &= ~SPI_CTL_XCH;
+            break;
+        }
+    }
+
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] |= SPI_INT_STA_TC;
+        s->regs[REG_INDEX(SPI_CTL_REG)] &= ~SPI_CTL_XCH;
+    }
+
+    trace_allwinner_a10_spi_flush_txfifo_end(fifo8_num_used(&s->tx_fifo),
+                                             fifo8_num_used(&s->rx_fifo));
+}
+
+static uint64_t allwinner_a10_spi_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    uint32_t value = 0;
+    AWA10SPIState *s = opaque;
+    uint32_t index = offset >> 2;
+
+    if (offset > SPI_FIFO_STA_REG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[%s]%s: Bad register at offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_AW_A10_SPI, __func__, offset);
+        return 0;
+    }
+
+    value = s->regs[index];
+
+    if (allwinner_a10_spi_is_enabled(s)) {
+        switch (offset) {
+        case SPI_RXDATA_REG:
+            if (fifo8_is_empty(&s->rx_fifo)) {
+                /* value is undefined */
+                value = 0xdeadbeef;
+            } else {
+                /* read from the RX FIFO */
+                value = fifo8_pop(&s->rx_fifo);
+            }
+            break;
+        case SPI_TXDATA_REG:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "[%s]%s: Trying to read from TX FIFO\n",
+                          TYPE_AW_A10_SPI, __func__);
+
+            /* Reading from TXDATA gives 0 */
+            break;
+        case SPI_FIFO_STA_REG:
+            /* Read current tx/rx fifo data count */
+            value = fifo8_num_used(&s->tx_fifo) << SPI_FIFO_STA_TF_CNT_SHIFT |
+                    fifo8_num_used(&s->rx_fifo) << SPI_FIFO_STA_RF_CNT_SHIFT;
+            break;
+        case SPI_CTL_REG:
+        case SPI_INTCTL_REG:
+        case SPI_INT_STA_REG:
+        case SPI_DMACTL_REG:
+        case SPI_WAIT_REG:
+        case SPI_CCTL_REG:
+        case SPI_BC_REG:
+        case SPI_TC_REG:
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                    "%s: bad offset 0x%x\n", __func__,
+                    (uint32_t)offset);
+            break;
+        }
+
+        allwinner_a10_spi_update_irq(s);
+    }
+    trace_allwinner_a10_spi_read(allwinner_a10_spi_get_regname(offset), value);
+
+    return value;
+}
+
+static bool allwinner_a10_spi_update_cs_level(AWA10SPIState *s, int cs_line_nr)
+{
+    if (cs_line_nr == allwinner_a10_spi_selected_channel(s)) {
+        return (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SS_LEVEL) != 0;
+    } else {
+        return (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SSPOL) != 0;
+    }
+}
+
+static void allwinner_a10_spi_write(void *opaque, hwaddr offset, uint64_t value,
+                                    unsigned size)
+{
+    AWA10SPIState *s = opaque;
+    uint32_t index = offset >> 2;
+    int i = 0;
+
+    if (offset > SPI_FIFO_STA_REG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[%s]%s: Bad register at offset 0x%" HWADDR_PRIx "\n",
+                      TYPE_AW_A10_SPI, __func__, offset);
+        return;
+    }
+
+    trace_allwinner_a10_spi_write(allwinner_a10_spi_get_regname(offset),
+                                  (uint32_t)value);
+
+    if (!allwinner_a10_spi_is_enabled(s)) {
+        /* Block is disabled */
+        if (offset != SPI_CTL_REG) {
+            /* Ignore access */
+            return;
+        }
+    }
+
+    switch (offset) {
+    case SPI_RXDATA_REG:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to write to RX FIFO\n",
+                      TYPE_AW_A10_SPI, __func__);
+        break;
+    case SPI_TXDATA_REG:
+        if (fifo8_is_full(&s->tx_fifo)) {
+            /* Ignore writes if queue is full */
+            break;
+        }
+
+        fifo8_push(&s->tx_fifo, (uint8_t)value);
+
+        break;
+    case SPI_INT_STA_REG:
+        /* Handle W1C bits - everything except SPI_INT_STA_INT_CBF. */
+        value &= ~SPI_INT_STA_INT_CBF;
+        s->regs[REG_INDEX(SPI_INT_STA_REG)] &= ~(value & SPI_INT_STA_MASK);
+        break;
+    case SPI_CTL_REG:
+        s->regs[REG_INDEX(SPI_CTL_REG)] = value;
+
+        for (i = 0; i < AW_A10_SPI_CS_LINES_NR; i++) {
+            qemu_set_irq(
+                s->cs_lines[i],
+                allwinner_a10_spi_update_cs_level(s, i));
+        }
+
+        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_XCH) {
+            /* Request to start emitting */
+            allwinner_a10_spi_flush_txfifo(s);
+        }
+        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_TF_RST) {
+            allwinner_a10_spi_txfifo_reset(s);
+            s->regs[REG_INDEX(SPI_CTL_REG)] &= ~SPI_CTL_TF_RST;
+        }
+        if (s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_RF_RST) {
+            allwinner_a10_spi_rxfifo_reset(s);
+            s->regs[REG_INDEX(SPI_CTL_REG)] &= ~SPI_CTL_RF_RST;
+        }
+        break;
+    case SPI_INTCTL_REG:
+    case SPI_DMACTL_REG:
+    case SPI_WAIT_REG:
+    case SPI_CCTL_REG:
+    case SPI_BC_REG:
+    case SPI_TC_REG:
+    case SPI_FIFO_STA_REG:
+        s->regs[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: bad offset 0x%x\n", __func__,
+            (uint32_t)offset);
+        break;
+    }
+
+    allwinner_a10_spi_update_irq(s);
+}
+
+static const MemoryRegionOps allwinner_a10_spi_ops = {
+    .read = allwinner_a10_spi_read,
+    .write = allwinner_a10_spi_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription allwinner_a10_spi_vmstate = {
+    .name = TYPE_AW_A10_SPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FIFO8(tx_fifo, AWA10SPIState),
+        VMSTATE_FIFO8(rx_fifo, AWA10SPIState),
+        VMSTATE_UINT32_ARRAY(regs, AWA10SPIState, AW_A10_SPI_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_a10_spi_realize(DeviceState *dev, Error **errp)
+{
+    AWA10SPIState *s = AW_A10_SPI(dev);
+    int i = 0;
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_a10_spi_ops, s,
+                          TYPE_AW_A10_SPI, AW_A10_SPI_IOSIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    s->bus = ssi_create_bus(dev, "spi");
+    for (i = 0; i < AW_A10_SPI_CS_LINES_NR; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->cs_lines[i]);
+    }
+    fifo8_create(&s->tx_fifo, AW_A10_SPI_FIFO_SIZE);
+    fifo8_create(&s->rx_fifo, AW_A10_SPI_FIFO_SIZE);
+}
+
+static void allwinner_a10_spi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = allwinner_a10_spi_reset_hold;
+    dc->vmsd = &allwinner_a10_spi_vmstate;
+    dc->realize = allwinner_a10_spi_realize;
+    dc->desc = "Allwinner A10 SPI Controller";
+}
+
+static const TypeInfo allwinner_a10_spi_type_info = {
+    .name = TYPE_AW_A10_SPI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AWA10SPIState),
+    .class_init = allwinner_a10_spi_class_init,
+};
+
+static void allwinner_a10_spi_register_types(void)
+{
+    type_register_static(&allwinner_a10_spi_type_info);
+}
+
+type_init(allwinner_a10_spi_register_types)
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 8d180de7cf2..1bd56463c1e 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -28,3 +28,7 @@ config BCM2835_SPI
 config PNV_SPI
     bool
     select SSI
+
+config ALLWINNER_A10_SPI
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 23cd425ab00..6afb1ea2001 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_ALLWINNER_A10_SPI', if_true: files('allwinner-a10-spi.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_fiu.c', 'npcm_pspi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 089d269994a..2f36cf96b8b 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -53,3 +53,13 @@ pnv_spi_rx_read_N2frame(void) ""
 pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x into RDR from payload index %d"
 pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
 pnv_spi_RDR_match(const char* result) "%s"
+
+# allwinner_a10_spi.c
+allwinner_a10_spi_update_irq(uint32_t level) "IRQ level is %d"
+allwinner_a10_spi_flush_txfifo_begin(uint32_t tx, uint32_t rx) "Begin: TX Fifo Size = %d, RX Fifo Size = %d"
+allwinner_a10_spi_flush_txfifo_end(uint32_t tx, uint32_t rx) "End: TX Fifo Size = %d, RX Fifo Size = %d"
+allwinner_a10_spi_burst_length(uint32_t len) "Burst length = %d"
+allwinner_a10_spi_tx(uint8_t byte) "write 0x%02x"
+allwinner_a10_spi_rx(uint8_t byte) "read 0x%02x"
+allwinner_a10_spi_read(const char* regname, uint32_t value) "reg[%s] => 0x%08x"
+allwinner_a10_spi_write(const char* regname, uint32_t value) "reg[%s] <= 0x%08x"
-- 
2.34.1


