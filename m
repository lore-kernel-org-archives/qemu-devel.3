Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D48DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByh-0006XI-DE; Thu, 19 Dec 2024 03:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByc-0006IV-G2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByU-0005EZ-Pm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqWzh2h1UvpMsoMNNGnTwlEeWlCR/rC8pyJNwgBOdls=;
 b=C+fqFL4Bvk4jK5rs08jQ/VoyeHiWwWmKlLKpFqZk/oxnR5z097uTaGdBIp5r4MMao8gGDs
 gJYvXUQqAQk/6f60nQjDkHLsppmb/g2dEfkrAljW+ui8wr3ZN6L1tbr+sIj3Zi8ViDskLC
 endlTvl+mVXk6oaH6lEddkNVXfWsCxY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-gl-Yzr8oP420DgZaq_5-Kw-1; Thu, 19 Dec 2024 03:33:36 -0500
X-MC-Unique: gl-Yzr8oP420DgZaq_5-Kw-1
X-Mimecast-MFC-AGG-ID: gl-Yzr8oP420DgZaq_5-Kw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so4594735e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597215; x=1735202015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqWzh2h1UvpMsoMNNGnTwlEeWlCR/rC8pyJNwgBOdls=;
 b=LWtDbKj+EH+m6gcygtgA3+4Evz98yBa+H2RrwAo5mp/W1qw58xY+yG51wm0etyaNYZ
 34/k82T9DLv8+SK9vWlvy+p6TnOVJWvr6GMgpjZOvMBb0k0Cs7RGDx4kH8oDtQXw1PGO
 dQ9akwFvMJ6Dy/sTfREIZJ/s1wWQKOhhLKrM5iSPKrJDOoD2qmniPEqHfqukaSs9SsP2
 wQVzLuF5s3svlPC5X/g6+sCzpnxmxuHaiDxkqgOaHS4AiDvmjnPODL2jANg897aFFt+a
 9sNEqNgcOSJ4yQCi8u3IM5QyES8Q8y4YgZ52EY3hrYL1mRRfuqv163IxNhZBJ1sKQfCl
 MxZA==
X-Gm-Message-State: AOJu0YyXBgjGVW9hdnV/wWYpI3lxH5qrcOD0z+8v97wz9HGAe50Wv8J+
 rb+pXU6owQBGOQ8vonNf1MByBwdbI51sPnr6FVm513ywY6yjUJPiqOQUC/z3BLOFFZkZfWnVIgH
 49O18Fj6vyeWbfAzjAYMixr4xMKdwrPuiUCLVYT5I9Rvc1uF5pppCjKqWwRQt3rH6H7xUbc7VL7
 PKOE+o6hKDu4xq0p1qWazwVJdn2S8kG2Af2Hog
X-Gm-Gg: ASbGncvBsEcrcEVaFLdxYqcZ7mcSUokOvPPJBbqX/u57UBebTXhPQPDMnSTD30Pj1IG
 yBrlGm4s+DjRcHtdxnxPufcQyLmbV0WwCKNKHTu9IkzOiVBaC1nkMSKhFn7BnWbZqo8+dkiureg
 Wn2jYAO4VxtjAodsyG/evTO8+4DovTeOFqxPjSftcWzfHXch/1Tcfv7N+2+PtdPVhD/QY2005CS
 xp7fVlLNRz9QqZtfBUbDTWMLeb0uJ+/C81I5Nc992rInjp2Jx+i0QMUV7z5
X-Received: by 2002:a05:600c:3106:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-4365536801amr56420265e9.16.1734597214374; 
 Thu, 19 Dec 2024 00:33:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb4wdZIV6TntoyBuhA0U9kU+314TdlbN0B2hR9+YHjFbfl8YkfjsFoMcqlA10Ols9g1JW9Fw==
X-Received: by 2002:a05:600c:3106:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-4365536801amr56419755e9.16.1734597213671; 
 Thu, 19 Dec 2024 00:33:33 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm11342085e9.5.2024.12.19.00.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/41] rust: qom: add casting functionality
