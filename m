Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D85C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa2-0003fX-CJ; Fri, 09 May 2025 09:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYn-0002A5-4e
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYj-0007Cp-Rd
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+IUI1D9cjbiOm7hd7wAS6/yA6X34fHJ9w+XyvKkSk8=;
 b=eAwQ8Gvi3+NO7cDdlJyrXIYhDxq4MkORUTtpuwmIyqt33i4EOrH/aqMV7jUtjERhxyajOb
 U5MO4lSS6FcOES+AFcM1gGzyt49bHJHXnw9qMYC1fGYQda2YUmgFcQpejaGsn0pYqLC+Cy
 b8TNN4VIFBk+8EyT75kcKngOLLU6T94=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-Rx4ULiNeO2SRDdSJjo2RSw-1; Fri,
 09 May 2025 09:14:35 -0400
X-MC-Unique: Rx4ULiNeO2SRDdSJjo2RSw-1
X-Mimecast-MFC-AGG-ID: Rx4ULiNeO2SRDdSJjo2RSw_1746796474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4FF18004AD; Fri,  9 May 2025 13:14:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E25618003FD; Fri,  9 May 2025 13:14:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/28] vfio: add unmap_all flag to DMA unmap callback
Date: Fri,  9 May 2025 15:13:11 +0200
Message-ID: <20250509131317.164235-23-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

We'll use this parameter shortly; this just adds the plumbing.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-9-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 15 +++++++++++++--
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  8 ++++++--
 hw/vfio/iommufd.c                     |  6 +++++-
 hw/vfio/listener.c                    |  8 ++++----
 5 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 5527e027220ac05f82d2a9beaf8b921e26597271..59f07d26e8226916c9c58eac07cb494552097138 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -81,7 +81,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, bool unmap_all);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -120,9 +120,20 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+    /**
+     * @dma_unmap
+     *
+     * Unmap an address range from the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use for unmap
+     * @iova: start address to unmap
+     * @size: size of the range to unmap
+     * @iotlb: The IOMMU TLB mapping entry (or NULL)
+     * @unmap_all: if set, unmap the entire address space
+     */
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, bool unmap_all);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 09340fd97a074c9a3b56c686e7a750530bed619f..3ff473a45c2db779a54f3d8e77079d4a1601eb36 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -85,12 +85,12 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_unmap);
-    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb, unmap_all);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index cf23aa799f61da58da09411ca6213a753a7f4794..d5f4e66f1c4146c2eb6a2ce209c74c4d391c27ce 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -124,7 +124,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,6 +138,10 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -205,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, false) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 62ecb758f1ade0e39efaef2b4001dab91abaa001..6b2764c044135b95c199b5df2f864156817fb6fc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -46,11 +46,15 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    if (unmap_all) {
+        return -ENOTSUP;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 6f77e18a7a2f9437d50976eeb9847f99bfe4a739..c5183700dbd859c9a66083f2cb6f74a75a01cc66 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -172,7 +172,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, false);
         if (ret) {
             error_setg(&local_err,
                        "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
@@ -201,7 +201,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL, false);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -638,7 +638,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             llsize = int128_rshift(llsize, 1);
             ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
+                                           int128_get64(llsize), NULL, false);
             if (ret) {
                 error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                              "0x%"HWADDR_PRIx") = %d (%s)",
@@ -648,7 +648,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
             iova += int128_get64(llsize);
         }
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+                                       int128_get64(llsize), NULL, false);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.49.0


