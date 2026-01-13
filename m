Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E038FD29DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqm-0002lO-Tf; Tue, 13 Jan 2026 04:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqj-0002W1-Tj
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqh-0003RL-OZ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zt4qz9zkLm4guZEvlZSD9b2rLiteAgTtol3j0jSCt7k=;
 b=GlgcNszWCtlZZpnzVk7aYiDSId/yExVRu0J+a3LN52MiAY8+rwZQRIl20G0FBI7Qwn9A9g
 cukGzX6D/7KM5z18XN3ch5TpceYXrdRWt8ioJGHIoY6fUUhTA3UI1em4XUG/u8EGwTReN8
 ZL5593jI66YlDUumuNSuJ3xoCnGodXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-vTF202MlOPSf76pRdC3_Ng-1; Tue,
 13 Jan 2026 04:37:57 -0500
X-MC-Unique: vTF202MlOPSf76pRdC3_Ng-1
X-Mimecast-MFC-AGG-ID: vTF202MlOPSf76pRdC3_Ng_1768297076
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F7EF1954B24; Tue, 13 Jan 2026 09:37:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 771BA30001A2; Tue, 13 Jan 2026 09:37:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>
Subject: [PULL 25/41] vfio: Add a backend_flag parameter to
 vfio_container_query_dirty_bitmap()
Date: Tue, 13 Jan 2026 10:36:21 +0100
Message-ID: <20260113093637.1549214-26-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joao Martins <joao.m.martins@oracle.com>

This new parameter will be used in following patch, currently 0 is passed.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-5-zhenzhong.duan@intel.com
[ clg: Fixed subject typo ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  8 ++++++--
 hw/vfio-user/container.c         |  5 +++--
 hw/vfio/container-legacy.c       |  5 +++--
 hw/vfio/container.c              | 15 +++++++++------
 hw/vfio/iommufd.c                |  7 ++++---
 hw/vfio/listener.c               |  6 +++---
 hw/vfio/trace-events             |  2 +-
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index c4b58d664b7e705d29be0e7116d609c6df0d42a9..9f6e8cedfc9541e84558d74bdb156e4963a68639 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -99,7 +99,9 @@ bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      hwaddr translated_addr, Error **errp);
+                                      uint64_t backend_flag,
+                                      hwaddr translated_addr,
+                                      Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
@@ -253,12 +255,14 @@ struct VFIOIOMMUClass {
      * @vbmap: #VFIOBitmap internal bitmap structure
      * @iova: iova base address
      * @size: size of iova range
+     * @backend_flag: flags for backend, opaque to upper layer container
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error.
      */
     int (*query_dirty_bitmap)(const VFIOContainer *bcontainer,
-                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
+                              VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                              uint64_t backend_flag, Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d5275a463b8d99eae967114e4e0ade70b2076570..796289a469033ef47fa7199dbe30d02f0ba83ada 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -163,8 +163,9 @@ vfio_user_set_dirty_page_tracking(const VFIOContainer *bcontainer,
 }
 
 static int vfio_user_query_dirty_bitmap(const VFIOContainer *bcontainer,
-                                         VFIOBitmap *vbmap, hwaddr iova,
-                                         hwaddr size, Error **errp)
+                                        VFIOBitmap *vbmap, hwaddr iova,
+                                        hwaddr size, uint64_t backend_flag,
+                                        Error **errp)
 {
     error_setg_errno(errp, ENOTSUP, "Not supported");
     return -ENOTSUP;
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 48bcbc0264effc100642ff59f510533bf0ad2180..625f151364c060135076cd19537810bbe61ab998 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                     iotlb->translated_addr, &local_err);
         if (ret) {
             error_report_err(local_err);
@@ -255,7 +255,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainer *bcontainer,
 }
 
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
-                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+                                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                                   uint64_t backend_flag, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5993d9054579077683720959cfc8e0d76eef519d..9881f5df2cc34262ae6aa88aa937659e7b197cd2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -213,13 +213,13 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 
 static int vfio_container_iommu_query_dirty_bitmap(
     const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
-    hwaddr size, Error **errp)
+    hwaddr size, uint64_t backend_flag, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->query_dirty_bitmap);
     return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
-                                               errp);
+                                    backend_flag, errp);
 }
 
 static int vfio_container_devices_query_dirty_bitmap(
@@ -247,7 +247,9 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      hwaddr translated_addr, Error **errp)
+                                      uint64_t backend_flag,
+                                      hwaddr translated_addr,
+                                      Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -274,7 +276,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                                         errp);
     } else {
         ret = vfio_container_iommu_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                     errp);
+                                                      backend_flag, errp);
     }
 
     if (ret) {
@@ -285,8 +287,9 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                                          translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
-                                            translated_addr, dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, backend_flag,
+                                            vbmap.size, translated_addr,
+                                            dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6d6244d7b9723def647f3dd4eec7ef1558415bb2..a3fb674f50eea549d0aaaaa7138e8981d343697d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -74,7 +74,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                                     iotlb->translated_addr,
                                                     &local_err);
             if (ret) {
@@ -100,7 +100,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                                 iotlb->translated_addr,
                                                 &local_err);
         if (ret) {
@@ -216,7 +216,8 @@ err:
 
 static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
-                                      hwaddr size, Error **errp)
+                                      hwaddr size, uint64_t backend_flag,
+                                      Error **errp)
 {
     VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     unsigned long page_size = qemu_real_host_page_size();
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 7af010753597ee99eee12d32f38e945322cbbbbf..62699cb772d786c1510318dff73973ef4d297177 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1083,7 +1083,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                translated_addr, &local_err);
+                                0, translated_addr, &local_err);
     if (ret) {
         error_prepend(&local_err,
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
@@ -1119,7 +1119,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size,
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, 0,
                                             translated_addr, &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1204,7 +1204,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
 
     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                   int128_get64(section->size), translated_addr, errp);
+                   int128_get64(section->size), 0, translated_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1e895448cd9b4f6b0dd5bb445de4acef6090ec62..3c62bab7647a7d027038444fa4b164182d3feb2b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container.c
-vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size=0x%"PRIx64" backend_flag=0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
 
 # container-legacy.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
-- 
2.52.0


