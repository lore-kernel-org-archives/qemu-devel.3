Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8BAC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzTD-0004yN-RC; Thu, 07 Aug 2025 08:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSP-0004ES-46; Thu, 07 Aug 2025 08:10:53 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSN-0005Cn-0B; Thu, 07 Aug 2025 08:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568651; x=1786104651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YO4ppsApMppmvSjO1TZkcO3ACCoVl7NKzejbdkLlymk=;
 b=BNggH4HZLYdV3gCOHmA1ZNCcsU0gb1IFJDWqggeMv96IOfJMwYvc25Kx
 V3fr/mx8MT5ZVQ75CeQ/pF4y1Z/CuNQ8vcU88FOJNwVt4rH7DHhyCIeGz
 RFamCEGxlH8AvmAO7RF13VbowBKbOYN+aY8wVPJum5amBwNJsKDQpn4gU
 EQxQGSWuQk/rz8K8JXfxEtQJ7bK+pMjE1283JdOb6p0S9LVaWtVb3J37+
 6J0BGj1OOpIXgz3rfQ67UbmVXeEAdY0qL7ugNqG/jaRPyuM0/15vGEr6C
 JQ6z57gKoH7AEzi469RqU6zu7aZFFgI67giAXjfns8iYRNwIF/uOqDGCE g==;
X-CSE-ConnectionGUID: /QATM6S7Re2vBUZh1vZbpw==
X-CSE-MsgGUID: rTO61MxoTBmfFxb3/Ia+tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036906"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:26 -0700
X-CSE-ConnectionGUID: QnB0AqLoTyOiW+nlg5knlw==
X-CSE-MsgGUID: SGplsYhWTzKtdQ0BoEubNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701368"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:24 -0700
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
Subject: [RFC 25/26] rust/memory: Add binding to check target endian
Date: Thu,  7 Aug 2025 20:30:26 +0800
Message-Id: <20250807123027.2910950-26-zhao1.liu@intel.com>
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

Add a binding (target_is_big_endian()) to check whether target is big
endian or not. This could help user to adjust endian before calling
AddresssSpace::store() or after calling AddressSpace::load().

Add the example in the documentation of AddresssSpace::store() to help
explain how to use it.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/memory.rs | 28 +++++++++++++++++++++++++---
 rust/qemu-api/wrapper.h     |  1 +
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 42bba23cf3f8..a8eb83c95ead 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -31,7 +31,7 @@
         memory_region_init_io, section_access_allowed, section_covers_region_addr,
         section_fuzz_dma_read, section_get_host_addr, section_rust_load,
         section_rust_read_continue_step, section_rust_store, section_rust_write_continue_step,
-        MEMTX_OK,
+        target_big_endian, MEMTX_OK,
     },
     callbacks::FnCall,
     cell::Opaque,
@@ -1107,9 +1107,25 @@ pub fn read(&self, buf: &mut [u8], addr: GuestAddress) -> Result<usize> {
     /// This function is similar to `address_space_st{size}` in C side.
     ///
     /// But it only assumes @val follows target-endian by default. So ensure
-    /// the endian of `val` aligned with target, before using this method.
+    /// the endian of `val` aligned with target, before using this method.  The
+    /// taget-endian can be checked with [`target_is_big_endian`].
     ///
     /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use qemu_api::memory::{ADDRESS_SPACE_MEMORY, target_is_big_endian};
+    ///
+    /// let addr = GuestAddress(0x123438000);
+    /// let val: u32 = 5;
+    /// let val_end = if target_is_big_endian() {
+    ///     val.to_be()
+    /// } else {
+    ///     val.to_le()
+    /// }
+    ///
+    /// assert!(ADDRESS_SPACE_MEMORY.store(addr, val_end).is_ok());
     pub fn store<T: AtomicAccess>(&self, addr: GuestAddress, val: T) -> Result<()> {
         rcu_read_lock();
         let r = self.memory().deref().store(val, addr, Ordering::Relaxed);
@@ -1122,7 +1138,8 @@ pub fn store<T: AtomicAccess>(&self, addr: GuestAddress, val: T) -> Result<()> {
     /// This function is similar to `address_space_ld{size}` in C side.
     ///
     /// But it only support target-endian by default.  The returned value is
-    /// with target-endian.
+    /// with target-endian.  The taget-endian can be checked with
+    /// [`target_is_big_endian`].
     ///
     /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
     pub fn load<T: AtomicAccess>(&self, addr: GuestAddress) -> Result<T> {
@@ -1147,3 +1164,8 @@ pub fn load<T: AtomicAccess>(&self, addr: GuestAddress) -> Result<T> {
     // the whole QEMU life.
     &*wrapper_ptr
 };
+
+pub fn target_is_big_endian() -> bool {
+    // SAFETY: the return value is boolean, so it is always valid.
+    unsafe { target_big_endian() }
+}
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index ce0ac8d3f550..c466b93054aa 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -70,3 +70,4 @@ typedef enum memory_order {
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
 #include "qemu/rcu.h"
+#include "qemu/target-info.h"
-- 
2.34.1


