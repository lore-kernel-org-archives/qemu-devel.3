Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113CCF07A9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 06:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1symVU-0001Yi-9T; Thu, 10 Oct 2024 02:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1symVO-0001Ve-5m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:18:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1symVM-0000Nm-E1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 02:18:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so3475735ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 23:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728541111; x=1729145911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MLNiJsGAAWceYJxSps2//DWS3W5RdJ9dtm7PKKVZBoQ=;
 b=WL4qj9ySBfoQ3lC1b1GwlxZYS9KGyg8wOWfkumjLeH+wEQNxdBu2P6XGBjAePuy0wn
 b4Q1EziDFowRCoYlzU3CSTktaRTjEXl4bKBA2dblAt40Q6gCVr51LkjchXqg3BAbVyAr
 84rnvZGUIwEeG/ZiStXny8sjBfmkgfzq09DcWcYvJDq24ULdKE14c1IO8tr/tm1V+t+U
 FbY2ZQ4eEferDpGEup1hqBeSLwsgufsQ7Wp9HIBmcWOsIxVyb17HylwhMkKqfvvdycTh
 T+xtYPZgsnxIfZqq3zfMiHFu9f8aZjtCLvN7sE7Rmr5p4KjmCoazs6IAwtBFDo3UC7B7
 OR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728541111; x=1729145911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLNiJsGAAWceYJxSps2//DWS3W5RdJ9dtm7PKKVZBoQ=;
 b=UdVbgHYsFZUK4KMr5wMSafpu8L88fG9jlZMIy9OkvRYl6wLZzjmhiRq8tFZop52QB+
 wQm8Kd+80lCGly3uvevio6Zqgab6ku+Z+rt5vvGOyQ0qrXmGGhaoTguX1IkDUcNjGeQS
 U0l6EcuAaHV3G72MHDBkPzDiakaHs8z8Arbkqv6prBVAZ7eLbBlq0hQyrhIwXV3hxyZ0
 jzySN8pyM6wMoL5M1OCqSYA9Cw5tS/0+UsIOjbnsDi80wo1GE7m+bN/l4jwXHEZMub6b
 R0IrnvWzWa/3mT93A8e0ItmUuSKfv5LRWoaR5TeFIDQCNKykqFy8KGihngLBcVu0GSd2
 GO9g==
X-Gm-Message-State: AOJu0Yw7kLuNYpX8pvaMjkK+IUEhE978X3ILalTaiHkqluhq7i4XNMrn
 k7AwzfwbQTrSUxd5It4DLAo91yVLtOd9bB1vuK+vRm+SqEdBkMUv
X-Google-Smtp-Source: AGHT+IHrcPiCD2q/3IMA+0pLF3qhHAZbaxI6azAz2xIu/33uK8N53aGDRJ97geVujVGBZ2zDtteDxg==
X-Received: by 2002:a17:90b:1245:b0:2e2:c636:d205 with SMTP id
 98e67ed59e1d1-2e2c636d34cmr2955663a91.27.1728541110526; 
 Wed, 09 Oct 2024 23:18:30 -0700 (PDT)
Received: from localhost.localdomain ([156.59.87.117])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a5aacaebsm2761061a91.39.2024.10.09.23.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 23:18:30 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: alex.bennee@linaro.org,
	mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org,
	yaozhenguo@jd.com
Subject: [PATCH V3] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Date: Thu, 10 Oct 2024 14:18:24 +0800
Message-Id: <20241010061824.74819-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-pl1-x631.google.com
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

During the hot-unplugging of vhost-user-net type network cards,
the vhost_user_cleanup function may add the same rcu node to
the rcu linked list.
The function call relationship in this case is as follows:

vhost_user_cleanup
    ->vhost_user_host_notifier_remove
        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
    ->g_free_rcu(n, rcu);

When this happens, QEMU will abort in try_dequeue:

if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
    abort();
}

backtrace is as follows::
0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
1  raise () at /usr/lib64/libc.so.6
2  abort () at /usr/lib64/libc.so.6
3  try_dequeue () at ../util/rcu.c:235
4  call_rcu_thread (0) at ../util/rcu.c:288
5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
6  start_thread () at /usr/lib64/libc.so.6
7  clone3 () at /usr/lib64/libc.so.6

