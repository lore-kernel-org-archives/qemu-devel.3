Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E63DFED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Zpq-0006cZ-83; Thu, 12 Mar 2026 02:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w0Zpp-0006cM-6M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:47:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w0Zpi-0006Tp-Ev
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773298066; x=1804834066;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Rjgf8C+Qwkuv+8eXtMo/pPyB4RGCESAJjkSJkYfpUr0=;
 b=hObNcPf12Fq2KiFr6htEkDBG+054ep7Z6GRE64HJetbb+6PTQ0yPQ/Xs
 90i9lH65r7LsK/yy7M1S6I0fjp79M8v3B4rIABx4KsVCPKKaxsJZ1ryIz
 E01diitxvplVqVT/o2DRyKbxB3dhf5fY6jIxG5rF5Fits1rgn9JRYEW+w
 JepNCxZzIQSc/noCHkoG8jWwkrt2W91xhzH1xtnk5NmSjtRFsZY1AtNl7
 pP8ovOgeLQ3tUluPDpZzZ7v+NcYm3D5Mz1HkIKIbARKoH+FtQUY+XgaXq
 7eMSeKP0qKA3zGA12VjjhVRgsXoWjtxNHjXt3SjaVLAbWWlR4gPnu7x+U w==;
X-CSE-ConnectionGUID: bCtixbetSxCWP7CbXMq2oA==
X-CSE-MsgGUID: lEJcn55WS/CobwM+jtF2TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73572999"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="73572999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 23:47:41 -0700
X-CSE-ConnectionGUID: gxwHyv2yRbaGHcDJ3haHcw==
X-CSE-MsgGUID: d3b34WdpTEmEVSMVpweKDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="218154810"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2026 23:47:39 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xiaoyao.li@intel.com, BALATON Zoltan <balaton@eik.bme.hu>,
 chenyi.qiang@intel.com, Farrah Chen <farrah.chen@intel.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] memory: Set mr->ram before RAM Block allocation
Date: Thu, 12 Mar 2026 14:34:20 +0800
Message-ID: <20260312063420.973637-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
introduced a helper function memory_region_set_ram_block(), which causes
mr->ram to be set to true after the RAM Block allocation by
qemu_ram_alloc_*().

It leads to the assertion

  g_assert(memory_region_is_ram(mr));

in memory_region_set_ram_discard_manager() being triggered when creating
RAM Block with the RAM_GUEST_MEMFD flag.

Fix this by restoring the original behavior of setting mr->ram before
RAM Block allocation.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
Reported-by: Farrah Chen <farrah.chen@intel.com>
Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 system/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 17a7bcd9af7c..56f3225b21ad 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1578,7 +1578,6 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
 
 static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
-    mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = rb;
@@ -1597,6 +1596,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     rb = qemu_ram_alloc(size, ram_flags, mr, errp);
     return memory_region_set_ram_block(mr, rb);
 }
@@ -1614,6 +1614,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
     return memory_region_set_ram_block(mr, rb);
 }
@@ -1628,6 +1629,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->align = align;
     rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
@@ -1642,6 +1644,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
     RAMBlock *rb;
 
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
     rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
                                 false, errp);
@@ -1663,6 +1666,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
                                 void *ptr)
 {
     memory_region_init(mr, owner, name, size);
+    mr->ram = true;
     memory_region_set_ram_ptr(mr, size, ptr);
 }
 
@@ -1671,6 +1675,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        void *ptr)
 {
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
+    mr->ram = true;
     mr->ram_device = true;
     memory_region_set_ram_ptr(mr, size, ptr);
 }
@@ -3699,7 +3704,6 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     memory_region_init_io(mr, owner, ops, opaque, name, size);
     rb = qemu_ram_alloc(size, 0, mr, errp);
     if (memory_region_set_ram_block(mr, rb)) {
-        mr->ram = false;
         mr->rom_device = true;
         memory_region_register_ram(mr, owner);
         return true;
-- 
2.43.0


