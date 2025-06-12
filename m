Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC0EC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdIO-00086c-4h; Thu, 12 Jun 2025 04:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIJ-0007zr-1T
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:19 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIG-0004FP-Qp
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749716897; x=1781252897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IoDfVvR6sOQKPtD7NymR46Bpd3lDqmDVR2c529+KaPQ=;
 b=iScjMdZnPz1jcbmpfxh47T+ApnM15FnHpwKhIwZ7OnzhGZslMAjJj7sk
 oqSN5YSad0ZfwbdyWSHG3UKoyzvavLeCeYUqcL7zW9qF+fF3Z9ZjNDpNs
 zi7aOnNnZ/Bet5rjMQelr80kPiMyTLgIW1mhRN/pN+jjFBdvnWH5uoiFk
 HysafEQgpcvkE5ZbdopM1GYsPSo4cm5Hsaf3nu8Zzk+/5xR81ix1APNid
 DSWEKogmj91iEMKoyqWC1AQAhEKLYn28XUnm2gnoHaxgH3rtvl+2Ndm/j
 6P7GJZad9cNUQubja9aJRyueovj9RbCU3XHZzcMcqfzfuLSKcxN8RMNjm g==;
X-CSE-ConnectionGUID: tiPsQvMYS8aScLrBUKTRGg==
X-CSE-MsgGUID: eAKeem/pScOZtZHBtYNjpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69453444"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="69453444"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:10 -0700
X-CSE-ConnectionGUID: DiI5kDGUQzyaj1BObYm3GA==
X-CSE-MsgGUID: 2lPuQWzSQNiOrb/Uvrf9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152442037"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:05 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v7 3/5] memory: Unify the definiton of ReplayRamPopulate() and
 ReplayRamDiscard()
Date: Thu, 12 Jun 2025 16:27:44 +0800
Message-ID: <20250612082747.51539-4-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250612082747.51539-1-chenyi.qiang@intel.com>
References: <20250612082747.51539-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Update ReplayRamDiscard() function to return the result and unify the
ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamDiscardState() at
the same time due to their identical definitions. This unification
simplifies related structures, such as VirtIOMEMReplayData, which makes
it cleaner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v7:
    - Add Reviewed-by from Xiaoyao and Pankaj.

Changes in v6:
    - Add Reviewed-by from David
    - Add a documentation comment for the prototype change

Changes in v5:
    - Rename ReplayRamStateChange to ReplayRamDiscardState (David)
    - return data->fn(s, data->opaque) instead of 0 in
      virtio_mem_rdm_replay_discarded_cb(). (Alexey)

Changes in v4:
    - Modify the commit message. We won't use Replay() operation when
      doing the attribute change like v3.
---
 hw/virtio/virtio-mem.c  | 21 +++++++-------
 include/system/memory.h | 64 ++++++++++++++++++++++++++++++-----------
 migration/ram.c         |  5 ++--
 system/memory.c         | 12 ++++----
 4 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 2e491e8c44..c46f6f9c3e 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1732,7 +1732,7 @@ static bool virtio_mem_rdm_is_populated(const RamDiscardManager *rdm,
 }
 
 struct VirtIOMEMReplayData {
-    void *fn;
+    ReplayRamDiscardState fn;
     void *opaque;
 };
 
@@ -1740,12 +1740,12 @@ static int virtio_mem_rdm_replay_populated_cb(MemoryRegionSection *s, void *arg)
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    return ((ReplayRamPopulate)data->fn)(s, data->opaque);
+    return data->fn(s, data->opaque);
 }
 
 static int virtio_mem_rdm_replay_populated(const RamDiscardManager *rdm,
                                            MemoryRegionSection *s,
-                                           ReplayRamPopulate replay_fn,
+                                           ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
@@ -1764,14 +1764,13 @@ static int virtio_mem_rdm_replay_discarded_cb(MemoryRegionSection *s,
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    ((ReplayRamDiscard)data->fn)(s, data->opaque);
-    return 0;
+    return data->fn(s, data->opaque);
 }
 
-static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
-                                            MemoryRegionSection *s,
-                                            ReplayRamDiscard replay_fn,
-                                            void *opaque)
+static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                           MemoryRegionSection *s,
+                                           ReplayRamDiscardState replay_fn,
+                                           void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
     struct VirtIOMEMReplayData data = {
@@ -1780,8 +1779,8 @@ static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
     };
 
     g_assert(s->mr == &vmem->memdev->mr);
