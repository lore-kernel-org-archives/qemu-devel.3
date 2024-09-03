Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B0CD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW51-0006gf-ME; Tue, 03 Sep 2024 12:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4s-00063X-2i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4n-0002kx-6C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso48019965e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379695; x=1725984495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IiCawLw2POwTZcTTAV1P3hhlN4KcpW1sTG7Gg9YSIJ8=;
 b=E71722J+A2oxs2CDlUza/NiZQaTO4DHYQNSuEIlSjuTA6HGFjYpMIxVFGAc3x8Tq1c
 j3+jls8D0rF5KdvN0PM8ltEVFC1N08POx+63K2Ufd4wN9U42GUdX39tElnPYvtDg6ksn
 hAkeozhp0txHTeDlIOvSqUoz0ZywqGRjEarlAH+cNNEXijOdwZqrTcIt+zPZQTAKhgu/
 6FVdDLq2RnhpYjUBOlxvk7F3RDWQbRE5aF7Ly+eDRNQQI822oP3WoWAanw8gRvDLUPgl
 ubxAV9Jdoeaig3Wmzhmzp7zLHbI48eU7OzyIdSAx75+PmRqncW2XoKecR6EQoTJPLg3n
 6JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379695; x=1725984495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IiCawLw2POwTZcTTAV1P3hhlN4KcpW1sTG7Gg9YSIJ8=;
 b=nACl9ZsBOZLrIMeBeosq8Yrv7QCEH8Vk9HH7e6LA0SSFZ0NTqpj28EZtI+Z9aojXjl
 j2e5DNheNrYYkY8zlJyR7FZ0+NP1MFGrMt8zrPYbrJfuSwhverqxvzOVKF51IpNzH5cZ
 hgnh/5YbPHx5AGDjsS1Aij6wPnYpaJQq7hR/bNkgpU5kFBxAfWtG92iMBsuWAxpgGrjF
 A7azryfjDVRnfj0OHespkknEQ266AheyCbPjWJJMafkSQESDM1D0BQA4UXV4zQfY+URq
 ctXX8mX6QLrb/1CT2CDjVqyeGYaPgeW/YXSgDnjeQK3BqA+vm6lW9XcsHd1+e7AgYlnv
 Axhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP3jbBjRfHxmlOtTn6+JZLW1XTOGVREbzKdh4rslW/6Ul5l4jGep4KOK7YCdSClM5Ob6/OM/MRv/Cz@nongnu.org
X-Gm-Message-State: AOJu0Yyg0tg1PCBOE1G7BFCtf0mpeJMJnnNnWTFachVHoFPkpcaW2Uqm
 gCviB/T6Uo4NZcqa4OTPXoikJ3iuXmjd+Mlq9t8kcj8QWnsEOGwnqxjlvQ4HWU+AIom84Sqok/U
 K
X-Google-Smtp-Source: AGHT+IHwMXZ4vUMHENrzX1FH/E4ewxQsPHNj85ZZi8EmLU78h4A3Ifcs7P+/NVINbR+YZ5CFDHnkzg==
X-Received: by 2002:a05:600c:4f47:b0:427:ff7a:79e with SMTP id
 5b1f17b1804b1-42c8de7b311mr11314135e9.16.1725379694990; 
 Tue, 03 Sep 2024 09:08:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 16/53] hw/sd: Remove pxa2xx_mmci.c
Date: Tue,  3 Sep 2024 17:07:14 +0100
Message-Id: <20240903160751.4100218-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Remove the pxa2xx-specific pxa2xx_mmci device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/pxa.h |  10 -
 hw/sd/pxa2xx_mmci.c  | 594 -------------------------------------------
 hw/sd/meson.build    |   1 -
 hw/sd/trace-events   |   4 -
 4 files changed, 609 deletions(-)
 delete mode 100644 hw/sd/pxa2xx_mmci.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index bf7f868700a..cc4de0750af 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -86,16 +86,6 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
                 hwaddr base, qemu_irq irq);
 void pxa2xx_lcd_vsync_notifier(PXA2xxLCDState *s, qemu_irq handler);
 
