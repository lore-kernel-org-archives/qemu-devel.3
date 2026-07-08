Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225E7C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxJ-0007Wt-Mk; Wed, 08 Jul 2026 03:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwt-0006bt-P2; Wed, 08 Jul 2026 03:44:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMwq-0004ox-U9; Wed, 08 Jul 2026 03:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496641; x=1815032641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3mCJsKszdHtSU/aPQHcctoMQ8KRo4ekMhv8giw5BLCs=;
 b=P8AFkMPsIA71EZr24tEIIi018hPqt1jZDGxO78Zxk8dp9vAgoka+LmeR
 eSXlWTCtP9IY93mgvYMJyiJQEGHZvNi8fYycShu65stQGP69qp2lKbvxi
 hmXhQINAQFQlpfUPpx8crOrJ04Ao8leu3naM+Y7U/sP7j2mg5yyzW6ehW
 zqgHSELk61JGC+ejSXaj4ZouQHO0J/+29/w9lMbzCjHYEcMjyV08Exzfr
 4fG+W5wPw/zu7eLumZOuuyC11FLdlMZEGxVtOF4IZhfv4NAJdnOffgo9g
 iBbAsKfnzoWBffCbdG4cLU87ai775pTWft03Hp2SKF8hpvo/dQ49CGDVt A==;
X-CSE-ConnectionGUID: QkULQUr4Qhi+QOtEKcuu0A==
X-CSE-MsgGUID: VAhSSq4yTlWskVcJnQkUrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343400"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343400"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:47 -0700
X-CSE-ConnectionGUID: //3drhTAQPWlhSN9tyluQg==
X-CSE-MsgGUID: 9tWf6NBXTKGeqs/HijHBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556071"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:43 -0700
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
Subject: [RFC v2 20/26] rust/system/memory: Switch to iteration style for
 memory access
Date: Wed,  8 Jul 2026 16:10:46 +0800
Message-Id: <20260708081052.2276617-21-zhao1.liu@intel.com>
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

The vm-memory crate deprecated try_access() and switched to using
get_slices(). Therefore, continuing to access memory in QEMU via a
similar function like try_access_full() is no longer appropriate in
the long run, as it blocks future alignment with vm-memory.

However, QEMU cannot directly use get_slices() because VolatileSlice
does not match QEMU's richer memory backend semantics (which must
support both RAM and MMIO).

To achieve an iteration-style approach similar to get_slices(),
introduce FlatViewChunk to QEMU. Unlike VolatileSlice, FlatViewChunk
does not contain a host address; instead, it records the corresponding
backend memory region (RAM or MMIO).

Building on this, introduce FlatViewChunkIterator as the memory access
iterator. This replaces the original try_access_full() with a graceful
iteration mechanism, providing QEMU with a get_chunks() method
equivalent to vm-memory's get_slices().

While this iteration style adds some structural complexity, it actually
aligns perfectly with the C side's loop logic. Conceptually, the Rust
iterator simply encapsulates the local variables of the C loop into an
iterator state (FlatViewChunkIterator) and a step structure
(FlatViewChunk). Furthermore, this complexity is contained entirely
within the lower-level implementation and remains invisible to
high-level callers.

Finally, this design reflects QEMU's actual requirements and highlights
the gap with the current vm-memory crate. This could inspire vm-memory
to implement a higher-level slice abstraction in the future that
accommodates both VolatileSlice and FlatViewChunk semantics.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New commit to align with the changes in vm-memory v0.18.0.
---
 rust/system/src/memory.rs | 383 ++++++++++++++++++++++++--------------
 1 file changed, 243 insertions(+), 140 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 9772d1444dfb..721b054d778f 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -632,6 +632,146 @@ fn check_address(&self, addr: MemoryRegionAddress) -> Option<MemoryRegionAddress
     }
 }
 
