Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0A5C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLPx-0007QD-3H; Fri, 07 Feb 2025 05:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPb-0007KI-G1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPZ-0003lK-At
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynfSiKySz1E493NM3nAmhgtxqEj3XUDWlZBIVMVVqV8=;
 b=T1rmDmxXu3QJUSRHn00L6Gh8PTL+Vy3QanInr6Y08UVjRae/gb0GkTXgvAYSHoh2irpqAo
 h//6ixDNnwqtknkFmOdWptXLGjvald5edpL3KAtdQU2KcUpJWXw09N/J+I6dzD20Uqc8oD
 3kjk38FWM7rv1yam34bWv0D5bskpQXI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ysoVjjfvNCilfwI5r_FSfg-1; Fri, 07 Feb 2025 05:16:33 -0500
X-MC-Unique: ysoVjjfvNCilfwI5r_FSfg-1
X-Mimecast-MFC-AGG-ID: ysoVjjfvNCilfwI5r_FSfg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7044083e5so221841466b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923390; x=1739528190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynfSiKySz1E493NM3nAmhgtxqEj3XUDWlZBIVMVVqV8=;
 b=NMQ117j4FnTPVgM8kno8BkFQVzw3HqorwOtXcKk7W5HXWKzOHS+ass7PLSHouEP7/q
 RB3jMKYWzrxjBA1iJL3+MSIhh46lXtQtYiXbnvSFagXs4DWdG22Gy7aEGdrLODZ9r8NJ
 H7OBsIOTOCH/IMC0B+4gWoxCVmS5G/2uBFqWm3Z3Kugj0xUOJuhtfFFbBAmcntp32Fzs
 EN3NtKqGU/7mEVMdXt2NMfI07V4b+fUenLdPk1HW+gJdCxLkZJXrARUGRVhH6eBirTcY
 ZWCev3JusmFOItTXYvPlZwVos6MlwAxhAS4a2ATJnlGYn0P9esmRi4Kt+SZMqvrTvZYd
 PpDQ==
X-Gm-Message-State: AOJu0Yzk/8P5m2iHJyFOu2mq8bQvCuJqOpQuGFH1h/Zr/fCk/YQm3O3s
 MvGOmIwtUwxMMWjYjRHRjjRpewP8NFjAQM2vyap94j25E1WfLeSflwcPxFK7hGECc2B0GLNHdu/
 28RDgcIt0mZjZ+xpd88KfsVwJZ3xSW2G9JGHykVu+folh2rb+zTWiuFh4u+t/Oq0MJBvlM9MxGp
 SEjKQ4QiO0jElZYCwKf97xgxxUvEQgY1hKxjwCEYg=
X-Gm-Gg: ASbGncvykBq6TaHlWyEuDvsW9FEw7uhp0dAqhgfIxByS8/NDbaO5Y0hpcVbTBAmafJp
 hcmOUjX9sn0eOqMqAJba1PovuFl7h0dXEwVAow10zHF+NzSuFUNJ536a97dH3kqv1001MePEHgE
 2npkGjZ1Eo+7dSyYWRqxDQPzLhIKMJ3krynIUAe3vpbp1UT9BsH9t07shi/2yDjVPPlFaNR3ujw
 wrT1CG/I2QkPSMKaxhvGX6BxjYtqdX5HXwNBb6pvCWP5yvyPa7u8cBub850QWFncH/0dxD0SUhF
 YISzoQ==
X-Received: by 2002:a17:907:72d4:b0:ab7:5f0e:87e9 with SMTP id
 a640c23a62f3a-ab789c709d0mr241699166b.55.1738923390190; 
 Fri, 07 Feb 2025 02:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtNVzUSMaVefP8pN97PYvnHBMVz7li2Kz2Y5myFpgrULJWY3/oHyeUKMhZENZnChv/evvjtw==
