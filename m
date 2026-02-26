Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF51FC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ4x-000228-DA; Thu, 26 Feb 2026 05:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvZ4v-00020G-QX
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvZ4t-0002ZT-3V
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772103521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNkFhTQFNIqWf75ki6InsEgKV4UEnTN22v0dDJ+FqnU=;
 b=CIDz9PeYV+2XXFyDLZbX9qX+4ATFxXGr07WJCg4wlv/Wuw+4QQQvG8k67qFa4berP/ksgA
 v7MYEdPfaOfzO5KOKb0aR6rDlZWb2xEJF9qGF7WVV/7IlVM3Q2RsruWBLFcgk/096PnrO1
 WY3bzBOY53kTDEK9pyDsf7O7eUbtWHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-xdGZ43QtOL6w8Kh079i7dw-1; Thu,
 26 Feb 2026 05:58:33 -0500
X-MC-Unique: xdGZ43QtOL6w8Kh079i7dw-1
X-Mimecast-MFC-AGG-ID: xdGZ43QtOL6w8Kh079i7dw_1772103512
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C5BC18002CE; Thu, 26 Feb 2026 10:58:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43CAB1800361; Thu, 26 Feb 2026 10:58:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Rob Herring <robh@kernel.org>
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/1] hw/net: Remove the xgmac device
Date: Thu, 26 Feb 2026 11:58:26 +0100
Message-ID: <20260226105826.30481-1-thuth@redhat.com>
In-Reply-To: <CAFEAcA-8s+fryKmgU7U=B4Roh4YsQYdWr005Q4opNd-fN3LoQw@mail.gmail.com>
References: <CAFEAcA-8s+fryKmgU7U=B4Roh4YsQYdWr005Q4opNd-fN3LoQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The xgmac device was only used by the highbank machine that just
has been removed. Being a sysbus device that cannot be instantiated
by the user, this is dead code now and thus can be removed, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/xgmac.c                      | 443 ----------------------------
 hw/net/Kconfig                      |   3 -
 hw/net/meson.build                  |   1 -
 scripts/coverity-scan/COMPONENTS.md |   2 +-
 4 files changed, 1 insertion(+), 448 deletions(-)
 delete mode 100644 hw/net/xgmac.c

diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
deleted file mode 100644
index 204c78aba37..00000000000
--- a/hw/net/xgmac.c
+++ /dev/null
@@ -1,443 +0,0 @@
-/*
- * QEMU model of XGMAC Ethernet.
- *
- * derived from the Xilinx AXI-Ethernet by Edgar E. Iglesias.
- *
- * Copyright (c) 2011 Calxeda, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/core/irq.h"
-#include "hw/core/qdev-properties.h"
-#include "hw/core/sysbus.h"
-#include "exec/cpu-common.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "net/net.h"
-#include "qom/object.h"
-
-#ifdef DEBUG_XGMAC
-#define DEBUGF_BRK(message, args...) do { \
-                                         fprintf(stderr, (message), ## args); \
-                                     } while (0)
-#else
-#define DEBUGF_BRK(message, args...) do { } while (0)
-#endif
-
-#define XGMAC_CONTROL           0x00000000   /* MAC Configuration */
-#define XGMAC_FRAME_FILTER      0x00000001   /* MAC Frame Filter */
-#define XGMAC_FLOW_CTRL         0x00000006   /* MAC Flow Control */
-#define XGMAC_VLAN_TAG          0x00000007   /* VLAN Tags */
-#define XGMAC_VERSION           0x00000008   /* Version */
-/* VLAN tag for insertion or replacement into tx frames */
-#define XGMAC_VLAN_INCL         0x00000009
-#define XGMAC_LPI_CTRL          0x0000000a   /* LPI Control and Status */
-#define XGMAC_LPI_TIMER         0x0000000b   /* LPI Timers Control */
-#define XGMAC_TX_PACE           0x0000000c   /* Transmit Pace and Stretch */
-#define XGMAC_VLAN_HASH         0x0000000d   /* VLAN Hash Table */
-#define XGMAC_DEBUG             0x0000000e   /* Debug */
-#define XGMAC_INT_STATUS        0x0000000f   /* Interrupt and Control */
-/* HASH table registers */
-#define XGMAC_HASH(n)           ((0x00000300/4) + (n))
-#define XGMAC_NUM_HASH          16
-/* Operation Mode */
-#define XGMAC_OPMODE            (0x00000400/4)
-/* Remote Wake-Up Frame Filter */
-#define XGMAC_REMOTE_WAKE       (0x00000700/4)
-/* PMT Control and Status */
-#define XGMAC_PMT               (0x00000704/4)
-
-#define XGMAC_ADDR_HIGH(reg)    (0x00000010+((reg) * 2))
-#define XGMAC_ADDR_LOW(reg)     (0x00000011+((reg) * 2))
-
-#define DMA_BUS_MODE            0x000003c0   /* Bus Mode */
-#define DMA_XMT_POLL_DEMAND     0x000003c1   /* Transmit Poll Demand */
-#define DMA_RCV_POLL_DEMAND     0x000003c2   /* Received Poll Demand */
-#define DMA_RCV_BASE_ADDR       0x000003c3   /* Receive List Base */
-#define DMA_TX_BASE_ADDR        0x000003c4   /* Transmit List Base */
-#define DMA_STATUS              0x000003c5   /* Status Register */
-#define DMA_CONTROL             0x000003c6   /* Ctrl (Operational Mode) */
-#define DMA_INTR_ENA            0x000003c7   /* Interrupt Enable */
-#define DMA_MISSED_FRAME_CTR    0x000003c8   /* Missed Frame Counter */
-/* Receive Interrupt Watchdog Timer */
-#define DMA_RI_WATCHDOG_TIMER   0x000003c9
-#define DMA_AXI_BUS             0x000003ca   /* AXI Bus Mode */
-#define DMA_AXI_STATUS          0x000003cb   /* AXI Status */
-#define DMA_CUR_TX_DESC_ADDR    0x000003d2   /* Current Host Tx Descriptor */
-#define DMA_CUR_RX_DESC_ADDR    0x000003d3   /* Current Host Rx Descriptor */
-#define DMA_CUR_TX_BUF_ADDR     0x000003d4   /* Current Host Tx Buffer */
-#define DMA_CUR_RX_BUF_ADDR     0x000003d5   /* Current Host Rx Buffer */
-#define DMA_HW_FEATURE          0x000003d6   /* Enabled Hardware Features */
-
-/* DMA Status register defines */
-#define DMA_STATUS_GMI          0x08000000   /* MMC interrupt */
-#define DMA_STATUS_GLI          0x04000000   /* GMAC Line interface int */
-#define DMA_STATUS_EB_MASK      0x00380000   /* Error Bits Mask */
-#define DMA_STATUS_EB_TX_ABORT  0x00080000   /* Error Bits - TX Abort */
-#define DMA_STATUS_EB_RX_ABORT  0x00100000   /* Error Bits - RX Abort */
-#define DMA_STATUS_TS_MASK      0x00700000   /* Transmit Process State */
-#define DMA_STATUS_TS_SHIFT     20
-#define DMA_STATUS_RS_MASK      0x000e0000   /* Receive Process State */
-#define DMA_STATUS_RS_SHIFT     17
-#define DMA_STATUS_NIS          0x00010000   /* Normal Interrupt Summary */
-#define DMA_STATUS_AIS          0x00008000   /* Abnormal Interrupt Summary */
-#define DMA_STATUS_ERI          0x00004000   /* Early Receive Interrupt */
-#define DMA_STATUS_FBI          0x00002000   /* Fatal Bus Error Interrupt */
-#define DMA_STATUS_ETI          0x00000400   /* Early Transmit Interrupt */
-#define DMA_STATUS_RWT          0x00000200   /* Receive Watchdog Timeout */
-#define DMA_STATUS_RPS          0x00000100   /* Receive Process Stopped */
-#define DMA_STATUS_RU           0x00000080   /* Receive Buffer Unavailable */
-#define DMA_STATUS_RI           0x00000040   /* Receive Interrupt */
-#define DMA_STATUS_UNF          0x00000020   /* Transmit Underflow */
-#define DMA_STATUS_OVF          0x00000010   /* Receive Overflow */
-#define DMA_STATUS_TJT          0x00000008   /* Transmit Jabber Timeout */
-#define DMA_STATUS_TU           0x00000004   /* Transmit Buffer Unavailable */
-#define DMA_STATUS_TPS          0x00000002   /* Transmit Process Stopped */
-#define DMA_STATUS_TI           0x00000001   /* Transmit Interrupt */
-
-/* DMA Control register defines */
-#define DMA_CONTROL_ST          0x00002000   /* Start/Stop Transmission */
-#define DMA_CONTROL_SR          0x00000002   /* Start/Stop Receive */
-#define DMA_CONTROL_DFF         0x01000000   /* Disable flush of rx frames */
-
-struct desc {
-    uint32_t ctl_stat;
-    uint16_t buffer1_size;
-    uint16_t buffer2_size;
-    uint32_t buffer1_addr;
-    uint32_t buffer2_addr;
-    uint32_t ext_stat;
-    uint32_t res[3];
-};
-
-#define R_MAX 0x400
-
-typedef struct RxTxStats {
-    uint64_t rx_bytes;
-    uint64_t tx_bytes;
-
-    uint64_t rx;
-    uint64_t rx_bcast;
-    uint64_t rx_mcast;
-} RxTxStats;
-
-#define TYPE_XGMAC "xgmac"
-OBJECT_DECLARE_SIMPLE_TYPE(XgmacState, XGMAC)
-
-struct XgmacState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    qemu_irq sbd_irq;
-    qemu_irq pmt_irq;
-    qemu_irq mci_irq;
-    NICState *nic;
-    NICConf conf;
-
-    struct RxTxStats stats;
-    uint32_t regs[R_MAX];
-};
-
-static const VMStateDescription vmstate_rxtx_stats = {
-    .name = "xgmac_stats",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(rx_bytes, RxTxStats),
-        VMSTATE_UINT64(tx_bytes, RxTxStats),
-        VMSTATE_UINT64(rx, RxTxStats),
-        VMSTATE_UINT64(rx_bcast, RxTxStats),
-        VMSTATE_UINT64(rx_mcast, RxTxStats),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_xgmac = {
-    .name = "xgmac",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(stats, XgmacState, 0, vmstate_rxtx_stats, RxTxStats),
-        VMSTATE_UINT32_ARRAY(regs, XgmacState, R_MAX),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void xgmac_read_desc(XgmacState *s, struct desc *d, int rx)
-{
-    uint32_t addr = rx ? s->regs[DMA_CUR_RX_DESC_ADDR] :
-        s->regs[DMA_CUR_TX_DESC_ADDR];
-    cpu_physical_memory_read(addr, d, sizeof(*d));
-}
-
-static void xgmac_write_desc(XgmacState *s, struct desc *d, int rx)
-{
-    int reg = rx ? DMA_CUR_RX_DESC_ADDR : DMA_CUR_TX_DESC_ADDR;
-    uint32_t addr = s->regs[reg];
-
-    if (!rx && (d->ctl_stat & 0x00200000)) {
-        s->regs[reg] = s->regs[DMA_TX_BASE_ADDR];
-    } else if (rx && (d->buffer1_size & 0x8000)) {
-        s->regs[reg] = s->regs[DMA_RCV_BASE_ADDR];
-    } else {
-        s->regs[reg] += sizeof(*d);
-    }
-    cpu_physical_memory_write(addr, d, sizeof(*d));
-}
-
-static void xgmac_enet_send(XgmacState *s)
-{
-    struct desc bd;
-    int frame_size;
-    int len;
-    QEMU_UNINITIALIZED uint8_t frame[8192];
-    uint8_t *ptr;
-
-    ptr = frame;
-    frame_size = 0;
-    while (1) {
-        xgmac_read_desc(s, &bd, 0);
-        if ((bd.ctl_stat & 0x80000000) == 0) {
-            /* Run out of descriptors to transmit.  */
-            break;
-        }
-        len = (bd.buffer1_size & 0xfff) + (bd.buffer2_size & 0xfff);
-
-        /*
-         * FIXME: these cases of malformed tx descriptors (bad sizes)
-         * should probably be reported back to the guest somehow
-         * rather than simply silently stopping processing, but we
-         * don't know what the hardware does in this situation.
-         * This will only happen for buggy guests anyway.
-         */
-        if ((bd.buffer1_size & 0xfff) > 2048) {
-            DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
-                        "xgmac buffer 1 len on send > 2048 (0x%x)\n",
-                         __func__, bd.buffer1_size & 0xfff);
-            break;
-        }
-        if ((bd.buffer2_size & 0xfff) != 0) {
-            DEBUGF_BRK("qemu:%s:ERROR...ERROR...ERROR... -- "
-                        "xgmac buffer 2 len on send != 0 (0x%x)\n",
-                        __func__, bd.buffer2_size & 0xfff);
-            break;
-        }
-        if (frame_size + len >= sizeof(frame)) {
-            DEBUGF_BRK("qemu:%s: buffer overflow %d read into %zu "
-                        "buffer\n" , __func__, frame_size + len, sizeof(frame));
-            DEBUGF_BRK("qemu:%s: buffer1.size=%d; buffer2.size=%d\n",
-                        __func__, bd.buffer1_size, bd.buffer2_size);
-            break;
-        }
-
-        cpu_physical_memory_read(bd.buffer1_addr, ptr, len);
-        ptr += len;
-        frame_size += len;
-        if (bd.ctl_stat & 0x20000000) {
-            /* Last buffer in frame.  */
-            qemu_send_packet(qemu_get_queue(s->nic), frame, len);
-            ptr = frame;
-            frame_size = 0;
-            s->regs[DMA_STATUS] |= DMA_STATUS_TI | DMA_STATUS_NIS;
-        }
-        bd.ctl_stat &= ~0x80000000;
-        /* Write back the modified descriptor.  */
-        xgmac_write_desc(s, &bd, 0);
-    }
-}
-
-static void enet_update_irq(XgmacState *s)
-{
-    int stat = s->regs[DMA_STATUS] & s->regs[DMA_INTR_ENA];
-    qemu_set_irq(s->sbd_irq, !!stat);
-}
-
-static uint64_t enet_read(void *opaque, hwaddr addr, unsigned size)
-{
-    XgmacState *s = opaque;
-    uint64_t r = 0;
-    addr >>= 2;
-
-    switch (addr) {
-    case XGMAC_VERSION:
-        r = 0x1012;
-        break;
-    default:
-        if (addr < ARRAY_SIZE(s->regs)) {
-            r = s->regs[addr];
-        }
-        break;
-    }
-    return r;
-}
-
-static void enet_write(void *opaque, hwaddr addr,
-                       uint64_t value, unsigned size)
-{
-    XgmacState *s = opaque;
-
-    addr >>= 2;
-    switch (addr) {
-    case DMA_BUS_MODE:
-        s->regs[DMA_BUS_MODE] = value & ~0x1;
-        break;
-    case DMA_XMT_POLL_DEMAND:
-        xgmac_enet_send(s);
-        break;
-    case DMA_STATUS:
-        s->regs[DMA_STATUS] = s->regs[DMA_STATUS] & ~value;
-        break;
-    case DMA_RCV_BASE_ADDR:
-        s->regs[DMA_RCV_BASE_ADDR] = s->regs[DMA_CUR_RX_DESC_ADDR] = value;
-        break;
-    case DMA_TX_BASE_ADDR:
-        s->regs[DMA_TX_BASE_ADDR] = s->regs[DMA_CUR_TX_DESC_ADDR] = value;
-        break;
-    default:
-        if (addr < ARRAY_SIZE(s->regs)) {
-            s->regs[addr] = value;
-        }
-        break;
-    }
-    enet_update_irq(s);
-}
-
-static const MemoryRegionOps enet_mem_ops = {
-    .read = enet_read,
-    .write = enet_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static int eth_can_rx(XgmacState *s)
-{
-    /* RX enabled?  */
-    return s->regs[DMA_CONTROL] & DMA_CONTROL_SR;
-}
-
-static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    XgmacState *s = qemu_get_nic_opaque(nc);
-    static const unsigned char sa_bcast[6] = {0xff, 0xff, 0xff,
-                                              0xff, 0xff, 0xff};
-    int unicast, broadcast, multicast;
-    struct desc bd;
-    ssize_t ret;
-
-    if (!eth_can_rx(s)) {
-        return -1;
-    }
-    unicast = ~buf[0] & 0x1;
-    broadcast = memcmp(buf, sa_bcast, 6) == 0;
-    multicast = !unicast && !broadcast;
-    if (size < 12) {
-        s->regs[DMA_STATUS] |= DMA_STATUS_RI | DMA_STATUS_NIS;
-        ret = -1;
-        goto out;
-    }
-
-    xgmac_read_desc(s, &bd, 1);
-    if ((bd.ctl_stat & 0x80000000) == 0) {
-        s->regs[DMA_STATUS] |= DMA_STATUS_RU | DMA_STATUS_AIS;
-        ret = size;
-        goto out;
-    }
-
-    cpu_physical_memory_write(bd.buffer1_addr, buf, size);
-
-    /* Add in the 4 bytes for crc (the real hw returns length incl crc) */
-    size += 4;
-    bd.ctl_stat = (size << 16) | 0x300;
-    xgmac_write_desc(s, &bd, 1);
-
-    s->stats.rx_bytes += size;
-    s->stats.rx++;
-    if (multicast) {
-        s->stats.rx_mcast++;
-    } else if (broadcast) {
-        s->stats.rx_bcast++;
-    }
-
-    s->regs[DMA_STATUS] |= DMA_STATUS_RI | DMA_STATUS_NIS;
-    ret = size;
-
-out:
-    enet_update_irq(s);
-    return ret;
-}
-
-static NetClientInfo net_xgmac_enet_info = {
-    .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState),
-    .receive = eth_rx,
-};
-
-static void xgmac_enet_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    XgmacState *s = XGMAC(dev);
-
-    memory_region_init_io(&s->iomem, OBJECT(s), &enet_mem_ops, s,
-                          "xgmac", 0x1000);
-    sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_irq(sbd, &s->sbd_irq);
-    sysbus_init_irq(sbd, &s->pmt_irq);
-    sysbus_init_irq(sbd, &s->mci_irq);
-
-    qemu_macaddr_default_if_unset(&s->conf.macaddr);
-    s->nic = qemu_new_nic(&net_xgmac_enet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id,
-                          &dev->mem_reentrancy_guard, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    s->regs[XGMAC_ADDR_HIGH(0)] = (s->conf.macaddr.a[5] << 8) |
-                                   s->conf.macaddr.a[4];
-    s->regs[XGMAC_ADDR_LOW(0)] = (s->conf.macaddr.a[3] << 24) |
-                                 (s->conf.macaddr.a[2] << 16) |
-                                 (s->conf.macaddr.a[1] << 8) |
-                                  s->conf.macaddr.a[0];
-}
-
-static const Property xgmac_properties[] = {
-    DEFINE_NIC_PROPERTIES(XgmacState, conf),
-};
-
-static void xgmac_enet_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = xgmac_enet_realize;
-    dc->vmsd = &vmstate_xgmac;
-    device_class_set_props(dc, xgmac_properties);
-}
-
-static const TypeInfo xgmac_enet_info = {
-    .name          = TYPE_XGMAC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(XgmacState),
-    .class_init    = xgmac_enet_class_init,
-};
-
-static void xgmac_enet_register_types(void)
-{
-    type_register_static(&xgmac_enet_info);
-}
-
-type_init(xgmac_enet_register_types)
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 2b513d68958..f9a1dfb80de 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -79,9 +79,6 @@ config NE2000_ISA
 config OPENCORES_ETH
     bool
 
