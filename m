Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91705C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiMN-0007L4-AL; Mon, 24 Mar 2025 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLe-0006vH-PQ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLc-0004J4-J0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22548a28d0cso80708535ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824811; x=1743429611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syGyxr2B/ai8s/rSZLKt/yNTwPgOQvFeWfVekUjCJzU=;
 b=YQO1tSYc+gTXy6/wvbU+31lYDR5ZcYNe0Po3iDNzaVhPj92zvW3F9e4mV5qngCYcdf
 7g1+6yplHS+MIXayYBfoey8YOOUETXBC4LmKgGbG9HVI7+JpzGWoSDVLyeJeGOIZb5aL
 WuzT9z0sCKQi4LXrrMhqn4wGtxQH+pL/pgs8kjLWN3tENBbbRD9BOBc43qolV22+2tav
 XJdFCEFpK7H8y9ejbLb8H5eXIrEHIj9sUoOv5aDVjB2SX4t0WG1D9C2jgMamLQYtui52
 zjeHTmHIir7+eLzETZO3yVhJNvtQWKKQr8OCMdPCSTSNYNdUGLaNDEp7AJ/Po27rifkC
 ltIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824811; x=1743429611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syGyxr2B/ai8s/rSZLKt/yNTwPgOQvFeWfVekUjCJzU=;
 b=F1rrhtvq8OKSYLPtbkxh6DXkw2iA/brkh2xuhx0uuubJ1l5ZnpqL5fMbuV63NAFAKs
 Sz1Q9UxRu0pOkgSwooVV/QMbK8iPpyQDkVR92G4IVWmBL4sXh+hXBkz/sI+hJaqCw9wd
 dwijKwWBLH0JAO00v9M26dMqy7FMut9Ez/XjuC25WeEZe57LWcpelx+Jtt2UdaIHxJNq
 ZSFOPRBw1JtQPWhiPoSkUeZiFs5srWRiOzrWBjbMgCNUwLeSd/D0lfpP6IfsDox0o47X
 iAtrCIkSj/E59V7dZEQ8klZB5Q5ecYdYuLTMW6EFNOVU307+8s4AqLjJSF8EyKSXFgEN
 wrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGDYLmhiwwpjIrVRb4FrnfRYcIwU1S6CaGhCHUZg8FpJbuSs/AZnD2e7+DNj6ZENmMSBv9VBktK1Z@nongnu.org
X-Gm-Message-State: AOJu0YxqIGS7953F92kgYjsF0BvmSBPqgVqAP0T5W/d7eR5NFy5HgI6h
 NDBlIijnjT97aZCiJW7Vw/MUYGltblcUJ5tWpKp/R6eTHujJFI39
X-Gm-Gg: ASbGnctkYhhkNBa+zLYdm1DrFekWvAgN+vVSo/8LdfmwjdCIJ64GRMlTvevsiziQJB2
 gfNd/+Q4sMJMXUIcpjPbORlIZVb5HZvZAAXqrbRkNoH4wT9rO0FLO8AyFnEZtWzWRudmjcUygFD
 iwC2AGX20f+wTaV6zynFmvjsYCmppegHVvCbr9BWEpcoH0AaTj7jvb+lgJLH7XneLUtyZIwX0Oo
 fBxf1ZHcb8FMz4a0LUaJpDbnICj3eg1PeVBOp7MwkGasSVfo+6kfTCrgyxV9k1sqTrkG1HMulZB
 Li8LCN+zQULCRLT2cJsd2uXtsylvwZA23a9nv6c=
X-Google-Smtp-Source: AGHT+IH9CNpxfurcSrOQzehqP7RHeS5Ueylqk+IO0a1WWxNg+24WoSMVp83h5sAlmTT9XeHjhBA9PQ==
X-Received: by 2002:a05:6a00:3929:b0:736:ab21:8a69 with SMTP id
 d2e1a72fcca58-73905635469mr22933210b3a.0.1742824810601; 
 Mon, 24 Mar 2025 07:00:10 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.07.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:00:10 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 5/7] vhost: Forward descriptors to guest via packed vqs
Date: Mon, 24 Mar 2025 19:29:19 +0530
Message-ID: <20250324135929.74945-6-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62f.google.com
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

Detect when used descriptors are ready for consumption by the guest via
packed virtqueues and forward them from the device to the guest.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- New commit.
- vhost-shadow-virtqueue.c:
  (vhost_svq_more_used): Split into vhost_svq_more_used_split and
  vhost_svq_more_used_packed.
  (vhost_svq_enable_notification): Handle split and packed vqs.
  (vhost_svq_disable_notification): Likewise.
  (vhost_svq_get_buf): Split into vhost_svq_get_buf_split and
  vhost_svq_get_buf_packed.
  (vhost_svq_poll): Use new functions.

 hw/virtio/vhost-shadow-virtqueue.c | 121 ++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 126957231d..8430b3c94a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -463,7 +463,7 @@ static void vhost_handle_guest_kick_notifier(EventNotifier *n)
     vhost_handle_guest_kick(svq);
 }
 
