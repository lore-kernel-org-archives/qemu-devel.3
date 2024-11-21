Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A7EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmu6j-0008NM-3i; Tue, 25 Feb 2025 07:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanmh12@chinatelecom.cn>)
 id 1tmu6a-0008MF-Gp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:32:12 -0500
Received: from smtpnm6-05.21cn.com ([182.42.157.213] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanmh12@chinatelecom.cn>) id 1tmu6W-00029y-It
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:32:08 -0500
HMM_SOURCE_IP: 192.168.139.44:0.2083019727
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.84 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 759689C1E41;
 Tue, 25 Feb 2025 20:24:27 +0800 (CST)
X-189-SAVE-TO-SEND: +yuanmh12@chinatelecom.cn
Received: from  ([36.111.64.84])
 by gateway-ssl-dep-84dfd8c7d7-g6c8d with ESMTP id
 97978b9255744c09b859c0159951367a for qemu-devel@nongnu.org; 
 Tue, 25 Feb 2025 20:24:30 CST
X-Transaction-ID: 97978b9255744c09b859c0159951367a
X-Real-From: yuanmh12@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
From: yuanminghao <yuanmh12@chinatelecom.cn>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/1] vhost: do not reset used_memslots when destroying vhost
 dev
Date: Thu, 21 Nov 2024 14:07:55 +0800
Message-Id: <20241121060755.164310-1-yuanmh12@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.157.213;
 envelope-from=yuanmh12@chinatelecom.cn; helo=chinatelecom.cn
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The global used_memslots or used_shared_memslots is updated to 0 unexpectly
when a vhost device destroyed. This can occur during scenarios such as live
detaching a vhost device or restarting a vhost-user net backend (e.g., OVS-DPDK):
 #0  vhost_commit(listener) at hw/virtio/vhost.c:439
 #1  listener_del_address_space(as, listener) at memory.c:2777
 #2  memory_listener_unregister(listener) at memory.c:2823
 #3  vhost_dev_cleanup(hdev) at hw/virtio/vhost.c:1406
 #4  vhost_net_cleanup(net) at hw/net/vhost_net.c:402
 #5  vhost_user_start(be, ncs, queues) at net/vhost-user.c:113
 #6  net_vhost_user_event(opaque, event) at net/vhost-user.c:281
 #7  tcp_chr_new_client(chr, sioc) at chardev/char-socket.c:924
 #8  tcp_chr_accept(listener, cioc, opaque) at chardev/char-socket.c:961

So we skip the update of used_memslots and used_shared_memslots when destroying
vhost devices, and it should work event if all vhost devices are removed.

Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
---
 hw/virtio/vhost.c         | 14 +++++++++-----
 include/hw/virtio/vhost.h |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..2258a12066 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -666,11 +666,13 @@ static void vhost_commit(MemoryListener *listener)
     dev->mem = g_realloc(dev->mem, regions_size);
     dev->mem->nregions = dev->n_mem_sections;
 
-    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
-        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
-        used_shared_memslots = dev->mem->nregions;
-    } else {
-        used_memslots = dev->mem->nregions;
+    if (!dev->listener_removing) {
+        if (dev->vhost_ops->vhost_backend_no_private_memslots &&
+            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
+            used_shared_memslots = dev->mem->nregions;
+        } else {
+            used_memslots = dev->mem->nregions;
+        }
     }
 
     for (i = 0; i < dev->n_mem_sections; i++) {
@@ -1668,7 +1670,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     }
     if (hdev->mem) {
         /* those are only safe after successful init */
+        hdev->listener_removing = true;
         memory_listener_unregister(&hdev->memory_listener);
+        hdev->listener_removing = false;
         QLIST_REMOVE(hdev, entry);
     }
     migrate_del_blocker(&hdev->migration_blocker);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a9469d50bc..037f85b642 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -133,6 +133,7 @@ struct vhost_dev {
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
     const VhostDevConfigOps *config_ops;
+    bool listener_removing;
 };
 
 extern const VhostOps kernel_ops;
-- 
2.27.0


