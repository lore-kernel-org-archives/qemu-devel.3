Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D4EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSA-0003DI-1L; Thu, 07 Aug 2025 08:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRy-0002HO-CL; Thu, 07 Aug 2025 08:10:26 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRv-0005Bp-6r; Thu, 07 Aug 2025 08:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568623; x=1786104623;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zfMJb0g3wXJyLqYM/+6g21n/rbDXZL8PB4EtRlUBfCI=;
 b=cjrPpsSq8SoJRt3DOpM7dreupnJUpeYWsnNXS1kI4oAwv8jf6sfAL55g
 nIjM0HKWmie6nQwm6qE2BLaxFXlGwJ97k6dlgAEtfTNtyJlpwtqVhKhpK
 ykVRkmED5Rt+J3VNzz+FwxdPVCj7gWMZpE0YMoZUsLQyAQogQJhDjg2vK
 DiY72oMO0i59sVUXQ1Yqd9bdNAAHvPuWY85z0vDcfn5fMIlesd81BqNq9
 ZZNgLx0yoZVkyY7nRqX9kBNMqESNxf5ymHVjBAblZY/wLmSjfOq68Kbgk
 nkhSSk75B0En7vEGQGVGgZzb1Wxy/6fU5XT8cle8KuJoSNQ6sMnTZ4vK9 g==;
X-CSE-ConnectionGUID: wo9g8YbnSM6/F6wDmYGlWg==
X-CSE-MsgGUID: GnXvD7CpRvyh78dCgjPo5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036846"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036846"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:05 -0700
X-CSE-ConnectionGUID: CufdCPrmTwSW55ApQmSRqA==
X-CSE-MsgGUID: RMGy/1g2TpKZrhebzThF1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701168"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:02 -0700
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
Subject: [RFC 19/26] memory: Add MemoryRegionSection based misc helpers
Date: Thu,  7 Aug 2025 20:30:20 +0800
Message-Id: <20250807123027.2910950-20-zhao1.liu@intel.com>
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

Add the following helpers:
 * section_access_allowed()
   - used to check access in GuestMemory::try_access().

 * section_covers_region_addr()
   - used to implement GuestMemoryRegion::check_address().

 * section_get_host_addr()
   - used to implement GuestMemoryRegion::get_host_address().

 * section_fuzz_dma_read()
   - used to insert fuzz hook before read/load.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 56 +++++++++++++++++++++++++++++++++++++++++
 system/physmem.c        | 30 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index eab69e15e10f..110ad0a3b590 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3357,6 +3357,62 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
+/**
+ * section_access_allowed
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @attrs: memory transaction attributes.
+ * @addr: address within that memory region.
+ * @len: the number of bytes to access.
+ *
+ * Check if a memory transaction is allowed.
+ *
+ * Returns: true if transaction is allowed, false if denied.
+ */
+bool section_access_allowed(MemoryRegionSection *section,
+                            MemTxAttrs attrs, hwaddr addr,
+                            hwaddr len);
+
+/**
+ * section_covers_region_addr
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @region_addr: memory region address within the region, which is
+ *               pointed by #MemoryRegionSection.
+ *
+ * Check if a region address is coverd by #MemoryRegionSection.
+ *
+ * Returns: true if transaction is allowed, false if denied.
+ */
+bool section_covers_region_addr(const MemoryRegionSection *section,
+                                hwaddr region_addr);
+
+/**
+ * section_get_host_addr
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @region_addr: memory region address within the region, which is
+ *               pointed by #MemoryRegionSection.
+ *
+ * Get the pointer to the host address.
+ *
+ * Returns: pointer to the host address.
+ */
+uint8_t *section_get_host_addr(const MemoryRegionSection *section,
+                               hwaddr region_addr);
+
+/**
+ * section_fuzz_dma_read
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @addr: memory address to be fuzzed.
+ * @len: length of the memory
+ *
+ * This function is wrapper of fuzz_dma_read_cb().
+ */
+void section_fuzz_dma_read(MemoryRegionSection *section,
+                           hwaddr addr, hwaddr len);
+
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
diff --git a/system/physmem.c b/system/physmem.c
index 8aaaab4d3a74..e06633f4d8a2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -320,6 +320,29 @@ static inline bool section_covers_addr(const MemoryRegionSection *section,
                              int128_getlo(section->size), addr);
 }
 
+bool section_covers_region_addr(const MemoryRegionSection *section,
+                                hwaddr region_addr)
+{
+    return section->offset_within_region <= region_addr &&
+           section->offset_within_region + int128_get64(section->size) >= region_addr;
+}
+
+uint8_t *section_get_host_addr(const MemoryRegionSection *section,
+                               hwaddr region_addr)
+{
+    MemoryRegion *mr = section->mr;
+    assert(mr && mr->ram_block);
+
+    return qemu_map_ram_ptr(mr->ram_block,
+                            section->offset_within_region + region_addr);
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
@@ -2947,6 +2970,13 @@ static bool memory_region_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
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


