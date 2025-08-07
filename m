Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED87C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzTw-00066n-7B; Thu, 07 Aug 2025 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSM-000470-MP; Thu, 07 Aug 2025 08:10:50 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSJ-0005Bp-9L; Thu, 07 Aug 2025 08:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568647; x=1786104647;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JC5ZB5z1XOiDYFlC6bwMZhTJO84pmbExB9lSlxIwYgU=;
 b=iNN805iNsxWK7FZZq+WCwnkO6CQTM8oLk8844ZmPOGGNnHhS3ibap6Ks
 J/502RAT8+QmVXaXbvfLo8QZnCKjXDi9E/FFsCr/TjG9dGepUNYk/jtps
 uvvkTvcFoAC40jueVR22J80uixCGg0nT4sxSQpkTSuBkmrz+vsBfBh70X
 4vIa1WLGXfL4CmLIXGrxjObOEIbNUO/9B2SDDAQ3dDq27R/rPRpzojju3
 Xg+0Ex0fSrDZNVYDzLpz30wLCwcmTnmPf1yJq9VZVXbBj37NPoK4yHW07
 BNkyYXzBKstMDk8HE+x++8CA3sHTkiLOIAM31+/b75lGfVRQfVcb/bDf6 w==;
X-CSE-ConnectionGUID: qVqJsjMeSYmWz0FnXoP3UQ==
X-CSE-MsgGUID: Y3rfUZDYS0ay7RAEVN7v/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036876"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036876"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:16 -0700
X-CSE-ConnectionGUID: /99abexeT82kKLGM5NL/bA==
X-CSE-MsgGUID: /eCEAMOaSf+WLz7ErDajkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701269"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:13 -0700
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
Subject: [RFC 22/26] rust/memory: Implement vm_memory::GuestMemoryRegion for
 MemoryRegionSection
Date: Thu,  7 Aug 2025 20:30:23 +0800
Message-Id: <20250807123027.2910950-23-zhao1.liu@intel.com>
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

Although QEMU already has native memory region abstraction, this is
MemoryRegion, which supports overlapping.

But vm-memory doesn't support overlapped memory, so MemoryRegionSection
is more proper to implement vm_memory::GuestMemoryRegion trait.

Implement vm_memory::GuestMemoryRegion for MemoryRegionSection, and
provide low-level memory write/read/store/load bindings based on
MemoryRegionSection.

Additionally, add necessay helpers (fuzz_dma_read() and
is_access_allowed()) for MemoryRegionSection.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/memory.rs | 393 +++++++++++++++++++++++++++++++++++-
 1 file changed, 391 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index e40fad6cf19e..c8faa3b9c1e9 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -2,17 +2,33 @@
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
 
+// FIXME: Convert hwaddr to GuestAddress
 pub use bindings::{hwaddr, MemTxAttrs};