+/// A contiguous part of a guest address range within a single
+/// [`MemoryRegionSection`], inspired by `vm-memory`'s `VolatileSlice`.
+///
+/// QEMU cannot use `VolatileSlice` because it requires a host pointer, which
+/// is not available for MMIO regions. Instead, QEMU needs to record the
+/// `MemoryRegionSection` as the backend to support both RAM and MMIO.
+///
+/// The `(mr, mr_addr, l)` triple corresponds to the loop-local variables used
+/// in the C side's `flatview_read_continue()` and `flatview_write_continue()`.
+/// On the Rust side, these variables are encapsulated into a `FlatViewChunk`
+/// to enable an iterator-based abstraction; the remaining loop variables are
+/// stored in [`FlatViewChunkIterator`].
+#[derive(Debug)]
+struct FlatViewChunk<'a> {
+    /// The section backing this chunk.
+    region: &'a MemoryRegionSection,
+    /// Offset of this chunk within `region`.
+    region_addr: MemoryRegionAddress,
+    /// Length of this chunk, in bytes.
+    len: usize,
+}
+
+/// Iterator over the [`FlatViewChunk`]s covering a guest address range,
+/// inspired by `vm-memory`'s `GuestMemoryBackendSliceIterator`.
+///
+/// It maintains the loop state across iterations, while each
+/// [`FlatViewChunk`] describes the result of a single translation step.
+struct FlatViewChunkIterator<'a> {
+    /// The `FlatView` being iterated.
+    view: &'a FlatView,
+    /// Next guest address still to translate.
+    addr: GuestAddress,
+    /// Bytes still to cover.
+    remaining: usize,
+    /// Requested access mode: whether it is a write or not.
+    access: Permissions,
+    /// Transaction attributes.
+    attrs: MemTxAttrs,
+}
+
+impl<'a> FlatViewChunkIterator<'a> {
+    /// Helper [`Self::next`].  Get the next chunk and update the internal
+    /// state.
+    ///
+    /// This method is inspired by `vm-memory`'s
+    /// `GuestMemorySliceIterator::do_next`.
+    ///
+    /// # Safety
+    ///
+    /// Whether `self.remaining` is 0 is the key condition that determines
+    /// whether the iteration should be terminated.  This function is
+    /// responsible only for the actual execution of the iteration.  The caller
+    /// must ensure the timing and logic for resetting `self.remaining` to 0
+    /// are correct to avoid invalid memory accesses or undefined behavior.
+    unsafe fn do_next(&mut self) -> Option<GuestMemoryResult<FlatViewChunk<'a>>> {
+        if self.remaining == 0 {
+            return None;
+        }
+
+        let (region, region_addr, region_len) = match self.view.translate(
+            self.addr,
+            self.remaining as GuestUsize,
+            self.access,
+            self.attrs,
+        ) {
+            Some(t) => t,
+            None => {
+                return Some(Err(GuestMemoryError::InvalidGuestAddress(self.addr)));
+            }
+        };
+
+        if !region.is_access_allowed(region_addr, region_len, self.attrs) {
+            return Some(Err(GuestMemoryError::InvalidGuestAddress(self.addr)));
+        }
+
+        // A zero-length translation would loop forever.
+        if region_len == 0 {
+            return Some(Err(GuestMemoryError::InvalidGuestAddress(self.addr)));
+        }
+
+        self.remaining -= region_len as usize;
+        if self.remaining > 0 {
+            self.addr = match self.addr.overflowing_add(region_len) {
+                (x @ GuestAddress(0), _) | (x, false) => x,
+                (_, true) => {
+                    return Some(Err(GuestMemoryError::GuestAddressOverflow));
+                }
+            };
+        }
+
+        Some(Ok(FlatViewChunk {
+            region,
+            region_addr,
+            len: region_len as usize,
+        }))
+    }
+
+    /// Adapts the iterator to return `None` when an error occurs after
+    /// at least one successful chunk, halting iteration and yielding a
+    /// partial result.  If an error occurs on the very first chunk, it is
+    /// propagated instead.
+    ///
+    /// This method is inspired by `vm-memory`'s
+    /// `GuestMemorySliceIterator::stop_on_error`.
+    ///
+    /// For QEMU, this implementation is a trade-off. Currently, there is
+    /// no way to report the number of bytes successfully processed within
+    /// `GuestMemoryError`. Returning this partial progress would be much
+    /// more useful than simply returning a bare error type. In the future,
+    /// a richer error type carrying `(bytes_done, cause)` could replace
+    /// this method.
+    fn stop_on_error(self) -> GuestMemoryResult<impl Iterator<Item = FlatViewChunk<'a>>> {
+        let mut peek = self.peekable();
+        if let Some(err) = peek.next_if(GuestMemoryResult::is_err) {
+            return Err(err.unwrap_err());
+        }
+        Ok(peek.filter_map(GuestMemoryResult::ok))
+    }
+}
+
+impl<'a> Iterator for FlatViewChunkIterator<'a> {
+    type Item = GuestMemoryResult<FlatViewChunk<'a>>;
+
+    /// A wrapper for [`Self::do_next`] that permanently stops the iteration on
+    /// error. If an `Err` is returned, it sets `self.remaining` to 0 so that
+    /// all subsequent calls simply return `None`.
+    fn next(&mut self) -> Option<Self::Item> {
+        // SAFETY:
+        // Reset `self.remaining` to 0 on error
+        match unsafe { self.do_next() } {
+            Some(Ok(chunk)) => Some(Ok(chunk)),
+            other => {
+                // On error (or end), reset to 0 so iteration remains stopped
+                self.remaining = 0;
+                other
+            }
+        }
+    }
+}
+
 /// A safe wrapper around [`bindings::FlatView`].
 ///
 /// [`FlatView`] represents a collection of memory regions, and maps to
