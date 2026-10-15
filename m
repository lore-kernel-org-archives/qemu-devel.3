Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7C6CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvb-0001T6-Fx; Thu, 15 Oct 2026 14:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvS-0001P9-Tn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:34 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvQ-0001Th-Ut
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:34 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5338f65913dso19384141cf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087892; x=1792692692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lg+YA8tNFmxKFnPuWfcTaMdwFiX9rJ52s3mZcUCryIM=;
 b=fVElOziAMA9C8uol7FxRwkwnPED3xTU8vctJYXWd1BsF7TVUbNrGCEZWgI8yCA/hHJ
 6pAV09xzE6BhzJhGbetDB1xpeG+FZYU9dhaHAjP9ck8R+v4OAguWTF/9BKIRTBmwEC4N
 dIXGRePhhrbrQw2AI65z6Abs6HiJU9XH8bLM4eS+i15+bbXe9WaQZMdAjErV6vmMB08R
 WRpHAg/NGaqVGRlRA4hWrcsG8Q3xDbFz0tOcQ0EMUk0C0gINFeLjrID+EDcoHjn74jCK
 nneJuEyRM4HaHNzbHx8FCX6Dj05MPLmDB6ZVc2jrRGpvg9gru3EchvBEWcmhoh7ZMUO+
 UrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087892; x=1792692692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lg+YA8tNFmxKFnPuWfcTaMdwFiX9rJ52s3mZcUCryIM=;
 b=B1gwrW25VBXeg2LOJMty36Scmc4MG6GGd15b6pPz6uSyO3dWYyiwL926w/y/g5X1cN
 HYpfG1kBCgRkwfHqmRDyX/FZM3qmLOIxfDf1q29CLjMnQYZ52GOXOFa9LIJ+dsCHud4/
 1GlmwWGKkwrPDvrW6+PxapNgtuMbA8hFu77QLVe5stLmMG+Kp0K7IzsHFC1p7m1z6BaD
 ZUpUG0hLI5xYKcQZr23aSD3Fh/IgoNJbFLZSrV7+9Lh7yV7YPbPXX8xjbW1Jgj6Q1HCl
 RflAlKR8jApb0PYfGZvkVDttHQwp7BRKikA6j73qERSxFhuwYAP17TQEzDfdScA7YP00
 4qmg==
X-Gm-Message-State: AFq9FYKWJWf/UTG5DlB0+JMsn/ilSuGnoL0DpOgaRKSa8Y1Lg6TsTo/Y
 v9TA1ryYQwPIIeByj1aoDYhEnYAkOhbGamCmFGOrJjLcW/rE0BgofLFWOd2uvl4g
X-Gm-Gg: AYBFou28NzaLYkppJUpN2cqa+x4zpSy1TjSkvWKsiG1VJZSCK/hMgmjoHZ24pCavh3B
 jky2gFcN8hXWskenfBVxy+6wy7FzoKbJXcUoAIPCsG/uLWEuwZHhL1vIw3dCrB8WOXpeAhEqwiA
 kMslB0GIyG5N3jEAHCaEQ+WHxn+GVo3D5XeDeNn3rGDJ9u3ezTn/dOK+OiXWveqzXs0YzwnrOhU
 INkw4YLMti/ZMWfQ4IbRgFz7baJfrAYnyg8eJJS+SZrGAqvZOPQ9eoCx29kdq4zddmeVn8V3GvR
 C2hQJM32lUFE6VNU+mGF77DZ/pUaM9j6LuxfYNpcIrnK5ctyBVgA3VNfTH4+pne5gaLgYV2t5w5
 fSEds9WuI18viB3ZRAGyvjsuLjo2HJ1VHoU7wGC4ebOIq19x4QHlwrWt9CZZBMgsO1hlOLgBgLE
 1MeE3FHOeL1H0Ygkaqs2iJi4pbMNmpEPIZlidqdg+ztG3cCfC9sWAoD9RIujO4g5Mfsm/JtEBcq
 HhQlTJELNIJufuGy5LFaH53UNcRi2qm6EULtYa8nTz61AmCUIU/VT9e40GQeBnl1Dh57Q==
X-Received: by 2002:a05:622a:5c08:b0:51c:6b6:9d0b with SMTP id
 d75a77b69052e-5359f498f10mr333206211cf.2.1792087891837; 
 Thu, 15 Oct 2026 11:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:31 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v3 06/16] hw/net/bcm2838_genet: add GENET register structs,
 part 2/4
Date: Thu, 15 Oct 2026 14:11:11 -0400
Message-ID: <20261015181122.60608-7-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x82f.google.com
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

Add the UMAC (CMD, MAC address, MDIO command) and DMA (ring config,
control, producer/consumer index, status, RX descriptor
length/status) register layouts and their field accessors.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 91 ++++++++++++++++++++++++++++++++++
 include/hw/net/bcm2838_genet.h | 89 +++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index ff6602c1f3..12a80534fb 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -20,6 +20,7 @@
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+/* GENET layouts */
 REG32(GENET_SYS_REV_CTRL,              0)
 FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
 FIELD(GENET_SYS_REV_CTRL, MINOR_REV,   16, 4)
