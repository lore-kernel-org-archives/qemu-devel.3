Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371CE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd3G-0005sJ-7X; Mon, 09 Dec 2024 07:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1Y-00041y-17
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1T-0007UD-Oi
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTYy1Da2MVUyx5e12TuwendQ6h8bg1WbLVoDyiNBJFQ=;
 b=V9Q1YD3g6rwHH1FWMl/KxKxaU4FGzSMKSWBewK/147Ld0Y2nOavgHs9uGZKwStxmPbZRuu
 6jigdSJ1RSerJQ8qxaeJ0vEkwGx6uHki7735oMWy7004njrv9OMzCf6k+Zc2q9I1THgMqh
 6TDdiLqpk/dEykoKZi1dy+UPoFi8G0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-yJySlSPtMR66Y_TnshMa5Q-1; Mon, 09 Dec 2024 07:37:56 -0500
X-MC-Unique: yJySlSPtMR66Y_TnshMa5Q-1
X-Mimecast-MFC-AGG-ID: yJySlSPtMR66Y_TnshMa5Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434f112d83aso13047535e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747875; x=1734352675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTYy1Da2MVUyx5e12TuwendQ6h8bg1WbLVoDyiNBJFQ=;
 b=PaFhE21ASMLUrG5rnuI/Q9X/SlcEofpBWPERjj4rf4k+XkYCSmnE21T43hBiY/ADkD
 +eN2IQy4hdxD1qzpl8unr9YKzEyfu6a5MsKRl0BwQsvtEl0M2vxlG5RVbdbsnSfbXkDB
 GC8E7hjy46eX0ZLqCxSK2KYWR7TDhK5plZQVEj1sZMqkQx8ADl72PqjO69i6OW0mnCs7
 rIN5VvYzyUi7Q0i1WHNJyUp7GnjWTX2WKotb7BqgUrBNPe/SqGf5WAi0HA/rKM8qpLMC
 KnaoEYaDXqHOpN7Ld0GaO57RQ3Lz/Q4xkwCHWk0pTME3GYq1k1DJEtDQtfOFdwpsb8j7
 q49g==
X-Gm-Message-State: AOJu0Yy3tslaumC7HcdRpLerP4Ot5QPswzxq2yJWj0HC/T4XqX8uFw19
 kz4UDjl59M93psAcHFde9Pms75zQzQQgCRt/DHzX1HPI7bjKY/g9s7L3nxWnjFV2gjodJJ2qAmU
 QBwSvYztkV6itubJHE6GbL9sjEsW8gOiioFjcOARuQdq+goqF40IQ3RYZWMhHuNQOlrF/I3P6PQ
 vqHeRLwjK/pJmL69PRQ5C2xX+INU3abVZQVC7R
X-Gm-Gg: ASbGnctr8X82/l2geUt7bJsMrxYG1UJxBwkToRiQs5dRwo6aXzB4VSnQR2byVWWN4jW
 YBtOeKKqOCXOIbCIWXvD38eN+f28IHcPfaS60nszq6zDvwQE36jEx+gTIlLhlTI60SaRt+eXZoI
 LAevbx+Hh/haoN6b5OIv/KIrNqWOOj1fdYGJuHhflp/0HBROyY1aMLfvk1FM2+BSHcc/DyHJgAi
 PrgFDB7H6rTGZiqk9rv/EFYiTWZtL5hmE/mTS3+pHq2V0WWo+R21Q==
X-Received: by 2002:a05:600c:34c4:b0:434:feb1:adbb with SMTP id
 5b1f17b1804b1-434feb1b243mr10131935e9.31.1733747874617; 
 Mon, 09 Dec 2024 04:37:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwu/ZgjtodbmY64bjy8c55kmq1254rX8DfOYm502NBkpVP7V98xEWbRE5TfNt/ZYFiMhTvCA==
X-Received: by 2002:a05:600c:34c4:b0:434:feb1:adbb with SMTP id
 5b1f17b1804b1-434feb1b243mr10131655e9.31.1733747874157; 
 Mon, 09 Dec 2024 04:37:54 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434fe9bff74sm8411475e9.8.2024.12.09.04.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out of
 pl011
Date: Mon,  9 Dec 2024 13:37:05 +0100
Message-ID: <20241209123717.99077-15-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow the ObjectImpl trait to expose Rust functions that avoid raw
pointers (though INSTANCE_INIT for example is still unsafe).
ObjectImpl::TYPE_INFO adds thunks around the functions in
ObjectImpl.

