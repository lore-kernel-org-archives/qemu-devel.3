Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534C0CA0EC1
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzTr-0005ah-8e; Thu, 07 Aug 2025 08:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSk-0004uY-0D; Thu, 07 Aug 2025 08:11:20 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSh-0005Bt-1z; Thu, 07 Aug 2025 08:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568671; x=1786104671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HwaA85D1ebnP7sljFlP5CUp7wIWrQyXh6BKaMqw9KoI=;
 b=kihwz4rJMDfrYbrit18HwOzmevgkwOQjdaP4tjAAE5lbpKUTLmWsflRJ
 TYr8uMkslv5BoCZ0rSFrbG/6alg5pMWamtEfe24avWDJK+uhE0kfJTQuM
 db3b8xBDr38Mc0NRpt3RN1JFksBpHL9qEwuPM9tSoAxz4qFoFuubDEX53
 UBMNPq53qDH9VxdWBRXU5ekjJSl9Hbr7DEPKTtfuUfNLPgh80SoNt+arC
 XPC90UfvEMSnB+ZoqiReFWwlfBed5cmZKJ4m5laYb0tT+zKrAo59GymP2
 yh2AB5/AueROiI7LvV/YcYUFpc8B6LyRdxgMtEcgXWX0yMiOym7XNRH1g A==;
X-CSE-ConnectionGUID: 8bU0UwcoTWK4N4KZJkQyVg==
X-CSE-MsgGUID: JCLYadVtR/yQ9SB/IxqXeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036895"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036895"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:23 -0700
X-CSE-ConnectionGUID: pBgUH1uQTTKW2pjrCZB+ow==
X-CSE-MsgGUID: sOW+MrKyTquBbfV7pekoFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701342"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:20 -0700
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
Subject: [RFC 24/26] rust/memory: Provide AddressSpace bindings
Date: Thu,  7 Aug 2025 20:30:25 +0800
Message-Id: <20250807123027.2910950-25-zhao1.liu@intel.com>
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

QEMU's AddressSpace matches vm_memory::GuestAddressSpace very well,
so it's straightforward to implement vm_memory::GuestAddressSpace trait
for AddressSpace structure.

And since QEMU's memory is almost entirely processed through
AddressSpace, provide the high-level memory write/read/store/load
interfaces for Rust side use.

