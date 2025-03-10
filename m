Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F229CC2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYNS-0006ZS-Il; Mon, 10 Mar 2025 04:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYNO-0006XU-W2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:43 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYNM-0004U2-6r
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741594840; x=1773130840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mUz3KRZzpMdb9UUDv1l5scZ1u6EFNRr/6avaaV0mfRQ=;
 b=PDmmafLzps/7y+fAeTR0RzTsuTLWzsIXoMmWT2uUpDQOIr7CflSjgTgs
 OMc6RDeJNyP3Fzo98oQQPPtHRDhGUObqMCz1lATDBgdn8/5MnCD02Ko0Q
 mgLOwny5wbAYkZqpL1O0vWlcYTKLbKHHvxk54235Q0yGLl7DSjJSWq58y
 kXD4OePdI0fMtkBI2lpYsBKzPgZEuGqVsCZN2iC7kIJ9k8OlEE/yhVSTA
 KVkF3eMpnU2Sp599lz92MuWF6uaFhvMj4YUK1MlAe9hBneJkMAia/pV9u
 wfSvQH2WLpq+9dzV3teV5zTkPBeUWM5U4scHYw1R/yl4U51xMlht5RQ1S g==;
X-CSE-ConnectionGUID: 2NskhrB/Q7y2E1HWXY7SsA==
X-CSE-MsgGUID: E/jGX4xUSKKw/g91Cv3ZYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42688519"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="42688519"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:38 -0700
X-CSE-ConnectionGUID: oa6bsM18TPihU1XUuN3n/A==
X-CSE-MsgGUID: xVbdbMIeR62RqMthfT4pbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="150862852"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:33 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 6/7] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
Date: Mon, 10 Mar 2025 16:18:34 +0800
Message-ID: <20250310081837.13123-7-chenyi.qiang@intel.com>
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

Introduce a new field, memory_attribute_manager, in RAMBlock to link to
an MemoryAttributeManager object. This change centralizes all
guest_memfd state information (like fd and shared_bitmap) within a
RAMBlock, making it easier to manage.

Use the realize()/unrealize() helpers to initialize/uninitialize the
MemoryAttributeManager object. Register/unregister the object in the
target RAMBlock's MemoryRegion when creating guest_memfd.

In the kvm_convert_memory() function, manage memory state changes by
using the shared_bitmap to call set_attribute() only on the specific
memory range. Additionally, use the
memory_attribute_manager_state_change() helper to notify the reigstered
RamDiscardListener of these changes.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v3:
    - Use ram_discard_manager_reply_populated/discarded() to set the
      memory attribute and add the undo support if state_change()
      failed.
    - Didn't add Reviewed-by from Alexey due to the new changes in this
      commit.

Changes in v2:
    - Introduce a new field memory_attribute_manager in RAMBlock.
    - Move the state_change() handling during page conversion in this patch.
    - Undo what we did if it fails to set.
    - Change the order of close(guest_memfd) and memory_attribute_manager cleanup.
---
 accel/kvm/kvm-all.c     | 50 +++++++++++++++++++++++++++++++++++++++--
 include/exec/ramblock.h |  2 ++
 system/physmem.c        | 13 +++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c1fea69d58..a89c5655e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -48,6 +48,7 @@
 #include "kvm-cpus.h"
 #include "system/dirtylimit.h"
 #include "qemu/range.h"
+#include "system/memory-attribute-manager.h"
 
 #include "hw/boards.h"
 #include "system/stats.h"
@@ -3018,6 +3019,25 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+typedef struct SetMemoryAttribute {
+    bool to_private;
+} SetMemoryAttribute;
+
+static int kvm_set_memory_attributes_cb(MemoryRegionSection *section,
+                                        void *opaque)
+{
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = section->size;
+    SetMemoryAttribute *args = opaque;
+    bool to_private = args->to_private;
+
+    if (to_private) {
+        return kvm_set_memory_attributes_private(start, size);
+    } else {
+        return kvm_set_memory_attributes_shared(start, size);
+    }
+}
+
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 {
     MemoryRegionSection section;
@@ -3026,6 +3046,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     RAMBlock *rb;
     void *addr;
     int ret = -EINVAL;
+    SetMemoryAttribute args = { .to_private = to_private };
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
 
@@ -3077,9 +3098,13 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     }
 
     if (to_private) {
-        ret = kvm_set_memory_attributes_private(start, size);
+        ret = ram_discard_manager_replay_populated(mr->rdm, &section,
+                                                   kvm_set_memory_attributes_cb,
+                                                   &args);
     } else {
-        ret = kvm_set_memory_attributes_shared(start, size);
+        ret = ram_discard_manager_replay_discarded(mr->rdm, &section,
+                                                   kvm_set_memory_attributes_cb,
+                                                   &args);
     }
     if (ret) {
         goto out_unref;
@@ -3088,6 +3113,27 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = memory_attribute_manager_state_change(MEMORY_ATTRIBUTE_MANAGER(mr->rdm),
+                                                offset, size, to_private);
+    if (ret) {
+        warn_report("Failed to notify the listener the state change of "
+                    "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                    start, size, to_private ? "private" : "shared");
+        args.to_private = !to_private;
+        if (to_private) {
+            ret = ram_discard_manager_replay_populated(mr->rdm, &section,
+                                                       kvm_set_memory_attributes_cb,
+                                                       &args);
+        } else {
+            ret = ram_discard_manager_replay_discarded(mr->rdm, &section,
+                                                       kvm_set_memory_attributes_cb,
+                                                       &args);
+        }
+        if (ret) {
+            goto out_unref;
+        }
+    }
+
     if (to_private) {
         if (rb->page_size != qemu_real_host_page_size()) {
             /*
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd105c0..06fd365326 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -23,6 +23,7 @@
 #include "cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
+#include "system/memory-attribute-manager.h"
 
 struct RAMBlock {
     struct rcu_head rcu;
@@ -42,6 +43,7 @@ struct RAMBlock {
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
+    MemoryAttributeManager *memory_attribute_manager;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..0ed394c5d2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -54,6 +54,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/xen-mapcache.h"
+#include "system/memory-attribute-manager.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1885,6 +1886,16 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        new_block->memory_attribute_manager = MEMORY_ATTRIBUTE_MANAGER(object_new(TYPE_MEMORY_ATTRIBUTE_MANAGER));
+        if (memory_attribute_manager_realize(new_block->memory_attribute_manager, new_block->mr)) {
+            error_setg(errp, "Failed to realize memory attribute manager");
+            object_unref(OBJECT(new_block->memory_attribute_manager));
+            close(new_block->guest_memfd);
+            ram_block_discard_require(false);
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
@@ -2138,6 +2149,8 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
+        memory_attribute_manager_unrealize(block->memory_attribute_manager);
+        object_unref(OBJECT(block->memory_attribute_manager));
         close(block->guest_memfd);
         ram_block_discard_require(false);
     }
-- 
2.43.5