-static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
+static bool vhost_svq_more_used_split(VhostShadowVirtqueue *svq)
 {
     uint16_t *used_idx = &svq->vring.used->idx;
     if (svq->last_used_idx != svq->shadow_used_idx) {
@@ -475,6 +475,22 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
     return svq->last_used_idx != svq->shadow_used_idx;
 }
 
+static bool vhost_svq_more_used_packed(VhostShadowVirtqueue *svq)
+{
+    bool avail_flag, used_flag, used_wrap_counter;
+    uint16_t last_used_idx, last_used, flags;
+
+    last_used_idx = svq->last_used_idx;
+    last_used = last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+    used_wrap_counter = !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
+
+    flags = le16_to_cpu(svq->vring_packed.vring.desc[last_used].flags);
+    avail_flag = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
+    used_flag = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
+
+    return avail_flag == used_flag && used_flag == used_wrap_counter;
+}
+
 /**
  * Enable vhost device calls after disable them.
  *
@@ -486,16 +502,31 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
  */
 static bool vhost_svq_enable_notification(VhostShadowVirtqueue *svq)
 {
+    bool more_used;
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        uint16_t *used_event = (uint16_t *)&svq->vring.avail->ring[svq->vring.num];
-        *used_event = cpu_to_le16(svq->shadow_used_idx);
+        if (!svq->is_packed) {
+            uint16_t *used_event = (uint16_t *)&svq->vring.avail->ring[svq->vring.num];
+            *used_event = cpu_to_le16(svq->shadow_used_idx);
+        }
     } else {
-        svq->vring.avail->flags &= ~cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
+        if (svq->is_packed) {
+            /* vq->vring_packed.vring.driver->off_wrap = cpu_to_le16(svq->last_used_idx); */
+            svq->vring_packed.vring.driver->flags =
+                cpu_to_le16(VRING_PACKED_EVENT_FLAG_ENABLE);
+        } else {
+            svq->vring.avail->flags &= ~cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
+        }
     }
 
     /* Make sure the event is enabled before the read of used_idx */
     smp_mb();
-    return !vhost_svq_more_used(svq);
+    if (svq->is_packed) {
+        more_used = !vhost_svq_more_used_packed(svq);
+    } else {
+        more_used = !vhost_svq_more_used_split(svq);
+    }
+
+    return more_used;
 }
 
 static void vhost_svq_disable_notification(VhostShadowVirtqueue *svq)
@@ -505,7 +536,12 @@ static void vhost_svq_disable_notification(VhostShadowVirtqueue *svq)
      * index is already an index too far away.
      */
     if (!virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
-        svq->vring.avail->flags |= cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
+        if (svq->is_packed) {
+            svq->vring_packed.vring.driver->flags =
+                cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE);
+        } else {
+            svq->vring.avail->flags |= cpu_to_le16(VRING_AVAIL_F_NO_INTERRUPT);
+        }
     }
 }
 
@@ -519,15 +555,14 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
     return i;
 }
 
-G_GNUC_WARN_UNUSED_RESULT
-static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
-                                           uint32_t *len)
+static VirtQueueElement *vhost_svq_get_buf_split(VhostShadowVirtqueue *svq,
+                                                 uint32_t *len)
 {
     const vring_used_t *used = svq->vring.used;
     vring_used_elem_t used_elem;
     uint16_t last_used, last_used_chain, num;
 
-    if (!vhost_svq_more_used(svq)) {
+    if (!vhost_svq_more_used_split(svq)) {
         return NULL;
     }
 
@@ -562,6 +597,66 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
 }
 
+static VirtQueueElement *vhost_svq_get_buf_packed(VhostShadowVirtqueue *svq,
+                                                  uint32_t *len)
+{
+    bool used_wrap_counter;
+    uint16_t last_used_idx, last_used, id, num, last_used_chain;
+
+    if (!vhost_svq_more_used_packed(svq)) {
+        return NULL;
+    }
+
+    /* Only get used array entries after they have been exposed by dev */
+    smp_rmb();
+    last_used_idx = svq->last_used_idx;
+    last_used = last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+    used_wrap_counter = !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
+    id = le32_to_cpu(svq->vring_packed.vring.desc[last_used].id);
+    *len = le32_to_cpu(svq->vring_packed.vring.desc[last_used].len);
+
+    if (unlikely(id >= svq->vring.num)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
+                      svq->vdev->name, id);
+        return NULL;
+    }
+
+    if (unlikely(!svq->desc_state[id].ndescs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "Device %s says index %u is used, but it was not available",
+            svq->vdev->name, id);
+        return NULL;
+    }
+
+    num = svq->desc_state[id].ndescs;
+    svq->desc_state[id].ndescs = 0;
+    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, id);
+    svq->desc_next[last_used_chain] = svq->free_head;
+    svq->free_head = id;
+    svq->num_free += num;
+
+    last_used += num;
+    if (unlikely(last_used >= svq->vring_packed.vring.num)) {
+        last_used -= svq->vring_packed.vring.num;
+        used_wrap_counter ^= 1;
+    }
+
+    last_used = (last_used | (used_wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+    svq->last_used_idx = last_used;
+    return g_steal_pointer(&svq->desc_state[id].elem);
+}
+
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
+                                           uint32_t *len)
+{
+    if (svq->is_packed) {
+        return vhost_svq_get_buf_packed(svq, len);
+    }
+
+    return vhost_svq_get_buf_split(svq, len);
+}
+
 /**
  * Push an element to SVQ, returning it to the guest.
  */
@@ -639,7 +734,11 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
         uint32_t r = 0;
 
         do {
-            if (vhost_svq_more_used(svq)) {
+            if (!svq->is_packed && vhost_svq_more_used_split(svq)) {
+                break;
+            }
+
+            if (svq->is_packed && vhost_svq_more_used_packed(svq)) {
                 break;
             }
 
-- 
2.48.1


