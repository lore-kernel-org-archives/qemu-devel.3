Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE5C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewZJ-0006a6-Kx; Fri, 16 Aug 2024 09:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1ser5r-0000I0-0d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:09:51 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1ser5o-0002E5-64
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:09:50 -0400
To: qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, zuoboqun
 <zuoboqun@baidu.com>
Subject: [PATCH] vhost_net: configure all host notifiers in a single MR
 transaction
Date: Fri, 16 Aug 2024 15:08:35 +0800
Message-ID: <20240816070835.8309-1-zuoboqun@baidu.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.72.15]
X-ClientProxiedBy: BC-Mail-Ex13.internal.baidu.com (172.31.51.53) To
 BJHW-MAIL-EX26.internal.baidu.com (10.127.64.41)
X-FEAS-Client-IP: 10.127.64.14
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=zuoboqun@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 09:00:13 -0400
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
Reply-to:  zuoboqun <zuoboqun@baidu.com>
From:  zuoboqun via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This allows the vhost_net device which has multiple virtqueues to batch
the setup of all its host notifiers. This significantly reduces the
vhost_net device starting and stoping time, e.g. the time spend
on enabling notifiers reduce from 630ms to 75ms and the time spend on
disabling notifiers reduce from 441ms to 45ms for a VM with 192 vCPUs
and 15 vhost-user-net devices (64vq per device) in our case.

Signed-off-by: zuoboqun <zuoboqun@baidu.com>
---
 hw/net/vhost_net.c        | 155 +++++++++++++++++++++++++++++++++++---
 hw/virtio/vhost.c         |   6 +-
 include/hw/virtio/vhost.h |   4 +
 3 files changed, 150 insertions(+), 15 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a788e6937e..28a9aca1a7 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -160,6 +160,135 @@ void vhost_net_save_acked_features(NetClientState *nc)
 #endif
 }
 
+static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int nvhosts)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    struct vhost_net *net;
+    struct vhost_dev *hdev;
+    int r, i, j;
+    NetClientState *peer;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        for (j = 0; j < hdev->nvqs; j++) {
+            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j,
+                                             false);
+            if (r < 0) {
+                error_report("vhost %d VQ %d notifier cleanup failed: %d",
+                              i, j, -r);
+            }
+            assert(r >= 0);
+        }
+    }
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        for (j = 0; j < hdev->nvqs; j++) {
+            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j);
+        }
+        virtio_device_release_ioeventfd(dev);
+    }
+}
+
+static int vhost_net_enable_notifiers(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int cvq)
+{
+    VirtIONet *n = VIRTIO_NET(dev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
+    int nvhosts = data_queue_pairs + cvq;
+    struct vhost_net *net;
+    struct vhost_dev *hdev;
+    int r, i, j;
+    NetClientState *peer;
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvhosts; i++) {
+        if (i < data_queue_pairs) {
+            peer = qemu_get_peer(ncs, i);
+        } else {
+            peer = qemu_get_peer(ncs, n->max_queue_pairs);
+        }
+
+        net = get_vhost_net(peer);
+        hdev = &net->dev;
+        /*
+         * We will pass the notifiers to the kernel, make sure that QEMU
+         * doesn't interfere.
+         */
+        r = virtio_device_grab_ioeventfd(dev);
+        if (r < 0) {
+            error_report("binding does not support host notifiers");
+            memory_region_transaction_commit();
+            goto fail_nvhosts;
+        }
+
+        for (j = 0; j < hdev->nvqs; j++) {
+            r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + j,
+                                             true);
+            if (r < 0) {
+                error_report("vhost %d VQ %d notifier binding failed: %d",
+                              i, j, -r);
+                memory_region_transaction_commit();
+                vhost_dev_disable_notifiers_nvqs(hdev, dev, j);
+                goto fail_nvhosts;
+            }
+        }
+    }
+
+    memory_region_transaction_commit();
+
+    return 0;
+fail_nvhosts:
+    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
+    return r;
+}
+
+/*
+ * Stop processing guest IO notifications in qemu.
+ * Start processing them in vhost in kernel.
+ */
+static void vhost_net_disable_notifiers(VirtIODevice *dev,
+                NetClientState *ncs, int data_queue_pairs, int cvq)
+{
+    vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs,
+                                        data_queue_pairs + cvq);
+}
+
 static int vhost_net_get_fd(NetClientState *backend)
 {
     switch (backend->info->type) {
@@ -270,11 +399,6 @@ static int vhost_net_start_one(struct vhost_net *net,
         }
     }
 
-    r = vhost_dev_enable_notifiers(&net->dev, dev);
-    if (r < 0) {
-        goto fail_notifiers;
-    }
-
     r = vhost_dev_start(&net->dev, dev, false);
     if (r < 0) {
         goto fail_start;
@@ -326,8 +450,6 @@ fail:
     }
     vhost_dev_stop(&net->dev, dev, false);
 fail_start:
-    vhost_dev_disable_notifiers(&net->dev, dev);
-fail_notifiers:
     return r;
 }
 
@@ -349,7 +471,6 @@ static void vhost_net_stop_one(struct vhost_net *net,
     if (net->nc->info->stop) {
         net->nc->info->stop(net->nc);
     }
-    vhost_dev_disable_notifiers(&net->dev, dev);
 }
 
 int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
@@ -394,10 +515,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
      }
 
+    r = vhost_net_enable_notifiers(dev, ncs, data_queue_pairs, cvq);
+    if (r < 0) {
+        error_report("Error enabling host notifiers: %d", -r);
+        goto err;
+    }
+
     r = k->set_guest_notifiers(qbus->parent, total_notifiers, true);
     if (r < 0) {
         error_report("Error binding guest notifier: %d", -r);
-        goto err;
+        goto err_host_notifiers;
     }
 
     for (i = 0; i < nvhosts; i++) {
@@ -412,19 +539,19 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
             r = vhost_set_vring_enable(peer, peer->vring_enable);
 
             if (r < 0) {
-                goto err_start;
+                goto err_guest_notifiers;
             }
         }
 
         r = vhost_net_start_one(get_vhost_net(peer), dev);
         if (r < 0) {
-            goto err_start;
+            goto err_guest_notifiers;
         }
     }
 
     return 0;
 
-err_start:
+err_guest_notifiers:
     while (--i >= 0) {
         peer = qemu_get_peer(ncs, i < data_queue_pairs ?
                                   i : n->max_queue_pairs);
@@ -435,6 +562,8 @@ err_start:
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
         fflush(stderr);
     }
+err_host_notifiers:
+    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
 err:
     return r;
 }
@@ -466,6 +595,8 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
         fflush(stderr);
     }
     assert(r >= 0);
+
+    vhost_net_disable_notifiers(dev, ncs, data_queue_pairs, cvq);
 }
 
 void vhost_net_cleanup(struct vhost_net *net)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 06fc71746e..7c5ef81b55 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1682,9 +1682,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     memset(hdev, 0, sizeof(struct vhost_dev));
 }
 
-static void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
-                                             VirtIODevice *vdev,
-                                             unsigned int nvqs)
+void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                      VirtIODevice *vdev,
+                                      unsigned int nvqs)
 {
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     int i, r;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index d75faf46e9..c75be46c06 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -171,6 +171,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
  */
 void vhost_dev_cleanup(struct vhost_dev *hdev);
 
+void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
+                                      VirtIODevice *vdev,
+                                      unsigned int nvqs);
+
 /**
  * vhost_dev_enable_notifiers() - enable event notifiers
  * @hdev: common vhost_dev structure
-- 
2.42.0.windows.2


