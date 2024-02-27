Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEAFC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4KW-0005aO-D9; Tue, 27 Feb 2024 15:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1pB-0005Lt-Bp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:05:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1p9-0001af-4S
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:05:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tklkh6wkGz4x1d;
 Wed, 28 Feb 2024 05:05:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tklkd3cpGz4x1Y;
 Wed, 28 Feb 2024 05:04:57 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 18/21] memory: Add Error** argument to
 memory_get_xlat_addr()
Date: Tue, 27 Feb 2024 19:03:42 +0100
Message-ID: <20240227180345.548960-19-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:32 -0500
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
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/exec/memory.h  | 15 ++++++++++++++-
 hw/vfio/common.c       | 13 +++++++++----
 hw/virtio/vhost-vdpa.c |  5 ++++-
 system/memory.c        | 10 +++++-----
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8b019465ab13ce85c03075c80865a0865ea1feed..baca989023415b69be3b4b4e7a622f983182314b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -771,9 +771,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
 void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
+/**
+ * memory_get_xlat_addr: Extract addresses from a TLB entry
+ *
+ * @iotlb: pointer to an #IOMMUTLBEntry
+ * @vaddr: virtual addressf
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
index e51757e7d747c60b67deb966bb29b946a511b328..43f37447e3692ffa97788b02f83b81b44aaf301a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -262,12 +262,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 
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
@@ -297,6 +298,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
     int ret;
+    Error *local_err = NULL;
 
     trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
                                 iova, iova + iotlb->addr_mask);
@@ -313,7 +315,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+            error_report_err(local_err);
             goto out;
         }
         /*
@@ -1226,6 +1229,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
+    Error *local_err = NULL;
     int ret = -EINVAL;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
@@ -1237,7 +1241,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+        error_report_err(local_err);
         goto out_lock;
     }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ddae494ca8e8154ce03b88bc781fe9f1e639aceb..a6f06266cfc798b20b98001fa97ce771722175ec 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -203,6 +203,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     void *vaddr;
     int ret;
     Int128 llend;
+    Error *local_err = NULL;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -222,7 +223,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
index 48aed0f8ece1c731849636c442b8ab8e5d7ff6a5..132c026e35cbeb0ab8fa0fe64bb9db50f6024e0d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2203,7 +2203,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager)
+                          bool *mr_has_discard_manager, Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2221,7 +2221,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
     mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
                                  &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
-        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
+        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
         return false;
     } else if (memory_region_has_ram_discard_manager(mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
@@ -2240,8 +2240,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
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
@@ -2252,7 +2252,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
      * check that it did not truncate too much.
      */
     if (len & iotlb->addr_mask) {
-        error_report("iommu has granularity incompatible with target AS");
+        error_setg(errp, "iommu has granularity incompatible with target AS");
         return false;
     }
 
-- 
2.43.2


