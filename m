Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB00C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6C4-0006c7-8q; Thu, 05 Jun 2025 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C2-0006bc-7H
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C0-0008GO-E4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73TfOwYpQB4Y91rrzUSKsHCU3q1wMj/Zwc2XYIgFEE4=;
 b=aDkDASREAGFusXd7aQ+f9tGPphcOBy83tW8qib8NmGcjOhfu/5y2Q4UzZoSDcCMmJlunRW
 3aMOGBuK5jQw6VTiAiWOODwzz48htVACugFfgfK/cK38bgm4kesBQw2bkCByc7wbKZW15Y
 vljTQHetJ79DTOkEp5+lX0KWuYqhGC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-ADsGabTnPy-vk5GGHgo34g-1; Thu,
 05 Jun 2025 04:43:16 -0400
X-MC-Unique: ADsGabTnPy-vk5GGHgo34g-1
X-Mimecast-MFC-AGG-ID: ADsGabTnPy-vk5GGHgo34g_1749112995
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 355451956080; Thu,  5 Jun 2025 08:43:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ECE91954B3C; Thu,  5 Jun 2025 08:43:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 09/16] vfio/container: pass MemoryRegion to DMA operations
Date: Thu,  5 Jun 2025 10:42:38 +0200
Message-ID: <20250605084245.1520562-10-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later, to translate
the vaddr into an offset for the dma map vfio-user message; CPR will
also will need this.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250521215534.2688540-1-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 9 +++++----
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 3 ++-
 hw/vfio/iommufd.c                     | 3 ++-
 hw/vfio/listener.c                    | 6 +++---
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f9e561cb081b361291e72ffe228845bd6b157f92..3feb773e5f41706a310b676c088ff95a85304325 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mr);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -151,20 +151,21 @@ struct VFIOIOMMUClass {
     /**
      * @dma_map
      *
-     * Map an address range into the container.
+     * Map an address range into the container. Note that the memory region is
+     * referenced within an RCU read lock region across this call.
      *
      * @bcontainer: #VFIOContainerBase to use
      * @iova: start address to map
      * @size: size of the range to map
      * @vaddr: process virtual address of mapping
      * @readonly: true if mapping should be readonly
+     * @mr: the memory region for this mapping
      *
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
-
+                   void *vaddr, bool readonly, MemoryRegion *mr);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b6040813a63bb8fca07b25189a8d8cb76..d834bd482290a8b195f94c07832b7f8020504c3a 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dbaec4c8d83450048d9bc53b34d859731ebb..a8c76eb48165405e2b41186a266dbc69ae1b782a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mr)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6b2696793f82fd68c306b85407b5f98201b9f5c6..46a3b36301e9a690e04347005e64552ed0abede5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mr)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 38e3dc82cf3a3c46e4319e6245f6143749b3cccf..74958661236e230751e52dbfc7857426358dcaac 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -170,7 +170,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mr);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -240,7 +240,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -564,7 +564,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
-- 
2.49.0


