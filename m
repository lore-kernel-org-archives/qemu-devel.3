Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F18C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiMK-0007KW-Tw; Mon, 24 Mar 2025 10:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLW-0006qq-OG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLU-00044o-6S
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fb0f619dso86567905ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824802; x=1743429602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzcbUoou4CVLHbkouLzdDRuspui/6y1Jg7LHkEflb4I=;
 b=hslabvdAH7Ns6WZPZLGYQD9OKp4TNfCYD1mxhMvZ36MEU3MaGUabO5Obt7fTQcYgR+
 o0TEV6qyQxI2T8jz6zwc6E78ArmZ+3B+U35Yjk7DZ2/wWEvQIqD2rxHb2jh2WwjmG0Pn
 H9T+C5vQqn1Zlq2NG1IgSjwcWB0/EDWQyHkFw8wr56ARSd33E7d8r5tvWolwTnbV/m6Z
 OYWe81d2HiKxqUOoEvPb6mj3ht89fdd3Bi6LEVsRZXZNlKATwHDwWyeqfeexCakuGr9E
 7f+EGAOxoRJqOD0evf5rkc5cHX1l3gZCNJ5/H+rFoo5Z6AwWBmgnIxL7yY4774/zQMtm
 W74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824802; x=1743429602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzcbUoou4CVLHbkouLzdDRuspui/6y1Jg7LHkEflb4I=;
 b=lGn8SbyfzJfXhUJSoV/Q2doCBWzvQoYrfNhO1TWuxUPtySEMpn9rH1WwDFDbwATgOi
 oj0LN2P9qfAjvIvmsm/erlU8L2CxxH4bEotavwdsKF0y+2EYzFRkLPTEBJRcoy3gTNVN
 sbfn++HrKbO72BW+/fZyaSrMOqm535d5lftJ2mLQ031VPrR00agoTwQvMspeHaKroslq
 LBhF94l9mlHYvRqOGwyDVAjvsuJZNBO4EfNVbW+rhNLFEqy2207eLmelcdQGfVvlRxdQ
 HLaH3SzihZPlM60LjXTOvLD23nsqs4uE0a93D5ewmg/2rP1xbcrFOtuuo4KW1pEqL6hi
 JI4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLF7dl/e5HKylQtEFG5T6OHIl1ANlNCjQI1W5R/8EMtGFa11DYFLg3cCyk+iR16deP192BfyuNfaZp@nongnu.org
X-Gm-Message-State: AOJu0YzB5z3J+vzO1sIG7N0Z2itdx7RPrQ+t9031dd3b60/jSnp1B2vy
 1+qZjMVi/ThlEpVRxD/66XsL++f/2OVzDeaOC0bEfGwz4M7kJkzY7Z7SCQ==
X-Gm-Gg: ASbGncs4vUoLF3OAwENrJEOmv33pnUBvVuy+3PKlSzesERP328RxHVcplQ5hxROM6Q/
 A7fudIJRP+6R8Y8XlFy4pnGBYoGMDjFEdWfIPzszwG+11cwh4sXUmxRqSdZT3AfdSwC+8zNgKIZ
 hUWOUjyTcs4nmyOQT9myuZ6MIzp5UNfgi7mbCFETtkDhdjQvMNqdPosUTdcQuorSujdgPRLei3I
 8tg1+Fp2S/9ukQZFVv2lC/NFnqUsn6UJO32n0NRPwtKIPg98GZtZCzutijhRsX2iIyVq2hsZJmc
 prM+0SJq3c228JsiPm3SS9MQP8VSy9wIahsZ/B8=
X-Google-Smtp-Source: AGHT+IHVvyMoAJPrxMDcE9ef80YtffcNQ77CKqpnUQXXMq3Ad4WHllFadbSeey+xxPGTQsLvXEWTeA==
X-Received: by 2002:a05:6a00:2288:b0:736:53bc:f1ab with SMTP id
 d2e1a72fcca58-7390599aa32mr20143425b3a.12.1742824801657; 
 Mon, 24 Mar 2025 07:00:01 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.06.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:00:01 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
Date: Mon, 24 Mar 2025 19:29:17 +0530
Message-ID: <20250324135929.74945-4-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62b.google.com
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

Implement the insertion of available buffers in the descriptor area of
packed shadow virtqueues. It takes into account descriptor chains, but
does not consider indirect descriptors.

