Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B180C44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwu-0006hk-Om; Wed, 08 Jul 2026 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwq-0006Lt-6l; Wed, 08 Jul 2026 03:44:01 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwm-0005DU-Dt; Wed, 08 Jul 2026 03:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496637; x=1815032637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IkJHfJxKWBp8jmtuiaJL3EzwgLEqGklUHEndyr1MKuw=;
 b=dyRdp8LKToC2hQsTj5EvzF5bnkUrztoKRsYaOQ68NudoVS1dvrvW3YAn
 4Ne8HKYJlVkXMDG1zI9ap+PzbLL5Kpw2sjiY1TqbKv8KOGHH91IcpdUgQ
 VhGS2knNWmsEPTY94oV4rzQJP4CDQp1MR7TSScPJSf6dI41dx3QmJXrsc
 G7CljAthIq+RX2tdvzGBbKlm9ypFwSHy6K0fp9RHqxLCXEvpc7zX+dcz+
 K7LCbTnkJw3vMrICa5UYLRYk3L0/xcJJ//zz1/i2H0xozZTWYtAV8vO+r
 Zn58nDZXPnsyCDxW1qGT15gtN810bz9XYhpVHDKfoTdYhFRlLNWAuI4Va Q==;
X-CSE-ConnectionGUID: MI0DzOV+Q/6o4ANxBFBbDg==
X-CSE-MsgGUID: fwdTyf4TTqawtVNSinnfVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343371"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343371"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:35 -0700
X-CSE-ConnectionGUID: hAQfwuKERLSDatD6Xu35kA==
X-CSE-MsgGUID: og8XPJtdQceZHpvl6J5pkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556038"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:30 -0700
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
Subject: [RFC v2 17/26] memory: Add store/load interfaces for Rust
Date: Wed,  8 Jul 2026 16:10:43 +0800
Message-Id: <20260708081052.2276617-18-zhao1.liu@intel.com>
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

Currently, there are many store/load variants defined in
memory_ldst.c.inc.

However, the vm-memory crate's Bytes::store() and Bytes::load() methods
are bound by the AtomicAccess trait, making it almost impossible to
select  the proper interface (e.g., for l, w, or q) based on a specific
type.

Therefore, it is necessary to provide interfaces that hide these type
details as much as possible. Compared to the
address_space_st{size}_{endian} and address_space_ld{size}_{endian}
functions, the differences include:

 * No address translation; they only perform memory access.

 * They treat the byte array as raw bytes.  RAM accesses copy the bytes
   unchanged.  For MMIO accesses, the Rust caller must use the correct
   endian ordering for the target device (via LeNN/BeNN), just as the C
   side must select the appropriate address_space_st{size}_le() or _be()
   variants.

 * They use byte arrays instead of a single uint64_t for the value
   being written or read, eliminating the need for the Rust side to
   convert generic types to u64.
   - However, this incurs an extra cost for MMIO accesses, as it
     requires conversion between byte arrays and uint64_t internally.

 * They do not handle cross-region MMIO accesses. The Rust side will be
   responsible for handling such edge cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Drop the native endian assumption and require the caller to use the
   target device's endianness.
