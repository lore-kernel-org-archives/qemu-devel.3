Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB4BC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgYl-0006Tj-Fg; Tue, 28 Jan 2025 03:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXZ-0002Km-9u; Tue, 28 Jan 2025 03:01:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXX-0001w3-Go; Tue, 28 Jan 2025 03:01:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4667E1B51;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 202441A6304;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id EDA7C52099; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 10/58] virtio-net: Add queues before loading them
Date: Mon, 27 Jan 2025 23:24:56 +0300
Message-Id: <20250127202547.3723716-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Call virtio_net_set_multiqueue() to add queues before loading their
states. Otherwise the loaded queues will not have handlers and elements
in them will not be processed.

Cc: qemu-stable@nongnu.org
Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")
Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 9379ea9db3c0064fa2787db0794a23a30f7b2d2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cf27d5cbe5..c1fe457359 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3035,6 +3035,15 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
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
@@ -4013,6 +4022,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->pre_load_queues = virtio_net_pre_load_queues;
     vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9e10cbc058..10f24a58dd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3251,6 +3251,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
index 0fcbc5c0c6..953dfca27c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -210,6 +210,8 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
+    /* Called before loading queues. Useful to add queues before loading. */
+    int (*pre_load_queues)(VirtIODevice *vdev);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
-- 
2.39.5


