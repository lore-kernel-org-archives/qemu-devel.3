Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A151D3B7EC
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6Q-0004tj-IH; Mon, 25 Nov 2024 03:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU6A-0004pk-VJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU66-0007Jx-WA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0LKrlVTFy584wQxeSUgT7J8vD0knzrWEoGW7oa1C9A=;
 b=S2xPYuyGm9pa2bUcRcuGvgd1rwmM35jsUHEcwR1k48gXFGuUhG3DFN4H/2YAbFJMZ3lhtj
 BRAMQO+03bON1BDJIhdYFiMPMy8EYf/tZ85U5nNn2IT8rSATqaL3Btlgna/suKud00D1Mt
 xuyjZk3qHCtKeTXEzyZ94OD3l4HPyBw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-K0shBqNgMeGAfmX_jowrMw-1; Mon, 25 Nov 2024 03:05:25 -0500
X-MC-Unique: K0shBqNgMeGAfmX_jowrMw-1
X-Mimecast-MFC-AGG-ID: K0shBqNgMeGAfmX_jowrMw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so2330050f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521924; x=1733126724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0LKrlVTFy584wQxeSUgT7J8vD0knzrWEoGW7oa1C9A=;
 b=fCSFkVmXAR5fx13bT+1dIcQnoORe21bNVgg0K50IFuI72DhWcQWezE+59FPXRfY/er
 y+Onkis73htndYVc26J6kEkkgm9CWpltsNCOfmlDqJ77sfIH4kAT4TedH/leVq1pyvHv
 sPN3YJTh0d3KOAQ9QsjQM6jb8hIeqfZ3T1949pmPvzOHNPQUKB9yjKuogU2/ls7V34fs
 LFiD7bVhJaaWQuAJQ02Tl82AowjirE28+jxOQuKRLgUN5wiHnqrdzieerIb7eCnK+yzq
 NfTPxSSvMnMMMEhoS0Nr0Y+vzOVtUoemqNPjCu9QpEBk78H9VTeOiUq/C4BeTaf6dkJY
 qi4w==
X-Gm-Message-State: AOJu0Yznf2Yl50ecrIBVnPEkupIdCNEEN1ZL0YvDab0eX0FpvB9uR6ZZ
 UR0rg7Cg9bH86Cx7HzYjN7Q4EhuHLIOQRuTf0rdLAXPOKMMIuMGOpmRXIfxi4G9qCx3FYiE518o
 b2RZXIlB7fl6BOcm2cfMOoM2OfCQkEIrqx0r6QR+fGLmzaV9BzydQQ34okw8M0vyxHrjcfSBFOC
 9gEbELPlmO6Wke1d/6B7gn5DAKJEpfnUAGuUPA
X-Gm-Gg: ASbGnctb+MYCvyDfCPN8fD4O9UKuk2cqWYXEUSUw6ABriT6v6QHBgHfqEkhHHnTxXJ+
 gqT9FJ9rmMiXFmVpjG3TJhNp6Nu9JjLF2JFXlH0h+oIrMMzZDkLcVL1Gbs3YlLrfhNHnJk/JTTA
 RKf73lo2SZtKqqNZ08BP3Gv3uEPXWlprMF1vaH1BZwo2tM3m1AGLx3ntLuNSWXQA1I8Cat2Wpz/
 eOFz54lcRdbKq6eADqCVMHQSjYp1uVRrMHxng4NNAV/MukQpTJbyKI=
X-Received: by 2002:a05:6000:154c:b0:381:f0d0:ed2c with SMTP id
 ffacd0b85a97d-38259d5115bmr11437329f8f.29.1732521923772; 
 Mon, 25 Nov 2024 00:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEYs7UvfWqQf0jRh4p3wETYoP3YjpOXimWJ57488yHvj+CJsU8xTyJo2SBqzERH2vGEwZzMg==
