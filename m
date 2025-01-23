Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AB5C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 16:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tazot-00020U-Or; Thu, 23 Jan 2025 11:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tazor-0001zj-AE; Thu, 23 Jan 2025 11:12:37 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tazoo-0000Ar-Lo; Thu, 23 Jan 2025 11:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737648755; x=1769184755;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tYhUpgqm3nvU5B3a10P7LcCb/l6h12GQjhqy7WIa2OM=;
 b=clKToP3Ub7nn8EEHIp8Teu0KCuDzYYIyrQEz1ttnSB3NCNTpiD7aPd8v
 VHp8WdaiMOb3wwHqcNQka1zg6bzqMNytbbRV6KJ407dHXRhXK7wPClWbU
 C/FCYJnL9OhCICxqj/FjlOqPzsTCHfamRXKrUSwn0WuTRtnAsobLcPldB
 Ae2oMKL+XW/XMk51n0+Fm9AOs5HtovyxoB2Ot44ioOCB++jo3pejIzNmF
 wKPxQXFCFfun/0uCf9seNsQ8DMrlwLcxPxm8OlzeFWAm9dkQyrsvcigba
 B+YnOb/Ov58jWWCYC09LG6Dap2yNW1soJ+9F//5XFO8JQnU5HtUwNry/E A==;
X-CSE-ConnectionGUID: AeFF3WLXRT2juNSW7kQJig==
X-CSE-MsgGUID: 7urbIStoRZC/9kPYqmEV9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37414582"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="37414582"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 08:12:31 -0800
X-CSE-ConnectionGUID: cC3ePLHnRsWaVNWKjl7jSg==
X-CSE-MsgGUID: 2A/nTWkqRVCSWGB1bEvZ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107923654"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 23 Jan 2025 08:12:30 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust/zeroable: Implement Zeroable with const_zero macro
Date: Fri, 24 Jan 2025 00:31:43 +0800
Message-Id: <20250123163143.679841-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

`const_zero` crate provides a nice macro to zero type-specific
constants, which doesn't need to enumerates the fields one by one.

Introduce `const_zero` macro to QEMU (along with its documentation), and
use it to simplify the implementation of `Zeroable` trait.

