Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FCCF318A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 22:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svl8V-0006qv-GN; Tue, 01 Oct 2024 18:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svl8P-0006m9-QY; Tue, 01 Oct 2024 18:14:21 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svl8M-0002VY-Qv; Tue, 01 Oct 2024 18:14:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53993564cb1so3375406e87.2; 
 Tue, 01 Oct 2024 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727820856; x=1728425656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pd0wEecK1Gqzc+b8D6a/6uJbyO5yZ2eQeNR5911Ksvo=;
 b=nh4a2ZytkmL/rm1JF5/lgQSGJ6p6vk2wTeTKpfjqXJuxNEn20JBdz+qHgoYY85JTHw
 FLFlTu5bV3T2S8sKkSLauNj7PThnCaJCxY2qguPnespJ3oIPc6aebnw9jIMAxfVaW6/T
 edPKSELgqB2Njlp8zE/iEgAvLklM0Nwt6BxsFE5rpAtmHIMtb96G+IKSDj+J1XOqY1rC
 Ks3i3/B4GKz2bGY2HZyk4PbxiEFc45/8BjVYrqHXmMHG2RLjKzk7/Qcax5+I2Uy/ms5z
 MOQSEhc4tVA+TueQJQeEjXdT0VaeIWRCVgWjYdxx11LSJ943wNA7RG2LA1nswzjBD/hd
 Bxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727820856; x=1728425656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pd0wEecK1Gqzc+b8D6a/6uJbyO5yZ2eQeNR5911Ksvo=;
 b=qvTOB3lHEMtbxuoVIOKJ2rex9tFB0JOldZpxNSuTrtRyccEGfPcb3Jl5rM4HAe1Yh/
 c0eIs57xDYPGoPVC/KVdga8x/7a/JYrSYxWi+o2C+x6mMTaZh21dJFKEypjDhRDMG5Pv
 edax/YdunNWk+qSUay5uoM38buDqFVKhsTu4pAyEvQ+EaGmdUDARv9lnb4PYnL+abd4s
 3c/gvSUPv/6VYI8VpuIqbvXNh2jUPCgwVfghEPGHTRbYMDwMyvj6UUP4EwzCPBttMR3N
 JvTYWeyXebSSnRwncuxLV9X1N8mTD4GRe+QXed2/IrjApJCgNKxOJ4vK0Dde0oLlN2PF
 0l4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJOPIToH0fyX6P73Px6J5HyV7oYUUpT7cm0efcPM8M7HWXUqWREoCiQFf4AaazwJM7O0+TbQ2krw==@nongnu.org
X-Gm-Message-State: AOJu0Yxkz2Ermnm+v4uHld8RgnPip9DvUbR24CqX0THAJwuVJfRZEatv
 Spohlt2ha5SHoFqixifHP1x/GCIhCDYkCyjwf8lnb1/LegA1k6ra
X-Google-Smtp-Source: AGHT+IEBAMBLLd7GJbaK77NQaPVKl7Vs3difyATN3pUzQ5Eh2qApoAieOWASaljVoIJ5fp8XAg+yFA==
X-Received: by 2002:a05:6512:1247:b0:539:9f70:b01d with SMTP id
 2adb3069b0e04-539a067ae27mr579581e87.26.1727820855307; 
 Tue, 01 Oct 2024 15:14:15 -0700 (PDT)
Received: from penguin.lxd (c-d17271d5.018-186-73746f22.bbcust.telenor.se.
 [213.113.114.209]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53992ca4683sm964813e87.124.2024.10.01.15.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 15:14:14 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH v2 1/2] hw/ssi: Allwinner A10 SPI emulation
Date: Wed,  2 Oct 2024 00:13:48 +0200
Message-Id: <20241001221349.8319-2-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
References: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch implements Allwinner A10 SPI controller emulation.
Only master-mode functionality is implemented.

Since U-Boot and Linux SPI drivers for Allwinner A10 perform only
byte-wide CPU access (no DMA) to the transmit and receive registers of
the peripheral, the emulated controller does not implement DMA control,
and supports only byte-wide access to transmit and receive registers
(half-word and word accesses will be treated as byte accesses).

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/ssi/Kconfig                     |   4 +
 hw/ssi/allwinner-a10-spi.c         | 561 +++++++++++++++++++++++++++++
 hw/ssi/meson.build                 |   1 +
 hw/ssi/trace-events                |  10 +
 include/hw/ssi/allwinner-a10-spi.h |  57 +++
 5 files changed, 633 insertions(+)
 create mode 100644 hw/ssi/allwinner-a10-spi.c
 create mode 100644 include/hw/ssi/allwinner-a10-spi.h

diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 8d180de7cf..1bd56463c1 100644
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
diff --git a/hw/ssi/allwinner-a10-spi.c b/hw/ssi/allwinner-a10-spi.c
new file mode 100644
index 0000000000..3eb50b44ac
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
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index b7ad7fca3b..0fb0b68617 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_ALLWINNER_A10_SPI', if_true: files('allwinner-a10-spi.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_fiu.c', 'npcm_pspi.c'))
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 089d269994..2f36cf96b8 100644
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
diff --git a/include/hw/ssi/allwinner-a10-spi.h b/include/hw/ssi/allwinner-a10-spi.h
new file mode 100644
index 0000000000..da46e29a27
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
-- 
2.39.5


