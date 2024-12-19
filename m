Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F63E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByO-0005Yk-Rt; Thu, 19 Dec 2024 03:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByL-0005KC-Lt
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByI-0005Cf-EI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b57K8ft544UoM6GCsiUjVHuM32CJVDdNlM86iQYtbsk=;
 b=NJWJK2tB9vmUUO2naBIx1l33YLkgvfpLBo6cOHFCMf8+OeyASgLN7qqXVTSXwvsgRRqTRr
 LYs8eIMSfN9k6hy82Ev9oQa2ZQdw7FUp7My6plH0o6YpUVaXq4B/9g0o5DvXEWxBVdfIl+
 Eam7dHlMN4mgztIfvC06pC3WcpjEjVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-VPyAlxKXOEyD9lCJqWjPfg-1; Thu, 19 Dec 2024 03:33:24 -0500
X-MC-Unique: VPyAlxKXOEyD9lCJqWjPfg-1
X-Mimecast-MFC-AGG-ID: VPyAlxKXOEyD9lCJqWjPfg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so2998825e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597203; x=1735202003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b57K8ft544UoM6GCsiUjVHuM32CJVDdNlM86iQYtbsk=;
 b=tvDhHvilaHA+o1A7aKgT5Q3NRuHFQ4UHs/JgpuoNuAZFVFn5ndHIp+3myk6TGw9+hN
 80o3i0tJ9RfNpR45L0xvVEsH/uX28LkCF7/xL9RnBR5sxuyeiW9HpjxN4Po0EGTdmJCE
 RjXZn+Fai5HA+24pM8JNvdQ8frw+1np/osEHYvXa9WJ24G4MKY8aGTA/Lgzo7JYUsfrA
 xgMm7h58bjfDkqiolHnueDohkm6sGbvr47WrqYwtL/GbXInDdmJ4t9LlDpWHECVadUCA
 c7dmBPMB4O0LWknMVUA7+1qrYBdYJJCtfhjaEP2b6NfMb4jedm0ZOxsJluGqkt1r3atk
 fPbg==
X-Gm-Message-State: AOJu0YzWDOwbJnbnVPoEpj3EZjr9tNHWb+tlTLEuhBgq4UySUP9xsc/m
 Tsu7xtTM0BzCexyzlEQV5bJu51K5oYtuQnp6za7AZXb5pWDQHW5zH9UIxesUMNsLbPAhTIsxy5F
 3DPlCoFPEd8DtsVBTgH9avcSAwtwoMoLHktBHnTGNUw55t/xUxX15Z15GXy6RkHsKF4hRAiU9GX
 vw6k77I0pJjHTaAHde12X1Yej5BvJkLf0Sgogl
X-Gm-Gg: ASbGncvH2Bjv2Ei1Gd4HcOyQFj6ivJAV07tI4a7fnR6rs5sFFj5ivQTbww9eqRaCY5v
 1zyiWTKd3F0M+VIHSVnrUXrOcX1aaif9UxN+M/2Iw1YxMB/iBhzBpqgE8OSzARxzuSSlaS3RLkM
 CB6cWH/Y3QBzjWWrFYRIVLfC5cFWX1Li+IbuWw5kHzU8KZsW8dhn2OuLg0XbnK8E+xAQ5Ad5n0g
 EcgODFY/qXQGbhh9zlJlxlna5YUtBgzMFezHQgKhozWoHJLxZ3wRAHXDBzi
X-Received: by 2002:a05:600c:3b88:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4365c77e436mr20928235e9.3.1734597202542; 
 Thu, 19 Dec 2024 00:33:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNm4V+wCPC8C8YlTwEY3j1RvRU4QPiJVvIqVqepXMFPBRnP5BomYS5hLq+nyO10IQ07ZDN7Q==
X-Received: by 2002:a05:600c:3b88:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4365c77e436mr20927685e9.3.1734597201851; 
 Thu, 19 Dec 2024 00:33:21 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm11222895e9.30.2024.12.19.00.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
Date: Thu, 19 Dec 2024 09:32:12 +0100
Message-ID: <20241219083228.363430-26-pbonzini@redhat.com>
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

Parameterize the implementation of ClassInitImpl so that it is
possible to call up the chain of implementations, one superclass at
a time starting at ClassInitImpl<Self::Class>.

In order to avoid having to implement (for example)
ClassInitImpl<PL011Class>, also remove the dummy PL011Class and
PL011LuminaryClass structs and specify the same ObjectType::Class as
the superclass.  In the future this default behavior can be handled by
a procedural macro, by looking at the first field in the struct.

