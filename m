Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41D3C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYMaV-00041e-EL; Thu, 16 Jan 2025 04:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYMaU-00041S-Ff
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:54:54 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYMaS-0005Ue-3v
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:54:54 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so1082134a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737021289; x=1737626089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3avZpWWOVNRTwHxyWxbmzY0ffixj/GdDucgBR8ohTeo=;
 b=CnYZpALrdfvrV0hByiWLL1ULVkbmHyJN0JGxPAPeCNBRhz15/6tKAY0UGvyk31ADsv
 1FFJHABmxUvCMG29HThB0sFSC3iCcZf7AgBPXmxjlbOqQyehymMNKF9t4zTPVWk2+htc
 97+C3xrRcmthvWmeT4k2OhxMCyKB4t8C7BgiAsgdTppMRvkCDoPMRmPLqZ3zDu5yfBax
 hocd6A1vdvX0ceF0EmLmFOd/RYeD795tQ3QtDtGNfPjANEaK4eq4nri2cu9CPHilvk00
 oazBdkOBta3QP4rezgqH+dpxlbACu5EsO3nv/+VBFl6YytAMpeWJojfD16EjwOGdvBoo
 fuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737021289; x=1737626089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3avZpWWOVNRTwHxyWxbmzY0ffixj/GdDucgBR8ohTeo=;
 b=rW3gROi/3VvgmDQ6yvOZfTiAlg9j7EzObch7ztfB7YVIvOo0kLNBEn7xil+rGBBB0g
 IhpXaCbXqW/rF2KCPecm9UdASEiJCm3uUtQ4lt+Ioxz36p3KMRptauKCQBMX8qBMcQbg
 zcXjn79VMlZQIUjbYJi8KW6yuCP7QZh5t2UX4u+Qr0gb0riiBB5zyekQTuZGicQkjQ+Z
 E+2gQiG0i6c9yrhVV6OGmfZRVaMXbwDMSYZu5bBmHz2CB6h+gLD/n59VlICetvz5k6q6
 imnzFVIPnbG/Vdk3E2KhReNCpqACDAHZYjctJ5Tmyg4jdffMZ/y3uUpW7J1z9LiZZXz4
 01cg==
X-Gm-Message-State: AOJu0YzX5eWllH9ST/uf0KTSUPKdHux3oUzmuf34WTo0kpFjZ/aKhyIm
 Lc1jdTVM/ArKHkV80LHXq9c3tXVsepmQJ9C2PqsP+0EOFjWVg+w0bs9fqDA+qTc=
X-Gm-Gg: ASbGncsdm43cO3sidSnkT95N2WkYHBnnI6sH6q72F9CMWMy5ts3ETjDSAjC7YkEkP4d
 XIB1A5kAjb3tdnK8FYWH4nke55WupJ9pLoTiUzKyf7uVcqJCNwZHWS2ZZ+WyNmJIgOB+4faYKXc
 9eJZVYncJD0HGw1IJT5qZC9EjSRtFHBMOI1TjWPfW86oa3Cy1ofWIRh6w4XZGB2ItYz8f349hAD
 dKetlECWjQzinH+II0zmcq5G9y52MnC7oAOnm2MAJk/A61gXPzcNokiPmfUX/s6G6MSCZE=
X-Google-Smtp-Source: AGHT+IGCFz+vyb0dznYNw47cU8mXWy6eSJWhnAi6yr56cHZdjWBS0J7kDsYwGe1bY2ig534duN0Khw==
X-Received: by 2002:a17:90b:280a:b0:2ee:d186:fe48 with SMTP id
 98e67ed59e1d1-2f548f1b5cfmr44962333a91.28.1737021289213; 
 Thu, 16 Jan 2025 01:54:49 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c151f0csm3159781a91.9.2025.01.16.01.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:54:48 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 sgarzare@redhat.com, Wencheng Yang <east.moutain.yang@gmail.com>
Subject: [PATCH] vfio: Support P2P access in confidential VM
Date: Thu, 16 Jan 2025 17:53:55 +0800
Message-ID: <20250116095355.41909-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On confidential VM platform, for example, AMD-SEV, P2P doesn't work.
The underlying reason is that IOMMU driver set encryption bit on
IOMMU page table pte entry, it's reasonalbe if the pte maps iova
to system memory. However, if the pte maps iova to device's
mmio bar space, setting encryption bit on pte would cause IOMMU
translates iova to incorrect bus address, rather than mmio bar
address.

