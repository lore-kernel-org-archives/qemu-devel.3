Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwL-000531-Li; Wed, 08 Jul 2026 03:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMw9-0004Q2-0R; Wed, 08 Jul 2026 03:43:17 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMw7-0004ox-22; Wed, 08 Jul 2026 03:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496595; x=1815032595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Pd6luYiUZ33e7gYrFtn+0Tg72KmZFlQ8qruU1KkqGg=;
 b=khH3QPz3Rg7cP7Uc+qzAig9VZTy8lJBlpEBnzRXc5RXf3UT8Hfr3Yd9h
 l1XV+GFqu4atkUr1lNyAPM2HUdGa0sR0gAhh2e5qZdxJdIn6Q2cJ/Vs4r
 /O5jsMe2XxQ4mFtSGD0m5yfsrokXAXlB3cD/9vI60o6OYtEGuRMd0GPzT
 Qw1lL/xP1GT/Lp2JB/FC/SEjlmLBu1PnXSnbMjbt/03WGjgG9umnJOaSb
 G8PSrGsKtbc3yPiBEcfw1f7asUICQbCPyzq0Wj+j5xlRIKabrhZwSvX0r
 i8fyTvZw47R4HoanAS9qZouCHUwuFB36YaenIG+BxCf49hhpzezV84BEh Q==;
X-CSE-ConnectionGUID: YorG+jSLS42QoL/73z5d6A==
X-CSE-MsgGUID: pPQFiYRvSOi6wqiFYlHtGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343325"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:14 -0700
X-CSE-ConnectionGUID: gjxw7uo1QFiU4GZycLehkw==
X-CSE-MsgGUID: qsjvNvdwS6KYCIezC0tHBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555988"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:09 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 12/26] memory: Make flatview_do_translate() return a pointer
 to MemoryRegionSection
Date: Wed,  8 Jul 2026 16:10:38 +0800
Message-Id: <20260708081052.2276617-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Rust will use common::Opaque to hide the details of C structures,
which helps avoid direct manipulation of C memory from the Rust side.

Therefore, it is necessary to create a translation binding wrapper that
returns a pointer to a MemoryRegionSection, instead of returning a copy
by value.

As a first step, make flatview_do_translate() return a pointer to a
MemoryRegionSection so that we can build a wrapper around it.

In addition, add a global variable `unassigned_section` to provide a
pointer to an invalid MemoryRegionSection.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/physmem.c | 51 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index f807e60aa348..418fc79ff2c0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -104,6 +104,9 @@ AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
 static MemoryRegion io_mem_unassigned;
+static MemoryRegionSection unassigned_section = {
+    .mr = &io_mem_unassigned
+};
 
 typedef struct PhysPageEntry PhysPageEntry;
 
@@ -419,14 +422,11 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
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
@@ -464,10 +464,10 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
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
@@ -490,15 +490,10 @@ unassigned:
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
@@ -524,14 +519,14 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
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
@@ -543,13 +538,13 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
@@ -570,13 +565,13 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
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
 
     if (xen_map_cache_enabled() &&
         memory_access_is_direct(mr, is_write, attrs)) {
@@ -3908,7 +3903,7 @@ static inline MemoryRegion *address_space_translate_cached(
     const MemoryRegionCache *cache, hwaddr addr, hwaddr *xlat,
     hwaddr *plen, bool is_write, MemTxAttrs attrs)
 {
-    MemoryRegionSection section;
+    MemoryRegionSection *section;
     MemoryRegion *mr;
     IOMMUMemoryRegion *iommu_mr;
     AddressSpace *target_as;
@@ -3926,7 +3921,7 @@ static inline MemoryRegion *address_space_translate_cached(
     section = address_space_translate_iommu(iommu_mr, xlat, plen,
                                             NULL, is_write, true,
                                             &target_as, attrs);
-    return section.mr;
+    return section->mr;
 }
 
 /* Called within RCU critical section.  */
-- 
2.34.1