Note that the new trait is safe: the calls are started by
rust_class_init<>(), which is not public and can convert the class
pointer to a Rust reference.

Since CLASS_BASE_INIT applies to the type that is being defined,
and only to it, move it to ObjectImpl.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  |  19 +----
 rust/qemu-api/src/definitions.rs  | 111 ++++++++++++++++++++++++------
 rust/qemu-api/src/device_class.rs |  50 +++++---------
 rust/qemu-api/src/sysbus.rs       |  18 ++++-
 rust/qemu-api/tests/tests.rs      |   9 +--
 5 files changed, 127 insertions(+), 80 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 3e29442a625..d9e9f35f456 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,7 +13,6 @@
     c_str,
     definitions::ObjectImpl,
     device_class::DeviceImpl,
-    impl_device_class,
     irq::InterruptSource,
     prelude::*,
 };
@@ -108,7 +107,7 @@ pub struct PL011State {
 }
 
 unsafe impl ObjectType for PL011State {
-    type Class = PL011Class;
+    type Class = <SysBusDevice as ObjectType>::Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
 }
 
@@ -118,11 +117,6 @@ impl ObjectImpl for PL011State {
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
-#[repr(C)]
-pub struct PL011Class {
-    _inner: [u8; 0],
-}
-
 impl DeviceImpl for PL011State {
     fn properties() -> &'static [Property] {
         &device_class::PL011_PROPERTIES
@@ -134,8 +128,6 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     const RESET: Option<fn(&mut Self)> = Some(Self::reset);
 }
 
-impl_device_class!(PL011State);
-
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
     ///
@@ -627,11 +619,6 @@ pub struct PL011Luminary {
     parent_obj: PL011State,
 }
 
-#[repr(C)]
-pub struct PL011LuminaryClass {
-    _inner: [u8; 0],
-}
-
 impl PL011Luminary {
     /// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
     ///
@@ -646,7 +633,7 @@ unsafe fn init(&mut self) {
 }
 
 unsafe impl ObjectType for PL011Luminary {
-    type Class = PL011LuminaryClass;
+    type Class = <PL011State as ObjectType>::Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
 }
 
@@ -657,5 +644,3 @@ impl ObjectImpl for PL011Luminary {
 }
 
 impl DeviceImpl for PL011Luminary {}
-
-impl_device_class!(PL011Luminary);
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index df91a2e31a9..13f8f6fd2a9 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -26,6 +26,16 @@
     T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
 }
 
+unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
+    klass: *mut ObjectClass,
+    _data: *mut c_void,
+) {
+    // SAFETY: klass is a T::Class, since rust_class_init<T>
+    // is called from QOM core as the class_init function
+    // for class T
+    T::class_init(unsafe { &mut *klass.cast::<T::Class>() })
+}
+
 /// Trait exposed by all structs corresponding to QOM objects.
 ///
 /// # Safety