X-Received: by 2002:a17:907:72d4:b0:ab7:5f0e:87e9 with SMTP id
 a640c23a62f3a-ab789c709d0mr241693666b.55.1738923389586; 
 Fri, 07 Feb 2025 02:16:29 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de3e49c372sm1343232a12.3.2025.02.07.02.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 01/12] rust: qom: add reference counting functionality
Date: Fri,  7 Feb 2025 11:16:12 +0100
Message-ID: <20250207101623.2443552-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a smart pointer that allows to add and remove references from
QOM objects.  It's important to note that while all QOM objects have a
reference count, in practice not all of them have their lifetime guarded
by it.  Embedded objects, specifically, are confined to the lifetime of
the owner.

When writing Rust bindings this is important, because embedded objects are
*never* used through the "Owned<>" smart pointer that is introduced here.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs     | 158 ++++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/vmstate.rs |   6 +-
 rust/qemu-api/tests/tests.rs |  10 +++
 3 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f50ee371aac..4a2e84c9aed 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -56,6 +56,7 @@
 use std::{
     ffi::CStr,
     fmt,
+    mem::ManuallyDrop,
     ops::{Deref, DerefMut},
     os::raw::c_void,
     ptr::NonNull,
@@ -63,7 +64,13 @@
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
+use crate::{
+    bindings::{
+        self, object_dynamic_cast, object_get_class, object_get_typename, object_ref, object_unref,
+        TypeInfo,
+    },
+    cell::bql_locked,
+};
 
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
@@ -610,6 +617,148 @@ unsafe impl ObjectType for Object {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
 }
 
+/// A reference-counted pointer to a QOM object.
+///
+/// `Owned<T>` wraps `T` with automatic reference counting.  It increases the
+/// reference count when created via [`Owned::from`] or cloned, and decreases
+/// it when dropped.  This ensures that the reference count remains elevated
+/// as long as any `Owned<T>` references to it exist.
+///
+/// `Owned<T>` can be used for two reasons:
+/// * because the lifetime of the QOM object is unknown and someone else could
+///   take a reference (similar to `Arc<T>`, for example): in this case, the
+///   object can escape and outlive the Rust struct that contains the `Owned<T>`
+///   field;
+///
+/// * to ensure that the object stays alive until after `Drop::drop` is called
+///   on the Rust struct: in this case, the object will always die together with
+///   the Rust struct that contains the `Owned<T>` field.
+///
+/// Child properties are an example of the second case: in C, an object that
+/// is created with `object_initialize_child` will die *before*
+/// `instance_finalize` is called, whereas Rust expects the struct to have valid
+/// contents when `Drop::drop` is called.  Therefore Rust structs that have
+/// child properties need to keep a reference to the child object.  Right now
+/// this can be done with `Owned<T>`; in the future one might have a separate
+/// `Child<'parent, T>` smart pointer that keeps a reference to a `T`, like
+/// `Owned`, but does not allow cloning.
+///
+/// Note that dropping an `Owned<T>` requires the big QEMU lock to be taken.
+#[repr(transparent)]
+#[derive(PartialEq, Eq, Hash, PartialOrd, Ord)]
+pub struct Owned<T: ObjectType>(NonNull<T>);
+
+// The following rationale for safety is taken from Linux's kernel::sync::Arc.
+
+// SAFETY: It is safe to send `Owned<T>` to another thread when the underlying
+// `T` is `Sync` because it effectively means sharing `&T` (which is safe
+// because `T` is `Sync`); additionally, it needs `T` to be `Send` because any
+// thread that has an `Owned<T>` may ultimately access `T` using a
+// mutable reference when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ObjectType + Send + Sync> Send for Owned<T> {}
+
+// SAFETY: It is safe to send `&Owned<T>` to another thread when the underlying
+// `T` is `Sync` because it effectively means sharing `&T` (which is safe
+// because `T` is `Sync`); additionally, it needs `T` to be `Send` because any
+// thread that has a `&Owned<T>` may clone it and get an `Owned<T>` on that
+// thread, so the thread may ultimately access `T` using a mutable reference
+// when the reference count reaches zero and `T` is dropped.
+unsafe impl<T: ObjectType + Sync + Send> Sync for Owned<T> {}
+
+impl<T: ObjectType> Owned<T> {
+    /// Convert a raw C pointer into an owned reference to the QOM
+    /// object it points to.  The object's reference count will be
+    /// decreased when the `Owned` is dropped.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `ptr` is NULL.
+    ///
+    /// # Safety
+    ///
+    /// The caller must indeed own a reference to the QOM object.
+    /// The object must not be embedded in another unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    ///
+    /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
+    /// back to `from_raw()` (assuming the original `Owned` was valid!),
+    /// since the owned reference remains there between the calls to
+    /// `into_raw()` and `from_raw()`.
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY NOTE: while NonNull requires a mutable pointer, only
+        // Deref is implemented so the pointer passed to from_raw
+        // remains const
+        Owned(NonNull::new(ptr as *mut T).unwrap())
+    }
+
+    /// Obtain a raw C pointer from a reference.  `src` is consumed
+    /// and the reference is leaked.
+    #[allow(clippy::missing_const_for_fn)]
+    pub fn into_raw(src: Owned<T>) -> *mut T {
+        let src = ManuallyDrop::new(src);
+        src.0.as_ptr()
+    }
+
+    /// Increase the reference count of a QOM object and return
+    /// a new owned reference to it.
+    ///
+    /// # Safety
+    ///
+    /// The object must not be embedded in another, unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    pub unsafe fn from(obj: &T) -> Self {
+        unsafe {
+            object_ref(obj.as_object_mut_ptr().cast::<c_void>());
+
+            // SAFETY NOTE: while NonNull requires a mutable pointer, only
+            // Deref is implemented so the reference passed to from_raw
+            // remains shared
+            Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
+        }
+    }
+}
+
+impl<T: ObjectType> Clone for Owned<T> {
+    fn clone(&self) -> Self {
+        // SAFETY: creation method is unsafe; whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        unsafe { Owned::from(self.deref()) }
+    }
+}
+
+impl<T: ObjectType> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: creation method is unsafe; whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        // With that guarantee, reference counting ensures that
+        // the object remains alive.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+impl<T: ObjectType> ObjectDeref for Owned<T> {}
+
+impl<T: ObjectType> Drop for Owned<T> {
+    fn drop(&mut self) {
+        assert!(bql_locked());
+        // SAFETY: creation method is unsafe, and whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>` and its clones.
+        unsafe {
+            object_unref(self.as_object_mut_ptr().cast::<c_void>());
+        }
+    }
+}
+
+impl<T: IsA<Object>> fmt::Debug for Owned<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        self.deref().debug_fmt(f)
+    }
+}
+
 /// Trait for methods exposed by the Object class.  The methods can be
 /// called on all objects that have the trait `IsA<Object>`.
 ///
@@ -641,6 +790,13 @@ fn get_class(&self) -> &'static <Self::Target as ObjectType>::Class {
 
         klass
     }
+
+    /// Convenience function for implementing the Debug trait
+    fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        f.debug_tuple(&self.typename())
+            .field(&(self as *const Self))
+            .finish()
+    }
 }
 
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6ac432cf52f..11d21b8791c 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -29,6 +29,8 @@
 pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::{
     bindings::{self, VMStateFlags},
+    prelude::*,
+    qom::Owned,
     zeroable::Zeroable,
 };
 
@@ -191,7 +193,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
 ///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer or a `Box` for any of the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
+///   the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
@@ -398,6 +401,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 5c3e75ed3d5..69ddac7f1c5 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -138,6 +138,16 @@ fn test_object_new() {
     }
 }
 
+#[test]
+#[allow(clippy::redundant_clone)]
+/// Create, clone and then drop an instance.
+fn test_clone() {
+    init_qom();
+    let p = DummyState::new();
+    assert_eq!(p.clone().typename(), "dummy");
+    drop(p);
+}
+
 #[test]
 /// Try invoking a method on an object.
 fn test_typename() {
-- 
2.48.1


