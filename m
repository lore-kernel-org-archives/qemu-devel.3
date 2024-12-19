Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7D8E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByO-0005YP-Pg; Thu, 19 Dec 2024 03:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByN-0005Ug-UK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByM-0005Cv-A3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmCTcKk0IFYVFevoPCPLYpGDtVOutqk1v2s9a09H49U=;
 b=NE6eYlRWabZm/kT6dsflDiSQEycxcETHerFa6ZS5c5IdVTRrHnbjo8VIoAeGUUATc+c3m2
 E4+SQ+KaQ0GKsHOj4wOVNpOU4S5uS6cfjbLcOLyg6jGBNtZLt8vtNrty+mMocxkzodaGIc
 y/UpOAP+sy4WllP3XS8TrQlSULz3+m8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-k22PXFs0OEuf_w6hipjBOQ-1; Thu, 19 Dec 2024 03:33:27 -0500
X-MC-Unique: k22PXFs0OEuf_w6hipjBOQ-1
X-Mimecast-MFC-AGG-ID: k22PXFs0OEuf_w6hipjBOQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436219070b4so2727985e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597205; x=1735202005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmCTcKk0IFYVFevoPCPLYpGDtVOutqk1v2s9a09H49U=;
 b=az4Yxa5IwHy0gKriOXqbBuxZbEcjR3QqhwKWjwyqMxxiQrO3mwmvRmhe/XgwSqBOYo
 I4MLhUINkYoaUxbxpL1+dcPqheCkmkEOpyFgYHJS40b6pP449MMlrWFz9+gFi4jzuHnR
 vq6gcRrDSyNu8gA70mxcyEbxLNn4vSAGDRiC5P6sxz2z9hM+B0d7V8RzAlFaeG94NZgp
 3D8dOkjsWhfntpJwtznrj3u0TVqyDS7pytlsxTLD2WEeFgS1H5IqD9A3Gp72UWNydw+w
 mK5vzY03YW0PZ+jroUINYnDPrUc4Cd0rNFqaYxKSDUTSO/pesSJqmCtvaKx1r/hDSlrJ
 cQvw==
X-Gm-Message-State: AOJu0Yz++O4VIT1sMSPQ2a8BMVLZYRM9cSWA3hC1SnOLuL1UYWvuHbw1
 seWGnH+pXrVBqCtf0tlJhWK0TbTqBSTYQS8BRujspq+2etHgwc2pJZemcfpeOqwVcJxBrzV9NoD
 xWez+AsnzhHAr7M8pyn47/Anl1Yx2CWP3WH6nJBPBikFALH8spAbQkWoUlQyPU24ohT4FoHd/A7
 DUmSIWbAOdJ/2pVHm1dmC0/ktXOM3MBIrT7pco
X-Gm-Gg: ASbGncvZnNvWgLNvQvSRDem+65Y84xRLiIwn08mOyaKY9rTMVRG3TqwPBw3/UN0ksxG
 ejVWgiskD2k5q1Twowp+3hfKJwIzeAPWyBJHiPEg5SNAnwzQQrr3+YzAfUs7oi6U9V7JHyScTqY
 XWm9oENB3JDwGoDFAa3bmJyot+7xkpBBh1b+TwWSqu9WHp0ezmR27d93X1KBNTKHcZQ8H0PZVOb
 R3nFAQaYRkpmC0g+WR0dLCmPdr3lgw6Cbgk5PBeUb2bsvrE6DAv7IFO2eu3
X-Received: by 2002:a05:600c:3b1f:b0:434:fae4:1630 with SMTP id
 5b1f17b1804b1-4365542e00emr40793555e9.28.1734597205360; 
 Thu, 19 Dec 2024 00:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ8TrS9ch95GAYe/BMmEpDJPSe8TzGbg5Kd7MtTtOTCKn0bmbqknbCWj+egPz7Z69MgKjRpQ==
X-Received: by 2002:a05:600c:3b1f:b0:434:fae4:1630 with SMTP id
 5b1f17b1804b1-4365542e00emr40793255e9.28.1734597204886; 
 Thu, 19 Dec 2024 00:33:24 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e31sm989066f8f.33.2024.12.19.00.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/41] rust: qom: add possibility of overriding unparent
Date: Thu, 19 Dec 2024 09:32:13 +0100
Message-ID: <20241219083228.363430-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Add a blanket definition of ClassInitImpl<ObjectClass> that thunks
ObjectImpl::UNPARENT and overrides it in ObjectClass if it is not
None.

ClassInitImpl<DeviceClass> can now call its superclass's ClassInitImpl,
so that the C and Rust hierarchies match more closely.

This is mostly done as an example of implementing the metaclass
hierarchy under ClassInitImpl.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/definitions.rs  | 44 ++++++++++++++++++++++++++++---
 rust/qemu-api/src/device_class.rs |  6 +++--
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 13f8f6fd2a9..a2481c1fe70 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -6,7 +6,7 @@
 
 use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings::{Object, ObjectClass, TypeInfo};
+use crate::bindings::{self, Object, ObjectClass, TypeInfo};
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
@@ -121,6 +121,9 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
         class_data: core::ptr::null_mut(),
         interfaces: core::ptr::null_mut(),
     };
+
+    // methods on ObjectClass
+    const UNPARENT: Option<fn(&Self)> = None;
 }
 
 /// Internal trait used to automatically fill in a class struct.
@@ -134,7 +137,8 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// Each struct will implement this trait with `T` equal to each
 /// superclass.  For example, a device should implement at least
-/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>`.
+/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>` and
+/// `ClassInitImpl<`[`ObjectClass`](crate::bindings::ObjectClass)`>`.
 /// Such implementations are made in one of two ways.
 ///
 /// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
@@ -147,9 +151,13 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
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
 /// The other case is when manual implementation of the trait is needed.
 /// This covers the following cases:
 ///
@@ -235,3 +243,33 @@ extern "C" fn ctor_fn() {
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
+        let state = core::ptr::NonNull::new_unchecked(dev.cast::<T>());
+        T::UNPARENT.unwrap()(state.as_ref());
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
index dcec5488291..a9965d1f123 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -5,7 +5,7 @@
 use std::ffi::CStr;
 
 use crate::{
-    bindings::{self, DeviceClass, DeviceState, Error, Property, VMStateDescription},
+    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
     definitions::ClassInitImpl,
     prelude::*,
 };
@@ -68,7 +68,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 
 impl<T> ClassInitImpl<DeviceClass> for T
 where
-    T: DeviceImpl,
+    T: ClassInitImpl<ObjectClass> + DeviceImpl,
 {
     fn class_init(dc: &mut DeviceClass) {
         if <T as DeviceImpl>::REALIZE.is_some() {
@@ -88,6 +88,8 @@ fn class_init(dc: &mut DeviceClass) {
                 bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
             }
         }
+
+        <T as ClassInitImpl<ObjectClass>>::class_init(&mut dc.parent_class);
     }
 }
 
-- 
2.47.1


