Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C73E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaS-0003uE-P1; Wed, 11 Dec 2024 11:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaL-0003Un-7v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaJ-0000gF-6b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctCAEWtPTR324riG8wYmwkDMgtVqvsSzl7tky+ffgCc=;
 b=ZmunXBmBibqayVuWtgRCbYcM8dypNdGtVuxVgs6356s73GbdKPvEqKlyl7El39cSuAsdks
 /J5EQBIL6bY7whcjRuuhfvxerKNam9JCxXdcL8gLAQ1YwUddiEQJcEnHIHwvCOpSAu3pxJ
 k3Cxet9RGQYd/0a9RGmgGuSLeNokY2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-Lra9O63JPWaV_ykoQnWuyA-1; Wed, 11 Dec 2024 11:29:08 -0500
X-MC-Unique: Lra9O63JPWaV_ykoQnWuyA-1
X-Mimecast-MFC-AGG-ID: Lra9O63JPWaV_ykoQnWuyA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434e8beee61so5295745e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934546; x=1734539346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctCAEWtPTR324riG8wYmwkDMgtVqvsSzl7tky+ffgCc=;
 b=IRpLO00Xo+iGyYqw7YCZzsZlxiQv1luPAolqK+Btq/gxwQEsTnHzcqJIWNBYpsCSWa
 RrxgLPqmMq3DoUbqOx0DNsGZVWmL3qW1V2yZISLsDDmQKyMzk1aSz2jMbThNrOAxDyTK
 vqE3j3LGG9VbsBtWKeXrUD3/y7Fx15ibD8JSKcuXaC5f9fkN8gCVOzzkfvE78JXV9RDt
 wi0WSv/xjtsRSsPhOML8CrcfaPtMBUdiZ+uHVybQ7afwypSb5qtUtgVqimvjeaRC3VJy
 DZuSiKFsxxKOnXikkbl19YbIQ0QK4jbeDuvp497dGJD498s3QBU/I6Ly5CASjOFcqyQy
 O27w==
X-Gm-Message-State: AOJu0YyX/msFvgnhpJ91lh4GCYVa4EWsBkichD48rcdA/s+Jn8Eun+/l
 4kgcZg/PpNdmH0wnxfbnHh0eDp5oDoDsQDQp6uzQXWtvMGY2nk/AnaJcPJhz1m4m6FFqispLpik
 L1eHLhPJP9Tbr1loR9wHVHiw9eFfQonklErJrk4GFs3KmRKp8gFOOL1k82NR9JXcA9oC8zAHmE/
 sMQlPvXNDpgv5Ajb3wcYELduxX0IeyFS7C5TDl
X-Gm-Gg: ASbGncssMPErOWG0BBbRvORwldTdKcx7iaalOa3AVhWf0lgOSFzrge6AL3Q8dSWYdto
 uVqILe7Zq16RmnoCjKxoLwUFStKIRl1jQvlBVzPn6wyAoDPd5WqzPY0r55QaD7FmLeJD8Hp4H98
 plmiBOo+utPhbk2YKvCtB5d2ilG8ePyaF60dtozVDk9ukampdhrUbOBr3TE0Uj5762L3AXGlTCd
 8OZXtY3UeZjJcESn2SEPkkgVq66Xc3NNOCNINGxvuE8JoN9fUKfwKVJ
X-Received: by 2002:a05:600c:68c9:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-4361c58f6f3mr23701135e9.2.1733934545873; 
 Wed, 11 Dec 2024 08:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbDh5yeFqL/pLxftKDaqJ5YYLxiOSmR5k05j8koV6KT4sMdI89jGxfosqxCBfEs6b2NRzn5Q==
X-Received: by 2002:a05:600c:68c9:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-4361c58f6f3mr23700955e9.2.1733934545421; 
 Wed, 11 Dec 2024 08:29:05 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-435aab63baesm53860845e9.38.2024.12.11.08.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 46/49] rust: qdev: move bridge for realize and reset functions
 out of pl011
