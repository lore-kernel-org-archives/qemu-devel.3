Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C033C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vb6-0007Zr-7e; Tue, 15 Sep 2026 12:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vb2-0007We-Jv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:24 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vax-0003Nj-9Q
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:24 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f705536so797214666b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488078; x=1790092878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hwsJgss9404Uci4hoxF6xJ6Z+8MMJ+jq2FhSZDgPJU=;
 b=dZDyzH2oVHCAQXSX6w2CNv2QOfV0JbQdEtWOwVVPMjTMJGPoITeP+PYjGXXyEmgRBx
 f2jwtqDEDmTDqk4DbXHU+VJBtLLRgKOwNvcD/JVqOLYOzwwfbyD0BbsPv+Uj9/thkWCI
 TDtr/dsyDx3SC0dXdUZ7SygRQpVZhWi6KUV2XZyqfhTMdXC8AHAX36F/qXnHl/RIfv5S
 JI3F4kDgIWWWGjEizUBmNUamP4MIU80SUM07Qq32/7iLrwIvCSs7JC39xjGQYwjF+75m
 s9F75oMHh2fn5pKuZfKD/+f0+ca6IXMIj1+SySX63zzYE69FaIz7IxouadPYy+i7O7Sk
 1ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488078; x=1790092878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7hwsJgss9404Uci4hoxF6xJ6Z+8MMJ+jq2FhSZDgPJU=;
 b=M8faAoU5iCVStNenBGND/lO7XFgyhh4/GYPvAx19lz0b2DFulOItyteFeejlWTb8k3
 8Df1jOn8ysxO3JjSK+too4TTlhlD+FutatwzYVgAriQuAd+oAnjKyWlopctjJZWjVMtf
 cVXrlbFg5iA+sysWUuNE15JSd5GzUtxDlXFMFdphV0YCEjoCCc0pHBG4KzcYuVcLZQJw
 +gofj6zPtMxUaTc53NNhB5inbMY4yAuuka95GvozVxqAd/pWPYmm1z8FNGLcIKBD/Opq
 YdBo6y2i8RfH+f87kqmXup7IHGm7Oyu5qq2VCaBbWw0je1pcK14IcX/duTspey+V0kl/
 mVFw==
X-Gm-Message-State: AFuF++mFoMEMewhn4FGItF7AIbG3smvJmcWnN5EfCdc0VXrVZsMb2KlE
 twG0XQiAlxDh/Rv7YCZ3nxCGfT30u9VOBGejWfh5z3YiojkdsEDsSuZzthKhVg==
X-Gm-Gg: AYBFou3LK15p3CnhRjLOTgYWhk/EqhNryDj3ocAW5lF+6x2P7FotTJALi+Ceq+7aYL4
 r23Du150o9R9oXImRJ6ylmqGkkzwDJYDR7ojOb4TlUhwxGNGWWSv1dkO/3ygIPbKzWE4n27dsGv
 L9yzB8LCfaXUrJDUAhgZjnnJgj6JcaCK7N/ROe4bvYv8+wf8VRo7sHNHVHTtLYuGs9EJv777H6x
 +L40Jw/qFN0twG2p0Zv/Qzo+iYRbF7cS57iHgbZbnQC+49Va3AMgf5b/7FDjqJNkegi2bMvnqtx
 XMDMJlGvRdllJb+BXSAFz304vCq+ngB9smFSHaetY71WX+fcReAV7669c+U0KONJRjSgK9KNLZV
 jClR605igr2aVuwip5HwU++FJ90RbM3rOKG1sEHTQeFelnDFH+lANj/KCxTIhwyfrmnIExXzHem
 5fR1xiJhdFqij5H7n9XR/qJaw7GZ58jZ21K87DgS6TvZXKuUQRgg4+wOtlSTuUrI8CAt35XXYS7
 DY10uhTZkIncH4wt9Vr1LuImjNlC7M1fdWwSy9XOA83vQ==
