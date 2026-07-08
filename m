Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1894C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxI-0007N7-In; Wed, 08 Jul 2026 03:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwt-0006Zc-BO; Wed, 08 Jul 2026 03:44:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwq-0005Eb-Fh; Wed, 08 Jul 2026 03:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496641; x=1815032641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rSFkOsJu2E+9YsPkkJ314w45wfR0HVp9UkR1a7Hyvls=;
 b=QE5BLkvAj00fN2nTbpVwC/JhlZTlBv/nAA/A8MQp0PS8rgc47+NK9EkA
 BymEvjgALAgllqhbjfty2LGrIp+sRNo8Q8p41h/779VTPHKwttFNyVJcC
 j24aV+I52vLARJYKGxxrYmge/vlbeoPA2SEO/mY73ydbg3/z7pt2C1Jqv
 hwiQTeUtaaTh0iX8EhJaRRP6/Jg9QXm/EuUKio++NG3czJTggDOeZ/d61
 qCMpGBxMGIEYWKc56YF0kOrozE5gsSucF+SQk7dmm24c8QAm1xl3iym+1
 +Iy9xf/OVUl+zOBnmr9eauhn62RZ6T9PzfCIu+fR7oYtJPQIEyIFuPCRr Q==;
X-CSE-ConnectionGUID: RlsgaH3KSbinZ9Zo02vtcg==
X-CSE-MsgGUID: 59LtsHbdR2uisKZo2i0KWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343385"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:39 -0700
X-CSE-ConnectionGUID: 6v6yH9IkQt+xweL6p1isWw==
X-CSE-MsgGUID: HKerOMJFQPSOT+aqrQoSuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556052"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:34 -0700
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
Subject: [RFC v2 18/26] rust/system/memory: Implement
 vm_memory::GuestMemoryRegion for MemoryRegionSection
Date: Wed,  8 Jul 2026 16:10:44 +0800
Message-Id: <20260708081052.2276617-19-zhao1.liu@intel.com>
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

Although QEMU already has a native memory region abstraction (MemoryRegion),
it supports overlapping regions. Since the vm-memory crate does not support
overlapping memory, MemoryRegionSection is a more appropriate choice to
implement the vm_memory::GuestMemoryRegion trait.

To achieve this, implement vm_memory::GuestMemoryRegion for MemoryRegionSection,
along with its required supertrait, GuestMemoryRegionBytes. Additionally,
implement Bytes<(MemoryRegionAddress, MemTxAttrs)> to properly attach QEMU's
memory transaction attributes to memory operations.

Furthermore, provide low-level memory write/read/store/load bindings based
on MemoryRegionSection, and add the necessary helpers (fuzz_dma_read() and
is_access_allowed()).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Implement GuestMemoryRegionBytes for MemoryRegionSection to satisfy
   supertrait requirement.
 * Implement Bytes<(MemoryRegionAddress, MemTxAttrs)> to attach
   MemTxAttrs.
 * For write/read, add an extra loop to ensure write/read are actually
   finished within the same region.
---
 rust/system/src/memory.rs | 449 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 447 insertions(+), 2 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 4c258201bad7..34c7b7ce04a1 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -2,19 +2,38 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion`, `MemoryRegionOps` and `MemTxAttrs`
+//! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs` and
+//! `MemoryRegionSection`.
 
 use std::{
     ffi::{c_uint, c_void, CStr, CString},
+    io::ErrorKind,
     marker::PhantomData,
+    mem::size_of,
+    ops::Deref,
+    sync::atomic::Ordering,
 };
 
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::prelude::*;
+pub use vm_memory::GuestAddress;
+use vm_memory::{
+    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryError, GuestMemoryRegion,
+    GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile,
+    WriteVolatile,
+};
 
-use crate::bindings::{self, device_endian, memory_region_init_io};
+use crate::bindings::{
+    self, device_endian, memory_region_init_io, rust_section_load, rust_section_read_continue_step,
+    rust_section_store, rust_section_write_continue_step, section_access_allowed,
+    section_covers_region_addr, section_fuzz_dma_read, MemTxResult,
+};
+// FIXME: Convert hwaddr to GuestAddress
 pub use crate::bindings::{hwaddr, MemTxAttrs};
 