@@ -56,6 +57,96 @@ REG32(GENET_INTRL_1,              0)
 FIELD(GENET_INTRL_1, TX_INTRS,    0, 16)
 FIELD(GENET_INTRL_1, RX_INTRS,    16, 16)
 
+REG32(GENET_UMAC_CMD,                  0)
+FIELD(GENET_UMAC_CMD, TX_EN,           0, 1)
+FIELD(GENET_UMAC_CMD, RX_EN,           1, 1)
+FIELD(GENET_UMAC_CMD, SPEED,           2, 2)
+FIELD(GENET_UMAC_CMD, PROMISC,         4, 1)
+FIELD(GENET_UMAC_CMD, PAD_EN,          5, 1)
+FIELD(GENET_UMAC_CMD, CRC_FWD,         6, 1)
+FIELD(GENET_UMAC_CMD, PAUSE_FWD,       7, 1)
+FIELD(GENET_UMAC_CMD, RX_PAUSE_IGNORE, 8, 1)
+FIELD(GENET_UMAC_CMD, TX_ADDR_INS,     9, 1)
+FIELD(GENET_UMAC_CMD, HD_EN,           10, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET_OLD,    11, 1)
+FIELD(GENET_UMAC_CMD, RSVD_12,         12, 1)
+FIELD(GENET_UMAC_CMD, SW_RESET,        13, 1)
+FIELD(GENET_UMAC_CMD, RSVD_14,         14, 1)
+FIELD(GENET_UMAC_CMD, LCL_LOOP_EN,     15, 1)
+FIELD(GENET_UMAC_CMD, RSVD_16_21,      16, 6)
+FIELD(GENET_UMAC_CMD, AUTO_CONFIG,     22, 1)
+FIELD(GENET_UMAC_CMD, CNTL_FRM_EN,     23, 1)
+FIELD(GENET_UMAC_CMD, NO_LEN_CHK,      24, 1)
+FIELD(GENET_UMAC_CMD, RMT_LOOP_EN,     25, 1)
+FIELD(GENET_UMAC_CMD, RX_ERR_DISC,     26, 1)
+FIELD(GENET_UMAC_CMD, PRBL_EN,         27, 1)
+FIELD(GENET_UMAC_CMD, TX_PAUSE_IGNORE, 28, 1)
+FIELD(GENET_UMAC_CMD, TX_RX_EN,        29, 1)
+FIELD(GENET_UMAC_CMD, RUNT_FILTER_DIS, 30, 1)
+FIELD(GENET_UMAC_CMD, RSVD_31,         31, 1)
+
+REG32(GENET_UMAC_MAC_0,         0)
+FIELD(GENET_UMAC_MAC_0, ADDR_3, 0,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_2, 8,  8)
+FIELD(GENET_UMAC_MAC_0, ADDR_1, 16, 8)
+FIELD(GENET_UMAC_MAC_0, ADDR_0, 24, 8)
+
+REG32(GENET_UMAC_MAC_1,             0)
+FIELD(GENET_UMAC_MAC_1, ADDR_5,     0,  8)
+FIELD(GENET_UMAC_MAC_1, ADDR_4,     8,  8)
+FIELD(GENET_UMAC_MAC_1, RSVD_16_31, 16, 8)
+
+REG32(GENET_UMAC_MDIO_CMD,             0)
+FIELD(GENET_UMAC_MDIO_CMD, REG_DATA,   0, 16)
+FIELD(GENET_UMAC_MDIO_CMD, REG_ID,     16, 5)
+FIELD(GENET_UMAC_MDIO_CMD, PHY_ID,     21, 5)
+FIELD(GENET_UMAC_MDIO_CMD, WR,         26, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD,         27, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RD_FAIL,    28, 1)
+FIELD(GENET_UMAC_MDIO_CMD, START_BUSY, 29, 1)
+FIELD(GENET_UMAC_MDIO_CMD, RSVD_30_31, 30, 2)
+
+REG32(GENET_DMA_RING_CFG,             0)
+FIELD(GENET_DMA_RING_CFG, EN,         0, 17)
+FIELD(GENET_DMA_RING_CFG, RSVD_17_31, 17, 14)
+
+REG32(GENET_DMA_CTRL,              0)
+FIELD(GENET_DMA_CTRL, EN,          0, 1)
+FIELD(GENET_DMA_CTRL, RING_BUF_EN, 1, 17)
+FIELD(GENET_DMA_CTRL, RSVD_18_19,  18, 2)
+FIELD(GENET_DMA_CTRL, TSB_SWAP_EN, 20, 1)
+FIELD(GENET_DMA_CTRL, RSVD_21_31,  21, 11)
+
+REG32(GENET_DMA_PROD_INDEX,              0)
+FIELD(GENET_DMA_PROD_INDEX, INDEX,       0, 16)
+FIELD(GENET_DMA_PROD_INDEX, DISCARD_CNT, 16, 16)
+
+REG32(GENET_DMA_CONS_INDEX,             0)
+FIELD(GENET_DMA_CONS_INDEX, INDEX,      0, 16)
+FIELD(GENET_DMA_CONS_INDEX, RSVD_16_31, 16, 16)
+
+REG32(GENET_DMA_STATUS,                     0)
+FIELD(GENET_DMA_STATUS, DISABLED,           0, 1)
+FIELD(GENET_DMA_STATUS, DESC_RAM_INIT_BUSY, 1, 1)
+FIELD(GENET_DMA_STATUS, RSVD_2_31,          2, 30)
+
+#define GENET_DMA_ENABLE_MASK ((1U << 18) - 1)
+
+REG32(GENET_RDMA_LENGTH_STATUS,             0)
+FIELD(GENET_RDMA_LENGTH_STATUS, OVERRUN,    0, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, CRC_ERROR,  1, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RXERR,      2, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, NO,         3, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, LG,         4, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, MULTICAST,  5, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BROADCAST,  6, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_7_11,  7, 5)
+FIELD(GENET_RDMA_LENGTH_STATUS, WRAP,       12, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, SOP,        13, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, EOP,        14, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, OWN,        15, 1)
+FIELD(GENET_RDMA_LENGTH_STATUS, BUFLENGTH,  16, 12)
+FIELD(GENET_RDMA_LENGTH_STATUS, RSVD_28_31, 29, 4)
 
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index af5e8abd2e..b3893c2dad 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,6 +18,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+#define BCM2838_GENET_DMA_DESC_CNT      256
+#define BCM2838_GENET_DMA_RING_CNT      17
+#define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -83,6 +87,88 @@ typedef struct {
     uint32_t reserved_0x18[58];
 } BCM2838GenetRegsTbuf;
 
