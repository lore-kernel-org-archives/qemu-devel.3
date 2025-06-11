Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1129FC71131
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2p-0005S9-Ro; Wed, 11 Jun 2025 11:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2m-0005H9-Hb
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2k-00079l-8u
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Mncl3eIe35qDtefYpoRq5zfuIlzvDpPbzDgAjgPdLc=;
 b=QFcF+PVqmK+ZymRLo1IMrN77IFdvij2ZWzG43YgmQVh8qg4UJIdrHmm4laoH2SI8pn/Tth
 vGvh2D2jfzbCzMdWLw6WoUqLUDhuwCC2SXFY7eCYfQ4JxEOq5kaJCu4fncMz2SeGqTsIaw
 0kZyyGoDHpE/IPZ89bpdn8g3qw7P9tI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-BoZ7ku3CNISfbKCe2NM4_g-1; Wed,
 11 Jun 2025 11:07:07 -0400
X-MC-Unique: BoZ7ku3CNISfbKCe2NM4_g-1
X-Mimecast-MFC-AGG-ID: BoZ7ku3CNISfbKCe2NM4_g_1749654427
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7CDD1800282; Wed, 11 Jun 2025 15:07:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 528CC180045C; Wed, 11 Jun 2025 15:07:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/27] vfio/container: recover from unmap-all-vaddr failure
Date: Wed, 11 Jun 2025 17:06:09 +0200
Message-ID: <20250611150620.701903-18-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

If there are multiple containers and unmap-all fails for some container, we
need to remap vaddr for the other containers for which unmap-all succeeded.
Recover by walking all address ranges of all containers to restore the vaddr
for each.  Do so by invoking the vfio listener callback, and passing a new
"remap" flag that tells it to restore a mapping without re-allocating new
userland data structures.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-9-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  3 +
 include/hw/vfio/vfio-cpr.h            | 10 +++
 hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++
 hw/vfio/listener.c                    | 19 +++++-
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9d37f86115a873eb164ae90c5ebaf2acd2c6a5d8..f0232654eedf19c4d9c4f0ed55e79074442720c3 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -256,4 +256,7 @@ struct VFIOIOMMUClass {
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool cpr_remap);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b83dd4275183595aa31071d99099ad746931c66a..56ede049ad68759e31d855809c5bd8493dc09176 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -10,6 +10,7 @@
 #define HW_VFIO_VFIO_CPR_H
 
 #include "migration/misc.h"
+#include "system/memory.h"
 
 struct VFIOContainer;
 struct VFIOContainerBase;
@@ -17,6 +18,9 @@ struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    bool vaddr_unmapped;
+    NotifierWithReturn transfer_notifier;
+    MemoryListener remap_listener;
     int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
                          hwaddr iova, ram_addr_t size,
                          void *vaddr, bool readonly, MemoryRegion *mr);
@@ -42,4 +46,10 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int fd);
 
+void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section);
+
+bool vfio_cpr_ram_discard_register_listener(
+    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2fd8348c7cd37964af87ef04e32ce3dcd2bfde1a..a84c3247b7172a1f084659f2418d0c1e1394becf 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -29,6 +29,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->cpr.vaddr_unmapped = true;
     return true;
 }
 
@@ -59,6 +60,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+static void vfio_region_remap(MemoryListener *listener,
+                              MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer,
+                                            cpr.remap_listener);
+    vfio_container_region_add(&container->bcontainer, section, true);
+}
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -120,6 +129,40 @@ static const VMStateDescription vfio_container_vmstate = {
     }
 };
 
+static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    VFIOContainer *container =
+        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
+        return 0;
+    }
+
+    if (container->cpr.vaddr_unmapped) {
+        /*
+         * Force a call to vfio_region_remap for each mapped section by
+         * temporarily registering a listener, and temporarily diverting
+         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
+         */
+
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+
+        container->cpr.remap_listener = (MemoryListener) {
+            .name = "vfio cpr recover",
+            .region_add = vfio_region_remap
+        };
+        memory_listener_register(&container->cpr.remap_listener,
+                                 bcontainer->space->as);
+        memory_listener_unregister(&container->cpr.remap_listener);
+        container->cpr.vaddr_unmapped = false;
+        vioc->dma_map = container->cpr.saved_dma_map;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -142,6 +185,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
         container->cpr.saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
+
+    migration_add_notifier_mode(&container->cpr.transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -152,6 +199,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migration_remove_notifier(&container->cpr.transfer_notifier);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a giommu.
+ *
+ * The giommu already exists.  Find it and replay it, which calls
+ * vfio_legacy_cpr_dma_map further down the stack.
+ */
+void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section)
+{
+    VFIOGuestIOMMU *giommu = NULL;
+    hwaddr as_offset = section->offset_within_address_space;
+    hwaddr iommu_offset = as_offset - section->offset_within_region;
+
+    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
+        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
+            giommu->iommu_offset == iommu_offset) {
+            break;
+        }
+    }
+    g_assert(giommu);
+    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a RamDiscardManager.
+ *
+ * The ram discard listener already exists.  Call its populate function
+ * directly, which calls vfio_legacy_cpr_dma_map.
+ */
+bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
+
+    g_assert(vrdl);
+    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
 }
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 735b5f21b7b87cff6b5e757f9696d9a7c1c44fbf..f498e23a93747cb1826726f7c4ca28f8128b4ced 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -481,6 +481,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    vfio_container_region_add(bcontainer, section, false);
+}
+
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section,
+                               bool cpr_remap)
+{
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -516,6 +523,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
+
+        if (cpr_remap) {
+            vfio_cpr_giommu_remap(bcontainer, section);
+        }
+
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
          * avoid bouncing all map/unmaps through qemu this way, this
@@ -558,7 +570,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_ram_discard_register_listener(bcontainer, section);
+        if (!cpr_remap) {
+            vfio_ram_discard_register_listener(bcontainer, section);
+        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
+                                                           section)) {
+            goto fail;
+        }
         return;
     }
 
-- 
2.49.0


