Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D92CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv02i-0003dA-EU; Sat, 06 Sep 2025 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02Z-0003Yc-MN; Sat, 06 Sep 2025 17:01:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv02Q-0005pR-0B; Sat, 06 Sep 2025 17:01:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D58E150F80;
 Sun, 07 Sep 2025 00:00:55 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C20F927868B;
 Sun,  7 Sep 2025 00:00:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 21/34] virtio-net: Add queues before loading them
Date: Sun,  7 Sep 2025 00:00:41 +0300
Message-ID: <20250906210056.127031-3-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Call virtio_net_set_multiqueue() to add queues before loading their
states. Otherwise the loaded queues will not have handlers and elements
in them will not be processed.

Cc: qemu-stable@nongnu.org
Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Fixes: 653217a501a1 ("virtio-net: Add only one queue pair when realizing" in 7.2.x)
Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 9379ea9db3c0064fa2787db0794a23a30f7b2d2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d7d155a44d..5dedfdf2e2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2973,6 +2973,15 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     virtio_net_set_queue_pairs(n);
 }
 
+static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+{
+    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
+                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+
+    return 0;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -3910,6 +3919,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->pre_load_queues = virtio_net_pre_load_queues;
     vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5914f839ea..a6a6f23d3a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3656,6 +3656,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ab3eb182f4..3f2f4f6d19 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -180,6 +180,8 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
+    /* Called before loading queues. Useful to add queues before loading. */
+    int (*pre_load_queues)(VirtIODevice *vdev);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
-- 
2.47.3


