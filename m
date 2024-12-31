Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A28AE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3E-0003R1-M9; Mon, 30 Dec 2024 19:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3D-0003Pa-24
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3A-0001z0-E4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQ9f8TEIbiidaBdHdliac2j4M4b1C9RXDFq4BMn1MtE=;
 b=Musl+y6YGMJvPh61snKWpXiTBwMJv5vP1XOQVvKGmXMTQ56i2k4k5V5QvXNrJjbIfLTTu4
 HtzVL1KFGwQUdAukdT0e4+WSLkwZuVW0zLA9ouiPLbJdHOj7sW8FThMIVg9vHahq8Sjo/t
 YqQuVg5WP+Zy2/qCU0URuSDvlYyR0lo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-rzZQWKntM6uZ2kdcR408mg-1; Mon, 30 Dec 2024 19:23:54 -0500
X-MC-Unique: rzZQWKntM6uZ2kdcR408mg-1
X-Mimecast-MFC-AGG-ID: rzZQWKntM6uZ2kdcR408mg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43635895374so47767195e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604632; x=1736209432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQ9f8TEIbiidaBdHdliac2j4M4b1C9RXDFq4BMn1MtE=;
 b=CNn890n07pEa3k7GDnfYcspzi+hdXmcIy2hQT39Apedg05WjM8+ft3XsjieyM0j5ag
 yOkjQJACkFlWTEimM2BJ2jkN5S/sSPbfbwK/QjtnSmcZ8yb8sQyeaxC3+xzK1BPSAl8i
 c38xuXYvMLV9su8SqsQgPtE/cIX1gZ9f+mRgFpa8JMdJVoS48mqZTNGWQ0CbmIhWCAbr
 Qa7UpNYd0H/r57pS7yFa6KQlJMp0dDgTIwgLJliOHcpzX1ZA0aMcT/dy4ErDYfT1jMRV
 jTcxL2MFfMoDZBRXRam3LN05ipK81i7Z3yf8qiuy5yYJv3tU2ei2iGKyiDzwfae03Hgl
 3UdQ==
X-Gm-Message-State: AOJu0Ywc54kcTrT0TUT3+Y1v/63m9niKiUn2Nhg90xChQj+fz+gwoXvJ
 9lCi0w5yY2hTCb8VB+CTafASwuFcXamkAzh0KybJCsq4s884YyZHSs5udNNRteRFBJkPYnn/5DX
 6iy5H/ulmiK6UQSlqKx4iWvLzOi8K+dKSKY1dYh8fpShHg2PiH0H9jFjnAO1o0LKRynIRtA5aYv
 QZPWheaVNBcLWm8OSkAtVq0/HwcKAqg/eZwk74VU4=
X-Gm-Gg: ASbGncsvHzO3Ai97LuqLaz0F/fClamL1T9LULID/CxZWINHs0MFpdzs9xW4oK8VpTwm
 +IDQ6UX3nnfWLr3dJ9mtNxGZ0Foil/fHg34WtruzXJL9w02wVbWJmQh4vEcAsEYl+ZDT9rCvfzt
 4UZP1XUl1UqMmVZSeWMcDg7aZajLbKl4oKv0+kc9BZcsYMNSXjBQ48UIVu9IXMecgDB2HJW0xQy
 hjlRMGr7iiZSkbWq0eghJl93rKvuUJ2pgQCu3pgvto0RTEGpGbxqJClTjA=
X-Received: by 2002:a05:6000:1569:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-38a22a648f7mr27522049f8f.27.1735604631631; 
 Mon, 30 Dec 2024 16:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXRkrAOdJIh9dRizoOccNa1BQJwzUhNZq9xlXOOZ6F4+nA5NEw9V7RQsz/zLaw5QqEfvQ7yQ==
X-Received: by 2002:a05:6000:1569:b0:386:3327:4f21 with SMTP id
 ffacd0b85a97d-38a22a648f7mr27522034f8f.27.1735604631244; 
 Mon, 30 Dec 2024 16:23:51 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm32122371f8f.81.2024.12.30.16.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 5/9] rust: vmstate: implement VMState for scalar types
Date: Tue, 31 Dec 2024 01:23:32 +0100
Message-ID: <20241231002336.25931-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Scalar types are those that have their own VMStateInfo.  This poses
a problem in that references to VMStateInfo can only be included in
associated consts starting with Rust 1.83.0, when the const_refs_static
was stabilized.  Removing the requirement is done by placing a limited
list of VMStateInfos in an enum, and going from enum to &VMStateInfo
only when building the VMStateField.

The same thing cannot be done with VMS_STRUCT because the set of
VMStateDescriptions extends to structs defined by the devices.
Therefore, structs and cells cannot yet use vmstate_of!.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 125 ++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 49d0a3c31d4..edd0cbff162 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -21,8 +21,11 @@
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
-pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::bindings::VMStateFlags;
+pub use crate::{
+    bindings::{self, VMStateDescription, VMStateField},
+    zeroable::Zeroable,
+};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -58,6 +61,70 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
     };
 }
 