To fix the issue, the key point is to let IOMMU driver know the
target phyical address is system memory or device mmio.

VFIO allocates virtual address and maps it to device mmio bar,
the member @ram_device of MemoryRegion indicates the memory
region is for mmio. The patch passes the info to VFIO DAM API,
IOMMU driver would do the correct thing.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 hw/vfio/common.c                      | 67 +++++++++++++++++----------
 hw/vfio/container-base.c              |  4 +-
 hw/vfio/container.c                   |  6 ++-
 hw/vfio/iommufd.c                     |  4 +-
 hw/virtio/vhost-vdpa.c                |  6 +--
 include/exec/memory.h                 |  7 ++-
 include/hw/vfio/vfio-common.h         |  4 ++
 include/hw/vfio/vfio-container-base.h |  4 +-
 linux-headers/linux/vfio.h            |  1 +
 system/memory.c                       | 11 +++--
 10 files changed, 74 insertions(+), 40 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7499a9b74..2660a42f9e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -247,31 +247,42 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only,
+                               ram_addr_t *ram_addr, uint32_t *flag,
                                Error **errp)
 {
     bool ret, mr_has_discard_manager;
+    uint32_t mr_flag = 0;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
+    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, &mr_flag,
                                &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
-        /*
-         * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
-         * pages will remain pinned inside vfio until unmapped, resulting in a
-         * higher memory consumption than expected. If memory would get
-         * populated again later, there would be an inconsistency between pages
-         * pinned by vfio and pages seen by QEMU. This is the case until
-         * unmapped from the IOMMU (e.g., during device reset).
-         *
-         * With malicious guests, we really only care about pinning more memory
-         * than expected. RLIMIT_MEMLOCK set for the user/process can never be
-         * exceeded and can be used to mitigate this problem.
-         */
-        warn_report_once("Using vfio with vIOMMUs and coordinated discarding of"
-                         " RAM (e.g., virtio-mem) works, however, malicious"
-                         " guests can trigger pinning of more memory than"
-                         " intended via an IOMMU. It's possible to mitigate "
-                         " by setting/adjusting RLIMIT_MEMLOCK.");
+    if (ret) {
+        if (flag) {
+            if (mr_flag & MRF_READONLY)
+                *flag |= VFIO_MRF_READONLY;
+
+            if (mr_flag & MRF_RAMDEV)
+                *flag |= VFIO_MRF_RAMDEV;
+        }
+
+        if (mr_has_discard_manager) {
+            /*
+             * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
+             * pages will remain pinned inside vfio until unmapped, resulting in a
+             * higher memory consumption than expected. If memory would get
+             * populated again later, there would be an inconsistency between pages
+             * pinned by vfio and pages seen by QEMU. This is the case until
+             * unmapped from the IOMMU (e.g., during device reset).
+             *
+             * With malicious guests, we really only care about pinning more memory
+             * than expected. RLIMIT_MEMLOCK set for the user/process can never be
+             * exceeded and can be used to mitigate this problem.
+             */
+            warn_report_once("Using vfio with vIOMMUs and coordinated discarding of"
+                             " RAM (e.g., virtio-mem) works, however, malicious"
+                             " guests can trigger pinning of more memory than"
+                             " intended via an IOMMU. It's possible to mitigate "
+                             " by setting/adjusting RLIMIT_MEMLOCK.");
+        }
     }
     return ret;
 }
@@ -298,9 +309,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     rcu_read_lock();
 
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
-        bool read_only;
+        uint32_t flag = 0;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &flag, &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -313,7 +324,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     flag);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -363,6 +374,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                        int128_get64(section->size);
     hwaddr start, next, iova;
     void *vaddr;