@@ -705,86 +845,21 @@ fn translate(
         ))
     }
 
-    /// Attempts to access a contiguous block of guest memory, executing a
-    /// callback for each memory region that backs the requested address
-    /// range.
-    ///
-    /// This method is the core of memory access operations.  It iterates
-    /// through each `MemoryRegionSection` that corresponds to the guest
-    /// address range [`addr`, `addr` + `count`) and invokes the provided
-    /// closure `f` for each section.
-    ///
-    /// This method is a variant of `GuestMemoryBackend::try_access()`, but it
-    /// includes additional permissions (`Permissions`) and memory transaction
-    /// attributes (`MemTxAttrs`).  Since `GuestMemoryBackend::try_access()` was
-    /// deprecated in `vm-memory` v0.18.0, `try_access_full()` is implemented
-    /// directly as an intrinsic method of [`FlatView`].
-    ///
-    /// The callback follows the `try_access()` semantics of `vm-memory`: an
-    /// `Err` stops the loop immediately.  Note that this differs from the
-    /// C side (`flatview_read_continue()` / `flatview_write_continue()`),
-    /// which accumulates `MemTxResult` errors and continues accessing
-    /// subsequent memory regions.
-    fn try_access_full<F>(
+    /// Returns a lazy iterator over the [`FlatViewChunk`]s, inspired by
+    /// vm-memory's `get_slices()`.
+    fn get_chunks(
         &self,
-        count: usize,
         addr: GuestAddress,
+        count: usize,
         access: Permissions,
         attrs: MemTxAttrs,
-        mut f: F,
-    ) -> GuestMemoryResult<usize>
-    where
-        F: FnMut(
-            usize,
-            usize,
-            MemoryRegionAddress,
-            &MemoryRegionSection,
-        ) -> GuestMemoryResult<usize>,
-    {
-        if count == 0 {
-            return Ok(count);
-        }
-
-        let mut total = 0;
-        let mut curr = addr;
-
-        while total < count {
-            let len = (count - total) as GuestUsize;
-            let (region, start, remain) = self.translate(curr, len, access, attrs).unwrap();
-
-            if !region.is_access_allowed(start, remain, attrs) {
-                return Err(GuestMemoryError::InvalidGuestAddress(addr));
-            }
-
-            match f(total, remain as usize, start, region) {
-                // no more data
-                Ok(0) => return Ok(total),
-                // made some progress
-                Ok(res) => {
-                    if res as GuestUsize > remain {
-                        return Err(GuestMemoryError::CallbackOutOfRange);
-                    }
-
-                    total = match total.checked_add(res) {
-                        Some(x) if x < count => x,
-                        Some(x) if x == count => return Ok(x),
-                        _ => return Err(GuestMemoryError::CallbackOutOfRange),
-                    };
-
-                    curr = match curr.overflowing_add(res as GuestUsize) {
-                        (x @ GuestAddress(0), _) | (x, false) => x,
-                        (_, true) => return Err(GuestMemoryError::GuestAddressOverflow),
-                    };
-                }
-                // error happened
-                e => return e,
-            }
-        }
-
-        if total == 0 {
-            Err(GuestMemoryError::InvalidGuestAddress(addr))
-        } else {
-            Ok(total)
+    ) -> FlatViewChunkIterator<'_> {
+        FlatViewChunkIterator {
+            view: self,
+            addr,
+            remaining: count,
+            access,
+            attrs,
         }
     }
 }
