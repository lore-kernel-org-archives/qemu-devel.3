Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279CDC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKDz-0004l1-Qe; Tue, 20 May 2025 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDx-0004jb-I7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:29 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDv-0004gB-CQ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736968; x=1779272968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZTijY9Sdopl8+Dse6K2gwMX4Z7V1NW/c8Gpa+JnYhEs=;
 b=Q4jvl9XCnKSl1a0qvVWN6KvhazYIsdUC7qS3yTvKnA34kAxXw+RG0fRE
 azOb1wO2ISAJ2DMUmLPYWCy3wDRdqePPGYm9AOPm/tu4TqXOUzEwLxqJy
 TrrFecbEIQpEEZkcXEehzYPpEXWyUttOCiHn6FrJipo4SlL5c/XpO3V3Y
 U/H77e2A3kFkxwqfqnh5XSZzhgh3DOM02BN5kV9UxY2z60CR+IXLivnYU
 nECv2lb53+9lRsSqz8/EQ8bzlAPNalthOSfiw+nbMTJA5r4DPmj4/D74R
 cAPLJgjGmxDIhfcrdmbAAic/R7wln56t6zPRjCAcpx/3t7zRIwR8IAVCT A==;
X-CSE-ConnectionGUID: dGEZMmW3Q9ikvPD0tCc4Wg==
X-CSE-MsgGUID: egUJm4yLT4GcXxrY8m4Dcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566668"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:26 -0700
X-CSE-ConnectionGUID: qH/3r4eJRWqXLyP4ArAIjw==
X-CSE-MsgGUID: Dn1CjrlUSPixRMIoLxJdBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905270"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:22 -0700
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
Subject: [PATCH v5 06/10] memory: Attach RamBlockAttribute to
 guest_memfd-backed RAMBlocks
Date: Tue, 20 May 2025 18:28:46 +0800
Message-ID: <20250520102856.132417-7-chenyi.qiang@intel.com>
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

A new field, ram_shared, was introduced in RAMBlock to link to a
RamBlockAttribute object, which centralizes all guest_memfd state
information (such as fd and shared_bitmap) within a RAMBlock.

Create and initialize the RamBlockAttribute object upon ram_block_add().
Meanwhile, register the object in the target RAMBlock's MemoryRegion.
After that, guest_memfd-backed RAMBlock is associated with the
RamDiscardManager interface, and the users will execute
RamDiscardManager specific handling. For example, VFIO will register the
RamDiscardListener as expected. The live migration path needs to be
avoided since it is not supported yet in confidential VMs.

Additionally, use the ram_block_attribute_state_change() helper to
notify the registered RamDiscardListener of these changes.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
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

Changes in v2:
    - Introduce a new field memory_attribute_manager in RAMBlock.
    - Move the state_change() handling during page conversion in this patch.
    - Undo what we did if it fails to set.
    - Change the order of close(guest_memfd) and memory_attribute_manager cleanup.
---
 accel/kvm/kvm-all.c |  9 +++++++++
 migration/ram.c     | 28 ++++++++++++++++++++++++++++
 system/physmem.c    | 14 ++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 51526d301b..2d7ecaeb6a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3089,6 +3089,15 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
+    ret = ram_block_attribute_state_change(RAM_BLOCK_ATTRIBUTE(mr->rdm),
+                                           offset, size, to_private);
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
diff --git a/migration/ram.c b/migration/ram.c
index c004f37060..69c9a42f16 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -890,6 +890,13 @@ static uint64_t ramblock_dirty_bitmap_clear_discarded_pages(RAMBlock *rb)
 
     if (rb->mr && rb->bmap && memory_region_has_ram_discard_manager(rb->mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(rb->mr);
+
+        if (object_dynamic_cast(OBJECT(rdm), TYPE_RAM_BLOCK_ATTRIBUTE)) {
+            error_report("%s: Live migration for confidential VM is not "
+                         "supported yet.", __func__);
+            exit(1);
+        }
+
         MemoryRegionSection section = {
             .mr = rb->mr,
             .offset_within_region = 0,
@@ -913,6 +920,13 @@ bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start)
 {
     if (rb->mr && memory_region_has_ram_discard_manager(rb->mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(rb->mr);
+
+        if (object_dynamic_cast(OBJECT(rdm), TYPE_RAM_BLOCK_ATTRIBUTE)) {
+            error_report("%s: Live migration for confidential VM is not "
+                         "supported yet.", __func__);
+            exit(1);
+        }
+
         MemoryRegionSection section = {
             .mr = rb->mr,
             .offset_within_region = start,
@@ -1552,6 +1566,13 @@ static void ram_block_populate_read(RAMBlock *rb)
      */
     if (rb->mr && memory_region_has_ram_discard_manager(rb->mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(rb->mr);
+
+        if (object_dynamic_cast(OBJECT(rdm), TYPE_RAM_BLOCK_ATTRIBUTE)) {
+            error_report("%s: Live migration for confidential VM is not "
+                         "supported yet.", __func__);
+            exit(1);
+        }
+
         MemoryRegionSection section = {
             .mr = rb->mr,
             .offset_within_region = 0,
@@ -1611,6 +1632,13 @@ static int ram_block_uffd_protect(RAMBlock *rb, int uffd_fd)
     /* See ram_block_populate_read() */
     if (rb->mr && memory_region_has_ram_discard_manager(rb->mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(rb->mr);
+
+        if (object_dynamic_cast(OBJECT(rdm), TYPE_RAM_BLOCK_ATTRIBUTE)) {
+            error_report("%s: Live migration for confidential VM is not "
+                         "supported yet.", __func__);
+            exit(1);
+        }
+
         MemoryRegionSection section = {
             .mr = rb->mr,
             .offset_within_region = 0,
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309e..f05f7ff09a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1931,6 +1931,19 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
+        new_block->ram_shared = ram_block_attribute_create(new_block->mr);
+        if (!new_block->ram_shared) {
+            error_setg(errp, "Failed to create ram block attribute");
+            /*
+             * The error path could be unified if the rest of ram_block_add()
+             * ever develops a need to check for errors.
+             */
+            close(new_block->guest_memfd);
+            ram_block_discard_require(false);
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         /*
          * Add a specific guest_memfd blocker if a generic one would not be
          * added by ram_block_add_cpr_blocker.
@@ -2287,6 +2300,7 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
+        ram_block_attribute_destroy(block->ram_shared);
         close(block->guest_memfd);
         ram_block_discard_require(false);
     }
-- 
2.43.5


