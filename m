Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF6FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d7I-0006nq-3q; Fri, 03 Oct 2025 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d78-0006kM-4R
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6s-0004kw-Of
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDCSj5XvWYv9MVD0aKNskXnPz6kHL93Gvp7vgG38oPk=;
 b=fgGTimZklpR6VwkrytLkTFYlCaX1VEcDAWiiL6pfqnefvQewk0LKIhJ56D4r7sDOOXv3i5
 bOZcG2/s1XqkXDwTHmMru8Ligrk6l33uAeyGaQ7vEwlBO1sZObvPJGi53hNxcfnhCNAL0a
 d9nrSB8k4sKRjoHCPCNcaekuH2K2f10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-jVC2WqxOPyicg8-nb9VGew-1; Fri,
 03 Oct 2025 06:33:42 -0400
X-MC-Unique: jVC2WqxOPyicg8-nb9VGew-1
X-Mimecast-MFC-AGG-ID: jVC2WqxOPyicg8-nb9VGew_1759487621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C90195608C; Fri,  3 Oct 2025 10:33:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01139300018D; Fri,  3 Oct 2025 10:33:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/5] hw/vfio: Avoid ram_addr_t in
 vfio_container_query_dirty_bitmap()
Date: Fri,  3 Oct 2025 12:33:27 +0200
Message-ID: <20251003103328.1864910-5-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

vfio_container_query_dirty_bitmap() doesn't expect such QEMU
intermediate address, but a guest physical addresses. Use the
appropriate 'hwaddr' type, rename as @translated_addr for
clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250930123528.42878-4-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  3 ++-
 hw/vfio/container.c              | 11 ++++++-----
 hw/vfio/listener.c               | 18 +++++++++---------
 hw/vfio/trace-events             |  2 +-
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index b8fb2b8b5d72b1d2a4c00dc89b214b48a371f555..093c360f0eef5547d493525df64d486475d6680b 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -98,7 +98,8 @@ bool vfio_container_dirty_tracking_is_started(
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
-    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
+                                      uint64_t iova, uint64_t size,
+                                      hwaddr translated_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 250b20f424522f4b6a4e864906eed2d8d13efbcd..9d69439371402940fcbc926737215eb9308b237a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -246,7 +246,7 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      ram_addr_t ram_addr, Error **errp)
+                                      hwaddr translated_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     int ret;
 
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(ram_addr, size,
+        cpu_physical_memory_set_dirty_range(translated_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
         return 0;
@@ -280,11 +280,12 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
         goto out;
     }
 
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+                                                         translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
-                                            dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
+                                            translated_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 3b6f17f0c3aa7ef08091f8cc1c3230eff97b5cd7..a2c19a3cec1a923631fe5c31d084cd7615f888c0 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1059,7 +1059,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = gdn->giommu;
     VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
-    ram_addr_t translated_addr;
+    hwaddr translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
     MemoryRegion *mr;
@@ -1108,8 +1108,8 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
-    const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
-                                section->offset_within_region;
+    const hwaddr translated_addr = memory_region_get_ram_addr(section->mr) +
+                                   section->offset_within_region;
     VFIORamDiscardListener *vrdl = opaque;
     Error *local_err = NULL;
     int ret;
@@ -1118,8 +1118,8 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
-                                &local_err);
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size,
+                                            translated_addr, &local_err);
     if (ret) {
         error_report_err(local_err);
     }
@@ -1183,7 +1183,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
 static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
-    ram_addr_t ram_addr;
+    hwaddr translated_addr;
 
     if (memory_region_is_iommu(section->mr)) {
         return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
@@ -1198,12 +1198,12 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
         return ret;
     }
 
-    ram_addr = memory_region_get_ram_addr(section->mr) +
-               section->offset_within_region;
+    translated_addr = memory_region_get_ram_addr(section->mr) +
+                      section->offset_within_region;
 
     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                                 int128_get64(section->size), ram_addr, errp);
+                   int128_get64(section->size), translated_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1b470cc295ecd07db60910843d9fe869ab7b924..1e895448cd9b4f6b0dd5bb445de4acef6090ec62 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container.c
-vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
 
 # container-legacy.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
-- 
2.51.0