Date: Wed, 11 Dec 2024 17:27:16 +0100
Message-ID: <20241211162720.320070-47-pbonzini@redhat.com>
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

Allow the DeviceImpl trait to expose safe Rust functions.
rust_device_class_init<> adds thunks around the functions
in DeviceImpl.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  5 ++--
 rust/hw/char/pl011/src/device_class.rs | 26 -------------------
 rust/qemu-api/src/definitions.rs       |  2 +-
 rust/qemu-api/src/device_class.rs      | 36 +++++++++++++++++++++-----
 4 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 28b1924337d..56403c36609 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -125,9 +125,8 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
-    const REALIZE: Option<unsafe extern "C" fn(*mut DeviceState, *mut *mut Error)> =
-        Some(device_class::pl011_realize);
-    const RESET: Option<unsafe extern "C" fn(*mut DeviceState)> = Some(device_class::pl011_reset);
+    const REALIZE: Option<fn(&mut Self)> = Some(Self::realize);
+    const RESET: Option<fn(&mut Self)> = Some(Self::reset);
 }
 
 impl_device_class!(PL011State);
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index c61b6bb0258..975c3d42be7 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -92,29 +92,3 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
         default = true
     ),
 }
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().realize();
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().reset();
-    }
-}
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 487712611f6..0467e6290e0 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -47,7 +47,7 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
 /// Each QOM type has one such class struct.
 ///
 /// The Rust implementation of methods will usually come from a trait
-/// like [`ObjectImpl`].
+/// like [`ObjectImpl`] or [`DeviceImpl`](crate::device_class::DeviceImpl).
 pub trait ClassInitImpl {
     /// Function that is called after all parent class initialization
     /// has occurred.  On entry, the virtual method pointers are set to
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index f683f94f2a5..f25904be4f6 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -17,14 +17,14 @@ pub trait DeviceImpl {
     ///
     /// If not `None`, the parent class's `realize` method is overridden
     /// with the function pointed to by `REALIZE`.
-    const REALIZE: Option<unsafe extern "C" fn(*mut DeviceState, *mut *mut Error)> = None;
+    const REALIZE: Option<fn(&mut Self)> = None;
 
     /// If not `None`, the parent class's `reset` method is overridden
     /// with the function pointed to by `RESET`.
     ///
     /// Rust does not yet support the three-phase reset protocol; this is
     /// usually okay for leaf classes.
-    const RESET: Option<unsafe extern "C" fn(dev: *mut DeviceState)> = None;
+    const RESET: Option<fn(&mut Self)> = None;
 
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
@@ -41,6 +41,30 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     }
 }
 
+/// # Safety
+///
+/// This function is only called through the QOM machinery and
+/// the `impl_device_class!` macro.
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(dev: *mut DeviceState, _errp: *mut *mut Error) {
+    assert!(!dev.is_null());
+    let state = dev.cast::<T>();
+    T::REALIZE.unwrap()(unsafe { &mut *state });
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_reset_fn<T: DeviceImpl>(dev: *mut DeviceState) {
+    assert!(!dev.is_null());
+    let state = dev.cast::<T>();
+    T::RESET.unwrap()(unsafe { &mut *state });
+}
+
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer that
@@ -53,11 +77,11 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     let mut dc = ::core::ptr::NonNull::new(klass.cast::<DeviceClass>()).unwrap();
     unsafe {
         let dc = dc.as_mut();
-        if let Some(realize_fn) = <T as DeviceImpl>::REALIZE {
-            dc.realize = Some(realize_fn);
+        if <T as DeviceImpl>::REALIZE.is_some() {
+            dc.realize = Some(rust_realize_fn::<T>);
         }
-        if let Some(reset_fn) = <T as DeviceImpl>::RESET {
-            bindings::device_class_set_legacy_reset(dc, Some(reset_fn));
+        if <T as DeviceImpl>::RESET.is_some() {
+            bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
         }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             dc.vmsd = vmsd;
-- 
2.47.1