The reason for the abort is that adding two identical nodes to
the rcu linked list will cause the rcu linked list to become a ring,
but when the dummy node is added after the two identical nodes,
the ring is opened. But only one node is added to list with
rcu_call_count added twice. This will cause rcu try_dequeue abort.

This happens when n->addr != 0. In some scenarios, this does happen.
For example, this situation will occur when using a 32-queue DPU
vhost-user-net type network card for hot-unplug testing, because
VhostUserHostNotifier->addr will be cleared during the processing of
VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG. However,it is asynchronous,
so we cannot guarantee that VhostUserHostNotifier->addr is zero in
vhost_user_cleanup. Therefore, it is necessary to merge g_free_rcu
and vhost_user_host_notifier_free into one rcu node.

Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
---
   V1->V2: add n->addr check in vhost_user_get_vring_base and vhost_user_backend_handle_vring_host_notifier to prevent submit same node to rcu list.
   V2->V3: 1. change "free" to "destroy"
           2. move "!n->addr && !destroy" checking to vhost_user_host_notifier_remove
           3. move "!n" checking to vhost_user_host_notifier_remove
---
 hw/virtio/vhost-user.c         | 43 ++++++++++++++++++----------------
 include/hw/virtio/vhost-user.h |  1 +
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..f80d0af76f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1185,9 +1185,16 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
 
 static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
 {
-    assert(n && n->unmap_addr);
-    munmap(n->unmap_addr, qemu_real_host_page_size());
-    n->unmap_addr = NULL;
+    if (n->unmap_addr) {
+        munmap(n->unmap_addr, qemu_real_host_page_size());
+        n->unmap_addr = NULL;
+    }
+    if (n->destroy) {
+        memory_region_transaction_begin();
+        object_unparent(OBJECT(&n->mr));
+        memory_region_transaction_commit();
+        g_free(n);
+    }
 }
 
 /*
@@ -1195,17 +1202,25 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
  * under rcu.
  */
 static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
-                                            VirtIODevice *vdev)
+                                            VirtIODevice *vdev, bool destroy)
 {
+    if (!n)
+        return;
+    if (!destroy && !n->addr)
+        return;
+
     if (n->addr) {
         if (vdev) {
+            memory_region_transaction_begin();
             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, false);
+            memory_region_transaction_commit();
         }
         assert(!n->unmap_addr);
         n->unmap_addr = n->addr;
         n->addr = NULL;
-        call_rcu(n, vhost_user_host_notifier_free, rcu);
     }
+    n->destroy = destroy;
+    call_rcu(n, vhost_user_host_notifier_free, rcu);
 }
 
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
@@ -1279,9 +1294,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
     struct vhost_user *u = dev->opaque;
 
     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
-    if (n) {
-        vhost_user_host_notifier_remove(n, dev->vdev);
-    }
+    vhost_user_host_notifier_remove(n, dev->vdev, false);
 
     ret = vhost_user_write(dev, &msg, NULL, 0);
     if (ret < 0) {
@@ -1562,7 +1575,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
      * new mapped address.
      */
     n = fetch_or_create_notifier(user, queue_idx);
-    vhost_user_host_notifier_remove(n, vdev);
+    vhost_user_host_notifier_remove(n, vdev, false);
 
     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
         return 0;
@@ -2736,15 +2749,7 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
 static void vhost_user_state_destroy(gpointer data)
 {
     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
-    if (n) {
-        vhost_user_host_notifier_remove(n, NULL);
-        object_unparent(OBJECT(&n->mr));
-        /*
-         * We can't free until vhost_user_host_notifier_remove has
-         * done it's thing so schedule the free with RCU.
-         */
-        g_free_rcu(n, rcu);
-    }
+    vhost_user_host_notifier_remove(n, NULL, true);
 }
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
@@ -2765,9 +2770,7 @@ void vhost_user_cleanup(VhostUserState *user)
     if (!user->chr) {
         return;
     }
-    memory_region_transaction_begin();
     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
-    memory_region_transaction_commit();
     user->chr = NULL;
 }
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 324cd8663a..9a3f238b43 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
     void *addr;
     void *unmap_addr;
     int idx;
+    bool destroy;
 } VhostUserHostNotifier;
 
 /**
-- 
2.41.0


