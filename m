Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21F5C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGI8-00054K-2Z; Fri, 24 Jan 2025 04:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGe-0007zG-P4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGa-00040y-Rm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohg5OnpD+mvfyDVr/6jK+jcwElKVKW8I4Rdj5udNnOk=;
 b=APs502RdPcG17vG6RB2hBKrcWiTg925bT1/SBKQKoWnNS9Z/TwpkUQ7k8UQpGXKr4OT/jl
 Sdzeq7oaxp6ZFYe2K+kft+dF5ZsKCF0E1JHJikvR20QXE95iirt5EjieqE34/KZNWL7JMh
 wS8Rb38Pp/0yzS7YOAtryBLXpXaCDwE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-1TY6_MnGMGO3TiZCOz3-lQ-1; Fri, 24 Jan 2025 04:46:17 -0500
X-MC-Unique: 1TY6_MnGMGO3TiZCOz3-lQ-1
X-Mimecast-MFC-AGG-ID: 1TY6_MnGMGO3TiZCOz3-lQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so14701225e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711975; x=1738316775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohg5OnpD+mvfyDVr/6jK+jcwElKVKW8I4Rdj5udNnOk=;
 b=duU227zRShnw0QtBqaXdn9hKo+l/OiKL+jDoHBwy6G0PQeQ2AVu9ETrmRgePpA1PI0
 +chmddtb7+Xc9aDBajEuQuhgOckWVcn3ii1t3QK1FxPthgXs27brwf9nhpmY6Hl6Hfc3
 Mc/9B3e1BpPwRRKSo1Lt1gW7wOPsNF1OjEp/FItsQXnh56Nt3uu1cWByf61Ut7MUXdgf
 7FIsDzMKja+Lnu+N2Go4Go8DsyvbZHjAGDM4rrSi96S0bGuItb/EC6iI7Q0v8RQi4iYR
 L7m3/FGlpqXIdrECsRAJKftzvulYhPcM2JoNOH9aels8/Fb1A7fIuPsrnPZozWUACp6s
 plcQ==
X-Gm-Message-State: AOJu0YwuBVTyfKp8BxNKXeDPdbki1U2D8WcENafDQObaG2adGZyT12C2
 4SyC6XyJLMvyhDd5wdnoYcguGQqZi/J7yGpFABp3PIR1WkdKVCR27itZLb5A0WUKY1gQE7tQwS/
 xLOuvq227z5zfQJL4IW9DCMLVWSbESDZGnRWFcTN1h3n9Ap7yMiXA1iLk4UUV9IvaV4AI86X381
 lEH5vgJkRdOB39W7h4oLiArtx73sOQMnobXlmYyMc=
X-Gm-Gg: ASbGnctqEdd6Yg2eMuJnvAY8ZXyqZGgjbJhz2biMa915pvb3WVgW/UAZaNuMP+blo6y
 7MOfA1YdVBiwuFwQ+G5yDXhCx07PnaSeGT1sQY7nXb1qqHe/Qv1Z9YNdNH8ZOQkHSdvX6m0bbwb
 ps9t+zqngAVUAjVqMaebl73U2EuTwvT3XQ3sGBk/SmulGapzY2kzjYSs+V2FygHHnpN75NOt9t4
 CUORS9kRMZokPuTFkzMzuJ3cD1+WflC8vXPyYu2VNdBfaIqF/j2CWZlZqHyD5YTsKXLEzl4mQ==
X-Received: by 2002:a05:600c:21d8:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-438bd0bca9amr24646095e9.13.1737711975457; 
 Fri, 24 Jan 2025 01:46:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaQMD872HSJ7oNUvzxx8TYuhffIXBnNk59r9n2YzNcPiSCU2DDk5UQ9CQsTnsFL1XSLQIFAQ==
X-Received: by 2002:a05:600c:21d8:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-438bd0bca9amr24645785e9.13.1737711975028; 
 Fri, 24 Jan 2025 01:46:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501721sm19993645e9.9.2025.01.24.01.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:46:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 47/48] rust/zeroable: Implement Zeroable with const_zero macro
Date: Fri, 24 Jan 2025 10:44:41 +0100
Message-ID: <20250124094442.13207-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The `const_zero` crate provides a nice macro to zero type-specific
constants, which doesn't need to enumerates the fields one by one.

Introduce the `const_zero` macro to QEMU (along with its documentation), and
use it to simplify the implementation of `Zeroable` trait.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250123163143.679841-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/zeroable.rs | 137 +++++++++++++++-------------------
 1 file changed, 61 insertions(+), 76 deletions(-)

diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 57cac96de06..7b04947cb6c 100644
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
@@ -29,23 +27,61 @@ pub unsafe trait Zeroable: Default {
     const ZERO: Self;
 }
 
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {
-    const ZERO: Self = Self { i: 0 };
+/// A macro that acts similarly to [`core::mem::zeroed()`], only is const
+///
+/// ## Safety
+///
+/// Similar to `core::mem::zeroed()`, except this zeroes padding bits. Zeroed
+/// padding usually isn't relevant to safety, but might be if a C union is used.
+///
+/// Just like for `core::mem::zeroed()`, an all zero byte pattern might not
+/// be a valid value for a type, as is the case for references `&T` and `&mut
+/// T`. Reference types trigger a (denied by default) lint and cause immediate
+/// undefined behavior if the lint is ignored
+///
+/// ```rust compile_fail
+/// use const_zero::const_zero;
+/// // error: any use of this value will cause an error
+/// // note: `#[deny(const_err)]` on by default
+/// const STR: &str = unsafe{const_zero!(&'static str)};
+/// ```
+///
+/// `const_zero` does not work on unsized types:
+///
+/// ```rust compile_fail
+/// use const_zero::const_zero;
+/// // error[E0277]: the size for values of type `[u8]` cannot be known at compilation time
+/// const BYTES: [u8] = unsafe{const_zero!([u8])};
+/// ```
+/// ## Differences with `core::mem::zeroed`
+///
+/// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+macro_rules! const_zero {
+    // This macro to produce a type-generic zero constant is taken from the
+    // const_zero crate (v0.1.1):
+    //
+    //     https://docs.rs/const-zero/latest/src/const_zero/lib.rs.html
+    //
+    // and used under MIT license
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
+/// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
+macro_rules! impl_zeroable {
+    ($type:ty) => {
+        unsafe impl Zeroable for $type {
+            const ZERO: Self = unsafe { const_zero!($type) };
+        }
     };
 }
 
@@ -57,61 +93,10 @@ fn default() -> Self {
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
2.48.1


