Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F2CC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQi2-00085U-70; Fri, 23 May 2025 07:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQhz-000843-En; Fri, 23 May 2025 07:37:03 -0400
Received: from forward500d.mail.yandex.net ([178.154.239.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQhu-0003g3-1C; Fri, 23 May 2025 07:37:03 -0400
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:4946:0:640:90b4:0])
 by forward500d.mail.yandex.net (Yandex) with ESMTPS id E9A9F611C6;
 Fri, 23 May 2025 14:36:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id kaOXlq9LjuQ0-PHptBkXS; 
 Fri, 23 May 2025 14:36:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1748000209; bh=UAZIoG9zeFPyCIfQiCp8DPVU6A+Jo0I5syz+q4uphrI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=R30KIsvzrMmL+0FbYqvr8TkN91gFFjzmP5nKNUxa651xEl/eEscSQiy7bERAr29Po
 R53FMVlXX1Vje9Z+CpRFNFMPiQTjOmLnywBqEcoz34N64NtWNtNz/eDb78ZVpHW/kF
 SLPw6Oa4nRcByPCIiRHEMk3j0eQmhae6+whOZrDA=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Ilya Chichkov <i.chichkov@yadro.com>,
 Nikita Shubin <n.shubin@yadro.com>
Subject: [PATCH v2 1/3] hw/dma: Add STM32 platfrom DMA controller emulation
Date: Fri, 23 May 2025 14:36:45 +0300
Message-ID: <20250523113647.4388-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523113647.4388-1-nikita.shubin@maquefel.me>
References: <20250523113647.4388-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.208;
 envelope-from=nikita.shubin@maquefel.me; helo=forward500d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Nikita Shubin <n.shubin@yadro.com>

STMicroelectronics STM32 SoCs integrate DMA engine that supports:

* Independent concurrent DMA transfers using 7/5 DMA channels
* Generation of interrupts on various conditions during execution
* PERIPH to MEMORY transactions, invoked by peripheral device models
* MEMORY to MEMORY transactions, invoked by software

This model is compatible with STM32F1xxxx and GD32F30x.

Co-developed-by: Ilya Chichkov <i.chichkov@yadro.com>
Signed-off-by: Ilya Chichkov <i.chichkov@yadro.com>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 hw/dma/Kconfig             |   4 +
 hw/dma/meson.build         |   1 +
 hw/dma/stm32_dma.c         | 566 +++++++++++++++++++++++++++++++++++++
 hw/dma/trace-events        |  15 +
 include/hw/dma/stm32_dma.h |  46 +++
 5 files changed, 632 insertions(+)
 create mode 100644 hw/dma/stm32_dma.c
 create mode 100644 include/hw/dma/stm32_dma.h

diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 98fbb1bb04..f1483a1ce5 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -30,3 +30,7 @@ config SIFIVE_PDMA
 config XLNX_CSU_DMA
     bool
     select REGISTER
