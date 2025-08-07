Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58933C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSV-0004XC-GJ; Thu, 07 Aug 2025 08:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSM-00045N-3F; Thu, 07 Aug 2025 08:10:50 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSI-0005Bt-3m; Thu, 07 Aug 2025 08:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568646; x=1786104646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L9/7AiV5IeaaNeK7AehXkGkn2BxB38AEIVLuEzucq1A=;
 b=Cfmp4LFTD9KVyFU7xMN1Rkyoza4ECjrTWS02T8LXk0aKvO1hw7u2KY60
 gkmmuKzkQPQMCgh4o6Q2uUnltw2p4mugWmZYwgwRYxMREcNIyscFSHcvf
 N5HLCxZI7bOcC3s6Kw5BZ4otI5mSdq0fxEcXVWtha7ygx31VrfyxE/tg1
 7oC7r0iLWf7VhSzAvNK63Du/tEaG0y5UbScpDbolZ36zmsQbXPA2jaSux
 adSK0VyCj7h4LMynypuHnlmGDNzQBGbAhRAjybBTc5lcVn0uRGnWhb0ks
 3/NlJxFiI5v5aqZ9mYFvubwPoNeX4jtHnHcKVXm3ZRjRU1yo1aVjklJs0 Q==;
X-CSE-ConnectionGUID: Sz959LUfTnmU1lv9P/E6Vw==
X-CSE-MsgGUID: JS20heUoQRuvmLt6EdvoHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036870"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036870"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:12 -0700
X-CSE-ConnectionGUID: P4ljDsr3TpGdx0ODypJrZw==
X-CSE-MsgGUID: Tlh/sA68TKigewNTOtyX/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701226"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:09 -0700
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
Subject: [RFC 21/26] memory: Add store/load interfaces for Rust side
Date: Thu,  7 Aug 2025 20:30:22 +0800
Message-Id: <20250807123027.2910950-22-zhao1.liu@intel.com>
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

At present, there're many store/load variants defined in
memory_ldst.c.inc.

However, the Bytes::store() and Bytes::load() of vm-memory are bound
with AtomicAccess trait, which makes it (almost) impossible to select
proper interface (for l, w or q) based on specific type.

