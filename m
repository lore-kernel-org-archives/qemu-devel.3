Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7A2CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3u-0002YN-PV; Sun, 18 Oct 2026 09:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3n-0002PZ-Vz
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:24 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3l-0002JJ-Aq
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:23 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-93f3c8958d5so26509985a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330579; x=1792935379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FZum1jK0KqRUl0S4M5rYEHWBJ9epdp3DgRzRq/PDH+o=;
 b=aLlMGyL0HD3D+VvFFUydfxeqqokeOXrppf7lkhhNiXOsgJ3efpEnTx6z3m7wVMVe5Z
 Swu5INaUOPnkDEow64G1zO/ykAKA7wPwgPQ4zB0YY1HRfDO1XMuO0nzlrakPA43MrBMF
 W0a4Br+ewaKxlETy9rvcX4M0N3SCpuk6WrqYsDnpy8vPmx1SZKxrnNWsDgH27n4YQVES
 ke4qbyn6WJpBTeR33UQoCXjl/k7luTpU7hl5JEzsc8k6SHiC3lfgTPK3UJAp/EB+kHG9
 +Pk2m3Uc69daRzkNKsJVH4xDSyAgCG8rubjEC2ZHmcxV0tIC+IFMm/MO8w4jWCQ8CkoQ
 LlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330579; x=1792935379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FZum1jK0KqRUl0S4M5rYEHWBJ9epdp3DgRzRq/PDH+o=;
 b=xM13Qz/rqEDqkq357o248JVnL0mVnzYhzRgKlkDF/aTsfzxrGxxDqCYd4etJBXp4jY
 gfm4oxKf/k+0lswTi49xdtsHywdnpezfKspCqmL9H/NoDwY6l3KaH5MlUSCleyWZh03X
 sSTjs1CJks5KCY/j7hSzs3lWgL15EI7sJAHkXZNwN1e+M4faYHk9gzCi18bFopx6esbc
 qjHyckQ55TwqscZEcPC3kZphFbN0lWsHuw2r9F743U8RKON2knESczte4rVaU3Qef5YZ
 Q4A+yb5LupJoZcDL1t1DR7ffMwVrPxMtq57WnB/GVbPYaYJGxvTzpxTu+NMQySvAcjqo
 20bg==
X-Gm-Message-State: AFq9FYLGBNCTIpZLE7lAjis3QKdrTefMr2xoBK4+Jt+PniaIQaIlps3g
 IBNneThae3rRTtglyG0MNc8KMf90HfRbLqMdZdpqbUXC90FmuOEOQNdBjfbLn0U1
X-Gm-Gg: AYBFou3KXWUdXdLdJGNLOyQS6DF5Xk6D0xJ6Icgo/7wLmjC8YKf5HqjHQqfmxjPgubd
 OLrAzdMJBy8ig4VgXpWfwIg3NjFQ9XO1q6d2VcgJf+OgpxF5HKXyZWf0/SDFzillipaXrzUbrz5
 h01qOmVKQMJxveAbMCsbWnbMaMtgdcCqv+WsVT3WSOaCIJ9LyH6i/XpMOpe+V6X5/afAXmrgea7
 Y1vkuVObniWObgWMPFCSfrymcVTwCCyr6iSmSiHIqePLg+Y5MaGcQL2qLI6H34NK2H+wQg9UUI1
 PsHfFAJjngUAZNunooGbvyAxrhh5TxBqUBXKoo2ZeY8Arh5Ghx12UInhpTPMBIFH8HkypTJmGV/
 t20E4H3YcgPhDzf5vYwrIrGhi9tfr5bslDpbhiCyikYlhDuXsB4hKN9fMmXSzBfEswKTJEfvKfz
 1I8FsQIw5320Olp/vxBr99u0ZlGgSLpYjip+GUzPPEpSHS67pr24awGeJXGRMVEuQyGp1fm1slA
 gO60lPoGu6ZNoKOm+6zOYQGOjuGvQhSwlpFUB/81IoXTPIVIPGfZFn/j6atQTK5SNFU8t0=
X-Received: by 2002:a05:620a:691a:b0:93b:d7a1:ba16 with SMTP id
 af79cd13be357-93f29da97bemr921621785a.65.1792330579157; 
 Sun, 18 Oct 2026 06:36:19 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:18 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v4 13/17] hw/net/bcm2838_genet: implement GENET RX path
Date: Sun, 18 Oct 2026 09:35:59 -0400
Message-ID: <20261018133603.64323-14-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72a.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Implement the receive DMA ring handling: qemu_can_receive()/
receive() callbacks for the NIC's netdev peer, copying incoming
frame data into descriptor buffers on the active RX ring,
classifying broadcast/multicast, and raising the RXDMA_MBDONE
interrupt as descriptors complete.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