This is valid since current types that require `Zeroable` support can
be safely zeroed using `zero_const`.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
* Based on the commit d3e2a17bb809 ("rust: qemu-api: add sub-subclass to
  the integration tests") of Paolo's rust-next.
---
 rust/qemu-api/src/zeroable.rs | 132 +++++++++++++++-------------------
 1 file changed, 56 insertions(+), 76 deletions(-)

diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 57cac96de06f..688ee8b059f2 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -1,13 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ptr;
-
 /// Encapsulates the requirement that
 /// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
 /// behavior.  This trait in principle could be implemented as just:
 ///
 /// ```
-/// pub unsafe trait Zeroable: Default {
+/// pub unsafe trait Zeroable {
 ///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
 /// }
 /// ```
@@ -29,23 +27,56 @@ pub unsafe trait Zeroable: Default {
     const ZERO: Self;
 }
 
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {
-    const ZERO: Self = Self { i: 0 };
+/// A marco that acts similarly to [`core::mem::zeroed()`], only is const
+///
+/// ## Safety
+/// Similar to `core::mem::zeroed()`, except this zeroes padding bits. Zeroed
+/// padding usually isn't relevant to safety, but might be if a C union is used.
+/// To repeat `core::mem::zeroed()`'s safety, an all zero byte pattern might not
+/// be a valid value for a type; for example, references &T, &mut T.
+///
+/// const_zero does not work on unsized types
+/// ```rust compile_fail
+/// use const_zero::const_zero;
+/// // error[E0277]: the size for values of type `[u8]` cannot be known at compilation time
+/// const BYTES: [u8] = unsafe{const_zero!([u8])};
+/// ```
+/// reference types trigger a (denied by default) lint and cause immediate
+/// undefined behavior if the lint is ignored
+/// ```rust compile_fail
+/// use const_zero::const_zero;
+/// // error: any use of this value will cause an error
+/// // note: `#[deny(const_err)]` on by default
+/// const STR: &str = unsafe{const_zero!(&'static str)};
+/// ```
+///
+/// ## Differences with `core::mem::zeroed`
+/// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+macro_rules! const_zero {
+    // This macro to zero type-specific constants comes from const_zero crate (v0.1.1):
+    //
+    //     https://docs.rs/const-zero/latest/src/const_zero/lib.rs.html
+    //
+    // used under MIT license
+    ($type_:ty) => {{
+        const TYPE_SIZE: ::core::primitive::usize = ::core::mem::size_of::<$type_>();
+        union TypeAsBytes {
+            bytes: [::core::primitive::u8; TYPE_SIZE],
+            inner: ::core::mem::ManuallyDrop<$type_>,
+        }
+        const ZERO_BYTES: TypeAsBytes = TypeAsBytes {
+            bytes: [0; TYPE_SIZE],
+        };
+        ::core::mem::ManuallyDrop::<$type_>::into_inner(ZERO_BYTES.inner)
+    }};
 }
 
-unsafe impl Zeroable for crate::bindings::Property {
-    const ZERO: Self = Self {
-        name: ptr::null(),
-        info: ptr::null(),
-        offset: 0,
-        bitnr: 0,
-        bitmask: 0,
-        set_default: false,
-        defval: Zeroable::ZERO,
-        arrayoffset: 0,
-        arrayinfo: ptr::null(),
-        arrayfieldsize: 0,
-        link_type: ptr::null(),
+/// A wrapper to implement `Zeroable` trait by `const_zero` macro.
+macro_rules! impl_zeroable {
+    ($type:ty) => {
+        unsafe impl Zeroable for $type {
+            const ZERO: Self = unsafe { const_zero!($type) };
+        }
     };
 }
 
@@ -57,61 +88,10 @@ fn default() -> Self {
     }
 }
 
-unsafe impl Zeroable for crate::bindings::VMStateFlags {
-    const ZERO: Self = Self(0);
-}
-
-unsafe impl Zeroable for crate::bindings::VMStateField {
-    const ZERO: Self = Self {
-        name: ptr::null(),
-        err_hint: ptr::null(),
-        offset: 0,
-        size: 0,
-        start: 0,
-        num: 0,
-        num_offset: 0,
-        size_offset: 0,
-        info: ptr::null(),
-        flags: Zeroable::ZERO,
-        vmsd: ptr::null(),
-        version_id: 0,
-        struct_version_id: 0,
-        field_exists: None,
-    };
-}
-
-unsafe impl Zeroable for crate::bindings::VMStateDescription {
-    const ZERO: Self = Self {
-        name: ptr::null(),
-        unmigratable: false,
-        early_setup: false,
-        version_id: 0,
-        minimum_version_id: 0,
-        priority: crate::bindings::MigrationPriority::MIG_PRI_DEFAULT,
-        pre_load: None,
-        post_load: None,
-        pre_save: None,
-        post_save: None,
-        needed: None,
-        dev_unplug_pending: None,
-        fields: ptr::null(),
-        subsections: ptr::null(),
-    };
-}
-
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {
-    const ZERO: Self = Self {
-        min_access_size: 0,
-        max_access_size: 0,
-        unaligned: false,
-        accepts: None,
-    };
-}
-
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {
-    const ZERO: Self = Self {
-        min_access_size: 0,
-        max_access_size: 0,
-        unaligned: false,
-    };
-}
+impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
+impl_zeroable!(crate::bindings::Property);
+impl_zeroable!(crate::bindings::VMStateFlags);
+impl_zeroable!(crate::bindings::VMStateField);
+impl_zeroable!(crate::bindings::VMStateDescription);
+impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
+impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
-- 
2.34.1


