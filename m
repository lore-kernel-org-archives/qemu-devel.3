Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89299C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mu-0005Ir-NF; Tue, 09 Jul 2024 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mp-0004zp-Sj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mj-0006KR-V7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKWkfLMyQ04RD2tDwr2ACGPMJyvQEaNn3WNUD/2GBjs=;
 b=e/uJt2JqbutG4hf7jdRCBWdYkeXv7VlELrV6qPgVaM/XJfHVaNSN8yv4W3iEeo9J+8C21w
 PgDrjg8fVv6yNogxm1HxgRyww9ZPiU475gA/zJCeSVjQpmgLrWjmXIZIlpNbBxzxWCY31R
 bzMAtmmOxqarx9GrS3H0wl/cd/1hcDk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-agQO9kqHMoqDocL0uEmT8A-1; Tue,
 09 Jul 2024 07:50:35 -0400
X-MC-Unique: agQO9kqHMoqDocL0uEmT8A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06B521955F41; Tue,  9 Jul 2024 11:50:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DB0D3000184; Tue,  9 Jul 2024 11:50:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 6/9] memory: remove IOMMU MR iommu_set_page_size_mask() callback
Date: Tue,  9 Jul 2024 13:50:14 +0200
Message-ID: <20240709115017.798043-7-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: Eric Auger <eric.auger@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h    | 38 ---------------------------------
 hw/vfio/common.c         |  8 -------
 hw/virtio/virtio-iommu.c | 45 ----------------------------------------
 system/memory.c          | 13 ------------
 hw/virtio/trace-events   |  1 -
 5 files changed, 105 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index c26ede33d21e82beba7de82892b23dd96ab9ae70..02f7528ec0608218d35a2a12f32b66da26c4765c 100644
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
index 7cdb969fd396ae3815cb175ad631d93d7cca7006..6d15b36e0bbbdaeb9437725167e61fdf5502555a 100644
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
index d6654985bd6ed56936289833983e6c1e20a5d9e7..76f34ea6b32f06c73fda51b19db83122812b86dc 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1408,50 +1408,6 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
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
@@ -1776,7 +1732,6 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
-    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/system/memory.c b/system/memory.c
index 2d6952136066da696aca911bba530ddc472e5d70..5e6eb459d5de064f8fc2f993c0a0c0a53f88b12c 100644
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
index 599d855ff6eeb1439ab51bed4d247cb4fc4998ce..b7c04f0856b185e037ccd53726a2d8722b6adc84 100644
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
2.45.2


