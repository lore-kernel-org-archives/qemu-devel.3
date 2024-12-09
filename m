Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02479E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd7G-0000Xl-UG; Mon, 09 Dec 2024 07:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd2h-0004u0-UH
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:39:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd2f-0007l3-RN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQvprRtOhbO0tTAhGCjhk7/MAt2yyWFqpYjv7MQU8PQ=;
 b=A103eHvk8p3TOcsxM55Amz/m9+oIUTNs0umFJT/R7td50vOZdi75q02XV0EChYCUupU14c
 X0vdMhGS81+byFsOiVheEuBj8pxdSet43mQ//s1RYZtoYw+vgFWmqJ2T4NwAtzpe6XZDBs
 came6yJnoagHGq1BUd0YoNdcoR7Suek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-DBsfOBzgMYuc_CTdoHEtlw-1; Mon, 09 Dec 2024 07:38:05 -0500
X-MC-Unique: DBsfOBzgMYuc_CTdoHEtlw-1
X-Mimecast-MFC-AGG-ID: DBsfOBzgMYuc_CTdoHEtlw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f3a758dbso9978515e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747884; x=1734352684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQvprRtOhbO0tTAhGCjhk7/MAt2yyWFqpYjv7MQU8PQ=;
 b=U0P+n6JlI8mHJLNSYyErMY0+wSLWj26+V4YXx3cOgoS/Iby+5Ds+HBcZQzm8wy+oGb
 w9HWdFPqLDdAZRF2XDG3jm4vbCUc/NUSuGDYGC6hv7CjsW3ZgCrX5zidLNzeLPvrG0OA
 8ft7pIt4c5FOfCKVbOecOlbxs+JoYU4Ybg5oUNZ6AZavEy1vcaGQgq27X1C779GLj9wT
 FplAYqYqqxj5d8ZH+RqX2xXv7kQKJS8FekEhifnGivIEFKRv6tFpfS8z8eAal1DZPhGM
 a+bFzBFMrAc05mAuV6H0c+PiZfwVPdAffgcVFWTKlnbpxvaneFYtH+YUw373vyfYGe64
 9E5g==
X-Gm-Message-State: AOJu0YxGfOng0dulCtL1c1Jr+eyAThwMn/bd7pKEmGCNRPJJ9BoiBmzX
 1ooPEtokkhUzsTo3K86MUzdUh502NuiuY8rxZxdu7TN7anpAHL6GEbyBU59P7Vm9eUzUWdASN88
 MhooOehsNdB026CuYml/Kmq7ZwQpmanqVNf7SnHlFL4S6QjX2ZXtWfrYHconLux9yY516RmAvmC
 vYymMCCjUYj46FRw5UgbHZ5AylTgIwxyqZTXyH
X-Gm-Gg: ASbGncvqH9D6yBOxtM0IsA0rllITGKZhKWQttAWvKYEulDGe08BoBlAJp9A1VtVWVji
 W8IpVRFYelSN0NvnYKki5ImdpVTQpi/izj5arAUU1unC5EMCa3uThIGCnncvB/uFyYX1Xk27urX
 I1zjPtt8LpXN7syd46+mcSX698nXDIHBqN0UJpCzIoqC44b44QgKlgx9xq/F/tJzSi45LUHQZVW
 +2uAEFl/fgHGxO7i052sS4EyvwkPxdTvo/WbqJYIk9TVW+FqiSWZw==
X-Received: by 2002:a05:600c:4f0d:b0:434:f0ab:42f with SMTP id
 5b1f17b1804b1-434fff9c4bfmr2869905e9.20.1733747883727; 
 Mon, 09 Dec 2024 04:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH55kiSw1XmRwkB3SlPJ0tg4JF7UgX1BMHGNFvQ8Jlk8je4ljZuKXqY9kQUzOVhz9TJZAW5uA==
X-Received: by 2002:a05:600c:4f0d:b0:434:f0ab:42f with SMTP id
 5b1f17b1804b1-434fff9c4bfmr2869675e9.20.1733747883265; 
 Mon, 09 Dec 2024 04:38:03 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f123da83sm71056725e9.29.2024.12.09.04.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 18/26] rust: qom: add possibility of overriding unparent