-/* pxa2xx_mmci.c */
-#define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxMMCIState, PXA2XX_MMCI)
-
-PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
-                hwaddr base,
-                qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma);
-void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
-                qemu_irq coverswitch);
-
 /* pxa2xx_pcmcia.c */
 #define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
 OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPCMCIAState, PXA2XX_PCMCIA)
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
deleted file mode 100644
index 82529708c8a..00000000000
--- a/hw/sd/pxa2xx_mmci.c
+++ /dev/null
@@ -1,594 +0,0 @@
-/*
- * Intel XScale PXA255/270 MultiMediaCard/SD/SDIO Controller emulation.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/irq.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "hw/arm/pxa.h"
-#include "hw/sd/sd.h"
-#include "hw/qdev-properties.h"
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "trace.h"
-#include "qom/object.h"
-
-#define TYPE_PXA2XX_MMCI_BUS "pxa2xx-mmci-bus"
-/* This is reusing the SDBus typedef from SD_BUS */
-DECLARE_INSTANCE_CHECKER(SDBus, PXA2XX_MMCI_BUS,
-                         TYPE_PXA2XX_MMCI_BUS)
-
-struct PXA2xxMMCIState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    qemu_irq irq;
-    qemu_irq rx_dma;
-    qemu_irq tx_dma;
-    qemu_irq inserted;
-    qemu_irq readonly;
-
-    BlockBackend *blk;
-    SDBus sdbus;
-
-    uint32_t status;
-    uint32_t clkrt;
-    uint32_t spi;
-    uint32_t cmdat;
-    uint32_t resp_tout;
-    uint32_t read_tout;
-    int32_t blklen;
-    int32_t numblk;
-    uint32_t intmask;
-    uint32_t intreq;
-    int32_t cmd;
-    uint32_t arg;
-
-    int32_t active;
-    int32_t bytesleft;
-    uint8_t tx_fifo[64];
-    uint32_t tx_start;
-    uint32_t tx_len;
-    uint8_t rx_fifo[32];
-    uint32_t rx_start;
-    uint32_t rx_len;
-    uint16_t resp_fifo[9];
-    uint32_t resp_len;
-
-    int32_t cmdreq;
-};
-
-static bool pxa2xx_mmci_vmstate_validate(void *opaque, int version_id)
-{
-    PXA2xxMMCIState *s = opaque;
-
-    return s->tx_start < ARRAY_SIZE(s->tx_fifo)
-        && s->rx_start < ARRAY_SIZE(s->rx_fifo)
-        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
-        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
-        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
-}
-
-
-static const VMStateDescription vmstate_pxa2xx_mmci = {
-    .name = "pxa2xx-mmci",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(status, PXA2xxMMCIState),
-        VMSTATE_UINT32(clkrt, PXA2xxMMCIState),
-        VMSTATE_UINT32(spi, PXA2xxMMCIState),
-        VMSTATE_UINT32(cmdat, PXA2xxMMCIState),
-        VMSTATE_UINT32(resp_tout, PXA2xxMMCIState),
-        VMSTATE_UINT32(read_tout, PXA2xxMMCIState),
-        VMSTATE_INT32(blklen, PXA2xxMMCIState),
-        VMSTATE_INT32(numblk, PXA2xxMMCIState),
-        VMSTATE_UINT32(intmask, PXA2xxMMCIState),
-        VMSTATE_UINT32(intreq, PXA2xxMMCIState),
-        VMSTATE_INT32(cmd, PXA2xxMMCIState),
-        VMSTATE_UINT32(arg, PXA2xxMMCIState),
-        VMSTATE_INT32(cmdreq, PXA2xxMMCIState),
-        VMSTATE_INT32(active, PXA2xxMMCIState),
-        VMSTATE_INT32(bytesleft, PXA2xxMMCIState),
-        VMSTATE_UINT32(tx_start, PXA2xxMMCIState),
-        VMSTATE_UINT32(tx_len, PXA2xxMMCIState),
-        VMSTATE_UINT32(rx_start, PXA2xxMMCIState),
-        VMSTATE_UINT32(rx_len, PXA2xxMMCIState),
-        VMSTATE_UINT32(resp_len, PXA2xxMMCIState),
-        VMSTATE_VALIDATE("fifo size incorrect", pxa2xx_mmci_vmstate_validate),
-        VMSTATE_UINT8_ARRAY(tx_fifo, PXA2xxMMCIState, 64),
-        VMSTATE_UINT8_ARRAY(rx_fifo, PXA2xxMMCIState, 32),
-        VMSTATE_UINT16_ARRAY(resp_fifo, PXA2xxMMCIState, 9),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-#define MMC_STRPCL	0x00	/* MMC Clock Start/Stop register */
-#define MMC_STAT	0x04	/* MMC Status register */
-#define MMC_CLKRT	0x08	/* MMC Clock Rate register */
-#define MMC_SPI		0x0c	/* MMC SPI Mode register */
-#define MMC_CMDAT	0x10	/* MMC Command/Data register */
-#define MMC_RESTO	0x14	/* MMC Response Time-Out register */
-#define MMC_RDTO	0x18	/* MMC Read Time-Out register */
-#define MMC_BLKLEN	0x1c	/* MMC Block Length register */
-#define MMC_NUMBLK	0x20	/* MMC Number of Blocks register */
-#define MMC_PRTBUF	0x24	/* MMC Buffer Partly Full register */
-#define MMC_I_MASK	0x28	/* MMC Interrupt Mask register */
-#define MMC_I_REG	0x2c	/* MMC Interrupt Request register */
-#define MMC_CMD		0x30	/* MMC Command register */
-#define MMC_ARGH	0x34	/* MMC Argument High register */
-#define MMC_ARGL	0x38	/* MMC Argument Low register */
-#define MMC_RES		0x3c	/* MMC Response FIFO */
-#define MMC_RXFIFO	0x40	/* MMC Receive FIFO */
-#define MMC_TXFIFO	0x44	/* MMC Transmit FIFO */
-#define MMC_RDWAIT	0x48	/* MMC RD_WAIT register */
-#define MMC_BLKS_REM	0x4c	/* MMC Blocks Remaining register */
-
-/* Bitfield masks */
-#define STRPCL_STOP_CLK	(1 << 0)
-#define STRPCL_STRT_CLK	(1 << 1)
-#define STAT_TOUT_RES	(1 << 1)
-#define STAT_CLK_EN	(1 << 8)
-#define STAT_DATA_DONE	(1 << 11)
-#define STAT_PRG_DONE	(1 << 12)
-#define STAT_END_CMDRES	(1 << 13)
-#define SPI_SPI_MODE	(1 << 0)
-#define CMDAT_RES_TYPE	(3 << 0)
-#define CMDAT_DATA_EN	(1 << 2)
-#define CMDAT_WR_RD	(1 << 3)
-#define CMDAT_DMA_EN	(1 << 7)
-#define CMDAT_STOP_TRAN	(1 << 10)
-#define INT_DATA_DONE	(1 << 0)
-#define INT_PRG_DONE	(1 << 1)
-#define INT_END_CMD	(1 << 2)
-#define INT_STOP_CMD	(1 << 3)
-#define INT_CLK_OFF	(1 << 4)
-#define INT_RXFIFO_REQ	(1 << 5)
-#define INT_TXFIFO_REQ	(1 << 6)
-#define INT_TINT	(1 << 7)
-#define INT_DAT_ERR	(1 << 8)
-#define INT_RES_ERR	(1 << 9)
-#define INT_RD_STALLED	(1 << 10)
-#define INT_SDIO_INT	(1 << 11)
-#define INT_SDIO_SACK	(1 << 12)
-#define PRTBUF_PRT_BUF	(1 << 0)
-
-/* Route internal interrupt lines to the global IC and DMA */
-static void pxa2xx_mmci_int_update(PXA2xxMMCIState *s)
-{
-    uint32_t mask = s->intmask;
-    if (s->cmdat & CMDAT_DMA_EN) {
-        mask |= INT_RXFIFO_REQ | INT_TXFIFO_REQ;
-
-        qemu_set_irq(s->rx_dma, !!(s->intreq & INT_RXFIFO_REQ));
-        qemu_set_irq(s->tx_dma, !!(s->intreq & INT_TXFIFO_REQ));
-    }
-
-    qemu_set_irq(s->irq, !!(s->intreq & ~mask));
-}
-
-static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
-{
-    if (!s->active)
-        return;
-
-    if (s->cmdat & CMDAT_WR_RD) {
-        while (s->bytesleft && s->tx_len) {
-            sdbus_write_byte(&s->sdbus, s->tx_fifo[s->tx_start++]);
-            s->tx_start &= 0x1f;
-            s->tx_len --;
-            s->bytesleft --;
-        }
-        if (s->bytesleft)
-            s->intreq |= INT_TXFIFO_REQ;
-    } else
-        while (s->bytesleft && s->rx_len < 32) {
-            s->rx_fifo[(s->rx_start + (s->rx_len ++)) & 0x1f] =
-                sdbus_read_byte(&s->sdbus);
-            s->bytesleft --;
-            s->intreq |= INT_RXFIFO_REQ;
-        }
-
-    if (!s->bytesleft) {
-        s->active = 0;
-        s->intreq |= INT_DATA_DONE;
-        s->status |= STAT_DATA_DONE;
-
-        if (s->cmdat & CMDAT_WR_RD) {
-            s->intreq |= INT_PRG_DONE;
-            s->status |= STAT_PRG_DONE;
-        }
-    }
-
-    pxa2xx_mmci_int_update(s);
-}
-
-static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
-{
-    int rsplen, i;
-    SDRequest request;
-    uint8_t response[16];
-
-    s->active = 1;
-    s->rx_len = 0;
-    s->tx_len = 0;
-    s->cmdreq = 0;
-
-    request.cmd = s->cmd;
-    request.arg = s->arg;
-    request.crc = 0;	/* FIXME */
-
-    rsplen = sdbus_do_command(&s->sdbus, &request, response);
-    s->intreq |= INT_END_CMD;
-
-    memset(s->resp_fifo, 0, sizeof(s->resp_fifo));
-    switch (s->cmdat & CMDAT_RES_TYPE) {
-#define PXAMMCI_RESP(wd, value0, value1)	\
-        s->resp_fifo[(wd) + 0] |= (value0);	\
-        s->resp_fifo[(wd) + 1] |= (value1) << 8;
-    case 0:	/* No response */
-        goto complete;
-
-    case 1:	/* R1, R4, R5 or R6 */
-        if (rsplen < 4)
-            goto timeout;
-        goto complete;
-
-    case 2:	/* R2 */
-        if (rsplen < 16)
-            goto timeout;
-        goto complete;
-
-    case 3:	/* R3 */
-        if (rsplen < 4)
-            goto timeout;
-        goto complete;
-
-    complete:
-        for (i = 0; rsplen > 0; i ++, rsplen -= 2) {
-            PXAMMCI_RESP(i, response[i * 2], response[i * 2 + 1]);
-        }
-        s->status |= STAT_END_CMDRES;
-
-        if (!(s->cmdat & CMDAT_DATA_EN))
-            s->active = 0;
-        else
-            s->bytesleft = s->numblk * s->blklen;
-
-        s->resp_len = 0;
-        break;
-
-    timeout:
-        s->active = 0;
-        s->status |= STAT_TOUT_RES;
-        break;
-    }
-
-    pxa2xx_mmci_fifo_update(s);
-}
-
-static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr offset, unsigned size)
-{
-    PXA2xxMMCIState *s = (PXA2xxMMCIState *) opaque;
-    uint32_t ret = 0;
-
-    switch (offset) {
-    case MMC_STRPCL:
-        break;
-    case MMC_STAT:
-        ret = s->status;
-        break;
-    case MMC_CLKRT:
-        ret = s->clkrt;
-        break;
-    case MMC_SPI:
-        ret = s->spi;
-        break;
-    case MMC_CMDAT:
-        ret = s->cmdat;
-        break;
-    case MMC_RESTO:
-        ret = s->resp_tout;
-        break;
-    case MMC_RDTO:
-        ret = s->read_tout;
-        break;
-    case MMC_BLKLEN:
-        ret = s->blklen;
-        break;
-    case MMC_NUMBLK:
-        ret = s->numblk;
-        break;
-    case MMC_PRTBUF:
-        break;
-    case MMC_I_MASK:
-        ret = s->intmask;
-        break;
-    case MMC_I_REG:
-        ret = s->intreq;
-        break;
-    case MMC_CMD:
-        ret = s->cmd | 0x40;
-        break;
-    case MMC_ARGH:
-        ret = s->arg >> 16;
-        break;
-    case MMC_ARGL:
-        ret = s->arg & 0xffff;
-        break;
-    case MMC_RES:
-        ret = (s->resp_len < 9) ? s->resp_fifo[s->resp_len++] : 0;
-        break;
-    case MMC_RXFIFO:
-        while (size-- && s->rx_len) {
-            ret |= s->rx_fifo[s->rx_start++] << (size << 3);
-            s->rx_start &= 0x1f;
-            s->rx_len --;
-        }
-        s->intreq &= ~INT_RXFIFO_REQ;
-        pxa2xx_mmci_fifo_update(s);
-        break;
-    case MMC_RDWAIT:
-        break;
-    case MMC_BLKS_REM:
-        ret = s->numblk;
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: incorrect register 0x%02" HWADDR_PRIx "\n",
-                      __func__, offset);
-    }
-    trace_pxa2xx_mmci_read(size, offset, ret);
-
-    return ret;
-}
-
-static void pxa2xx_mmci_write(void *opaque,
-                              hwaddr offset, uint64_t value, unsigned size)
-{
-    PXA2xxMMCIState *s = (PXA2xxMMCIState *) opaque;
-
-    trace_pxa2xx_mmci_write(size, offset, value);
-    switch (offset) {
-    case MMC_STRPCL:
-        if (value & STRPCL_STRT_CLK) {
-            s->status |= STAT_CLK_EN;
-            s->intreq &= ~INT_CLK_OFF;
-
-            if (s->cmdreq && !(s->cmdat & CMDAT_STOP_TRAN)) {
-                s->status &= STAT_CLK_EN;
-                pxa2xx_mmci_wakequeues(s);
-            }
-        }
-
-        if (value & STRPCL_STOP_CLK) {
-            s->status &= ~STAT_CLK_EN;
-            s->intreq |= INT_CLK_OFF;
-            s->active = 0;
-        }
-
-        pxa2xx_mmci_int_update(s);
-        break;
-
-    case MMC_CLKRT:
-        s->clkrt = value & 7;
-        break;
-
-    case MMC_SPI:
-        s->spi = value & 0xf;
-        if (value & SPI_SPI_MODE) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: attempted to use card in SPI mode\n", __func__);
-        }
-        break;
-
-    case MMC_CMDAT:
-        s->cmdat = value & 0x3dff;
-        s->active = 0;
-        s->cmdreq = 1;
-        if (!(value & CMDAT_STOP_TRAN)) {
-            s->status &= STAT_CLK_EN;
-
-            if (s->status & STAT_CLK_EN)
-                pxa2xx_mmci_wakequeues(s);
-        }
-
-        pxa2xx_mmci_int_update(s);
-        break;
-
-    case MMC_RESTO:
-        s->resp_tout = value & 0x7f;
-        break;
-
-    case MMC_RDTO:
-        s->read_tout = value & 0xffff;
-        break;
-
-    case MMC_BLKLEN:
-        s->blklen = value & 0xfff;
-        break;
-
-    case MMC_NUMBLK:
-        s->numblk = value & 0xffff;
-        break;
-
-    case MMC_PRTBUF:
-        if (value & PRTBUF_PRT_BUF) {
-            s->tx_start ^= 32;
-            s->tx_len = 0;
-        }
-        pxa2xx_mmci_fifo_update(s);
-        break;
-
-    case MMC_I_MASK:
-        s->intmask = value & 0x1fff;
-        pxa2xx_mmci_int_update(s);
-        break;
-
-    case MMC_CMD:
-        s->cmd = value & 0x3f;
-        break;
-
-    case MMC_ARGH:
-        s->arg &= 0x0000ffff;
-        s->arg |= value << 16;
-        break;
-
-    case MMC_ARGL:
-        s->arg &= 0xffff0000;
-        s->arg |= value & 0x0000ffff;
-        break;
-
-    case MMC_TXFIFO:
-        while (size-- && s->tx_len < 0x20)
-            s->tx_fifo[(s->tx_start + (s->tx_len ++)) & 0x1f] =
-                    (value >> (size << 3)) & 0xff;
-        s->intreq &= ~INT_TXFIFO_REQ;
-        pxa2xx_mmci_fifo_update(s);
-        break;
-
-    case MMC_RDWAIT:
-    case MMC_BLKS_REM:
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: incorrect reg 0x%02" HWADDR_PRIx " "
-                      "(value 0x%08" PRIx64 ")\n", __func__, offset, value);
-    }
-}
-
-static const MemoryRegionOps pxa2xx_mmci_ops = {
-    .read = pxa2xx_mmci_read,
-    .write = pxa2xx_mmci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
-                hwaddr base,
-                qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma)
-{
-    DeviceState *dev;
-
-    dev = sysbus_create_simple(TYPE_PXA2XX_MMCI, base, irq);
-    qdev_connect_gpio_out_named(dev, "rx-dma", 0, rx_dma);
-    qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
-
-    return PXA2XX_MMCI(dev);
-}
-
-static void pxa2xx_mmci_set_inserted(DeviceState *dev, bool inserted)
-{
-    PXA2xxMMCIState *s = PXA2XX_MMCI(dev);
-
-    qemu_set_irq(s->inserted, inserted);
-}
-
-static void pxa2xx_mmci_set_readonly(DeviceState *dev, bool readonly)
-{
-    PXA2xxMMCIState *s = PXA2XX_MMCI(dev);
-
-    qemu_set_irq(s->readonly, readonly);
-}
-
-void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
-                          qemu_irq coverswitch)
-{
-    DeviceState *dev = DEVICE(s);
-
-    s->readonly = readonly;
-    s->inserted = coverswitch;
-
-    pxa2xx_mmci_set_inserted(dev, sdbus_get_inserted(&s->sdbus));
-    pxa2xx_mmci_set_readonly(dev, sdbus_get_readonly(&s->sdbus));
-}
-
-static void pxa2xx_mmci_reset(DeviceState *d)
-{
-    PXA2xxMMCIState *s = PXA2XX_MMCI(d);
-
-    s->status = 0;
-    s->clkrt = 0;
-    s->spi = 0;
-    s->cmdat = 0;
-    s->resp_tout = 0;
-    s->read_tout = 0;
-    s->blklen = 0;
-    s->numblk = 0;
-    s->intmask = 0;
-    s->intreq = 0;
-    s->cmd = 0;
-    s->arg = 0;
-    s->active = 0;
-    s->bytesleft = 0;
-    s->tx_start = 0;
-    s->tx_len = 0;
-    s->rx_start = 0;
-    s->rx_len = 0;
-    s->resp_len = 0;
-    s->cmdreq = 0;
-    memset(s->tx_fifo, 0, sizeof(s->tx_fifo));
-    memset(s->rx_fifo, 0, sizeof(s->rx_fifo));
-    memset(s->resp_fifo, 0, sizeof(s->resp_fifo));
-}
-
-static void pxa2xx_mmci_instance_init(Object *obj)
-{
-    PXA2xxMMCIState *s = PXA2XX_MMCI(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    DeviceState *dev = DEVICE(obj);
-
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_mmci_ops, s,
-                          "pxa2xx-mmci", 0x00100000);
-    sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_irq(sbd, &s->irq);
-    qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
-    qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
-
-    qbus_init(&s->sdbus, sizeof(s->sdbus),
-              TYPE_PXA2XX_MMCI_BUS, DEVICE(obj), "sd-bus");
-}
-
-static void pxa2xx_mmci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_pxa2xx_mmci;
-    dc->reset = pxa2xx_mmci_reset;
-}
-
-static void pxa2xx_mmci_bus_class_init(ObjectClass *klass, void *data)
-{
-    SDBusClass *sbc = SD_BUS_CLASS(klass);
-
-    sbc->set_inserted = pxa2xx_mmci_set_inserted;
-    sbc->set_readonly = pxa2xx_mmci_set_readonly;
-}
-
-static const TypeInfo pxa2xx_mmci_types[] = {
-    {
-        .name           = TYPE_PXA2XX_MMCI,
-        .parent         = TYPE_SYS_BUS_DEVICE,
-        .instance_size  = sizeof(PXA2xxMMCIState),
-        .instance_init  = pxa2xx_mmci_instance_init,
-        .class_init     = pxa2xx_mmci_class_init,
-    },
-    {
-        .name           = TYPE_PXA2XX_MMCI_BUS,
-        .parent         = TYPE_SD_BUS,
-        .instance_size  = sizeof(SDBus),
-        .class_init     = pxa2xx_mmci_bus_class_init,
-    },
-};
-
-DEFINE_TYPES(pxa2xx_mmci_types)
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index bbb75af0c9b..b43d45bc564 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -5,7 +5,6 @@ system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
 system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 43671dc7912..db0644256d9 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -60,10 +60,6 @@ sdcard_set_voltage(uint16_t millivolts) "%u mV"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
 sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
 
-# pxa2xx_mmci.c
-pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
-pxa2xx_mmci_write(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
-
 # pl181.c
 pl181_command_send(uint8_t cmd, uint32_t arg) "sending CMD%02d arg 0x%08" PRIx32
 pl181_command_sent(void) "command sent"
-- 
2.34.1


