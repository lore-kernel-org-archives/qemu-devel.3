Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A60C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFi-0001OH-Lx; Mon, 07 Apr 2025 03:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFR-0001Jy-0R
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:28 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFO-0005Qw-53
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012223; x=1775548223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VcsOtoKaXuIBJyGwmx8nSbTIs9EhvqUalOaaez7TI0A=;
 b=nfnVgqI2mguGcr+GRlKDsxRVge4sHLTL8LCCqOTmab+F4y3tbcRXM9yM
 zaXrtTZ+uyJN48D4082xll8r1NsRjlDU918e32I4oWrOYW3nZLETwSjDR
 twOvatE4ZVL9IxmxEhhoXiHAXxYsnrHLszgk0EzceekTHhzopVeikJh/l
 MP55KAnjqi2OB+fFe9OsQ527Db8KuoeS1NPQ9Xb/zUBmDYq723nBhq3yz
 IMQ4x0jCD95zRoGWk8OdksQmRgwF/GnWGJ/E3FXG9wPD21v+Rs8KdLysd
 uOpFyWV8KV2JHKlvWuO93A1cgaSX2t1OlIoNytfaFgos0Malcg5sB/ICy Q==;
X-CSE-ConnectionGUID: /GGRnJdySGyigzpxPDE/jg==
X-CSE-MsgGUID: 5WzDdvVGTjuKvkcfjADLUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857570"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:22 -0700
X-CSE-ConnectionGUID: 52pGxl9oQAeCJDAezIyv3w==
X-CSE-MsgGUID: Q/C6FP9TTbaf3hipyyTGfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405662"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:18 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 09/13] memory: Attach RamBlockAttribute to
 guest_memfd-backed RAMBlocks
Date: Mon,  7 Apr 2025 15:49:29 +0800
Message-ID: <20250407074939.18657-10-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

A new field, ram_block_attribute, is introduced in RAMBlock to link to a
RamBlockAttribute object. This change centralizes all guest_memfd state
information (such as fd and shared_bitmap) within a RAMBlock,
simplifying management.

The realize()/unrealized() helpers are used to initialize/uninitialize
the RamBlockAttribute object. The object is registered/unregistered in
the target RAMBlock's MemoryRegion when creating guest_memfd.

Additionally, use the private_shared_manager_state_change() helper to
notify the registered PrivateSharedListener of these changes.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Remove the replay operations for attribute changes which will be
      handled in a listener in following patches.
    - Add some comment in the error path of realize() to remind the
      future development of the unified error path.

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
 accel/kvm/kvm-all.c     |  9 +++++++++
 include/exec/ramblock.h |  1 +
 system/physmem.c        | 16 ++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c1fea69d58..546b58b737 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3088,6 +3088,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = private_shared_manager_state_change(PRIVATE_SHARED_MANAGER(mr->gsm),
+                                              offset, size, to_private);
+    if (ret) {
+        error_report("Failed to notify the listener the state change of "
+                     "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                     start, size, to_private ? "private" : "shared");
+        goto out_unref;
+    }
+
     if (to_private) {
         if (rb->page_size != qemu_real_host_page_size()) {
             /*
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index b8b5469db9..78eb031819 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -46,6 +46,7 @@ struct RAMBlock {
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
+    RamBlockAttribute *ram_block_attribute;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..fb74321e10 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1885,6 +1885,20 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        new_block->ram_block_attribute = RAM_BLOCK_ATTRIBUTE(object_new(TYPE_RAM_BLOCK_ATTRIBUTE));
+        if (ram_block_attribute_realize(new_block->ram_block_attribute, new_block->mr)) {
+            error_setg(errp, "Failed to realize ram block attribute");
+            /*
+             * The error path could be unified if the rest of ram_block_add() ever
+             * develops a need to check for errors.
+             */
+            object_unref(OBJECT(new_block->ram_block_attribute));
+            close(new_block->guest_memfd);
+            ram_block_discard_require(false);
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
@@ -2138,6 +2152,8 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
+        ram_block_attribute_unrealize(block->ram_block_attribute);
+        object_unref(OBJECT(block->ram_block_attribute));
         close(block->guest_memfd);
         ram_block_discard_require(false);
     }
-- 
2.43.5


