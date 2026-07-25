Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCD0C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 23:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnlXK-0003kz-9t; Sat, 25 Jul 2026 19:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlX4-0003hH-EI
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:50 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnlX2-0005jL-OL
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 19:11:50 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5c11362f67eso1026513e0c.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785021107; x=1785625907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9/DrSP3MDIUcGpUWTKODc5NEMP8Qerb9nXStJq3dMzc=;
 b=RFFbsPLrQI13VV7zyMZzmuhJVfH75CZqSxEWVsg3jC4VvaHVy7mUijSzSEQw5tzulu
 S820c+zo6rXr08UIzB51NueWJU3FQv3sIWWvtSFGKLd9TzdNZbjPRXlVgSVe8mtFEDX+
 BEofWq/RevJBnMtkbNG/Nr/TpQTcIbyoYMfcl3GGd/YzNTM+t6fFPSP/VuT5QokZK7bM
 JEwfrgEGTlfVCQcDlWsYwcf/koXGwwBxkor1FJwGKI16SQA+54UjIxXuZKpwhe9l7llq
 jfJkvoGSkjq8peA7nsfPyBDRY1CIJ3XuFTLUP2hZW9m50j8FA29qey4ZrNORLp1Etvtk
 6ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785021107; x=1785625907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9/DrSP3MDIUcGpUWTKODc5NEMP8Qerb9nXStJq3dMzc=;
 b=jn47qr0rypBTV86eDZseWeee9XD0LuBajpLqggwKtGmZzAaselk7dxOHAz1RcrdLCi
 LpxOJaBSIsPY/v/ajj/PzkTRZ2xwEjQxQgbTIZ3geIx1LE61abXxAcSy8AzrUkRCJpbp
 lhiXkEEzL6Q0ZGXdxddD0eOuA16cTaf6WslgjQqGh+jvmke+XeywY+SbfRFFEsJv1Ug8
 cFtl8B8i7pHSVcQTmPVcRoTtJ6tozsWT4sJ2WI5iL/DgnhRnwCfYEWOt4cfmvvnUuC3F
 ytAmAamgkpwueEhwnfr6aiCm2zc1DCGMJixxXSFAFUbLVtSfPl41rfU9BNeArJMt8B0c
 OtDw==
X-Gm-Message-State: AOJu0YzGKF/2PWmkAqdwWakQyVdC3QSeH/vJINYXYuLsQSJOXWsl8ZYZ
 SMcWHbGa2xcsuDrK10e/rXi+M2rvbJPiDUQRMfAG9riEsHUr+LrND7a0mDTiYQ==
X-Gm-Gg: AR+sD10t4gA2jr4Ah6JzI0BYfEyAcnRhu2AeNc6vJWMPYICY0l6FMefr70hXCUOxYgp
 OIRr9jZ2k9/eCdScX7A1DHX4bOIpHBvXwjSqYVQDkKvNR1IQi6jBaewo36g4EXvbhnc4qcdVFw0
 TU8iue/E5naxvV+qIuLNe85d1fvMDR9nvXtZ9o6OUihcRfcJTwPDW78tXTU3sP5+QHsK5ZCKcH7
 cLnmi5OMtAeRB8BmfPxiD69KyJZaNQjvJf8GHw9CcKZdXaImGWZjWB5Nq6j57k8zeAOZmPMTaXO
 gw/NLetDepF2Iv+21Z/RORCsl66q83QjmSHAYw5COOTwV973lkq6/viD0BE6ypV4m2ch6dIngAT
 AOrWc5w1TaLtw2xgQKRR3ja0jaUpELIU1GlN42Ekq2SZHdMMNZ891DcGqt9+ecY7X3jV12wUsks
 Wva2yeD7dq8ZbPnbt6We1GAvKkbotaiZDh0A1dOw/j4nk=
X-Received: by 2002:a05:6122:8b11:b0:5bb:eebe:7ffd with SMTP id
 71dfb90a1353d-5c306c7e7ffmr1617920e0c.8.1785021107237; 
 Sat, 25 Jul 2026 16:11:47 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c30549516csm2907015e0c.6.2026.07.25.16.11.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jul 2026 16:11:46 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>, Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 2/2] hw/net/bcm2838_genet: fix per-ring DMA status and RX ring
 selection
Date: Sat, 25 Jul 2026 19:11:42 -0400
Message-ID: <20260725231142.61663-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725231142.61663-1-marcelomanzo@gmail.com>
References: <20260725231142.61663-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa36.google.com
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

Three related GENET DMA-ring bugs, all hit by newer guest drivers that
actually use multiple RX/TX rings instead of relying on the single
default ring:

- BCM2838_GENET_RDMA_CTRL writes never updated the RDMA status
  register at all (only TDMA_CTRL updated a status field, and only a
  single overall DISABLED bit, not per-ring state). Track a proper
  per-ring enable bitmask (bits 0-17, one per ring plus the default
  ring) for both RDMA and TDMA, computed directly from the ctrl
  register's enable bits on every write.

- Enabling a ring via RDMA_CTRL didn't flush any packets that had been
  queued while the ring was disabled, so traffic arriving in the
  window before a ring was enabled was silently dropped instead of
  delivered once it came up. Call qemu_flush_queued_packets() when the
  EN bit is set.

