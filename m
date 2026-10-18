Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BACCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3u-0002Xl-3p; Sun, 18 Oct 2026 09:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3m-0002Nk-0H
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:23 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3i-0002Il-22
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:20 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-93f1cf92c9eso137497585a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330577; x=1792935377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkUEOvZR0HivkZBApoITVQ28H4P1ZchMtmkyrj4ps1g=;
 b=Hfz7bXjCdDJuZJNToNZmChN4zrC3qoNl3zejbV6Njdv9M2K9RdUDNSeES37HlH3ZQs
 hT353rLAD9Qc0ESZ4vLMEbbnyYvEGLjxv/68nvEP+JoT5vEkehZwc32q9p4keUXHX40g
 41JPkAAI12tS4wIRlNfq/pD/HtIbbGiO+lRZRrZkximM3bD3Wyod925GJ0JInRAI98CK
 A4Icw/xNo1iM9LZnV8VbkDdqQE+g3LmIWvBahgO5J9k9svyrsNsiGutHrZyiq2KJVN8d
 dnEoumKmcXMsk2f7qEMYgY4uRpaATRK61qqA67SfTCNykmqWhUB7ECyzlKojNnPhhPVn
 GU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330577; x=1792935377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zkUEOvZR0HivkZBApoITVQ28H4P1ZchMtmkyrj4ps1g=;
 b=rV0XCbi6gJUedGJWrlh0fodvT+QSeXu20+1NoZtojxBvXBXQx/rmJsyBadPAyBTZ0T
 r8XiDkjO8/28T/ZIC0Z5amf+8E4Kzazrmchky97qhUaqD1wwxUQFbFJwGmynzj01NIGL
 e+Mhf2LUl7A7yKwiF0XMWkaPaTfj5adCs6EqE7nT56rhY5CaWH3LDeMhji0AOSRKtrav
 NWsc3VRB/ooKFSLvpqrtUCffaSQ9XL5WI2DkIusVkR8YNbh5kK3V8d3CNbDhGabV4NuA
 nboO/4jx3DHEGDAFVQqjmjIufxiY2qkxDSVmlkifCEt0Dc6fwdqS/V3UsLgCxw3n8Y5W
 C+qQ==
X-Gm-Message-State: AFq9FYIREA/EwE3Jc+lE34ps01K6RyYHID7Jv/cZ4Dl/sq4a5tSYqLA/
 16isNOWV/3p+0A8WXBbyL4+dDTiTNWmY5zwNdKLVN99jmHMC5lPZJKlKDr2raEi+
X-Gm-Gg: AYBFou1ueHdKK2DBpwoUCCiijrZuipcoMlT9MwDl5Vrbs9/cUcu46BKdsvavDeNsj4C
 o0C7vn7IX15uRy/TeXjdSf2dnLAN/vpsrJkNt2yBevoWoGSLas/VyyY3x9Av1HsCpVk7mczl1dU
 nmExhXEkyqmOvOEPk5miNW8fd54ljloNcY9p//1zAClVNURq+nibOdBQlU+ajYOi46EAHb9sjH0
 9wwX1/UJfrfOVpLe6mHqWD/tRCi7jMPrYoQlPxEK/dysZO/jN1jj9sXZtvNQnJAG7na6Nui2vDc
 YDWQPLuHpsOYUF2PHQ1VErJECmdeGtUUgkjoL6P24QQrjwiKpn3lFSdUqDigB/b0wacUb2Wn2qC
 2btvgvIzLA35p2pnYDnU5gxnx0mweTNX0WVB+0/IMJ9zxMCG6wc7ekAT4hv4PhtndbrPZ+GUug0
 PwnImaaACuJw52bqaN7YWIgj4xoSVqCjs9VyKgKbLt2o+bgsaGwnIWN+SspKdhYbysHU7sWOsxt
 RSjN2rZAQIJ2iGRZQ0hwz4334Dx2wWIkI5HVa40X/acA0kLe30s0RAglBWML2TG37T39rk=
