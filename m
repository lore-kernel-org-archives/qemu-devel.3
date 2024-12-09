Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F0BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd41-0006AI-RH; Mon, 09 Dec 2024 07:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1U-00040L-T4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1N-0007Sm-HR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2XjECiQ3aF3ccKlQ+UfpX2Co0fO2a2DC8TPDve57ok=;
 b=H9m1vDyYUEtqLUXB9SVyKbkliRvwnxndbRUdmZRsERqV1dkvzaWFs3Mt140QOX8Uk8Am65
 QKzdhKHCxH7qWBc87pymXoPUWg2NRTgGx1skuwdgl5lOVvCjY/wsXw4Ks0K+v/NmIJ4Qd/
 VXjjFR1wsAgX7GZ2ZeKlYQYkn8nnmWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-EhQXVIm6PzWkeJjUBnWreQ-1; Mon, 09 Dec 2024 07:37:51 -0500
X-MC-Unique: EhQXVIm6PzWkeJjUBnWreQ-1
X-Mimecast-MFC-AGG-ID: EhQXVIm6PzWkeJjUBnWreQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso1658533f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747869; x=1734352669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2XjECiQ3aF3ccKlQ+UfpX2Co0fO2a2DC8TPDve57ok=;
 b=YhKAJOMzKTBxTn0NrwPdAkWt986JK+3pX0k3VRA3mzjFwwF6sBnU1nhi1975QJZvtQ
 m2Q88oRMH8P4jnHEEJ/snis2vFXxavgaQcU3sw0WZkahwoT4/2YixHNuFAjyd1QoPjL+
 Rcx/3FD3Wq/o5ZEQ7QFwb6GviYESJZZORc+DEaqAdtcAJDM23fs8vzlhqqVLBUS2odXz
 R1H2GyDPWAh+ImDGrNqHqaccNay0S9cpWBRlXAU2Xsc7oHd5HqWp2bts5AYauC1jCmYz
 JShdD3vI0/id1bysoCJI6hr59e8c/SPL38LWvWrhJyR+sWzbXn5bQpmdf3SJXg0E+jYO
 WHfQ==
X-Gm-Message-State: AOJu0YyRB2/BHWEf10dBTnZWn2xlUBUT38KiZANq2op04S6NUNQh4E9x
 XzJU4r2vdEGicuzw5p6GGWzkw5//OxaSwOVXoZVLix2pPeWEybZr4NyWYCtemSJ5DE5lS8OrEr6
 snn6kuhM4rzs8Rf9vJLS7g6ZacNaLihFP0tq25sALefLNwZG21Skm16eSrOFolWjMQabBXQKdWd
 IIuZoBfeYmTOa+S9V7b5gRJTf9SMWo/tO/YBnm
X-Gm-Gg: ASbGncujPQSyQvcz/M0IItLM8Y+Co/kVyU3AFknvwgavQzzBn13P7aFlhmePIeiZnkL
 1I7k1g8PmvtoNdPES78bTFLMJVv5ZYxubGPTT74z0OfJ08SUOokb7Xq5/dnnuTaz7psfE7RC5qH
 16Tn+BEWOZwpqoETA/e+gAwq2aydNybd3LsfvoI8Sq6dwtM8JOTmdHEo8jw82dF+w3XMwhZuZnZ
 FthJpDPT2Yqusriv35mkdQJTkxctsrMFgpGRiG8EJh1+EQ2Z0e9Rw==
X-Received: by 2002:a5d:5989:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-386453f67d0mr134689f8f.36.1733747869390; 
 Mon, 09 Dec 2024 04:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1jEk838B0P5aDCFXoIWlGcKXrjWlDpoOWk27luUi4kdcFBTVRh3sHrmTSDuTICl5fi5QAbA==
X-Received: by 2002:a5d:5989:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-386453f67d0mr134658f8f.36.1733747868914; 
 Mon, 09 Dec 2024 04:37:48 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3863157fb80sm8857813f8f.19.2024.12.09.04.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 12/26] rust: qdev: move bridge for realize and reset functions
 out of pl011
Date: Mon,  9 Dec 2024 13:37:03 +0100
Message-ID: <20241209123717.99077-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Allow the DeviceImpl trait to expose safe Rust functions.
rust_device_class_init<> adds thunks around the functions
in DeviceImpl.

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


