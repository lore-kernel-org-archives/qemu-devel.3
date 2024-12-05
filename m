Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B49CE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIZ2-0005yV-2C; Thu, 05 Dec 2024 15:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZ0-0005wI-Fa
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:06 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIYy-0004lR-Mu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:06 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-724e14b90cfso1435625b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430903; x=1734035703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ho7yg6U067P5Xh/RW+CDVPYnTIMYuQPRqRvfGLa5b6g=;
 b=fS1RHPzJW2Aj30eyjd9HqMIMaAIzRtx85+qPClw27ZS3adaHN8xbW+SDVvTE2cU+9d
 R3eJwxvjyy8IQ60KqxJaS9aMckzzjT6LN19NZSTZCaBFjT00D2JHw8VuRSkoFmNLaW9x
 Nh0mpom9J5y6NMnbaqYO0OA72YCJ1Vh0k2oAPkUUImPaFLjyN6jcWPRcTx0PvWmLffr2
 wk69iqY3uMi0FxVYmpStiZed0nH1RV2KXIKyiVJF/jcGmpY6u5SIuconpScbn117YTK7
 6rUa5QwHLlOVONgRvDTAH6dUb9Xcz5OKqTRPtA8VNM7xk9xYji5ENmwF8b7VYT5ecYB1
 D2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430903; x=1734035703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ho7yg6U067P5Xh/RW+CDVPYnTIMYuQPRqRvfGLa5b6g=;
 b=MgZel8Xm1E0CRsupaEXtrV8iBjTCPywyUXhCdYTWT+wX6+xCChIt43wV4m/Stjg/cq
 pTQJDOAIl7vtzTDOhvqbpAshk4SaDquJE6GeWoSwLBi/BRxZkaYhPv2T1Tlyep0guj2n
 WsJcFqrE9HVNcf6+xVbmQPWYaEk5AthHI9tTkayQU6qI/Wq/JS3Glbe/WDboQ1/Qy/Rt
 FnfCbmZRLjruQuqXgsV0hwELJJCs8Jbgmn/qoRe5SAoYYr6aEcUzjOPjNDQuUstD+tAI
 WbvKwDCdeUPVCPVkN/9bCd7KS4l7iOhn44olvxUCHoqQQyH6tQmGzxwWBs97+JB3TP6E
 wA6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBkyQhFYz9jjcb4erMlNdQH7x0zoAOr7VLEAS5L/NdK76cVcREFCU4sKUj5UdHpUXGFWXRibD68w/2@nongnu.org
X-Gm-Message-State: AOJu0YygcAsHt46ADDB6gc8A2I+kFZVDhruDRI6CVrgfIncWEiMgB1T7
 Xov5YDqk9kQ6jGsUHBTTlC2rQvkHOKs7QkNuc4purvKgSxJELFKkr+vywQ==
X-Gm-Gg: ASbGncug0+ah91KuwDo0hacUtwyFUSv9H3jdvOOZmbFJSWmEIAfNNAZx7MspFp23OF7
 g4CcvM2QEu0arwIqX5p0/rTTiQjsQzSBHSENPDAs0CbN/0M7mlV17Kx0DxLuDu8qopUxqEIfAdg
 X3yJYUUyASTOVLGwTVeZUSKurE3AYTU2eiaHghacTLpoqROr2ICcyrO0s0grqcWAV0qcYdWdM4P
 +fCU98EVGhLiYJrBT4IRXZiA/rL6/LjSX2n/024s0M=
X-Google-Smtp-Source: AGHT+IGaKFkcjrLMfwjlj0++LPVUS7WZYp/D4x5NUBgasLDoRn7VkRiUrUONm/NEj+C0Eu6hcrkL8A==
X-Received: by 2002:a17:90b:5384:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2ef69f0b7f8mr812652a91.16.1733430903260; 
 Thu, 05 Dec 2024 12:35:03 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:35:02 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 2/5] vhost: Write descriptors to packed svq
Date: Fri,  6 Dec 2024 02:04:27 +0530
Message-ID: <20241205203430.76251-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x432.google.com
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

This commit is the first in a series to add support for packed
virtqueues in vhost_shadow_virtqueue.

This patch implements the insertion of available buffers in the
descriptor area. It takes into account descriptor chains, but does
not consider indirect descriptors.

Also validate svq-specific features that vdpa supports.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v3 -> v4:
- Split commit #1 in v3 into 2 commits.
- vhost-shadow-virtqueue.c
  (vhost_svq_valid_features): Add enums.

 hw/virtio/vhost-shadow-virtqueue.c | 83 +++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bb7cf6d5db..6eee01ab3c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
          ++b) {
         switch (b) {
         case VIRTIO_F_ANY_LAYOUT:
+        case VIRTIO_F_RING_PACKED:
+        case VIRTIO_F_RING_RESET:
+        case VIRTIO_RING_F_INDIRECT_DESC:
         case VIRTIO_RING_F_EVENT_IDX:
             continue;
 
@@ -178,7 +181,78 @@ static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
     /* Update the avail index after write the descriptor */
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
+}
 
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
+                                const struct iovec *out_sg, size_t out_num,
+                                const struct iovec *in_sg, size_t in_num,
+                                hwaddr *sgs, unsigned *head)
+{
+    uint16_t id, curr, i, head_flags = 0;
+    size_t num = out_num + in_num;
+    unsigned n;
+
+    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
+
+    *head = svq->vring_packed.next_avail_idx;
+    i = *head;
+    id = svq->free_head;
+    curr = id;
+
+    /* Write descriptors to SVQ packed vring */
+    for (n = 0; n < num; n++) {
+        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
+                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
+                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
+        if (i == *head) {
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
+                    1 << VRING_PACKED_DESC_F_AVAIL |
+                    1 << VRING_PACKED_DESC_F_USED;
+        }
+    }
+
+    if (i <= *head) {
+        svq->vring_packed.avail_wrap_counter ^= 1;
+    }
+
+    svq->vring_packed.next_avail_idx = i;
+    svq->free_head = curr;
+
+    /*
+     * A driver MUST NOT make the first descriptor in the list
+     * available before all subsequent descriptors comprising
+     * the list are made available.
+     */
+    smp_wmb();
+    svq->vring_packed.vring.desc[*head].flags = head_flags;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -240,8 +314,13 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -EINVAL;
     }
 
-    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
-                        in_num, sgs, &qemu_head);
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
+                             in_num, sgs, &qemu_head);
+    } else {
+        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
+                            in_num, sgs, &qemu_head);
+    }
 
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
-- 
2.47.0


