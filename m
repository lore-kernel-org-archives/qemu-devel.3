Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E548BC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 05:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKs90-0008WO-4t; Fri, 30 May 2025 01:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKs8x-0008Vm-MF
 for qemu-devel@nongnu.org; Fri, 30 May 2025 01:19:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKs8u-0002v1-W4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 01:18:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso1332277b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748582335; x=1749187135;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cope124TjOYa+7NUk9EDspUxzXdBjrFv+k/R7FUMnec=;
 b=mGVtTpz21ckiV7Nx7I9Ma7KLnz0eS4iY6AvlY1f1udwOIDzOQf3lKUEavW75on3EdH
 o2K6r4yfJXS5ON2QfAbZDejM2vLABajunH3/y6Xc9BGHJsBbuqCEtEGy641xUwcjwNZ/
 eRDwTG6wSpnq5fWvSG2sh/Qo6z5hJO+ihjJqCneDihREK1rauDMxwm3TWgSghsiW6yCK
 twU1+x8DwXbPC4L0qwUY6zXEeggQ87sGaI4XEpCyrKNhJeH+WbnbrOW/kkCSzJ+r6CMQ
 Ldga5yKrhQflqFmZzohc5ywPtB69bA78VVPr2KL0XCoYmGG2LQbWaQ3wsV/z2Hgpunu3
 LQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748582335; x=1749187135;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cope124TjOYa+7NUk9EDspUxzXdBjrFv+k/R7FUMnec=;
 b=DfwJk11CvNpJgwnHaBUjGfC6llb/dgbsa1kqqoDjcACNSbUarkExNTwCghpAn1MhVJ
 hXVaD0oMs6BZngiP4xkYp7opH6MaZUBL1ksjI+MTGMUVW4e5t4+pzHsugaXuyywJ7toI
 y6+efa5Lu6KRCnYBUG9BSsIwoPQ71+YEKMbfbqLw3jOwqXk/NJmNGgrf16Q3XERkvMnE
 LM19Et3HpWjopbpTFHDfxfuwqHn/HuHCnd4rOlFUXAhB3YfqmxYstQUQ56mL29nuQjCC
 eQK2DIkkV31w6laYCIzuJKC/9jBGGl16X/V9XOTvMY1LUHZvysj9Olxz6tcYfm7STRoS
 jr0Q==
X-Gm-Message-State: AOJu0YwFb9kzUvv3AgIvij/XXiUWtXz4ngxIdXwKA5ibZqo/XNqccOUL
 /UjC6P0BtJP+JDQyYiNa4BqNnI2A+2hTySj9++ED98OdZ4ghn3ChvGwgCrUATTafky4L72DkZjm
 cxJ+9
X-Gm-Gg: ASbGncvDAjqrR87/phjW4fZVras1rNHkF7hlE+G/Ic2F8mRBlbhaYCdpEevs5f872j5
 0TPSZf3Sf1STGZoPiqWLHiNFi0EW8Pd6vJlOPogTEJ/NsHrbxnFgn0eUDPH3bKPyn7e+ySZdlkm
 yysBY096YxCBr4hZsH2qLPv5/sW+6zeAijowQZP6a8cGAzQafFg5PNErqBWDgTdIy7hUOlaaEM8
 g5YBjfsBL5LbE1ARX0rFGwdKbtD4Jj7SLpTomlUKSfnm2Aifq1bWC+Xrv4Zj8Pq9vPbeDyXGXGx
 IFJZN50SAvf7bUcEDEW0a0IJPG3KRXcFqsEL+gyxINgzXUaz+YFm/mLM6XRh5P4=
