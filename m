Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1EAE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaT-0003wt-3h; Wed, 11 Dec 2024 11:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaQ-0003lb-0g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaN-0000j8-Ua
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goSFoLP9ZZzBeb1oQrmWlXZpCZrwinc7Rd5f+O1pfS8=;
 b=EGmdUqJaNGjq0j6jmDYPMx2LQKn5BKltNKQ3Cp0Gk8Jm11qdEi+1g/vJagXsDXapFWoA7h
 35vLd0TtyhL6T2hLUlTSscfiFSbwmzeM5ONGIOt1AXAVQkigtS8ALNWeNY/E5v4Fi/8uvg
 36CEG7UUngeWtI6ruZbcJyTyUTdXnsE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-VOG3BQeGM0C2xWZCKYqs1Q-1; Wed, 11 Dec 2024 11:29:13 -0500
X-MC-Unique: VOG3BQeGM0C2xWZCKYqs1Q-1
X-Mimecast-MFC-AGG-ID: VOG3BQeGM0C2xWZCKYqs1Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385df115288so2972721f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934552; x=1734539352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goSFoLP9ZZzBeb1oQrmWlXZpCZrwinc7Rd5f+O1pfS8=;
 b=mLp49fFJZkSk1QoDE9w/0krxMFGSGQsm2J8CqaIegrYqtWnLhIP/wC5TN2pBFquyDt
 EQyyoefOdUGG06y2tMyqyzuufmYcoYUapQRV8cEHjNgYy/62huStEArZHH+BLpRlJRLY
 8QaWjy1MYsY9/eLrr3Fk+R5JdTzbADOLKe22pA1iGwMnc+fmxTbYbJ6bRdsvjzg4P482
 JQifMPbL5eFp0HIZSEjKQk+p5ELdam/hw+kqNXmZkkJp4OXKWeMihxk3J/9pW9ve3JqV
 b/t0M04u/MEHFG9MI5N65kszuic+LWZDfUzVuqq2gMQDIjjMUA5k9VYhoXsUuuXJiDwe
 i2hQ==
X-Gm-Message-State: AOJu0Yx/sbMe/32bh7oxGYODwdfgHBFtM3VmKNFTTMjPUVTcOy7ufbMo
 G72qFnr/FDAx50Jh1Fku6stV75aLNkfFi1rhF6GvplcYbBAAPojfphVfFZpBzGTnb0pyYdZDCKO
 DFIVWrUD53uWMb3F9uQa2ziVTjyGlpgbtvu54lvTFbd+27ZgOPezf3BbLuIBqocxghZUbkYAqXX
 arAkWScIcVJJU46ILdvO1ehmnDamejF2vXvDr2
X-Gm-Gg: ASbGnctV3XCDV7d5FArb1OROTzuSlsti2rfMO7dTtTyOL8aYq69aMCMFFJnoYTU5tew
 LiXu1JiamQqKDOEeLj1IrAPTP2yzIZSZSDs09tc1YDVtFeRWm7XgHZbOL5TKdtVFX60U+llowzf
 HJMAbJhE/d1vT/KeI4NiG4iVArvyWVjizGfq6vNUzXl3g6ylcTnxzLDTODGW4Xlqtr9Tl48qfSf
 lPYXCRKyIcrMv3FWJ9xILbQQufIzy1olgTpqizml56GDXmk8mpG0b0A
X-Received: by 2002:a5d:47c6:0:b0:385:f062:c2df with SMTP id
 ffacd0b85a97d-3864ce4968emr3330992f8f.11.1733934551558; 
 Wed, 11 Dec 2024 08:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVKTEij2xde+OaauMr8jeMSHVSr8tiBVX8BoCT5vhHI9fdqWO+vH9yXfdaeYkoNJZpdRO3bg==
X-Received: by 2002:a5d:47c6:0:b0:385:f062:c2df with SMTP id
 ffacd0b85a97d-3864ce4968emr3330964f8f.11.1733934551061; 
 Wed, 11 Dec 2024 08:29:11 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dbbfsm1609110f8f.97.2024.12.11.08.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 48/49] rust: qom: split ObjectType from ObjectImpl trait
Date: Wed, 11 Dec 2024 17:27:18 +0100
Message-ID: <20241211162720.320070-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Define a separate trait for fields that also applies to classes that are
defined by C code.  This makes it possible to add metadata to core classes,
which has multiple uses:

- it makes it possible to access the parent struct's TYPE_* for types
  that are defined in Rust code, and to avoid repeating it in every subclass

- implementors of ObjectType will be allowed to implement the IsA<> trait and
  therefore to perform typesafe casts from one class to another.

- in the future, an ObjectType could be created with Foo::new() in a type-safe
  manner, without having to pass a TYPE_* constant.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  | 17 ++++++++++++-----
 rust/qemu-api/src/definitions.rs  | 27 +++++++++++++++++++++------
 rust/qemu-api/src/device_class.rs | 11 ++++++-----
 rust/qemu-api/src/prelude.rs      |  2 ++
 rust/qemu-api/src/sysbus.rs       | 10 ++++++++--
 rust/qemu-api/tests/tests.rs      | 17 +++++++++--------
 6 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b9f8fb134b5..0ab825b1ca4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,9 +12,10 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
