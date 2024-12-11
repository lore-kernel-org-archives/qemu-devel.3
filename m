Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD169E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaQ-0003nX-Nl; Wed, 11 Dec 2024 11:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaM-0003a1-Ox
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaK-0000hi-Lg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QBVWKJK/+NNxfBQypJGp9jx0dxljKYnV/yzXgDBlBg=;
 b=BQu6IjlijW/FX1vaJimyN1xJsEEs0+yeerlSaZwsdFbtMYufgm1ftEyOVtq680gKxDy70Q
 Ee3XdqWf5wH3xqwSwW8n6XWCeXSFmKudnkp/JOFanhEhuJac3+V1aEd2EQUxJpIRRibJ2b
 Zz7br6Wf0MuuiRfDrmpc+RA9Krs9Sf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-GT7O1lEBOjG7EmPlLKyQ_w-1; Wed, 11 Dec 2024 11:29:10 -0500
X-MC-Unique: GT7O1lEBOjG7EmPlLKyQ_w-1
X-Mimecast-MFC-AGG-ID: GT7O1lEBOjG7EmPlLKyQ_w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434f3398326so4673915e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934549; x=1734539349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QBVWKJK/+NNxfBQypJGp9jx0dxljKYnV/yzXgDBlBg=;
 b=qkmsonS35heVDNMLoEtO0VxfKhNVu6TA0LL1RGY1Eqy7oUgqcrgUqinjznVz4VUTtF
 6ycmPGBubiEmUZB59lemfdFdB9158N/ghZt0Bf/ygGeUixGCcNPZvQYvdbgprZQLfadt
 Q0SlEE2+Yw7u6qdb0aHYOUkx1HSDkQTP3Rq05NYhkrTGeVzT8Yh/TEHSLq6Wqz0LLBwR
 zlABvEL2TLkrULgwit49oefnSk/PJDcbK+Qe9Y3K65JW2LAmkH4zxgJBLyfDLpZRF9iE
 puBofciP6+w0pTCtDLpnH8qYTzTnqTJ5aje89bIUsQpDyVfAfO5fg1ZCmFcZcZg+RQq7
 QnQg==
X-Gm-Message-State: AOJu0YwEXdrtOFNbRKlHapdke9Wr+KqjJ1XqjPlbgxr5sCmwycwL++Pe
 v4j15D7yXcHTjtxp+uQ4SfSxnK48TiLjd9sUqBSDg/CiFlOj+hfuPVe076XuvQUTVuDOqh2gHFt
 8TaVqxThXKwWsVVcjJ5uYc2xz5LOtThi7nBrY8/u4fQ4RjMc/8sf99Czx0SzDeRaAxHLQQT69EY
 H0Y0yRwp5uTxJ+PAY1C3o2lDR8knZJ43OqFaT8
X-Gm-Gg: ASbGncun/+6nfWvP4f6OLRbLSoFe42VahUcmZEypiaj4AKeCwHCdVY9A626DzPFMMxo
 6KCZnSXKYVXn5lxxBzY/75xtAgQaQoH/b5Obzjnw7XWt5EQUbVFNo9jEewywAg1kRowVMjYcIvG
 Be9o7qXt9GM14+sGKYYvTKrX9Yp/qTVXMDADli5teqY59691QJXoPEEkibWxoni7esOrCI6LLe+
 Wx/BsW4ibslMpQht4MybJvY8yipQWVdnZA1CyLEF7kQ97tgGjt28CiK
X-Received: by 2002:a05:600c:4896:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-4361c49e385mr23250185e9.0.1733934548968; 
 Wed, 11 Dec 2024 08:29:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/0FUuNXzvBFFDMbZiq4wYyOi0MyEdKbETCvqLZuXfqA+lUBuGNdTvOa3FP0wZjltXKn9mLw==
X-Received: by 2002:a05:600c:4896:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-4361c49e385mr23250035e9.0.1733934548451; 
 Wed, 11 Dec 2024 08:29:08 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f43aedb2sm128912535e9.41.2024.12.11.08.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:29:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 47/49] rust: qom: move bridge for TypeInfo functions out of
 pl011
Date: Wed, 11 Dec 2024 17:27:17 +0100
Message-ID: <20241211162720.320070-48-pbonzini@redhat.com>
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

Allow the ObjectImpl trait to expose Rust functions that avoid raw
pointers (though INSTANCE_INIT for example is still unsafe).
ObjectImpl::TYPE_INFO adds thunks around the functions in
ObjectImpl.

While at it, document `TypeInfo`.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
index 0467e6290e0..f2970758986 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -8,16 +8,63 @@
 
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
     const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 
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
+
     const TYPE_INFO: TypeInfo = TypeInfo {
         name: Self::TYPE_NAME.as_ptr(),
         parent: if let Some(pname) = Self::PARENT_TYPE_NAME {
@@ -27,8 +74,14 @@ pub trait ObjectImpl: ClassInitImpl + Sized {
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
         instance_finalize: Self::INSTANCE_FINALIZE,
         abstract_: Self::ABSTRACT,
         class_size: core::mem::size_of::<Self::Class>(),
-- 
2.47.1