- bcm2838_genet_receive()'s fallback path hardcoded ring
  BCM2838_GENET_DMA_RING_CNT - 1 (the last/default ring) whenever a
  packet didn't match a specific filter, with no check that this ring
  was actually active. Older guest kernels default to this ring, but
  newer ones (observed: Debian 13/Trixie's 6.18 kernel) actively use
  rings 0-4 and never enable the default ring at all, so every
  unfiltered packet was silently dropped. Fall back to scanning for
  the first actually-active ring instead of assuming the last one.

Reset now initializes both status registers to "all rings enabled"
to match real hardware defaults.

Verified against real Raspberry Pi OS images under the patched
raspi4b machine: Bullseye (5.15) and Bookworm (6.12) worked with the
old code (they use the default ring); Trixie (6.18) did not get a
working DHCP lease over GENET without this fix and does with it.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 24 +++++++++++++++++++++---
 include/hw/net/bcm2838_genet.h |  2 ++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 43583aba64..a9798073dc 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -132,6 +132,8 @@ FIELD(GENET_DMA_STATUS, DISABLED,           0, 1)
 FIELD(GENET_DMA_STATUS, DESC_RAM_INIT_BUSY, 1, 1)
 FIELD(GENET_DMA_STATUS, RSVD_2_31,          2, 30)
 
+#define GENET_DMA_ENABLE_MASK ((1U << 18) - 1)
+
 REG32(GENET_RDMA_LENGTH_STATUS,             0)
 FIELD(GENET_RDMA_LENGTH_STATUS, OVERRUN,    0, 1)
 FIELD(GENET_RDMA_LENGTH_STATUS, CRC_ERROR,  1, 1)
@@ -622,10 +624,8 @@ static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
         }
         break;
     case BCM2838_GENET_TDMA_CTRL:
+        s->regs.tdma.status = (~dma_ctrl) & GENET_DMA_ENABLE_MASK;
         if (exst_tdma_en != incm_tdma_en) {
-            s->regs.tdma.status = FIELD_DP32(s->regs.tdma.status,
-                                             GENET_DMA_STATUS,
-                                             DISABLED, !exst_tdma_en);
             trace_bcm2838_genet_tx_dma(incm_tdma_en == 1
                                        ? "enabled"
                                        : "disabled");
@@ -727,6 +727,9 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
                                              GENET_INTRL_0, MDIO_DONE, 1);
             break;
+        case BCM2838_GENET_RDMA_CTRL:
+            s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
+            break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
             bcm2838_genet_tdma(s, offset, value);
@@ -736,6 +739,10 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         memcpy((uint8_t *)&s->regs + offset, &value, size);
+        if (offset == BCM2838_GENET_RDMA_CTRL &&
+            FIELD_EX32(value, GENET_DMA_CTRL, EN)) {
+            qemu_flush_queued_packets(ncs);
+        }
         bcm2838_genet_set_irq_default(s);
         bcm2838_genet_set_irq_prio(s);
     } else {
@@ -927,6 +934,15 @@ static ssize_t bcm2838_genet_receive(NetClientState *nc, const uint8_t *buf,
             ring_index = bcm2838_genet_filter2ring(s, filter_index);
         } else {
             ring_index = BCM2838_GENET_DMA_RING_CNT - 1;
+            if (!bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                for (ring_index = 0;
+                     ring_index < BCM2838_GENET_DMA_RING_CNT - 1;
+                     ring_index++) {
+                    if (bcm2838_genet_rdma_ring_active(s, ring_index)) {
+                        break;
+                    }
+                }
+            }
         }
 
         if (size <= MAX_PACKET_SIZE) {
@@ -1063,6 +1079,8 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
                                       MAJOR_REV, BCM2838_GENET_REV_MAJOR);
     s->regs.sys.rev_ctrl = FIELD_DP32(s->regs.sys.rev_ctrl, GENET_SYS_REV_CTRL,
                                       MINOR_REV, BCM2838_GENET_REV_MINOR);
+    s->regs.rdma.status = GENET_DMA_ENABLE_MASK;
+    s->regs.tdma.status = GENET_DMA_ENABLE_MASK;
 
     trace_bcm2838_genet_reset("done");
 
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 5944e0cef9..960042f6f4 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -55,6 +55,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_TDMA_RINGS        BCM2838_GENET_TDMA_REG(rings)
 #define BCM2838_GENET_TDMA_RING_CFG     BCM2838_GENET_TDMA_REG(ring_cfg)
 #define BCM2838_GENET_TDMA_CTRL         BCM2838_GENET_TDMA_REG(ctrl)
+#define BCM2838_GENET_TDMA_STATUS       BCM2838_GENET_TDMA_REG(status)
 
 #define BCM2838_GENET_RDMA_REGS         offsetof(BCM2838GenetRegs, rdma)
 #define BCM2838_GENET_RDMA_REG(reg)     (BCM2838_GENET_RDMA_REGS \
@@ -62,6 +63,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_RDMA_RINGS        BCM2838_GENET_RDMA_REG(rings)
 #define BCM2838_GENET_RDMA_RING_CFG     BCM2838_GENET_RDMA_REG(ring_cfg)
 #define BCM2838_GENET_RDMA_CTRL         BCM2838_GENET_RDMA_REG(ctrl)
+#define BCM2838_GENET_RDMA_STATUS       BCM2838_GENET_RDMA_REG(status)
 
 #define BCM2838_GENET_TRING_REG(reg)    offsetof(BCM2838GenetTdmaRing, reg)
 #define BCM2838_GENET_TRING_WRITE_PTR BCM2838_GENET_TRING_REG(write_ptr)
-- 
2.47.1


