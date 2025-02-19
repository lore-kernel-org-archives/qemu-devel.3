Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD04C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoMj-0000uW-M5; Wed, 19 Feb 2025 13:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMh-0000st-Jb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkoMf-0002Fn-Ht
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739988004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izbuYHWAlPY/ZjmWAGQ+rCOPojIoAsrGnvob1x2IkTU=;
 b=bdi2f39A3qCeKVcso2MLwKPQOS9MePCcc5U2/K1GX+wIrx9ngrdMPPmODfvjRnKgqt2Vd8
 31GyDRx0yOwkesD/A4EGPoeO3o1ft0d4ZLs3JzLDWm9Ztib1wm0jrVR5urTmiGvTz3N5SY
 b34/qKx1ncHGE9qAOYfI9B7qdHzUsNk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-gpf29jlGPvi8t2NG_gmTkQ-1; Wed,
 19 Feb 2025 13:00:00 -0500
X-MC-Unique: gpf29jlGPvi8t2NG_gmTkQ-1
X-Mimecast-MFC-AGG-ID: gpf29jlGPvi8t2NG_gmTkQ_1739988000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA8F31800879; Wed, 19 Feb 2025 17:59:59 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8209F1800940; Wed, 19 Feb 2025 17:59:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com
Subject: [RFC 2/2] hw/vfio/pci: Prevents BARs from being dma mapped in d3hot
 state
Date: Wed, 19 Feb 2025 18:59:00 +0100
Message-ID: <20250219175941.135390-3-eric.auger@redhat.com>
In-Reply-To: <20250219175941.135390-1-eric.auger@redhat.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since kernel commit:
2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
in D3hot power state")
any attempt to do an mmap access to a BAR when the device is in d3hot
state will generate a fault.

On system_powerdown, if the VFIO device is translated by an IOMMU,
the device is moved to D3hot state and then the vIOMMU gets disabled
by the guest. As a result of this later operation, the address space is
swapped from translated to untranslated. When re-enabling the aliased
regions, the RAM regions are dma-mapped again and this causes DMA_MAP
faults when attempting the operation on BARs.

To avoid doing the remap on those BARs, we need to retrieve the
information whether the device is in a non compatible state.

Implement the vfio_is_dma_map_allowed() callback for PCI devices.
If the device is in D3hot state, skip the DMA MAP in vfio_listener_add().

To ease the implementation, vfio_section_is_vfio_pci now returns
a VFIOPCIDevice pointer and the function is moved before the first
caller.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c     | 57 +++++++++++++++++++++++++++-----------------
 hw/vfio/pci.c        | 22 +++++++++++++++++
 hw/vfio/trace-events |  1 +
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 173fb3a997..96f401f10a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -555,11 +555,34 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static VFIOPCIDevice *vfio_section_is_vfio_pci(MemoryRegionSection *section,
+                                     VFIOContainerBase *bcontainer)
+{
+    VFIOPCIDevice *pcidev;
+    VFIODevice *vbasedev;
+    Object *owner;
+
+    owner = memory_region_owner(section->mr);
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+            continue;
+        }
+        pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+        if (OBJECT(pcidev) == owner) {
+            return pcidev;
+        }
+    }
+
+    return NULL;
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    VFIOPCIDevice *vdev;
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -630,6 +653,18 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
     /* Here we assume that memory_region_is_ram(section->mr)==true */
 
+    /* skip if the region is a BAR and the power state forbids DMA MAP */
+    vdev = vfio_section_is_vfio_pci(section, bcontainer);
+    if (vdev) {
+        VFIODevice *vbasedev = &vdev->vbasedev;
+        assert(vbasedev->ops->vfio_is_dma_map_allowed);
+        if (!vbasedev->ops->vfio_is_dma_map_allowed(vbasedev)) {
+            trace_vfio_listener_region_add_skip(section->mr->name);
+            return;
+        }
+    }
+
+
     /*
      * For RAM memory regions with a RamDiscardManager, we only want to map the
      * actually populated parts - and update the mapping whenever we're notified
@@ -804,28 +839,6 @@ typedef struct VFIODirtyRangesListener {
     MemoryListener listener;
 } VFIODirtyRangesListener;
 
-static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
-                                     VFIOContainerBase *bcontainer)
-{
-    VFIOPCIDevice *pcidev;
-    VFIODevice *vbasedev;
-    Object *owner;
-
-    owner = memory_region_owner(section->mr);
-
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
-            continue;
-        }
-        pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
-        if (OBJECT(pcidev) == owner) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
 static void vfio_dirty_tracking_update_range(VFIODirtyRanges *range,
                                              hwaddr iova, hwaddr end,
                                              bool update_pci)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab17a98ee5..314dddae4a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2653,6 +2653,26 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     return ret;
 }
 
+/*
+ * BARs cannot be dma-mapped if the device is in D3hot state since
+ * linux commit 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block
+ * the access in D3hot power state")
+ */
+static bool vfio_pci_is_dma_map_allowed(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    uint16_t pmcsr;
+    uint8_t state;
+
+    pmcsr = vfio_pci_read_config(&vdev->pdev, vdev->pm_cap + PCI_PM_CTRL, 2);
+    state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+    if (state == 3) {
+        return false;
+    }
+    return true;
+}
+
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
@@ -2660,6 +2680,7 @@ static VFIODeviceOps vfio_pci_ops = {
     .vfio_get_object = vfio_pci_get_object,
     .vfio_save_config = vfio_pci_save_config,
     .vfio_load_config = vfio_pci_load_config,
+    .vfio_is_dma_map_allowed = vfio_pci_is_dma_map_allowed,
 };
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
@@ -3477,3 +3498,4 @@ static void register_vfio_pci_dev_type(void)
 }
 
 type_init(register_vfio_pci_dev_type)
+
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index c5385e1a4f..a0d5868c2f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -121,6 +121,7 @@ vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_reset_handler(void) ""
+vfio_listener_region_add_skip(const char *name) "DMA MAP would fail on region %s due to incompatible power state, skip it"
 
 # platform.c
 vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
-- 
2.47.1


