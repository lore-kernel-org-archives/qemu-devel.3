Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1DCE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFR-0001mV-7b; Thu, 19 Dec 2024 11:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOI-00065h-OS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOG-00087N-Uk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vGbxeyUby2e1YBpFsrxSiWFR5XYA6Df2008LzEqLo4=;
 b=fCESzMEqCcFHLHvGeAHwxvY0l+2jjuXHM4EWYqdPxngMANvpCrFwLE1ZDP98ruL5MpUmRG
 2xADaeCJSxcif/z+L2Oc3zYBj/jFnOu74RkUnyt5L1pIIvwlMRS6zPq50ibaX6meziO3Oq
 uQ3/Qnh8wJ3VxTVVrveHDH8fTg3Or2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-mH16JKLzO-6V2X5QTeH-ew-1; Thu, 19 Dec 2024 07:12:23 -0500
X-MC-Unique: mH16JKLzO-6V2X5QTeH-ew-1
X-Mimecast-MFC-AGG-ID: mH16JKLzO-6V2X5QTeH-ew
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so6107775e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610340; x=1735215140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vGbxeyUby2e1YBpFsrxSiWFR5XYA6Df2008LzEqLo4=;
 b=LO2oWHIZC0zvpOpb8W0gwjhgZLkQkTV3rKv6d4f8aD56yePd15KGy9uv6HwRnthcNa
 nFWW/rRhUJoLQo2p+YKYUVXQJPcD5SLaisDkkuJ6a/kRBsnGfnF2rydL+Kg/oGk4Y/mw
 v0FwpDwmq5tXUqJ5PrR7asVQhWKBsUdSEf8iUvwo2NfNkxuKsLVWrHvuw83pBFvISF73
 Lt6G1N0/irQP1qQncZ6AYwoXsreZekKoLUW2RVwV1n+Kw2Uau7StAFTPtAFm+kSpo/Z9
 vWvxyiXKDhYdZziJ3iVfQtPiiu+12rDaory9RWxQHcfsOfluz1aX3I7iH59T8WzplpeY
 R9eQ==
X-Gm-Message-State: AOJu0YzJ2dHqYyCyvQe7jMMsw9wQ0rTKEY7Pf7CKcBXqkkMF8gWCkIAQ
 k+oZ72nDVwQ81A5cl+xf2xiLA7+OL5v5kDlvBtSrirm/LpGK0/jbTM1MtJox1YuOUMai54vl5uI
 kguk58fxqXojVWZJJ7p8KsIJ0Tua8KDMxKzA8Am3bmAfSpdARaRHeiUvG+mzQpdfTrP1xWz24+K
 5zGpcbRTHV5SShlygjRyScX1kEv96LS3iP5rzi
X-Gm-Gg: ASbGncu+OW3JlWkhc+t0nbhPhzE/ra0RcbKu9Z9TFBtN0+C/3w2sJGD6lsECo8Niofk
 4S81/zArAmKMxKXjjNrO91J5fVBwO/HSIDb593kctUfpIm3nZq1K6b9OJwCmmUg/g0JA9o/RPP4
 oOGR5TZQaMZcmr/dY3CF5FV0QdSwAyIAvHWNDKs17FsIyY/ult/jmE8gQFhEKKZvk35RctWNu59
 Z6hIu58ibuEDvVon0eWbYcUtgfcfA4aic0Wdnu9gP3984atxW6t4b0KcoOO
X-Received: by 2002:a5d:64a7:0:b0:385:f560:7924 with SMTP id
 ffacd0b85a97d-388e4d30f16mr5206554f8f.4.1734610340519; 
 Thu, 19 Dec 2024 04:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGLDLy1I/JHySafW0VHoWat3oVlESM2h61+AfUoumbqC+QQB+VnBHfnXAlca1gz+Z/1uGPsg==
X-Received: by 2002:a5d:64a7:0:b0:385:f560:7924 with SMTP id
 ffacd0b85a97d-388e4d30f16mr5206518f8f.4.1734610339983; 
 Thu, 19 Dec 2024 04:12:19 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366121955fsm16756355e9.21.2024.12.19.04.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 01/10] rust: qom: add ParentField
Date: Thu, 19 Dec 2024 13:12:07 +0100
Message-ID: <20241219121216.416905-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 ++--
 rust/qemu-api/src/qom.rs         | 56 +++++++++++++++++++++++++++++---
 rust/qemu-api/tests/tests.rs     |  4 +--
 3 files changed, 57 insertions(+), 9 deletions(-)

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
index 7d5fbef1e17..1341a173893 100644
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
@@ -151,8 +198,9 @@ fn as_ref(&self) -> &$parent {
 ///
 /// - the struct must be `#[repr(C)]`;
 ///
-/// - the first field of the struct must be of the instance struct corresponding
-///   to the superclass, which is `ObjectImpl::ParentType`
+/// - the first field of the struct must be of type
+///   [`ParentField<T>`](ParentField), where `T` is the parent type
+///   [`ObjectImpl::ParentType`]
 ///
 /// - likewise, the first field of the `Class` must be of the class struct
 ///   corresponding to the superclass, which is `ObjectImpl::ParentType::Class`.
@@ -384,8 +432,8 @@ impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
-    /// The parent of the type.  This should match the first field of
-    /// the struct that implements `ObjectImpl`:
+    /// The parent of the type.  This should match the first field of the
+    /// struct that implements `ObjectImpl`, minus the `ParentField<_>` wrapper.
     type ParentType: ObjectType;
 
     /// Whether the object can be instantiated
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 41ea4026b83..3b3cf793ae3 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -15,7 +15,7 @@
     c_str, declare_properties, define_property,
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


