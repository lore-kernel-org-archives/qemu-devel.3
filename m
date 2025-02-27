Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD7C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelb-0000XB-Ub; Thu, 27 Feb 2025 09:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekz-0007bs-1f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekt-0003ps-Rg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qmdmd+wL1XBTd0QsgGEcFsO/eGydgDAort0AQ7Nq3Cg=;
 b=bva3h58GyCs3joj2fQ0T5HVjK5BK4roJ5gM4tnYCF4kSX6tek0DYRlP+xHIxGp/oFOvTUW
 EN2Gq7zy4sb7X3qmFAI3GzyHL1W4iSDCPcjsEFL3wRuC66IK5ryZBrJY8EIlMZxjetZS8Z
 5fJLL7n6WqUQoSHiTIQ8P+f2l+sc7g8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-W8QcDvCFMS2AUMicQYZAcA-1; Thu, 27 Feb 2025 09:20:49 -0500
X-MC-Unique: W8QcDvCFMS2AUMicQYZAcA-1
X-Mimecast-MFC-AGG-ID: W8QcDvCFMS2AUMicQYZAcA_1740666049
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5de5172cc5bso918655a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666048; x=1741270848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qmdmd+wL1XBTd0QsgGEcFsO/eGydgDAort0AQ7Nq3Cg=;
 b=QrSk9W1o3B/Bay7hym+9slAsDa04dVRwXO67sQYDAorVgGWWfomJSNx2ozAe76gonr
 kfmeLi7BvjqkiBVPfXeX7X4HOF9U2M5Fdi1Nh6kY97qGMLEyX1kT4iDb7aztUx60aElM
 1DFJNbxSbjnGohJeFKJoW1n5nADxvAj2Aem+JqO4wsEpl2zSSFOu9Uq993Y/6uvPBawd
 dtNLhbPjiyRr4feRuowS1agXS/IHWemWkDL7wCq+yqBtwe855qbLjtDJDaADTNdtKhc7
 DcoQfom3KYETb7qPbnzH0FQ8qtlBKevbPx5WAr40tCMSbInd42ZzhCEQBUATWRZWdkLz
 mwCg==
X-Gm-Message-State: AOJu0YzZvdJdzYzcTZZYYSD3kJ+v89NJdc5SL8nWxQJL9RcHPxumjstZ
 MduZ54C8N7/fk073NX5ygCmoLze29cFXmcXWQT1GDlGui3yXD2T3aqnbDK4hlL5KtesEidknoMb
 sBfL6vPM5WZYM4/33XWFUGWCk+YLr4+SEV2c5UJ59Yta0eAc0BFU7J/bFkxG8hAsiPSgSm3Jwfl
 zPDQj7hoTcLGo4n1beHMMbjgS0BfO49iE+q5ePF0Y=
X-Gm-Gg: ASbGncuzmVfwoxoPv0MZ2m8g7C7p3izjedn8Yu19T+NxrCti/YXKAXOOPvgjmF5L8qX
 vx7bMjZAY0k2ILulcSl/jXdI6Ul4fSbICpawhV3jZTG66XVrPwRRYvTStolzqU3Z8fO+0+jzd4M
 EJRF8bg7dhL7eL7AA9KWwc2fAYpXggRnPi8aAIFu1XvfXRX7ZW2FiQuuGvRtJWJvd6l1f4RpVVC
 Q9XQZkWZQoYosyMSvzoE4CxcddtQHIEILH2xhezz26Is53MjB8GiNh50OBQckT7kuWq1isbXFUT
 qRzhL9OcAhiRMLprCOv+
X-Received: by 2002:a05:6402:524f:b0:5dc:5ada:e0c7 with SMTP id
 4fb4d7f45d1cf-5e44a256c98mr29401273a12.26.1740666047551; 
 Thu, 27 Feb 2025 06:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgoBTCfCzjELF+/8A5x3OoVRzl075bsimUN6iERAAzPqkkWzLwS32RmGxHgy73WV86TD7qiA==
