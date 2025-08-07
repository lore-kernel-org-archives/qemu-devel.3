Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3433FC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSR-0004Jz-QV; Thu, 07 Aug 2025 08:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSM-00045S-4e; Thu, 07 Aug 2025 08:10:50 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzSJ-0005Cn-2l; Thu, 07 Aug 2025 08:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568647; x=1786104647;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RPK/xV4qr+qgQthrCvhKw4L9KVKLhbnVw8l3iY1dEz4=;
 b=mKozXiytLvsqX8rdwxdojEYoYyTVmTV9XZac4p2Z1yvlJfXzl/Y1TVKp
 3HJl7h64otNmrKljRe+2W9HK+vnI+cWHftVHQ+OYAsUBBwcbmBWBxZHMw
 UC37jru23UkeOA90xeBYNYCSPbWd6LNc6joYKX4Yy3zll0wDsPjy7bqYX
 0Z7wB9/lvFGg3VHmFSpzru9MtemF+88yK/2mwsZq6vGowVDADxzV+H5xn
 Dl6V42XDWE5TkMuPii1VqHXYDb+wnU/nZ9E7L/8w7ErGl2JvnFnhrUfXR
 mfjZkPiXv7awgESb3noA0ScQTw55AKnv0sDU9t1DXQ0zWj5rtx1PY2cj9 w==;
X-CSE-ConnectionGUID: aU0EpJKgTJyMdToMxUHCMA==
X-CSE-MsgGUID: eCOg+4e1TJGV4B1XUGVYGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036883"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036883"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:10:19 -0700
X-CSE-ConnectionGUID: 0QrxE7xYRNy5eC6XN7Hjng==
X-CSE-MsgGUID: Lgb+kPdbSnSrNM3q36KSkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701309"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:10:17 -0700
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
Subject: [RFC 23/26] rust/memory: Implement vm_memory::GuestMemory for FlatView
Date: Thu,  7 Aug 2025 20:30:24 +0800
Message-Id: <20250807123027.2910950-24-zhao1.liu@intel.com>
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

Implement vm_memory::GuestMemory for FlafView, and provide memory
write/read/store/load bindings.

