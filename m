Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F091FCEACEB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfw3-0008Os-4m; Tue, 01 Oct 2024 12:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuX-0005YQ-OW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuR-00064J-EA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cc84c12c2so3041136f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800774; x=1728405574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qNPDX7ggLhNO0iDzea2pGXNSJ5Ybn1/cOfNVKKikcjs=;
 b=oM2a1S/2VNZk9s4kGPzT9qe6jitBVTAUMLBr2fJCwel14yFVft0lkZIe8hw/UngnC0
 CvcoeMwSA5q4cBZ8osnzv8ITESYUEVM8iMYf9MH8wRZLUwtyXmSp7POiL48c/JctZq2y
 cr7Qcke9bMoEIpmrh+aN6ulayQzrEhASWsmljv5S+VTQgG7gr+uuEYLgYI921ulPdz7j
 t9dtN4w6q1H1Zh+B3/3MaIrXO/Idswjp1Qz9NeNV0HgHb7CnNQVrTIpBqk7g1JsxbAjT
 eoae8Ty7FCbp/tTEOM+xceqCH498zxPTJFfH3PC2LW0QzCIMWlj+rDkfMYOByWG7aeHC
 MsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800774; x=1728405574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNPDX7ggLhNO0iDzea2pGXNSJ5Ybn1/cOfNVKKikcjs=;
 b=VUWUaKrlJy8aKMRGAW8tlO8+UROTXID9qFXggnUQ0Y56u26I5Yccwbl7eBeLI0zzcK
 aH+KWvJS0vqpj5VhvV75zoMyL/sNfrI2alNSC8mx1iWNWcaMbVrVjrH2gzdX0EhnpENf
 ZZ/vBxclaU/rtz4kHglA6bwTT/9lruo04OFUwMzv/iYQAacPvZxUURCpS0UjmLT7W5KS
 MLHd/hkZ2QP2cwjrwrPENxQxEg8nQpEQJtoPSSXHSOCgy224NSh1/qlGuG4Oga+ZxxWA
 ONEjvldS1d8Y1CkCNI7b8WQMNHZkm3iPOTX8TwUIFLgrtfxui/RBIW5dqeThGz5WS2aE
 ecWQ==
X-Gm-Message-State: AOJu0YxXAZ+2LXyhQVc/KVxWZnwUW1KIV2mYJiZs0cYfuWwU1alig2q0
 4cmtwSzOoeBA/OwwSGuEiV8QKvWo2LU1QYAGbP19b6dYyd+zxdge9dFHQ33LP0NuSZbQZW2FGVH
 9
X-Google-Smtp-Source: AGHT+IGNLyr2se1nsKDo0ZCpqBmHzr5I+QgQiTx1dw+EIAIUseQOylxg0alZZkTtNNXILA0VxjdWfw==
X-Received: by 2002:a5d:4d09:0:b0:374:b9d7:5120 with SMTP id
 ffacd0b85a97d-37cfb8b653amr111580f8f.23.1727800773816; 
 Tue, 01 Oct 2024 09:39:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/54] hw/arm: Remove pxa2xx_pic
Date: Tue,  1 Oct 2024 17:38:50 +0100
Message-Id: <20241001163918.1275441-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Remove the pxa2xx-specific interrupt controller device.
As this is the last user of the pxa.h header file and the
CONFIG_PXA2XX define we can remove those too.

This completes the removal of the pxa2xx specific code.  We leave:
 * pxa2xx_timer -- still used by the Collie board (strongarm)
 * the definitions of the CPUs themselves in target/arm
   (still usable by linux-user mode)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240903160751.4100218-23-peter.maydell@linaro.org
---
 MAINTAINERS          |  10 --
 include/hw/arm/pxa.h |  74 ---------
 hw/arm/pxa2xx_pic.c  | 359 -------------------------------------------
 hw/arm/Kconfig       |  11 --
 hw/arm/meson.build   |   1 -
 5 files changed, 455 deletions(-)
 delete mode 100644 include/hw/arm/pxa.h
 delete mode 100644 hw/arm/pxa2xx_pic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb27bbdfd01..1ec1d33b4db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -913,16 +913,6 @@ F: hw/intc/realview_gic.c
 F: include/hw/intc/realview_gic.h
 F: docs/system/arm/realview.rst
 
