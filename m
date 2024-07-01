Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D316C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCkm-0003qv-UF; Mon, 01 Jul 2024 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCk9-0003kX-N9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCk7-0005Wf-4v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719823834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYwSSrAed8SWiVoQkRzuCKcEV+Z9zcietsZ/7R8nwAA=;
 b=gyypOrkH5Y4vynX+XySY7uP72uSJ/7iXUlMSCPaMOX9fMeGqjV2/uw7PXYNsiZQxAuUj8H
 y3F09kMmbJi9glEsktoVlYyOKp9YVgaTBmrqhXC1ihUTKOUWyGLuM8YMIcSmpdAd0r3/sq
 d6gNkFMFxGfySE0DZKXf6E2xG0DBnfI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-uno9Db-KMLOdFYetkAD2bA-1; Mon,
 01 Jul 2024 04:50:31 -0400
X-MC-Unique: uno9Db-KMLOdFYetkAD2bA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25FC1944D24; Mon,  1 Jul 2024 08:50:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.9.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0FE1956089; Mon,  1 Jul 2024 08:50:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH v2 6/7] memory: remove IOMMU MR iommu_set_page_size_mask()
 callback
Date: Mon,  1 Jul 2024 10:48:58 +0200
Message-ID: <20240701084957.1567641-7-eric.auger@redhat.com>
In-Reply-To: <20240701084957.1567641-1-eric.auger@redhat.com>
References: <20240701084957.1567641-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Everything is now in place to use the Host IOMMU Device callbacks
to retrieve the page size mask usable with a given assigned device.
This new method brings the advantage to pass the info much earlier
to the virtual IOMMU and before the IOMMU MR gets enabled. So let's
remove the call to memory_region_iommu_set_page_size_mask in
vfio common.c and remove the single implementation of the IOMMU MR
callback in the virtio-iommu.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/exec/memory.h    | 38 ---------------------------------
 hw/vfio/common.c         |  8 -------
 hw/virtio/virtio-iommu.c | 45 ----------------------------------------
 system/memory.c          | 13 ------------
 hw/virtio/trace-events   |  1 -
 5 files changed, 105 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0903513d13..6f9c78cc14 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -504,32 +504,6 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
-
-    /**
-     * @iommu_set_page_size_mask:
-     *
-     * Restrict the page size mask that can be supported with a given IOMMU
-     * memory region. Used for example to propagate host physical IOMMU page
-     * size mask limitations to the virtual IOMMU.
-     *
-     * Optional method: if this method is not provided, then the default global
-     * page mask is used.
-     *
-     * @iommu: the IOMMUMemoryRegion
-     *
-     * @page_size_mask: a bitmask of supported page sizes. At least one bit,
-     * representing the smallest page size, must be set. Additional set bits
-     * represent supported block sizes. For example a host physical IOMMU that
-     * uses page tables with a page size of 4kB, and supports 2MB and 4GB
-     * blocks, will set mask 0x40201000. A granule of 4kB with indiscriminate
-     * block sizes is specified with mask 0xfffffffffffff000.
-     *
-     * Returns 0 on success, or a negative error. In case of failure, the error
-     * object must be created.
-     */
-     int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
-                                     uint64_t page_size_mask,
-                                     Error **errp);
 };
 
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1919,18 +1893,6 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
 
-/**
- * memory_region_iommu_set_page_size_mask: set the supported page
- * sizes for a given IOMMU memory region
- *
- * @iommu_mr: IOMMU memory region
- * @page_size_mask: supported page size mask
- * @errp: pointer to Error*, to store an error if it happens.
- */
-int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
-                                           uint64_t page_size_mask,
-                                           Error **errp);
-
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7cdb969fd3..6d15b36e0b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -622,14 +622,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             int128_get64(llend),
                             iommu_idx);
 
-        ret = memory_region_iommu_set_page_size_mask(giommu->iommu_mr,
-                                                     bcontainer->pgsizes,
-                                                     &err);
-        if (ret) {
-            g_free(giommu);
-            goto fail;
-        }
-
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7d5db554af..dc337a6805 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1365,50 +1365,6 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
     return 0;
 }
 
-/*
- * The default mask depends on the "granule" property. For example, with
- * 4k granule, it is -(4 * KiB). When an assigned device has page size
- * restrictions due to the hardware IOMMU configuration, apply this restriction
- * to the mask.
- */
-static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
-                                           uint64_t new_mask,
-                                           Error **errp)
-{
-    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
-    VirtIOIOMMU *s = sdev->viommu;
-    uint64_t cur_mask = s->config.page_size_mask;
-
-    trace_virtio_iommu_set_page_size_mask(mr->parent_obj.name, cur_mask,
-                                          new_mask);
-
-    if ((cur_mask & new_mask) == 0) {
-        error_setg(errp, "virtio-iommu %s reports a page size mask 0x%"PRIx64
-                   " incompatible with currently supported mask 0x%"PRIx64,
-                   mr->parent_obj.name, new_mask, cur_mask);
-        return -1;
-    }
-
-    /*
-     * Once the granule is frozen we can't change the mask anymore. If by
-     * chance the hotplugged device supports the same granule, we can still
-     * accept it.
-     */
-    if (s->granule_frozen) {
-        int cur_granule = ctz64(cur_mask);
-
-        if (!(BIT_ULL(cur_granule) & new_mask)) {
-            error_setg(errp, "virtio-iommu %s does not support frozen granule 0x%llx",
-                       mr->parent_obj.name, BIT_ULL(cur_granule));
-            return -1;
-        }
-        return 0;
-    }
-
-    s->config.page_size_mask &= new_mask;
-    return 0;
-}
-
 static void virtio_iommu_system_reset(void *opaque)
 {
     VirtIOIOMMU *s = opaque;
@@ -1733,7 +1689,6 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
-    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/system/memory.c b/system/memory.c
index 2d69521360..5e6eb459d5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1901,19 +1901,6 @@ static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
-int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
-                                           uint64_t page_size_mask,
-                                           Error **errp)
-{
-    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
-    int ret = 0;
-
-    if (imrc->iommu_set_page_size_mask) {
-        ret = imrc->iommu_set_page_size_mask(iommu_mr, page_size_mask, errp);
-    }
-    return ret;
-}
-
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 599d855ff6..b7c04f0856 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -131,7 +131,6 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
-virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "mr=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
 virtio_iommu_update_page_size_mask(const char *name, uint64_t old, uint64_t new) "host iommu device=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
-- 
2.41.0