At the meanwhile, add a RAII guard to help protect FlatView's life
time at Rust side.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/memory.rs | 433 +++++++++++++++++++++++++++++++++++-
 1 file changed, 429 insertions(+), 4 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index c8faa3b9c1e9..23347f35e5da 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -2,8 +2,8 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs` and
-//! `MemoryRegionSection`.
+//! Bindings for `MemoryRegion`, `MemoryRegionOps`, `MemTxAttrs`
+//! `MemoryRegionSection` and `FlatView`.
 
 use std::{
     ffi::{c_uint, c_void, CStr, CString},
@@ -11,6 +11,7 @@
     marker::PhantomData,
     mem::size_of,
     ops::Deref,
+    ptr::NonNull,
     sync::atomic::Ordering,
 };
 
@@ -18,13 +19,14 @@
 pub use bindings::{hwaddr, MemTxAttrs};
 pub use vm_memory::GuestAddress;
 use vm_memory::{
-    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryError, GuestMemoryRegion,
+    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemory, GuestMemoryError, GuestMemoryRegion,
     GuestMemoryResult, GuestUsize, MemoryRegionAddress, ReadVolatile, VolatileSlice, WriteVolatile,
 };
 
 use crate::{
     bindings::{
-        self, device_endian, memory_region_init_io, section_access_allowed,
+        self, address_space_lookup_section, device_endian, flatview_ref,
+        flatview_translate_section, flatview_unref, memory_region_init_io, section_access_allowed,
         section_covers_region_addr, section_fuzz_dma_read, section_get_host_addr,
         section_rust_load, section_rust_read_continue_step, section_rust_store,
         section_rust_write_continue_step, MEMTX_OK,
@@ -591,3 +593,426 @@ fn get_slice(
         unimplemented!()
     }
 }
+
+/// A safe wrapper around [`bindings::FlatView`].
+///
+/// [`Flaftview`] represents a collection of memory regions, and maps to
+/// [`GuestMemoryRegion`](vm_memory::GuestMemoryRegion).
+///
+/// The memory details are hidden beneath this wrapper. Direct memory access
+/// is not allowed.  Instead, memory access, e.g., write/read/store/load
+/// should process through [`Bytes<GuestAddress>`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
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
+    /// Translate guest address to the offset within a MemoryRegionSection.
+    ///
+    /// Ideally, this helper should be integrated into
+    /// GuestMemory::to_region_addr(), but we haven't reached there yet.
+    fn translate(
+        &self,
+        addr: GuestAddress,
+        len: GuestUsize,
+        is_write: bool,
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
+                is_write,
+                MEMTXATTRS_UNSPECIFIED,
+            )
+        };
+
+        if ptr.is_null() {
+            return None;
+        }
+
+        // SAFETY: the pointer is valid and not NULL.
+        let s = unsafe { <FlatView as GuestMemory>::R::from_raw(ptr) };
+        Some((
+            s,
+            MemoryRegionAddress(raw_addr)
+                .checked_sub(s.deref().offset_within_region)
+                .unwrap(),
+            remain as GuestUsize,
+        ))
+    }
+}
+
+impl Bytes<GuestAddress> for FlatView {
+    type E = GuestMemoryError;
+
+    /// The memory wirte interface based on `FlatView`.
+    ///
+    /// This function is similar to `flatview_write` in C side, but it
+    /// only supports MEMTXATTRS_UNSPECIFIED for now.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    /// Furthermore, it is only for internal use and should not be called
+    /// directly.
+    fn write(&self, buf: &[u8], addr: GuestAddress) -> GuestMemoryResult<usize> {
+        self.try_access(
+            buf.len(),
+            addr,
+            true,
+            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
+                // vm-memory provides an elegent way to advance (See
+                // ReadVolatile::read_volatile), but at this moment,
+                // this simple way is enough.
+                let sub_buf = &buf[offset..offset + count];
+                region.write(sub_buf, caddr)
+            },
+        )
+    }
+
+    /// The memory wirte interface based on `FlatView`.
+    ///
+    /// This function is similar to `flatview_read` in C side, but it
+    /// only supports MEMTXATTRS_UNSPECIFIED for now.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    /// Furthermore, it is only for internal use and should not be called
+    /// directly.
+    fn read(&self, buf: &mut [u8], addr: GuestAddress) -> GuestMemoryResult<usize> {
+        if buf.len() == 0 {
+            return Ok(0);
+        }
+
+        self.try_access(
+            buf.len(),
+            addr,
+            false,
+            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
+                // vm-memory provides an elegent way to advance (See
+                // ReadVolatile::write_volatile), but at this moment,
+                // this simple way is enough.
+                let sub_buf = &mut buf[offset..offset + count];
+                region
+                    .fuzz_dma_read(addr, sub_buf.len() as GuestUsize)
+                    .read(sub_buf, caddr)
+            },
+        )
+    }
+
+    /// The memory store interface based on `FlatView`.
+    ///
+    /// This function supports MEMTXATTRS_UNSPECIFIED, and only supports
+    /// native endian, which means before calling this function, make sure
+    /// the endian of value follows target's endian.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    /// Furthermore, it is only for internal use and should not be called
+    /// directly.
+    fn store<T: AtomicAccess>(
+        &self,
+        val: T,
+        addr: GuestAddress,
+        order: Ordering,
+    ) -> GuestMemoryResult<()> {
+        self.translate(addr, size_of::<T>() as GuestUsize, true)
+            .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
+            .and_then(|(region, region_addr, remain)| {
+                // Though C side handles this cross region case via MMIO
+                // by default, it still looks very suspicious for store/
+                // load. It happens Bytes::store() doesn't support more
+                // argument to identify this case, so report an error
+                // directly!
+                if remain < size_of::<T>() as GuestUsize {
+                    return Err(GuestMemoryError::InvalidBackendAddress);
+                }
+
+                region.store(val, region_addr, order)
+            })
+    }
+
+    /// The memory load interface based on `FlatView`.
+    ///
+    /// This function supports MEMTXATTRS_UNSPECIFIED, and only supports
+    /// native endian, which means the value returned by this function
+    /// follows target's endian.
+    ///
+    /// Note: This function should be called within RCU critical section.
+    /// Furthermore, it is only for internal use and should not be called
+    /// directly.
+    fn load<T: AtomicAccess>(&self, addr: GuestAddress, order: Ordering) -> GuestMemoryResult<T> {
+        self.translate(addr, size_of::<T>() as GuestUsize, false)
+            .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
+            .and_then(|(region, region_addr, remain)| {
+                // Though C side handles this cross region case via MMIO
+                // by default, it still looks very suspicious for store/
+                // load. It happens Bytes::load() doesn't support more
+                // arguments to identify this case, so report an error
+                // directly!
+                if remain < size_of::<T>() as GuestUsize {
+                    return Err(GuestMemoryError::InvalidBackendAddress);
+                }
+
+                region
+                    .fuzz_dma_read(addr, size_of::<T> as GuestUsize)
+                    .load(region_addr, order)
+            })
+    }
+
+    fn write_slice(&self, _buf: &[u8], _addr: GuestAddress) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_slice(&self, _buf: &mut [u8], _addr: GuestAddress) -> GuestMemoryResult<()> {
+        unimplemented!()
+    }
+
+    fn read_volatile_from<F>(
+        &self,
+        _addr: GuestAddress,
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
+        _addr: GuestAddress,
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
+        _addr: GuestAddress,
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
+        _addr: GuestAddress,
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
+impl GuestMemory for FlatView {
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
+    /// This function always triggers panic under debug mode.
+    fn iter(&self) -> impl Iterator<Item = &Self::R> {
+        assert!(false); // Do not use this iter()!
+
+        // QEMU has a linear iteration in C side named `flatview_for_each_range`,
+        // but it iterates `FlatRange` instead of `MemoryRegionSection`.
+        //
+        // It is still possible to have a `Iterator` based on `MemoryRegionSection`,
+        // by iterating `FlatView::dispatch::map::sections`.
+        //
+        // However, it is not worth it. QEMU has implemented the two-level "page"
+        // walk in `phys_page_find`, which is more efficient than linear
+        // iteration. Therefore, there is no need to reinvent the wheel on the
+        // Rust side, at least for now.
+        //
+        // Just return an empty iterator to satisfy the trait's contract.
+        // This makes the code compile, but the iterator won't yield
+        // any items.
+        std::iter::empty()
+    }
+
+    fn to_region_addr(&self, _addr: GuestAddress) -> Option<(&Self::R, MemoryRegionAddress)> {
+        // Note: This method should implement FlatView::translate(), but
+        // its function signature is unfriendly to QEMU's translation. QEMU
+        // needs to distinguish write access or not, and care about the
+        // remianing bytes of the region.
+        //
+        // FIXME: Once GuestMemory::to_region_addr() could meet QEMU's
+        // requirements, move FlatView::translate() here.
+        unimplemented!()
+    }
+
+    /// Try to access a contiguous block of guest memory, executing a callback
+    /// for each memory region that backs the requested address range.
+    ///
+    /// This method is the core of memory access.  It iterates through each
+    /// `MemoryRegionSection` that corresponds to the guest address
+    /// range [`addr`, `addr` + `count`) and invokes the provided closure `f`
+    /// for each section.
+    fn try_access<F>(
+        &self,
+        count: usize,
+        addr: GuestAddress,
+        is_write: bool,
+        mut f: F,
+    ) -> GuestMemoryResult<usize>
+    where
+        F: FnMut(usize, usize, MemoryRegionAddress, &Self::R) -> GuestMemoryResult<usize>,
+    {
+        // FIXME: it's tricky to add more argument in try_access(), e.g.,
+        // attrs. Or maybe it's possible to move try_access() to Bytes trait,
+        // then it can accept a generic type which contains the address and
+        // other arguments.
+
+        if count == 0 {
+            return Ok(count);
+        }
+
+        let mut total = 0;
+        let mut curr = addr;
+
+        while total < count {
+            let len = (count - total) as GuestUsize;
+            let (region, start, remain) = self.translate(curr, len, is_write).unwrap();
+
+            if !region.is_access_allowed(start, remain) {
+                // FIXME: could we return something like MEMTX_ACCESS_ERROR?
+                return Err(GuestMemoryError::InvalidGuestAddress(addr));
+            }
+
+            match f(total as usize, remain as usize, start, region) {
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
+/// A RAII guard that provides temporary access to a `FlatView`.
+///
+/// Upon creation, this guard increments the reference count of the
+/// underlying `FlatView`.  When the guard goes out of of scope, it
+/// automatically decrements the count.
+///
+/// As long as the guard lives, the access to `FlatView` is valid.
+#[derive(Debug)]
+pub struct FlatViewRefGuard(NonNull<FlatView>);
+
+impl Drop for FlatViewRefGuard {
+    fn drop(&mut self) {
+        // SAFETY: the pointer is convertible.
+        unsafe { flatview_unref(self.0.as_ref().as_mut_ptr()) };
+    }
+}
+
+impl FlatViewRefGuard {
+    /// Attempt to create a new RAII guard for the given `FlatView`.
+    ///
+    /// This may fail if the `FlatView`'s reference count is already zero.
+    pub fn new(flat: &FlatView) -> Option<Self> {
+        // SAFETY: the pointer is convertible.
+        if unsafe { flatview_ref(flat.as_mut_ptr()) } {
+            Some(FlatViewRefGuard(NonNull::from(flat)))
+        } else {
+            None
+        }
+    }
+}
+
+impl Deref for FlatViewRefGuard {
+    type Target = FlatView;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: the pointer and reference are convertible.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+
+impl Clone for FlatViewRefGuard {
+    /// Clone the guard, which involves incrementing the reference
+    /// count again.
+    ///
+    /// This method will **panic** if the reference count of the underlying
+    /// `FlatView` cannot be incremented (e.g., if it is zero, meaning the
+    /// object is being destroyed).  This can happen in concurrent scenarios.
+    fn clone(&self) -> Self {
+        FlatViewRefGuard::new(self.deref()).expect(
+            "Failed to clone FlatViewRefGuard: the FlatView may have been destroyed concurrently.",
+        )
+    }
+}
-- 
2.34.1


