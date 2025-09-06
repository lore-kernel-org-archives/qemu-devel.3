Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7CCA101F
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv02k-0003d6-7B; Sat, 06 Sep 2025 17:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02Z-0003Yd-Mf; Sat, 06 Sep 2025 17:01:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02S-0005qI-9p; Sat, 06 Sep 2025 17:01:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1F268150F81;
 Sun, 07 Sep 2025 00:00:55 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D58F127868C;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 22/34] virtio-net: Add queues for RSS during migration
Date: Sun,  7 Sep 2025 00:00:42 +0300
Message-ID: <20250906210056.127031-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Fixes: 653217a501a1 ("virtio-net: Add only one queue pair when realizing" in 7.2.x)

Tested-by: Lei Yang <leiyang@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit adda0ad56bd28d5a809051cbd190fda5798ec4e4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5dedfdf2e2..785cbbf768 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2928,11 +2928,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
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
@@ -2968,16 +2967,14 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
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
index a6a6f23d3a..82a49b8ab7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3656,13 +3656,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
@@ -3670,6 +3663,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 3f2f4f6d19..5ce9144c4a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -180,8 +180,14 @@ struct VirtioDeviceClass {
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
-- 
2.47.3