-PXA2XX
-M: Peter Maydell <peter.maydell@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/*/pxa2xx*
-F: hw/gpio/max7310.c
-F: hw/adc/max111x.c
-F: include/hw/adc/max111x.h
-F: include/hw/arm/pxa.h
-
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
deleted file mode 100644
index fb28a683f38..00000000000
--- a/include/hw/arm/pxa.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Intel XScale PXA255/270 processor support.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- */
-
-#ifndef PXA_H
-#define PXA_H
-
-#include "exec/memory.h"
-#include "target/arm/cpu-qom.h"
-#include "hw/pcmcia.h"
-#include "qom/object.h"
-
-/* Interrupt numbers */
-# define PXA2XX_PIC_SSP3	0
-# define PXA2XX_PIC_USBH2	2
-# define PXA2XX_PIC_USBH1	3
-# define PXA2XX_PIC_KEYPAD	4
-# define PXA2XX_PIC_PWRI2C	6
-# define PXA25X_PIC_HWUART	7
-# define PXA27X_PIC_OST_4_11	7
-# define PXA2XX_PIC_GPIO_0	8
-# define PXA2XX_PIC_GPIO_1	9
-# define PXA2XX_PIC_GPIO_X	10
-# define PXA2XX_PIC_I2S 	13
-# define PXA26X_PIC_ASSP	15
-# define PXA25X_PIC_NSSP	16
-# define PXA27X_PIC_SSP2	16
-# define PXA2XX_PIC_LCD		17
-# define PXA2XX_PIC_I2C		18
-# define PXA2XX_PIC_ICP		19
-# define PXA2XX_PIC_STUART	20
-# define PXA2XX_PIC_BTUART	21
-# define PXA2XX_PIC_FFUART	22
-# define PXA2XX_PIC_MMC		23
-# define PXA2XX_PIC_SSP		24
-# define PXA2XX_PIC_DMA		25
-# define PXA2XX_PIC_OST_0	26
-# define PXA2XX_PIC_RTC1HZ	30
-# define PXA2XX_PIC_RTCALARM	31
-
-/* DMA requests */
-# define PXA2XX_RX_RQ_I2S	2
-# define PXA2XX_TX_RQ_I2S	3
-# define PXA2XX_RX_RQ_BTUART	4
-# define PXA2XX_TX_RQ_BTUART	5
-# define PXA2XX_RX_RQ_FFUART	6
-# define PXA2XX_TX_RQ_FFUART	7
-# define PXA2XX_RX_RQ_SSP1	13
-# define PXA2XX_TX_RQ_SSP1	14
-# define PXA2XX_RX_RQ_SSP2	15
-# define PXA2XX_TX_RQ_SSP2	16
-# define PXA2XX_RX_RQ_ICP	17
-# define PXA2XX_TX_RQ_ICP	18
-# define PXA2XX_RX_RQ_STUART	19
-# define PXA2XX_TX_RQ_STUART	20
-# define PXA2XX_RX_RQ_MMCI	21
-# define PXA2XX_TX_RQ_MMCI	22
-# define PXA2XX_USB_RQ(x)	((x) + 24)
-# define PXA2XX_RX_RQ_SSP3	66
-# define PXA2XX_TX_RQ_SSP3	67
-
-# define PXA2XX_SDRAM_BASE	0xa0000000
-# define PXA2XX_INTERNAL_BASE	0x5c000000
-# define PXA2XX_INTERNAL_SIZE	0x40000
-
-/* pxa2xx_pic.c */
-DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu);
-
-#endif /* PXA_H */
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
deleted file mode 100644
index 34c5555dba9..00000000000
--- a/hw/arm/pxa2xx_pic.c
+++ /dev/null
@@ -1,359 +0,0 @@
-/*
- * Intel XScale PXA Programmable Interrupt Controller.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Copyright (c) 2006 Thorsten Zitterell
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GPL.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "qemu/log.h"
-#include "cpu.h"
-#include "hw/arm/pxa.h"
-#include "hw/sysbus.h"
-#include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
-#include "qom/object.h"
-#include "target/arm/cpregs.h"
-
-#define ICIP	0x00	/* Interrupt Controller IRQ Pending register */
-#define ICMR	0x04	/* Interrupt Controller Mask register */
-#define ICLR	0x08	/* Interrupt Controller Level register */
-#define ICFP	0x0c	/* Interrupt Controller FIQ Pending register */
-#define ICPR	0x10	/* Interrupt Controller Pending register */
-#define ICCR	0x14	/* Interrupt Controller Control register */
-#define ICHP	0x18	/* Interrupt Controller Highest Priority register */
-#define IPR0	0x1c	/* Interrupt Controller Priority register 0 */
-#define IPR31	0x98	/* Interrupt Controller Priority register 31 */
-#define ICIP2	0x9c	/* Interrupt Controller IRQ Pending register 2 */
-#define ICMR2	0xa0	/* Interrupt Controller Mask register 2 */
-#define ICLR2	0xa4	/* Interrupt Controller Level register 2 */
-#define ICFP2	0xa8	/* Interrupt Controller FIQ Pending register 2 */
-#define ICPR2	0xac	/* Interrupt Controller Pending register 2 */
-#define IPR32	0xb0	/* Interrupt Controller Priority register 32 */
-#define IPR39	0xcc	/* Interrupt Controller Priority register 39 */
-
-#define PXA2XX_PIC_SRCS	40
-
-#define TYPE_PXA2XX_PIC "pxa2xx_pic"
-OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPICState, PXA2XX_PIC)
-
-struct PXA2xxPICState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion iomem;
-    ARMCPU *cpu;
-    uint32_t int_enabled[2];
-    uint32_t int_pending[2];
-    uint32_t is_fiq[2];
-    uint32_t int_idle;
-    uint32_t priority[PXA2XX_PIC_SRCS];
-};
-
-static void pxa2xx_pic_update(void *opaque)
-{
-    uint32_t mask[2];
-    PXA2xxPICState *s = (PXA2xxPICState *) opaque;
-    CPUState *cpu = CPU(s->cpu);
-
-    if (cpu->halted) {
-        mask[0] = s->int_pending[0] & (s->int_enabled[0] | s->int_idle);
-        mask[1] = s->int_pending[1] & (s->int_enabled[1] | s->int_idle);
-        if (mask[0] || mask[1]) {
-            cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB);
-        }
-    }
-
-    mask[0] = s->int_pending[0] & s->int_enabled[0];
-    mask[1] = s->int_pending[1] & s->int_enabled[1];
-
-    if ((mask[0] & s->is_fiq[0]) || (mask[1] & s->is_fiq[1])) {
-        cpu_interrupt(cpu, CPU_INTERRUPT_FIQ);
-    } else {
-        cpu_reset_interrupt(cpu, CPU_INTERRUPT_FIQ);
-    }
-
-    if ((mask[0] & ~s->is_fiq[0]) || (mask[1] & ~s->is_fiq[1])) {
-        cpu_interrupt(cpu, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
-    }
-}
-
-/* Note: Here level means state of the signal on a pin, not
- * IRQ/FIQ distinction as in PXA Developer Manual.  */
-static void pxa2xx_pic_set_irq(void *opaque, int irq, int level)
-{
-    PXA2xxPICState *s = (PXA2xxPICState *) opaque;
-    int int_set = (irq >= 32);
-    irq &= 31;
-
-    if (level)
-        s->int_pending[int_set] |= 1 << irq;
-    else
-        s->int_pending[int_set] &= ~(1 << irq);
-
-    pxa2xx_pic_update(opaque);
-}
-
-static inline uint32_t pxa2xx_pic_highest(PXA2xxPICState *s) {
-    int i, int_set, irq;
-    uint32_t bit, mask[2];
-    uint32_t ichp = 0x003f003f;	/* Both IDs invalid */
-
-    mask[0] = s->int_pending[0] & s->int_enabled[0];
-    mask[1] = s->int_pending[1] & s->int_enabled[1];
-
-    for (i = PXA2XX_PIC_SRCS - 1; i >= 0; i --) {
-        irq = s->priority[i] & 0x3f;
-        if ((s->priority[i] & (1U << 31)) && irq < PXA2XX_PIC_SRCS) {
-            /* Source peripheral ID is valid.  */
-            bit = 1 << (irq & 31);
-            int_set = (irq >= 32);
-
-            if (mask[int_set] & bit & s->is_fiq[int_set]) {
-                /* FIQ asserted */
-                ichp &= 0xffff0000;
-                ichp |= (1 << 15) | irq;
-            }
-
-            if (mask[int_set] & bit & ~s->is_fiq[int_set]) {
-                /* IRQ asserted */
-                ichp &= 0x0000ffff;
-                ichp |= (1U << 31) | (irq << 16);
-            }
-        }
-    }
-
-    return ichp;
-}
-
-static uint64_t pxa2xx_pic_mem_read(void *opaque, hwaddr offset,
-                                    unsigned size)
-{
-    PXA2xxPICState *s = (PXA2xxPICState *) opaque;
-
-    switch (offset) {
-    case ICIP:	/* IRQ Pending register */
-        return s->int_pending[0] & ~s->is_fiq[0] & s->int_enabled[0];
-    case ICIP2:	/* IRQ Pending register 2 */
-        return s->int_pending[1] & ~s->is_fiq[1] & s->int_enabled[1];
-    case ICMR:	/* Mask register */
-        return s->int_enabled[0];
-    case ICMR2:	/* Mask register 2 */
-        return s->int_enabled[1];
-    case ICLR:	/* Level register */
-        return s->is_fiq[0];
-    case ICLR2:	/* Level register 2 */
-        return s->is_fiq[1];
-    case ICCR:	/* Idle mask */
-        return (s->int_idle == 0);
-    case ICFP:	/* FIQ Pending register */
-        return s->int_pending[0] & s->is_fiq[0] & s->int_enabled[0];
-    case ICFP2:	/* FIQ Pending register 2 */
-        return s->int_pending[1] & s->is_fiq[1] & s->int_enabled[1];
-    case ICPR:	/* Pending register */
-        return s->int_pending[0];
-    case ICPR2:	/* Pending register 2 */
-        return s->int_pending[1];
-    case IPR0  ... IPR31:
-        return s->priority[0  + ((offset - IPR0 ) >> 2)];
-    case IPR32 ... IPR39:
-        return s->priority[32 + ((offset - IPR32) >> 2)];
-    case ICHP:	/* Highest Priority register */
-        return pxa2xx_pic_highest(s);
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "pxa2xx_pic_mem_read: bad register offset 0x%" HWADDR_PRIx
-                      "\n", offset);
-        return 0;
-    }
-}
-
-static void pxa2xx_pic_mem_write(void *opaque, hwaddr offset,
-                                 uint64_t value, unsigned size)
-{
-    PXA2xxPICState *s = (PXA2xxPICState *) opaque;
-
-    switch (offset) {
-    case ICMR:	/* Mask register */
-        s->int_enabled[0] = value;
-        break;
-    case ICMR2:	/* Mask register 2 */
-        s->int_enabled[1] = value;
-        break;
-    case ICLR:	/* Level register */
-        s->is_fiq[0] = value;
-        break;
-    case ICLR2:	/* Level register 2 */
-        s->is_fiq[1] = value;
-        break;
-    case ICCR:	/* Idle mask */
-        s->int_idle = (value & 1) ? 0 : ~0;
-        break;
-    case IPR0  ... IPR31:
-        s->priority[0  + ((offset - IPR0 ) >> 2)] = value & 0x8000003f;
-        break;
-    case IPR32 ... IPR39:
-        s->priority[32 + ((offset - IPR32) >> 2)] = value & 0x8000003f;
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "pxa2xx_pic_mem_write: bad register offset 0x%"
-                      HWADDR_PRIx "\n", offset);
-        return;
-    }
-    pxa2xx_pic_update(opaque);
-}
-
-/* Interrupt Controller Coprocessor Space Register Mapping */
-static const int pxa2xx_cp_reg_map[0x10] = {
-    [0x0 ... 0xf] = -1,
-    [0x0] = ICIP,
-    [0x1] = ICMR,
-    [0x2] = ICLR,
-    [0x3] = ICFP,
-    [0x4] = ICPR,
-    [0x5] = ICHP,
-    [0x6] = ICIP2,
-    [0x7] = ICMR2,
-    [0x8] = ICLR2,
-    [0x9] = ICFP2,
-    [0xa] = ICPR2,
-};
-
-static uint64_t pxa2xx_pic_cp_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    int offset = pxa2xx_cp_reg_map[ri->crn];
-    return pxa2xx_pic_mem_read(ri->opaque, offset, 4);
-}
-
-static void pxa2xx_pic_cp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                uint64_t value)
-{
-    int offset = pxa2xx_cp_reg_map[ri->crn];
-    pxa2xx_pic_mem_write(ri->opaque, offset, value, 4);
-}
-
-#define REGINFO_FOR_PIC_CP(NAME, CRN) \
-    { .name = NAME, .cp = 6, .crn = CRN, .crm = 0, .opc1 = 0, .opc2 = 0, \
-      .access = PL1_RW, .type = ARM_CP_IO, \
-      .readfn = pxa2xx_pic_cp_read, .writefn = pxa2xx_pic_cp_write }
-
-static const ARMCPRegInfo pxa_pic_cp_reginfo[] = {
-    REGINFO_FOR_PIC_CP("ICIP", 0),
-    REGINFO_FOR_PIC_CP("ICMR", 1),
-    REGINFO_FOR_PIC_CP("ICLR", 2),
-    REGINFO_FOR_PIC_CP("ICFP", 3),
-    REGINFO_FOR_PIC_CP("ICPR", 4),
-    REGINFO_FOR_PIC_CP("ICHP", 5),
-    REGINFO_FOR_PIC_CP("ICIP2", 6),
-    REGINFO_FOR_PIC_CP("ICMR2", 7),
-    REGINFO_FOR_PIC_CP("ICLR2", 8),
-    REGINFO_FOR_PIC_CP("ICFP2", 9),
-    REGINFO_FOR_PIC_CP("ICPR2", 0xa),
-};
-
-static const MemoryRegionOps pxa2xx_pic_ops = {
-    .read = pxa2xx_pic_mem_read,
-    .write = pxa2xx_pic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static int pxa2xx_pic_post_load(void *opaque, int version_id)
-{
-    pxa2xx_pic_update(opaque);
-    return 0;
-}
-
-static void pxa2xx_pic_reset_hold(Object *obj, ResetType type)
-{
-    PXA2xxPICState *s = PXA2XX_PIC(obj);
-
-    s->int_pending[0] = 0;
-    s->int_pending[1] = 0;
-    s->int_enabled[0] = 0;
-    s->int_enabled[1] = 0;
-    s->is_fiq[0] = 0;
-    s->is_fiq[1] = 0;
-}
-
-DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
-{
-    DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
-
-    object_property_set_link(OBJECT(dev), "arm-cpu",
-                             OBJECT(cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return dev;
-}
-
-static void pxa2xx_pic_realize(DeviceState *dev, Error **errp)
-{
-    PXA2xxPICState *s = PXA2XX_PIC(dev);
-
-    qdev_init_gpio_in(dev, pxa2xx_pic_set_irq, PXA2XX_PIC_SRCS);
-
-    /* Enable IC memory-mapped registers access.  */
-    memory_region_init_io(&s->iomem, OBJECT(s), &pxa2xx_pic_ops, s,
-                          "pxa2xx-pic", 0x00100000);
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
-
-    /* Enable IC coprocessor access.  */
-    define_arm_cp_regs_with_opaque(s->cpu, pxa_pic_cp_reginfo, s);
-}
-
-static const VMStateDescription vmstate_pxa2xx_pic_regs = {
-    .name = "pxa2xx_pic",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .post_load = pxa2xx_pic_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(int_enabled, PXA2xxPICState, 2),
-        VMSTATE_UINT32_ARRAY(int_pending, PXA2xxPICState, 2),
-        VMSTATE_UINT32_ARRAY(is_fiq, PXA2xxPICState, 2),
-        VMSTATE_UINT32(int_idle, PXA2xxPICState),
-        VMSTATE_UINT32_ARRAY(priority, PXA2xxPICState, PXA2XX_PIC_SRCS),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static Property pxa2xx_pic_properties[] = {
-    DEFINE_PROP_LINK("arm-cpu", PXA2xxPICState, cpu,
-                     TYPE_ARM_CPU, ARMCPU *),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
-
-    device_class_set_props(dc, pxa2xx_pic_properties);
-    dc->realize = pxa2xx_pic_realize;
-    dc->desc = "PXA2xx PIC";
-    dc->vmsd = &vmstate_pxa2xx_pic_regs;
-    rc->phases.hold = pxa2xx_pic_reset_hold;
-}
-
-static const TypeInfo pxa2xx_pic_info = {
-    .name          = TYPE_PXA2XX_PIC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PXA2xxPICState),
-    .class_init    = pxa2xx_pic_class_init,
-};
-
-static void pxa2xx_pic_register_types(void)
-{
-    type_register_static(&pxa2xx_pic_info);
-}
-
-type_init(pxa2xx_pic_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8f6cbf94855..d33d59bee90 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -166,17 +166,6 @@ config OMAP
     select SD
     select SERIAL
 
-config PXA2XX
-    bool
-    select FRAMEBUFFER
-    select I2C
-    select SERIAL
-    select SD
-    select SSI
-    select USB_OHCI_SYSBUS
-    select PCMCIA
-    select PXA2XX_TIMER
-
 config REALVIEW
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index c2b717f3118..094366fbd5c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -22,7 +22,6 @@ arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
 arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
 arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
-arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_pic.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
 arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
-- 
2.34.1