@@ -807,19 +882,32 @@ fn write(
         buf: &[u8],
         (addr, attrs): (GuestAddress, MemTxAttrs),
     ) -> GuestMemoryResult<usize> {
-        self.try_access_full(
-            buf.len(),
-            addr,
-            Permissions::Write,
-            attrs,
-            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
-                // vm-memory provides an elegent way to advance (See
-                // ReadVolatile::read_volatile), but at this moment,
-                // this simple way is enough.
-                let sub_buf = &buf[offset..offset + count];
-                Bytes::write(region, sub_buf, (caddr, attrs))
-            },
-        )
+        let completed = self
+            .get_chunks(addr, buf.len(), Permissions::Write, attrs)
+            .stop_on_error()?
+            .try_fold(0, |acc, chunk| {
+                let sub_buf = &buf[acc..acc + chunk.len];
+                let n = Bytes::write(chunk.region, sub_buf, (chunk.region_addr, attrs))?;
+                // Since the iterator has already advanced past it, the
+                // incomplete write results in the wrong buffer offset.
+                if n != chunk.len {
+                    return Err(GuestMemoryError::PartialBuffer {
+                        expected: buf.len(),
+                        completed: acc + n,
+                    });
+                }
+                Ok(acc + n)
+            })?;
+
+        // `stop_on_error` silently truncates the iterator if `next()` returns
+        // an error.  Convert this into a `PartialBuffer` error.
+        if completed != buf.len() {
+            return Err(GuestMemoryError::PartialBuffer {
+                expected: buf.len(),
+                completed,
+            });
+        }
+        Ok(completed)
     }
 
     /// Read a byte buffer from guest memory, similar to `flatview_read` on