+typedef struct {
+    uint32_t reserved_0x0;
+    uint32_t hd_bkp_ctrl;
+    uint32_t cmd;
+    uint32_t mac0;
+    uint32_t mac1;
+    uint32_t max_frame_len;
+    uint32_t pause_quanta;
+    uint32_t reserved_0x1C[10];
+    uint32_t mode;
+    uint32_t frm_tag0;
+    uint32_t frm_tag1;
+    uint32_t reserved_0x50[3];
+    uint32_t tx_ipg_len;
+    uint32_t reserved_0x60;
+    uint32_t eee_ctrl;
+    uint32_t eee_lpi_timer;
+    uint32_t eee_wake_timer;
+    uint32_t eee_ref_count;
+    uint32_t reserved_0x74;
+    uint32_t rx_ipg_inv;
+    uint32_t reserved_0x7C[165];
+    uint32_t macsec_prog_tx_crc;
+    uint32_t macsec_ctrl;
+    uint32_t reserved_0x318[6];
+    uint32_t pause_ctrl;
+    uint32_t tx_flush;
+    uint32_t rx_fifo_status;
+    uint32_t tx_fifo_status;
+    uint32_t reserved_0x340[48];
+    uint32_t mib[96];
+    uint32_t mib_ctrl;
+    uint32_t reserved_0x584[36];
+    uint32_t mdio_cmd;
+    uint32_t reserved_0x618[2];
+    uint32_t mpd_ctrl;
+    uint32_t mpd_pw_ms;
+    uint32_t mpd_pw_ls;
+    uint32_t reserved_0x62C[3];
+    uint32_t mdf_err_cnt;
+    uint32_t reserved_0x63C[5];
+    uint32_t mdf_ctrl;
+    uint32_t mdf_addr;
+    uint32_t reserved_0x658[106];
+} BCM2838GenetRegsUmac;
+
+typedef struct {
+    uint32_t length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} BCM2838GenetRdmaDesc;
+
+typedef struct {
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint32_t prod_index;
+    uint32_t cons_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t xon_xoff_tresh;
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint32_t reserved_0x34[3];
+} BCM2838GenetRdmaRing;
+
+typedef struct {
+    BCM2838GenetRdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetRdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    uint32_t ring_cfg;
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t scb_burst_size;
+    uint32_t reserved_0x1050[7];
+    uint32_t ring_timeout[17];
+    uint32_t index2ring[8];
+    uint32_t reserved_0x10D0[972];
+} BCM2838GenetRegsRdma;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -95,6 +181,9 @@ typedef struct {
     uint32_t reserved_0x400[128];
     BCM2838GenetRegsTbuf tbuf;
     uint32_t reserved_0x700[64];
+    BCM2838GenetRegsUmac umac;
+    uint32_t reserved_0x1000[1024];
+    BCM2838GenetRegsRdma rdma;
 } BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.55.0


