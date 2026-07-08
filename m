Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1485CC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxP-0008Kn-GR; Wed, 08 Jul 2026 03:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxH-0007KM-Nd; Wed, 08 Jul 2026 03:44:28 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxE-0004ox-UL; Wed, 08 Jul 2026 03:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496665; x=1815032665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A/YjrgPMKQGrz/+7JdydAfbXQvs9uQxNrlFjhW1yjfs=;
 b=n8zqYF9B/u/P+PIkWQj8uYBFXfArEeZxNQq+8y0jUJqWzEUHCEU2jjOp
 a4bO9qzSuUjoK/sXbeXlqAPpUJvfIjBBzW02e2hHCKx/UQ0Na9DUpOz/W
 hyNTyeZruFUk66s+iYYe0NqVW4RUIAwK71GHwYRiUWIB93LTmvvitY/02
 PA2Dg+Otp1iIhT8WH45fWasacsUCMbfrGlhXEhezhwCbFsrPIMNHgiZmY
 T1oE8jWG6C2GYev2vWDN1WhbQ1jTRgn5zs4Y0UErXUM2v/kp0WUbtW6cH
 2XVvzMY7gW/hoTpeMfGwWq1Uy24BdIcDhul9f9LhyuYVbh7Hz3c2qVJyx w==;
X-CSE-ConnectionGUID: Ko5VpI8pR9mAwrqUvuvzKg==
X-CSE-MsgGUID: CXEmCtkdRu23qy5Z7iTrbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343439"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:44:00 -0700
X-CSE-ConnectionGUID: PaaqZfwoSNCsGDfNqCYt/w==
X-CSE-MsgGUID: yXTen9K1QxCNHzQmq0bflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556093"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:55 -0700
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
Subject: [RFC v2 23/26] rust/memory: Provide AddressSpace bindings
Date: Wed,  8 Jul 2026 16:10:49 +0800
Message-Id: <20260708081052.2276617-24-zhao1.liu@intel.com>
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

QEMU's AddressSpace matches vm_memory::GuestAddressSpace very well,
so it's straightforward to implement vm_memory::GuestAddressSpace trait
for &AddressSpace (not AddressSpace because GuestAddressSpace requires
Clone).

And since QEMU's memory is almost entirely processed through
AddressSpace, provide the high-level memory write/read/store/load
interfaces for Rust side use.

Additionally, provide the safe binding for address_space_memory.

Note, AddressSpace::read, write, load and store methods support
MEMTXATTRS_UNSPECIFIED by default, but it can support any MemTxAttrs.
When necessary, it's possible to add *_attrs variants.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Implement GuestAddressSpace for &AddressSpace since it requires
   Clone for now.
 * Re-implement RCU protection logic by using RcuCell and lifetime
   to provide RCU critical section.
 * Fix AddressSapce::memory() and use a loop just like C side did.
 * Explicitly require AddressSpace::save and load specify endianness
   and no longer rely on native endianness.