X-Received: by 2002:a17:907:18c4:b0:c26:1648:a06e with SMTP id
 a640c23a62f3a-c29b87725e0mr500397766b.41.1789488077569; 
 Tue, 15 Sep 2026 09:01:17 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:16 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 03/20] hw/core: Add Remote Port session state and hello
 protocol
Date: Tue, 15 Sep 2026 18:00:27 +0200
Message-ID: <20260915160044.345788-4-ruslichenko.r@gmail.com>
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the session management for Remote Port protocol.
Key features implemented are following:

- Hello packet handling and capabilities negotiation
- Dynamic packet management routines
- rp_peer_state struct definition to hold negotiated
capabilities.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 134 +++++++++++++++++++++++++++-
 include/hw/core/remote-port-proto.h |  72 +++++++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
index fed52a9734..9439f4b119 100644
--- a/hw/core/remote-port-proto.c
+++ b/hw/core/remote-port-proto.c
@@ -65,7 +65,43 @@ int rp_decode_payload(struct rp_pkt *pkt)
     int used = 0;
 
     switch (pkt->hdr.cmd) {
-    /* TBD */
+    case RP_CMD_hello:
+        assert(pkt->hdr.len >= sizeof pkt->hello.version);
+        pkt->hello.version.major = be16_to_cpu(pkt->hello.version.major);
+        pkt->hello.version.minor = be16_to_cpu(pkt->hello.version.minor);
+        used += sizeof pkt->hello.version;
+
+        if ((pkt->hdr.len - used) >= sizeof pkt->hello.caps) {
+            void *offset;
+            int i;
+
+            pkt->hello.caps.offset = be32_to_cpu(pkt->hello.caps.offset);
+            pkt->hello.caps.len = be16_to_cpu(pkt->hello.caps.len);
+
+            offset = (char *)pkt + pkt->hello.caps.offset;
+            for (i = 0; i < pkt->hello.caps.len; i++) {
+                uint32_t cap;
+
+                /*
+                 * We don't know if offset is 32bit aligned so use
+                 * memcpy to do the endian conversion.
+                 */
+                memcpy(&cap, offset + i * sizeof cap, sizeof cap);
+                cap = be32_to_cpu(cap);
+                memcpy(offset + i * sizeof cap, &cap, sizeof cap);
+            }
+            used += sizeof pkt->hello.caps;
+        } else {
+            pkt->hello.caps.offset = 0;
+            pkt->hello.caps.len = 0;
+        }
+
+        /*
+         * Consume everything ignoring additional headers we do not yet
+         * know about.
+         */
+        used = pkt->hdr.len;
+        break;
     default:
         break;
     }
@@ -81,3 +117,99 @@ void rp_encode_hdr(struct rp_pkt_hdr *hdr, uint32_t cmd, uint32_t id,
     hdr->dev = cpu_to_be32(dev);
     hdr->flags = cpu_to_be32(flags);
 }
