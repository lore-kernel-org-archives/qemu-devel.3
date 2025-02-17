Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD8DC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwLg-0004BJ-Hn; Mon, 17 Feb 2025 03:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLN-0003KK-Rp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:10 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLL-00016L-UO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739780348; x=1771316348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=et457s5gxOACczlEdsQV3JpgBTp1+3xW6hMwzsrYsk0=;
 b=YTsltjjBP8pYj6fyjVtU8FewUgjBfvXMe4Ut+2qX907rmnOHGweRfKL0
 RBUtVrXis2aW/lqcKIquSbLvfiY2SQShGKbwDxRbgdWl1cTxA9bdlivFS
 IxaiD9mws3LeroQ0zhOyN9dHjemnB054+1NhFiGe1xJyOx7Ce11c6bJHc
 Gv8NBPjYZfEp57s8mjfYU8kWsVWmsXRvbvc45STJkmJrpDKFIRnYci2z+
 kTgUuLSvF6BxMZqjuKE6ZlkvODoycbjq4GQUbMnA3VEcqkjtrsH1QU72W
 ODxUnNDsIX8osq2OqYrfoTwx7oEaE0L8FshIGzO7e0zJi/G4m3hetOPj3 g==;
X-CSE-ConnectionGUID: AhNI4sneSsKAtuz6c89uXA==
X-CSE-MsgGUID: cCzvFtLXSYa2d9No98kcIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="50669002"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="50669002"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:19:04 -0800
X-CSE-ConnectionGUID: l51kerAISVmk9QAqliXkng==
X-CSE-MsgGUID: xdV2eWBVTKyB3H50d8XF5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118690254"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:19:02 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v2 5/6] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
Date: Mon, 17 Feb 2025 16:18:24 +0800
Message-ID: <20250217081833.21568-6-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217081833.21568-1-chenyi.qiang@intel.com>
References: <20250217081833.21568-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

Introduce a new field, memory_attribute_manager, in RAMBlock to link to
an MemoryAttributeManager object. This change centralizes all
guest_memfd state information (like fd and shared_bitmap) within a
RAMBlock, making it easier to manage.

Use the realize()/unrealize() helpers to initialize/uninitialize the
MemoryAttributeManager object. Register/unregister the object in the
target RAMBlock's MemoryRegion when creating guest_memfd. Upon memory
state changes in kvm_convert_memory(), invoke the
memory_attribute_manager_state_change() helper to notify the registered
RamDiscardListener.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v2:
    - Introduce a new field memory_attribute_manager in RAMBlock.
    - Move the state_change() handling during page conversion in this patch.
    - Undo what we did if it fails to set.
    - Change the order of close(guest_memfd) and memory_attribute_manager cleanup.
---
 accel/kvm/kvm-all.c     |  9 +++++++++
 include/exec/ramblock.h |  2 ++
 system/physmem.c        | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c1fea69d58..c0d15c48ad 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -48,6 +48,7 @@
 #include "kvm-cpus.h"
 #include "system/dirtylimit.h"
 #include "qemu/range.h"
+#include "system/memory-attribute-manager.h"
 
 #include "hw/boards.h"
 #include "system/stats.h"
@@ -3088,6 +3089,14 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = memory_attribute_manager_state_change(MEMORY_ATTRIBUTE_MANAGER(mr->rdm),
+                                                offset, size, to_private);
+    if (ret) {
+        warn_report("Failed to notify the listener the state change of "
+                    "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                    start, size, to_private ? "private" : "shared");
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


