Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51135C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwF-0004Zv-H7; Wed, 08 Jul 2026 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMw4-0004EG-Ex; Wed, 08 Jul 2026 03:43:12 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMw2-0004ox-MV; Wed, 08 Jul 2026 03:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496591; x=1815032591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VqnZQ7CrTJfaaaMOjcDnDIF8dHHxULpFm1eDfe3uLj0=;
 b=hnbn2/hvlVjLPpDz888/TVOW+Ui/GTjgcMWTrt6uz+Rb8lFrjxwvwr9c
 XsZenwrpg9QGeqZ2zKc1BfSAZsJVG624pOs3K3VNopFqe+cRUaOae8MVx
 IE/yOifTJtbjPA3cqllRJjM/sFGu17PGXmfyg05fCSBVvNfAUKiCC/KeL
 OH94t8WYI2QvedQlzagYx28eETlNkx7iLk+LAgJRWNljCx02d3FxtGPnG
 RV4nWwV4OGziijaAmUDRilZ78TTdXome0n7lLQP/2QNDLqqyQJ/kzZf0x
 3lAjGjmTrDGtgkYJvFjWEp4Uol+gVXZOeJRQYfO/oD3+dcHFBF6zk0pvc w==;
X-CSE-ConnectionGUID: 25jVDygBSKGGRK6xH06J2A==
X-CSE-MsgGUID: WHDB7P+8QyuvolWQrxQdHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343314"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343314"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:10 -0700
X-CSE-ConnectionGUID: MOHvCCgVQr2b9OFdD1gm8A==
X-CSE-MsgGUID: MiiSwpXuReeZtFi26cnlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555978"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:05 -0700
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
Subject: [RFC v2 11/26] memory: Rename address_space_lookup_region and expose
 it to Rust
Date: Wed,  8 Jul 2026 16:10:37 +0800
Message-Id: <20260708081052.2276617-12-zhao1.liu@intel.com>
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

address_space_lookup_region() returns a pointer to a
MemoryRegionSection instead of a MemoryRegion. Therefore, rename
it to address_space_lookup_section().

Add its declaration to memory.h so that bindgen can generate
bindings for it.

This interface will be used to implement GuestMemory::find_region()
in the vm_memory crate.

In addition, add its documentation in memory.h.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 21 +++++++++++++++++++++
 system/physmem.c        |  8 ++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index bf5bfa7164fb..c32e3d01f825 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -948,6 +948,27 @@ static inline FlatView *address_space_to_flatview(const AddressSpace *as)
     return qatomic_rcu_read(&as->current_map);
 }
 
+/**
+ * address_space_lookup_section: Find the MemoryRegionSection within a
+ * given #AddressSpaceDispatch.
+ *
+ * @d: The AddressSpaceDispatch to search within.
+ * @addr: The address to look up.
+ * @resolve_subpage: If 'true', resolve to a subpage section if the
+ * region is a subpage container.
+ *
+ * This function translates an address (@addr) into its corresponding
+ * #MemoryRegionSection within a given address space dispatch (@d).
+ * Must be called within an RCU critical section.
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
  * flatview_ref: Atomically increment the reference count of a #FlatView.
  *
diff --git a/system/physmem.c b/system/physmem.c
index c21ea929153e..f807e60aa348 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -342,9 +342,9 @@ static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
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
@@ -370,7 +370,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
     MemoryRegion *mr;
     Int128 diff;
 
-    section = address_space_lookup_region(d, addr, resolve_subpage);
+    section = address_space_lookup_section(d, addr, resolve_subpage);
     /* Compute offset within MemoryRegionSection */
     addr -= section->offset_within_address_space;
 
-- 
2.34.1