+/// Corresponds to C `MEMTX_OK` (#define `MEMTX_OK` 0).
+const MEMTX_OK: MemTxResult = 0;
+
 pub struct MemoryRegionOps<T>(
     bindings::MemoryRegionOps,
     // Note: quite often you'll see PhantomData<fn(&T)> mentioned when discussing
@@ -187,3 +206,429 @@ unsafe impl ObjectType for MemoryRegion {
     unspecified: true,
     ..Zeroable::ZERO
 };
+
+/// A safe wrapper around [`bindings::MemoryRegionSection`].
+///
+/// This struct is fundamental for integrating QEMU's memory model with
+/// the `vm-memory` ecosystem.  It directly maps to the concept of
+/// [`GuestMemoryRegion`] and implements that trait.
+///
+/// ### `MemoryRegion` vs. `MemoryRegionSection`
+///
+/// Although QEMU already has native memory region abstraction, this is
+/// [`MemoryRegion`], which supports overlapping.  But `vm-memory` doesn't
+/// support overlapped memory, so `MemoryRegionSection` is more proper
+/// to implement [`GuestMemoryRegion`] trait.
+///
+/// One point should pay attention is, [`MemoryRegionAddress`] represents the
+/// address or offset within the `MemoryRegionSection`.  But traditional C
+/// bindings treats memory region address or offset as the offset within
+/// `MemoryRegion`.
+///
+/// Therefore, it's necessary to do conversion when calling C bindings
+/// with `MemoryRegionAddress` from the context of `MemoryRegionSection`.
+///
+/// ### Usage
+///
+/// Considerring memory access is almost always through `AddressSpace`
+/// in QEMU, `MemoryRegionSection` is intended for **internal use only**
+///  within the `vm-memory` backend implementation.
+///
+/// Device and other external users should **not** use or create
+/// `MemoryRegionSection`s directly.  Instead, they should work with the
+/// higher-level `MemoryRegion` API to create and manage their device's
+/// memory.  This separation of concerns mirrors the C API and avoids
+/// confusion about different memory abstractions.
+#[repr(transparent)]
+#[derive(common::Wrapper, Debug)]
+pub struct MemoryRegionSection(Opaque<bindings::MemoryRegionSection>);
+
+unsafe impl Send for MemoryRegionSection {}
+unsafe impl Sync for MemoryRegionSection {}
+
+impl Deref for MemoryRegionSection {
+    type Target = bindings::MemoryRegionSection;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Opaque<> wraps a pointer from C side. The validity
+        // of the pointer is confirmed at the creation of Opaque<>.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl MemoryRegionSection {
+    /// A fuzz testing hook for DMA read.
+    ///
+    /// When `CONFIG_FUZZ` is not set, this hook will do nothing.
+    #[allow(dead_code)]
+    fn fuzz_dma_read(&self, addr: GuestAddress, len: GuestUsize) -> &Self {
+        // SAFETY: Opaque<> ensures the pointer is valid, and here it
+        // takes into account the offset conversion between MemoryRegionSection
+        // and MemoryRegion.
+        unsafe {
+            section_fuzz_dma_read(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                len,
+            );
+        }
+        self
+    }
+
+    /// A helper to check if the memory access is allowed.
+    ///
+    /// This is needed for memory write/read.
+    #[allow(dead_code)]
+    fn is_access_allowed(
+        &self,
+        addr: MemoryRegionAddress,
+        len: GuestUsize,
+        attrs: MemTxAttrs,
+    ) -> bool {
+        // SAFETY: Opaque<> ensures the pointer is valid, and here it
+        // takes into account the offset conversion between MemoryRegionSection
+        // and MemoryRegion.
+        let allowed = unsafe {
+            section_access_allowed(
+                self.as_mut_ptr(),
+                attrs,
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                len,
+            )
+        };
+        allowed
+    }
+}
+
+/// Satisfies the `Bytes<MemoryRegionAddress>` supertrait required by
+/// `GuestMemoryRegion`.
+///
+/// The blanket impl fails with `HostAddressNotAvailable` because
+/// `MemoryRegionSection` methods all go through `as_volatile_slice()` and
+/// `get_slice()`, which by default return an error.
+///
+/// QEMU's real access path is always attrs-aware and reaches this section
+/// through the `Bytes<(MemoryRegionAddress,
+/// MemTxAttrs)>` impl below.
+impl GuestMemoryRegionBytes for MemoryRegionSection {}
+
+/// The attrs-aware `Bytes` implementation that actually does the C-side
+/// memory access for a single `MemoryRegionSection`.
+///
+/// This composite impl is the *only* real access path into a
+/// `MemoryRegionSection`: QEMU always reaches it through `FlatView`
+/// with the real `attrs`.  The blanket `GuestMemoryRegionBytes` impl above
+/// just satisfies the `GuestMemoryRegion` supertrait bound and is never
+/// actually  called.
+impl Bytes<(MemoryRegionAddress, MemTxAttrs)> for MemoryRegionSection {
+    type E = GuestMemoryError;
+
+    /// Write a byte buffer into guest memory at `addr`.
+    ///
+    /// This shouldn't be called to access memory directly; it is the
+    /// per-region worker invoked by `FlatView`'s write path.  The transaction
+    /// `attrs` are forwarded to the C side. And the cross-region is handled by
+    /// `FlatView`'s write.
+    fn write(
+        &self,
+        buf: &[u8],
+        (addr, attrs): (MemoryRegionAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<usize> {
+        let base = addr
+            .checked_add(self.deref().offset_within_region)
+            .unwrap()
+            .raw_value();
+        let total = buf.len() as u64;
+        let mut done: u64 = 0;
+
+        while done < total {
+            // `step` is the attempt size on input and the bytes actually
+            // handled on output.
+            let mut step = total - done;
+
+            // SAFETY: the pointers and reference are convertible and the
+            // offset conversion is considered.
+            let ret = unsafe {
+                rust_section_write_continue_step(
+                    self.as_mut_ptr(),
+                    attrs,
+                    buf[done as usize..].as_ptr(),
+                    total - done,
+                    base + done,
+                    &mut step,
+                )
+            };
+
+            if ret != MEMTX_OK {
+                return Err(GuestMemoryError::InvalidBackendAddress);
+            }
+
+            // A zero-length step can never make progress.
+            if step == 0 {
+                break;
+            }
+
+            done += step;
+        }
+
+        Ok(done as usize)
+    }
+
+    /// Read a byte buffer from guest memory at `addr`.
+    ///
+    /// This shouldn't be called to access memory directly; it is the
+    /// per-region worker invoked by `FlatView`'s read path.  The transaction
+    /// `attrs` are forwarded to the C side. And the cross-region is handled by
+    /// `FlatView`'s read.
+    fn read(
+        &self,
+        buf: &mut [u8],
+        (addr, attrs): (MemoryRegionAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<usize> {
+        let base = addr
+            .checked_add(self.deref().offset_within_region)
+            .unwrap()
+            .raw_value();
+        let total = buf.len() as u64;
+        let mut done: u64 = 0;
+
+        while done < total {
+            // `step` is the attempt size on input and the bytes actually
+            // handled on output.
+            let mut step = total - done;
+
+            // SAFETY: the pointers and reference are convertible and the
+            // offset conversion is considered.
+            let ret = unsafe {
+                rust_section_read_continue_step(
+                    self.as_mut_ptr(),
+                    attrs,
+                    buf[done as usize..].as_mut_ptr(),
+                    total - done,
+                    base + done,
+                    &mut step,
+                )
+            };
+
+            if ret != MEMTX_OK {
+                return Err(GuestMemoryError::InvalidBackendAddress);
+            }
+
+            // A zero-length step can never make progress.
+            if step == 0 {
+                break;
+            }
+
+            done += step;
+        }
+
+        Ok(done as usize)
+    }
+
+    /// Store a value into guest memory at `addr`.
+    ///
+    /// This function - as the low-level store implementation - is
+    /// called by `FlatView`'s `store()`.  And it shouldn't be called to
+    /// access memory directly.
+    ///
+    /// The transaction `attrs` are forwarded to the C side; the `Ordering` is
+    /// ignored because the access is not Rust-atomic.
+    fn store<T: AtomicAccess>(
+        &self,
+        val: T,
+        (addr, attrs): (MemoryRegionAddress, MemTxAttrs),
+        _order: Ordering,
+    ) -> GuestMemoryResult<()> {
+        let len = size_of::<T>();
+
+        if len > size_of::<u64>() {
+            return Err(GuestMemoryError::IOError(std::io::Error::new(
+                ErrorKind::InvalidInput,
+                "failed to store the data more then 8 bytes",
+            )));
+        }
+
+        // Note: rust_section_store() accepts `const uint8_t *buf`.
+        //
+        // This is a "compromise" solution: vm-memory requires AtomicAccess
+        // but QEMU uses uint64_t as the default type. Here we can't convert
+        // AtomicAccess to u64, since the compiler will complain "an `as`
+        // expression can only be used to convert between primitive types or
+        // to coerce to a specific trait object", or other endless errors
+        // about conversion to u64.
+        //
+        // Fortunately, we can use a byte array to bridge the Rust wrapper
+        // and the C binding. This approach is not without a trade-off,
+        // however: the rust_section_store() function requires an additional
+        // conversion from bytes to a uint64_t for the MMIO case. This performance
+        // overhead is considered acceptable.
+        //
+        // SAFETY: the pointers are convertible and the offset conversion is
+        // considered.
+        let res = unsafe {
+            rust_section_store(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                val.as_slice().as_ptr(),
+                attrs,
+                len as u64,
+            )
+        };
+
+        match res {
+            MEMTX_OK => Ok(()),
+            _ => Err(GuestMemoryError::InvalidBackendAddress),
+        }
+    }
+
+    /// Load a value from guest memory at `addr`.
+    ///
+    /// This function - as the low-level load implementation - is
+    /// called by `FlatView`'s `load()`.  And it shouldn't be called to
+    /// access memory directly.
+    ///
+    /// The transaction `attrs` are forwarded to the C side; the `Ordering` is
+    /// ignored because the access is not Rust-atomic.
+    fn load<T: AtomicAccess>(
+        &self,
+        (addr, attrs): (MemoryRegionAddress, MemTxAttrs),
+        _order: Ordering,
+    ) -> GuestMemoryResult<T> {
+        let len = size_of::<T>();
+
+        if len > size_of::<u64>() {
+            return Err(GuestMemoryError::IOError(std::io::Error::new(
+                ErrorKind::InvalidInput,
+                "failed to load the data more then 8 bytes",
+            )));
+        }
+
+        let mut val: T = T::zeroed();
+
+        // Note: rust_section_load() accepts `uint8_t *buf`.
+        //
+        // This is for a similar reason as store(), with the slight difference
+        // that rust_section_load() requires an additional conversion from
+        // uint64_t to bytes.
+        //
+        // SAFETY: the pointers are convertible and the offset conversion is
+        // considered.
+        let res = unsafe {
+            rust_section_load(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                val.as_mut_slice().as_mut_ptr(),
+                attrs,
+                size_of::<T>() as u64,
+            )
+        };
+
+        match res {
+            MEMTX_OK => Ok(val),
+            _ => Err(GuestMemoryError::InvalidBackendAddress),
+        }
+    }
+
+    fn write_slice(
+        &self,
+        _buf: &[u8],
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_slice(
+        &self,
+        _buf: &mut [u8],
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_volatile_from<F>(
+        &self,
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+        _src: &mut F,
+        _count: usize,
+    ) -> GuestMemoryResult<usize>
+    where
+        F: ReadVolatile,
+    {
+        unimplemented!()
+    }
+
+    fn read_exact_volatile_from<F>(
+        &self,
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+        _src: &mut F,
+        _count: usize,
+    ) -> GuestMemoryResult<()>
+    where
+        F: ReadVolatile,
+    {
+        unimplemented!()
+    }
+
+    fn write_volatile_to<F>(
+        &self,
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+        _dst: &mut F,
+        _count: usize,
+    ) -> GuestMemoryResult<usize>
+    where
+        F: WriteVolatile,
+    {
+        unimplemented!()
+    }
+
+    fn write_all_volatile_to<F>(
+        &self,
+        _addr: (MemoryRegionAddress, MemTxAttrs),
+        _dst: &mut F,
+        _count: usize,
+    ) -> GuestMemoryResult<()>
+    where
+        F: WriteVolatile,
+    {
+        unimplemented!()
+    }
+}
+
+impl GuestMemoryRegion for MemoryRegionSection {
+    type B = ();
+
+    /// Get the memory size covered by this `MemoryRegionSection`.
+    fn len(&self) -> GuestUsize {
+        self.deref().size as GuestUsize
+    }
+
+    /// Return the minimum (inclusive) Guest physical address managed by
+    /// this `MemoryRegionSection`.
+    fn start_addr(&self) -> GuestAddress {
+        GuestAddress(self.deref().offset_within_address_space)
+    }
+
+    fn bitmap(&self) -> BS<'_, Self::B> {}
+
+    /// Check whether the `@addr` is covered by this `MemoryRegionSection`.
+    fn check_address(&self, addr: MemoryRegionAddress) -> Option<MemoryRegionAddress> {
+        let region_addr = addr
+            .checked_add(self.deref().offset_within_region)?
+            .raw_value();
+        // SAFETY: the pointer is convertible and the offset conversion is
+        // considered.
+        if unsafe { section_covers_region_addr(self.as_mut_ptr(), region_addr) } {
+            Some(addr)
+        } else {
+            None
+        }
+    }
+}
-- 
2.34.1


