Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36307E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaO-0003gO-VY; Wed, 11 Dec 2024 11:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaI-0003Ng-RX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaG-0000ff-Qw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sU9LjfrSS+1trzy9agSXX/YTJPU2Nn1jBVlPhNEmW34=;
 b=J53gqNVuVpSg48WUJSo144KRQSimO0fV0m98AAG6970grwQf5I/EQVsWE1IwkBxmy5uW19
 cByr/dT6pYIO8Tb1ytvj41LBeRbMeipHFejVktB3Ag5wt0Sxpfe5aJZpz0Y7z2XMkxDbW6
 iNKC270bmfQAdNMgD97+jPc/Ee/xvqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-_t8prK4LMGSLo2zzRL5ekw-1; Wed, 11 Dec 2024 11:29:07 -0500
X-MC-Unique: _t8prK4LMGSLo2zzRL5ekw-1
X-Mimecast-MFC-AGG-ID: _t8prK4LMGSLo2zzRL5ekw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so3866879f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934546; x=1734539346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sU9LjfrSS+1trzy9agSXX/YTJPU2Nn1jBVlPhNEmW34=;
 b=nDTazvL2njUm+qjxOOC8gE7M75sJwjAotqfJrJ6AtnNtoJYQ5w6N+5YXMjB52skexY
 376j1A0aBwat5LAwzppJL7pTm+aJOnohveAfAiDjC8tLp1nG5kbt5XxBds7XtgC8Z8Vw
 GgguLFgeh2Yt7Z3TBnw0BfdLGE7fD8abqjdHUcvK33CiGhwztR/JZFQXVtMXRaPBShAH
 UBEVb4NptN8TgDJSIvGL/w6YQEPXSCUcfT92mqqwofdGjfZyMHycGTg9w4UaPR4UTU1G
 84zTRHz7N2JF963OfeUtlGpirdzDb3y8vIWUP3X7iLxKWlN8sjcowoyuzG25kOFJIqN4
 /jRg==
X-Gm-Message-State: AOJu0YzJvOXaRXT+5A11FnPADJ3++KbEgOuGlXC7B3mk5yURxDm1vMzb
 0tquXvozdOHLrKVP/p7V3J77G5XJ+zCkrH5yrc942jD+NeoMnK3H1jxqz+JRoJmcnoAdI1w56Mt
 YJhEuQiceIdqnWhQ2/4PTM9rvCOdp0sDGieV3TEyIZR1R/n8PJnPIyX48U5kj7dqksqkssHNnkg
 qITU6uTCfxN/sqz5+IussbOg1W6BI2T0bQMQqW
X-Gm-Gg: ASbGncukmuW85YIWk2owsSKhSTDHIno7jFTXmeeBxlmUI6Yi5fcJFacTGUE+Ed67VuR
 ZnZMr8ylGZBAprgje3QnHvyIFzetJeslewdgS4GyKaxNqS54vMT1s5M6s29Tvza72A5VDd7DL/P
 4CcqUqVRVFgeIvUZHL88yrZRxfLdEy5g4lepfallxFfXEqOLG4g21o0rrWCQIBn++xYSc90olkE
 XxLwbbA1TBoCvxVR9PgIxMESLMn0dabuo2VZKD+5gX2NfGFsftceh2e
X-Received: by 2002:a05:6000:1541:b0:385:fc70:826 with SMTP id
 ffacd0b85a97d-387876c3782mr161980f8f.52.1733934544172; 
 Wed, 11 Dec 2024 08:29:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjqF7S7VouQo98MvQ/qm7NjZ0q6KaY1Z/d3XaUyd658vx1cPqT+V+fs7gq/nRx+Rd6SrhWLQ==
X-Received: by 2002:a05:6000:1541:b0:385:fc70:826 with SMTP id
 ffacd0b85a97d-387876c3782mr161974f8f.52.1733934543640; 
 Wed, 11 Dec 2024 08:29:03 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251bc16sm1639553f8f.86.2024.12.11.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 45/49] rust: qdev: move device_class_init! body to generic
 function, ClassInitImpl implementation to macro
Date: Wed, 11 Dec 2024 17:27:15 +0100
Message-ID: <20241211162720.320070-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Use a trait to access the former parameters to device_class_init!.
This allows hiding the details of the class_init implementation behind
a generic function and makes higher-level functionality available from
qemu_api.

The implementation of ClassInitImpl is then the same for all devices and
is easily macroized.  Later on, we can remove the need to implement
ClassInitImpl by hand for all device types, and stop making
rust_device_class_init<>() public.

While at it, document the members of DeviceImpl.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 34 +++++-----
 rust/hw/char/pl011/src/device_class.rs |  8 ---
 rust/qemu-api/src/device_class.rs      | 87 +++++++++++++++++++++-----
 rust/qemu-api/tests/tests.rs           | 30 ++++-----
 4 files changed, 103 insertions(+), 56 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2384d4bcb95..28b1924337d 100644
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
index 922bbce1bb8..f683f94f2a5 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,25 +2,80 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings;
+use crate::{
+    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    zeroable::Zeroable,
+};
+
+/// Trait providing the contents of [`DeviceClass`].
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
+        &[Zeroable::ZERO; 1]
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
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut ::std::os::raw::c_void),
+            > = Some($crate::device_class::rust_device_class_init::<$type>);
+            const CLASS_BASE_INIT: Option<
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut ::std::os::raw::c_void),
+            > = None;
         }
     };
 }
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index fd0c979121c..b8b12a40422 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,13 +2,14 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, os::raw::c_void};
+use std::ffi::CStr;
 
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
2.47.1


