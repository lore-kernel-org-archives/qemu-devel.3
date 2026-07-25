Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF3EC531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmr-00023i-Q9; Fri, 24 Jul 2026 21:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTO-000704-7f
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:38 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTM-0000q2-1y
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:37 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5c11362f67eso643806e0c.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940155; x=1785544955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JyRU5HOdFMiswMijymXTpoZPGwe7iOq5G9DNyA3fyig=;
 b=YlGKRlM6EsJuVsr5oUtii2BIamk6gt48OqtpwouT/SuOsCafKBHtJHBAuNn8mh/FKi
 74kAkDn5g78WslHkoXN0caUnXPl4uvevuqphh34qkoPcRmghW8ZJzvXSw6J9TZHtpxMF
 BsADKn97tYv4B4dKCi9egfvep//Hvs+7d2uzK+xi0gacs37Bqv7Rfai/NFGGSrxHCqEN
 sKIo06MCjzNVpT4YcJ61+MDZabVkEgnfLe0Lf9QEoxzcHvlTFAhQ36GiIGg8QY2jK/iX
 oajoxA8QAwYyN6hHyslRIiHMzSkLiG1rEy5FyQMW1joiDZ2Xz2ct+tv8+kW84z3p6Wbf
 kt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940155; x=1785544955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JyRU5HOdFMiswMijymXTpoZPGwe7iOq5G9DNyA3fyig=;
 b=dTlR+5z7nw2diJmvZIGg5nB8uK1jO1F5gSJjxDqJolTwsCakce9mB8RpcbcfpOkxDb
 MLO34Cn5YRKn4vMATPx5ZdUlpxiHjZMJjIVmw6Fu0BdBEo4kczSNlEEM1lbYDftYKPj1
 MCE/teunbfu5bwDsr5xPWOATZ6HYGJ9cbU0mKs+GvK/j18RLwuQ4TydanVGrPWOzM77/
 Wtq+5SD7RywMpCtQzsaPHERpf1WCDyvCEH/k7JSxFmtXE7cxMLdxbComI5CIOdB25/Z5
 A1Vyqh8QoUlRO+D6JIbLQkke0n1UQ97jG5IBz1sfIgI9Exr18Bs3lRRC3Tp3STVte1mi
 MMNw==
X-Gm-Message-State: AOJu0YxOTmq0ac3XSTst19lhheIxdCqrkwMKD6BXRgL27jyq/8BrVIcJ
 slh5Ib2hgkOFxEhnin13UdtzbkcvlM3cWMDlVDW+EKJPhyCRHz0+/Td6jkTSy3Au
X-Gm-Gg: AR+sD111WiLaOVpcod2AaVCUsEQ8z57yyb3vwibioiKoQS/+dl6b3bORFXxSHpSWXtu
 4IEmfilkCG3oTsfCdRIv88DmbN5295132WOK+xb+JjoN7utmN3MG1MmzDIPFxfECgnDSfQgq/4c
 GSOx/BtN99B8CIZw6a62WWAvbYywu81G7ev5WMofBSA+J+QkSgWAULTrZPL20ZOu56i9/RCVDfW
 Qi2d8EuUls8/YiHqG4DN0eDyILtYI/Tev2mz3Mon24wDuEOAjMl5AX61TkahT5uRPebd9LW6S3m
 xnFUVSAsVkorqowYnL5pOb3Wj6nxVBwqF42T7yHt+VRqlzdbvhRY1fQIUmtzjQD/bWKfAC8pxAq
 M4bbnhejJbQ6nWTmH8sulGQAFOuwV05/Tq6tQQrjfRsOpYRt/O6snnBh5suK/alyEsZK9gOc03V
 HWxSTtkKP/1aiDjR6cy39w0qZJ8F1vewcSvZdaaoHWIsw=
X-Received: by 2002:a05:6122:219e:b0:5bd:73b5:6d25 with SMTP id
 71dfb90a1353d-5c306c20b97mr462820e0c.5.1784940155052; 
 Fri, 24 Jul 2026 17:42:35 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:34 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 12/19] hw/net/bcm2838_genet: implement GENET TX path
Date: Fri, 24 Jul 2026 20:42:11 -0400
Message-ID: <20260725004219.66222-13-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

Implement the transmit DMA ring handling: walk TX descriptors
between the consumer and producer index for a ring, pull frame data
out of guest memory, and hand completed frames to the netdev peer
via qemu_send_packet(), advancing the consumer index and raising the
TXDMA_MBDONE interrupt as descriptors complete.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo;
see the later "Fix TX ring activation check" patch for a real bug
found and fixed in the ring-activity check this path depends on.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 221 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |  17 +++
 2 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 7ab6815a..378537ff 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -235,6 +235,13 @@ REG16(GENET_PHY_EXP_SEL,           0)
 FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
 FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
 
+REG32(GENET_TX_CSUM_INFO,            0)
+FIELD(GENET_TX_CSUM_INFO, OFFSET,    0, 15)
+FIELD(GENET_TX_CSUM_INFO, PROTO_UDP, 15, 1)
+FIELD(GENET_TX_CSUM_INFO, START,     16, 15)
+FIELD(GENET_TX_CSUM_INFO, LV,        30, 1)
+
+
 static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
 {
     const MACAddr *addr = &s->nic_conf.macaddr;
@@ -394,6 +401,218 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
     return cmd;
 }
 