+/// Workaround for lack of `const_refs_static`: references to global variables
+/// can be included in a `static`, but not in a `const`; unfortunately, this
+/// is exactly what would go in the `VMStateField`'s `info` member.
+///
+/// This enum contains the contents of the `VMStateField`'s `info` member,
+/// but as an `enum` instead of a pointer.
+#[allow(non_camel_case_types)]
+pub enum VMStateFieldType {
+    null,
+    vmstate_info_bool,
+    vmstate_info_int8,
+    vmstate_info_int16,
+    vmstate_info_int32,
+    vmstate_info_int64,
+    vmstate_info_uint8,
+    vmstate_info_uint16,
+    vmstate_info_uint32,
+    vmstate_info_uint64,
+    vmstate_info_timer,
+}
+
+/// Workaround for lack of `const_refs_static`.  Converts a `VMStateFieldType`
+/// to a `*const VMStateInfo`, for inclusion in a `VMStateField`.
+#[macro_export]
+macro_rules! info_enum_to_ref {
+    ($e:expr) => {
+        unsafe {
+            match $e {
+                $crate::vmstate::VMStateFieldType::null => ::core::ptr::null(),
+                $crate::vmstate::VMStateFieldType::vmstate_info_bool => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_bool)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int8 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int8)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int16 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int16)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int32 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_int64 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_int64)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint8 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint8)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint16 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint16)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint32 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_uint64 => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint64)
+                }
+                $crate::vmstate::VMStateFieldType::vmstate_info_timer => {
+                    ::core::ptr::addr_of!($crate::bindings::vmstate_info_timer)
+                }
+            }
+        }
+    };
+}
+
 /// A trait for types that can be included in a device's migration stream.  It
 /// provides the base contents of a `VMStateField` (minus the name and offset).
 ///
@@ -66,6 +133,12 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker:
 /// The contents of this trait go straight into structs that are parsed by C
 /// code and used to introspect into other structs.  Be careful.
 pub unsafe trait VMState {
+    /// The `info` member of a `VMStateField` is a pointer and as such cannot
+    /// yet be included in the [`BASE`](VMState::BASE) associated constant;
+    /// this is only allowed by Rust 1.83.0 and newer.  For now, include the
+    /// member as an enum which is stored in a separate constant.
+    const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::null;
+
     /// The base contents of a `VMStateField` (minus the name and offset) for
     /// the type that is implementing the trait.
     const BASE: VMStateField;
@@ -80,6 +153,12 @@ pub unsafe trait VMState {
     };
 }
 
+/// Internal utility function to retrieve a type's `VMStateFieldType`;
+/// used by [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_scalar_type<T: VMState>(_: PhantomData<T>) -> VMStateFieldType {
+    T::SCALAR_TYPE
+}
+
 /// Internal utility function to retrieve a type's `VMStateField`;
 /// used by [`vmstate_of!`](crate::vmstate_of).
 pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
@@ -96,11 +175,20 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField
 /// Return the `VMStateField` for a field of a struct.  The field must be
 /// visible in the current scope.
 ///
+/// Only a limited set of types is supported out of the box:
+/// * scalar types (integer and `bool`)
+/// * the C struct `QEMUTimer`
+/// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
+///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
+/// * a raw pointer to any of the above
+/// * a `NonNull` pointer to any of the above, possibly wrapped with `Option`
+/// * an array of any of the above
+///
 /// In order to support other types, the trait `VMState` must be implemented
 /// for them.
 #[macro_export]
 macro_rules! vmstate_of {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:tt $(* $factor:expr)?])? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -109,6 +197,11 @@ macro_rules! vmstate_of {
             $(.num_offset: $crate::offset_of!($struct_name, $num),)?
             // The calls to `call_func_with_field!` are the magic that
             // computes most of the VMStateField from the type of the field.
+            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
+                $crate::vmstate::vmstate_scalar_type,
+                $struct_name,
+                $field_name
+            )),
             ..$crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
@@ -175,6 +268,7 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const SCALAR_TYPE: VMStateFieldType = <$base as VMState>::SCALAR_TYPE;
             const BASE: VMStateField = VMStateField {
                 size: mem::size_of::<$type>(),
                 ..<$base as VMState>::BASE
@@ -189,6 +283,33 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 
+// Scalar types using predefined VMStateInfos
+
+macro_rules! impl_vmstate_scalar {
+    ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
+        unsafe impl VMState for $type {
+            const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::$info;
+            const BASE: VMStateField = VMStateField {
+                size: mem::size_of::<$type>(),
+                flags: VMStateFlags::VMS_SINGLE,
+                ..Zeroable::ZERO
+            };
+            $(const VARRAY_FLAG: VMStateFlags = VMStateFlags::$varray_flag;)?
+        }
+    };
+}
+
+impl_vmstate_scalar!(vmstate_info_bool, bool);
+impl_vmstate_scalar!(vmstate_info_int8, i8);
+impl_vmstate_scalar!(vmstate_info_int16, i16);
+impl_vmstate_scalar!(vmstate_info_int32, i32);
+impl_vmstate_scalar!(vmstate_info_int64, i64);
+impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY_UINT8);
+impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
+impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
+impl_vmstate_scalar!(vmstate_info_uint64, u64);
+impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
+
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 
 macro_rules! impl_vmstate_pointer {
-- 
2.47.1


