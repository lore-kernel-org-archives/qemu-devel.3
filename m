Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B34C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbD-0007hC-N1; Tue, 15 Sep 2026 12:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbC-0007g3-3c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:34 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbA-0003OG-8K
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:33 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f6c7a56so509144266b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488081; x=1790092881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hqn5sYLybz9LYd9ThTYkVIvKptKJIS6KFBdy+ZatTw=;
 b=f+2B82XGxkNS/UzPVWijgr8ZMf1B41qHvk/W5lvUAer4ZTnbhtNQ42Hv+D3oZnxmsW
 v1sUENaoNi2wcTM9qJAChKUoKm9eWXhvIp/A9+ezbGK7TAQ5Ju1QgB7qjZCAVooDgoo9
 T9klwKniCPeA6sx5mPEHwhvUGDV4AQx6Ka1JQou2XJqlhX3uf3FZskuCjtUb3bz+NoHQ
 vg8eiVDiwV5Ss9tL6xPTI1+8e90l0YEUp2W9YmB3k/a2sbff6Tcr3U/t3wsglXAG5TFJ
 FePaqTkK5aGq6mjzs+HitA+jhCb120TEPKQRlrhLFhux1lSv7vIOHDtWW1I/WF6ja8eP
 iRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488081; x=1790092881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1hqn5sYLybz9LYd9ThTYkVIvKptKJIS6KFBdy+ZatTw=;
 b=UW2opTx9P5O6Uubr/Gos0JFlNrFq462+A4gckmWdWVH5DqozXRq+13QO3f/itME62R
 HfUFRDvp6h721aI0z062rPp1ag3bxlPXsz6AlwTHGZtuTIDkZ0dZkZnjinQ446owNKSc
 pZfqe+YJzLtq/LgykFifgX5twNgWiiwRPMhdXkslbLy0SDupfF6sMO1OyK+wkKiNt5vK
 REqYuAeoLghWy+eBXaQ5Jrsu/+E+dYPKFi+0imld2JDS9XoEiRJEf1PQ5dv8NT7whkqK
 48tE2rGmRBpW1P2GuH6H2V0TpuTFuFzq8eX4eAUU/EWhIwEXu/OnJp4yK7JfU8gSMIhx
 nJpg==
X-Gm-Message-State: AFuF++kDr2TUzHEb5GLcxyKLH7jyvo74trzFXRUet4X8a4koklk4kZYl
 iyEumfgVzRUYD/WPmIUzVveeSkFUUh/cjQKBvM1EnKiD+hzglXs7jExjeZuo8w==
X-Gm-Gg: AYBFou0T1e4KDLyBOCVyCjbzBcOqVRlr+e6AmhWZI2xsI/hDyfVfmE9zDRCtG/gGTVP
 y0gZI8yNJvAIAun7cqRC8D656x0So8dxQBPANpLUDN0+ZPGvFf9fuzWKEvI501/QnPlCxw9ZjP5
 Ntt5MjpaHmHfje+wLsAPb8V1yIWuF/B/B3ZjVS/rgoFkrrzH3u4drsWId++4JGDdfPsRgcutZxN
 4tpxkRA0PeauIRU1C+YrHzxOTPaMmTGZmvau33cD1+2gOs4HbLcfbDS2/bAi82CoDMbs6cqfFBK
 FfRqc2rvSS/YuIyrNQXlo355MIOcU9Yf6pvS/GmO1eMl+6j8lfFi7QoU6XXX92g2R7Bm33QYd2e
 /UeCwCkjblnlVAUyVstdAQ9aPjULAJU13TP2gh/07OtsanQyejzwLWDX7RgrJJU4TxMTnmfGGLI
 weWV0OjxaFWiMKPvnnf4B8XnsS+9eSg72L/U+Xo2uQ37Lk0X55WRsbJvaW3JWpngNgB1wt6pr+U
 o0FcpaXCplgGV4OJXUsX5cOUoA0t0P4uAgETRKtY8QkBA==
X-Received: by 2002:a17:907:3f1b:b0:c29:62d8:68b8 with SMTP id
 a640c23a62f3a-c29b874c4d4mr496231866b.48.1789488080807; 
 Tue, 15 Sep 2026 09:01:20 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:20 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 05/20] hw/core: Implement Remote Port irq,
 sync and ATS helpers
Date: Tue, 15 Sep 2026 18:00:29 +0200
Message-ID: <20260915160044.345788-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch add support for encoding and decoding of following
commands:

- RP_CMD_interrupt: propagate gpio and interrupt lines changes
to external peers
- RP_CMD_sync: support for synchronization between QEMU and the
remote model
- RP_CMD_ats_*: handling iommu transactoin request and invalidation
accross the link.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 100 ++++++++++++++++++++++++++++
 include/hw/core/remote-port-proto.h |  29 ++++++++
 2 files changed, 129 insertions(+)

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index ddaefa7e36..0c90ba8971 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -132,6 +132,24 @@ int rp_decode_payload(struct rp_pkt *pkt)
         }
         pkt->busaccess.master_id = master_id;
         break;
+    case RP_CMD_interrupt:
+        pkt->interrupt.timestamp = be64_to_cpu(pkt->interrupt.timestamp);
+        pkt->interrupt.vector = be64_to_cpu(pkt->interrupt.vector);
+        pkt->interrupt.line = be32_to_cpu(pkt->interrupt.line);
+        pkt->interrupt.val = pkt->interrupt.val;
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_sync:
+        pkt->sync.timestamp = be64_to_cpu(pkt->interrupt.timestamp);
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        pkt->ats.attributes = be64_to_cpu(pkt->ats.attributes);
+        pkt->ats.addr = be64_to_cpu(pkt->ats.addr);
+        pkt->ats.len = be64_to_cpu(pkt->ats.len);
+        pkt->ats.result = be32_to_cpu(pkt->ats.result);
+        break;
     default:
         break;
     }
@@ -295,6 +313,88 @@ size_t rp_encode_busaccess(struct rp_peer_state *peer,
     return sizeof *pkt + ret_size;
 }
 
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_interrupt, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    pkt->vector = cpu_to_be64(vector);
+    pkt->line = cpu_to_be32(line);
+    pkt->val = val;
+    return sizeof *pkt;
+}
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val)
+{
+    return rp_encode_interrupt_f(id, dev, pkt, clk, line, vector, val, 0);
+}
+
+static size_t rp_encode_ats_common(uint32_t cmd, uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, cmd, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    pkt->attributes = cpu_to_be64(attr);
+    pkt->addr = cpu_to_be64(addr);
+    pkt->len = cpu_to_be64(len);
+    pkt->result = cpu_to_be32(result);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_req, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_inv, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+static size_t rp_encode_sync_common(uint32_t id, uint32_t dev,
+                                    struct rp_pkt_sync *pkt,
+                                    int64_t clk, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_sync, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = cpu_to_be64(clk);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, 0);
+}
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, RP_PKT_FLAGS_response);
+}
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len)
 {
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index de67cd6501..c86f0657d2 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -472,6 +472,35 @@ size_t rp_encode_busaccess(struct rp_peer_state *peer,
                            struct rp_pkt_busaccess_ext_base *pkt,
                            struct rp_encode_busaccess_in *in);
 
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags);
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val);
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk);
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk);
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
 void rp_process_caps(struct rp_peer_state *peer,
                      void *caps, size_t caps_len);
 
-- 
2.43.0