X-Received: by 2002:a05:620a:258d:b0:939:6dea:374d with SMTP id
 af79cd13be357-93f29d813camr874056885a.49.1792330576898; 
 Sun, 18 Oct 2026 06:36:16 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:16 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v4 11/17] hw/net/bcm2838_genet: implement GENET MDIO
Date: Sun, 18 Oct 2026 09:35:57 -0400
Message-ID: <20261018133603.64323-12-marcelomanzo@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the MDIO command register handling used to read/write the
BCM54213PE PHY's standard MII registers (BMCR, BMSR, LPA, ...) plus
its vendor "shadow" register blocks reached through the AUX_CTL/
EXP_SHD indirection scheme, and a simple link-state model (PHY
starts down, comes up once BMCR is programmed and autonegotiation
is (re)started).

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

While carrying this forward, fix the autonegotiation-restart handling
in bcm2838_genet_mdio_cmd(): the guest PHY driver sets BMCR.ANRESTART
and polls BMCR until it reads back as cleared, but the result of
FIELD_DP16() (which returns a new value rather than modifying its
argument) was discarded, so the bit never cleared and the guest
spun forever at boot.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 138 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   3 +-
 2 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index af94c60c88..331a598855 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -216,6 +216,7 @@ FIELD(GENET_PHY_STAT_1000, LOCALRXOK, 13, 1)
 FIELD(GENET_PHY_STAT_1000, MSRES,     14, 1)
 FIELD(GENET_PHY_STAT_1000, MSFAIL,    15, 1)
 
+/* There are two data representations for PHY_AUX_CTRL register */
 REG16(GENET_PHY_AUX_CTRL_0,              0)
 FIELD(GENET_PHY_AUX_CTRL_0, REG_ID_MASK, 0, 3)
 FIELD(GENET_PHY_AUX_CTRL_0, RSVD_3,      3, 1)
@@ -272,6 +273,135 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
     qemu_set_irq(s->irq_prio, level);
 }
 