While at it, document `TypeInfo`.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 40 +++++++--------------
 rust/qemu-api/src/definitions.rs | 61 +++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 56403c36609..b9f8fb134b5 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -110,7 +110,7 @@ impl ObjectImpl for PL011State {
     type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
 #[repr(C)]
@@ -615,19 +615,6 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
     }
 }
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
-        state.as_mut().init();
-    }
-}
-
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object)]
 /// PL011 Luminary device model.
@@ -640,19 +627,16 @@ pub struct PL011LuminaryClass {
     _inner: [u8; 0],
 }
 
-/// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
-///
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011Luminary`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_luminary_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011Luminary>());
-        let state = state.as_mut();
-        state.parent_obj.device_id = DeviceId::Luminary;
+impl PL011Luminary {
+    /// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
+    ///
+    /// # Safety
+    ///
+    /// We expect the FFI user of this function to pass a valid pointer, that
+    /// has the same size as [`PL011Luminary`]. We also expect the device is
+    /// readable/writeable from one thread at any time.
+    unsafe fn init(&mut self) {
+        self.parent_obj.device_id = DeviceId::Luminary;
     }
 }
 
@@ -660,7 +644,7 @@ impl ObjectImpl for PL011Luminary {
     type Class = PL011LuminaryClass;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
 impl DeviceImpl for PL011Luminary {}
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index d64a581a5cc..078ba30d61a 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -8,6 +8,24 @@
 
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
+unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since rust_instance_init<T>
+    // is called from QOM core as the instance_init function
+    // for class T
+    unsafe { T::INSTANCE_INIT.unwrap()(&mut *obj.cast::<T>()) }
+}
+
+unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut Object) {
+    // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
+    // is called from QOM core as the instance_post_init function
+    // for class T
+    //
+    // FIXME: it's not really guaranteed that there are no backpointers to
+    // obj; it's quite possible that they have been created by instance_init().
+    // The receiver should be &self, not &mut self.
+    T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
+}
+
 unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since drop_object<T>
     // is called from QOM core as the instance_finalize function
@@ -16,13 +34,42 @@
 }
 
 /// Trait a type must implement to be registered with QEMU.
+///
+/// # Safety
+///
+/// - the struct must be `#[repr(C)]`
+///
+/// - `Class` and `TYPE` must match the data in the `TypeInfo` (this is
+///   automatic if the class is defined via `ObjectImpl`).
+///
+/// - the first field of the struct must be of the instance struct corresponding
+///   to the superclass declared as `PARENT_TYPE_NAME`
 pub trait ObjectImpl: ClassInitImpl + Sized {
+    /// The QOM class object corresponding to this struct.  Not used yet.
     type Class;
+
+    /// The name of the type, which can be passed to `object_new()` to
+    /// generate an instance of this type.
     const TYPE_NAME: &'static CStr;
+
+    /// The parent of the type.  This should match the first field of
+    /// the struct that implements `ObjectImpl`:
     const PARENT_TYPE_NAME: Option<&'static CStr>;
+
+    /// Whether the object can be instantiated
     const ABSTRACT: bool = false;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+
+    /// Function that is called to initialize an object.  The parent class will
+    /// have already been initialized so the type is only responsible for
+    /// initializing its own members.
+    ///
+    /// FIXME: The argument is not really a valid reference. `&mut
+    /// MaybeUninit<Self>` would be a better description.
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = None;
+
+    /// Function that is called to finish initialization of an object, once
+    /// `INSTANCE_INIT` functions have been called.
+    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
@@ -33,8 +80,14 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
         },
         instance_size: core::mem::size_of::<Self>(),
         instance_align: core::mem::align_of::<Self>(),
-        instance_init: Self::INSTANCE_INIT,
-        instance_post_init: Self::INSTANCE_POST_INIT,
+        instance_init: match Self::INSTANCE_INIT {
+            None => None,
+            Some(_) => Some(rust_instance_init::<Self>),
+        },
+        instance_post_init: match Self::INSTANCE_POST_INIT {
+            None => None,
+            Some(_) => Some(rust_instance_post_init::<Self>),
+        },
         instance_finalize: Some(drop_object::<Self>),
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
-- 
2.47.1


