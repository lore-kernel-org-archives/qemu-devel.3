Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E95CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Np-0001Qi-67; Thu, 04 Jun 2026 09:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8NR-0001MA-Ha
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8NO-0008Rc-NI
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UWN+04UBMj15nlZKWF5kruPALXdBmOnKOzox9aoPUg=;
 b=I0uvVmunyfhV7tKZJwlBlQ7Fcfyvrw47fpTgDWg7PGAHTVkfJMPppohpqgzS8vI7PU1Z4u
 dK4d7wMUh9OzBtpqkAj9PJcrBpU22qMap7SSAUJ3fimpOmSrU8bXEDk08UIOxy9vvYt4HB
 CmH/mTTgDv+4jmVMP8Wk7kX/g8uxoVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-4NHMaoLeO_2EQx76GK54oQ-1; Thu,
 04 Jun 2026 09:44:47 -0400
X-MC-Unique: 4NHMaoLeO_2EQx76GK54oQ-1
X-Mimecast-MFC-AGG-ID: 4NHMaoLeO_2EQx76GK54oQ_1780580686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6EAF1956096; Thu,  4 Jun 2026 13:44:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D0F51955BC1; Thu,  4 Jun 2026 13:44:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:49 +0400
Subject: [PATCH v5 03/12] system/memory: constify section arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=16962;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hsOVg7tfNvdNlKdVvwQtTFjqhtsx5tPExed/hVKen5Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEwupYJ9cbC8oOsNO7ZY4Axfu/K2L1+WY3rS
 BNTPe439L+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMAAKCRDa6OEJdZac
 5Q8DD/994m8iedVQiISyS/qyCX7CSHhrAfQ97UVoVDDvPVhuOo4LjcDkDzCa5vBNGzRBMjoTaDV
 EBzuyHOoLB7n4e/ckuqePeH7p3tzM4WDc00YkopyQ6/TTURuMiTcptS4z1bKc22LCpEUkcTTI2z
 DKNG6VOjwifDWqIh9T9x0NLILaiHwTlfXLIF3Fnh5h3aOGTMR5Px++uveteckg3B71v6h/e5D6P
 OFS79xYDrERPWzpvTA487+BnFHnU31ZTVdXQVwvLZxsS8tYUpyWgAuy3HvDJ2NKRsXB1O6BFuOL
 DGcKFRB8MNOQYgmrBoTBNGUGQpzCxwiLITAiQB508jqubVu3XJn81VTeBo5FcZWJ56tI+F4NOKr
 QMK7GaJNkzw34HQs8Eck+xJcW+nUeh1IS3R/i7COmpyDkEcP55N33+efxkbIuuH0y8UMp5teIWd
 Iwh05F2wAt5zdpvCVrsKUSZ7EaxJRyPAOKDRthOixabQ5f/W+1Cs76PZhvl6NUNPRayiyYx4var
 9XXds0ggy9OjLQX8yAdYVuleXGqH+lwegyd4lVal1u1dxfS/JEpTJ0b20XspNtEPDhjLFp7auv5
 i9erQfvK3uaOZ4Guk1JNdYRqR5DQ771fm3Y656saZZ2aWIzfhjGXWcvKUgEpWEL1GAY80kVJYVI
 2ghrUshzeOO7CSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The sections shouldn't be modified.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index c431d899731..2d40d8baeaf 100644
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
index 0b72a2cf5e5..fbff1344448 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -201,7 +201,7 @@ out:
 }
 
 static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -219,7 +219,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 }
 
 static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -461,7 +461,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 }
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainer *bcontainer, MemoryRegionSection *section)
+    VFIOContainer *bcontainer, const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl;
 
@@ -1143,8 +1143,8 @@ out:
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
index fc38ffbf8af..b2c7ec43b6a 100644
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
@@ -1588,7 +1588,7 @@ static inline void populate_read_range(RAMBlock *block, ram_addr_t offset,
     }
 }
 
-static inline int populate_read_section(MemoryRegionSection *section,
+static inline int populate_read_section(const MemoryRegionSection *section,
                                         void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
@@ -1663,7 +1663,7 @@ void ram_write_tracking_prepare(void)
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
index a72924eea7d..79c7e97d9a1 100644
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
2.54.0


