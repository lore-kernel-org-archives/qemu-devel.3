Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F06C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSM-0003x9-B6; Thu, 07 Aug 2025 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRt-0001fL-8z; Thu, 07 Aug 2025 08:10:22 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRp-0005Bp-4w; Thu, 07 Aug 2025 08:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568617; x=1786104617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3KxZHVVpZuvJRzJPVQgu9JT9Tqo8Scg+uw8X4qt5Us8=;
 b=D02IezYPQpoGui1bH8Ekm/y8ERe9bnSc38/98GvBklJWBdZAEQOcx7kl
 jDRg+p/DliN0wkcZ99YECl7ZKZbZ0QFmQenoeungJsepOZ8XM1d44dfVo
 sWcljCp6D7C2MN+pnnv2XuE8ZYCogp1sgPrqCeeEGgqmzTiNyCPdbkH/F
 YATSQeuOe1P8kfu7qLsZ8/xf68IKAJEPIpj07uqMn4b0vflLPRczLFURE
 PhtvHyYjbemuxyTKqefgHAJixd3MNeubsdNKstks4wRUhN+R8vpYoBGqN
 mmdHj7Ih0HfmCsmbGj+5AA99VPjQRbV0ymZ0BLIQ9sfrtYscfpWy9zxoP g==;
X-CSE-ConnectionGUID: bBojlb6cSua20FBbUrvs2A==
X-CSE-MsgGUID: 2O2R87YoRKaNafY6b/VOng==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036835"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:58 -0700
X-CSE-ConnectionGUID: xZXWfzx2QHifLiRELRwPMg==
X-CSE-MsgGUID: RIi14K4UTd+HVPuuV1JsHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701146"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:55 -0700
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
Subject: [RFC 17/26] memory: Add a translation helper to return
 MemoryRegionSection
Date: Thu,  7 Aug 2025 20:30:18 +0800
Message-Id: <20250807123027.2910950-18-zhao1.liu@intel.com>
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

Rust side will based on MemoryRegionSection to origanize non-overlapping
memory "region" abstractions. So it's necessary to provide a translation
variant helper to return the MemoryRegionSection directly.

Additionally, refine and complete the documentations for translation
helpers.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 68 +++++++++++++++++++++++++++++++++++------
 system/physmem.c        | 22 ++++++++++---
 2 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index f492e1fc78bf..eab69e15e10f 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3053,24 +3053,74 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs);
 
-/* address_space_translate: translate an address range into an address space
- * into a MemoryRegion and an address range into that section.  Should be
+/**
+ * flatview_translate_section: translate an guest physical address range
+ * to the corresponding MemoryRegionSection in Flatview. Should be
  * called from an RCU critical section, to avoid that the last reference
- * to the returned region disappears after address_space_translate returns.
- *
- * @fv: #FlatView to be accessed
- * @addr: address within that address space
- * @xlat: pointer to address within the returned memory region section's
- * #MemoryRegion.
- * @len: pointer to length
+ * to the memory region (pointed by returned section) disappears after
+ * flatview_translate_section returns.
+ *
+ * @fv: the flat view to be accessed.
+ * @addr: the address to be translated in above address space.
+ * @xlat: the translated address offset within the returned section's
+ *        #MemoryRegion.
+ * @len: pointer to length, and it will be changed to valid read/write
+ *       length of the translated address after this function returns.
  * @is_write: indicates the transfer direction
  * @attrs: memory attributes
+ *
+ * Returns:
+ * The #MemoryRegionSection that contains the translated address
+ */
+MemoryRegionSection *flatview_translate_section(FlatView *fv, hwaddr addr,
+                                                hwaddr *xlat, hwaddr *len,
+                                                bool is_write, MemTxAttrs attrs);
+
+/**
+ * flatview_translate: translate an guest physical address range
+ * to the corresponding MemoryRegionSection in Flatview. Should be
+ * called from an RCU critical section, to avoid that the last reference
+ * to the returned memory region disappears after flatview_translate
+ * returns.
+ *
+ * This function is the variant of flatview_translate_section(), with the
+ * difference that it returns the MemoryRegion contained in the
+ * MemoryRegionSection.
+ *
+ * @fv: the flat view to be accessed.
+ * @addr: the address to be translated in above address space.
+ * @xlat: the translated address offset within memory region.
+ * @len: pointer to length, and it will be changed to valid read/write
+ *       length of the translated address after this function returns.
+ * @is_write: whether the translation operation is for write.
+ * @attrs: memory transaction attributes.
+ *
+ * Returns:
+ * The #MemoryRegion that contains the translated address.
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
                                  hwaddr *len, bool is_write,
                                  MemTxAttrs attrs);
 
+/**
+ * address_space_translate: translate an guest physical address range
+ * to the corresponding MemoryRegionSection in Flatview. Should be
+ * called from an RCU critical section, to avoid that the last reference
+ * to the returned memory region disappears after flatview_translate
+ * returns.
+ *
+ * This function is the variant of flatview_translate(), with the difference
+ * that it accesses the AddressSpace which contains FlatView.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: the address to be translated in above address space.
+ * @xlat: the translated address offset within memory region.
+ * @len: pointer to length, and it will be changed to valid read/write
+ *       length of the translated address after this function returns.
+ * @is_write: whether the translation operation is for write.
+ * @attrs: memory transaction attributes.
+ */
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
                                                     hwaddr *len, bool is_write,
diff --git a/system/physmem.c b/system/physmem.c
index 4af29ea2168e..d2106d0ffa87 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -559,9 +559,9 @@ iotlb_fail:
 }
 
 /* Called from RCU critical section */
-MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool is_write,
-                                 MemTxAttrs attrs)
+MemoryRegionSection *flatview_translate_section(FlatView *fv, hwaddr addr,
+                                                hwaddr *xlat, hwaddr *plen,
+                                                bool is_write, MemTxAttrs attrs)
 {
     MemoryRegion *mr;
     MemoryRegionSection *section;
@@ -577,7 +577,21 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
         *plen = MIN(page, *plen);
     }
 
-    return mr;
+    return section;
+}
+
+/* Called from RCU critical section */
+MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
+                                 hwaddr *plen, bool is_write,
+                                 MemTxAttrs attrs)
+{
+    MemoryRegionSection *section;
+
+    /* This can be MMIO, so setup MMIO bit. */
+    section = flatview_translate_section(fv, addr, xlat, plen,
+                                         is_write, attrs);
+
+    return section->mr;
 }
 
 #ifdef CONFIG_TCG
-- 
2.34.1