While carrying this forward, make these changes to the original code:

 - Report no hardware-computed RX checksum (rx_csum = 0). The original
   stored the IPv4 header checksum in host byte order, but the guest's
   CHECKSUM_COMPLETE path expects a running checksum over the L4
   payload, which made the guest reject otherwise-valid inbound
   packets ("hw csum failure" in bcmgenet_rx_poll()) and broke
   DHCP/connectivity intermittently. With 0 the guest verifies
   checksums in software instead.
 - Fill in the per-packet status block with stl_le_p() rather than by
   casting the packet buffer to a C struct, which is undefined
   behaviour for a misaligned buffer and wrong on big-endian hosts.
 - Refresh the link state once a BMCR autonegotiation restart has been
   handled by the MDIO code (moved here from the MDIO patch, where the
   function it calls does not exist yet).
 - Validate the guest-programmed descriptor indexes against the size
   of the descriptor array, and limit the DMA write to the size of our
   packet buffer, so that a guest-controlled register can't make us
   access memory outside them.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 286 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 286 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 7274a66d8f..e20358c8e7 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,8 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
+
 /* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
@@ -402,6 +404,9 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
                     }
                 }
                 *phy_reg = phy_reg_data;
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR && anrestart == 1) {
+                    bcm2838_genet_phy_update_link(s);
+                }
             }
         }
     }
@@ -585,6 +590,24 @@ static void bcm2838_genet_tdma_prod_index_write(BCM2838GenetState *s,
     }
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+
+    bool dma_en = FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN);
+    bool ring_en = FIELD_EX32(s->regs.rdma.ring_cfg, GENET_DMA_RING_CFG, EN)
+                   & ring_mask;
+    bool ring_buf_en = FIELD_EX32(s->regs.rdma.ctrl,
+                                  GENET_DMA_CTRL, RING_BUF_EN) & ring_mask;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_rx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+
+    return active;
+}
+
 static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
                                uint64_t value)
 {
@@ -764,9 +787,268 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4, .max_access_size = 4},
 };
 
+static int32_t bcm2838_genet_filter(BCM2838GenetState *s, const void *buf,
+                                    size_t size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static int32_t bcm2838_genet_filter2ring(BCM2838GenetState *s,
+                                         uint32_t filter_idx)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static bool is_packet_broadcast(const uint8_t *buf, size_t size)
+{
+    static const uint8_t bcst_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+    if (size < sizeof(bcst_addr)) {
+        return false;
+    }
+
+    return !memcmp(buf, bcst_addr, sizeof(bcst_addr));
+}
+
+static bool is_packet_multicast(const uint8_t *buf, size_t size)
+{
+    return !!(buf[0] & 0x01);
+}
+
+static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
+                                  const void *buf, size_t size)
+{
+    const size_t desc_word_size =
+        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
+
+    ssize_t len = 0;
+    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
+    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
+    hwaddr write_index =
+        bcm2838_genet_make_u64(ring->write_ptr_hi, ring->write_ptr)
+        / desc_word_size;
+    BCM2838GenetRdmaDesc *desc;
+
+    const hwaddr start_index =
+        bcm2838_genet_make_u64(ring->start_addr_hi, ring->start_addr)
+        / desc_word_size;
+    const hwaddr end_index =
+        bcm2838_genet_make_u64(ring->end_addr_hi, ring->end_addr)
+        / desc_word_size;
+
+    if (!bcm2838_genet_rdma_ring_active(s, ring_idx)) {
+        return -1;
+    }
+
+    if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid RX descriptor index %" PRIu64
+                      " (exceeds %u)\n", __func__, (uint64_t)write_index,
+                      BCM2838_GENET_DMA_DESC_CNT - 1);
+        return -1;
+    }
+    desc = &rdma->descs[write_index];
+
+    desc->length_status = FIELD_DP32(desc->length_status,
+                                     GENET_RDMA_LENGTH_STATUS, SOP, 1);
+
+    while (len < size) {
+        size_t l = size - len;
+        size_t buf_size = MIN(ring->ring_buf_size & 0xffff,
+                              sizeof(s->rx_packet));
+        uint8_t *dma_buf = s->rx_packet;
+        hwaddr dma_buf_addr =
+            bcm2838_genet_make_u64(desc->address_hi, desc->address_lo);
+        MemTxResult mem_tx_result = MEMTX_OK;
+        uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
+
+        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        size_t buflength;
+        uint32_t prod_index;
+
+        if (l > ring->ring_buf_size) {
+            l = ring->ring_buf_size;
+        }
+
+        memcpy(frame_buf, buf + len, l);
+
+        len += l;
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         EOP, !!(len >= size));
+
+        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
+        if (crc_fwd) {
+            buflength += 4;
+        }
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BUFLENGTH, buflength);
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BROADCAST,
+                                         !!is_packet_broadcast(frame_buf, l));
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         MULTICAST,
+                                         !!is_packet_multicast(frame_buf, l));
+
+        /*
+         * We don't implement the hardware's partial RX checksum: report 0 and
+         * rely on the guest verifying checksums in software.
+         */
+        stl_le_p(dma_buf + offsetof(BCM2838GenetXmitStatus, rx_csum), 0);
+        stl_le_p(dma_buf + offsetof(BCM2838GenetXmitStatus, length_status),
+                 desc->length_status);
+
+        mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            dma_buf, buf_size);
+        if (mem_tx_result != MEMTX_OK) {
+            desc->length_status = FIELD_DP32(desc->length_status,
+                                             GENET_RDMA_LENGTH_STATUS,
+                                             RXERR, 1);
+        }
+
+        if (FIELD_EX32(desc->length_status,
+                       GENET_RDMA_LENGTH_STATUS, RXERR) != 0) {
+            break;
+        }
+
+        prod_index = FIELD_EX32(ring->prod_index, GENET_DMA_PROD_INDEX, INDEX);
+        ring->prod_index = FIELD_DP32(ring->prod_index,
+                                      GENET_DMA_PROD_INDEX,
+                                      INDEX, ++prod_index);
+        if (++write_index > end_index) {
+            write_index = start_index;
+        }
+        if (write_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid RX descriptor index %" PRIu64
+                          " (exceeds %u)\n", __func__, (uint64_t)write_index,
+                          BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * desc_word_size;
+        ring->write_ptr_hi = ((hwaddr)write_index * desc_word_size) >> 32;
+    }
+
+    if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, RXDMA_MBDONE, 1);
+    } else {
+        uint32_t rx_intrs =
+            FIELD_EX32(s->regs.intrl1.stat, GENET_INTRL_1, RX_INTRS);
+        rx_intrs |= 1 << ring_idx;
+
+        s->regs.intrl1.stat = FIELD_DP32(s->regs.intrl1.stat,
+                                         GENET_INTRL_1, RX_INTRS, rx_intrs);
+    }
+
+    return len;
+}
+
+static ssize_t bcm2838_genet_receive(NetClientState *nc, const uint8_t *buf,
+                                     size_t size)
+{
+    BCM2838GenetState *s = (BCM2838GenetState *)qemu_get_nic_opaque(nc);
+    ssize_t bytes_received = -1;
+    int32_t filter_index = -1;
+    int32_t ring_index = -1;
+
+    if (FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN) != 0) {
+        filter_index = bcm2838_genet_filter(s, buf, size);
+
+        if (filter_index >= 0) {
+            ring_index = bcm2838_genet_filter2ring(s, filter_index);
+        } else {
+            ring_index = BCM2838_GENET_DMA_RING_CNT - 1;
+            if (!bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                for (ring_index = 0;
+                     ring_index < BCM2838_GENET_DMA_RING_CNT - 1;
+                     ring_index++) {
+                    if (bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                        break;
+                    }
+                }
+            }
+        }
+
+        if (size <= MAX_PACKET_SIZE) {
+            bytes_received = bcm2838_genet_rdma(s, ring_index, buf, size);
+        }
+    }
+
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
+
+    return bytes_received;
+}
+
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s)
+{
+    bool qemu_link_down = qemu_get_queue(s->nic)->link_down;
+
+    bool lstatus = FIELD_EX32(s->phy_regs.bmsr, GENET_PHY_BMSR, LSTATUS);
+
+    if (qemu_link_down && lstatus) {
+        trace_bcm2838_genet_phy_update_link("down");
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 0);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 0);
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_DOWN, 1);
+    } else if (!qemu_link_down && !lstatus) {
+        trace_bcm2838_genet_phy_update_link("up");
+
+        /*
+         * Complete auto-negotiation (fixed link partner's abilities for now:
+         * 1Gbps with flow control)
+         */
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, HALF, 1);
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, FULL, 1);
+
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_CAP, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_ASYM, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa, GENET_PHY_LPA, LPACK, 1);
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 1);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 1);
+
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_UP, 1);
+    }
+
+    bcm2838_genet_set_irq_default(s);
+}
+static void bcm2838_genet_set_link(NetClientState *nc)
+{
+    BCM2838GenetState *s = qemu_get_nic_opaque(nc);
+
+    bcm2838_genet_phy_update_link(s);
+}
+
 static NetClientInfo bcm2838_genet_client_info = {
     .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState)
+    .size = sizeof(NICState),
+    .receive = bcm2838_genet_receive,
+    .link_status_changed = bcm2838_genet_set_link,
 };
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
@@ -820,6 +1102,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.regs[BCM2838_GENET_PHY_AUX_CTL_MISC] = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(Object *obj, ResetType type)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 28529381d1..63af38d412 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -419,6 +419,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 /*
-- 
2.55.0