-config XGMAC
-    bool
-
 config ALLWINNER_EMAC
     bool
 
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 913eaedbc52..1feabe991fa 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -22,7 +22,6 @@ system_ss.add(when: 'CONFIG_LAN9118', if_true: files('lan9118.c'))
 system_ss.add(when: 'CONFIG_LAN9118_PHY', if_true: files('lan9118_phy.c'))
 system_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
 system_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
-system_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axienet.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_EMAC', if_true: files('allwinner_emac.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_SUN8I_EMAC', if_true: files('allwinner-sun8i-emac.c'))
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 95805b536bc..02131f1388a 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -4,7 +4,7 @@ alpha
   ~ .*/qemu((/include)?/hw/alpha/.*|/target/alpha/.*)
 
 arm
-  ~ .*/qemu((/include)?/hw/arm/.*|(/include)?/hw/.*/(arm|allwinner-a10|bcm28|digic|exynos|imx|omap|stellaris|pxa2xx|versatile|zynq|cadence).*|/hw/net/xgmac.c|/hw/ssi/xilinx_spips.c|/target/arm/.*)
+  ~ .*/qemu((/include)?/hw/arm/.*|(/include)?/hw/.*/(arm|allwinner-a10|bcm28|digic|exynos|imx|omap|stellaris|pxa2xx|versatile|zynq|cadence).*|/hw/ssi/xilinx_spips.c|/target/arm/.*)
 
 avr
   ~ .*/qemu((/include)?/hw/avr/.*|/target/avr/.*)
-- 
2.53.0


