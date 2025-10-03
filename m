Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E50CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d73-0006fd-9L; Fri, 03 Oct 2025 06:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d71-0006ai-1C
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6m-0004kc-0m
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEnAz3DRaMmi/3jIfdFEqwFvBj968VN58jIC2caKuiE=;
 b=akw7cN2x0RHGSBxTcdwUnztQBkAzEKfOCS09C8tqShGkyHDLBw/OWlaKVBDBUgmQJTCtTr
 hvrmbR7eW4T9knlC3cm3gb4iZ2QFXDOVTKpmqkM1GVzm3DGHLDl+nyq6MAGH2tHP9SYyXp
 hx4PAMrF3pgeYMVjpf3vT4JYRsEt6Ns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-oka95bRqOH6LGkA3rwrC6w-1; Fri,
 03 Oct 2025 06:33:44 -0400
X-MC-Unique: oka95bRqOH6LGkA3rwrC6w-1
X-Mimecast-MFC-AGG-ID: oka95bRqOH6LGkA3rwrC6w_1759487623
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E5C1800452; Fri,  3 Oct 2025 10:33:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 218D7300018D; Fri,  3 Oct 2025 10:33:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/5] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Date: Fri,  3 Oct 2025 12:33:28 +0200
Message-ID: <20251003103328.1864910-6-clg@redhat.com>
In-Reply-To: <20251003103328.1864910-1-clg@redhat.com>
References: <20251003103328.1864910-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

This doesn't represent well an IOVA mapping size. Simply use
the uint64_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250930123528.42878-5-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h | 10 +++++-----
 include/hw/vfio/vfio-cpr.h       |  2 +-
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              |  4 ++--
 hw/vfio/cpr-legacy.c             |  2 +-
 hw/vfio/iommufd.c                |  6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 093c360f0eef5547d493525df64d486475d6680b..c4b58d664b7e705d29be0e7116d609c6df0d42a9 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -81,10 +81,10 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
                                VFIOContainer *bcontainer);
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
-                           hwaddr iova, ram_addr_t size,
+                           hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr);
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
-                             hwaddr iova, ram_addr_t size,
+                             hwaddr iova, uint64_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
 bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
@@ -167,7 +167,7 @@ struct VFIOIOMMUClass {
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_map)(const VFIOContainer *bcontainer,
-                   hwaddr iova, ram_addr_t size,
+                   hwaddr iova, uint64_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
     /**
      * @dma_map_file
@@ -182,7 +182,7 @@ struct VFIOIOMMUClass {
      * @readonly: map read only if true
      */
     int (*dma_map_file)(const VFIOContainer *bcontainer,
-                        hwaddr iova, ram_addr_t size,
+                        hwaddr iova, uint64_t size,
                         int fd, unsigned long start, bool readonly);
     /**
      * @dma_unmap
@@ -198,7 +198,7 @@ struct VFIOIOMMUClass {
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_unmap)(const VFIOContainer *bcontainer,
-                     hwaddr iova, ram_addr_t size,
+                     hwaddr iova, uint64_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
 
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 26ee0c4fe15ac74b5123f57c20c94486171d4779..81f4e24e229ef35f5b14582ce6e58415e0ebf3df 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -21,7 +21,7 @@ struct VFIOIOMMUFDContainer;
 struct IOMMUFDBackend;
 
 typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
-                          hwaddr iova, ram_addr_t size, void *vaddr,
+                          hwaddr iova, uint64_t size, void *vaddr,
                           bool readonly, MemoryRegion *mr);
 
 typedef struct VFIOContainerCPR {
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 411eb7b28b72a25cd68d494ffc4a8f9b55b4862d..e45192fef6531872e484372d45dca82fac6cb88f 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -39,7 +39,7 @@ static void vfio_user_listener_commit(VFIOContainer *bcontainer)
 }
 
 static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
-                               hwaddr iova, ram_addr_t size,
+                               hwaddr iova, uint64_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
@@ -81,7 +81,7 @@ static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
 }
 
 static int vfio_user_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
-                             ram_addr_t size, void *vaddr, bool readonly,
+                             uint64_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 25a15ea8674c159b7e624425c52953240b8c1179..34352dd31fc9b1963c8597ac9e7f8a76fe653ad9 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -69,7 +69,7 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
 }
 
 static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *bcontainer = VFIO_IOMMU(container);
@@ -122,7 +122,7 @@ unmap_exit:
 }
 
 static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
-                                     hwaddr iova, ram_addr_t size,
+                                     hwaddr iova, uint64_t size,
                                      IOMMUTLBEntry *iotlb)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -167,7 +167,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
 static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     int ret;
@@ -192,7 +192,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly,
+                               uint64_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9d69439371402940fcbc926737215eb9308b237a..41de343924614ddab08b5a02af11a5415272c29a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -74,7 +74,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 }
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
-                           hwaddr iova, ram_addr_t size,
+                           hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -93,7 +93,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
 }
 
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
-                             hwaddr iova, ram_addr_t size,
+                             hwaddr iova, uint64_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bbf7a0d35f0ba2b78fd40a60b6e47337665dcbb9..3a1d126556e11c60502084d43138a49c29327ba9 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -39,7 +39,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
  * The incoming state is cleared thereafter.
  */
 static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
-                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   hwaddr iova, uint64_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f0ffe2359196505468dd5ed159440f4655847d42..68470d552eccc67afbf757de192ba53431e4840b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -35,7 +35,7 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly,
+                            uint64_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
@@ -46,7 +46,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
 }
 
 static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  int fd, unsigned long start, bool readonly)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
@@ -57,7 +57,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
 }
 
 static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
-                              hwaddr iova, ram_addr_t size,
+                              hwaddr iova, uint64_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
-- 
2.51.0


