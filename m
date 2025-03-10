Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C62DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYNE-0006UK-BB; Mon, 10 Mar 2025 04:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYNC-0006Ty-H4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:30 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYNA-0004PV-3Z
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741594828; x=1773130828;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jc+MM1PaxuEIdOSl04LSzW2Hm+iS2U1LUcyIKZi7jKI=;
 b=J/Iy8jWbAOTzqK1/D50GHBaa+kgm9DawhCq95Zl5O4q6OiKUt4z8jes+
 rI7Kk33I2luvTdQ9v1dl8PUm8GJkt9yLs/+qErVCbb2RQ8wE3akJKRL1G
 h/541Wp4bLvc5Y/CuoLkMSx9bqF7OB5vSSvMQ0lMFpxN2RKU5YHe389ba
 oJ99vHldIqaEgHf9Wi4Skk6j25LpSOi28HaRzZ71yTY2/Wu41EUaN1jAK
 y1r1+1L9jXvCqW8kw0FqHj/BmR+zZSB5rlsaMHmbYX3CIhmecZIN0+fDP
 qCFJqUxV25+BvqljQHQK6ZGRLMBGlHS7ha4jBWrpDLrGP5+e2BDcIcXYr w==;
X-CSE-ConnectionGUID: w1OwNfL2Q8+MhBgmGmJ88Q==
X-CSE-MsgGUID: dKu5nZnwTCuTvYVvrjthVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42688464"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="42688464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:26 -0700
X-CSE-ConnectionGUID: rFbQ405CSFuduoZ3ISdGHw==
X-CSE-MsgGUID: obLDyxTXS4uay3UWGzWUvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="150862807"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:23 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 3/7] memory: Unify the definiton of ReplayRamPopulate() and
 ReplayRamDiscard()
Date: Mon, 10 Mar 2025 16:18:31 +0800
Message-ID: <20250310081837.13123-4-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310081837.13123-1-chenyi.qiang@intel.com>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
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
ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamStateChange() at
the same time due to their identical definitions. This unification
simplifies related structures, such as VirtIOMEMReplayData, which makes
it more cleaner and maintainable. It also paves the way for future
extension when introducing new ReplayRamDiscard() functions to return
the results.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v3:
    - Newly added.
---
 hw/virtio/virtio-mem.c | 20 ++++++++++----------
 include/exec/memory.h  | 31 ++++++++++++++++---------------
 migration/ram.c        |  5 +++--
 system/memory.c        | 12 ++++++------
 4 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index d0d3a0240f..816ae8abdd 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1733,7 +1733,7 @@ static bool virtio_mem_rdm_is_populated(const RamDiscardManager *rdm,
 }
 
 struct VirtIOMEMReplayData {
-    void *fn;
+    ReplayRamStateChange fn;
     void *opaque;
 };
 
@@ -1741,12 +1741,12 @@ static int virtio_mem_rdm_replay_populated_cb(MemoryRegionSection *s, void *arg)
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    return ((ReplayRamPopulate)data->fn)(s, data->opaque);
+    return data->fn(s, data->opaque);
 }
 
 static int virtio_mem_rdm_replay_populated(const RamDiscardManager *rdm,
                                            MemoryRegionSection *s,
-                                           ReplayRamPopulate replay_fn,
+                                           ReplayRamStateChange replay_fn,
                                            void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
@@ -1765,14 +1765,14 @@ static int virtio_mem_rdm_replay_discarded_cb(MemoryRegionSection *s,
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    ((ReplayRamDiscard)data->fn)(s, data->opaque);
+    data->fn(s, data->opaque);
     return 0;
 }
 
-static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
-                                            MemoryRegionSection *s,
-                                            ReplayRamDiscard replay_fn,
-                                            void *opaque)
+static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                           MemoryRegionSection *s,
+                                           ReplayRamStateChange replay_fn,
+                                           void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
     struct VirtIOMEMReplayData data = {
@@ -1781,8 +1781,8 @@ static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
     };
 
     g_assert(s->mr == &vmem->memdev->mr);
-    virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                          virtio_mem_rdm_replay_discarded_cb);
+    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
+                                                 virtio_mem_rdm_replay_discarded_cb);
 }
 
 static void virtio_mem_rdm_register_listener(RamDiscardManager *rdm,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 390477b588..aa67d84329 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -566,8 +566,7 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
     rdl->double_discard_supported = double_discard_supported;
 }
 
-typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void *opaque);
-typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
+typedef int (*ReplayRamStateChange)(MemoryRegionSection *section, void *opaque);
 
 /*
  * RamDiscardManagerClass:
@@ -641,36 +640,38 @@ struct RamDiscardManagerClass {
     /**
      * @replay_populated:
      *
-     * Call the #ReplayRamPopulate callback for all populated parts within the
+     * Call the #ReplayRamStateChange callback for all populated parts within the
      * #MemoryRegionSection via the #RamDiscardManager.
      *
      * In case any call fails, no further calls are made.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamPopulate callback
+     * @replay_fn: the #ReplayRamStateChange callback
      * @opaque: pointer to forward to the callback
      *
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_populated)(const RamDiscardManager *rdm,
                             MemoryRegionSection *section,
-                            ReplayRamPopulate replay_fn, void *opaque);
+                            ReplayRamStateChange replay_fn, void *opaque);
 
     /**
      * @replay_discarded:
      *
-     * Call the #ReplayRamDiscard callback for all discarded parts within the
+     * Call the #ReplayRamStateChange callback for all discarded parts within the
      * #MemoryRegionSection via the #RamDiscardManager.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscard callback
+     * @replay_fn: the #ReplayRamStateChange callback
      * @opaque: pointer to forward to the callback
+     *
+     * Returns 0 on success, or a negative error if any notification failed.
      */
-    void (*replay_discarded)(const RamDiscardManager *rdm,
-                             MemoryRegionSection *section,
-                             ReplayRamDiscard replay_fn, void *opaque);
+    int (*replay_discarded)(const RamDiscardManager *rdm,
+                            MemoryRegionSection *section,
+                            ReplayRamStateChange replay_fn, void *opaque);
 
     /**
      * @register_listener:
@@ -713,13 +714,13 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamStateChange replay_fn,
                                          void *opaque);
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque);
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamStateChange replay_fn,
+                                         void *opaque);
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
                                            RamDiscardListener *rdl,
diff --git a/migration/ram.c b/migration/ram.c
index ce28328141..053730367b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -816,8 +816,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     return ret;
 }
 
-static void dirty_bitmap_clear_section(MemoryRegionSection *section,
-                                       void *opaque)
+static int dirty_bitmap_clear_section(MemoryRegionSection *section,
+                                      void *opaque)
 {
     const hwaddr offset = section->offset_within_region;
     const hwaddr size = int128_get64(section->size);
@@ -836,6 +836,7 @@ static void dirty_bitmap_clear_section(MemoryRegionSection *section,
     }
     *cleared_bits += bitmap_count_one_with_offset(rb->bmap, start, npages);
     bitmap_clear(rb->bmap, start, npages);
+    return 0;
 }
 
 /*
diff --git a/system/memory.c b/system/memory.c
index 62d6b410f0..8622d17133 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2147,7 +2147,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamStateChange replay_fn,
                                          void *opaque)
 {
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
@@ -2156,15 +2156,15 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
     return rdmc->replay_populated(rdm, section, replay_fn, opaque);
 }
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque)
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamStateChange replay_fn,
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