+pub use vm_memory::GuestAddress;
+use vm_memory::{
+    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryError, GuestMemoryRegion,
+    GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile, VolatileSlice, WriteVolatile,
+};
 
 use crate::{
-    bindings::{self, device_endian, memory_region_init_io},
+    bindings::{
+        self, device_endian, memory_region_init_io, section_access_allowed,
+        section_covers_region_addr, section_fuzz_dma_read, section_get_host_addr,
+        section_rust_load, section_rust_read_continue_step, section_rust_store,
+        section_rust_write_continue_step, MEMTX_OK,
+    },
     callbacks::FnCall,
     cell::Opaque,
     prelude::*,
@@ -202,3 +218,376 @@ unsafe impl ObjectType for MemoryRegion {
     unspecified: true,
     ..Zeroable::ZERO
 };
+
+/// A safe wrapper around [`bindings::MemoryRegionSection`].
+///
+/// This struct is fundamental for integrating QEMU's memory model with
+/// the [`vm-memory`] ecosystem.  It directly maps to the concept of
+/// [`GuestMemoryRegion`](vm_memory::GuestMemoryRegion) and implements
+/// that trait.
+///
+/// ### `MemoryRegion` vs. `MemoryRegionSection`
+///
+/// Although QEMU already has native memory region abstraction, this is
+/// [`MemoryRegion`], which supports overlapping.  But `vm-memory` doesn't
+/// support overlapped memory, so `MemoryRegionSection` is more proper
+/// to implement [`GuestMemoryRegion`](vm_memory::GuestMemoryRegion)
+/// trait.
+///
+/// One point should pay attention is,
+/// [`MemoryRegionAddress`](vm_memory::MemoryRegionAddress) represents the
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
+#[derive(qemu_api_macros::Wrapper)]
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
+    /// When CONFIG_FUZZ is not set, this hook will do nothing.
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
+            )
+        };
+        self
+    }
+
+    /// A helper to check if the memory access is allowed.
+    ///
+    /// This is needed for memory write/read.
+    #[allow(dead_code)]
+    fn is_access_allowed(&self, addr: MemoryRegionAddress, len: GuestUsize) -> bool {
+        // SAFETY: Opaque<> ensures the pointer is valid, and here it
+        // takes into account the offset conversion between MemoryRegionSection
+        // and MemoryRegion.
+        let allowed = unsafe {
+            section_access_allowed(
+                self.as_mut_ptr(),
+                MEMTXATTRS_UNSPECIFIED,
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
+impl Bytes<MemoryRegionAddress> for MemoryRegionSection {
+    type E = GuestMemoryError;
+
+    /// The memory wirte interface based on `MemoryRegionSection`.
+    ///
+    /// This function - as an intermediate step - is called by FlatView's
+    /// write(). And it shouldn't be called to access memory directly.
+    fn write(&self, buf: &[u8], addr: MemoryRegionAddress) -> GuestMemoryResult<usize> {
+        let len = buf.len() as u64;
+        let mut remain = len;
+
+        // SAFETY: the pointers and reference are convertible and the
+        // offset conversion is considerred.
+        let ret = unsafe {
+            section_rust_write_continue_step(
+                self.as_mut_ptr(),
+                MEMTXATTRS_UNSPECIFIED,
+                buf.as_ptr(),
+                len,
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                &mut remain,
+            )
+        };
+
+        if ret == MEMTX_OK {
+            return Ok(remain as usize);
+        } else {
+            return Err(GuestMemoryError::InvalidBackendAddress);
+        }
+    }
+
+    /// The memory read interface based on `MemoryRegionSection`.
+    ///
+    /// This function - as an intermediate step - is called by FlatView's
+    /// read(). And it shouldn't be called to access memory directly.
+    fn read(&self, buf: &mut [u8], addr: MemoryRegionAddress) -> GuestMemoryResult<usize> {
+        let len = buf.len() as u64;
+        let mut remain = len;
+
+        // SAFETY: the pointers and reference are convertible and the
+        // offset conversion is considerred.
+        let ret = unsafe {
+            section_rust_read_continue_step(
+                self.as_mut_ptr(),
+                MEMTXATTRS_UNSPECIFIED,
+                buf.as_mut_ptr(),
+                len,
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                &mut remain,
+            )
+        };
+
+        if ret == MEMTX_OK {
+            return Ok(remain as usize);
+        } else {
+            return Err(GuestMemoryError::InvalidBackendAddress);
+        }
+    }
+
+    /// The memory store interface based on `MemoryRegionSection`.
+    ///
+    /// This function - as the low-level store implementation - is
+    /// called by FlatView's store(). And it shouldn't be called to
+    ///  access memory directly.
+    fn store<T: AtomicAccess>(
+        &self,
+        val: T,
+        addr: MemoryRegionAddress,
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
+        // Note: setcion_rust_store() accepts `const uint8_t *buf`.
+        //
+        // This is a "compromise" solution: vm-memory requires AtomicAccess
+        // but QEMU uses uint64_t as the default type. Here we can't convert
+        // AtomicAccess to u64, since complier will complain "an `as`
+        // expression can only be used to convert between primitive types or
+        // to coerce to a specific trait object", or other endless errors
+        // about convertion to u64.
+        //
+        // Fortunately, we can use a byte array to bridge the Rust wrapper
+        // and the C binding. This approach is not without a trade-off,
+        // however: the section_rust_store() function requires an additional
+        // conversion from bytes to a uint64_t. This performance overhead is
+        // considered acceptable.
+        //
+        // SAFETY: the pointers are convertible and the offset conversion is
+        // considerred.
+        let res = unsafe {
+            section_rust_store(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                val.as_slice().as_ptr(),
+                MEMTXATTRS_UNSPECIFIED,
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
+    /// The memory load interface based on `MemoryRegionSection`.
+    ///
+    /// This function - as the low-level load implementation - is
+    /// called by FlatView's load(). And it shouldn't be called to
+    /// access memory directly.
+    fn load<T: AtomicAccess>(
+        &self,
+        addr: MemoryRegionAddress,
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
+        // Note: setcion_rust_load() accepts `uint8_t *buf`.
+        //
+        // It has the similar reason as store() with the slight difference,
+        // which is section_rust_load() requires additional conversion of
+        // uint64_t to bytes.
+        //
+        // SAFETY: the pointers are convertible and the offset conversion is
+        // considerred.
+        let res = unsafe {
+            section_rust_load(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+                val.as_mut_slice().as_mut_ptr(),
+                MEMTXATTRS_UNSPECIFIED,
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
+    fn write_slice(&self, _buf: &[u8], _addr: MemoryRegionAddress) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_slice(&self, _buf: &mut [u8], _addr: MemoryRegionAddress) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_volatile_from<F>(
+        &self,
+        _addr: MemoryRegionAddress,
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
+        _addr: MemoryRegionAddress,
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
+        _addr: MemoryRegionAddress,
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
+        _addr: MemoryRegionAddress,
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
+    /// Get the memory size covered by this MemoryRegionSection.
+    fn len(&self) -> GuestUsize {
+        self.deref().size as GuestUsize
+    }
+
+    /// Return the minimum (inclusive) Guest physical address managed by
+    /// this MemoryRegionSection.
+    fn start_addr(&self) -> GuestAddress {
+        GuestAddress(self.deref().offset_within_address_space)
+    }
+
+    fn bitmap(&self) -> BS<'_, Self::B> {
+        ()
+    }
+
+    /// Check whether the @addr is covered by this MemoryRegionSection.
+    fn check_address(&self, addr: MemoryRegionAddress) -> Option<MemoryRegionAddress> {
+        // SAFETY: the pointer is convertible and the offset conversion is
+        // considerred.
+        if unsafe {
+            section_covers_region_addr(
+                self.as_mut_ptr(),
+                addr.checked_add(self.deref().offset_within_region)
+                    .unwrap()
+                    .raw_value(),
+            )
+        } {
+            Some(addr)
+        } else {
+            None
+        }
+    }
+
+    /// Get the host virtual address from the offset of this MemoryRegionSection
+    /// (@addr).
+    fn get_host_address(&self, addr: MemoryRegionAddress) -> GuestMemoryResult<*mut u8> {
+        self.check_address(addr)
+            .ok_or(GuestMemoryError::InvalidBackendAddress)
+            .map(|addr|
+                // SAFETY: the pointers are convertible and the offset
+                // conversion is considerred.
+                unsafe { section_get_host_addr(self.as_mut_ptr(), addr.raw_value()) })
+    }
+
+    fn get_slice(
+        &self,
+        _offset: MemoryRegionAddress,
+        _count: usize,
+    ) -> GuestMemoryResult<VolatileSlice<BS<Self::B>>> {
+        unimplemented!()
+    }
+}
-- 
2.34.1