X-Received: by 2002:a05:6402:524f:b0:5dc:5ada:e0c7 with SMTP id
 4fb4d7f45d1cf-5e44a256c98mr29401184a12.26.1740666046820; 
 Thu, 27 Feb 2025 06:20:46 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7c083esm130186666b.175.2025.02.27.06.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/34] rust: qom: get rid of ClassInitImpl
Date: Thu, 27 Feb 2025 15:19:42 +0100
Message-ID: <20250227141952.811410-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Complete the conversion from the ClassInitImpl trait to class_init() methods.
This will provide more freedom to split the qemu_api crate in separate parts.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |   6 +-
 rust/hw/timer/hpet/src/hpet.rs   |   4 +-
 rust/qemu-api/src/qdev.rs        |  38 ++++---
 rust/qemu-api/src/qom.rs         | 164 +++++++++++++------------------
 rust/qemu-api/src/sysbus.rs      |  15 ++-
 rust/qemu-api/tests/tests.rs     |   4 +-
 6 files changed, 101 insertions(+), 130 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 094049cb9e6..d0857b470c9 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -19,8 +19,8 @@
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
-    sysbus::{SysBusDevice, SysBusDeviceClass, SysBusDeviceImpl},
+    qom::{ObjectImpl, Owned, ParentField},
+    sysbus::{SysBusDevice, SysBusDeviceImpl},
     vmstate::VMStateDescription,
 };
 
@@ -145,7 +145,7 @@ trait PL011Impl: SysBusDeviceImpl + IsA<PL011State> {
 impl PL011Class {
     fn class_init<T: PL011Impl>(&mut self) {
         self.device_id = T::DEVICE_ID;
-        <T as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut self.parent_class);
+        self.parent_class.class_init::<T>();
     }
 }
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index e01b4b67064..be27eb0eff4 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -21,7 +21,7 @@
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ClassInitImpl, ObjectImpl, ObjectType, ParentField},
+    qom::{ObjectImpl, ObjectType, ParentField},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL},
@@ -836,7 +836,7 @@ impl ObjectImpl for HPETState {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
-    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
 
 // TODO: Make these properties user-configurable!
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index c4dd26b582c..c136457090c 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -19,7 +19,7 @@
     chardev::Chardev,
     irq::InterruptSource,
     prelude::*,
-    qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
+    qom::{ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
 };
 
@@ -113,7 +113,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// # Safety
 ///
 /// This function is only called through the QOM machinery and
-/// used by the `ClassInitImpl<DeviceClass>` trait.
+/// used by `DeviceClass::class_init`.
 /// We expect the FFI user of this function to pass a valid pointer that
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
@@ -127,43 +127,41 @@ unsafe impl InterfaceType for ResettableClass {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_RESETTABLE_INTERFACE) };
 }
 