+static void bcm2838_genet_xmit_packet(NetClientState *s, void *packet,
+                                      size_t size)
+{
+    uint8_t *buf = packet + sizeof(BCM2838GenetXmitStatus);
+    size_t len = size;
+    uint16_t len_type = 0;
+
+    len -= sizeof(BCM2838GenetXmitStatus);
+    net_checksum_calculate(buf, len, CSUM_ALL);
+
+    memcpy(&len_type, &buf[12], sizeof(len_type));
+    len_type = ntohs(len_type);
+    if (len_type < MAX_PAYLOAD_SIZE) {
+        len_type = len;
+        len_type = htons(len_type);
+        memcpy(&buf[12], &len_type, sizeof(len_type));
+    }
+
+    qemu_send_packet(s, buf, len);
+}
+
+static uint64_t bcm2838_genet_tx(BCM2838GenetState *s, unsigned int ring_index,
+                                 uint32_t prod_index,
+                                 uint32_t cons_index)
+{
+    const unsigned int DESC_SIZE_WORDS
+        = sizeof(BCM2838GenetTdmaDesc) / sizeof(uint32_t);
+    const uint64_t RING_START_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].start_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].start_addr;
+    const uint64_t RING_END_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].end_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].end_addr;
+
+    hwaddr data_addr;
+    uint64_t desc_index;
+    uint32_t desc_status = 0;
+    uint32_t buflength = 0;
+    uint64_t num_descs = 0;
+    uint64_t read_ptr
+        = ((uint64_t)s->regs.tdma.rings[ring_index].read_ptr_hi << 32)
+            + s->regs.tdma.rings[ring_index].read_ptr;
+    off_t packet_off = 0;
+
+    uint32_t prod_index_fld = FIELD_EX32(prod_index,
+                                         GENET_DMA_PROD_INDEX, INDEX);
+    uint32_t cons_index_fld = FIELD_EX32(cons_index,
+                                        GENET_DMA_CONS_INDEX, INDEX);
+
+    while (cons_index_fld != prod_index_fld) {
+        desc_index = read_ptr / DESC_SIZE_WORDS;
+        if (desc_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: invalid TX descriptor index %" PRIu64 " (exceeds %u)\n",
+                __func__, desc_index, BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc_status = s->regs.tdma.descs[desc_index].length_status;
+        data_addr = ((uint64_t)s->regs.tdma.descs[desc_index].address_hi << 32)
+            + s->regs.tdma.descs[desc_index].address_lo;
+        trace_bcm2838_genet_tx(ring_index, desc_index, desc_status,
+                               data_addr);
+
+        if (FIELD_EX32(desc_status, GENET_RDMA_LENGTH_STATUS, SOP) != 0) {
+            packet_off = 0;
+        }
+
+        buflength = FIELD_EX32(desc_status,
+                               GENET_RDMA_LENGTH_STATUS, BUFLENGTH);
+
+        /* TODO: Add address_space_read() return value check */
+        address_space_read(&s->dma_as, data_addr,
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        s->tx_packet + packet_off,
+                                        buflength);
+        packet_off += buflength;
+
+        if (FIELD_EX32(desc_status, GENET_RDMA_LENGTH_STATUS, EOP) != 0) {
+            bcm2838_genet_xmit_packet(qemu_get_queue(s->nic), s->tx_packet,
+                                                     packet_off);
+            packet_off = 0;
+        }
+
+        num_descs++;
+        cons_index_fld++;
+        s->regs.tdma.descs[desc_index].length_status =
+            FIELD_DP32(s->regs.tdma.descs[desc_index].length_status,
+                       GENET_RDMA_LENGTH_STATUS, OWN, 1);
+        read_ptr = read_ptr == RING_END_ADDR + 1 - DESC_SIZE_WORDS
+            ? RING_START_ADDR : read_ptr + DESC_SIZE_WORDS;
+    }
+
+    s->regs.tdma.rings[ring_index].read_ptr = read_ptr;
+    s->regs.tdma.rings[ring_index].read_ptr_hi = read_ptr >> 32;
+
+    return num_descs;
+}
+
+static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ctrl_reg = s->regs.tdma.ctrl;
+    uint32_t ring_cfg_reg = s->regs.tdma.ring_cfg;
+    uint32_t ring_mask = 1 << ring_index;
+    bool dma_en = FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, EN) != 0;
+    bool ring_en =
+        (FIELD_EX32(ring_cfg_reg, GENET_DMA_CTRL, EN) & ring_mask) != 0;
+    bool ring_buf_en =
+        (FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, RING_BUF_EN) & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_tx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+    return active;
+}
+
+static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
+                               uint64_t value)
+{
+    hwaddr ring_offset;
+    uint64_t num_descs_tx;
+    unsigned int ring_index;
+     uint32_t tx_intrs;
+    uint32_t cons_index;
+    uint32_t prod_index = value;
+    uint32_t ring_cfg = value;
+    uint32_t dma_ctrl = value;
+
+    uint32_t cons_index_fld;
+    uint32_t prod_index_fld =
+        FIELD_EX32(prod_index, GENET_DMA_PROD_INDEX, INDEX);
+
+    uint32_t exst_tdma_en =
+        FIELD_EX32(s->regs.tdma.ctrl, GENET_DMA_CTRL, EN);
+    uint32_t exst_ring_en =
+        FIELD_EX32(s->regs.tdma.ring_cfg, GENET_DMA_RING_CFG, EN);
+    uint32_t incm_tdma_en =
+        FIELD_EX32(dma_ctrl, GENET_DMA_CTRL, EN);
+    uint32_t incm_ring_en =
+        FIELD_EX32(ring_cfg, GENET_DMA_RING_CFG, EN);
+    uint32_t incm_ring_buf_en =
+        FIELD_EX32(dma_ctrl, GENET_DMA_CTRL, RING_BUF_EN);
+
+    switch (offset) {
+    case BCM2838_GENET_TDMA_RINGS
+        ... BCM2838_GENET_TDMA_RINGS + sizeof(s->regs.tdma.rings) - 1:
+        ring_index = (offset - BCM2838_GENET_TDMA_RINGS)
+            / sizeof(BCM2838GenetTdmaRing);
+        if (bcm2838_genet_tdma_ring_active(s, ring_index)) {
+            ring_offset = offset - BCM2838_GENET_TDMA_RINGS
+                - ring_index * sizeof(BCM2838GenetTdmaRing);
+            switch (ring_offset) {
+            case BCM2838_GENET_TRING_PROD_INDEX:
+                cons_index = s->regs.tdma.rings[ring_index].cons_index;
+                cons_index_fld = FIELD_EX32(cons_index,
+                                            GENET_DMA_CONS_INDEX, INDEX);
+                if (cons_index_fld != prod_index_fld) {
+                    trace_bcm2838_genet_tx_request(ring_index,
+                                                   prod_index_fld,
+                                                   cons_index_fld);
+                    num_descs_tx = bcm2838_genet_tx(s, ring_index, prod_index,
+                                                    cons_index);
+                    if (num_descs_tx > 0) {
+                        s->regs.tdma.rings[ring_index].cons_index =
+                            FIELD_DP32(s->regs.tdma.rings[ring_index].cons_index,
+                                       GENET_DMA_CONS_INDEX, INDEX,
+                                       cons_index + num_descs_tx);
+
+                        if (ring_index == BCM2838_GENET_DMA_RING_DEFAULT) {
+                            s->regs.intrl0.stat =
+                                FIELD_DP32(s->regs.intrl0.stat, GENET_INTRL_0,
+                                           TXDMA_MBDONE, 1);
+                        } else {
+                            tx_intrs =  FIELD_EX32(s->regs.intrl1.stat,
+                                                   GENET_INTRL_1, TX_INTRS);
+                            s->regs.intrl1.stat =
+                                FIELD_DP32(s->regs.intrl1.stat,
+                                           GENET_INTRL_1, TX_INTRS,
+                                           tx_intrs | 1 << ring_index);
+                        }
+                    }
+                }
+                break;
+            default:
+                break;
+            }
+        }
+        break;
+    case BCM2838_GENET_TDMA_RING_CFG:
+        if (exst_ring_en != incm_ring_en) {
+            trace_bcm2838_genet_tx_dma_ring(incm_ring_en);
+        }
+        break;
+    case BCM2838_GENET_TDMA_CTRL:
+        if (exst_tdma_en != incm_tdma_en) {
+            s->regs.tdma.status = FIELD_DP32(s->regs.tdma.status,
+                                             GENET_DMA_STATUS,
+                                             DISABLED, !exst_tdma_en);
+            trace_bcm2838_genet_tx_dma(incm_tdma_en == 1
+                                       ? "enabled"
+                                       : "disabled");
+        }
+        if (exst_ring_en != incm_ring_buf_en) {
+            trace_bcm2838_genet_tx_dma_ring_buf(incm_ring_buf_en);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -484,7 +703,7 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
+            bcm2838_genet_tdma(s, offset, value);
             break;
         default:
             break;
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index a5e06482..0802ab01 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -108,6 +108,21 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
 #define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
 
+#define MAX_FRAME_SIZE                  0xFFF
+#define MAX_PACKET_SIZE                 1518
+#define MAX_PAYLOAD_SIZE                1500
+#define TX_MIN_PKT_SIZE                 60
+
+
+typedef struct BCM2838GenetXmitStatus {
+    uint32_t  length_status;  /* length and peripheral status */
+    uint32_t  ext_status;     /* Extended status */
+    uint32_t  rx_csum;        /* partial rx checksum */
+    uint32_t  unused1[9];     /* unused */
+    uint32_t  tx_csum_info;   /* Tx checksum info. */
+    uint32_t  unused2[3];     /* unused */
+} BCM2838GenetXmitStatus;
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -403,6 +418,8 @@ struct BCM2838GenetState {
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
+
+    uint8_t tx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.47.1