Date: Thu, 19 Dec 2024 09:32:17 +0100
Message-ID: <20241219083228.363430-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Add traits that let client cast typecast safely between object types.
In particular, an upcast is compile-time guaranteed to succeed, and a
YOLO C-style downcast must be marked as unsafe.

The traits are based on an IsA<> trait that declares what
is a subclass of what, which is an idea taken from glib-rs
(https://docs.rs/glib/latest/glib/object/trait.IsA.html).
The four primitives are also taken from there
(https://docs.rs/glib/latest/glib/object/trait.Cast.html).  However,
the implementation of casting itself is a bit different and uses the
Deref trait.

This removes some pointer arithmetic from the pl011 device; it is also a
prerequisite for the definition of methods, so that they can be invoked
on all subclass structs.  This will use the IsA<> trait to detect the
structs that support the methods.

glib also has a "monadic" casting trait which could be implemented on
Option (as in https://docs.rs/glib/latest/glib/object/trait.CastNone.html)
and perhaps even Result.  For now I'm leaving it out, as the patch is
already big enough and the benefit seems debatable.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                  |   1 +
 rust/hw/char/pl011/src/device.rs |  12 +-
 rust/qemu-api/src/prelude.rs     |   7 +
 rust/qemu-api/src/qdev.rs        |   1 +
 rust/qemu-api/src/qom.rs         | 283 ++++++++++++++++++++++++++++++-
 rust/qemu-api/src/sysbus.rs      |   7 +-
 rust/qemu-api/tests/tests.rs     |  70 +++++++-
 7 files changed, 368 insertions(+), 13 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 6ec19b67297..5b6b6ca4382 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -38,6 +38,7 @@ should_implement_trait = "deny"
 unused_self = "allow"
 
 # default-allow lints
+as_ptr_cast_mut = "deny"
 as_underscore = "deny"
 assertions_on_result_states = "deny"
 bool_to_int_with_if = "deny"
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 3fed8b4ad25..e85d13c5a2b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -106,6 +106,8 @@ pub struct PL011State {
     device_id: DeviceId,
 }
 
+qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
+
 unsafe impl ObjectType for PL011State {
     type Class = <SysBusDevice as ObjectType>::Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
@@ -140,8 +142,6 @@ impl PL011State {
     unsafe fn init(&mut self) {
         const CLK_NAME: &CStr = c_str!("clk");
 
-        let sbd = unsafe { &mut *(addr_of_mut!(*self).cast::<SysBusDevice>()) };
-
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -155,15 +155,16 @@ unsafe fn init(&mut self) {
                 Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
+
+            let sbd: &mut SysBusDevice = self.upcast_mut();
             sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
         }
 
         for irq in self.interrupts.iter() {
+            let sbd: &SysBusDevice = self.upcast();
             sbd.init_irq(irq);
         }
 
-        let dev = addr_of_mut!(*self).cast::<DeviceState>();
-
         // SAFETY:
         //
         // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
@@ -172,6 +173,7 @@ unsafe fn init(&mut self) {
         // calls this function to initialize the fields; therefore no code is
         // able to access an invalid self.clock value.
         unsafe {
+            let dev: &mut DeviceState = self.upcast_mut();
             self.clock = NonNull::new(qdev_init_clock_in(
                 dev,
                 CLK_NAME.as_ptr(),
@@ -632,6 +634,8 @@ unsafe fn init(&mut self) {
     }
 }
 
+qom_isa!(PL011Luminary : PL011State, SysBusDevice, DeviceState, Object);
+
 unsafe impl ObjectType for PL011Luminary {
     type Class = <PL011State as ObjectType>::Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 5cc41f081f9..a0a71fcd6bc 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,4 +7,11 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
+pub use crate::qom::IsA;
+pub use crate::qom::Object;
+pub use crate::qom::ObjectCast;
+pub use crate::qom::ObjectCastMut;
+pub use crate::qom::ObjectDeref;
 pub use crate::qom::ObjectType;
+
+pub use crate::qom_isa;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 07a502a8371..686054e737a 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -144,3 +144,4 @@ unsafe impl ObjectType for DeviceState {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
+qom_isa!(DeviceState: Object);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index a663647ffe5..74ea5721f77 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -4,15 +4,22 @@
 
 //! Bindings to access QOM functionality from Rust.
 //!
-//! This module provides automatic creation and registration of `TypeInfo`
-//! for classes that are written in Rust, and mapping between Rust traits
-//! and QOM vtables.
+//! The QEMU Object Model (QOM) provides inheritance and dynamic typing for QEMU
+//! devices. This module makes QOM's features available in Rust through two main
+//! mechanisms:
+//!
+//! * Automatic creation and registration of `TypeInfo` for classes that are
+//!   written in Rust, as well as mapping between Rust traits and QOM vtables.
+//!
+//! * Type-safe casting between parent and child classes, through the [`IsA`]
+//!   trait and methods such as [`upcast`](ObjectCast::upcast) and
+//!   [`downcast`](ObjectCast::downcast).
 //!
 //! # Structure of a class
 //!
 //! A leaf class only needs a struct holding instance state. The struct must
-//! implement the [`ObjectType`] trait, as well as any `*Impl` traits that exist
-//! for its superclasses.
+//! implement the [`ObjectType`] and [`IsA`] traits, as well as any `*Impl`
+//! traits that exist for its superclasses.
 //!
 //! If a class has subclasses, it will also provide a struct for instance data,
 //! with the same characteristics as for concrete classes, but it also needs
@@ -31,11 +38,57 @@
 //!   the source for this is the `*Impl` trait; the associated consts and
 //!   functions if needed are wrapped to map C types into Rust types.
 
-use std::{ffi::CStr, os::raw::c_void};
+use std::{
+    ffi::CStr,
+    ops::{Deref, DerefMut},
+    os::raw::c_void,
+};
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, TypeInfo};
+use crate::bindings::{self, object_dynamic_cast, TypeInfo};
+
+/// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
+/// or indirect parent of `Self`).
+///
+/// # Safety
+///
+/// The struct `Self` must be `#[repr(C)]` and must begin, directly or
+/// indirectly, with a field of type `P`.  This ensures that invalid casts,
+/// which rely on `IsA<>` for static checking, are rejected at compile time.
+pub unsafe trait IsA<P: ObjectType>: ObjectType {}
+
+// SAFETY: it is always safe to cast to your own type
+unsafe impl<T: ObjectType> IsA<T> for T {}
+
+/// Macro to mark superclasses of QOM classes.  This enables type-safe
+/// up- and downcasting.
+///
+/// # Safety
+///
+/// This macro is a thin wrapper around the [`IsA`] trait and performs
+/// no checking whatsoever of what is declared.  It is the caller's
+/// responsibility to have $struct begin, directly or indirectly, with
+/// a field of type `$parent`.
+#[macro_export]
+macro_rules! qom_isa {
+    ($struct:ty : $($parent:ty),* ) => {
+        $(
+            // SAFETY: it is the caller responsibility to have $parent as the
+            // first field
+            unsafe impl $crate::qom::IsA<$parent> for $struct {}
+
+            impl AsRef<$parent> for $struct {
+                fn as_ref(&self) -> &$parent {
+                    // SAFETY: follows the same rules as for IsA<U>, which is
+                    // declared above.
+                    let ptr: *const Self = self;
+                    unsafe { &*ptr.cast::<$parent>() }
+                }
+            }
+        )*
+    };
+}
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
@@ -96,8 +149,224 @@ pub unsafe trait ObjectType: Sized {
     /// The name of the type, which can be passed to `object_new()` to
     /// generate an instance of this type.
     const TYPE_NAME: &'static CStr;
+
+    /// Return the receiver as an Object.  This is always safe, even
+    /// if this type represents an interface.
+    fn as_object(&self) -> &Object {
+        unsafe { &*self.as_object_ptr() }
+    }
+
+    /// Return the receiver as a const raw pointer to Object.
+    /// This is preferrable to `as_object_mut_ptr()` if a C
+    /// function only needs a `const Object *`.
+    fn as_object_ptr(&self) -> *const Object {
+        self.as_ptr().cast()
+    }
+
+    /// Return the receiver as a mutable raw pointer to Object.
+    ///
+    /// # Safety
+    ///
+    /// This cast is always safe, but because the result is mutable
+    /// and the incoming reference is not, this should only be used
+    /// for calls to C functions, and only if needed.
+    unsafe fn as_object_mut_ptr(&self) -> *mut Object {
+        self.as_object_ptr() as *mut _
+    }
 }
 
+/// This trait provides safe casting operations for QOM objects to raw pointers,
+/// to be used for example for FFI. The trait can be applied to any kind of
+/// reference or smart pointers, and enforces correctness through the [`IsA`]
+/// trait.
+pub trait ObjectDeref: Deref
+where
+    Self::Target: ObjectType,
+{
+    /// Convert to a const Rust pointer, to be used for example for FFI.
+    /// The target pointer type must be the type of `self` or a superclass
+    fn as_ptr<U: ObjectType>(&self) -> *const U
+    where
+        Self::Target: IsA<U>,
+    {
+        let ptr: *const Self::Target = self.deref();
+        ptr.cast::<U>()
+    }
+
+    /// Convert to a mutable Rust pointer, to be used for example for FFI.
+    /// The target pointer type must be the type of `self` or a superclass.
+    /// Used to implement interior mutability for objects.
+    ///
+    /// # Safety
+    ///
+    /// This method is unsafe because it overrides const-ness of `&self`.
+    /// Bindings to C APIs will use it a lot, but otherwise it should not
+    /// be necessary.
+    unsafe fn as_mut_ptr<U: ObjectType>(&self) -> *mut U
+    where
+        Self::Target: IsA<U>,
+    {
+        #[allow(clippy::as_ptr_cast_mut)]
+        {
+            self.as_ptr::<U>() as *mut _
+        }
+    }
+}
+
+/// Trait that adds extra functionality for `&T` where `T` is a QOM
+/// object type.  Allows conversion to/from C objects in generic code.
+pub trait ObjectCast: ObjectDeref + Copy
+where
+    Self::Target: ObjectType,
+{
+    /// Safely convert from a derived type to one of its parent types.
+    ///
+    /// This is always safe; the [`IsA`] trait provides static verification
+    /// trait that `Self` dereferences to `U` or a child of `U`.
+    fn upcast<'a, U: ObjectType>(self) -> &'a U
+    where
+        Self::Target: IsA<U>,
+        Self: 'a,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait
+        unsafe { self.unsafe_cast::<U>() }
+    }
+
+    /// Attempt to convert to a derived type.
+    ///
+    /// Returns `None` if the object is not actually of type `U`. This is
+    /// verified at runtime by checking the object's type information.
+    fn downcast<'a, U: IsA<Self::Target>>(self) -> Option<&'a U>
+    where
+        Self: 'a,
+    {
+        self.dynamic_cast::<U>()
+    }
+
+    /// Attempt to convert between any two types in the QOM hierarchy.
+    ///
+    /// Returns `None` if the object is not actually of type `U`. This is
+    /// verified at runtime by checking the object's type information.
+    fn dynamic_cast<'a, U: ObjectType>(self) -> Option<&'a U>
+    where
+        Self: 'a,
+    {
+        unsafe {
+            // SAFETY: upcasting to Object is always valid, and the
+            // return type is either NULL or the argument itself
+            let result: *const U =
+                object_dynamic_cast(self.as_object_mut_ptr(), U::TYPE_NAME.as_ptr()).cast();
+
+            result.as_ref()
+        }
+    }
+
+    /// Convert to any QOM type without verification.
+    ///
+    /// # Safety
+    ///
+    /// What safety? You need to know yourself that the cast is correct; only
+    /// use when performance is paramount.  It is still better than a raw
+    /// pointer `cast()`, which does not even check that you remain in the
+    /// realm of QOM `ObjectType`s.
+    ///
+    /// `unsafe_cast::<Object>()` is always safe.
+    unsafe fn unsafe_cast<'a, U: ObjectType>(self) -> &'a U
+    where
+        Self: 'a,
+    {
+        unsafe { &*(self.as_ptr::<Self::Target>().cast::<U>()) }
+    }
+}
+
+impl<T: ObjectType> ObjectDeref for &T {}
+impl<T: ObjectType> ObjectCast for &T {}
+
+/// Trait for mutable type casting operations in the QOM hierarchy.
+///
+/// This trait provides the mutable counterparts to [`ObjectCast`]'s conversion
+/// functions. Unlike `ObjectCast`, this trait returns `Result` for fallible
+/// conversions to preserve the original smart pointer if the cast fails. This
+/// is necessary because mutable references cannot be copied, so a failed cast
+/// must return ownership of the original reference. For example:
+///
+/// ```ignore
+/// let mut dev = get_device();
+/// // If this fails, we need the original `dev` back to try something else
+/// match dev.dynamic_cast_mut::<FooDevice>() {
+///    Ok(foodev) => /* use foodev */,
+///    Err(dev) => /* still have ownership of dev */
+/// }
+/// ```
+pub trait ObjectCastMut: Sized + ObjectDeref + DerefMut
+where
+    Self::Target: ObjectType,
+{
+    /// Safely convert from a derived type to one of its parent types.
+    ///
+    /// This is always safe; the [`IsA`] trait provides static verification
+    /// that `Self` dereferences to `U` or a child of `U`.
+    fn upcast_mut<'a, U: ObjectType>(self) -> &'a mut U
+    where
+        Self::Target: IsA<U>,
+        Self: 'a,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait
+        unsafe { self.unsafe_cast_mut::<U>() }
+    }
+
+    /// Attempt to convert to a derived type.
+    ///
+    /// Returns `Ok(..)` if the object is of type `U`, or `Err(self)` if the
+    /// object if the conversion failed. This is verified at runtime by
+    /// checking the object's type information.
+    fn downcast_mut<'a, U: IsA<Self::Target>>(self) -> Result<&'a mut U, Self>
+    where
+        Self: 'a,
+    {
+        self.dynamic_cast_mut::<U>()
+    }
+
+    /// Attempt to convert between any two types in the QOM hierarchy.
+    ///
+    /// Returns `Ok(..)` if the object is of type `U`, or `Err(self)` if the
+    /// object if the conversion failed. This is verified at runtime by
+    /// checking the object's type information.
+    fn dynamic_cast_mut<'a, U: ObjectType>(self) -> Result<&'a mut U, Self>
+    where
+        Self: 'a,
+    {
+        unsafe {
+            // SAFETY: upcasting to Object is always valid, and the
+            // return type is either NULL or the argument itself
+            let result: *mut U =
+                object_dynamic_cast(self.as_object_mut_ptr(), U::TYPE_NAME.as_ptr()).cast();
+
+            result.as_mut().ok_or(self)
+        }
+    }
+
+    /// Convert to any QOM type without verification.
+    ///
+    /// # Safety
+    ///
+    /// What safety? You need to know yourself that the cast is correct; only
+    /// use when performance is paramount.  It is still better than a raw
+    /// pointer `cast()`, which does not even check that you remain in the
+    /// realm of QOM `ObjectType`s.
+    ///
+    /// `unsafe_cast::<Object>()` is always safe.
+    unsafe fn unsafe_cast_mut<'a, U: ObjectType>(self) -> &'a mut U
+    where
+        Self: 'a,
+    {
+        unsafe { &mut *self.as_mut_ptr::<Self::Target>().cast::<U>() }
+    }
+}
+
+impl<T: ObjectType> ObjectDeref for &mut T {}
+impl<T: ObjectType> ObjectCastMut for &mut T {}
+
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
     /// The parent of the type.  This should match the first field of
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 9abc687a261..8193734bde4 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -7,7 +7,11 @@
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
 use crate::{
-    bindings, cell::bql_locked, irq::InterruptSource, prelude::*, qdev::DeviceClass,
+    bindings,
+    cell::bql_locked,
+    irq::InterruptSource,
+    prelude::*,
+    qdev::{DeviceClass, DeviceState},
     qom::ClassInitImpl,
 };
 
@@ -16,6 +20,7 @@ unsafe impl ObjectType for SysBusDevice {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
 }
+qom_isa!(SysBusDevice: DeviceState, Object);
 
 // TODO: add SysBusDeviceImpl
 impl<T> ClassInitImpl<SysBusDeviceClass> for T
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 953cb15975b..5d9f13b15d4 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,13 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{cell::Cell, ffi::CStr, sync::Mutex};
+use std::{
+    cell::Cell,
+    ffi::CStr,
+    os::raw::c_void,
+    ptr::{addr_of, addr_of_mut},
+    sync::Mutex,
+};
 
 use qemu_api::{
     bindings::*,
@@ -29,6 +35,8 @@ pub struct DummyState {
     migrate_clock: bool,
 }
 
+qom_isa!(DummyState: Object, DeviceState);
+
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
@@ -85,3 +93,63 @@ fn test_object_new() {
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
     }
 }
+
+// a note on all "cast" tests: usually, especially for downcasts the desired
+// class would be placed on the right, for example:
+//
+//    let sbd_ref = p.dynamic_cast::<SysBusDevice>();
+//
+// Here I am doing the opposite to check that the resulting type is correct.
+
+#[test]
+#[allow(clippy::shadow_unrelated)]
+/// Test casts on shared references.
+fn test_cast() {
+    init_qom();
+    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+
+    let p_ref: &DummyState = unsafe { &*p };
+    let obj_ref: &Object = p_ref.upcast();
+    assert_eq!(addr_of!(*obj_ref), p.cast());
+
+    let sbd_ref: Option<&SysBusDevice> = obj_ref.dynamic_cast();
+    assert!(sbd_ref.is_none());
+
+    let dev_ref: Option<&DeviceState> = obj_ref.downcast();
+    assert_eq!(addr_of!(*dev_ref.unwrap()), p.cast());
+
+    // SAFETY: the cast is wrong, but the value is only used for comparison
+    unsafe {
+        let sbd_ref: &SysBusDevice = obj_ref.unsafe_cast();
+        assert_eq!(addr_of!(*sbd_ref), p.cast());
+
+        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
+    }
+}
+
+#[test]
+#[allow(clippy::shadow_unrelated)]
+/// Test casts on mutable references.
+fn test_cast_mut() {
+    init_qom();
+    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+
+    let p_ref: &mut DummyState = unsafe { &mut *p };
+    let obj_ref: &mut Object = p_ref.upcast_mut();
+    assert_eq!(addr_of_mut!(*obj_ref), p.cast());
+
+    let sbd_ref: Result<&mut SysBusDevice, &mut Object> = obj_ref.dynamic_cast_mut();
+    let obj_ref = sbd_ref.unwrap_err();
+
+    let dev_ref: Result<&mut DeviceState, &mut Object> = obj_ref.downcast_mut();
+    let dev_ref = dev_ref.unwrap();
+    assert_eq!(addr_of_mut!(*dev_ref), p.cast());
+
+    // SAFETY: the cast is wrong, but the value is only used for comparison
+    unsafe {
+        let sbd_ref: &mut SysBusDevice = obj_ref.unsafe_cast_mut();
+        assert_eq!(addr_of_mut!(*sbd_ref), p.cast());
+
+        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
+    }
+}
-- 
2.47.1


