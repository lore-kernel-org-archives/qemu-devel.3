Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9874C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdIR-0008A4-Ct; Thu, 12 Jun 2025 04:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIL-000852-4r
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:21 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIJ-0004Fi-5r
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749716899; x=1781252899;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2q50YptO0BwNcKJJ1GYtGtPlphWJ7IdYPt7wdCRzghY=;
 b=DEfbGYJx+pYQ4Z7mkbbelg421f2jPNSguk8YO3Bt0UHOc9/3sXToVjd0
 p+MJJ5yYTY165QeIwBLPaiDe7kGS7LQyd4zLuOy35qYsoG8BV5BD++a4i
 LdSgeT0H7lBEzdZz2Rg8LKlkOy9+Sm6pzeXZrIlyL/qc+gmtoGhCyHvvK
 ASvvYd7Mo+WGlzAeuTrg6T66Bt8OYctox6YlBoFi5nv7MHcDvvY1j2Ho7
 4Vc0diykrrwsTtiV1AQaYEe/Q+LQB3A9frrkb4elEUCWks53i7zDNDS8O
 imEUA8DWlaB2q59dt2lixAhLBSsz28XjMmhnW43R3C+dj+78eepYqgC60 Q==;
X-CSE-ConnectionGUID: UIyApgjqQhegiqlT8p27mg==
X-CSE-MsgGUID: rO8e3gziQWek7TmzjTiCGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69453464"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="69453464"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:18 -0700
X-CSE-ConnectionGUID: echUqQE1SK64eZ7/AldPRw==
X-CSE-MsgGUID: fz3XyqcsTkGUeb1OAGLQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152442064"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:28:14 -0700
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
Subject: [PATCH v7 5/5] physmem: Support coordinated discarding of RAM with
 guest_memfd
Date: Thu, 12 Jun 2025 16:27:46 +0800
Message-ID: <20250612082747.51539-6-chenyi.qiang@intel.com>
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

A new field, attributes, was introduced in RAMBlock to link to a
RamBlockAttributes object, which centralizes all guest_memfd related
information (such as fd and status bitmap) within a RAMBlock.

Create and initialize the RamBlockAttributes object upon ram_block_add().
Meanwhile, register the object in the target RAMBlock's MemoryRegion.
After that, guest_memfd-backed RAMBlock is associated with the
RamDiscardManager interface, and the users can execute RamDiscardManager
specific handling. For example, VFIO will register the
RamDiscardListener and get notifications when the state_change() helper
invokes.

As coordinate discarding of RAM with guest_memfd is now supported, only
block uncoordinated discard.

Tested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v7:
    - Add some document about the attribute and status consistency
      (David).
    - Add Reviewed-by and Acked-by from Alexey and David.

Changes in v6:
    - Squash the unblocking of cooridnate discard into this commit.
    - Remove the checks in migration path.

Changes in v5:
    - Revert to use RamDiscardManager interface.
    - Move the object_new() into the ram_block_attribute_create()
      helper.
    - Add some check in migration path.

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
---
 accel/kvm/kvm-all.c       |  9 +++++++++
 include/system/ramblock.h |  1 +
 system/physmem.c          | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 51526d301b..3b390bbb09 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3089,6 +3089,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
+                                            offset, size, to_private);
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
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 1bab9e2dac..87e847e184 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -46,6 +46,7 @@ struct RAMBlock {
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
+    RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309e..ff0ca40222 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
         assert(new_block->guest_memfd < 0);
 
-        ret = ram_block_discard_require(true);
+        ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
@@ -1931,6 +1931,24 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
+        /*
+         * The attribute bitmap of the RamBlockAttributes is default to
+         * discarded, which mimics the behavior of kvm_set_phys_mem() when it
+         * calls kvm_set_memory_attributes_private(). This leads to a brief
+         * period of inconsistency between the creation of the RAMBlock and its
+         * mapping into the physical address space. However, this is not
+         * problematic, as no users rely on the attribute status to perform
+         * any actions during this interval.
+         */
+        new_block->attributes = ram_block_attributes_create(new_block);
+        if (!new_block->attributes) {
+            error_setg(errp, "Failed to create ram block attribute");
+            close(new_block->guest_memfd);
+            ram_block_coordinated_discard_require(false);
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         /*
          * Add a specific guest_memfd blocker if a generic one would not be
          * added by ram_block_add_cpr_blocker.
@@ -2287,8 +2305,9 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
+        ram_block_attributes_destroy(block->attributes);
         close(block->guest_memfd);
-        ram_block_discard_require(false);
+        ram_block_coordinated_discard_require(false);
     }
 
     g_free(block);
-- 
2.43.5


