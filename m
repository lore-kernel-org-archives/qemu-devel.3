Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3AEFCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbvP-00034J-BH; Thu, 26 Feb 2026 09:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbv0-0002gU-9p
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbux-0006Jx-DY
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772114438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0nd8w74Eg1MZwcVqt9ubuzj/ONkZRtMKFKv1IXrpoA=;
 b=HvcHS7wyQzsAloq4nBY1x9LIm0fdsQZP39MMzl+Bp0835gYQXZRQ9w3Lr7DUQZSkON44+y
 Pakfx9uLxlowYfRtYd27PQ+IFWfpc2E+DgXycG0Juyv3PCNBdc9BrO3DSOF04TIBwHpwUL
 6yCq6Q2u9m8BgQirs29vWupGDGnBMpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-82LJ4GjdPg6jNFUvPy69eA-1; Thu,
 26 Feb 2026 09:00:34 -0500
X-MC-Unique: 82LJ4GjdPg6jNFUvPy69eA-1
X-Mimecast-MFC-AGG-ID: 82LJ4GjdPg6jNFUvPy69eA_1772114433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7E319560AD; Thu, 26 Feb 2026 14:00:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE9C219560B5; Thu, 26 Feb 2026 14:00:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 08/15] system/memory: constify section arguments
Date: Thu, 26 Feb 2026 14:59:53 +0100
Message-ID: <20260226140001.3622334-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The sections shouldn't be modified.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h     |  2 +-
 include/hw/vfio/vfio-cpr.h           |  2 +-
 include/system/ram-discard-manager.h | 14 +++++++-------
 hw/vfio/cpr-legacy.c                 |  4 ++--
 hw/vfio/listener.c                   | 10 +++++-----
 hw/virtio/virtio-mem.c               | 10 +++++-----
 migration/ram.c                      |  6 +++---
 system/memory_mapping.c              |  4 ++--
 system/ram-block-attributes.c        |  8 ++++----
 system/ram-discard-manager.c         | 10 +++++-----
 10 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index a7d5c5ed679..b2e7f4312c3 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -277,7 +277,7 @@ struct VFIOIOMMUClass {
 };
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainer *bcontainer, MemoryRegionSection *section);
+    VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
 void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 4606da500a7..ecabe0c747d 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -69,7 +69,7 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
 bool vfio_cpr_ram_discard_replay_populated(
-    struct VFIOContainer *bcontainer, MemoryRegionSection *section);
+    struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                              int nr, int fd);
diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
index da55658169f..b188e09a30f 100644
--- a/include/system/ram-discard-manager.h
+++ b/include/system/ram-discard-manager.h
@@ -26,9 +26,9 @@ DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
 
 typedef struct RamDiscardListener RamDiscardListener;
 typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
+                                 const MemoryRegionSection *section);
 typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
+                                 const MemoryRegionSection *section);
 
 struct RamDiscardListener {
     /*
@@ -86,7 +86,7 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
  *
  * Returns 0 on success, or a negative error if failed.
  */
-typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
+typedef int (*ReplayRamDiscardState)(const MemoryRegionSection *section,
                                      void *opaque);
 
 /*
@@ -151,7 +151,7 @@ struct RamDiscardSourceClass {
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_populated)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
+                            const MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
@@ -168,7 +168,7 @@ struct RamDiscardSourceClass {
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_discarded)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
+                            const MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
 };
 
@@ -237,7 +237,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
  * Returns 0 on success, or a negative error if any notification failed.
  */
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
@@ -255,7 +255,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
  * Returns 0 on success, or a negative error if any notification failed.
  */
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 033a546c301..cca7dd08dfc 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -226,7 +226,7 @@ void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
-static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+static int vfio_cpr_rdm_remap(const MemoryRegionSection *section, void *opaque)
 {
     RamDiscardListener *rdl = opaque;
 
@@ -242,7 +242,7 @@ static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
 bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
-                                           MemoryRegionSection *section)
+                                           const MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl =
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a93..d24780e089d 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -203,7 +203,7 @@ out:
 }
 
 static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -221,7 +221,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 }
 
 static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -465,7 +465,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 }
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainer *bcontainer, MemoryRegionSection *section)
+    VFIOContainer *bcontainer, const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = NULL;
 
@@ -1147,8 +1147,8 @@ out:
     }
 }
 
-static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
-                                             void *opaque)
+static int vfio_ram_discard_query_dirty_bitmap(const MemoryRegionSection *section,
+                                               void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index be149ee9441..ec165503205 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -262,7 +262,7 @@ static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
 typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void *arg);
 
 static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