+    uint32_t flag = 0;
     int ret;
 
     /*
@@ -377,8 +389,10 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
                section->offset_within_address_space;
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
+        flag |= section->readonly? VFIO_MRF_READONLY: 0;
+        flag |= section->ram_device? VFIO_MRF_RAMDEV: 0;
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, flag);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -563,6 +577,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
+    uint32_t flag = 0;
     int ret;
     Error *err = NULL;
 
@@ -661,8 +676,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
         }
     }
 
+    flag |= section->readonly? VFIO_MRF_READONLY: 0;
+    flag |= section->ram_device? VFIO_MRF_RAMDEV: 0;
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, flag);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 749a3fd29d..7cee2ac562 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -17,12 +17,12 @@
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, uint32_t flag)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, flag);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ebb526808..90c32cd16d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -176,7 +176,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, uint32_t flag)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -188,9 +188,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
         .size = size,
     };
 
-    if (!readonly) {
+    if (!(flag & VFIO_MRF_READONLY)) {
         map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
     }
+    if (flag & VFIO_MRF_RAMDEV)
+        map.flags |= VFIO_DMA_MAP_FLAG_MMIO;
 
     /*
      * Try the mapping, if it fails with EBUSY, unmap the region and try
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f1eb..c773b45b5d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -28,14 +28,14 @@
 #include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, uint32_t flag)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
     return iommufd_backend_map_dma(container->be,
                                    container->ioas_id,
-                                   iova, size, vaddr, readonly);
+                                   iova, size, vaddr, flag & VFIO_MRF_READONLY);
 }
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..dea733ef8a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -226,15 +226,15 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
-        bool read_only;
+        uint32_t flag;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &flag, NULL,
                                   &local_err)) {
             error_report_err(local_err);
             return;
         }
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                                 iotlb->addr_mask + 1, vaddr, read_only);
+                                 iotlb->addr_mask + 1, vaddr, flag & MRF_READONLY);
         if (ret) {
             error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ", %p) = %d (%m)",
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..24405af0be 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -104,10 +104,15 @@ struct MemoryRegionSection {
     hwaddr offset_within_region;
     hwaddr offset_within_address_space;
     bool readonly;
+    bool ram_device;
     bool nonvolatile;
     bool unmergeable;
 };
 
+/* memory region flag */
+#define MRF_READONLY 0x1
+#define MRF_RAMDEV   0x2
+
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
@@ -742,7 +747,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
  * Return: true on success, else false setting @errp with error.
  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
+                          ram_addr_t *ram_addr, uint32_t *flag,
                           bool *mr_has_discard_manager, Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0c60be5b15..48018dc751 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -43,6 +43,10 @@ enum {
     VFIO_DEVICE_TYPE_AP = 3,
 };
 
+/* vfio memory region flag */
+#define VFIO_MRF_READONLY 0x1
+#define VFIO_MRF_RAMDEV   0x2
+
 typedef struct VFIOMmap {
     MemoryRegion mem;
     void *mmap;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab..bb473e7201 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, uint32_t flag);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
@@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, uint32_t flag);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 1b5e254d6a..4a32e70c33 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
diff --git a/system/memory.c b/system/memory.c
index b17b5538ff..71c54fc045 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -223,6 +223,7 @@ struct FlatRange {
     uint8_t dirty_log_mask;
     bool romd_mode;
     bool readonly;
+    bool ram_device;
     bool nonvolatile;
     bool unmergeable;
 };
@@ -240,6 +241,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)
         .size = fr->addr.size,
         .offset_within_address_space = int128_get64(fr->addr.start),
         .readonly = fr->readonly,
+        .ram_device = fr->ram_device,
         .nonvolatile = fr->nonvolatile,
         .unmergeable = fr->unmergeable,
     };
@@ -252,6 +254,7 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->offset_in_region == b->offset_in_region
         && a->romd_mode == b->romd_mode
         && a->readonly == b->readonly
+        && a->ram_device == b->ram_device
         && a->nonvolatile == b->nonvolatile
         && a->unmergeable == b->unmergeable;
 }
@@ -657,6 +660,7 @@ static void render_memory_region(FlatView *view,
     fr.dirty_log_mask = memory_region_get_dirty_log_mask(mr);
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
+    fr.ram_device = mr->ram_device;
     fr.nonvolatile = nonvolatile;
     fr.unmergeable = unmergeable;
 
@@ -2184,7 +2188,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
+                          ram_addr_t *ram_addr, uint32_t *flag,
                           bool *mr_has_discard_manager, Error **errp)
 {
     MemoryRegion *mr;
@@ -2246,8 +2250,9 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *ram_addr = memory_region_get_ram_addr(mr) + xlat;
     }
 
-    if (read_only) {
-        *read_only = !writable || mr->readonly;
+    if (flag) {
+        *flag |= (!writable || mr->readonly)? MRF_READONLY: 0;
+        *flag |= mr->ram_device? MRF_RAMDEV: 0;
     }
 
     return true;
-- 
2.43.0


