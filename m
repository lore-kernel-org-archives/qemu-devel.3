Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C8CCDB480
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YX-0004Y3-Jd; Tue, 23 Jun 2026 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YV-0004XF-KV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YO-00070w-PC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sINIeW2UHD4RjknjeKDQWmHp+p5AoJ5q9+hvtuiEzPw=;
 b=QJR71ybO/CKB/GdJ//vONZs/MX8iHlHR4ZWq37HQzK/xz5hSjAtc1UhouTUwO8HbSYheRA
 SIqThOYsIC5tf9/38FKAv8HiDiLPxkH4r4VVxY4CfKvXZ2w490Pg/D/NJqbWwmrZ8VnrGc
 1Z0auMsletdeh2+CkAHZCxnD96c/XNg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-LRFzO-T_MBGLxsEw1EkrHA-1; Tue, 23 Jun 2026 08:48:35 -0400
X-MC-Unique: LRFzO-T_MBGLxsEw1EkrHA-1
X-Mimecast-MFC-AGG-ID: LRFzO-T_MBGLxsEw1EkrHA_1782218914
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517787172b0so104014721cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218914; x=1782823714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sINIeW2UHD4RjknjeKDQWmHp+p5AoJ5q9+hvtuiEzPw=;
 b=KDynU0eLBpIAgdjwHt52Sf8xrHRjeEsY3HWGBNntKm7KfQzxFSVTw/HWJ7yvWrLIUx
 dfYU4bubKF1tQFvBrvANnQ2M79gMrIpG0VYN8HuPJXo6QV8a+03avjhI/77whVnXG/4z
 cs4qMtjvlBkOvU0vm9q1gArKCE2Ue3YDFBejk6SmUP2kDy68aFfAF3CvX4aVjeO+thd7
 EALsN1ptb+YsZg/i175iX9Jmjgt1y8YQgf9dxIrk64szdibEzlZTKqN9dInkVHcL+WqE
 Y36cX7ZM3Lw4/SIhedNH6nhpAEfFXQJsSrgxNubDa7WR9D84x36FDp5SJOtk4twWsZ7J
 f3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218914; x=1782823714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sINIeW2UHD4RjknjeKDQWmHp+p5AoJ5q9+hvtuiEzPw=;
 b=b3I2uo2hxLK2cUEi4K82cbH5OtvKZCS01qL6ZVxYFYEXGhwf+rYieYGqlvSbmc8UZv
 7xBmh22LPb8Q1vfigGfo6dzhad/gX/56ls1mniU3UNucaIgO8n/ndruY7b0sIwcuoSNd
 vx1sNuKqIO69W6sBi/JWrE2N6QTXv8lckM4ArT4HhnHVTGJ+V48xqPXXzEm4MXFFLrAM
 RdkDsDAsKePvETGs4cLLNTL/fab8dmKLppzqNe3oZaME/jBv56G8bUuIz4lCmYimAPM6
 rJo0Y/rkNFbggfqGeX9s3Qwkv6P/9z62e2XkMew76ADutubbdf+8lYAUzS4bBmGHVMtB
 sxow==
X-Gm-Message-State: AOJu0YxFKqOqbjA9DpyMLOtDihlSuLcmg4z70TuSim94cn2h8yVfXEyA
 UzrVDTbfO+LgZAlp4Q0jiaSIB/FdYlA6vC1FzS5CZjXs3Pf99hLqo/gnDwH+n2yYebnpdeFK43X
 5AzRPND2xlfMfq6vwFvv9tkVqQrUESjs63oxKy/vogNyG9D0xX57OYJs4rN7rlwDFDyL6PUmYVn
 BgN4ghYNL7qQdGxPdv7qUWh6rQpa2LrdV11OBL5A==
X-Gm-Gg: AfdE7cnx3UR2rilweU1PhW9A1WkQ0O3gcwa0IWrEzROZv2q0ad8T7Tw46uCfIABwmTu
 4VudrwsMgJrTNGQI+lj0jRHAb5IYWiqBX0Es6QziJAHIcQyLYg7fTPtvNfoKFOyOestt3Ans+Qi
 be06o1157s/AGWeTUF2wDHsBF0r5WL0ZE3ka4VQpDljvEiYE993uRnwC22cyolp50p5eS8Ap+qM
 CxVMKnrkCTiuJRfdWjxzPXLaFiIi0rO/MsdnUZ7Rav5KH7u5ODZY+35FkK4S+T5rPXFhlldTqOs
 +kVNc0PV6o9si1kvAFBDjaWx74yRVXuz4+C1IBN/AMigcTDu+216COWWS4DZwRTuMfyZN2KapIm
 jjQ==
X-Received: by 2002:a05:622a:2599:b0:517:895f:1935 with SMTP id
 d75a77b69052e-519e4a54e07mr295732791cf.13.1782218914072; 
 Tue, 23 Jun 2026 05:48:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2599:b0:517:895f:1935 with SMTP id
 d75a77b69052e-519e4a54e07mr295731991cf.13.1782218913422; 
 Tue, 23 Jun 2026 05:48:33 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PULL 10/18] system/memory: constify section arguments
Date: Tue, 23 Jun 2026 08:47:51 -0400
Message-ID: <20260623124759.125399-11-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-3-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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
index a7d5c5ed67..b2e7f4312c 100644
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
index 4606da500a..ecabe0c747 100644
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
index da55658169..b188e09a30 100644
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
index c431d89973..2d40d8baea 100644
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
index 14cca678ae..109b5d61af 100644
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
 
@@ -1149,8 +1149,8 @@ out:
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
index be149ee944..ec16550320 100644
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
index 6da24d7258..bd519f1931 100644
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
index da708a08ab..cacef504f6 100644
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
index a72924eea7..79c7e97d9a 100644
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
index 3d8c85617d..1c9ff7fda5 100644
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


