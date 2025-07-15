Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2203DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 03:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubWWc-0004DX-Pg; Mon, 14 Jul 2025 23:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWb-0004CG-IU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWZ-0006Rk-Ej
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752550812; x=1784086812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qeil6/cS4TnDGn/oSbEZUuBv4NuQFCKMlPyhRgS+pqA=;
 b=iZVk9GrKRVX3lwddkefiI+bsA3Kw9u4v/j7/4++UTwpAZxF0JCJGSD2l
 vfNxrd2Il1ccJxqUUXJtPllmFTPJM4NK+QTpBrIj2AfGzIMWN+0evB9l/
 kojCUvhK2xc9lzffnPIJPJa0J+mTi01jKc8Y/2hBHWDLZVk4c9D8idiW4
 2lYZpcAYzCf3uaDUFmoPQTwTyJOUT/Qgc3m6lQOPWB6rP5pDfrE3s8+5a
 02dSe5HsFNRjzPd82Q2DVlnxKNAsZrYpvkQgXeB6KoRC0uXBs1Npkn2Ep
 Rpy7ZxuAFoMJcKK3OK8IigW+Ohv4z9blm0vEs5ea2ej/bj0HHpapiP2oz g==;
X-CSE-ConnectionGUID: yqjRu9P5Rh66xaKYsx4O3Q==
X-CSE-MsgGUID: mcmHgc6+SpuQNTMplWypSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72334946"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="72334946"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 20:40:11 -0700
X-CSE-ConnectionGUID: V/OJWrNDQHSoOfPHxJLXSA==
X-CSE-MsgGUID: Zf/J+uF7SEqChZOuPe+G6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="180808190"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 14 Jul 2025 20:40:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 ackerleytng@google.com, seanjc@google.com
Cc: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>,
 rick.p.edgecombe@intel.com, Kai Huang <kai.huang@intel.com>,
 binbin.wu@linux.intel.com, yan.y.zhao@intel.com, ira.weiny@intel.com,
 michael.roth@amd.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [POC PATCH 5/5] [HACK] memory: Don't enable in-place conversion for
 internal MemoryRegion with gmem
Date: Tue, 15 Jul 2025 11:31:41 +0800
Message-ID: <20250715033141.517457-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715033141.517457-1-xiaoyao.li@intel.com>
References: <cover.1747264138.git.ackerleytng@google.com>
 <20250715033141.517457-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the TDVF cannot work with gmem in-place conversion because
current implementation of KVM_TDX_INIT_MEM_REGION in KVM requires
gmem of TDVF to be valid for both shared and private at the same time.

To workaround it, explicitly not enable in-place conversion for internal
MemoryRegion with gmem. So that TDVF doesn't use in-place conversion gmem
and KVM_TDX_INIT_MEM_REGION will initialize the gmem with the separate
shared memory.

To make in-place conversion work with TDX's initial memory, the
one possible solution and flow would be as below and it requires KVM
change:

- QEMU create gmem as shared;
- QEMU mmap the gmem and load TDVF binary into it;
- QEMU convert gmem to private with the content preserved[1];
- QEMU invokes KVM_TDX_INIT_MEM_REGION without valid src, so that KVM
  knows to fetch the content in-place and use in-place PAGE.ADD for TDX.

[1] https://lore.kernel.org/all/aG0pNijVpl0czqXu@google.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/system/memory.h | 3 +++
 system/memory.c         | 2 +-
 system/physmem.c        | 8 +++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index f14fbf65805d..89d6449cef70 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -256,6 +256,9 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/* Don't use enable in-place conversion for the guest mmefd backend */
+#define RAM_GUEST_MEMFD_NO_INPLACE (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/memory.c b/system/memory.c
index 6870a41629ef..c1b73abc4c94 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3702,7 +3702,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
     DeviceState *owner_dev;
 
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD, errp)) {
+                                                RAM_GUEST_MEMFD | RAM_GUEST_MEMFD_NO_INPLACE, errp)) {
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
diff --git a/system/physmem.c b/system/physmem.c
index ea1c27ea2b99..c23379082f38 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1916,7 +1916,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 
     if (new_block->flags & RAM_GUEST_MEMFD) {
         int ret;
-        bool in_place = kvm_guest_memfd_inplace_supported;
+        bool in_place = !(new_block->flags & RAM_GUEST_MEMFD_NO_INPLACE) &&
+                        kvm_guest_memfd_inplace_supported;
 
         new_block->guest_memfd_flags = 0;
 
@@ -2230,7 +2231,8 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD |
+                          RAM_GUEST_MEMFD_NO_INPLACE)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
     assert(max_size >= size);
 
@@ -2314,7 +2316,7 @@ RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
     assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
-                          RAM_PRIVATE)) == 0);
+                          RAM_PRIVATE | RAM_GUEST_MEMFD_NO_INPLACE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
-- 
2.43.0


