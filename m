Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F09DC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSD-0003Op-6F; Thu, 07 Aug 2025 08:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRs-0001eY-Mk; Thu, 07 Aug 2025 08:10:22 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRm-0005Bt-Nt; Thu, 07 Aug 2025 08:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568615; x=1786104615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lwh8w+q9CSmEJR/ei3K4JNynEwIGGgyYzFZQuK/O5nE=;
 b=LdKDLef9XNYlX8qeXbQMbubjWxxWQJcY+CwP6uSFBLiH+LNlK8NI3FwO
 ShMtCxq+TJBINDkRMD80HsES0XzNCOqML2PuY5xCmJuvONImHuqfWj6CT
 055moh/cx4u3mPbJap2VPvDvaiAWtGklX1taH8b9BPgwitezVBeclxYZ1
 KYeQz+JI6rABIJDTVPDItjOjr6Z7nG9hXcomWQZZRzmZj51h+CJILATWY
 VTYYZMDr0lGmJnIamfGCjjCKo42mA3HECKHtP6q0nOYhZFqz09gSJVBqs
 izI+p1ksZQ5ruKQ/LCzXfbjEDVt56TytYJN5o3WDPikWphEkYOXRCMFXe Q==;
X-CSE-ConnectionGUID: c+Fz7rzYRAOObsqoIUeoXg==
X-CSE-MsgGUID: OQw3OYUnRR24HGYGZGr/lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036821"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:51 -0700
X-CSE-ConnectionGUID: nCwM6eKXQM+X0rYM57TvaQ==
X-CSE-MsgGUID: OlQm2mK/RMOfq0vBSrb09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701139"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:49 -0700
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
Subject: [RFC 15/26] memory: Rename address_space_lookup_region and expose it
 to Rust side
Date: Thu,  7 Aug 2025 20:30:16 +0800
Message-Id: <20250807123027.2910950-16-zhao1.liu@intel.com>
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

address_space_lookup_region() retures the pointer to
MemoryRegionSection, instead of MemoryRegion, so it's better to rename
it to address_space_lookup_section().

And add its declaration to memory.h so that bindgen could generate its
binding.

This interface will be used to implement GuestMemory::find_region() of
vm_memory crate.

In addition, add its documentation in memory.h.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 21 +++++++++++++++++++++
 system/physmem.c        |  8 ++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 4b9a2f528d86..f492e1fc78bf 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1203,6 +1203,27 @@ struct FlatView {
     MemoryRegion *root;
 };
 
+/**
+ * address_space_lookup_section: Find the MemoryRegionSection by a
+ * given #AddressSpaceDispatch.
+ *
+ * @d: The AddressSpaceDispatch to search within.
+ * @addr: The address to look up.
+ * @resolve_subpage: If 'true', resolve to a subpage section if the
+ * region is a subpage container.
+ *
+ * This function translates a address (@addr) into its corresponding
+ * #MemoryRegionSection within a given address space dispatch (@d).
+ * Called within RCU critical section.
+ *
+ * Returns:
+ * A pointer to the #MemoryRegionSection. If the address is not
+ * mapped, this will be a pointer to the 'unassigned' section.
+ */
+MemoryRegionSection *address_space_lookup_section(AddressSpaceDispatch *d,
+                                                  hwaddr addr,
+                                                  bool resolve_subpage);
+
 /**
  * address_space_to_flatview: Get a transient RCU-protected pointer to
  * the current FlatView.
diff --git a/system/physmem.c b/system/physmem.c
index e5dd760e0bca..785c9a4050c6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -341,9 +341,9 @@ static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
 }
 
 /* Called from RCU critical section */
-static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
-                                                        hwaddr addr,
-                                                        bool resolve_subpage)
+MemoryRegionSection *address_space_lookup_section(AddressSpaceDispatch *d,
+                                                  hwaddr addr,
+                                                  bool resolve_subpage)
 {
     MemoryRegionSection *section = qatomic_read(&d->mru_section);
     subpage_t *subpage;
@@ -369,7 +369,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
     MemoryRegion *mr;
     Int128 diff;
 
-    section = address_space_lookup_region(d, addr, resolve_subpage);
+    section = address_space_lookup_section(d, addr, resolve_subpage);
     /* Compute offset within MemoryRegionSection */
     addr -= section->offset_within_address_space;
 
-- 
2.34.1