+
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *caps_out,
+                            uint32_t caps_len)
+{
+    size_t psize = sizeof *pkt + sizeof caps[0] * caps_len;
+    unsigned int i;
+
+    rp_encode_hdr(&pkt->hdr, RP_CMD_hello, id, dev,
+                  psize - sizeof pkt->hdr, 0);
+    pkt->version.major = cpu_to_be16(version_major);
+    pkt->version.minor = cpu_to_be16(version_minor);
+
+    /* Feature list is appeneded right after the hello packet.  */
+    pkt->caps.offset = cpu_to_be32(sizeof *pkt);
+    pkt->caps.len = cpu_to_be16(caps_len);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        cap = caps[i];
+        caps_out[i] = cpu_to_be32(cap);
+    }
+    return sizeof *pkt;
+}
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len)
+{
+    int i;
+
+    assert(peer->caps.busaccess_ext_base == false);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        memcpy(&cap, caps + i * sizeof cap, sizeof cap);
+
+        switch (cap) {
+        case CAP_BUSACCESS_EXT_BASE:
+            peer->caps.busaccess_ext_base = true;
+            break;
+        case CAP_BUSACCESS_EXT_BYTE_EN:
+            peer->caps.busaccess_ext_byte_en = true;
+            break;
+        case CAP_WIRE_POSTED_UPDATES:
+            peer->caps.wire_posted_updates = true;
+            break;
+        case CAP_ATS:
+            peer->caps.ats = true;
+            break;
+        }
+    }
+}
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size)
+{
+    if (dpkt->size < size) {
+        char *u8;
+        dpkt->pkt = realloc(dpkt->pkt, size);
+        u8 = (void *) dpkt->pkt;
+        memset(u8 + dpkt->size, 0, size - dpkt->size);
+        dpkt->size = size;
+    }
+}
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b)
+{
+    struct rp_pkt *tmp_pkt;
+    size_t tmp_size;
+
+    tmp_pkt = a->pkt;
+    tmp_size = a->size;
+    a->pkt = b->pkt;
+    a->size = b->size;
+    b->pkt = tmp_pkt;
+    b->size = tmp_size;
+}
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt)
+{
+    return dpkt->size > 0 && dpkt->pkt->hdr.len;
+}
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt)
+{
+    assert(rp_dpkt_is_valid(dpkt));
+    dpkt->pkt->hdr.len = 0;
+}
+
+inline void rp_dpkt_free(RemotePortDynPkt *dpkt)
+{
+    dpkt->size = 0;
+    free(dpkt->pkt);
+}
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index f7995ff430..ac7b7a9b96 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -296,6 +296,28 @@ struct rp_pkt {
     };
 };
 
+struct rp_peer_state {
+    void *opaque;
+
+    struct rp_pkt pkt;
+    bool hdr_used;
+
+    struct rp_version version;
+
+    struct {
+        bool busaccess_ext_base;
+        bool busaccess_ext_byte_en;
+        bool wire_posted_updates;
+        bool ats;
+    } caps;
+
+    /* Used to normalize our clk.  */
+    int64_t clk_base;
+
+    struct rp_cfg_state local_cfg;
+    struct rp_cfg_state peer_cfg;
+};
+
 const char *rp_cmd_to_string(enum rp_cmd cmd);
 int rp_decode_hdr(struct rp_pkt *pkt);
 int rp_decode_payload(struct rp_pkt *pkt);
@@ -304,4 +326,54 @@ void rp_encode_hdr(struct rp_pkt_hdr *hdr,
                    uint32_t cmd, uint32_t id, uint32_t dev, uint32_t len,
                    uint32_t flags);
 
+/*
+ * caps is a an array of supported capabilities by the implementor.
+ * caps_out is the encoded (network byte order) version of the
+ * same array. It should be sent to the peer after the hello packet.
+ */
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *features_out,
+                            uint32_t features_len);
+
+/* rp_encode_hello is deprecated in favor of hello_caps.  */
+static inline size_t __attribute__ ((deprecated))
+rp_encode_hello(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                uint16_t version_major, uint16_t version_minor) {
+    return rp_encode_hello_caps(id, dev, pkt, version_major, version_minor,
+                                NULL, NULL, 0);
+}
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len);
+
+/* Dynamically resizable remote port pkt.  */
+
+typedef struct RemotePortDynPkt {
+    struct rp_pkt *pkt;
+    size_t size;
+} RemotePortDynPkt;
+
+/*
+ * Make sure dpkt is allocated and has enough room.
+ */
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size);
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b);
+
+/*
+ * Check if the dpkt is valid. Used for debugging purposes.
+ */
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt);
+
+/*
+ * Invalidate the dpkt. Used for debugging purposes.
+ */
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt);
+
+void rp_dpkt_free(RemotePortDynPkt *dpkt);
+
 #endif
-- 
2.43.0


