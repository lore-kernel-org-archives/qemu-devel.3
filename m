Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52336C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiLo-0006vw-Ry; Mon, 24 Mar 2025 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLQ-0006nQ-BK
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLO-00043m-9X
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:59:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22401f4d35aso89555155ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824797; x=1743429597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/q2t0q3qYb96coVx11NQT5PZmW6Rt7r2gudCW01h9tU=;
 b=lNTomRT/YWFmNylLBuVJtoI696WznhT0x3WaVlX6g4NqOc0UMhPIpXGEOiDoTwMxAb
 Rs1dBm1mdZ7vIE8RGcQUM0wzHKdyJJLk4j7VjBFcgBraCZBjfNrtMy42YCcCtmFfVlAK
 KV4nRt0zVECGtvLeSYe5E2rCY+b5xE1dih8V3XjSiUzqVnz2YLsf9gPFMfkU6/zBh1Qg
 ZBG8bBABIHVTIR8XuW5j9tRGW9sBdNI+aT0GymXxcGYtfcomvEJxGGilnjBwv8lGJHXC
 vUiAtno0PtQn4Q7uaVFsLoXxBuuEEuyjlmGCOAquqbaYNOl6KuZ0EieUgNYJWo5sj4yg
 xSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824797; x=1743429597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/q2t0q3qYb96coVx11NQT5PZmW6Rt7r2gudCW01h9tU=;
 b=fP9h84VluNpZ54Ph7Q1zVGqqtji1j9UoCiaoDM4PJ5DOJO24taWClUXtEoLGgoeB2O
 wszfsMQD/J5BhaapkG7IQ+ePWGjW5pD50SSl8w2BqlHIBnf9rWTo5XuqMqE/fjNxyffo
 +Q+0ClBysCdahd5/ShVBmN1OBsmmldhPCyvVQiAWP3+ij8ihCLqRcPO26I1N85uIhQOL
 JB0Dx7eIvGBVUsfZUd8aKnJHSq3imrlC5g0DbFlwVogMSl6n5OUZtrwkaiH8yg3Z5em9
 8ZmN/6gEI0QEwuGCnT8GFrNOBsAp347GtFFajdtES3mFPsqlNf3d7L2uQRQCFSoYO/xA
 xktQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjHbDnuF8A7a1pycSfdcOCqNNmBYCvxGV6oAuF4uMBEQGAdAUKOu4GvCrOVl0wAVjKODvjviyyir77@nongnu.org
X-Gm-Message-State: AOJu0Yx3LXJSXWLffPqODAUZwdcVY652auFOSJ7qHIAM4d5zCrn0Y9tC
 XM7EroKgHXZSuZRItwr546DGNi4vJDNOwmmdNbSy6yQw4DP8wkXY
X-Gm-Gg: ASbGncsw9KZPVG3tsntgtDhfSZRV0FfRbEsRFJz8GHRK22fr3/cGDE6a+LUgP8qJBkA
 /7+DG2ZDUrmQNxoLTB3cKw3r1BkR8zw8wgyrzwqyrG+FFKwD5zxVe/6ph/bd7HfOtoCIQUDM506
 jpMiLBNgmi97MlmwqHqNp9jCSZ4um8CicW7EhxCKxBa0NoTN0pX+1ahKMM3mGd59l7OHr6xBzrL
 ZeJZ62J5Us6yD+7E/tOkbleWjbXsQRs8xMSvjIAVophDUTtSm20m0cX4XdBkOTNnePUqXO86A34
 kRRw67C3Eo2voT3YfBmE5XJOTzB+UTp9vySgq/A=
X-Google-Smtp-Source: AGHT+IFAUWmVb4Sg/XdrS7vjTPznhWndku+QpaziXuGLgeBA9mkwp4ckoarDTW+XXVjWNtY6oM4VRQ==
X-Received: by 2002:a05:6a20:2d23:b0:1f5:5aac:f345 with SMTP id
 adf61e73a8af0-1fe43435c0fmr25499185637.36.1742824796418; 
 Mon, 24 Mar 2025 06:59:56 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.06.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 06:59:56 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 2/7] vhost: Data structure changes to support packed vqs
Date: Mon, 24 Mar 2025 19:29:16 +0530
Message-ID: <20250324135929.74945-3-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x634.google.com
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

Modify VhostShadowVirtqueue so it can support split and packed virtqueue
formats.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes from v4 -> v5:
- This was commit #3 in v4. This has been reordered to commit #2
  based on review comments.
- Place shadow_avail_idx, shadow_used_idx, last_used_idx
  above the "shadow vring" union.

 hw/virtio/vhost-shadow-virtqueue.h | 87 +++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 9c273739d6..5f7699da9d 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -46,10 +46,65 @@ typedef struct VhostShadowVirtqueueOps {
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
+    /* Next head to expose to the device */
+    uint16_t shadow_avail_idx;
+
+    /* Last seen used idx */
+    uint16_t shadow_used_idx;
+
+    /* Next head to consume from the device */
+    uint16_t last_used_idx;
+
     /* Shadow vring */
-    struct vring vring;
+    union {
+        struct vring vring;
+        struct vring_packed vring_packed;
+    };
 
     /* Shadow kick notifier, sent to vhost */
     EventNotifier hdev_kick;
@@ -69,47 +124,17 @@ typedef struct VhostShadowVirtqueue {
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
 
     /* Caller callbacks opaque */
     void *ops_opaque;
-
-    /* Next head to expose to the device */
-    uint16_t shadow_avail_idx;
-
-    /* Next free descriptor */
-    uint16_t free_head;
-
-    /* Last seen used idx */
-    uint16_t shadow_used_idx;
-
-    /* Next head to consume from the device */
-    uint16_t last_used_idx;
-
-    /* Size of SVQ vring free descriptors */
-    uint16_t num_free;
 } VhostShadowVirtqueue;
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
-- 
2.48.1


