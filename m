Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8463FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2d-0000PH-FG; Fri, 10 Jan 2025 13:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1p-0000Bf-K8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1k-000150-4s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+ve94DKbTOVXrMnq6VI7ki09hbI6XC3Vzt03Al6AE8=;
 b=hKq8ZdEnJHr9FrLZQvwu7/N3RrHBW21LuQAgH0zL3xRCETdYP2qbGDzdePC5YKFGsoJpVV
 hheWC6WtiToCf+gXziIsw/JQAcBeC92oHpTqzL8kkF+1fbyEfASHFiVXb4PB42M6lQo1nv
 UxNTJsxlPFZgBeb8TQ+X6Oy1sC2ZGIE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-IACNSdQNNLeHXMPpA1e-yQ-1; Fri, 10 Jan 2025 13:46:31 -0500
X-MC-Unique: IACNSdQNNLeHXMPpA1e-yQ-1
X-Mimecast-MFC-AGG-ID: IACNSdQNNLeHXMPpA1e-yQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa66f6ce6bfso197494366b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534789; x=1737139589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+ve94DKbTOVXrMnq6VI7ki09hbI6XC3Vzt03Al6AE8=;
 b=kM9tbVw5IVA+o9aVZgO8QaIL81DrpROp8WPSaY1pkIsRfK8SjweT9oau2BNDEdIQ1R
 9EE9cSbsXY4CkJgqbwsMaDnRX3zk3KivPsWgnomILsOIOl0YWtNL0t49O1Pc6l0WWBhp
 p9LN8e5gGrBzsUOV1CBlYGBbW7v+Ygq8+V6vdkqMjAUB2tk6klgVBmvTvq5kVlNxsTXF
 8kVmvb5fH4xj0NJiKxd5PUzQZeh5x8/da2GuNUowjIH5iGQeTyRavAfRaXjaJdghohDX
 BFZRa8PalpJ8bL0HHV622qHN7QeprHWJu4lJVu4e4OF8ZEkSow2H/+D4zVk+1vr0u+iq
 R3Kg==
X-Gm-Message-State: AOJu0Yz0SNyBgjAhuRHw9lmwnLK3P8QqooYTELkg9lsasbKK7iGLIhL5
 FLicp/zYDSqVO5K4SJmd45VDH9T0Re4PA8pDLzaFFUNht9Okqx7qUI6VNSCnXxsL/RjpBArJpj+
 Y0CqJXt9lowXOrSv9qCPzgGnT6lk9cIpKgH+c44nMMoqotBZCeVLLLUq95utAPUp6ugcpiYP7Z1
 2AcZUW58nYECWaNSbEs29GC+A2dZ5v7s42ElZmXW0=
X-Gm-Gg: ASbGncsmk/3b/Sw7EGiZh5tbrSmEA1+SDhpq3g/lZOPJuJbV41Srk2scHvUkXCZft6c
 BVhtoeZio1ZEAUrBJ04Gm0TweUNAhHCKzM2fY4ZrGHRnZ2kyDT03kO/5XVtyk1QBZdgpLit5pzI
 gpkjbiumMYw9WesqK8aMJ1v2a3NiPSn2nDfrgkPHhMuiSV9Zu60g1dx2Hl3eLBhZTDOFLzo/KsR
 hJTD2PRHtJz8dNwcKjA+UJIs4OKVqOprMx/Un0MqQVKu8ulMnlLaHpYq9U=
X-Received: by 2002:a17:907:2d1e:b0:aa6:93c4:c685 with SMTP id
 a640c23a62f3a-ab2ab6bfe87mr1050800766b.23.1736534789193; 
 Fri, 10 Jan 2025 10:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzmdYqPe86rzk8xjbj3VeKJGaUx3BwcVwm5HoG/DGpRmH9YlJxYAPnEMUNvMmodfJCCj4grA==
X-Received: by 2002:a17:907:2d1e:b0:aa6:93c4:c685 with SMTP id
 a640c23a62f3a-ab2ab6bfe87mr1050798566b.23.1736534788635; 
 Fri, 10 Jan 2025 10:46:28 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90db325sm195677166b.65.2025.01.10.10.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/38] rust: qom: add ParentField
Date: Fri, 10 Jan 2025 19:45:44 +0100
Message-ID: <20250110184620.408302-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Add a type that, together with the C function object_deinit, ensures the
correct drop order for QOM objects relative to their superclasses.

Right now it is not possible to implement the Drop trait for QOM classes
that are defined in Rust, as the drop() function would not be called when
the object goes away; instead what is called is ObjectImpl::INSTANCE_FINALIZE.
It would be nice for INSTANCE_FINALIZE to just drop the object, but this has
a problem: suppose you have

   pub struct MySuperclass {
       parent: DeviceState,
       field: Box<MyData>,
       ...
   }

   impl Drop for MySuperclass {
       ...
   }

   pub struct MySubclass {
       parent: MySuperclass,
       ...
   }

and an instance_finalize implementation that is like

    unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
        unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
    }