-                                               MemoryRegionSection *s,
+                                               const MemoryRegionSection *s,
                                                void *arg,
                                                virtio_mem_section_cb cb)
 {
@@ -294,7 +294,7 @@ static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
 }
 
 static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
-                                                 MemoryRegionSection *s,
+                                                 const MemoryRegionSection *s,
                                                  void *arg,
                                                  virtio_mem_section_cb cb)
 {
@@ -1680,7 +1680,7 @@ static int virtio_mem_rds_replay_cb(MemoryRegionSection *s, void *arg)
 }
 
 static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
-                                           MemoryRegionSection *s,
+                                           const MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
@@ -1692,11 +1692,11 @@ static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
 
     g_assert(s->mr == &vmem->memdev->mr);
     return virtio_mem_for_each_plugged_section(vmem, s, &data,
-                                            virtio_mem_rds_replay_cb);
+                                               virtio_mem_rds_replay_cb);
 }
 
 static int virtio_mem_rds_replay_discarded(const RamDiscardSource *rds,
-                                           MemoryRegionSection *s,
+                                           const MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
diff --git a/migration/ram.c b/migration/ram.c
index fc7ece2c1a1..57237385300 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -860,7 +860,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     return ret;
 }
 
-static int dirty_bitmap_clear_section(MemoryRegionSection *section,
+static int dirty_bitmap_clear_section(const MemoryRegionSection *section,
                                       void *opaque)
 {
     const hwaddr offset = section->offset_within_region;
@@ -1595,7 +1595,7 @@ static inline void populate_read_range(RAMBlock *block, ram_addr_t offset,
     }
 }
 
-static inline int populate_read_section(MemoryRegionSection *section,
+static inline int populate_read_section(const MemoryRegionSection *section,
                                         void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
@@ -1670,7 +1670,7 @@ void ram_write_tracking_prepare(void)
     }
 }
 
-static inline int uffd_protect_section(MemoryRegionSection *section,
+static inline int uffd_protect_section(const MemoryRegionSection *section,
                                        void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index da708a08ab7..cacef504f68 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -196,7 +196,7 @@ typedef struct GuestPhysListener {
 } GuestPhysListener;
 
 static void guest_phys_block_add_section(GuestPhysListener *g,
-                                         MemoryRegionSection *section)
+                                         const MemoryRegionSection *section)
 {
     const hwaddr target_start = section->offset_within_address_space;
     const hwaddr target_end = target_start + int128_get64(section->size);
@@ -248,7 +248,7 @@ static void guest_phys_block_add_section(GuestPhysListener *g,
 #endif
 }
 
-static int guest_phys_ram_populate_cb(MemoryRegionSection *section,
+static int guest_phys_ram_populate_cb(const MemoryRegionSection *section,
                                       void *opaque)
 {
     GuestPhysListener *g = opaque;
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index ceb7066e6b9..e921e09f5b3 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -37,7 +37,7 @@ typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
 
 static int
 ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
-                                                MemoryRegionSection *section,
+                                                const MemoryRegionSection *section,
                                                 void *arg,
                                                 ram_block_attributes_section_cb cb)
 {
@@ -78,7 +78,7 @@ ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
 
 static int
 ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
-                                                MemoryRegionSection *section,
+                                                const MemoryRegionSection *section,
                                                 void *arg,
                                                 ram_block_attributes_section_cb cb)
 {
@@ -161,7 +161,7 @@ ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
 
 static int
 ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
-                                          MemoryRegionSection *section,
+                                          const MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
@@ -175,7 +175,7 @@ ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
 
 static int
 ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
-                                          MemoryRegionSection *section,
+                                          const MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 3d8c85617d7..1c9ff7fda58 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -28,7 +28,7 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
 }
 
 static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
+                                               const MemoryRegionSection *section,
                                                ReplayRamDiscardState replay_fn,
                                                void *opaque)
 {
@@ -39,7 +39,7 @@ static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
 }
 
 static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
+                                               const MemoryRegionSection *section,
                                                ReplayRamDiscardState replay_fn,
                                                void *opaque)
 {
@@ -74,7 +74,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 }
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
@@ -83,7 +83,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
@@ -164,7 +164,7 @@ void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm)
     }
 }
 
-static int rdm_populate_cb(MemoryRegionSection *section, void *opaque)
+static int rdm_populate_cb(const MemoryRegionSection *section, void *opaque)
 {
     RamDiscardListener *rdl = opaque;
 
-- 
2.53.0