---
 rust/system/src/memory.rs | 205 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 196 insertions(+), 9 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index b16e71ddbf4e..83aff2907ad1 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -3,7 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs`
-//! `MemoryRegionSection` and `FlatView`.
+//! `MemoryRegionSection`, `FlatView` and `AddressSpace`.
 
 use std::{
     ffi::{c_uint, c_void, CStr, CString},
@@ -11,24 +11,28 @@
     marker::PhantomData,
     mem::size_of,
     ops::Deref,
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
     sync::atomic::Ordering,
 };
 
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::prelude::*;
+use util::{
+    error::Result,
+    rcu::{RcuCell, RcuGuard},
+};
 use vm_memory::{
-    bitmap::BS, Address, AtomicAccess, ByteValued, Bytes, GuestMemoryBackend, GuestMemoryError,
-    GuestMemoryRegion, GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize, MemoryRegionAddress,
-    Permissions, ReadVolatile, WriteVolatile,
+    bitmap::BS, Address, AtomicAccess, ByteValued, Bytes, GuestAddressSpace, GuestMemoryBackend,
+    GuestMemoryError, GuestMemoryRegion, GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize,
+    MemoryRegionAddress, Permissions, ReadVolatile, WriteVolatile,
 };
 pub use vm_memory::{Be16, Be32, Be64, GuestAddress, Le16, Le32, Le64};
 
 use crate::bindings::{
-    self, address_space_lookup_section, device_endian, flatview_ref, flatview_translate_section,
-    flatview_unref, memory_region_init_io, rust_section_load, rust_section_read_continue_step,
-    rust_section_store, rust_section_write_continue_step, section_access_allowed,
-    section_covers_region_addr, section_fuzz_dma_read, MemTxResult,
+    self, address_space_lookup_section, address_space_memory, device_endian, flatview_ref,
+    flatview_translate_section, flatview_unref, memory_region_init_io, rust_section_load,
+    rust_section_read_continue_step, rust_section_store, rust_section_write_continue_step,
+    section_access_allowed, section_covers_region_addr, section_fuzz_dma_read, MemTxResult,
 };
 // FIXME: Convert hwaddr to GuestAddress
 pub use crate::bindings::{hwaddr, MemTxAttrs};
@@ -1290,3 +1294,186 @@ fn from_carrier(carrier: Self::Carrier) -> Self {
     Le64 => u64,
     Be64 => u64,
 );
+
+/// A safe wrapper around [`bindings::AddressSpace`].
+///
+/// [`AddressSpace`] is the address space abstraction in QEMU, which
+/// provides memory access for the Guest memory it managed.
+#[repr(transparent)]
+#[derive(common::Wrapper)]
+pub struct AddressSpace(Opaque<bindings::AddressSpace>);
+
+unsafe impl Send for AddressSpace {}
+unsafe impl Sync for AddressSpace {}
+
+impl GuestAddressSpace for &AddressSpace {
+    type M = FlatView;
+    type T = FlatViewRefGuard;
+
+    /// Get the memory of the [`AddressSpace`].
+    ///
+    /// This function retrieves the [`FlatView`] for the current
+    /// [`AddressSpace`], similar to `address_space_get_flatview` on the C side.
+    fn memory(&self) -> Self::T {
+        let rcu = RcuGuard::new();
+        // Similar loop as `address_space_get_flatview` did.
+        loop {
+            // SAFETY: FlatViewRefGuard ensures the returned reference is protected by the
+            // guard.
+            if let Some(guard) = FlatViewRefGuard::new(unsafe { self.get_flatview(&rcu) }) {
+                return guard;
+            }
+        }
+    }
+}
+
+impl Deref for AddressSpace {
+    type Target = bindings::AddressSpace;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Opaque<> wraps a pointer from C side. The validity
+        // of the pointer is confirmed at the creation of Opaque<>.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl AddressSpace {
+    /// Helper function to get the [`FlatView`] of the current [`AddressSpace`]
+    /// without reference count protection.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the returned reference is protected by
+    /// reference count.
+    unsafe fn get_flatview<'g>(&self, rcu: &'g RcuGuard) -> &'g FlatView {
+        // SAFETY: `current_map` is an RCU-protected pointer field and any change is
+        // protected by the RCU mechanism.
+        let cell = unsafe { RcuCell::from_ptr(std::ptr::addr_of!(self.deref().current_map)) };
+        // SAFETY: the pointer is valid and not NULL.
+        unsafe { FlatView::from_raw(std::ptr::from_ref(cell.get(rcu).unwrap()).cast_mut()) }
+    }
+
+    /// The write interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_write` on the C side.
+    ///
+    /// But it assumes the memory attributes is `MEMTXATTRS_UNSPECIFIED`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use system::memory::{GuestAddress, ADDRESS_SPACE_MEMORY};
+    ///
+    /// let addr = GuestAddress(0x123123000);
+    /// let buf = [0x1, 0x2, 0x3, 0x4];
+    /// assert!(ADDRESS_SPACE_MEMORY.write(&buf, addr).is_ok());
+    /// ```
+    pub fn write(&self, buf: &[u8], addr: GuestAddress) -> Result<usize> {
+        Ok(Bytes::write(
+            &*self.memory(),
+            buf,
+            (addr, MEMTXATTRS_UNSPECIFIED),
+        )?)
+    }
+
+    /// The read interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_read_full` on the C side.
+    ///
+    /// But it assumes the memory attributes is `MEMTXATTRS_UNSPECIFIED`.
+    ///
+    /// Note: this function does not support the fast path like
+    /// `address_space_read` on the C side.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use system::memory::{GuestAddress, ADDRESS_SPACE_MEMORY};
+    ///
+    /// let addr = GuestAddress(0x123123000);
+    /// let mut buf = [0u8; 4];
+    /// assert!(ADDRESS_SPACE_MEMORY.read(&mut buf, addr).is_ok());
+    /// ```
+    pub fn read(&self, buf: &mut [u8], addr: GuestAddress) -> Result<usize> {
+        Ok(Bytes::read(
+            &*self.memory(),
+            buf,
+            (addr, MEMTXATTRS_UNSPECIFIED),
+        )?)
+    }
+
+    /// The store interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_st{size}_{endian}` on the C
+    /// side.
+    ///
+    /// The endianness of the access is carried by the value's type, which must
+    /// implement [`EndianValued`]: pass an explicit-endian type such as
+    /// `Le32`/`Be32` (or a single-byte `u8`/`i8`).
+    ///
+    /// And it assumes the memory attributes is `MEMTXATTRS_UNSPECIFIED`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use system::memory::{GuestAddress, Le32, ADDRESS_SPACE_MEMORY};
+    ///
+    /// let addr = GuestAddress(0x123123000);
+    /// assert!(ADDRESS_SPACE_MEMORY.store(addr, Le32::from(5)).is_ok());
+    /// ```
+    pub fn store<T: EndianValued>(&self, addr: GuestAddress, val: T) -> Result<()> {
+        // the `Ordering::Relaxed` will be ignored: QEMU's path is not
+        // Rust-atomic.
+        Ok(Bytes::store(
+            &*self.memory(),
+            val.to_carrier(),
+            (addr, MEMTXATTRS_UNSPECIFIED),
+            Ordering::Relaxed,
+        )?)
+    }
+
+    /// The load interface of `AddressSpace`.
+    ///
+    /// This function is similar to `address_space_ld{size}_{endian}` on the C
+    /// side.
+    ///
+    /// The endianness of the access is carried by the requested type, which
+    /// must implement [`EndianValued`]: ask for an explicit-endian type such
+    /// as `Le32`/`Be32` (or a single-byte `u8`/`i8`).
+    ///
+    /// And it assumes the memory attributes is `MEMTXATTRS_UNSPECIFIED`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use system::memory::{GuestAddress, Le32, ADDRESS_SPACE_MEMORY};
+    ///
+    /// let addr = GuestAddress(0x123123000);
+    /// assert!(ADDRESS_SPACE_MEMORY.load::<Le32>(addr).is_ok());
+    /// ```
+    pub fn load<T: EndianValued>(&self, addr: GuestAddress) -> Result<T> {
+        // the `Ordering::Relaxed` will be ignored: QEMU's path is not
+        // Rust-atomic.
+        let carrier: T::Carrier = Bytes::load(
+            &*self.memory(),
+            (addr, MEMTXATTRS_UNSPECIFIED),
+            Ordering::Relaxed,
+        )?;
+        Ok(T::from_carrier(carrier))
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
+    // SAFETY: `address_space_memory` structure is valid on the C side during
+    // the whole QEMU life.
+    &*wrapper_ptr
+};
-- 
2.34.1


