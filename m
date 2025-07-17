Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B643C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGq-0006i5-7l; Thu, 17 Jul 2025 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1w-0002xj-MA; Thu, 17 Jul 2025 05:35:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1u-00027P-Bs; Thu, 17 Jul 2025 05:35:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B4435137CFE;
 Thu, 17 Jul 2025 12:34:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 940BD2491F7;
 Thu, 17 Jul 2025 12:34:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 61/65] vhost: Fix used memslot tracking when
 destroying a vhost device
Date: Thu, 17 Jul 2025 12:33:57 +0300
Message-ID: <20250717093412.728292-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

When we unplug a vhost device, we end up calling vhost_dev_cleanup()
where we do a memory_listener_unregister().

This memory_listener_unregister() call will end up disconnecting the
listener from the address space through listener_del_address_space().

In that process, we effectively communicate the removal of all memory
regions from that listener, resulting in region_del() + commit()
callbacks getting triggered.

So in case of vhost, we end up calling vhost_commit() with no remaining
memory slots (0).

In vhost_commit() we end up overwriting the global variables
used_memslots / used_shared_memslots, used for detecting the number
of free memslots. With used_memslots / used_shared_memslots set to 0
by vhost_commit() during device removal, we'll later assume that the
other vhost devices still have plenty of memslots left when calling
vhost_get_free_memslots().

Let's fix it by simply removing the global variables and depending
only on the actual per-device count.

Easy to reproduce by adding two vhost-user devices to a VM and then
hot-unplugging one of them.

While at it, detect unexpected underflows in vhost_get_free_memslots()
and issue a warning.

Reported-by: yuanminghao <yuanmh12@chinatelecom.cn>
Link: https://lore.kernel.org/qemu-devel/20241121060755.164310-1-yuanmh12@chinatelecom.cn/
Fixes: 2ce68e4cf5be ("vhost: add vhost_has_free_slot() interface")
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20250603111336.1858888-1-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9f749129e2629b19f424df106c92c5a5647e396c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..99d31cc1b4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -47,12 +47,6 @@ static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
 static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 
-/* Memslots used by backends that support private memslots (without an fd). */
-static unsigned int used_memslots;
-
-/* Memslots used by backends that only support shared memslots (with an fd). */
-static unsigned int used_shared_memslots;
-
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
@@ -74,15 +68,15 @@ unsigned int vhost_get_free_memslots(void)
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
         unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        unsigned int cur_free;
+        unsigned int cur_free = r - hdev->mem->nregions;
 
-        if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
-            hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
-            cur_free = r - used_shared_memslots;
+        if (unlikely(r < hdev->mem->nregions)) {
+            warn_report_once("used (%u) vhost backend memory slots exceed"
+                             " the device limit (%u).", hdev->mem->nregions, r);
+            free = 0;
         } else {
-            cur_free = r - used_memslots;
+            free = MIN(free, cur_free);
         }
-        free = MIN(free, cur_free);
     }
     return free;
 }
@@ -666,13 +660,6 @@ static void vhost_commit(MemoryListener *listener)
     dev->mem = g_realloc(dev->mem, regions_size);
     dev->mem->nregions = dev->n_mem_sections;
 
-    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
-        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
-        used_shared_memslots = dev->mem->nregions;
-    } else {
-        used_memslots = dev->mem->nregions;
-    }
-
     for (i = 0; i < dev->n_mem_sections; i++) {
         struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
         struct MemoryRegionSection *mrs = dev->mem_sections + i;
@@ -1619,15 +1606,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
-     * The listener we registered properly updated the corresponding counter.
-     * So we can trust that these values are accurate.
+     * The listener we registered properly setup the number of required
+     * memslots in vhost_commit().
      */
-    if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
-        hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
-        used = used_shared_memslots;
-    } else {
-        used = used_memslots;
-    }
+    used = hdev->mem->nregions;
+
     /*
      * We assume that all reserved memslots actually require a real memslot
      * in our vhost backend. This might not be true, for example, if the
-- 
2.47.2