+static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
+                                            uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID);
+    uint16_t reg_id_mask = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_ID_MASK);
+    uint16_t misc_wren = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, MISC_WREN);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_AUX_CTRL_0, REG_DATA);
+    uint16_t reg_data12 = FIELD_EX16(value, GENET_PHY_AUX_CTRL_1, REG_DATA);
+
+    uint16_t *phy_aux_ctl_shd_reg_id =
+        &s->phy_aux_ctl_shd_regs.regs[reg_id];
+    uint16_t *phy_aux_ctl_shd_reg_id_mask =
+        &s->phy_aux_ctl_shd_regs.regs[reg_id_mask];
+
+    if (reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+        if (reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+            if (misc_wren == 0) {
+                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
+                FIELD_DP16(value, GENET_PHY_AUX_CTRL_0, REG_DATA,
+                          *phy_aux_ctl_shd_reg_id);
+            } else {
+                /* write the 8-bit REG_DATA field to AUX_CTL_MISC */
+                *phy_aux_ctl_shd_reg_id_mask = reg_data;
+            }
+        } else {
+            /* write for subsequent read (12-bit) */
+            FIELD_DP16(value, GENET_PHY_AUX_CTRL_1, REG_DATA,
+                      *phy_aux_ctl_shd_reg_id);
+        }
+    } else {
+        /* write 12 bits */
+        *phy_aux_ctl_shd_reg_id_mask = reg_data12;
+    }
+
+    s->phy_regs.aux_ctl = value;
+}
+
+static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
+                                           uint16_t value)
+{
+    uint16_t reg_id = FIELD_EX16(value, GENET_PHY_SHADOW, REG_ID);
+    uint16_t wr = FIELD_EX16(value, GENET_PHY_SHADOW, WR);
+    uint16_t reg_data = FIELD_EX16(value, GENET_PHY_SHADOW, REG_DATA);
+
+    uint16_t *phy_shd_reg = (uint16_t *)&s->phy_shd_regs + reg_id;
+
+    if (wr == 0) {
+        FIELD_DP16(value, GENET_PHY_SHADOW, REG_DATA, *phy_shd_reg);
+    } else {
+        *phy_shd_reg = reg_data;
+    }
+
+    s->phy_regs.shd = value;
+}
+
+static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
+                                               uint16_t value)
+{
+    /*
+     * TODO Stub implementation without side effect,
+     * just storing registers values
+     */
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    assert(block_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs));
+    assert(reg_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs[0]));
+    s->phy_exp_shd_regs.regs[block_id][reg_id] = value;
+}
+
+static uint16_t bcm2838_genet_phy_exp_shadow_read(BCM2838GenetState *s)
+{
+    uint16_t reg_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                 GENET_PHY_EXP_SEL, REG_ID);
+    uint16_t block_id = FIELD_EX16(s->phy_regs.exp_ctrl,
+                                   GENET_PHY_EXP_SEL, BLOCK_ID);
+
+    assert(block_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs));
+    assert(reg_id < ARRAY_SIZE(s->phy_exp_shd_regs.regs[0]));
+    return s->phy_exp_shd_regs.regs[block_id][reg_id];
+}
+
+static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
+{
+    uint32_t phy_reg_id = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_ID);
+    uint32_t phy_reg_data = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA);
+    uint32_t start_busy = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY);
+    uint32_t rd = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, RD);
+    uint32_t wr = FIELD_EX32(cmd, GENET_UMAC_MDIO_CMD, WR);
+    uint16_t *phy_reg = (uint16_t *)&s->phy_regs + phy_reg_id;
+
+    uint16_t anrestart = FIELD_EX16(phy_reg_data, GENET_PHY_BMCR, ANRESTART);
+
+    if (start_busy != 0) {
+        cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, START_BUSY, 0);
+
+        if (rd != 0) {
+            if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA,
+                                 bcm2838_genet_phy_exp_shadow_read(s));
+            } else {
+                cmd = FIELD_DP32(cmd, GENET_UMAC_MDIO_CMD, REG_DATA, *phy_reg);
+            }
+        } else if (wr != 0) {
+            if (phy_reg_id == BCM2838_GENET_PHY_AUX_CTL) {
+                bcm2838_genet_phy_aux_ctl_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_PHY_SHD) {
+                bcm2838_genet_phy_shadow_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                bcm2838_genet_phy_exp_shadow_write(s, phy_reg_data);
+            } else {
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
+                    /* Initiate auto-negotiation once it has been restarted */
+                    if (anrestart == 1) {
+                        phy_reg_data = FIELD_DP16(phy_reg_data,
+                                                  GENET_PHY_BMCR,
+                                                  ANRESTART, 0);
+                    }
+                }
+                *phy_reg = phy_reg_data;
+            }
+        }
+    }
+
+    return cmd;
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -357,10 +487,13 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
             break;
         case BCM2838_GENET_UMAC_MDIO_CMD:
+            value = bcm2838_genet_mdio_cmd(s, value);
+            s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                             GENET_INTRL_0, MDIO_DONE, 1);
+            break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP,
-                "UMAC MDIO and TDMA aren't implemented yet");
+            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
             break;
         default:
             break;
@@ -462,6 +595,7 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
 
     trace_bcm2838_genet_reset("done");
 
+    bcm2838_genet_set_qemu_mac(s);
     bcm2838_genet_phy_reset(s);
 }
 
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 533848d3c1..9566b2a29a 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -103,7 +103,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_EXP_DATA          BCM2838_GENET_PHY_REG(exp_data)
 #define BCM2838_GENET_EXP_SEL           BCM2838_GENET_PHY_REG(exp_ctrl)
 
-#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_AUXCTL    0x0
+#define BCM2838_GENET_PHY_AUX_CTL_MISC      0x7
 #define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
 
 #define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
-- 
2.55.0


