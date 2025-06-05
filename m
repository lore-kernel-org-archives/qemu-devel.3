Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51DEC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6C3-0006bu-DV; Thu, 05 Jun 2025 04:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6C0-0006bN-Ld
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6By-0008GE-Co
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXRfjXWMi3MYdjVldTg7VzwuSqpbsk0qfgWTpYRQAjw=;
 b=TvjT7LnEWilQM/TbFh2ZH7UOb33INpegALtl+NcChNeckyXVLVscsWyfX80j+H8wSjHyyP
 +l2C6Udn92HU+cvcWjE2t4e+MDKHk1qRWYfLyr2WYqvvCd1RkgQQlm9NkefEo+1ZDvWsH9
 IMEkZoErtUqrtRCgS8FHS5PgcKzosQM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-_H8xHjZKOiOCd8rPT1s8Jw-1; Thu,
 05 Jun 2025 04:43:12 -0400
X-MC-Unique: _H8xHjZKOiOCd8rPT1s8Jw-1
X-Mimecast-MFC-AGG-ID: _H8xHjZKOiOCd8rPT1s8Jw_1749112992
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5EE519560AE; Thu,  5 Jun 2025 08:43:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AF311954B33; Thu,  5 Jun 2025 08:43:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 08/16] vfio: return mr from vfio_get_xlat_addr
Date: Thu,  5 Jun 2025 10:42:37 +0200
Message-ID: <20250605084245.1520562-9-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Steve Sistare <steven.sistare@oracle.com>

Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
region that the translated address is found in.  This will be needed by
CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.

Also return the xlat offset, so we can simplify the interface by removing
the out parameters that can be trivially derived from mr and xlat.

Lastly, rename the functions to  to memory_translate_iotlb() and
vfio_translate_iotlb().

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1747661203-136490-1-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/memory.h | 19 +++++++++----------
 hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
 hw/virtio/vhost-vdpa.c  |  9 +++++++--
 system/memory.c         | 32 +++++++-------------------------
 4 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fc35a0dcad5600dcf9c0699d7765d2a56a3d78a7..0848690ea45dd414d9543be9b24f0c8016657778 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -739,21 +739,20 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
 /**
- * memory_get_xlat_addr: Extract addresses from a TLB entry
+ * memory_translate_iotlb: Extract addresses from a TLB entry.
+ *                         Called with rcu_read_lock held.
  *
  * @iotlb: pointer to an #IOMMUTLBEntry
- * @vaddr: virtual address
- * @ram_addr: RAM address
- * @read_only: indicates if writes are allowed
- * @mr_has_discard_manager: indicates memory is controlled by a
- *                          RamDiscardManager
+ * @xlat_p: return the offset of the entry from the start of the returned
+ *          MemoryRegion.
  * @errp: pointer to Error*, to store an error if it happens.
  *
- * Return: true on success, else false setting @errp with error.
+ * Return: On success, return the MemoryRegion containing the @iotlb translated
+ *         addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
+ *         On failure, return NULL, setting @errp with error.
  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9cd5b7764a1678142eedf6d553cc07a..38e3dc82cf3a3c46e4319e6245f6143749b3cccf 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
            section->offset_within_address_space & (1ULL << 63);
 }
 
-/* Called with rcu_read_lock held.  */
-static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+/*
+ * Called with rcu_read_lock held.
+ * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
+ */
+static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                          Error **errp)
 {
-    bool ret, mr_has_discard_manager;
+    MemoryRegion *mr;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
+    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
+    if (mr && memory_region_has_ram_discard_manager(mr)) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
          * pages will remain pinned inside vfio until unmapped, resulting in a
@@ -118,7 +119,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                          " intended via an IOMMU. It's possible to mitigate "
                          " by setting/adjusting RLIMIT_MEMLOCK.");
     }
-    return ret;
+    return mr;
 }
 
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mr;
+    hwaddr xlat;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,10 +153,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             goto out;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
@@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     ram_addr_t translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
+    MemoryRegion *mr;
+    hwaddr xlat;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
@@ -1021,9 +1030,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+    if (!mr) {
         goto out_unlock;
     }
+    translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e20da95f30368ac05b3a22f13bca1cfd09adb3d1..7061b6e1a3863e7090577214dc0bfa8e2185aebe 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     int ret;
     Int128 llend;
     Error *local_err = NULL;
+    MemoryRegion *mr;
+    hwaddr xlat;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -228,11 +230,14 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
-                                  &local_err)) {
+        mr = memory_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             return;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
diff --git a/system/memory.c b/system/memory.c
index 63b983efcdb98f27de87a86fa467328a8e0a0c41..306e9ff9ebc58a2f17a23fdd7f8c60b5d9c683fb 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 }
 
 /* Called with rcu_read_lock held.  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
     hwaddr len = iotlb->addr_mask + 1;
     bool writable = iotlb->perm & IOMMU_WO;
 
-    if (mr_has_discard_manager) {
-        *mr_has_discard_manager = false;
-    }
     /*
      * The IOMMU TLB entry we have just covers translation through
      * this IOMMU to its immediate target.  We need to translate
@@ -2195,7 +2191,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                  &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
         error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
-        return false;
+        return NULL;
     } else if (memory_region_has_ram_discard_manager(mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
         MemoryRegionSection tmp = {
@@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             .offset_within_region = xlat,
             .size = int128_make64(len),
         };
-        if (mr_has_discard_manager) {
-            *mr_has_discard_manager = true;
-        }
         /*
          * Malicious VMs can map memory into the IOMMU, which is expected
          * to remain discarded. vfio will pin all pages, populating memory.
@@ -2216,7 +2209,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
                          " via virtio-mem): %" HWADDR_PRIx "",
                          iotlb->translated_addr);
-            return false;
+            return NULL;
         }
     }
 
@@ -2226,22 +2219,11 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
      */
     if (len & iotlb->addr_mask) {
         error_setg(errp, "iommu has granularity incompatible with target AS");
-        return false;
-    }
-
-    if (vaddr) {
-        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    }
-
-    if (ram_addr) {
-        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
-    }
-
-    if (read_only) {
-        *read_only = !writable || mr->readonly;
+        return NULL;
     }
 
-    return true;
+    *xlat_p = xlat;
+    return mr;
 }
 
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
-- 
2.49.0