X-Received: by 2002:a05:6000:154c:b0:381:f0d0:ed2c with SMTP id
 ffacd0b85a97d-38259d5115bmr11437299f8f.29.1732521923297; 
 Mon, 25 Nov 2024 00:05:23 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd04ec7sm9630096f8f.110.2024.11.25.00.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/8] rust: qdev: move device_class_init! body to generic
 function, ClassInitImpl implementation to macro
Date: Mon, 25 Nov 2024 09:05:04 +0100
Message-ID: <20241125080507.115450-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use a trait to access the former parameters to device_class_init!.
This allows hiding the details of the class_init implementation behind
a generic function and makes higher-level functionality available from
qemu_api.

The implementation of ClassInitImpl is then the same for all devices and
is easily macroized.  Later on, we can remove the need to implement
ClassInitImpl by hand for all device types, and stop making
rust_device_class_init<>() public.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 34 ++++++-----
 rust/hw/char/pl011/src/device_class.rs |  8 ---
 rust/qemu-api/src/device_class.rs      | 85 +++++++++++++++++++++-----
 rust/qemu-api/tests/tests.rs           | 28 ++++-----
 4 files changed, 100 insertions(+), 55 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 21d86b41f2e..1906b9022bd 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,11 +12,13 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
-    device_class::TYPE_SYS_BUS_DEVICE,
+    device_class::{DeviceImpl, TYPE_SYS_BUS_DEVICE},
+    impl_device_class,
     irq::InterruptSource,
 };
 
 use crate::{
+    device_class,
     memory_ops::PL011_OPS,
     registers::{self, Interrupt},
     RegisterOffset,
@@ -116,14 +118,20 @@ pub struct PL011Class {
     _inner: [u8; 0],
 }
 
-impl qemu_api::definitions::ClassInitImpl for PL011State {
-    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
-        Some(crate::device_class::pl011_class_init);
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
-    > = None;
+impl DeviceImpl for PL011State {
+    fn properties() -> &'static [Property] {
+        &device_class::PL011_PROPERTIES
+    }
+    fn vmsd() -> Option<&'static VMStateDescription> {
+        Some(&device_class::VMSTATE_PL011)
+    }
+    const REALIZE: Option<unsafe extern "C" fn(*mut DeviceState, *mut *mut Error)> =
+        Some(device_class::pl011_realize);
+    const RESET: Option<unsafe extern "C" fn(*mut DeviceState)> = Some(device_class::pl011_reset);
 }
 
+impl_device_class!(PL011State);
+
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
     ///
@@ -649,17 +657,13 @@ pub struct PL011LuminaryClass {
     }
 }
 
-impl qemu_api::definitions::ClassInitImpl for PL011Luminary {
-    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
-        None;
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
-    > = None;
-}
-
 impl ObjectImpl for PL011Luminary {
     type Class = PL011LuminaryClass;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
 }
+
+impl DeviceImpl for PL011Luminary {}
+
+impl_device_class!(PL011Luminary);
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index a707fde1384..c61b6bb0258 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -93,14 +93,6 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     ),
 }
 