+
+config STM32_DMA
+    bool
+    select REGISTER
\ No newline at end of file
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index cc7810beb8..4db1aca955 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
+system_ss.add(when: 'CONFIG_STM32_DMA', if_true: files('stm32_dma.c'))
diff --git a/hw/dma/stm32_dma.c b/hw/dma/stm32_dma.c
new file mode 100644
index 0000000000..48ad93cf36
--- /dev/null
+++ b/hw/dma/stm32_dma.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU STM32 Direct memory access controller (DMA).
+ *
+ * This includes STM32F1xxxx, STM32F2xxxx and GD32F303x
+ *
+ * Author: 2025 Nikita Shubin <n.shubin@yadro.com>
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/register.h"
+#include "system/dma.h"
+
+#include "trace.h"
+
+#include "hw/dma/stm32_dma.h"
+
+#define STM32_DMA_APERTURE_SIZE 0x400
+
+/* Global interrupt flag */
+#define DMA_ISR_GIF   BIT(0)
+/* Full transfer finish */
+#define DMA_ISR_TCIF  BIT(1)
+/* Half transfer finish */
+#define DMA_ISR_HTIF  BIT(2)
+/* Transfer error */
+#define DMA_ISR_TEIF  BIT(3)
+
+/* Interrupt flag register (DMA_ISR) */
+REG32(DMA_ISR, 0x00)
+    FIELD(DMA_ISR, CHAN0,     0,  4)
+    FIELD(DMA_ISR, CHAN1,     4,  4)
+    FIELD(DMA_ISR, CHAN2,     8,  4)
+    FIELD(DMA_ISR, CHAN3,     12,  4)
+    FIELD(DMA_ISR, CHAN4,     16,  4)
+    FIELD(DMA_ISR, CHAN5,     20,  4)
+    FIELD(DMA_ISR, CHAN6,     24,  4)
+    FIELD(DMA_ISR, RSVD,      28,  4)
+
+/* Interrupt flag clear register (DMA_IFCR) */
+REG32(DMA_IFCR, 0x04)
+    FIELD(DMA_IFCR, CHAN0,     0,  4)
+    FIELD(DMA_IFCR, CHAN1,     4,  4)
+    FIELD(DMA_IFCR, CHAN2,     8,  4)
+    FIELD(DMA_IFCR, CHAN3,     12,  4)
+    FIELD(DMA_IFCR, CHAN4,     16,  4)
+    FIELD(DMA_IFCR, CHAN5,     20,  4)
+    FIELD(DMA_IFCR, CHAN6,     24,  4)
+    FIELD(DMA_IFCR, RSVD,      28,  4)
+
+/* Channel x control register (DMA_CCRx) */
+/* Address offset: 0x08 + 0x14 * x */
+REG32(DMA_CCR, 0x08)
+    FIELD(DMA_CCR, EN,      0,  1)
+    FIELD(DMA_CCR, TCIE,    1,  1)
+    FIELD(DMA_CCR, HTIE,    2,  1)
+    FIELD(DMA_CCR, TEIE,    3,  1)
+
+    /* all below RO if chan enabled */
+    FIELD(DMA_CCR, DIR,     4,  1)
+    FIELD(DMA_CCR, CIRC,    5,  1)
+    FIELD(DMA_CCR, PINC,    6,  1)
+    FIELD(DMA_CCR, MINC,    7,  1)
+    FIELD(DMA_CCR, PSIZE,   8,  2)
+    FIELD(DMA_CCR, MSIZE,   10, 2)
+    FIELD(DMA_CCR, PL,      12, 2)
+    FIELD(DMA_CCR, M2M,     14, 1)
+    FIELD(DMA_CCR, RSVD,    15, 17)
+
+#define DMA_CCR_RO_MASK   \
+    (R_DMA_CCR_DIR_MASK \
+    | R_DMA_CCR_CIRC_MASK \
+    | R_DMA_CCR_PINC_MASK \
+    | R_DMA_CCR_MINC_MASK \
+    | R_DMA_CCR_PSIZE_MASK \
+    | R_DMA_CCR_MSIZE_MASK \
+    | R_DMA_CCR_PL_MASK \
+    | R_DMA_CCR_M2M_MASK)
+
+/* Channel x counter register (DMA_CNDTRx) */
+/* Address offset: 0x0C + 0x14 * x */
+REG32(DMA_CNDTR, 0x0c)
+    FIELD(DMA_CNDTR, NDT,      0,  16)
+    FIELD(DMA_CNDTR, RSVD,     16, 16)
+
+/* Channel x peripheral base address register (DMA_CPARx) */
+/* Address offset: 0x10 + 0x14 * x */
+REG32(DMA_CPAR, 0x10)
+    FIELD(DMA_CPAR, PA,      0,  32)
+
+/* Channel x memory base address register (DMA_CMARx) */
+/* 0x14 + 0x14 * x */
+REG32(DMA_CMAR, 0x14)
+    FIELD(DMA_CMAR, MA,      0,  32)
+
+#define A_DMA_CCR0     0x08
+#define A_DMA_CMAR7    0xa0
+
+static void stm32_dma_chan_update_intr(STM32DmaState *s, uint8_t idx)
+{
+    /* check TCIF, HTIF, TEIF*/
+    uint32_t flags = extract32(s->intf, idx * 4 + 1, 3);
+    /* check TCIE, HTIE, TEIE*/
+    uint32_t ien = extract32(s->chan[idx].chctl, 1, 3);
+
+    if (flags & ien) {
+        /* set GIFCx */
+        set_bit32(idx * 4, &s->intf);
+        qemu_irq_raise(s->output[idx]);
+    }
+}
+
+static MemTxResult stm32_dma_transfer_one(STM32DmaState *s, uint8_t idx)
+{
+    STM32DmaChannel *chan = &s->chan[idx];
+    uint8_t pwidth = 1 << FIELD_EX32(chan->chctl, DMA_CCR, PSIZE);
+    uint8_t mwidth = 1 << FIELD_EX32(chan->chctl, DMA_CCR, MSIZE);
+    hwaddr paddr, maddr;
+    MemTxResult res = MEMTX_OK;
+    uint32_t data = 0;
+
+    paddr = chan->chpaddr;
+    if (FIELD_EX32(chan->chctl, DMA_CCR, PINC)) {
+        /* increment algorithm enabled */
+        uint32_t incr = chan->chcnt_shadow - chan->chcnt;
+
+        paddr += pwidth * incr;
+    }
+
+    maddr = chan->chmaddr;
+    if (FIELD_EX32(chan->chctl, DMA_CCR, MINC)) {
+        /* increment algorithm enabled */
+        uint32_t incr = chan->chcnt_shadow - chan->chcnt;
+
+        maddr += mwidth * incr;
+    }
+
+    /* issue transaction */
+    if (FIELD_EX32(chan->chctl, DMA_CCR, DIR)) {
+        /* FROM memory TO peripheral */
+        res = dma_memory_read(&address_space_memory, maddr, &data,
+                              pwidth, MEMTXATTRS_UNSPECIFIED);
+        if (res) {
+            goto fail_rw;
+        }
+
+        res = dma_memory_write(&address_space_memory, paddr, &data,
+                               mwidth, MEMTXATTRS_UNSPECIFIED);
+        if (res) {
+            goto fail_rw;
+        }
+
+        trace_stm32_dma_transfer(idx, maddr, mwidth,
+                                 paddr, pwidth, data);
+    } else {
+        /* FROM peripheral TO memory */
+        res = dma_memory_read(&address_space_memory, paddr, &data,
+                              pwidth, MEMTXATTRS_UNSPECIFIED);
+        if (res) {
+            goto fail_rw;
+        }
+
+        res = dma_memory_write(&address_space_memory, maddr, &data,
+                               mwidth, MEMTXATTRS_UNSPECIFIED);
+        if (res) {
+            goto fail_rw;
+        }
+
+        trace_stm32_dma_transfer(idx, paddr, pwidth,
+                                 maddr, mwidth, data);
+    }
+
+    /* Issue completed half transfer interrupt */
+    trace_stm32_dma_raise(idx, "HTIE");
+    set_bit(idx * 4 + 2, (unsigned long *)&s->intf);
+
+    return res;
+
+fail_rw:
+    /* Issue transfer error interrupt */
+    trace_stm32_dma_raise(idx, "TEIE");
+    set_bit(idx * 4 + 3, (unsigned long *)&s->intf);
+    trace_stm32_dma_transfer_fail(idx, paddr, maddr);
+
+    return res;
+}
+
+static void stm32_dma_transfer(STM32DmaState *s, uint8_t idx, bool m2m)
+{
+    STM32DmaChannel *chan = &s->chan[idx];
+    MemTxResult res = 0;
+
+    if (!chan->enabled || chan->chcnt == 0) {
+        trace_stm32_dma_disabled(idx, chan->enabled, chan->chcnt);
+        return;
+    }
+
+    do {
+        res = stm32_dma_transfer_one(s, idx);
+        if (res) {
+            goto fail_rw;
+        }
+
+        chan->chcnt--;
+    } while (chan->chcnt && m2m);
+
+    /* rearm counter */
+    if (chan->chcnt == 0) {
+        /* Issue completed full transfer interrupt */
+        trace_stm32_dma_raise(idx, "TCIE");
+        set_bit(idx * 4 + 1, (unsigned long *)&s->intf);
+
+        /* M2M mode can't be circular */
+        if (!FIELD_EX32(chan->chctl, DMA_CCR, M2M) &&
+            FIELD_EX32(chan->chctl, DMA_CCR, CIRC)) {
+            chan->chcnt = chan->chcnt_shadow;
+            trace_stm32_dma_cmen(idx, chan->chcnt);
+        }
+    }
+
+fail_rw:
+    stm32_dma_chan_update_intr(s, idx);
+    return;
+}
+
+static uint32_t stm32_dma_chan_read(STM32DmaState *s, hwaddr addr)
+{
+    uint8_t idx = (addr - A_DMA_CCR0) / 0x14 /* STRIDE */;
+    uint8_t reg = (addr - 0x14 /* STRIDE */ * idx);
+    uint32_t val = 0;
+
+    if (idx > s->nr_chans) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: chan_idx %d exceed %d number of channels\n",
+                      __func__, idx, s->nr_chans);
+        return val;
+    }
+
+    switch (reg) {
+    case A_DMA_CCR:
+        val = s->chan[idx].chctl;
+        break;
+    case A_DMA_CNDTR:
+        val = s->chan[idx].chcnt;
+        break;
+    case A_DMA_CPAR:
+        val = s->chan[idx].chpaddr;
+        break;
+    case A_DMA_CMAR:
+        val = s->chan[idx].chmaddr;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unknown reg 0x%x\n",
+                      __func__, reg);
+        break;
+    }
+
+    trace_stm32_dma_chan_read(addr, idx, reg, val);
+
+    return val;
+}
+
+static uint64_t stm32_dma_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    STM32DmaState *s = STM32_DMA(opaque);
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_DMA_ISR:
+        val = s->intf;
+        break;
+    case A_DMA_CCR0 ... A_DMA_CMAR7:
+        val = stm32_dma_chan_read(s, addr);
+        break;
+    /* write-only */
+    case A_DMA_IFCR:
+    default:
+        /*
+         * TODO: WARN_ONCE ? If left as is produces spam, because many
+         *       people use '|=' on write-only registers.
+         * qemu_log_mask(LOG_GUEST_ERROR,
+         * "%s:  read to unimplemented register " \
+         * "at address: 0x%" PRIx64 " size %d\n",
+         * __func__, addr, size);
+         */
+        break;
+    };
+
+    trace_stm32_dma_read(addr);
+
+    return val;
+}
+
+static void stm32_dma_update_chan_ctrl(STM32DmaState *s, uint8_t idx,
+                                      uint32_t val)
+{
+    int is_enabled, was_enabled;
+
+    was_enabled = !!FIELD_EX32(s->chan[idx].chctl, DMA_CCR, EN);
+    is_enabled = !!FIELD_EX32(val, DMA_CCR, EN);
+
+    if (was_enabled && is_enabled) {
+        uint32_t protected = (s->chan[idx].chctl ^ val) & DMA_CCR_RO_MASK;
+        if (protected) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: attempt to write enabled chan_idx %d settings "
+                          "with val 0x%x\n", __func__, idx, val);
+        }
+
+        val &= ~DMA_CCR_RO_MASK;
+        val |= DMA_CCR_RO_MASK & s->chan[idx].chctl;
+    }
+
+    s->chan[idx].chctl = val;
+    s->chan[idx].enabled = !!FIELD_EX32(s->chan[idx].chctl, DMA_CCR, EN);
+
+    if (!was_enabled && is_enabled) {
+        /* clear flags */
+        s->intf = deposit32(s->intf, idx * 4, 4, 0);
+        if (FIELD_EX32(s->chan[idx].chctl, DMA_CCR, M2M)) {
+            stm32_dma_transfer(s, idx, true);
+        }
+    }
+}
+
+static void stm32_dma_chan_write(STM32DmaState *s, hwaddr addr,
+                                uint64_t val)
+{
+    uint8_t idx = (addr - A_DMA_CCR0) / 0x14 /* STRIDE */;
+    uint8_t reg = (addr - 0x14 /* STRIDE */ * idx);
+
+    if (idx > s->nr_chans) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: chan_idx %d exceed %d number of channels\n",
+                      __func__, idx, s->nr_chans);
+        return;
+    }
+
+    trace_stm32_dma_chan_write(addr, idx, reg, val);
+
+    if (reg == A_DMA_CCR) {
+        stm32_dma_update_chan_ctrl(s, idx, val);
+        return;
+    }
+
+    if (s->chan[idx].enabled) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: attempt to changed enabled chan_idx %d settings\n",
+                      __func__, idx);
+        return;
+    }
+
+    switch (reg) {
+    case A_DMA_CNDTR:
+        s->chan[idx].chcnt = FIELD_EX32(val, DMA_CNDTR, NDT);
+        s->chan[idx].chcnt_shadow = s->chan[idx].chcnt;
+        break;
+    case A_DMA_CPAR:
+        s->chan[idx].chpaddr = val;
+        break;
+    case A_DMA_CMAR:
+        s->chan[idx].chmaddr = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unknown reg 0x%x\n",
+                      __func__, reg);
+        break;
+    }
+}
+
+static void stm32_dma_intr_ack(STM32DmaState *s, uint32_t val)
+{
+    int i, j;
+    uint32_t changed = val & s->intf;
+
+    if (!changed) {
+        return;
+    }
+
+    for (i = 0, j = 0; i < R_DMA_IFCR_RSVD_SHIFT; i += 4, j++) {
+        uint8_t bits_changed = extract32(changed, i, 4);
+        if (bits_changed) {
+            /* clear bits */
+            uint8_t bits = 0;
+
+            /* Clear global interrupt flag of channel */
+            if (!(bits_changed & BIT(0))) {
+                bits = extract32(s->intf, i, 4) & ~bits_changed;
+            }
+
+            s->intf = deposit32(s->intf, i , 4, bits);
+            if (!bits) {
+                trace_stm32_dma_lower(j);
+                qemu_irq_lower(s->output[j]);
+            }
+        }
+    }
+}
+
+static void stm32_dma_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned int size)
+{
+    STM32DmaState *s = STM32_DMA(opaque);
+
+    switch (addr) {
+    case A_DMA_IFCR:
+        stm32_dma_intr_ack(s, val);
+        break;
+    case A_DMA_CCR0 ... A_DMA_CMAR7:
+        stm32_dma_chan_write(s, addr, val);
+        break;
+    /* read-only */
+    case A_DMA_ISR:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s:  write to unimplemented register " \
+                      "at address: 0x%" PRIx64 " size=%d val=0x%" PRIx64 "\n",
+                      __func__, addr, size, val);
+        break;
+    };
+
+    trace_stm32_dma_write(addr, val);
+}
+
+static const MemoryRegionOps dma_ops = {
+    .read =  stm32_dma_read,
+    .write = stm32_dma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void stm32_dma_reset_enter(Object *obj, ResetType type)
+{
+    STM32DmaState *s = STM32_DMA(obj);
+
+    s->intf = 0x0;
+
+    for (int i = 0; i < s->nr_chans; i++) {
+        s->chan[i].chctl = 0;
+        s->chan[i].chcnt = 0;
+        s->chan[i].chpaddr = 0;
+        s->chan[i].chmaddr = 0;
+
+        s->chan[i].enabled = false;
+    }
+
+    trace_stm32_dma_reset("reset_enter");
+}
+
+static void stm32_dma_reset_hold(Object *obj, ResetType type)
+{
+    STM32DmaState *s = STM32_DMA(obj);
+
+    for (int i = 0; i < s->nr_chans; i++) {
+        qemu_irq_lower(s->output[i]);
+    }
+
+    trace_stm32_dma_reset("reset_hold");
+}
+
+/* irq from peripheral */
+static void stm32_dma_set(void *opaque, int line, int value)
+{
+    STM32DmaState *s = STM32_DMA(opaque);
+
+    if (line > s->nr_chans) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s:  requested non-existant line %d > %d\n",
+                      __func__, line, s->nr_chans);
+        return;
+    }
+
+    /* start dma transfer */
+    stm32_dma_transfer(s, line, false);
+
+    trace_stm32_dma_set(line, value);
+}
+
+static void stm32_dma_realize(DeviceState *dev, Error **errp)
+{
+    STM32DmaState *s = STM32_DMA(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &dma_ops, s,
+            TYPE_STM32_DMA, STM32_DMA_APERTURE_SIZE);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(s), stm32_dma_set, s->nr_chans);
+    for (int i = 0; i < s->nr_chans; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->output[i]);
+    }
+}
+
+static const VMStateDescription vmstate_stm32_dma_channel = {
+    .name = "stm32_dma_channel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(enabled, STM32DmaChannel),
+        VMSTATE_UINT32(chctl, STM32DmaChannel),
+        VMSTATE_UINT32(chcnt, STM32DmaChannel),
+        VMSTATE_UINT32(chpaddr, STM32DmaChannel),
+        VMSTATE_UINT32(chmaddr, STM32DmaChannel),
+        VMSTATE_UINT32(chcnt_shadow, STM32DmaChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_stm32_dma = {
+    .name = TYPE_STM32_DMA,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(nr_chans, STM32DmaState),
+        VMSTATE_UINT32(intf,    STM32DmaState),
+        VMSTATE_STRUCT_ARRAY(chan, STM32DmaState, STM32_DMA_CHAN_NUMBER,
+                             1, vmstate_stm32_dma_channel, STM32DmaChannel),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static const Property stm32_dma_properties[] = {
+    DEFINE_PROP_UINT8("nchans", STM32DmaState, nr_chans, STM32_DMA_CHAN_NUMBER),
+};
+
+static void stm32_dma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = stm32_dma_reset_enter;
+    rc->phases.hold = stm32_dma_reset_hold;
+
+    dc->vmsd = &vmstate_stm32_dma;
+    dc->realize = stm32_dma_realize;
+    dc->desc = "STM32 DMA";
+
+    device_class_set_props(dc, stm32_dma_properties);
+}
+
+static const TypeInfo stm32_dma_info = {
+    .name = TYPE_STM32_DMA,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32DmaState),
+    .class_init = stm32_dma_class_init,
+};
+
+static void stm32_dma_register_types(void)
+{
+    type_register_static(&stm32_dma_info);
+}
+
+type_init(stm32_dma_register_types)
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 4c09790f9a..8d70fea582 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -47,3 +47,18 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
 
 # xilinx_axidma.c
 xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
+
+# stm32_dma.c
+stm32_dma_reset(const char *type) "%s"
+stm32_dma_set(int line, int value) "line %d, value %d"
+stm32_dma_transfer(uint8_t idx, uint64_t src, uint8_t swidth, uint64_t dst, uint8_t dwidth, uint32_t data) "idx: %d 0x%08" PRIx64"[%u] -> 0x%08" PRIx64 "[%u] 0x%x"
+stm32_dma_read(uint64_t addr) "address: 0x%08"PRIx64
+stm32_dma_write(uint64_t addr, uint64_t val) "address: 0x%08"PRIx64" data: 0x%08"PRIx64
+stm32_dma_chan_read(uint64_t addr, uint8_t idx, uint8_t reg, uint64_t val) "address: 0x%08"PRIx64" idx: %u reg: %x data: 0x%08"PRIx64
+stm32_dma_chan_write(uint64_t addr, uint8_t idx, uint8_t reg, uint64_t val) "address: 0x%08"PRIx64" idx: %u reg: %x data: 0x%08"PRIx64
+stm32_dma_transfer_fail(uint8_t idx, uint64_t src, uint64_t dst) "idx: %d 0x%08" PRIx64" -> 0x%08" PRIx64
+stm32_dma_raise(uint8_t idx, const char* type) "idx %d: %s"
+stm32_dma_lower(uint8_t idx) "idx %d"
+stm32_dma_cmen(uint8_t idx, uint32_t cnt) "idx %d cnt %u"
+stm32_dma_disabled(uint8_t idx, bool enabled, uint32_t cnt) "idx %d enabled %u cnt %u"
+
diff --git a/include/hw/dma/stm32_dma.h b/include/hw/dma/stm32_dma.h
new file mode 100644
index 0000000000..4777037a71
--- /dev/null
+++ b/include/hw/dma/stm32_dma.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU STM32 Direct memory access controller (DMA).
+ *
+ * This includes STM32F1xxxx, STM32F2xxxx and STM32F30x
+ *
+ * Author: 2025 Nikita Shubin <n.shubin@yadro.com>
+ */
+#ifndef HW_STM32_DMA_H
+#define HW_STM32_DMA_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define STM32_DMA_CHAN_NUMBER    7
+
+#define TYPE_STM32_DMA "stm32-dma"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32DmaState, STM32_DMA)
+
+typedef struct STM32DmaChannel {
+    bool enabled;
+
+    uint32_t chctl;
+    uint32_t chcnt;
+    uint32_t chpaddr;
+    uint32_t chmaddr;
+
+    uint32_t chcnt_shadow;
+} STM32DmaChannel;
+
+typedef struct STM32DmaState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint8_t nr_chans;
+
+    uint32_t intf;
+
+    STM32DmaChannel chan[STM32_DMA_CHAN_NUMBER];
+
+    qemu_irq output[STM32_DMA_CHAN_NUMBER];
+} STM32DmaState;
+
+#endif /* HW_STM32_DMA_H */
-- 
2.48.1


