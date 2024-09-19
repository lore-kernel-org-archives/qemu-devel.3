Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A74CF3975
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srP7x-0004R0-Ca; Thu, 19 Sep 2024 17:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1srP7r-0004MV-8C; Thu, 19 Sep 2024 17:55:47 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1srP7n-0005fd-Tb; Thu, 19 Sep 2024 17:55:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5365c512b00so1673665e87.3; 
 Thu, 19 Sep 2024 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726782940; x=1727387740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wOZKPsLQhjVmA/ktzeb0fPOUMvgu/CM8Woz9bkG0fLo=;
 b=mayIddGtLnZreae7nJyp5yKi2K0cOnzb+5e+zB9EO8rReM/D9raRM0Hd0OFvO6QQ15
 XSGtsmeVY3ffBThkvqPgHKjQbYRRsdVVMDHfy2LhPlACKtdR3EZWwSXivm8OOdPEunn6
 iHuO5ROiW0fh/7wJjVOrHV1RlJNiFdmnf5xSobG3BLZn5gEyvlUOyKzHfT7Adc7jDbRK
 +qAddzJPWW4YNUNnBcwgf96X79IWS/Hk1cM2F0mPZeQVsKjRKuPKl24X8MW2FR6PJZxj
 DN3A+QTT4dYr1LLBcIwfhNNZopLhfCGLahUDXtGaoeFtpI9HrPoylrfVDA8tqGN0cerQ
 paIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726782940; x=1727387740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOZKPsLQhjVmA/ktzeb0fPOUMvgu/CM8Woz9bkG0fLo=;
 b=XHLVL0DRObLiJDHtX8ScYztCGR1xdcoJisiWL+2kTpxul6GkyR0a/aZBDLr6ZqZmQd
 PCzzJ5/lf8gcFcAk4TvDgOhrFUp0I9/OgxHU+aFhyjvFOdMKZLOWW/nrGUwtfxhFBkGQ
 AX8KPJBJNAAOCF7V9WLVrZxummjdJgy4QQHrLEx/R/EpaHWHQu3hBMLIATuY/3kAqs6U
 8Ek8vSNnoRb13TylelofKokmAt9msrAq5z6O1XLOFmwodlIqiIwx36XvFVQpWyJb80h6
 lTxWJ9kOHRSRqMWIZzP2gOvuOJsfgBs0oPteGhneyJKYNSJE8jc5piNrRT4Kse0FkoxL
 Os3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWnbNRP18R3NYHPwCzNWEyTgS3T5aI1BaKI3kUZ/Le0hM1up/fGhJe2VNrFRz34LI238N9+SuPNw==@nongnu.org
X-Gm-Message-State: AOJu0YyxslHa2MyI6vkc1mumI3gXJB32J0X2U5masyOzi48cDEsXADoa
 7P6JWd0m4Cxqw2gBkxiRddpy4PxZAij6DTeCrDm4Dq+JXShFsiCj
X-Google-Smtp-Source: AGHT+IEAA3ioSzUteAExRibm369IPZR1jyIU5QA/dtudZlbdgC+HpVPAKAqwe6jw9wZk0vddqxGFcQ==
X-Received: by 2002:a05:6512:32c8:b0:536:54db:ddd0 with SMTP id
 2adb3069b0e04-536ac179fdamr495126e87.0.1726782939435; 
 Thu, 19 Sep 2024 14:55:39 -0700 (PDT)
Received: from penguin.lxd (c-d17271d5.018-186-73746f22.bbcust.telenor.se.
 [213.113.114.209]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870969e7sm1940056e87.123.2024.09.19.14.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 14:55:38 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH] {hw/ssi,docs/system/arm}: Allwinner A10 SPI emulation
Date: Thu, 19 Sep 2024 23:55:25 +0200
Message-Id: <20240919215525.22398-1-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x12c.google.com
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
byte-wide CPU access (no DMA) to the peripheral, the emulated
controller does not implement DMA control and supports only byte-wide
access.

Docs are also updated for Cubieboard to indicate SPI availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 docs/system/arm/cubieboard.rst     |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/arm/allwinner-a10.c             |   8 +
 hw/ssi/Kconfig                     |   4 +
 hw/ssi/allwinner-a10-spi.c         | 534 +++++++++++++++++++++++++++++
 hw/ssi/meson.build                 |   1 +
 hw/ssi/trace-events                |  10 +
 include/hw/arm/allwinner-a10.h     |   2 +
 include/hw/ssi/allwinner-a10-spi.h |  56 +++
 9 files changed, 617 insertions(+)
 create mode 100644 hw/ssi/allwinner-a10-spi.c
 create mode 100644 include/hw/ssi/allwinner-a10-spi.h

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 58c4a2d3ea..90d24c73a1 100644
--- a/docs/system/arm/cubieboard.rst
+++ b/docs/system/arm/cubieboard.rst
@@ -15,4 +15,5 @@ Emulated devices:
 - USB controller
 - SATA controller
 - TWI (I2C) controller
+- SPI controller
 - Watchdog timer
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..933b0a059c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -398,6 +398,7 @@ config ALLWINNER_A10
     select ALLWINNER_WDT
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
+    select ALLWINNER_A10_SPI
     select AXP2XX_PMU
     select SERIAL
     select UNIMP
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 57d5d80159..30852dd038 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -35,6 +35,7 @@
 #define AW_A10_PIC_REG_BASE     0x01c20400
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
+#define AW_A10_SPI0_BASE        0x01c05000
 #define AW_A10_EMAC_BASE        0x01c0b000
 #define AW_A10_EHCI_BASE        0x01c14000
 #define AW_A10_OHCI_BASE        0x01c14400