-qemu_api::device_class_init! {
-    pl011_class_init,
-    props => PL011_PROPERTIES,
-    realize_fn => Some(pl011_realize),
-    legacy_reset_fn => Some(pl011_reset),
-    vmsd => VMSTATE_PL011,
-}
-
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer, that has
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 0ba798d3e3c..72cea345f87 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,25 +2,78 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings;
+use crate::bindings::{
+    self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription,
+};
+
+pub trait DeviceImpl {
+    /// _Realization_ is the second stage of device creation. It contains
+    /// all operations that depend on device properties and can fail (note:
+    /// this is not yet supported for Rust devices).
+    ///
+    /// If not `None`, the parent class's `realize` method is overridden
+    /// with the function pointed to by `REALIZE`.
+    const REALIZE: Option<unsafe extern "C" fn(*mut DeviceState, *mut *mut Error)> = None;
+
+    /// If not `None`, the parent class's `reset` method is overridden
+    /// with the function pointed to by `RESET`.
+    ///
+    /// Rust does not yet support the three-phase reset protocol; this is
+    /// usually okay for leaf classes.
+    const RESET: Option<unsafe extern "C" fn(dev: *mut DeviceState)> = None;
+
+    /// An array providing the properties that the user can set on the
+    /// device.  Not a `const` because referencing statics in constants
+    /// is unstable until Rust 1.83.0.
+    fn properties() -> &'static [Property] {
+        &[]
+    }
+
+    /// A `VMStateDescription` providing the migration format for the device
+    /// Not a `const` because referencing statics in constants is unstable
+    /// until Rust 1.83.0.
+    fn vmsd() -> Option<&'static VMStateDescription> {
+        None
+    }
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `DeviceClass`, because `T` implements
+/// `DeviceImpl`.
+pub unsafe extern "C" fn rust_device_class_init<T: DeviceImpl>(
+    klass: *mut ObjectClass,
+    _: *mut c_void,
+) {
+    let mut dc = ::core::ptr::NonNull::new(klass.cast::<DeviceClass>()).unwrap();
+    unsafe {
+        let dc = dc.as_mut();
+        if let Some(realize_fn) = <T as DeviceImpl>::REALIZE {
+            dc.realize = Some(realize_fn);
+        }
+        if let Some(reset_fn) = <T as DeviceImpl>::RESET {
+            bindings::device_class_set_legacy_reset(dc, Some(reset_fn));
+        }
+        if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
+            dc.vmsd = vmsd;
+        }
+        bindings::device_class_set_props(dc, <T as DeviceImpl>::properties().as_ptr());
+    }
+}
 
 #[macro_export]
-macro_rules! device_class_init {
-    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
-        pub unsafe extern "C" fn $func(
-            klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::std::os::raw::c_void,
-        ) {
-            let mut dc =
-                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
-            unsafe {
-                dc.as_mut().realize = $realize_fn;
-                dc.as_mut().vmsd = &$vmsd;
-                $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
-                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_ptr());
-            }
+macro_rules! impl_device_class {
+    ($type:ty) => {
+        impl $crate::definitions::ClassInitImpl for $type {
+            const CLASS_INIT: Option<
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+            > = Some($crate::device_class::rust_device_class_init::<$type>);
+            const CLASS_BASE_INIT: Option<
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+            > = None;
         }
     };
 }
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index fd0c979121c..04bacb548a4 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -7,8 +7,9 @@
 use qemu_api::{
     bindings::*,
     c_str, declare_properties, define_property,
-    definitions::{ClassInitImpl, ObjectImpl},
-    device_class, device_class_init,
+    definitions::ObjectImpl,
+    device_class::{self, DeviceImpl},
+    impl_device_class,
     zeroable::Zeroable,
 };
 
@@ -45,28 +46,23 @@ pub struct DummyClass {
             ),
     }
 
-    device_class_init! {
-        dummy_class_init,
-        props => DUMMY_PROPERTIES,
-        realize_fn => None,
-        legacy_reset_fn => None,
-        vmsd => VMSTATE,
-    }
-
     impl ObjectImpl for DummyState {
         type Class = DummyClass;
         const TYPE_NAME: &'static CStr = c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
     }
 
-    impl ClassInitImpl for DummyState {
-        const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
-            Some(dummy_class_init);
-        const CLASS_BASE_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
-        > = None;
+    impl DeviceImpl for DummyState {
+        fn properties() -> &'static [Property] {
+            &DUMMY_PROPERTIES
+        }
+        fn vmsd() -> Option<&'static VMStateDescription> {
+            Some(&VMSTATE)
+        }
     }
 
+    impl_device_class!(DummyState);
+
     unsafe {
         module_call_init(module_init_type::MODULE_INIT_QOM);
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
-- 
2.47.0