Enable the packed SVQ to forward the descriptors to the device.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- This was commit #2 in v4. This has been reordered to commit #3
  based on review comments.
- vhost-shadow-virtqueue.c:
  (vhost_svq_valid_features): Move addition of enums to commit #6
  based on review comments.
  (vhost_svq_add_packed): Set head_idx to buffer id instead of vring's
  index.
  (vhost_svq_kick): Split into vhost_svq_kick_split and
  vhost_svq_kick_packed.
  (vhost_svq_add): Use new vhost_svq_kick_* functions.

 hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 4f74ad402a..6e16cd4bdf 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
     /* Update the avail index after write the descriptor */
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
+}
+
+/**
+ * Write descriptors to SVQ packed vring
+ *
+ * @svq: The shadow virtqueue
+ * @out_sg: The iovec to the guest
+ * @out_num: Outgoing iovec length
+ * @in_sg: The iovec from the guest
+ * @in_num: Incoming iovec length
+ * @sgs: Cache for hwaddr
+ * @head: Saves current free_head
+ */
+static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
+                                 const struct iovec *out_sg, size_t out_num,
+                                 const struct iovec *in_sg, size_t in_num,
+                                 hwaddr *sgs, unsigned *head)
+{
+    uint16_t id, curr, i, head_flags = 0, head_idx;
+    size_t num = out_num + in_num;
+    unsigned n;
+
+    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
+
+    head_idx = svq->vring_packed.next_avail_idx;
+    i = head_idx;
+    id = svq->free_head;
+    curr = id;
+    *head = id;
+
+    /* Write descriptors to SVQ packed vring */
+    for (n = 0; n < num; n++) {
+        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
+                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
+                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
+        if (i == head_idx) {
+            head_flags = flags;
+        } else {
+            descs[i].flags = flags;
+        }
+
+        descs[i].addr = cpu_to_le64(sgs[n]);
+        descs[i].id = id;
+        if (n < out_num) {
+            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
+        } else {
+            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
+        }
+
+        curr = cpu_to_le16(svq->desc_next[curr]);
+
+        if (++i >= svq->vring_packed.vring.num) {
+            i = 0;
+            svq->vring_packed.avail_used_flags ^=
+                1 << VRING_PACKED_DESC_F_AVAIL |
+                1 << VRING_PACKED_DESC_F_USED;
+        }
+    }
 
+    if (i <= head_idx) {
+        svq->vring_packed.avail_wrap_counter ^= 1;
+    }
+
+    svq->vring_packed.next_avail_idx = i;
+    svq->shadow_avail_idx = i;
+    svq->free_head = curr;
+
+    /*
+     * A driver MUST NOT make the first descriptor in the list
+     * available before all subsequent descriptors comprising
+     * the list are made available.
+     */
+    smp_wmb();
+    svq->vring_packed.vring.desc[head_idx].flags = head_flags;
 }
 
-static void vhost_svq_kick(VhostShadowVirtqueue *svq)
+static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
 {
     bool needs_kick;
 
@@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t avail_event = le16_to_cpu(
                 *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
-        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
+        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx,
+                     svq->shadow_avail_idx - 1);
     } else {
         needs_kick =
                 !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
@@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     event_notifier_set(&svq->hdev_kick);
 }
 
+static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
+{
+    bool needs_kick;
+
+    /*
+     * We need to expose the available array entries before checking
+     * notification suppressions.
+     */
+    smp_mb();
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        return;
+    } else {
+        needs_kick = (svq->vring_packed.vring.device->flags !=
+                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
+    }
+
+    if (!needs_kick) {
+        return;
+    }
+
+    event_notifier_set(&svq->hdev_kick);
+}
+
 /**
  * Add an element to a SVQ.
  *
@@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -EINVAL;
     }
 
-    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
-                        in_num, sgs, &qemu_head);
+    if (svq->is_packed) {
+        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
+                             in_num, sgs, &qemu_head);
+    } else {
+        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
+                            in_num, sgs, &qemu_head);
+    }
 
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
-    vhost_svq_kick(svq);
+    if (svq->is_packed) {
+        vhost_svq_kick_packed(svq);
+    } else {
+        vhost_svq_kick_split(svq);
+    }
     return 0;
 }
 
-- 
2.48.1