-impl<T> ClassInitImpl<ResettableClass> for T
-where
-    T: ResettablePhasesImpl,
-{
-    fn class_init(rc: &mut ResettableClass) {
+impl ResettableClass {
+    /// Fill in the virtual methods of `ResettableClass` based on the
+    /// definitions in the `ResettablePhasesImpl` trait.
+    pub fn class_init<T: ResettablePhasesImpl>(&mut self) {
         if <T as ResettablePhasesImpl>::ENTER.is_some() {
-            rc.phases.enter = Some(rust_resettable_enter_fn::<T>);
+            self.phases.enter = Some(rust_resettable_enter_fn::<T>);
         }
         if <T as ResettablePhasesImpl>::HOLD.is_some() {
-            rc.phases.hold = Some(rust_resettable_hold_fn::<T>);
+            self.phases.hold = Some(rust_resettable_hold_fn::<T>);
         }
         if <T as ResettablePhasesImpl>::EXIT.is_some() {
-            rc.phases.exit = Some(rust_resettable_exit_fn::<T>);
+            self.phases.exit = Some(rust_resettable_exit_fn::<T>);
         }
     }
 }
 
-impl<T> ClassInitImpl<DeviceClass> for T
-where
-    T: ClassInitImpl<ObjectClass> + ClassInitImpl<ResettableClass> + DeviceImpl,
-{
-    fn class_init(dc: &mut DeviceClass) {
+impl DeviceClass {
+    /// Fill in the virtual methods of `DeviceClass` based on the definitions in
+    /// the `DeviceImpl` trait.
+    pub fn class_init<T: DeviceImpl>(&mut self) {
         if <T as DeviceImpl>::REALIZE.is_some() {
-            dc.realize = Some(rust_realize_fn::<T>);
+            self.realize = Some(rust_realize_fn::<T>);
         }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
-            dc.vmsd = vmsd;
+            self.vmsd = vmsd;
         }
         let prop = <T as DeviceImpl>::properties();
         if !prop.is_empty() {
             unsafe {
-                bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
+                bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
             }
         }
 
-        ResettableClass::interface_init::<T, DeviceState>(dc);
-        <T as ClassInitImpl<ObjectClass>>::class_init(&mut dc.parent_class);
+        ResettableClass::cast::<DeviceState>(self).class_init::<T>();
+        self.parent_class.class_init::<T>();
     }
 }
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index d821ac25acc..5488643a2fd 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -40,11 +40,6 @@
 //!   The traits have the appropriate specialization of `IsA<>` as a supertrait,
 //!   for example `IsA<DeviceState>` for `DeviceImpl`.
 //!
-//! * an implementation of [`ClassInitImpl`], for example
-//!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct;
-//!   the source for this is the `*Impl` trait; the associated consts and
-//!   functions if needed are wrapped to map C types into Rust types.
-//!
 //! * a trait for instance methods, for example `DeviceMethods`. This trait is
 //!   automatically implemented for any reference or smart pointer to a device
 //!   instance.  It calls into the vtable provides access across all subclasses
@@ -54,6 +49,48 @@
 //!   This provides access to class-wide functionality that doesn't depend on
 //!   instance data. Like instance methods, these are automatically inherited by
 //!   child classes.
+//!
+//! # Class structures
+//!
+//! Each QOM class that has virtual methods describes them in a
+//! _class struct_.  Class structs include a parent field corresponding
+//! to the vtable of the parent class, all the way up to [`ObjectClass`].
+//!
+//! As mentioned above, virtual methods are defined via traits such as
+//! `DeviceImpl`.  Class structs do not define any trait but, conventionally,
+//! all of them have a `class_init` method to initialize the virtual methods
+//! based on the trait and then call the same method on the superclass.
+//!
+//! ```ignore
+//! impl YourSubclassClass
+//! {
+//!     pub fn class_init<T: YourSubclassImpl>(&mut self) {
+//!         ...
+//!         klass.parent_class::class_init<T>();
+//!     }
+//! }
+//! ```
+//!
+//! If a class implements a QOM interface.  In that case, the function must
+//! contain, for each interface, an extra forwarding call as follows:
+//!
+//! ```ignore
+//! ResettableClass::cast::<Self>(self).class_init::<Self>();
+//! ```
+//!
+//! These `class_init` functions are methods on the class rather than a trait,
+//! because the bound on `T` (`DeviceImpl` in this case), will change for every
+//! class struct.  The functions are pointed to by the
+//! [`ObjectImpl::CLASS_INIT`] function pointer. While there is no default
+//! implementation, in most cases it will be enough to write it as follows:
+//!
+//! ```ignore
+//! const CLASS_INIT: fn(&mut Self::Class)> = Self::Class::class_init::<Self>;
+//! ```
+//!
+//! This design incurs a small amount of code duplication but, by not using
+//! traits, it allows the flexibility of implementing bindings in any crate,
+//! without incurring into violations of orphan rules for traits.
 
 use std::{
     ffi::CStr,
@@ -279,19 +316,25 @@ pub unsafe trait InterfaceType: Sized {
     /// for this interface.
     const TYPE_NAME: &'static CStr;
 
-    /// Initialize the vtable for the interface; the generic argument `T` is the
-    /// type being initialized, while the generic argument `U` is the type that
+    /// Return the vtable for the interface; `U` is the type that
     /// lists the interface in its `TypeInfo`.
     ///
+    /// # Examples
+    ///
+    /// This function is usually called by a `class_init` method in `U::Class`.
+    /// For example, `DeviceClass::class_init<T>` initializes its `Resettable`
+    /// interface as follows:
+    ///
+    /// ```ignore
+    /// ResettableClass::cast::<DeviceState>(self).class_init::<T>();
+    /// ```
+    ///
+    /// where `T` is the concrete subclass that is being initialized.
+    ///
     /// # Panics
     ///
     /// Panic if the incoming argument if `T` does not implement the interface.
-    fn interface_init<
-        T: ObjectType + ClassInitImpl<Self> + ClassInitImpl<U::Class>,
-        U: ObjectType,
-    >(
-        klass: &mut U::Class,
-    ) {
+    fn cast<U: ObjectType>(klass: &mut U::Class) -> &mut Self {
         unsafe {
             // SAFETY: upcasting to ObjectClass is always valid, and the
             // return type is either NULL or the argument itself
@@ -300,8 +343,7 @@ fn interface_init<
                 Self::TYPE_NAME.as_ptr(),
             )
             .cast();
-
-            <T as ClassInitImpl<Self>>::class_init(result.as_mut().unwrap())
+            result.as_mut().unwrap()
         }
     }
 }
@@ -558,87 +600,20 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// the default values coming from the parent classes; the function
     /// can change them to override virtual methods of a parent class.
     ///
-    /// Usually defined as `<Self as ClassInitImpl<Self::Class>::class_init`.
-    const CLASS_INIT: fn(&mut Self::Class);
-}
-
-/// Internal trait used to automatically fill in a class struct.
-///
-/// Each QOM class that has virtual methods describes them in a
-/// _class struct_.  Class structs include a parent field corresponding
-/// to the vtable of the parent class, all the way up to [`ObjectClass`].
-/// Each QOM type has one such class struct; this trait takes care of
-/// initializing the `T` part of the class struct, for the type that
-/// implements the trait.
-///
-/// Each struct will implement this trait with `T` equal to each
-/// superclass.  For example, a device should implement at least
-/// `ClassInitImpl<`[`DeviceClass`](crate::qdev::DeviceClass)`>` and
-/// `ClassInitImpl<`[`ObjectClass`]`>`.  Such implementations are made
-/// in one of two ways.
-///
-/// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
-/// crate itself.  The Rust implementation of methods will come from a
-/// trait like [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl),
-/// and `ClassInitImpl` is provided by blanket implementations that
-/// operate on all implementors of the `*Impl`* trait.  For example:
-///
-/// ```ignore
-/// impl<T> ClassInitImpl<DeviceClass> for T
-/// where
-///     T: ClassInitImpl<ObjectClass> + DeviceImpl,
-/// ```
-///
-/// The bound on `ClassInitImpl<ObjectClass>` is needed so that,
-/// after initializing the `DeviceClass` part of the class struct,
-/// the parent [`ObjectClass`] is initialized as well.
-///
-/// The other case is when manual implementation of the trait is needed.
-/// This covers the following cases:
-///
-/// * if a class implements a QOM interface, the Rust code _has_ to define its
-///   own class struct `FooClass` and implement `ClassInitImpl<FooClass>`.
-///   `ClassInitImpl<FooClass>`'s `class_init` method will then forward to
-///   multiple other `class_init`s, for the interfaces as well as the
-///   superclass. (Note that there is no Rust example yet for using interfaces).
-///
-/// * for classes implemented outside the ``qemu-api`` crate, it's not possible
-///   to add blanket implementations like the above one, due to orphan rules. In
-///   that case, the easiest solution is to implement
-///   `ClassInitImpl<YourSuperclass>` for each subclass and not have a
-///   `YourSuperclassImpl` trait at all.
-///
-/// ```ignore
-/// impl ClassInitImpl<YourSuperclass> for YourSubclass {
-///     fn class_init(klass: &mut YourSuperclass) {
-///         klass.some_method = Some(Self::some_method);
-///         <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
-///     }
-/// }
-/// ```
-///
-///   While this method incurs a small amount of code duplication,
-///   it is generally limited to the recursive call on the last line.
-///   This is because classes defined in Rust do not need the same
-///   glue code that is needed when the classes are defined in C code.
-///   You may consider using a macro if you have many subclasses.
-pub trait ClassInitImpl<T> {
-    /// Initialize `klass` to point to the virtual method implementations
-    /// for `Self`.  On entry, the virtual method pointers are set to
-    /// the default values coming from the parent classes; the function
-    /// can change them to override virtual methods of a parent class.
+    /// Usually defined simply as `Self::Class::class_init::<Self>`;
+    /// however a default implementation cannot be included here, because the
+    /// bounds that the `Self::Class::class_init` method places on `Self` are
+    /// not known in advance.
     ///
-    /// The virtual method implementations usually come from another
-    /// trait, for example [`DeviceImpl`](crate::qdev::DeviceImpl)
-    /// when `T` is [`DeviceClass`](crate::qdev::DeviceClass).
+    /// # Safety
     ///
-    /// On entry, `klass`'s parent class is initialized, while the other fields
+    /// While `klass`'s parent class is initialized on entry, the other fields
     /// are all zero; it is therefore assumed that all fields in `T` can be
     /// zeroed, otherwise it would not be possible to provide the class as a
     /// `&mut T`.  TODO: add a bound of [`Zeroable`](crate::zeroable::Zeroable)
     /// to T; this is more easily done once Zeroable does not require a manual
     /// implementation (Rust 1.75.0).
-    fn class_init(klass: &mut T);
+    const CLASS_INIT: fn(&mut Self::Class);
 }
 
 /// # Safety
@@ -651,13 +626,12 @@ pub trait ClassInitImpl<T> {
     T::UNPARENT.unwrap()(unsafe { state.as_ref() });
 }
 
-impl<T> ClassInitImpl<ObjectClass> for T
-where
-    T: ObjectImpl,
-{
-    fn class_init(oc: &mut ObjectClass) {
+impl ObjectClass {
+    /// Fill in the virtual methods of `ObjectClass` based on the definitions in
+    /// the `ObjectImpl` trait.
+    pub fn class_init<T: ObjectImpl>(&mut self) {
         if <T as ObjectImpl>::UNPARENT.is_some() {
-            oc.unparent = Some(rust_unparent_fn::<T>);
+            self.unparent = Some(rust_unparent_fn::<T>);
         }
     }
 }
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index fee2e3d478f..04821a2b9b3 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -14,8 +14,8 @@
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
-    qdev::{DeviceClass, DeviceImpl, DeviceState},
-    qom::{ClassInitImpl, Owned},
+    qdev::{DeviceImpl, DeviceState},
+    qom::Owned,
 };
 
 unsafe impl ObjectType for SysBusDevice {
@@ -28,12 +28,11 @@ unsafe impl ObjectType for SysBusDevice {
 // TODO: add virtual methods
 pub trait SysBusDeviceImpl: DeviceImpl + IsA<SysBusDevice> {}
 
-impl<T> ClassInitImpl<SysBusDeviceClass> for T
-where
-    T: SysBusDeviceImpl + ClassInitImpl<DeviceClass>,
-{
-    fn class_init(sdc: &mut SysBusDeviceClass) {
-        <T as ClassInitImpl<DeviceClass>>::class_init(&mut sdc.parent_class);
+impl SysBusDeviceClass {
+    /// Fill in the virtual methods of `SysBusDeviceClass` based on the
+    /// definitions in the `SysBusDeviceImpl` trait.
+    pub fn class_init<T: SysBusDeviceImpl>(self: &mut SysBusDeviceClass) {
+        self.parent_class.class_init::<T>();
     }
 }
 
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 93c5637bbc3..e3985782a38 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -14,7 +14,7 @@
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
-    qom::{ClassInitImpl, ObjectImpl, ParentField},
+    qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
     vmstate::VMStateDescription,
     zeroable::Zeroable,
@@ -43,7 +43,7 @@ pub struct DummyClass {
 
 impl DummyClass {
     pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
-        <T as ClassInitImpl<DeviceClass>>::class_init(&mut self.parent_class);
+        self.parent_class.class_init::<T>();
     }
 }
 
-- 
2.48.1


