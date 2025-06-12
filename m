Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EFBC71148
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdIJ-00081O-Om; Thu, 12 Jun 2025 04:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdII-0007z7-Gh
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:18 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIC-0004Fi-Nd
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749716893; x=1781252893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LdiTvLQwV3NPajQBdRm+xuKF+dxYwpbIICIDW52TqYs=;
 b=ibxv7ARYeGBsicvoc41J4M06iwQttvDWUaCRvNn8o+uGTOnPx/LVAaNp
 dDrgZS0ILUHj284NcjIGS5doHKYDa6h07r0HCRqFjp5nqsNERhHhYADma
 gOmU8nDr0MOrVIQEFQPoJVhgw4hEHSwsjSykdklE89vRahTTd2iTtoytg
 Kek3sHOAVRcp2KOWrLLYHO2ma5coKxKjOCKWSyrXuNllZUy6TakB2r16z
 DtFFR5YsZul78ERGSR872GJKEILx9aL/Mm3zOoaDirVHau1lNg+M3TS0w
 BptpTPBy/a5WEeG1hyOpyik2MAClMx0Fs3t7PZPc+Z0RNsrIKBP3WDgXH Q==;
X-CSE-ConnectionGUID: wtpApKrPTXa6ST4VxiW6PA==
X-CSE-MsgGUID: hZ5NNS6vT3Cq4hg8amcoYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69453430"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="69453430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:05 -0700
X-CSE-ConnectionGUID: pfpPH5VHSyCMjItiH4/4Fw==
X-CSE-MsgGUID: I3o9yiCnSuuA9zi7OiOy+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152442030"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:01 -0700
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
Subject: [PATCH v7 2/5] memory: Change memory_region_set_ram_discard_manager()
 to return the result
Date: Thu, 12 Jun 2025 16:27:43 +0800
Message-ID: <20250612082747.51539-3-chenyi.qiang@intel.com>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v7:
    - Add Reviewed-by from Pankaj, Alexey and Xiaoyao

Changes in v6:
    - Add Reviewed-by from David.

Changes in v5:
    - Nit in commit message (return false -> -EBUSY)
    - Add set_ram_discard_manager(NULL) when ram_block_discard_range()
      fails.

Changes in v3:
    - Move set_ram_discard_manager() up to avoid a g_free()
    - Clean up set_ram_discard_manager() definition
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
index da97753e28..60983d4977 100644
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
index 306e9ff9eb..d0c186e9f6 100644
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