So it's necessary to provide such interfaces that hide the type details
as much as possible. And compared with address_space_st{size} or
address_space_ld{size}, the differences include:

 * No translation, and only memory access.

 * Only support native endian. Then Rust side must handle the endian
   format before/after processing store()/load().

 * Use bytes array instead of single uint64_t for the value to be
   written or read. Then Rust side doesn't need to convert generic type
   to u64.

   - But the extra cost is that there's the need for conversation
     between bytes array and uint64_t inside the interfaces.

 * Do not handle the cross-region case via MMIO access. Then Rust side
   will handle such abnormal cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h | 52 +++++++++++++++++++++++++++++++--
 system/physmem.c        | 65 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index a75c8c348f58..f0f51f1c4c89 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3440,7 +3440,7 @@ MemTxResult section_rust_write_continue_step(MemoryRegionSection *section,
     MemTxAttrs attrs, const uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
 
 /**
- * section_read_continue_step: read from #MemoryRegionSection.
+ * section_rust_read_continue_step: read from #MemoryRegionSection.
  *
  * Not: This function should only used by Rust side, and user shouldn't
  * call it directly!
@@ -3461,9 +3461,57 @@ MemTxResult section_rust_write_continue_step(MemoryRegionSection *section,
  * Return a MemTxResult indicating whether the operation succeeded
  * or failed.
  */
-MemTxResult section_read_continue_step(MemoryRegionSection *section,
+MemTxResult section_rust_read_continue_step(MemoryRegionSection *section,
     MemTxAttrs attrs, uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
 
+/**
+ * section_rust_store: store data to #MemoryRegionSection.
+ *
+ * Not: This function should only used by Rust side, and user shouldn't
+ * call it directly!
+ *
+ * This function provides a wrapper for address_space_st{size} without
+ * translation, and only supports native endian by default.
+ *
+ * Should be called from an RCU critical section.
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @mr_offset: address within that memory region.
+ * @buf: buffer to be written.
+ * @attrs: memory transaction attributes.
+ * @len: the number of bytes is expected to read.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed.
+ */
+MemTxResult section_rust_store(MemoryRegionSection *section,
+                               hwaddr mr_offset, const uint8_t *buf,
+                               MemTxAttrs attrs, hwaddr len);
+
+/**
+ * section_rust_load: load data from #MemoryRegionSection.
+ *
+ * Not: This function should only used by Rust side, and user shouldn't
+ * call it directly!
+ *
+ * This function provides a wrapper for address_space_st{size} without
+ * translation, and only supports native endian by default.
+ *
+ * Should be called from an RCU critical section.
+ *
+ * @section: #MemoryRegionSection to be accessed.
+ * @mr_offset: address within that memory region.
+ * @buf: buffer to be written.
+ * @attrs: memory transaction attributes.
+ * @len: the number of bytes is expected to read.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed.
+ */
+MemTxResult section_rust_load(MemoryRegionSection *section,
+                              hwaddr mr_offset, uint8_t *buf,
+                              MemTxAttrs attrs, hwaddr len);
+
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
diff --git a/system/physmem.c b/system/physmem.c
index 0c30dea775ca..6048d5faac8c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3120,9 +3120,9 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
 }
 
 MemTxResult
-section_read_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
-                           uint8_t *buf, hwaddr len, hwaddr mr_addr,
-                           hwaddr *l)
+section_rust_read_continue_step(MemoryRegionSection *section, MemTxAttrs attrs,
+                                uint8_t *buf, hwaddr len, hwaddr mr_addr,
+                                hwaddr *l)
 {
     return flatview_read_continue_step(attrs, buf, len, mr_addr, l, section->mr);
 }
@@ -3239,6 +3239,65 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
                      buf, len, is_write);
 }
 
+MemTxResult section_rust_store(MemoryRegionSection *section,
+                               hwaddr mr_offset, const uint8_t *buf,
+                               MemTxAttrs attrs, hwaddr len)
+{
+    MemoryRegion *mr = section->mr;
+    MemTxResult r;
+    uint64_t val;
+
+    val = ldn_he_p(buf, len);
+    if (!memory_access_is_direct(mr, true, attrs)) {
+        bool release_lock = false;
+
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_write(mr, mr_offset, val,
+                                         size_memop(len) |
+                                         devend_memop(DEVICE_NATIVE_ENDIAN),
+                                         attrs);
+        if (release_lock) {
+            bql_unlock();
+        }
+    } else {
+        uint8_t *ptr = qemu_map_ram_ptr(mr->ram_block, mr_offset);
+        stn_p(ptr, len, val);
+        invalidate_and_set_dirty(mr, mr_offset, len);
+        r = MEMTX_OK;
+    }
+
+    return r;
+}
+
+MemTxResult section_rust_load(MemoryRegionSection *section,
+                              hwaddr mr_offset, uint8_t *buf,
+                              MemTxAttrs attrs, hwaddr len)
+{
+    MemoryRegion *mr = section->mr;
+    MemTxResult r;
+    uint64_t val;
+
+    if (!memory_access_is_direct(mr, false, attrs)) {
+        bool release_lock = false;
+
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                        size_memop(len) |
+                                        devend_memop(DEVICE_NATIVE_ENDIAN),
+                                        attrs);
+        if (release_lock) {
+            bql_unlock();
+        }
+    } else {
+        uint8_t *ptr = qemu_map_ram_ptr(mr->ram_block, mr_offset);
+        val = ldn_p(ptr, len);
+        r = MEMTX_OK;
+    }
+
+    stn_he_p(buf, len, val);
+    return r;
+}
+
 enum write_rom_type {
     WRITE_DATA,
     FLUSH_CACHE,
-- 
2.34.1


