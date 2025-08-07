Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A502C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSQ-0004Fh-61; Thu, 07 Aug 2025 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRu-0001rw-V7; Thu, 07 Aug 2025 08:10:23 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRp-0005Cn-Jw; Thu, 07 Aug 2025 08:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568618; x=1786104618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lbnpK8OyGgwHu5vkc+8beR3dBNzfXQc8vRTwv8yoFE8=;
 b=OTpkRXBJWTwAThCzTt2mRXsSFC2YOoV7fqb69UeCUWd3h9UuOp18udKh
 Nwyg5UqFornxIvZuwta8g6v3AAvD0oDZoe4y1TKE9wIlKYqLDgrCo7Hgk
 gcwSfymOCqXKD/H01VphATrHrskMvcEz4KAd6QcW7sxnXgqS77vI7cZ3S
 MsCCAf1UetGQwBQcB/U8QgtchQPct6R7LxnjQug04B0WPIoWCtfUpXUAK
 hdrlRLxPDFdQCE8Nli5rdWAQHPmJOBjxrt6qFIn+9QJ/Aq4TNC/BCWDjN
 W7AbDY2WK1EXlVMn7vx405+nSNCUtqGGGzi/pbVZlhmf+r8hsgVpEnTbg A==;
X-CSE-ConnectionGUID: l829pqP2QrKqNzOeHri9aQ==
X-CSE-MsgGUID: j9VwhQD6RCe1cdpv3Q7+/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036829"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036829"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:55 -0700
X-CSE-ConnectionGUID: d/BF90LjQYusZ5jvSUIDRQ==
X-CSE-MsgGUID: vCBVfKaoToqbg8jWIBvAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701142"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 16/26] memory: Make flatview_do_translate() return a pointer to
 MemoryRegionSection
Date: Thu,  7 Aug 2025 20:30:17 +0800
Message-Id: <20250807123027.2910950-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Rust side will use cell::Opaque<> to hide details of C structure, and
this could help avoid the direct operation on C memory from Rust side.

Therefore, it's necessary to wrap a translation binding and make it only
return the pointer to MemoryRegionSection, instead of the copy.

As the first step, make flatview_do_translate return a pointer to
MemoryRegionSection, so that we can build a wrapper based on it.

In addtion, add a global variable `unassigned_section` to help get a
pointer to an invalid MemoryRegionSection.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/physmem.c | 51 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 785c9a4050c6..4af29ea2168e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -103,6 +103,9 @@ AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
 static MemoryRegion io_mem_unassigned;
+static MemoryRegionSection unassigned_section = {
+    .mr = &io_mem_unassigned
+};
 
 typedef struct PhysPageEntry PhysPageEntry;
 
@@ -418,14 +421,11 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
  * This function is called from RCU critical section.  It is the common
  * part of flatview_do_translate and address_space_translate_cached.
  */
-static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iommu_mr,
-                                                         hwaddr *xlat,
-                                                         hwaddr *plen_out,
-                                                         hwaddr *page_mask_out,
-                                                         bool is_write,
-                                                         bool is_mmio,
-                                                         AddressSpace **target_as,
-                                                         MemTxAttrs attrs)
+static MemoryRegionSection *
+address_space_translate_iommu(IOMMUMemoryRegion *iommu_mr, hwaddr *xlat,
+                              hwaddr *plen_out, hwaddr *page_mask_out,
+                              bool is_write, bool is_mmio,
+                              AddressSpace **target_as, MemTxAttrs attrs)
 {
     MemoryRegionSection *section;
     hwaddr page_mask = (hwaddr)-1;
@@ -463,10 +463,10 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
     if (page_mask_out) {
         *page_mask_out = page_mask;
     }
-    return *section;
+    return section;
 
 unassigned:
-    return (MemoryRegionSection) { .mr = &io_mem_unassigned };
+    return &unassigned_section;
 }
 
 /**
@@ -489,15 +489,10 @@ unassigned:
  *
  * This function is called from RCU critical section
  */
-static MemoryRegionSection flatview_do_translate(FlatView *fv,
-                                                 hwaddr addr,
-                                                 hwaddr *xlat,
-                                                 hwaddr *plen_out,
-                                                 hwaddr *page_mask_out,
-                                                 bool is_write,
-                                                 bool is_mmio,
-                                                 AddressSpace **target_as,
-                                                 MemTxAttrs attrs)
+static MemoryRegionSection *
+flatview_do_translate(FlatView *fv, hwaddr addr, hwaddr *xlat, hwaddr *plen_out,
+                      hwaddr *page_mask_out, bool is_write, bool is_mmio,
+                      AddressSpace **target_as, MemTxAttrs attrs)
 {
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
@@ -523,14 +518,14 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
         *page_mask_out = ~TARGET_PAGE_MASK;
     }
 
-    return *section;
+    return section;
 }
 
 /* Called from RCU critical section */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs)
 {
-    MemoryRegionSection section;
+    MemoryRegionSection *section;
     hwaddr xlat, page_mask;
 
     /*
@@ -542,13 +537,13 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                     attrs);
 
     /* Illegal translation */
-    if (section.mr == &io_mem_unassigned) {
+    if (section->mr == &io_mem_unassigned) {
         goto iotlb_fail;
     }
 
     /* Convert memory region offset into address space offset */
-    xlat += section.offset_within_address_space -
-        section.offset_within_region;
+    xlat += section->offset_within_address_space -
+        section->offset_within_region;
 
     return (IOMMUTLBEntry) {
         .target_as = as,
@@ -569,13 +564,13 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                  MemTxAttrs attrs)
 {
     MemoryRegion *mr;
-    MemoryRegionSection section;
+    MemoryRegionSection *section;
     AddressSpace *as = NULL;
 
     /* This can be MMIO, so setup MMIO bit. */
     section = flatview_do_translate(fv, addr, xlat, plen, NULL,
                                     is_write, true, &as, attrs);
-    mr = section.mr;
+    mr = section->mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
@@ -3618,7 +3613,7 @@ static inline MemoryRegion *address_space_translate_cached(
     MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
     hwaddr *plen, bool is_write, MemTxAttrs attrs)
 {
-    MemoryRegionSection section;
+    MemoryRegionSection *section;
     MemoryRegion *mr;
     IOMMUMemoryRegion *iommu_mr;
     AddressSpace *target_as;
@@ -3636,7 +3631,7 @@ static inline MemoryRegion *address_space_translate_cached(
     section = address_space_translate_iommu(iommu_mr, xlat, plen,
                                             NULL, is_write, true,
                                             &target_as, attrs);
-    return section.mr;
+    return section->mr;
 }
 
 /* Called within RCU critical section.  */
-- 
2.34.1