@@ -50,7 +60,8 @@
 /// - likewise, the first field of the `Class` must be of the class struct
 ///   corresponding to the superclass, which is `ObjectImpl::ParentType::Class`.
 pub unsafe trait ObjectType: Sized {
-    /// The QOM class object corresponding to this struct.  Not used yet.
+    /// The QOM class object corresponding to this struct.  This is used
+    /// to automatically generate a `class_init` method.
     type Class;
 
     /// The name of the type, which can be passed to `object_new()` to
@@ -59,7 +70,7 @@ pub unsafe trait ObjectType: Sized {
 }
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl: ObjectType + ClassInitImpl {
+pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
     /// The parent of the type.  This should match the first field of
     /// the struct that implements `ObjectImpl`:
     type ParentType: ObjectType;
@@ -80,6 +91,15 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl {
     /// `INSTANCE_INIT` functions have been called.
     const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
 
+    /// Called on descendent classes after all parent class initialization
+    /// has occurred, but before the class itself is initialized.  This
+    /// is only useful if a class is not a leaf, and can be used to undo
+    /// the effects of copying the contents of the parent's class struct
+    /// to the descendants.
+    const CLASS_BASE_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+    > = None;
+
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
         parent: Self::ParentType::TYPE_NAME.as_ptr(),
@@ -96,37 +116,86 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl {
         instance_finalize: Self::INSTANCE_FINALIZE,
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
-        class_init: <Self as ClassInitImpl>::CLASS_INIT,
-        class_base_init: <Self as ClassInitImpl>::CLASS_BASE_INIT,
+        class_init: Some(rust_class_init::<Self>),
+        class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null_mut(),
         interfaces: core::ptr::null_mut(),
     };
 }
 
-/// Trait used to fill in a class struct.
+/// Internal trait used to automatically fill in a class struct.
 ///
 /// Each QOM class that has virtual methods describes them in a
 /// _class struct_.  Class structs include a parent field corresponding
 /// to the vtable of the parent class, all the way up to [`ObjectClass`].
-/// Each QOM type has one such class struct.
+/// Each QOM type has one such class struct; this trait takes care of
+/// initializing the `T` part of the class struct, for the type that
+/// implements the trait.
 ///
-/// The Rust implementation of methods will usually come from a trait
-/// like [`ObjectImpl`] or [`DeviceImpl`](crate::device_class::DeviceImpl).
-pub trait ClassInitImpl {
-    /// Function that is called after all parent class initialization
-    /// has occurred.  On entry, the virtual method pointers are set to
+/// Each struct will implement this trait with `T` equal to each
+/// superclass.  For example, a device should implement at least
+/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>`.
+/// Such implementations are made in one of two ways.
+///
+/// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
+/// crate itself.  The Rust implementation of methods will come from a
+/// trait like [`ObjectImpl`] or
+/// [`DeviceImpl`](crate::device_class::DeviceImpl), and `ClassInitImpl` is
+/// provided by blanket implementations that operate on all implementors of the
+/// `*Impl`* trait.  For example:
+///
+/// ```ignore
+/// impl<T> ClassInitImpl<DeviceClass> for T
+/// where
+///     T: DeviceImpl,
+/// ```
+///
+/// The other case is when manual implementation of the trait is needed.
+/// This covers the following cases:
+///
+/// * if a class implements a QOM interface, the Rust code _has_ to define its
+///   own class struct `FooClass` and implement `ClassInitImpl<FooClass>`.
+///   `ClassInitImpl<FooClass>`'s `class_init` method will then forward to
+///   multiple other `class_init`s, for the interfaces as well as the
+///   superclass. (Note that there is no Rust example yet for using interfaces).
+///
+/// * for classes implemented outside the ``qemu-api`` crate, it's not possible
+///   to add blanket implementations like the above one, due to orphan rules. In
+///   that case, the easiest solution is to implement
+///   `ClassInitImpl<YourSuperclass>` for each subclass and not have a
+///   `YourSuperclassImpl` trait at all.
+///
+/// ```ignore
+/// impl ClassInitImpl<YourSuperclass> for YourSubclass {
+///     fn class_init(klass: &mut YourSuperclass) {
+///         klass.some_method = Some(Self::some_method);
+///         <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
+///     }
+/// }
+/// ```
+///
+///   While this method incurs a small amount of code duplication,
+///   it is generally limited to the recursive call on the last line.
+///   This is because classes defined in Rust do not need the same
+///   glue code that is needed when the classes are defined in C code.
+///   You may consider using a macro if you have many subclasses.
+pub trait ClassInitImpl<T> {
+    /// Initialize `klass` to point to the virtual method implementations
+    /// for `Self`.  On entry, the virtual method pointers are set to
     /// the default values coming from the parent classes; the function
     /// can change them to override virtual methods of a parent class.
-    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
-
-    /// Called on descendent classes after all parent class initialization
-    /// has occurred, but before the class itself is initialized.  This
-    /// is only useful if a class is not a leaf, and can be used to undo
-    /// the effects of copying the contents of the parent's class struct
-    /// to the descendants.
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
-    >;
+    ///
+    /// The virtual method implementations usually come from another
+    /// trait, for example [`DeviceImpl`](crate::device_class::DeviceImpl)
+    /// when `T` is [`DeviceClass`](crate::bindings::DeviceClass).
+    ///
+    /// On entry, `klass`'s parent class is initialized, while the other fields
+    /// are all zero; it is therefore assumed that all fields in `T` can be
+    /// zeroed, otherwise it would not be possible to provide the class as a
+    /// `&mut T`.  TODO: add a bound of [`Zeroable`](crate::zeroable::Zeroable)
+    /// to T; this is more easily done once Zeroable does not require a manual
+    /// implementation (Rust 1.75.0).
+    fn class_init(klass: &mut T);
 }
 
 #[macro_export]
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index c98f0b2c7da..dcec5488291 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,10 +2,11 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, os::raw::c_void};
+use std::ffi::CStr;
 
 use crate::{
-    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    bindings::{self, DeviceClass, DeviceState, Error, Property, VMStateDescription},
+    definitions::ClassInitImpl,
     prelude::*,
 };
 
@@ -44,7 +45,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// # Safety
 ///
 /// This function is only called through the QOM machinery and
-/// the `impl_device_class!` macro.
+/// used by the `ClassInitImpl<DeviceClass>` trait.
 /// We expect the FFI user of this function to pass a valid pointer that
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
@@ -65,48 +66,31 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     T::RESET.unwrap()(unsafe { &mut *state });
 }
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer that
-/// can be downcasted to type `DeviceClass`, because `T` implements
-/// `DeviceImpl`.
-pub unsafe extern "C" fn rust_device_class_init<T: DeviceImpl>(
-    klass: *mut ObjectClass,
-    _: *mut c_void,
-) {
-    let mut dc = ::core::ptr::NonNull::new(klass.cast::<DeviceClass>()).unwrap();
-    unsafe {
-        let dc = dc.as_mut();
+impl<T> ClassInitImpl<DeviceClass> for T
+where
+    T: DeviceImpl,
+{
+    fn class_init(dc: &mut DeviceClass) {
         if <T as DeviceImpl>::REALIZE.is_some() {
             dc.realize = Some(rust_realize_fn::<T>);
         }
         if <T as DeviceImpl>::RESET.is_some() {
-            bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
+            unsafe {
+                bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
+            }
         }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             dc.vmsd = vmsd;
         }
         let prop = <T as DeviceImpl>::properties();
         if !prop.is_empty() {
-            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
+            unsafe {
+                bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
+            }
         }
     }
 }
 
-#[macro_export]
-macro_rules! impl_device_class {
-    ($type:ty) => {
-        impl $crate::definitions::ClassInitImpl for $type {
-            const CLASS_INIT: Option<
-                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut ::std::os::raw::c_void),
-            > = Some($crate::device_class::rust_device_class_init::<$type>);
-            const CLASS_BASE_INIT: Option<
-                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut ::std::os::raw::c_void),
-            > = None;
-        }
-    };
-}
-
 #[macro_export]
 macro_rules! define_property {
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
@@ -148,8 +132,8 @@ macro_rules! declare_properties {
     };
 }
 