X-Google-Smtp-Source: AGHT+IEK50F/mJqLXpIfu7lO7BQvA9+LMD2IB/Gtgpd/UbBFJ0O3cS9DGDQfeNeRqSrPhOljoafJjA==
X-Received: by 2002:a05:6a00:4fc7:b0:742:aecc:c46d with SMTP id
 d2e1a72fcca58-747bd95a8c0mr2693895b3a.5.1748582335081; 
 Thu, 29 May 2025 22:18:55 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affd54fbsm2211683b3a.154.2025.05.29.22.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 22:18:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 14:18:53 +0900
Subject: [PATCH v2] virtio-net: Add queues for RSS during migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-n-v2-1-b1be546ca586@daynix.com>
X-B4-Tracking: v=1; b=H4sIALw/OWgC/yWMzQ6CMBCEX4Xs2Zr+SAVPvgfhUMsqe7A1rWkgp
 O/OipnTN5lvNsiYCDPcmg0SFsoUA4M+NeBnF14oaGIGLXUrL9KKIBxeHyhN15tOA+8+CZ+0HB/
 DyDxT/sa0HpdF/dq/3SrJdlGC0yNq67zxzt4ntwZazj6+Yay17nL2Jf6TAAAA
X-Change-ID: 20250406-n-ae7be0389382
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
VIRTIO_NET_F_MQ uses bit 22.

Instead of inferring the required number of queues from
vdev->guest_features, use the number loaded from the vm state. This
change also has a nice side effect to remove a duplicate peer queue
pair change by circumventing virtio_net_set_multiqueue().

Also update the comment in include/hw/virtio/virtio.h to prevent an
implementation of pre_load_queues() from refering to any fields being
loaded during migration by accident in the future.

Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Updated a documentation comment of pre_load_queues() for clarity.
- Link to v1: https://lore.kernel.org/qemu-devel/20250510-n-v1-1-19ee26ac3ca6@daynix.com
---
 include/hw/virtio/virtio.h | 10 ++++++++--
 hw/net/virtio-net.c        | 11 ++++-------
 hw/virtio/virtio.c         | 14 +++++++-------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 214d4a77e932..c594764f23f4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -210,8 +210,14 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
-    /* Called before loading queues. Useful to add queues before loading. */
-    int (*pre_load_queues)(VirtIODevice *vdev);
+    /*
+     * Called before loading queues.
+     * If the number of queues change at runtime, use @n to know the
+     * number and add or remove queues accordingly.
+     * Note that this function is called in the middle of loading vmsd;
+     * no assumption should be made on states being loaded from vmsd.
+     */
+    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a50..5a1aead4e70e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3022,11 +3022,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     virtio_del_queue(vdev, index * 2 + 1);
 }
 
-static void virtio_net_change_num_queue_pairs(VirtIONet *n, int new_max_queue_pairs)
+static void virtio_net_change_num_queues(VirtIONet *n, int new_num_queues)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int old_num_queues = virtio_get_num_queues(vdev);
-    int new_num_queues = new_max_queue_pairs * 2 + 1;
     int i;
 
     assert(old_num_queues >= 3);
@@ -3062,16 +3061,14 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     int max = multiqueue ? n->max_queue_pairs : 1;
 
     n->multiqueue = multiqueue;
-    virtio_net_change_num_queue_pairs(n, max);
+    virtio_net_change_num_queues(n, max * 2 + 1);
 
     virtio_net_set_queue_pairs(n);
 }
 
-static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
 {
-    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+    virtio_net_change_num_queues(VIRTIO_NET(vdev), n);
 
     return 0;
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2e98cecf64df..bbeccccf6d77 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3259,13 +3259,6 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
-    if (vdc->pre_load_queues) {
-        ret = vdc->pre_load_queues(vdev);
-        if (ret) {
-            return ret;
-        }
-    }
-
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {
@@ -3273,6 +3266,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         return -1;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev, num);
+        if (ret) {
+            return ret;
+        }
+    }
+
     for (i = 0; i < num; i++) {
         vdev->vq[i].vring.num = qemu_get_be32(f);
         if (k->has_variable_vring_alignment) {

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250406-n-ae7be0389382

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