---
 include/system/memory.h | 50 ++++++++++++++++++++++++++++
 system/physmem.c        | 72 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 87006ce79d47..32399c111f48 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2970,6 +2970,56 @@ MemTxResult rust_section_write_continue_step(MemoryRegionSection *section,
 MemTxResult rust_section_read_continue_step(MemoryRegionSection *section,
     MemTxAttrs attrs, uint8_t *buf, hwaddr len, hwaddr mr_addr, hwaddr *l);
 
+/**
+ * rust_section_store: Store data to a #MemoryRegionSection.
+ *
+ * Note: This function should only be used by the Rust side, and callers
+ * should not invoke it directly!
+ *
+ * This function does a single-access store without translation. @buf provides
+ * raw bytes: RAM uses direct memory copy; MMIO expects data in device
+ * endianness.
+ *
+ * Must be called within an RCU critical section.
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @mr_offset: The address within that memory region.
+ * @buf: Buffer containing the data to be written.
+ * @attrs: Memory transaction attributes.
+ * @len: The number of bytes to write.
+ *
+ * Returns:
+ * A MemTxResult indicating whether the operation succeeded or failed.
+ */
+MemTxResult rust_section_store(MemoryRegionSection *section,
+                               hwaddr mr_offset, const uint8_t *buf,
+                               MemTxAttrs attrs, hwaddr len);
+
+/**
+ * rust_section_load: Load data from a #MemoryRegionSection.
+ *
+ * Note: This function should only be used by the Rust side, and callers
+ * should not invoke it directly!
+ *
+ * This function does a single-access load without translation. @buf receives
+ * raw bytes: RAM uses direct memory copy; MMIO returns data in device
+ * endianness.
+ *
+ * Must be called within an RCU critical section.
+ *
+ * @section: The #MemoryRegionSection to be accessed.
+ * @mr_offset: The address within that memory region.
+ * @buf: The output buffer to store the read data.
+ * @attrs: Memory transaction attributes.
+ * @len: The expected number of bytes to read.
+ *
+ * Returns:
+ * A MemTxResult indicating whether the operation succeeded or failed.
+ */
+MemTxResult rust_section_load(MemoryRegionSection *section,
+                              hwaddr mr_offset, uint8_t *buf,
+                              MemTxAttrs attrs, hwaddr len);
+
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index f19709be59e5..51abb6865b96 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3518,6 +3518,78 @@ void physical_memory_read(hwaddr addr, void *buf, hwaddr len)
                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
+MemTxResult rust_section_store(MemoryRegionSection *section,
+                               hwaddr mr_offset, const uint8_t *buf,
+                               MemTxAttrs attrs, hwaddr len)
+{
+    MemoryRegion *mr = section->mr;
+    MemTxResult r;
+
+    /*
+     * Rust encodes the requested endian order in @buf, via LeNN or BeNN.
+     *
+     * For RAM, store the bytes unchanged.
+     * For MMIO, @buf is read into a host-order temporary value, then
+     * adjust_endianness() converts it to the device's endianness later.
+     *
+     * Note that there is no guarantee that the endian order encoded by Rust
+     * will match the target device's endianness. Caller should use the right
+     * LeNN or BeNN.
+     */
+    if (!memory_access_is_direct(mr, true, attrs)) {
+        bool release_lock = false;
+        uint64_t val = ldn_he_p(buf, len);
+
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_write(mr, mr_offset, val,
+                                         size_memop(len), attrs);
+        if (release_lock) {
+            bql_unlock();
+        }
+    } else {
+        uint8_t *ptr = qemu_map_ram_ptr(mr->ram_block, mr_offset);
+
+        memcpy(ptr, buf, len);
+        invalidate_and_set_dirty(mr, mr_offset, len);
+        r = MEMTX_OK;
+    }
+
+    return r;
+}
+
+MemTxResult rust_section_load(MemoryRegionSection *section,
+                              hwaddr mr_offset, uint8_t *buf,
+                              MemTxAttrs attrs, hwaddr len)
+{
+    MemoryRegion *mr = section->mr;
+    MemTxResult r;
+
+    /*
+     * Similar to rust_section_store():
+     * For RAM, load the bytes unchanged, but for MMIO, it uses a host-order
+     * temporary value to help with conversion.
+     */
+    if (!memory_access_is_direct(mr, false, attrs)) {
+        bool release_lock = false;
+        uint64_t val;
+
+        release_lock |= prepare_mmio_access(mr);
+        r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                        size_memop(len), attrs);
+        stn_he_p(buf, len, val);
+        if (release_lock) {
+            bql_unlock();
+        }
+    } else {
+        uint8_t *ptr = qemu_map_ram_ptr(mr->ram_block, mr_offset);
+
+        memcpy(buf, ptr, len);
+        r = MEMTX_OK;
+    }
+
+    return r;
+}
+
 void physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
     address_space_write(&address_space_memory, addr,
-- 
2.34.1


