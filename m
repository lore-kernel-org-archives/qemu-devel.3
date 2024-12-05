Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D76CE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIZ8-00066m-8b; Thu, 05 Dec 2024 15:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZ7-00066I-08
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:13 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZ5-0004n8-Eo
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:12 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eecc01b5ebso1193328a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430910; x=1734035710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrlYK4yXYr2i1VgD7WUebq8opI+LmqDH8ytWZHxqCgE=;
 b=NFH1RAGse6UBvhKwSWwaiunGc4H1l+owCPpuJN2BJvf/gEaSRUVh5dC1r0BjDs/SUk
 83GXoA6KJCSdUsTHmjeXCXoQ+Gs/QhjO0ce4pdvDMdMuIY+ecI817dsGEpjdeaXAsVEK
 Sc1wNizhSyZdluas/jETvp15k3eSEmxw/HjVAgp4OI+Ej/Nh1EqKjefwAi22XFSMwM7I
 tCdVaks0d7oroUTNKxg0vYc4h7+9scPH/HF5iL4bEPkD5E6RhBI5423vgZtbVIIDfa+Q
 6i5uQQQxQ733FkZJIy7mYaXKfeRh0llksL9DMOJAFgD7DPoWZ0phHWXUioRNTErWRsv6
 48+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430910; x=1734035710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrlYK4yXYr2i1VgD7WUebq8opI+LmqDH8ytWZHxqCgE=;
 b=ImpAnb7C7obtBOxBXBb3R9IILO1uJMY+L/qWh9Y51dl2wGVpDiKsUcxK90J6driLlu
 xzUWGEA0elze9DRpbGOflPQLn5TK6e2eHL/KldWWJd2wR7OBiin/RkVmBi5n8CgBIEQg
 4ZIVSYexqg7agpO9u5sJQXZz2/OUsmGfKDNA0mNtfw05m7QyNhnr/XQMAB2m7Y/q+M7r
 0nAavkAxcrHdX8HsXYaZTNc7FhErRMaPpZS1f44qnIJyquSqsYfGK8tVmpOHq5S/Lk6n
 XP7971ULlFjgfcdSzYxgmiWwCEWgF8rA4wFayW8chgw+dWznBvbMIAdiY8TVnKROhY0R
 Ia7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqC8CElo0Q38HZe3xO6/pxTOCFFCGF+ZRVYWpKUsPSKxktPvD3Vr6ITl66m5ZBuvFqU4T++ioBjzPh@nongnu.org
X-Gm-Message-State: AOJu0YxW+8yagTdlHOMqwpydm05I3rKgAVvtZpwmsIPibEQ+FDvLQnCh
 71Vb5EIWB0BAH4/1pavOlTNqTrv8mY4tRs/EBfNlBPWdVGP9ZNOc
X-Gm-Gg: ASbGnctsaGuI3OtHp+N2nhXXbONfczqwG3mPvGYyawbXwbylbpinZyFBenq4cNpCu2y
 ZwZd3JppVbRatGVUtHMn4/qdBPDWyO6S/pD0UtSi0t7TwRwQWLcuXhOgD905ye2GgDmQrsHAzIT
 qIraz0pPes62GXOAaSYHzERcCahJVfcUGv7WbNxCXy+R1rwQPd0fcMllKiS7abbsDKlGK4U3XN/
 z0f34luPbG+a0uU749Ydc7sBxdbFUZiHh356KUTb1c=
X-Google-Smtp-Source: AGHT+IGMmafjO+Z8rkuT7OJWtzNVIwmPTIjIFSX16Kr73Am/jYb2RDv6S6vzkVafZQgeMfJhXVYZ0Q==
X-Received: by 2002:a17:90a:d88e:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2ef6ab10353mr726680a91.26.1733430909765; 
 Thu, 05 Dec 2024 12:35:09 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:35:09 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 3/5] vhost: Data structure changes to support packed vqs
Date: Fri,  6 Dec 2024 02:04:28 +0530
Message-ID: <20241205203430.76251-4-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1036.google.com
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

Introduce "struct vring_packed".

Modify VhostShadowVirtqueue so it can support split
and packed virtqueue formats.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v3 -> v4:
- Commit #2 of v3 is now commit #3 in this series.
- vhost-shadow-virtqueue.h
  (struct VhostShadowVirtqueue): Add bool is_packed.
  This was initially in commit #3 of v3.

 hw/virtio/vhost-shadow-virtqueue.h | 69 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 19c842a15b..ce89bafedc 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -46,10 +46,56 @@ typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
 } VhostShadowVirtqueueOps;
 
+struct vring_packed {
+    /* Actual memory layout for this queue. */
+    struct {
+        unsigned int num;
+        struct vring_packed_desc *desc;
+        struct vring_packed_desc_event *driver;
+        struct vring_packed_desc_event *device;
+    } vring;
+
+    /* Avail used flags. */
+    uint16_t avail_used_flags;
+
+    /* Index of the next avail descriptor. */
+    uint16_t next_avail_idx;
+
+    /* Driver ring wrap counter */
+    bool avail_wrap_counter;
+};
+
 /* Shadow virtqueue to relay notifications */
 typedef struct VhostShadowVirtqueue {
+    /* True if packed virtqueue */
+    bool is_packed;
+
+    /* Virtio queue shadowing */
+    VirtQueue *vq;
+
+    /* Virtio device */
+    VirtIODevice *vdev;
+
+    /* SVQ vring descriptors state */
+    SVQDescState *desc_state;
+
+    /*
+     * Backup next field for each descriptor so we can recover securely, not
+     * needing to trust the device access.
+     */
+    uint16_t *desc_next;
+
+    /* Next free descriptor */
+    uint16_t free_head;
+
+    /* Size of SVQ vring free descriptors */
+    uint16_t num_free;
+
     /* Shadow vring */
-    struct vring vring;
+    union {
+        struct vring vring;
+        struct vring_packed vring_packed;
+    };
 
     /* Shadow kick notifier, sent to vhost */
     EventNotifier hdev_kick;
@@ -69,27 +115,12 @@ typedef struct VhostShadowVirtqueue {
     /* Guest's call notifier, where the SVQ calls guest. */
     EventNotifier svq_call;
 
-    /* Virtio queue shadowing */
-    VirtQueue *vq;
-
-    /* Virtio device */
-    VirtIODevice *vdev;
-
     /* IOVA mapping */
     VhostIOVATree *iova_tree;
 
-    /* SVQ vring descriptors state */
-    SVQDescState *desc_state;
-
     /* Next VirtQueue element that guest made available */
     VirtQueueElement *next_guest_avail_elem;
 
-    /*
-     * Backup next field for each descriptor so we can recover securely, not
-     * needing to trust the device access.
-     */
-    uint16_t *desc_next;
-
     /* Caller callbacks */
     const VhostShadowVirtqueueOps *ops;
 
@@ -99,17 +130,11 @@ typedef struct VhostShadowVirtqueue {
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-    /* Next free descriptor */
-    uint16_t free_head;
-
     /* Last seen used idx */
     uint16_t shadow_used_idx;
 
     /* Next head to consume from the device */
     uint16_t last_used_idx;
-
-    /* Size of SVQ vring free descriptors */
-    uint16_t num_free;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
-- 
2.47.0


