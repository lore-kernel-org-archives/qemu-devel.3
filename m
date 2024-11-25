Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F97D3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6K-0004sA-HW; Mon, 25 Nov 2024 03:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU6A-0004pl-Vv
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU67-0007KH-08
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EIU9yq9+mkYvQn7U+sZDRaPopWMU6lMkqtmBrfvhkY=;
 b=MZHcW+BUSbiqltWzCxWkBlmUnnRi4GwtujGw2gPV2/Ubb06ZFBkYnkgeS8P8HZMwrEiByd
 leYmVtnZczjq57M4ZiRlZNFFh3dognJAAjmMViqB8S0cODU2i0EhfoWiNvV7lI/ZMlWGcT
 YpfHDtdCcvCWGkwqvLWL9yd2G9va5qM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-fb-cHsiYMWSkpW4cgROLdQ-1; Mon, 25 Nov 2024 03:05:28 -0500
X-MC-Unique: fb-cHsiYMWSkpW4cgROLdQ-1
X-Mimecast-MFC-AGG-ID: fb-cHsiYMWSkpW4cgROLdQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3823326e95aso2204344f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521926; x=1733126726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EIU9yq9+mkYvQn7U+sZDRaPopWMU6lMkqtmBrfvhkY=;
 b=oEL/qtHRwFc8G61j733kRuh/nmxP4iSysIl46TULkQQ8w63xzNvEPn/fro++6G5JC3
 raZXed5KW+6vVGnNdaxlGwrlVdx8vsRARIsmssICtVfW+Ml0D0g/wqMjGfdDPZatOz+w
 lpHnG3LcDb0mFO65k7PzTTclbp/dHGsXKS7oqRhNsUCRTOZgDii2dE2ibHYW9ts8sXBD
 KM4/eNGZuNJTEgTWexhfvymJAPE5CDvTasPk+JXH9PXsuy72Ev+uCMUrjLm8r3GXtNE6
 lIi+W3FRQjgln6357+HxAfp/CU+O42XKWZdFHvROnD13HwUdLoCoaYvHlCxNz89SCzTi
 m6Mw==
X-Gm-Message-State: AOJu0YziitmKsQBmjkZwYcnrpwNboOflXmq47+/fe/+KTgpfPmkmT9b6
 uATZCeyfxCzw+dtHcJW+7J7acKOpQ4gcz+nrnMtCFYJTY7Q0s9SxRFcuOEndj18AURth//lilkz
 X487o86c6YeqAkxBgIAGC6eJk5Ajm632vuWJuv2gdY9plbVYCIhAa5CR0DPVx7pSS7Rfi5Cxksa
 CA9qQDRy4pEYl0Oba5/fs7iLrlSA3W6Q9u+As2
X-Gm-Gg: ASbGnctalryBaFWhEWX0d28PzcfkgC8sone7ph1nb8PXNpdOoqrcghymoob43rWNack
 IIIT2jL3erClhrpy4UBCtTahh/qId7VG08f4t94B7EQrrHQCZH+hzEbWEj1xb12zJTq7ug3ocHV
 3kQkUF+YzLuQ4keZ1Bsz3frUJSsB8h1ZYzmQifV5lCijBRtTVY1/SeciFCj7+2cuyUB61BN9JMO
 sMJMCVTMrUEkq3s1HdeZscUsK//zjdJ8gb6iVfmrihEE+IPWuWCsKA=
X-Received: by 2002:adf:e18c:0:b0:382:2d59:b166 with SMTP id
 ffacd0b85a97d-38260b83dfbmr9389367f8f.31.1732521926503; 
 Mon, 25 Nov 2024 00:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBhdvQKS16rJzpik1QM1H18fPFVJE8xEiLUlgfFi5zKMN2UAE6CYEr2gorK3eR1XCRns4tYA==
X-Received: by 2002:adf:e18c:0:b0:382:2d59:b166 with SMTP id
 ffacd0b85a97d-38260b83dfbmr9389341f8f.31.1732521926073; 
 Mon, 25 Nov 2024 00:05:26 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9be8sm9641677f8f.24.2024.11.25.00.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 6/8] rust: qdev: move bridge for realize and reset functions
 out of pl011
Date: Mon, 25 Nov 2024 09:05:05 +0100
Message-ID: <20241125080507.115450-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  5 ++--
 rust/hw/char/pl011/src/device_class.rs | 26 ----------------
 rust/qemu-api/src/definitions.rs       |  2 +-
 rust/qemu-api/src/device_class.rs      | 41 ++++++++++++++++++++++----
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 1906b9022bd..aeccce5186c 100644
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
index 72cea345f87..385f0b7a09e 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -8,6 +8,7 @@
     self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription,
 };
 
+/// Trait providing the contents of [`DeviceClass`].
 pub trait DeviceImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
@@ -15,14 +16,14 @@ pub trait DeviceImpl {
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
@@ -39,6 +40,30 @@ fn vmsd() -> Option<&'static VMStateDescription> {
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
@@ -51,11 +80,11 @@ fn vmsd() -> Option<&'static VMStateDescription> {
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
2.47.0