-    virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                          virtio_mem_rdm_replay_discarded_cb);
+    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
+                                                 virtio_mem_rdm_replay_discarded_cb);
 }
 
 static void virtio_mem_rdm_register_listener(RamDiscardManager *rdm,
diff --git a/include/system/memory.h b/include/system/memory.h
index 60983d4977..eb2618e1b4 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -576,8 +576,20 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
     rdl->double_discard_supported = double_discard_supported;
 }
 
-typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void *opaque);
-typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
+/**
+ * ReplayRamDiscardState:
+ *
+ * The callback handler for #RamDiscardManagerClass.replay_populated/
+ * #RamDiscardManagerClass.replay_discarded to invoke on populated/discarded
+ * parts.
+ *
+ * @section: the #MemoryRegionSection of populated/discarded part
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if failed.
+ */
+typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
+                                     void *opaque);
 
 /*
  * RamDiscardManagerClass:
@@ -651,36 +663,38 @@ struct RamDiscardManagerClass {
     /**
      * @replay_populated:
      *
-     * Call the #ReplayRamPopulate callback for all populated parts within the
-     * #MemoryRegionSection via the #RamDiscardManager.
+     * Call the #ReplayRamDiscardState callback for all populated parts within
+     * the #MemoryRegionSection via the #RamDiscardManager.
      *
      * In case any call fails, no further calls are made.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamPopulate callback
+     * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
      *
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_populated)(const RamDiscardManager *rdm,
                             MemoryRegionSection *section,
-                            ReplayRamPopulate replay_fn, void *opaque);
+                            ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
      * @replay_discarded:
      *
-     * Call the #ReplayRamDiscard callback for all discarded parts within the
-     * #MemoryRegionSection via the #RamDiscardManager.
+     * Call the #ReplayRamDiscardState callback for all discarded parts within
+     * the #MemoryRegionSection via the #RamDiscardManager.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscard callback
+     * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
+     *
+     * Returns 0 on success, or a negative error if any notification failed.
      */
-    void (*replay_discarded)(const RamDiscardManager *rdm,
-                             MemoryRegionSection *section,
-                             ReplayRamDiscard replay_fn, void *opaque);
+    int (*replay_discarded)(const RamDiscardManager *rdm,
+                            MemoryRegionSection *section,
+                            ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
      * @register_listener:
@@ -721,15 +735,31 @@ uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
 bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
                                       const MemoryRegionSection *section);
 
+/**
+ * ram_discard_manager_replay_populated:
+ *
+ * A wrapper to call the #RamDiscardManagerClass.replay_populated callback
+ * of the #RamDiscardManager.
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque);
+/**
+ * ram_discard_manager_replay_discarded:
+ *
+ * A wrapper to call the #RamDiscardManagerClass.replay_discarded callback
+ * of the #RamDiscardManager.
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque);
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
                                            RamDiscardListener *rdl,
diff --git a/migration/ram.c b/migration/ram.c
index d26dbd37c4..2d4af497b5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -848,8 +848,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     return ret;
 }
 
-static void dirty_bitmap_clear_section(MemoryRegionSection *section,
-                                       void *opaque)
+static int dirty_bitmap_clear_section(MemoryRegionSection *section,
+                                      void *opaque)
 {
     const hwaddr offset = section->offset_within_region;
     const hwaddr size = int128_get64(section->size);
@@ -868,6 +868,7 @@ static void dirty_bitmap_clear_section(MemoryRegionSection *section,
     }
     *cleared_bits += bitmap_count_one_with_offset(rb->bmap, start, npages);
     bitmap_clear(rb->bmap, start, npages);
+    return 0;
 }
 
 /*
diff --git a/system/memory.c b/system/memory.c
index d0c186e9f6..76b44b8220 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2138,7 +2138,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
@@ -2147,15 +2147,15 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
     return rdmc->replay_populated(rdm, section, replay_fn, opaque);
 }
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque)
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque)
 {
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
 
     g_assert(rdmc->replay_discarded);
-    rdmc->replay_discarded(rdm, section, replay_fn, opaque);
+    return rdmc->replay_discarded(rdm, section, replay_fn, opaque);
 }
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
-- 
2.43.5