When instance_finalize is called for MySubclass, it will walk the struct's
list of fields and call the drop method for MySuperclass.  Then, object_deinit
recurses to the superclass and calls the same drop method again.  This
will cause double-freeing of the Box<Data>.

What's happening here is that QOM wants to control the drop order of
MySuperclass and MySubclass's fields.  To do so, the parent field must
be marked ManuallyDrop<>, which is quite ugly.  Instead, add a wrapper
type ParentField<> that is specific to QOM.  This hides the implementation
detail of *what* is special about the ParentField, and will also be easy
to check in the #[derive(Object)] macro.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 +--
 rust/qemu-api/src/qom.rs         | 64 +++++++++++++++++++++++++++++---
 rust/qemu-api/tests/tests.rs     |  4 +-
 3 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 18cc122951d..689202f4550 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -14,7 +14,7 @@
     irq::InterruptSource,
     prelude::*,
     qdev::DeviceImpl,
-    qom::ObjectImpl,
+    qom::{ObjectImpl, ParentField},
 };
 
 use crate::{
@@ -86,7 +86,7 @@ fn index(&self, idx: u32) -> &Self::Output {
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
-    pub parent_obj: SysBusDevice,
+    pub parent_obj: ParentField<SysBusDevice>,
     pub iomem: MemoryRegion,
     #[doc(alias = "fr")]
     pub flags: registers::Flags,
@@ -645,7 +645,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 #[derive(Debug, qemu_api_macros::Object)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
-    parent_obj: PL011State,
+    parent_obj: ParentField<PL011State>,
 }
 
 impl PL011Luminary {
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 7d5fbef1e17..40d17a92e1f 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -55,6 +55,7 @@
 
 use std::{
     ffi::CStr,
+    fmt,
     ops::{Deref, DerefMut},
     os::raw::c_void,
 };
@@ -105,6 +106,52 @@ fn as_ref(&self) -> &$parent {
     };
 }
 
+/// This is the same as [`ManuallyDrop<T>`](std::mem::ManuallyDrop), though
+/// it hides the standard methods of `ManuallyDrop`.
+///
+/// The first field of an `ObjectType` must be of type `ParentField<T>`.
+/// (Technically, this is only necessary if there is at least one Rust
+/// superclass in the hierarchy).  This is to ensure that the parent field is
+/// dropped after the subclass; this drop order is enforced by the C
+/// `object_deinit` function.
+///
+/// # Examples
+///
+/// ```ignore
+/// #[repr(C)]
+/// #[derive(qemu_api_macros::Object)]
+/// pub struct MyDevice {
+///     parent: ParentField<DeviceState>,
+///     ...
+/// }
+/// ```
+#[derive(Debug)]
+#[repr(transparent)]
+pub struct ParentField<T: ObjectType>(std::mem::ManuallyDrop<T>);
+
+impl<T: ObjectType> Deref for ParentField<T> {
+    type Target = T;
+
+    #[inline(always)]
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T: ObjectType> DerefMut for ParentField<T> {
+    #[inline(always)]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.0
+    }
+}
+
+impl<T: fmt::Display + ObjectType> fmt::Display for ParentField<T> {
+    #[inline(always)]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
+        self.0.fmt(f)
+    }
+}
+
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
     // is called from QOM core as the instance_init function
@@ -151,11 +198,16 @@ fn as_ref(&self) -> &$parent {
 ///
 /// - the struct must be `#[repr(C)]`;
 ///
-/// - the first field of the struct must be of the instance struct corresponding
-///   to the superclass, which is `ObjectImpl::ParentType`
+/// - the first field of the struct must be of type
+///   [`ParentField<T>`](ParentField), where `T` is the parent type
+///   [`ObjectImpl::ParentType`]
 ///
-/// - likewise, the first field of the `Class` must be of the class struct
-///   corresponding to the superclass, which is `ObjectImpl::ParentType::Class`.
+/// - the first field of the `Class` must be of the class struct corresponding
+///   to the superclass, which is `ObjectImpl::ParentType::Class`. `ParentField`
+///   is not needed here.
+///
+/// In both cases, having a separate class type is not necessary if the subclass
+/// does not add any field.
 pub unsafe trait ObjectType: Sized {
     /// The QOM class object corresponding to this struct.  This is used
     /// to automatically generate a `class_init` method.
@@ -384,8 +436,8 @@ impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
-    /// The parent of the type.  This should match the first field of
-    /// the struct that implements `ObjectImpl`:
+    /// The parent of the type.  This should match the first field of the
+    /// struct that implements `ObjectImpl`, minus the `ParentField<_>` wrapper.
     type ParentType: ObjectType;
 
     /// Whether the object can be instantiated
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 1d2825b0986..526c3f4f8ea 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -15,7 +15,7 @@
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property},
-    qom::ObjectImpl,
+    qom::{ObjectImpl, ParentField},
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
@@ -31,7 +31,7 @@
 #[repr(C)]
 #[derive(qemu_api_macros::Object)]
 pub struct DummyState {
-    parent: DeviceState,
+    parent: ParentField<DeviceState>,
     migrate_clock: bool,
 }
 
-- 
2.47.1


