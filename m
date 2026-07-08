Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEE9C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwF-0004bw-OU; Wed, 08 Jul 2026 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwC-0004V3-Vq; Wed, 08 Jul 2026 03:43:21 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwB-0004ox-50; Wed, 08 Jul 2026 03:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496599; x=1815032599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xS9j1SfbNnXEP53X/50BOi4BX5IanNXaJwbdx5fCkPY=;
 b=HRiCazY5ExS8t0Rx5/MoUJtjeiJ+lcoUbTpn+j1Lua71xLVpnAfOSHVb
 +fSFO1BVt9wrlTzhH454DuwlHA0cEf1j2OaZMpoXy4SvVjDO0CTNmatf+
 IihEbSy0/b1yqFe4/miVzt+hxh/bqIHctyNrAmUP5xEMNhLrBgq9/bovU
 34GWpWZ1HA4cAQsF9ulhCbA/qijZ7H/SIsfaBC37Vhsyi70Bq+9moTWzE
 uudWLsujI8qTIIHPQ3RCV6mycoTZVy17jbRzQ7gFzxdJDMlelHzvkkLWE
 xFlcsluSp61DGxsAKpKXVRtZDzRiZqFEAPW6Kl+YNEv2+Ux/USvW9FkCv Q==;
X-CSE-ConnectionGUID: 77VtcnMiS+WesUYxn2sf8Q==
X-CSE-MsgGUID: SSQjaL7XQCSf+KJy6JNX+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343336"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343336"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:18 -0700
X-CSE-ConnectionGUID: m4NFgrQ4S86ij/sjZxG2Bw==
X-CSE-MsgGUID: 0LLKhp6SReWv1r2rRw7shg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555998"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:14 -0700
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
Subject: [RFC v2 13/26] memory: Add a translation helper to return a
 MemoryRegionSection
Date: Wed,  8 Jul 2026 16:10:39 +0800
Message-Id: <20260708081052.2276617-14-zhao1.liu@intel.com>
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

The Rust side will rely on MemoryRegionSection to organize non-overlapping
memory "region" abstractions. Therefore, it is necessary to provide a
translation helper variant that returns a MemoryRegionSection directly.

Additionally, refine and complete the documentation for the translation
helpers.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 76 +++++++++++++++++++++++++++++++++++------
 system/physmem.c        | 22 +++++++++---
 2 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index c32e3d01f825..7e64a39662be 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2609,24 +2609,80 @@ void address_space_flush_icache_range(AddressSpace *as,
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs);
 
-/* address_space_translate: translate an address range into an address space
- * into a MemoryRegion and an address range into that section.  Should be
- * called from an RCU critical section, to avoid that the last reference
- * to the returned region disappears after address_space_translate returns.
+/**
+ * flatview_translate_section: Translate a guest physical address range
+ * to the corresponding #MemoryRegionSection in a FlatView.
  *
- * @fv: #FlatView to be accessed
- * @addr: address within that address space
- * @xlat: pointer to address within the returned memory region section's
+ * Must be called within an RCU critical section to prevent the last
+ * reference to the memory region (referenced by the returned section)
+ * from disappearing after the function returns.
+ *
+ * @fv: The FlatView to be accessed.
+ * @addr: The address to be translated within the given FlatView.
+ * @xlat: The translated address offset within the returned section's
  * #MemoryRegion.
- * @len: pointer to length
- * @is_write: indicates the transfer direction
- * @attrs: memory attributes
+ * @len: Pointer to the length. On return, this will be updated to the
+ * valid read/write length of the translated address range.
+ * @is_write: Indicates the transfer direction.
+ * @attrs: Memory attributes.
+ *
+ * Returns:
+ * The #MemoryRegionSection that contains the translated address.
+ */
+MemoryRegionSection *flatview_translate_section(FlatView *fv, hwaddr addr,
+                                                hwaddr *xlat, hwaddr *len,
+                                                bool is_write, MemTxAttrs attrs);
+
+/**
+ * flatview_translate: Translate a guest physical address range
+ * to the corresponding #MemoryRegionSection in a FlatView.
+ *
+ * Must be called within an RCU critical section to prevent the last
+ * reference to the returned memory region from disappearing after
+ * the function returns.
+ *
+ * This function is a variant of flatview_translate_section(), with the
+ * difference that it returns the #MemoryRegion contained in the
+ * #MemoryRegionSection.
+ *
+ * @fv: The FlatView to be accessed.
+ * @addr: The address to be translated within the given FlatView.
+ * @xlat: The translated address offset within the returned #MemoryRegion.
+ * @len: Pointer to the length. On return, this will be updated to the
+ * valid read/write length of the translated address range.
+ * @is_write: Indicates whether the translation operation is for a write.
+ * @attrs: Memory transaction attributes.
+ *
+ * Returns:
+ * The #MemoryRegion that contains the translated address.
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
                                  hwaddr *len, bool is_write,
                                  MemTxAttrs attrs);
 
+/**
+ * address_space_translate: Translate a guest physical address range
+ * to the corresponding #MemoryRegionSection in a FlatView.
+ *
+ * Must be called within an RCU critical section to prevent the last
+ * reference to the returned memory region from disappearing after
+ * the function returns.
+ *
+ * This function is a variant of flatview_translate(), with the difference
+ * that it operates on an #AddressSpace rather than a #FlatView directly.
+ *
+ * @as: The #AddressSpace to be accessed.
+ * @addr: The address to be translated within the given address space.
+ * @xlat: The translated address offset within the returned #MemoryRegion.
+ * @len: Pointer to the length. On return, this will be updated to the
+ * valid read/write length of the translated address range.
+ * @is_write: Indicates whether the translation operation is for a write.
+ * @attrs: Memory transaction attributes.
+ *
+ * Returns:
+ * The #MemoryRegion that contains the translated address.
+ */
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
                                                     hwaddr *len, bool is_write,
diff --git a/system/physmem.c b/system/physmem.c
index 418fc79ff2c0..ff60ac7dd3aa 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -560,9 +560,9 @@ iotlb_fail:
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
@@ -580,7 +580,21 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
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


