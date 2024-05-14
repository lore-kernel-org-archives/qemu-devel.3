Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9989C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6u8p-0001Ua-O4; Tue, 14 May 2024 11:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u8D-0001L1-K2
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u8B-0000a7-PF
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715700715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZj2PfVq3ADGOsN3a8NEycy3x/pIN9gywBfbm7M6pUU=;
 b=NZDUGgvmzminBeyjfLaD4ObTYo2E5WJLv6t11BIf/2BQIU6Upx5d0UpUKnrQM8S4SFVD2n
 2dqeaIc+kegZrc/YlLagwJLmV9otUsXaeSmDCQuuoHWsVnpT5G3r7tC3J7n8ZITfU7yIA1
 EdN404DAlZMK3FZSgxOSdrykAul2QfY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-zeA3v4qrO6SvVZdv3WFFCA-1; Tue,
 14 May 2024 11:31:50 -0400
X-MC-Unique: zeA3v4qrO6SvVZdv3WFFCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77F8929AB407;
 Tue, 14 May 2024 15:31:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D12AA21EE56C;
 Tue, 14 May 2024 15:31:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 7/9] memory: Add Error** argument to memory_get_xlat_addr()
Date: Tue, 14 May 2024 17:31:28 +0200
Message-ID: <20240514153130.394307-8-clg@redhat.com>
In-Reply-To: <20240514153130.394307-1-clg@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let the callers do the reporting. This will be useful in
vfio_iommu_map_dirty_notify().

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v6:

 - Fixed memory_get_xlat_addr documentation (Avihai)
 
 include/exec/memory.h  | 15 ++++++++++++++-
 hw/vfio/common.c       | 13 +++++++++----
 hw/virtio/vhost-vdpa.c |  5 ++++-
 system/memory.c        | 10 +++++-----
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d417d7f363dbbca6553c449582a93d5da73cca40..9cdd64e9c69b63f9d27cebc2e8cb366e22ed7577 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -774,9 +774,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
 void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
+/**
+ * memory_get_xlat_addr: Extract addresses from a TLB entry
+ *
+ * @iotlb: pointer to an #IOMMUTLBEntry
+ * @vaddr: virtual address
+ * @ram_addr: RAM address
+ * @read_only: indicates if writes are allowed
+ * @mr_has_discard_manager: indicates memory is controlled by a
+ *                          RamDiscardManager
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: true on success, else false setting @errp with error.
+ */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager);
+                          bool *mr_has_discard_manager, Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4e2ef3d3034e72aa6a546bcb9ea1f31a0bbd5b1b..919c4c52bc1590fd6c0bda37ba5881f58ff2ffff 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -253,12 +253,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only)
+                               ram_addr_t *ram_addr, bool *read_only,
+                               Error **errp)
 {
     bool ret, mr_has_discard_manager;
 
     ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager);
+                               &mr_has_discard_manager, errp);
     if (ret && mr_has_discard_manager) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
@@ -288,6 +289,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
+    Error *local_err = NULL;
 
     trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
                                 iova, iova + iotlb->addr_mask);
@@ -304,7 +306,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+            error_report_err(local_err);
             goto out;
         }
         /*
@@ -1213,6 +1216,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
+    Error *local_err = NULL;
     int ret = -EINVAL;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
@@ -1224,7 +1228,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+        error_report_err(local_err);
         goto out_unlock;
     }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e827b9175fc61f1ef419e48d90a440b00449312a..ed99ab87457d8f31b98ace960713f48d47b27102 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -208,6 +208,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     void *vaddr;
     int ret;
     Int128 llend;
+    Error *local_err = NULL;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -227,7 +228,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+                                  &local_err)) {
+            error_report_err(local_err);
             return;
         }
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
diff --git a/system/memory.c b/system/memory.c
index 642a449f8c867d38c62a748a4dfd5c055637c205..9540caa8a1f4da8501bf5ae9d7eedde8b775e1dc 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2179,7 +2179,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager)
+                          bool *mr_has_discard_manager, Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2197,7 +2197,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
     mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
                                  &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
-        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
+        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
         return false;
     } else if (memory_region_has_ram_discard_manager(mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
@@ -2216,8 +2216,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
          * were already restored before IOMMUs are restored.
          */
         if (!ram_discard_manager_is_populated(rdm, &tmp)) {
-            error_report("iommu map to discarded memory (e.g., unplugged via"
-                         " virtio-mem): %" HWADDR_PRIx "",
+            error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
+                         " via virtio-mem): %" HWADDR_PRIx "",
                          iotlb->translated_addr);
             return false;
         }
@@ -2228,7 +2228,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
      * check that it did not truncate too much.
      */
     if (len & iotlb->addr_mask) {
-        error_report("iommu has granularity incompatible with target AS");
+        error_setg(errp, "iommu has granularity incompatible with target AS");
         return false;
     }
 
-- 
2.45.0