-unsafe impl ObjectType for bindings::DeviceState {
-    type Class = bindings::DeviceClass;
+unsafe impl ObjectType for DeviceState {
+    type Class = DeviceClass;
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 5ee068541cf..5d15b317405 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -6,7 +6,13 @@
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
-use crate::{bindings, cell::bql_locked, irq::InterruptSource, prelude::*};
+use crate::{
+    bindings::{self, DeviceClass},
+    cell::bql_locked,
+    definitions::ClassInitImpl,
+    irq::InterruptSource,
+    prelude::*,
+};
 
 unsafe impl ObjectType for SysBusDevice {
     type Class = SysBusDeviceClass;
@@ -14,6 +20,16 @@ unsafe impl ObjectType for SysBusDevice {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
 }
 
+// TODO: add SysBusDeviceImpl
+impl<T> ClassInitImpl<SysBusDeviceClass> for T
+where
+    T: ClassInitImpl<DeviceClass>,
+{
+    fn class_init(sdc: &mut SysBusDeviceClass) {
+        <T as ClassInitImpl<DeviceClass>>::class_init(&mut sdc.parent_class);
+    }
+}
+
 impl SysBusDevice {
     /// Return `self` cast to a mutable pointer, for use in calls to C code.
     const fn as_mut_ptr(&self) -> *mut SysBusDevice {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 278efe967fe..ed3a555e76d 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -26,11 +26,6 @@ pub struct DummyState {
         pub migrate_clock: bool,
     }
 
-    #[repr(C)]
-    pub struct DummyClass {
-        pub _parent: DeviceClass,
-    }
-
     declare_properties! {
         DUMMY_PROPERTIES,
             define_property!(
@@ -43,7 +38,7 @@ pub struct DummyClass {
     }
 
     unsafe impl ObjectType for DummyState {
-        type Class = DummyClass;
+        type Class = <DeviceState as ObjectType>::Class;
         const TYPE_NAME: &'static CStr = c_str!("dummy");
     }
 
@@ -61,8 +56,6 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         }
     }
 
-    impl_device_class!(DummyState);
-
     unsafe {
         module_call_init(module_init_type::MODULE_INIT_QOM);
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
-- 
2.47.1