@@ -836,27 +924,36 @@ fn read(
         buf: &mut [u8],
         (addr, attrs): (GuestAddress, MemTxAttrs),
     ) -> GuestMemoryResult<usize> {
-        if buf.is_empty() {
-            return Ok(0);
+        let expected = buf.len();
+        let completed = self
+            .get_chunks(addr, expected, Permissions::Read, attrs)
+            .stop_on_error()?
+            .try_fold(0, |acc, chunk| {
+                let sub_buf = &mut buf[acc..acc + chunk.len];
+                let region = chunk
+                    .region
+                    .fuzz_dma_read(addr, sub_buf.len() as GuestUsize);
+                let n = Bytes::read(region, sub_buf, (chunk.region_addr, attrs))?;
+                // Since the iterator has already advanced past it, the
+                // incomplete read results in the wrong buffer offset.
+                if n != chunk.len {
+                    return Err(GuestMemoryError::PartialBuffer {
+                        expected,
+                        completed: acc + n,
+                    });
+                }
+                Ok(acc + n)
+            })?;
+
+        // `stop_on_error` silently truncates the iterator if `next()` returns
+        // an error.  Convert this into a `PartialBuffer` error.
+        if completed != expected {
+            return Err(GuestMemoryError::PartialBuffer {
+                expected,
+                completed,
+            });
         }
-
-        self.try_access_full(
-            buf.len(),
-            addr,
-            Permissions::Read,
-            attrs,
-            |offset, count, caddr, region| -> GuestMemoryResult<usize> {
-                // vm-memory provides an elegent way to advance (See
-                // ReadVolatile::write_volatile), but at this moment,
-                // this simple way is enough.
-                let sub_buf = &mut buf[offset..offset + count];
-                Bytes::read(
-                    region.fuzz_dma_read(addr, sub_buf.len() as GuestUsize),
-                    sub_buf,
-                    (caddr, attrs),
-                )
-            },
-        )
+        Ok(completed)
     }
 
     /// Store a value into guest memory at `addr`.  It is only for internal
@@ -869,24 +966,25 @@ fn store<T: AtomicAccess>(
         (addr, attrs): (GuestAddress, MemTxAttrs),
         order: Ordering,
     ) -> GuestMemoryResult<()> {
-        self.translate(
-            addr,
-            size_of::<T>() as GuestUsize,
-            Permissions::Write,
-            attrs,
-        )
-        .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
-        .and_then(|(region, region_addr, remain)| {
-            // Although the C side handles this cross-region case via MMIO
-            // by default, it is highly suspicious for store/load operations.
-            // Since Bytes::store() does not support additional arguments to
-            // identify this scenario, report an error directly!
-            if remain < size_of::<T>() as GuestUsize {
-                return Err(GuestMemoryError::InvalidBackendAddress);
-            }
+        match self
+            .get_chunks(addr, size_of::<T>(), Permissions::Write, attrs)
+            .next() // Compared to C, this includes additional checks for access and overflow.
+        {
+            None => Err(GuestMemoryError::InvalidGuestAddress(addr)),
+            Some(Err(e)) => Err(e),
+            Some(Ok(chunk)) => {
+                // Though C side handles this cross region case via MMIO
+                // by default, it still looks very suspicious for store/
+                // load. It happens Bytes::store() doesn't support more
+                // argument to identify this case, so report an error
+                // directly!
+                if chunk.len < size_of::<T>() {
+                    return Err(GuestMemoryError::InvalidBackendAddress);
+                }
 
-            Bytes::store(region, val, (region_addr, attrs), order)
-        })
+                Bytes::store(chunk.region, val, (chunk.region_addr, attrs), order)
+            }
+        }
     }
 
     /// Load a value from guest memory at `addr`.  It is only for internal
@@ -898,23 +996,28 @@ fn load<T: AtomicAccess>(
         (addr, attrs): (GuestAddress, MemTxAttrs),
         order: Ordering,
     ) -> GuestMemoryResult<T> {
-        self.translate(addr, size_of::<T>() as GuestUsize, Permissions::Read, attrs)
-            .ok_or(GuestMemoryError::InvalidGuestAddress(addr))
-            .and_then(|(region, region_addr, remain)| -> GuestMemoryResult<T> {
-                // Although the C side handles this cross-region case via MMIO
-                // by default, it is highly suspicious for store/load operations.
-                // Since Bytes::load() does not support additional arguments to
-                // identify this scenario, report an error directly!
-                if remain < size_of::<T>() as GuestUsize {
+        match self
+            .get_chunks(addr, size_of::<T>(), Permissions::Read, attrs)
+            .next() // Compared to C, this includes additional checks for access and overflow.
+        {
+            None => Err(GuestMemoryError::InvalidGuestAddress(addr)),
+            Some(Err(e)) => Err(e),
+            Some(Ok(chunk)) => {
+                // Though C side handles this cross region case via MMIO
+                // by default, it still looks very suspicious for store/
+                // load. It happens Bytes::load() doesn't support more
+                // arguments to identify this case, so report an error
+                // directly!
+                if chunk.len < size_of::<T>() {
                     return Err(GuestMemoryError::InvalidBackendAddress);
                 }
 
-                Bytes::load(
-                    region.fuzz_dma_read(addr, size_of::<T>() as GuestUsize),
-                    (region_addr, attrs),
-                    order,
-                )
-            })
+                let region = chunk
+                    .region
+                    .fuzz_dma_read(addr, size_of::<T>() as GuestUsize);
+                Bytes::load(region, (chunk.region_addr, attrs), order)
+            }
+        }
     }
 
     fn write_slice(&self, _buf: &[u8], _addr: (GuestAddress, MemTxAttrs)) -> GuestMemoryResult<()> {
-- 
2.34.1


