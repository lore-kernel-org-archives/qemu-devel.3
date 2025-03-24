Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499BC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiLo-0006vl-Qn; Mon, 24 Mar 2025 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLO-0006nN-DC
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLJ-00043J-Q7
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:59:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22423adf751so79588155ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824792; x=1743429592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxKEcv5S9QjMePEO14d+2fv4DpH3hNFE45wGwOXGF1U=;
 b=V9/rFuWjgelzmKc0yyP/MCwILwSOriExsp/gGE4q410VrVvE4SkcT2HZkJ36duhAQq
 5HdxLeObwItNsHW/Z0Rck4lyERnZVxKH6q1SMoHMQ4Z/mmwf39/RkNquX6SDrTYKkh6s
 2IzlbtkrOOe5lg7fR7glw5nJll8CwEnowTajWkufZkfvKHkfh1y+Jwt3J2lQHXr+g45/
 EAXcUz0MK5CoWtf/wd5f2PaOBn0HgM2jR2cdQUfW7HgtZagqW/DnibrDurkwCeG0DKoP
 qznywBn4As09BlltJktbmjLnvMP86GTMKWhSPuorz+dTOgqSnpznRwBfl1ZFt6f+5y9G
 PvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824792; x=1743429592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxKEcv5S9QjMePEO14d+2fv4DpH3hNFE45wGwOXGF1U=;
 b=QJPO67DfCO0/dPjHll3CVOJxkKk3EMKKAlq4YcHAO70kws7otGFbaDLcfEEpHx+JzS
 K/8co9sjozB+2P1vPq7cHSxPICiwIvIaI6k6eqJu4bScrkZnSn+HobNxrqen8YqdDugi
 AjCPrhP8cI3KRRePNRw7P3Q27S0yey42LIGWvQfS51hPp5TXZKn0auZjFi0GpsMjv1Z8
 CTN7I4E7B0/AUotsOFoMGNUQqsrHNaMgZk1qpdBoPfTmusfTi2iVrYyr5xcJylByN6ie
 +VAtSGHPOjXOF1lwqPow9tHBkKz2nfq3ofanEZHQFLfQOLG0YXRwf56I8f++S2YN2xH1
 exrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgoALFOwRQxWJwdvDW1UCykwN/brdb1dcAANOp6brQkXdyCVYirnJwlwyTlqymu6wRWBZa2p2Oy44Q@nongnu.org
X-Gm-Message-State: AOJu0YwfI7iYWzUmOosrsPFevCSKywNAjUVYC7zqnxi+/fQBaTQHrpL+
 4AITWS6gGWj4LZhIcGUx3Qfnms3a3r9rDD9mRakTKX+bXQqMXdq2o4/Fug==
X-Gm-Gg: ASbGncsyAkJTRDEB9OXLa+sBfxpcE+c+ngzooDT/Wqh1GMuMRoufvloyeUEB1r8TJAN
 CqVpNXbU/3xfB8D1NoAQ2gf0cUFBl9jbX+X8glW95QZI7hm1tJKSVfZT1Q+xsFQWstCX+uZfJVZ
 OwfZssc7JQLuO3eLxsRBIDe9WKPE1H6A4MtHmsORZDA1Aqm15g82oXMHckAATW6AzplMP4dgHq6
 a8r3/mzUM8oAJRfRwok7+Kh2rZ4uI1/fhzdaDKB6w39wjXG3r5RIGJWnpQH6CtvRWXG6HXylNdG
 7sPQqAhIQMp7rnlXDrKKSmjqMUshM938sLPzkrpGm09YI7Ix5A==
X-Google-Smtp-Source: AGHT+IHD5IHgRcPuKVkgD1wrHgYslu1D8Mcx6cy+9D3rGGYQlqCyP0T0HJANzsctUS0N3WsRPIAJWQ==
X-Received: by 2002:a05:6a20:2585:b0:1f5:7eb5:72c7 with SMTP id
 adf61e73a8af0-1fe4300f7d1mr21318870637.29.1742824791641; 
 Mon, 24 Mar 2025 06:59:51 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.06.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 06:59:51 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 1/7] vhost: Refactor vhost_svq_add_split
