Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A688C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKDk-0004cB-Fd; Tue, 20 May 2025 06:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDi-0004c1-Cd
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:14 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDg-0004eb-9t
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736953; x=1779272953;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R5LFT5AsG3wsPZY3KRrUkPR61WLL1e67GZCvt4H8Tkk=;
 b=F3uvGEXuxMuoHjpfFyoXqqGlSUzPXG/eEl1xqeAshgc+oQwegWHa1Kjk
 7Djj5Q4ptqO+tAH+IfXCAOTF/JjwJuljFQENcwgIqxYZISyLeEHK8fI0r
 o4tlspkTrqiPBST7ZY58DBqku21UoM2jjYW+FYH35Pk/8MH9xesebck56
 LZlPHOgBs2g+ch2MYndZTlIOFU2BxYF/PhILzxib7Xukh9zkfulYY10SV
 ilTPPRNf51l1WABos08+oB1d9IS/l+sOZCynP27BhfWMihj9fkNXSHTQ8
 dUVGkvClS5pGmkJDd78kGTFuuxjSLM56zY/MdHQEtf1L089zca9zLyvog A==;
X-CSE-ConnectionGUID: i8tApbm8Tym7tXA0Do2Z1g==
X-CSE-MsgGUID: MSSGhU8nR6OQ9fOlyfbmwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566638"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566638"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:12 -0700
X-CSE-ConnectionGUID: K0NXmz3yQGqZNd/LaV/iJA==
X-CSE-MsgGUID: YnzgoaVORCePeeTjE9lLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905230"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:07 -0700
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
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v5 02/10] memory: Change
 memory_region_set_ram_discard_manager() to return the result
Date: Tue, 20 May 2025 18:28:42 +0800
Message-ID: <20250520102856.132417-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250520102856.132417-1-chenyi.qiang@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Modify memory_region_set_ram_discard_manager() to return -EBUSY if a
RamDiscardManager is already set in the MemoryRegion. The caller must
handle this failure, such as having virtio-mem undo its actions and fail
the realize() process. Opportunistically move the call earlier to avoid
complex error handling.

This change is beneficial when introducing a new RamDiscardManager
instance besides virtio-mem. After
ram_block_coordinated_discard_require(true) unlocks all
RamDiscardManager instances, only one instance is allowed to be set for
one MemoryRegion at present.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v5:
    - Nit in commit message (return false -> -EBUSY)
    - Add set_ram_discard_manager(NULL) when ram_block_discard_range()
      fails.

Changes in v4:
    - No change.

Changes in v3:
    - Move set_ram_discard_manager() up to avoid a g_free()
    - Clean up set_ram_discard_manager() definition

Changes in v2:
    - newly added.
---
 hw/virtio/virtio-mem.c  | 30 +++++++++++++++++-------------
 include/system/memory.h |  6 +++---
 system/memory.c         | 10 +++++++---
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b3c126ea1e..2e491e8c44 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1047,6 +1047,17 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * Set ourselves as RamDiscardManager before the plug handler maps the
+     * memory region and exposes it via an address space.
+     */
+    if (memory_region_set_ram_discard_manager(&vmem->memdev->mr,
+                                              RAM_DISCARD_MANAGER(vmem))) {
+        error_setg(errp, "Failed to set RamDiscardManager");
+        ram_block_coordinated_discard_require(false);
+        return;
+    }
+
     /*
      * We don't know at this point whether shared RAM is migrated using
      * QEMU or migrated using the file content. "x-ignore-shared" will be
@@ -1061,6 +1072,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
         if (ret) {
             error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
+            memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
             ram_block_coordinated_discard_require(false);
             return;
         }
@@ -1122,13 +1134,6 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
     vmem->system_reset->vmem = vmem;
     qemu_register_resettable(obj);
-
-    /*
-     * Set ourselves as RamDiscardManager before the plug handler maps the
-     * memory region and exposes it via an address space.
-     */
-    memory_region_set_ram_discard_manager(&vmem->memdev->mr,
-                                          RAM_DISCARD_MANAGER(vmem));
 }
 
 static void virtio_mem_device_unrealize(DeviceState *dev)
@@ -1136,12 +1141,6 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
 
-    /*
-     * The unplug handler unmapped the memory region, it cannot be
-     * found via an address space anymore. Unset ourselves.
-     */
-    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
-
     qemu_unregister_resettable(OBJECT(vmem->system_reset));
     object_unref(OBJECT(vmem->system_reset));
 
@@ -1154,6 +1153,11 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
     g_free(vmem->bitmap);
+    /*
+     * The unplug handler unmapped the memory region, it cannot be
+     * found via an address space anymore. Unset ourselves.
+     */
+    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
     ram_block_coordinated_discard_require(false);
 }
 
diff --git a/include/system/memory.h b/include/system/memory.h
index b961c4076a..896948deb1 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2499,13 +2499,13 @@ static inline bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
  *
  * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
  * that does not cover RAM, or a #MemoryRegion that already has a
- * #RamDiscardManager assigned.
+ * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
  *
  * @mr: the #MemoryRegion
  * @rdm: #RamDiscardManager to set
  */
-void memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                           RamDiscardManager *rdm);
+int memory_region_set_ram_discard_manager(MemoryRegion *mr,
+                                          RamDiscardManager *rdm);
 
 /**
  * memory_region_find: translate an address/size relative to a
diff --git a/system/memory.c b/system/memory.c
index 63b983efcd..b45b508dce 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2106,12 +2106,16 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
     return mr->rdm;
 }
 
-void memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                           RamDiscardManager *rdm)
+int memory_region_set_ram_discard_manager(MemoryRegion *mr,
+                                          RamDiscardManager *rdm)
 {
     g_assert(memory_region_is_ram(mr));
-    g_assert(!rdm || !mr->rdm);
+    if (mr->rdm && rdm) {
+        return -EBUSY;
+    }
+
     mr->rdm = rdm;
+    return 0;
 }
 
 uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
-- 
2.43.5