Additionally, provide the safe binding for address_space_memory.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/memory.rs | 149 +++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 9 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 23347f35e5da..42bba23cf3f8 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs`
-//! `MemoryRegionSection` and `FlatView`.
+//! `MemoryRegionSection`, `FlatView` and `AddressSpace`.
 
 use std::{
     ffi::{c_uint, c_void, CStr, CString},
@@ -11,7 +11,7 @@
     marker::PhantomData,
     mem::size_of,
     ops::Deref,
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
     sync::atomic::Ordering,
 };
 
@@ -19,21 +19,25 @@
 pub use bindings::{hwaddr, MemTxAttrs};
 pub use vm_memory::GuestAddress;
 use vm_memory::{
-    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemory, GuestMemoryError, GuestMemoryRegion,
-    GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile, VolatileSlice, WriteVolatile,
+    bitmap::BS, Address, AtomicAccess, Bytes, GuestAddressSpace, GuestMemory, GuestMemoryError,
+    GuestMemoryRegion, GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile,
+    VolatileSlice, WriteVolatile,
 };
 
 use crate::{
     bindings::{
-        self, address_space_lookup_section, device_endian, flatview_ref,
-        flatview_translate_section, flatview_unref, memory_region_init_io, section_access_allowed,
-        section_covers_region_addr, section_fuzz_dma_read, section_get_host_addr,
-        section_rust_load, section_rust_read_continue_step, section_rust_store,
-        section_rust_write_continue_step, MEMTX_OK,
+        self, address_space_lookup_section, address_space_memory, address_space_to_flatview,
+        device_endian, flatview_ref, flatview_translate_section, flatview_unref,
+        memory_region_init_io, section_access_allowed, section_covers_region_addr,
+        section_fuzz_dma_read, section_get_host_addr, section_rust_load,
+        section_rust_read_continue_step, section_rust_store, section_rust_write_continue_step,
+        MEMTX_OK,
     },
     callbacks::FnCall,
     cell::Opaque,
+    error::{Error, Result},
     prelude::*,
+    rcu::{rcu_read_lock, rcu_read_unlock},
     uninit::MaybeUninitField,
     zeroable::Zeroable,
 };
@@ -1016,3 +1020,130 @@ fn clone(&self) -> Self {
         )
     }
 }
+
+/// A safe wrapper around [`bindings::AddressSpace`].
+///
+/// [`AddressSpace`] is the address space abstraction in QEMU, which
+/// provides memory access for the Guest memory it managed.
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct AddressSpace(Opaque<bindings::AddressSpace>);
+
+unsafe impl Send for AddressSpace {}
+unsafe impl Sync for AddressSpace {}
+
+impl GuestAddressSpace for AddressSpace {
+    type M = FlatView;
+    type T = FlatViewRefGuard;
+
+    /// Get the memory of the [`AddressSpace`].
+    ///
+    /// This function retrieves the [`FlatView`] for the current
+    /// [`AddressSpace`].  And it should be called from an RCU
+    /// critical section.  The returned [`FlatView`] is used for
+    /// short-term memory access.
+    ///
+    /// Note, this function method may **panic** if [`FlatView`] is
+    /// being distroying.  Fo this case, we should consider to providing
+    /// the more stable binding with [`bindings::address_space_get_flatview`].
+    fn memory(&self) -> Self::T {
+        let flatp = unsafe { address_space_to_flatview(self.0.as_mut_ptr()) };
+        FlatViewRefGuard::new(unsafe { Self::M::from_raw(flatp) }).expect(
+            "Failed to clone FlatViewRefGuard: the FlatView may have been destroyed concurrently.",
+        )
+    }
+}
+
+/// The helper to convert [`vm_memory::GuestMemoryError`] to
+/// [`crate::error::Error`].
+#[track_caller]
+fn guest_mem_err_to_qemu_err(err: GuestMemoryError) -> Error {
+    match err {
+        GuestMemoryError::InvalidGuestAddress(addr) => {
+            Error::from(format!("Invalid guest address: {:#x}", addr.raw_value()))
+        }
+        GuestMemoryError::InvalidBackendAddress => Error::from("Invalid backend memory address"),
+        GuestMemoryError::GuestAddressOverflow => {
+            Error::from("Guest address addition resulted in an overflow")
+        }
+        GuestMemoryError::CallbackOutOfRange => {
+            Error::from("Callback accessed memory out of range")
+        }
+        GuestMemoryError::IOError(io_err) => Error::with_error("Guest memory I/O error", io_err),
+        other_err => Error::with_error("An unexpected guest memory error occurred", other_err),
+    }
+}
+
+impl AddressSpace {
+    /// The write interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_write` in C side.
+    ///
+    /// But it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
+    pub fn write(&self, buf: &[u8], addr: GuestAddress) -> Result<usize> {
+        rcu_read_lock();
+        let r = self.memory().deref().write(buf, addr);
+        rcu_read_unlock();
+        r.map_err(guest_mem_err_to_qemu_err)
+    }
+
+    /// The read interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_read_full` in C side.
+    ///
+    /// But it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
+    ///
+    /// It should also be noted that this function does not support the fast
+    /// path like `address_space_read` in C side.
+    pub fn read(&self, buf: &mut [u8], addr: GuestAddress) -> Result<usize> {
+        rcu_read_lock();
+        let r = self.memory().deref().read(buf, addr);
+        rcu_read_unlock();
+        r.map_err(guest_mem_err_to_qemu_err)
+    }
+
+    /// The store interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_st{size}` in C side.
+    ///
+    /// But it only assumes @val follows target-endian by default. So ensure
+    /// the endian of `val` aligned with target, before using this method.
+    ///
+    /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
+    pub fn store<T: AtomicAccess>(&self, addr: GuestAddress, val: T) -> Result<()> {
+        rcu_read_lock();
+        let r = self.memory().deref().store(val, addr, Ordering::Relaxed);
+        rcu_read_unlock();
+        r.map_err(guest_mem_err_to_qemu_err)
+    }
+
+    /// The load interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_ld{size}` in C side.
+    ///
+    /// But it only support target-endian by default.  The returned value is
+    /// with target-endian.
+    ///
+    /// And it assumes the memory attributes is MEMTXATTRS_UNSPECIFIED.
+    pub fn load<T: AtomicAccess>(&self, addr: GuestAddress) -> Result<T> {
+        rcu_read_lock();
+        let r = self.memory().deref().load(addr, Ordering::Relaxed);
+        rcu_read_unlock();
+        r.map_err(guest_mem_err_to_qemu_err)
+    }
+}
+
+/// The safe binding around [`bindings::address_space_memory`].
+///
+/// `ADDRESS_SPACE_MEMORY` provides the complete address space
+/// abstraction for the whole Guest memory.
+pub static ADDRESS_SPACE_MEMORY: &AddressSpace = unsafe {
+    let ptr: *const bindings::AddressSpace = addr_of!(address_space_memory);
+
+    // SAFETY: AddressSpace is #[repr(transparent)].
+    let wrapper_ptr: *const AddressSpace = ptr.cast();
+
+    // SAFETY: `address_space_memory` structure is valid in C side during
+    // the whole QEMU life.
+    &*wrapper_ptr
+};
-- 
2.34.1