-    device_class::{DeviceImpl, TYPE_SYS_BUS_DEVICE},
+    device_class::DeviceImpl,
     impl_device_class,
     irq::InterruptSource,
+    prelude::*,
 };
 
 use crate::{
@@ -106,10 +107,13 @@ pub struct PL011State {
     device_id: DeviceId,
 }
 
-impl ObjectImpl for PL011State {
+unsafe impl ObjectType for PL011State {
     type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
+}
+
+impl ObjectImpl for PL011State {
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<SysBusDevice as ObjectType>::TYPE_NAME);
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
@@ -640,10 +644,13 @@ unsafe fn init(&mut self) {
     }
 }
 
-impl ObjectImpl for PL011Luminary {
+unsafe impl ObjectType for PL011Luminary {
     type Class = PL011LuminaryClass;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
+}
+
+impl ObjectImpl for PL011Luminary {
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<PL011State as ObjectType>::TYPE_NAME);
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index f2970758986..b98a6926785 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -26,25 +26,40 @@
     T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
 }
 
-/// Trait a type must implement to be registered with QEMU.
+/// Trait exposed by all structs corresponding to QOM objects.
 ///
 /// # Safety
 ///
-/// - the struct must be `#[repr(C)]`
+/// For classes declared in C:
 ///
-/// - `Class` and `TYPE` must match the data in the `TypeInfo` (this is
-///   automatic if the class is defined via `ObjectImpl`).
+/// - `Class` and `TYPE` must match the data in the `TypeInfo`;
+///
+/// - the first field of the struct must be of the instance type corresponding
+///   to the superclass, as declared in the `TypeInfo`
+///
+/// - likewise, the first field of the `Class` struct must be of the class type
+///   corresponding to the superclass
+///
+/// For classes declared in Rust and implementing [`ObjectImpl`]:
+///
+/// - the struct must be `#[repr(C)]`;
 ///
 /// - the first field of the struct must be of the instance struct corresponding
-///   to the superclass declared as `PARENT_TYPE_NAME`
-pub trait ObjectImpl: ClassInitImpl + Sized {
+///   to the superclass, as declared in `ObjectImpl::PARENT_TYPE_NAME`
+///
+/// - likewise, the first field of the `Class` must be of the class struct
+///   corresponding to the superclass
+pub unsafe trait ObjectType: Sized {
     /// The QOM class object corresponding to this struct.  Not used yet.
     type Class;
 
     /// The name of the type, which can be passed to `object_new()` to
     /// generate an instance of this type.
     const TYPE_NAME: &'static CStr;
+}
 
+/// Trait a type must implement to be registered with QEMU.
+pub trait ObjectImpl: ObjectType + ClassInitImpl {
     /// The parent of the type.  This should match the first field of
     /// the struct that implements `ObjectImpl`:
     const PARENT_TYPE_NAME: Option<&'static CStr>;
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index f25904be4f6..03d03feee83 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    prelude::*,
     zeroable::Zeroable,
 };
 
@@ -146,8 +147,8 @@ macro_rules! declare_properties {
     };
 }
 
-// workaround until we can use --generate-cstr in bindgen.
-pub const TYPE_DEVICE: &CStr =
-    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
-pub const TYPE_SYS_BUS_DEVICE: &CStr =
-    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
+unsafe impl ObjectType for bindings::DeviceState {
+    type Class = bindings::DeviceClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
+}
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index a39e228babf..1b8677b2d9a 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -6,3 +6,5 @@
 
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
+
+pub use crate::definitions::ObjectType;
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 4e192c75898..5ee068541cf 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,11 +2,17 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ptr::addr_of;
+use std::{ffi::CStr, ptr::addr_of};
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
-use crate::{bindings, cell::bql_locked, irq::InterruptSource};
+use crate::{bindings, cell::bql_locked, irq::InterruptSource, prelude::*};
+
+unsafe impl ObjectType for SysBusDevice {
+    type Class = SysBusDeviceClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
+}
 
 impl SysBusDevice {
     /// Return `self` cast to a mutable pointer, for use in calls to C code.
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index b8b12a40422..1d027dd6527 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,12 +5,8 @@
 use std::ffi::CStr;
 
 use qemu_api::{
-    bindings::*,
-    c_str, declare_properties, define_property,
-    definitions::ObjectImpl,
-    device_class::{self, DeviceImpl},
-    impl_device_class,
-    zeroable::Zeroable,
+    bindings::*, c_str, declare_properties, define_property, definitions::ObjectImpl,
+    device_class::DeviceImpl, impl_device_class, prelude::*, zeroable::Zeroable,
 };
 
 #[test]
@@ -46,10 +42,15 @@ pub struct DummyClass {
             ),
     }
 
-    impl ObjectImpl for DummyState {
+    unsafe impl ObjectType for DummyState {
         type Class = DummyClass;
         const TYPE_NAME: &'static CStr = c_str!("dummy");
-        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
+    }
+
+    impl ObjectImpl for DummyState {
+        const PARENT_TYPE_NAME: Option<&'static CStr> =
+            Some(<DeviceState as ObjectType>::TYPE_NAME);
+        const ABSTRACT: bool = false;
     }
 
     impl DeviceImpl for DummyState {
-- 
2.47.1