Date: Mon, 24 Mar 2025 19:29:15 +0530
Message-ID: <20250324135929.74945-2-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit refactors vhost_svq_add_split and vhost_svq_add to simplify
their implementation and prepare for the addition of packed vqs in the
following commits.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
No changes from v4 -> v5.

 hw/virtio/vhost-shadow-virtqueue.c | 107 +++++++++++------------------
 1 file changed, 41 insertions(+), 66 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..4f74ad402a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -139,87 +139,48 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
 }
 
 /**
- * Write descriptors to SVQ vring
+ * Write descriptors to SVQ split vring
  *
  * @svq: The shadow virtqueue
- * @sg: Cache for hwaddr
- * @iovec: The iovec from the guest
- * @num: iovec length
- * @addr: Descriptors' GPAs, if backed by guest memory
- * @more_descs: True if more descriptors come in the chain
- * @write: True if they are writeable descriptors
- *
- * Return true if success, false otherwise and print error.
+ * @out_sg: The iovec to the guest
+ * @out_num: Outgoing iovec length
+ * @in_sg: The iovec from the guest
+ * @in_num: Incoming iovec length
+ * @sgs: Cache for hwaddr
+ * @head: Saves current free_head
  */
-static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
-                                        const struct iovec *iovec, size_t num,
-                                        const hwaddr *addr, bool more_descs,
-                                        bool write)
+static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
+                                const struct iovec *out_sg, size_t out_num,
+                                const struct iovec *in_sg, size_t in_num,
+                                hwaddr *sgs, unsigned *head)
 {
+    unsigned avail_idx, n;
     uint16_t i = svq->free_head, last = svq->free_head;
-    unsigned n;
-    uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
+    vring_avail_t *avail = svq->vring.avail;
     vring_desc_t *descs = svq->vring.desc;
-    bool ok;
-
-    if (num == 0) {
-        return true;
-    }
+    size_t num = in_num + out_num;
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
-    if (unlikely(!ok)) {
-        return false;
-    }
+    *head = svq->free_head;
 
     for (n = 0; n < num; n++) {
-        if (more_descs || (n + 1 < num)) {
-            descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
+        descs[i].flags = cpu_to_le16(n < out_num ? 0 : VRING_DESC_F_WRITE);
+        if (n + 1 < num) {
+            descs[i].flags |= cpu_to_le16(VRING_DESC_F_NEXT);
             descs[i].next = cpu_to_le16(svq->desc_next[i]);
+        }
+
+        descs[i].addr = cpu_to_le64(sgs[n]);
+        if (n < out_num) {
+            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
         } else {
-            descs[i].flags = flags;
+            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
         }
-        descs[i].addr = cpu_to_le64(sg[n]);
-        descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
         last = i;
         i = svq->desc_next[i];
     }
 
     svq->free_head = svq->desc_next[last];
-    return true;
-}
-
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
-                                const struct iovec *out_sg, size_t out_num,
-                                const hwaddr *out_addr,
-                                const struct iovec *in_sg, size_t in_num,
-                                const hwaddr *in_addr, unsigned *head)
-{
-    unsigned avail_idx;
-    vring_avail_t *avail = svq->vring.avail;
-    bool ok;
-    g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
-
-    *head = svq->free_head;
-
-    /* We need some descriptors here */
-    if (unlikely(!out_num && !in_num)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Guest provided element with no descriptors");
-        return false;
-    }
-
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
-                                     in_num > 0, false);
-    if (unlikely(!ok)) {
-        return false;
-    }
-
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
-                                     true);
-    if (unlikely(!ok)) {
-        return false;
-    }
 
     /*
      * Put the entry in the available array (but don't update avail->idx until
@@ -233,7 +194,6 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 
-    return true;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -276,16 +236,31 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     unsigned ndescs = in_num + out_num;
     bool ok;
 
+    /* We need some descriptors here */
+    if (unlikely(!ndescs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Guest provided element with no descriptors");
+        return -EINVAL;
+    }
+
     if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
-                             in_addr, &qemu_head);
+    g_autofree hwaddr *sgs = g_new(hwaddr, ndescs);
+    ok = vhost_svq_translate_addr(svq, sgs, out_sg, out_num, out_addr);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
 
+    ok = vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num, in_addr);
+    if (unlikely(!ok)) {
+        return -EINVAL;
+    }
+
+    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
+                        in_num, sgs, &qemu_head);
+
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
-- 
2.48.1


