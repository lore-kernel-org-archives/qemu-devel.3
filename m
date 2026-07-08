Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwu-0006gB-Hn; Wed, 08 Jul 2026 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwq-0006Ls-6e; Wed, 08 Jul 2026 03:44:01 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwk-0004ox-GZ; Wed, 08 Jul 2026 03:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496635; x=1815032635;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s01A4TYlsdhYxVJa19FuPv1TolkBLDQE//62uZNCv2k=;
 b=kcHr4z06f0PSZmfVY8zZhg0hPu5BGe37LxsaVWttZdtmsTuAyzkVa5dQ
 TfzuuiUpog3w30QDiZwg6aaseVWYL/IG0CNsQlgDLflEx/d14P39TaFQT
 xR9uXKD3SsNHP268uHwtkS8QMJRihd7FFdw8xcWRFOulGra5VMX8539o/
 9fTmWYYwf1XSiaHXLorEkLM4KZLmtjmOnEBcm9qhXIDPvJrpsY0HhD1Yy
 2TVxsz4tQbPGlc+GU5dkSjxfnGwo/h51svRm4+/m70vHGkKECSStdcdVT
 HWhlRcpkepk3fSlQaRo5zwkeehwDpMEAcfktH6+5tDfsoyb4+yjlvHfo7 w==;
X-CSE-ConnectionGUID: pa/0SJaWR3eAD7Iu30gqzg==
X-CSE-MsgGUID: e4I6852HSwaD6Img99OKOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343391"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343391"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:43 -0700
X-CSE-ConnectionGUID: RLOYSd36QCGfXERFrUfH2w==
X-CSE-MsgGUID: JADoR++sSh+dQN9BKwDmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556068"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:38 -0700
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
Subject: [RFC v2 19/26] rust/system/memory: Implement vm_memory::GuestMemory
 for FlatView
Date: Wed,  8 Jul 2026 16:10:45 +0800
Message-Id: <20260708081052.2276617-20-zhao1.liu@intel.com>
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

Implement vm_memory::GuestMemory for FlatView, and provide memory
write/read/store/load bindings.

Note that the semantics of Bytes::read and Bytes::write in FlatView
differ from those of the C functions: on the Rust side, read/write
operations stop once an error occurs, while on the C side,
`MemTxResult` errors are accumulated and continue accessing to
subsequent memory regions.

This is because the current Rust loop implementation (try_access_full())
simply returns an error and aborts the operation. To achieve the
consistent semantics as the C side, it would be necessary to support
accumulating MemTxResult. This can be addressed as a future enhancement.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Implement Bytes<(MemoryRegionAddress, MemTxAttrs)> to attach
   MemTxAttrs.
 * Move GuestMemoryBackend::try_access() to FlatView::try_access_full().
 * Use vm-memory::Permissions to replace is_write flag.
