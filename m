Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A4BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwN-0005Ah-F1; Wed, 08 Jul 2026 03:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwL-00050I-3U; Wed, 08 Jul 2026 03:43:29 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwJ-0004ox-C0; Wed, 08 Jul 2026 03:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496608; x=1815032608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D9f+ISIq4RvumZ8f8S94j8L5GCqYoQ10V046ev7+rdk=;
 b=kZAfXhr5NpqHhdq9LAre6gTzlN4D14PTAUVP63aoPxI9+eOozkdqyPm2
 HPQjXeNnbPNHWh5N9rd5zWAstXJgpkVe8pAOeES4YnHi+gj2m+5Se7ztW
 s3HCykQlplgGBktlhfY80d/mVl5Wjq58fbUZJGuGAviVZ2U+6SX3cEdJR
 hodTJ4QWXZd2YjGZ2PBbWNceBN+aztm/3QE4h7afC2/m2yMAibwrd0M9N
 uBUwGax02hF4CNo5+LpEIyQCgn5Y95H9fp5C0PnC2+YCj2qIwRwdrMhRp
 CBBjcJy0+d62/2E0CUKO1oStA918vDhD2+CdVdY/DIXfiffyvOA9mkbLZ g==;
X-CSE-ConnectionGUID: bTveeASnTuy5r24ydUb7Qg==
X-CSE-MsgGUID: IdDcmJzTQZyQII8XXsx21g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343355"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343355"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:26 -0700
X-CSE-ConnectionGUID: Hiz3VhIQQCmHOqBL+2Z6bw==
X-CSE-MsgGUID: XKVszofZTEaSXhtkjmvApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556016"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:22 -0700
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
Subject: [RFC v2 15/26] memory: Add MemoryRegionSection-based misc helpers
Date: Wed,  8 Jul 2026 16:10:41 +0800
Message-Id: <20260708081052.2276617-16-zhao1.liu@intel.com>
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

Add the following helpers:
 * section_access_allowed()
   - used to check memory access permissions.

 * section_covers_region_addr()
   - used to implement GuestMemoryRegion::check_address().

 * section_fuzz_dma_read()
   - used to insert a fuzzing hook before read/load operations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Drop section_get_host_addr() for two reasons:
   - GuestMemoryRegion::get_host_address() doesn't accept Permissions
     and MemTxAttrs arguments, which doesn't map well to QEMU's
     complex use cases.
   - section_get_host_addr() itself doesn't differentiate between MMIO
     and RAM. Although this could be fixed, the first reason makes it
     unnecessary.
---
 include/system/memory.h | 39 +++++++++++++++++++++++++++++++++++++++
 system/physmem.c        | 20 ++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 7e64a39662be..18f269ac4dab 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2878,6 +2878,45 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
 MemTxResult address_space_set(const AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
+/**
+ * section_access_allowed: Check if a memory transaction is allowed.
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @attrs: Memory transaction attributes.
+ * @addr: The address within that memory region.
+ * @len: The number of bytes to access.
+ *
+ * Returns: true if the transaction is allowed, false if denied.
+ */
+bool section_access_allowed(MemoryRegionSection *section,
+                            MemTxAttrs attrs, hwaddr addr,
+                            hwaddr len);
+
+/**
+ * section_covers_region_addr: Check if a region address is covered by
+ * a #MemoryRegionSection.
+ *
+ * @section: The #MemoryRegionSection to check against.
+ * @region_addr: The address within the memory region referenced by the
+ * @section.
+ *
+ * Returns: true if the address is covered by the section, false otherwise.
+ */
+bool section_covers_region_addr(const MemoryRegionSection *section,
+                                hwaddr region_addr);
+
+/**
+ * section_fuzz_dma_read: Wrapper for fuzz_dma_read_cb().
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @addr: The memory address to be fuzzed.
+ * @len: The length of the memory to fuzz.
+ *
+ * This function is a wrapper for fuzz_dma_read_cb().
+ */
+void section_fuzz_dma_read(MemoryRegionSection *section,
+                           hwaddr addr, hwaddr len);
+
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index 1162819c1080..c227d4680e33 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -321,6 +321,19 @@ static inline bool section_covers_addr(const MemoryRegionSection *section,
                              int128_getlo(section->size), addr);
 }
 
+bool section_covers_region_addr(const MemoryRegionSection *section,
+                                hwaddr region_addr)
+{
+    return section->offset_within_region <= region_addr &&
+           section->offset_within_region + int128_get64(section->size) >= region_addr;
+}
+
+void section_fuzz_dma_read(MemoryRegionSection *section,
+                           hwaddr addr, hwaddr len)
+{
+    fuzz_dma_read_cb(addr, len, section->mr);
+}
+
 static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
 {
     PhysPageEntry lp = d->phys_map, *p;
@@ -3236,6 +3249,13 @@ static bool memory_region_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
     return false;
 }
 
+bool section_access_allowed(MemoryRegionSection *section,
+                            MemTxAttrs attrs, hwaddr addr,
+                            hwaddr len)
+{
+    return memory_region_access_allowed(section->mr, attrs, addr, len);
+}
+
 static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
                                                 const uint8_t *buf,
                                                 hwaddr len, hwaddr mr_addr,
-- 
2.34.1