@@ -80,6 +81,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "i2c0", &s->i2c0, TYPE_AW_I2C);
 
+    object_initialize_child(obj, "spi0", &s->spi0, TYPE_AW_A10_SPI);
+
     for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -195,6 +198,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c0), 0, AW_A10_I2C0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c0), 0, qdev_get_gpio_in(dev, 7));
 
+    /* SPI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->spi0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0, AW_A10_SPI0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi0), 0, qdev_get_gpio_in(dev, 10));
+
     /* WDT */
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
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
index 0000000000..ea44ae46a3
--- /dev/null
+++ b/hw/ssi/allwinner-a10-spi.c
@@ -0,0 +1,534 @@
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
+ * SPDX-License-Identifier: MIT
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
+#define SPI_CTL_SS_SHIFT (12)
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
+#define SPI_CTL_MASK     (0xFFFFFu)
+#define SPI_CTL_RESET    (0x0002001Cu)
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
+#define SPI_INTCTL_MASK               (0x37F7Fu)
+#define SPI_INTCTL_RESET              (0)
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
+#define SPI_INT_STA_MASK    (0x80037F7Fu)
+#define SPI_INT_STA_RESET   (0x00001B00u)
+
+/* DMA control register - not implemented */
+#define SPI_DMACTL_RESET (0)
+
+/* Wait clock register */
+#define SPI_WAIT_REG_WCC_MASK (0xFFFFu)
+#define SPI_WAIT_RESET        (0)
+
+/* Clock control register - not implemented */
+#define SPI_CCTL_RESET (2)
+
+/* Burst count register */
+#define SPI_BC_BC_MASK (0xFFFFFFu)
+#define SPI_BC_RESET   (0)
+
+/* Transmi counter register */
+#define SPI_TC_WTC_MASK (0xFFFFFFu)
+#define SPI_TC_RESET    (0)
+
+/* FIFO status register */
+#define SPI_FIFO_STA_CNT_MASK     (0x7F)
+#define SPI_FIFO_STA_TF_CNT_SHIFT (16)
+#define SPI_FIFO_STA_RF_CNT_SHIFT (0)
+#define SPI_FIFO_STA_RESET        (0)
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
+    int level;
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
+    level = s->regs[REG_INDEX(SPI_INT_STA_REG)] &
+                    s->regs[REG_INDEX(SPI_INTCTL_REG)] ?
+                1 :
+                0;
+
+    qemu_set_irq(s->irq, level);
+
+    trace_allwinner_a10_spi_update_irq(level);
+}
+
+static void allwinner_a10_spi_flush_txfifo(AWA10SPIState *s)
+{
+    uint8_t tx;
+    uint8_t rx;
+    uint32_t burst_count = s->regs[REG_INDEX(SPI_BC_REG)];
+    uint32_t tx_burst = s->regs[REG_INDEX(SPI_TC_REG)];
+    trace_allwinner_a10_spi_burst_length(tx_burst);
+
+    trace_allwinner_a10_spi_flush_txfifo_begin(fifo8_num_used(&s->tx_fifo),
+                                               fifo8_num_used(&s->rx_fifo));
+
+    while (!fifo8_is_empty(&s->tx_fifo)) {
+        tx = fifo8_pop(&s->tx_fifo);
+        rx = 0;
+        bool fill_rx = true;
+
+        trace_allwinner_a10_spi_tx(tx);
+
+        /* Write one byte at a time */
+        rx = ssi_transfer(s->bus, tx);
+
+        trace_allwinner_a10_spi_rx(rx);
+
+        /* Check DHB here to determing if RX bytes should be stored */
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
+        default:
+            break;
+        }
+
+        allwinner_a10_spi_update_irq(s);
+    }
+    trace_allwinner_a10_spi_read(allwinner_a10_spi_get_regname(offset), value);
+
+    return (uint64_t)value;
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
+                i == allwinner_a10_spi_selected_channel(s) ?
+                    !!(s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SS_LEVEL) :
+                    !(s->regs[REG_INDEX(SPI_CTL_REG)] & SPI_CTL_SSPOL));
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
+    default:
+        s->regs[index] = value;
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
+    .fields =
+        (const VMStateField[]){
+            VMSTATE_FIFO8(tx_fifo, AWA10SPIState),
+            VMSTATE_FIFO8(rx_fifo, AWA10SPIState),
+            VMSTATE_UINT32_ARRAY(regs, AWA10SPIState, AW_A10_SPI_REGS_NUM),
+            VMSTATE_END_OF_LIST() }
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
index 089d269994..6c81d0b291 100644
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
+allwinner_a10_spi_read(const char* regname, uint32_t value) "reg[%s] => 0x%" PRIx32
+allwinner_a10_spi_write(const char* regname, uint32_t value) "reg[%s] <= 0x%" PRIx32
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 67a9a17b86..e5815b0d12 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,6 +12,7 @@
 #include "hw/misc/allwinner-a10-ccm.h"
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
+#include "hw/ssi/allwinner-a10-spi.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "sysemu/block-backend.h"
 
@@ -40,6 +41,7 @@ struct AwA10State {
     AllwinnerAHCIState sata;
     AwSdHostState mmc0;
     AWI2CState i2c0;
+    AWA10SPIState spi0;
     AwRtcState rtc;
     AwWdtState wdt;
     MemoryRegion sram_a;
diff --git a/include/hw/ssi/allwinner-a10-spi.h b/include/hw/ssi/allwinner-a10-spi.h
new file mode 100644
index 0000000000..01ddbf74ab
--- /dev/null
+++ b/include/hw/ssi/allwinner-a10-spi.h
@@ -0,0 +1,56 @@
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