---
 rust/system/src/memory.rs | 428 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 418 insertions(+), 10 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 34c7b7ce04a1..9772d1444dfb 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -2,8 +2,8 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs` and
-//! `MemoryRegionSection`.
+//! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs`
+//! `MemoryRegionSection` and `FlatView`.
 
 use std::{
     ffi::{c_uint, c_void, CStr, CString},
@@ -18,15 +18,16 @@
 use qom::prelude::*;
 pub use vm_memory::GuestAddress;
 use vm_memory::{
-    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryError, GuestMemoryRegion,
-    GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile,
-    WriteVolatile,
+    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryBackend, GuestMemoryError,
+    GuestMemoryRegion, GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize, MemoryRegionAddress,
+    Permissions, ReadVolatile, WriteVolatile,
 };
 
 use crate::bindings::{
-    self, device_endian, memory_region_init_io, rust_section_load, rust_section_read_continue_step,
-    rust_section_store, rust_section_write_continue_step, section_access_allowed,
-    section_covers_region_addr, section_fuzz_dma_read, MemTxResult,
+    self, address_space_lookup_section, device_endian, flatview_translate_section,
+    memory_region_init_io, rust_section_load, rust_section_read_continue_step, rust_section_store,
+    rust_section_write_continue_step, section_access_allowed, section_covers_region_addr,
+    section_fuzz_dma_read, MemTxResult,
 };
 // FIXME: Convert hwaddr to GuestAddress
 pub use crate::bindings::{hwaddr, MemTxAttrs};
@@ -260,7 +261,6 @@ impl MemoryRegionSection {
     /// A fuzz testing hook for DMA read.
     ///
     /// When `CONFIG_FUZZ` is not set, this hook will do nothing.
-    #[allow(dead_code)]
     fn fuzz_dma_read(&self, addr: GuestAddress, len: GuestUsize) -> &Self {
         // SAFETY: Opaque<> ensures the pointer is valid, and here it
         // takes into account the offset conversion between MemoryRegionSection
@@ -280,7 +280,6 @@ fn fuzz_dma_read(&self, addr: GuestAddress, len: GuestUsize) -> &Self {
     /// A helper to check if the memory access is allowed.
     ///
     /// This is needed for memory write/read.
-    #[allow(dead_code)]
     fn is_access_allowed(
         &self,
         addr: MemoryRegionAddress,
@@ -632,3 +631,412 @@ fn check_address(&self, addr: MemoryRegionAddress) -> Option<MemoryRegionAddress
         }
     }
 }
+
+/// A safe wrapper around [`bindings::FlatView`].
+///
+/// [`FlatView`] represents a collection of memory regions, and maps to
+/// [`GuestMemoryRegion`].
+///
+/// The memory details are hidden beneath this wrapper. Direct memory access
+/// is not allowed.  Instead, memory access, e.g., write/read/store/load
+/// should process through [`Bytes<GuestAddress>`].
+#[repr(transparent)]
+#[derive(common::Wrapper)]
+pub struct FlatView(Opaque<bindings::FlatView>);
+
+unsafe impl Send for FlatView {}
+unsafe impl Sync for FlatView {}
+
+impl Deref for FlatView {
+    type Target = bindings::FlatView;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Opaque<> wraps a pointer from C side. The validity
+        // of the pointer is confirmed at the creation of Opaque<>.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl FlatView {
+    /// Translate guest address to the offset within a `MemoryRegionSection`.
+    ///
+    /// Ideally, this helper should be integrated into
+    /// `GuestMemoryBackend::to_region_addr()`, but we haven't reached there
+    /// yet.
+    fn translate(
+        &self,
+        addr: GuestAddress,
+        len: GuestUsize,
+        access: Permissions,
+        attrs: MemTxAttrs,
+    ) -> Option<(&MemoryRegionSection, MemoryRegionAddress, GuestUsize)> {
+        let mut remain = len as hwaddr;
+        let mut raw_addr: hwaddr = 0;
+
+        // SAFETY: the pointers and reference are convertible and the
+        // offset conversion is considerred.
+        let ptr = unsafe {
+            flatview_translate_section(
+                self.as_mut_ptr(),
+                addr.raw_value(),
+                &mut raw_addr,
+                &mut remain,
+                access.has_write(),
+                attrs,
+            )
+        };
+
+        if ptr.is_null() {
+            return None;
+        }
+
+        // SAFETY: the pointer is valid and not NULL.
+        let s = unsafe {
+            <FlatView as GuestMemoryBackend>::R::from_raw(
+                ptr.cast::<bindings::MemoryRegionSection>(),
+            )
+        };
+        Some((
+            s,
+            MemoryRegionAddress(raw_addr)
+                .checked_sub(s.deref().offset_within_region)
+                .unwrap(),
+            remain as GuestUsize,
+        ))
+    }
+
+    /// Attempts to access a contiguous block of guest memory, executing a
+    /// callback for each memory region that backs the requested address
+    /// range.
+    ///
+    /// This method is the core of memory access operations.  It iterates
+    /// through each `MemoryRegionSection` that corresponds to the guest
+    /// address range [`addr`, `addr` + `count`) and invokes the provided
+    /// closure `f` for each section.
+    ///
+    /// This method is a variant of `GuestMemoryBackend::try_access()`, but it
+    /// includes additional permissions (`Permissions`) and memory transaction
+    /// attributes (`MemTxAttrs`).  Since `GuestMemoryBackend::try_access()` was
+    /// deprecated in `vm-memory` v0.18.0, `try_access_full()` is implemented
+    /// directly as an intrinsic method of [`FlatView`].
+    ///
+    /// The callback follows the `try_access()` semantics of `vm-memory`: an
+    /// `Err` stops the loop immediately.  Note that this differs from the
+    /// C side (`flatview_read_continue()` / `flatview_write_continue()`),
+    /// which accumulates `MemTxResult` errors and continues accessing
+    /// subsequent memory regions.
+    fn try_access_full<F>(
+        &self,
+        count: usize,
+        addr: GuestAddress,
+        access: Permissions,
+        attrs: MemTxAttrs,
+        mut f: F,
+    ) -> GuestMemoryResult<usize>
+    where
+        F: FnMut(
+            usize,
+            usize,
+            MemoryRegionAddress,
+            &MemoryRegionSection,
+        ) -> GuestMemoryResult<usize>,
+    {
+        if count == 0 {
+            return Ok(count);
+        }
+
+        let mut total = 0;
+        let mut curr = addr;
+
+        while total < count {
+            let len = (count - total) as GuestUsize;
+            let (region, start, remain) = self.translate(curr, len, access, attrs).unwrap();
+
+            if !region.is_access_allowed(start, remain, attrs) {
+                return Err(GuestMemoryError::InvalidGuestAddress(addr));
+            }
+
+            match f(total, remain as usize, start, region) {
+                // no more data
+                Ok(0) => return Ok(total),
+                // made some progress
+                Ok(res) => {
+                    if res as GuestUsize > remain {
+                        return Err(GuestMemoryError::CallbackOutOfRange);
+                    }
+
+                    total = match total.checked_add(res) {
+                        Some(x) if x < count => x,
+                        Some(x) if x == count => return Ok(x),
+                        _ => return Err(GuestMemoryError::CallbackOutOfRange),
+                    };
+
+                    curr = match curr.overflowing_add(res as GuestUsize) {
+                        (x @ GuestAddress(0), _) | (x, false) => x,
+                        (_, true) => return Err(GuestMemoryError::GuestAddressOverflow),
+                    };
+                }
+                // error happened
+                e => return e,
+            }
+        }
+
+        if total == 0 {
+            Err(GuestMemoryError::InvalidGuestAddress(addr))
+        } else {
+            Ok(total)
+        }
+    }
+}
+
+/// The attrs-aware `Bytes` implementation for `(GuestAddress, MemTxAttrs)`.
+impl Bytes<(GuestAddress, MemTxAttrs)> for FlatView {
+    type E = GuestMemoryError;
+
+    /// Write a byte buffer into guest memory, similar to `flatview_write` on
+    /// the C side.  It is only for internal use and should not be called
+    /// directly.
+    ///
+    /// The write stops once an error occurs.  This differs from the C side
+    /// (`flatview_write_continue()`), which accumulates `MemTxResult` errors
+    /// and continues accessing subsequent memory regions.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    fn write(
+        &self,
+        buf: &[u8],
+        (addr, attrs): (GuestAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<usize> {
+        self.try_access_full(
+            buf.len(),
+            addr,
+            Permissions::Write,
+            attrs,
+            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
+                // vm-memory provides an elegent way to advance (See
+                // ReadVolatile::read_volatile), but at this moment,
+                // this simple way is enough.
+                let sub_buf = &buf[offset..offset + count];
+                Bytes::write(region, sub_buf, (caddr, attrs))
+            },
+        )
+    }
+
+    /// Read a byte buffer from guest memory, similar to `flatview_read` on
+    /// the C side.  It is only for internal use and should not be called
+    /// directly.
+    ///
+    /// The read stops once an error occurs.  This differs from the C side
+    /// (`flatview_read_continue()`), which accumulates `MemTxResult` errors
+    /// and continues accessing subsequent memory regions.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    fn read(
+        &self,
+        buf: &mut [u8],
+        (addr, attrs): (GuestAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<usize> {
+        if buf.is_empty() {
+            return Ok(0);
+        }
+
+        self.try_access_full(
+            buf.len(),
+            addr,
+            Permissions::Read,
+            attrs,
+            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
+                // vm-memory provides an elegent way to advance (See
+                // ReadVolatile::write_volatile), but at this moment,
+                // this simple way is enough.
+                let sub_buf = &mut buf[offset..offset + count];
+                Bytes::read(
+                    region.fuzz_dma_read(addr, sub_buf.len() as GuestUsize),
+                    sub_buf,
+                    (caddr, attrs),
+                )
+            },
+        )
+    }
+
+    /// Store a value into guest memory at `addr`.  It is only for internal
+    /// use and should not be called directly.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    fn store<T: AtomicAccess>(
+        &self,
+        val: T,
+        (addr, attrs): (GuestAddress, MemTxAttrs),
+        order: Ordering,
+    ) -> GuestMemoryResult<()> {
+        self.translate(
+            addr,
+            size_of::<T>() as GuestUsize,
+            Permissions::Write,
+            attrs,
+        )
+        .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
+        .and_then(|(region, region_addr, remain)| {
+            // Although the C side handles this cross-region case via MMIO
+            // by default, it is highly suspicious for store/load operations.
+            // Since Bytes::store() does not support additional arguments to
+            // identify this scenario, report an error directly!
+            if remain < size_of::<T>() as GuestUsize {
+                return Err(GuestMemoryError::InvalidBackendAddress);
+            }
+
+            Bytes::store(region, val, (region_addr, attrs), order)
+        })
+    }
+
+    /// Load a value from guest memory at `addr`.  It is only for internal
+    /// use and should not be called directly.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    fn load<T: AtomicAccess>(
+        &self,
+        (addr, attrs): (GuestAddress, MemTxAttrs),
+        order: Ordering,
+    ) -> GuestMemoryResult<T> {
+        self.translate(addr, size_of::<T>() as GuestUsize, Permissions::Read, attrs)
+            .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
+            .and_then(|(region, region_addr, remain)| -> GuestMemoryResult<T> {
+                // Although the C side handles this cross-region case via MMIO
+                // by default, it is highly suspicious for store/load operations.
+                // Since Bytes::load() does not support additional arguments to
+                // identify this scenario, report an error directly!
+                if remain < size_of::<T>() as GuestUsize {
+                    return Err(GuestMemoryError::InvalidBackendAddress);
+                }
+
+                Bytes::load(
+                    region.fuzz_dma_read(addr, size_of::<T>() as GuestUsize),
+                    (region_addr, attrs),
+                    order,
+                )
+            })
+    }
+
+    fn write_slice(&self, _buf: &[u8], _addr: (GuestAddress, MemTxAttrs)) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_slice(
+        &self,
+        _buf: &mut [u8],
+        _addr: (GuestAddress, MemTxAttrs),
+    ) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_volatile_from<F>(
+        &self,
+        _addr: (GuestAddress, MemTxAttrs),
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
+        _addr: (GuestAddress, MemTxAttrs),
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
+        _addr: (GuestAddress, MemTxAttrs),
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
+        _addr: (GuestAddress, MemTxAttrs),
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
+impl GuestMemoryBackend for FlatView {
+    type R = MemoryRegionSection;
+
+    /// Get the number of `MemoryRegionSection`s managed by this `FlatView`.
+    fn num_regions(&self) -> usize {
+        self.deref().nr.try_into().unwrap()
+    }
+
+    /// Find the `MemoryRegionSection` which covers @addr
+    fn find_region(&self, addr: GuestAddress) -> Option<&Self::R> {
+        // set resolve_subpage as true by default
+        //
+        // SAFETY: bindings::FlatView has `dispatch` field and the pointer is
+        // valid, although accessing the field of C structure is ugly.
+        let raw =
+            unsafe { address_space_lookup_section(self.deref().dispatch, addr.raw_value(), true) };
+
+        if !raw.is_null() {
+            let s = unsafe { Self::R::from_raw(raw) };
+            Some(s)
+        } else {
+            None
+        }
+    }
+
+    /// Return an empty iterator.
+    ///
+    /// This function always triggers panic.
+    #[allow(unreachable_code)]
+    fn iter(&self) -> impl Iterator<Item = &Self::R> {
+        unreachable!(); // Do not use this iter()!
+
+        // QEMU has a linear iteration mechanism on the C side named
+        // `flatview_for_each_range`, but it iterates over `FlatRange`s
+        // instead of `MemoryRegionSection`s.
+        //
+        // It is still possible to have an `Iterator` based on
+        // `MemoryRegionSection` by iterating over
+        // `FlatView::dispatch::map::sections`.
+        //
+        // However, it is not worth it. QEMU has implemented the two-level
+        // "page" walk in `phys_page_find`, which is more efficient than
+        // linear iteration. Therefore, there is no need to reinvent the
+        // wheel on the Rust side, at least for now.
+        //
+        // Just return an empty iterator to satisfy the trait's contract.
+        // This makes the code compile, but the iterator won't yield
+        // any items.
+        std::iter::empty()
+    }
+
+    fn to_region_addr(&self, _addr: GuestAddress) -> Option<(&Self::R, MemoryRegionAddress)> {
+        // Note: This method should implement FlatView::translate(), but
+        // its function signature is ill-suited for QEMU's translation needs.
+        // QEMU needs to distinguish whether an access is a write, and it must
+        // account for the remaining bytes of the region.
+        //
+        // FIXME: Once GuestMemoryBackend::to_region_addr() can meet QEMU's
+        // requirements, move the FlatView::translate() logic here.
+        unimplemented!()
+    }
+}
-- 
2.34.1