Date: Mon,  9 Dec 2024 13:37:09 +0100
Message-ID: <20241209123717.99077-19-pbonzini@redhat.com>
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

Add a blanket definition of ClassInitImpl<ObjectClass> that thunks
ObjectImpl::UNPARENT and overrides it in ObjectClass if it is not
None.

ClassInitImpl<DeviceClass> can now call its superclass's ClassInitImpl,
so that the C and Rust hierarchies match more closely.

This is mostly done as an example of implementing the metaclass
hierarchy under ClassInitImpl.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/definitions.rs  | 44 ++++++++++++++++++++++++++++---
 rust/qemu-api/src/device_class.rs |  6 +++--
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 2429b9f53f0..958ea34decc 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -6,7 +6,7 @@
 
 use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings::{Object, ObjectClass, TypeInfo};
+use crate::bindings::{self, Object, ObjectClass, TypeInfo};
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
@@ -115,6 +115,9 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
         class_data: core::ptr::null_mut(),
         interfaces: core::ptr::null_mut(),
     };
+
+    // methods on ObjectClass
+    const UNPARENT: Option<fn(&mut Self)> = None;
 }
 
 /// Internal trait used to automatically fill in a class struct.
@@ -128,7 +131,8 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// Each struct will implement this trait with `T` equal to each
 /// superclass.  For example, a device should implement at least
-/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>`.
+/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>` and
+/// `ClassInitImpl<`[`ObjectClass`](crate::bindings::ObjectClass)`>`.
 ///
 /// Fortunately, this is almost never necessary.  Instead, the Rust
 /// implementation of methods will usually come from a trait like
@@ -139,9 +143,13 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 /// ```ignore
 /// impl<T> ClassInitImpl<DeviceClass> for T
 /// where
-///     T: DeviceImpl,
+///     T: ClassInitImpl<ObjectClass> + DeviceImpl,
 /// ```
 ///
+/// The bound on `ClassInitImpl<ObjectClass>` is needed so that,
+/// after initializing the `DeviceClass` part of the class struct,
+/// the parent [`ObjectClass`] is initialized as well.
+///
 /// The only case in which a manual implementation of the trait is needed
 /// is for interfaces (note that there is no Rust example yet for using
 /// interfaces).  In this case, unlike the C case, the Rust class _has_
@@ -203,3 +211,33 @@ extern "C" fn ctor_fn() {
         }
     };
 }
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut Object) {
+    unsafe {
+        assert!(!dev.is_null());
+        let mut state = core::ptr::NonNull::new_unchecked(dev.cast::<T>());
+        T::UNPARENT.unwrap()(state.as_mut());
+    }
+}
+
+impl<T> ClassInitImpl<ObjectClass> for T
+where
+    T: ObjectImpl,
+{
+    fn class_init(oc: &mut ObjectClass) {
+        if <T as ObjectImpl>::UNPARENT.is_some() {
+            oc.unparent = Some(rust_unparent_fn::<T>);
+        }
+    }
+}
+
+unsafe impl ObjectType for Object {
+    type Class = ObjectClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
+}
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index ee9ae7eeb74..285dfe582c7 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -5,7 +5,7 @@
 use std::ffi::CStr;
 
 use crate::{
-    bindings::{self, DeviceClass, DeviceState, Error, Property, VMStateDescription},
+    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
     definitions::ClassInitImpl,
     prelude::*,
     zeroable::Zeroable,
@@ -69,7 +69,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 
 impl<T> ClassInitImpl<DeviceClass> for T
 where
-    T: DeviceImpl,
+    T: ClassInitImpl<ObjectClass> + DeviceImpl,
 {
     fn class_init(dc: &mut DeviceClass) {
         if <T as DeviceImpl>::REALIZE.is_some() {
@@ -86,6 +86,8 @@ fn class_init(dc: &mut DeviceClass) {
         unsafe {
             bindings::device_class_set_props(dc, <T as DeviceImpl>::properties().as_ptr());
         }
+
+        <T as ClassInitImpl<ObjectClass>>::class_init(&mut dc.parent_class);
     }
 }
 
-- 
2.47.1


