Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055D3E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByj-0006ev-53; Thu, 19 Dec 2024 03:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByf-0006WM-CM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBya-0005FF-Hm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3f/tK+ZTxZZI3fMVdifM4kT9MvIwtAUXIGT42T0zO+Y=;
 b=PHbdgEYbJlWuv3ydBst52CSTyK/2ug3fwQ23OikBuq0Fg3R63ZFbBzOpKJJ4aTLSogknUr
 cij8zTyWrQHOKSSMc6CjDy1wTBQrzWsCX8MmcmfBZzqLVRTfuuHBYmO8rcSPtpvV0W5GcF
 UP5KcXxnGBrQSRkeFrws9NTSbREg5+8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-BqYw3DFOP1Sf0gDMppJZ4Q-1; Thu, 19 Dec 2024 03:33:40 -0500
X-MC-Unique: BqYw3DFOP1Sf0gDMppJZ4Q-1
X-Mimecast-MFC-AGG-ID: BqYw3DFOP1Sf0gDMppJZ4Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so4083805e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597217; x=1735202017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3f/tK+ZTxZZI3fMVdifM4kT9MvIwtAUXIGT42T0zO+Y=;
 b=rBbulK5aIVoFcBDLs+Lx3k5RILpOQquBXJcli9Hn1uJLHOokjTZKobkRwJJnufEgaC
 FvPnYb+Oo4yRKr4r896WG/f+43j5wFOhv2h0QWxE4hmiS6TaJUU6K9/UwlEdphMEVpaK
 5ARdjX8vSOznU+9hUVRIqFJ4gVqhCMPzfBdsYi4XSifegosHCA+fIqm0dD9W6uNlkt/3
 vetyW5bis6tPChCY6FZbkZZ/g/lOpQtGtCWXfnUx8WdCbwXCe9gk/SdsHlGpYTSnCagY
 ouhFExzOyZPO0eZ93BpJpZezQiYtkgSnFSdUY22AJbWk1NM1agQ/49akoYWSvWljYooJ
 H8kA==
X-Gm-Message-State: AOJu0YzAcxhTAnSlJNvA4lnl3c75HlQb3otl7tR1F7uLZxvMxGpCotN7
 FrtNwSLG/w8LeU8TJt8GbbX8RYD0T8irZ0oBwQss+kJ6eOTpYuEXi4TI2h/Oyt5mNuVXVYurhP3
 Fvfpy/O12X+trswbW2nhL4l6NUfgzc9/kKBjlk+K9EF2R+Arh3kj5jnnZYkKv47qCP2bK5KGteK
 vFLXJLbQOeTDQeo7c3SQ7lv0xS/TDTyYl7jra5
X-Gm-Gg: ASbGncs+L8pDlrCH/irUtxK0ijooqu1wfPXK4pBZhdbZ0pmK1kC/6JsUBVRRy6bo5+A
 GUP1cBsZP5qkjMCVwyoeszL08EFpY4DEmWbVrqOKBxU8he1uNmoYnCCE0wdhI9Y7df83lahE3Tl
 c6cvtFps5CDMUIpEIwAAG3gDHY/CDxyFcT6bRP8BHQywbOeqcYp1VRUQbaJPpse8MJnc3oBIGHt
 BsGugPKIv6ZRGkZRrnKjSotKwLQ7V017Nf3f7mhqDJ0rFE4X+MoepkW9ARE
X-Received: by 2002:a05:6000:186f:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-38a19b050a5mr2431249f8f.14.1734597216864; 
 Thu, 19 Dec 2024 00:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1D9nY5fIZLSfIgL12fieezyJCMj6kNP4Ops0+CGUpQBrGy4e6Z3JqkaZa5J/0ZrRybXZUYQ==
X-Received: by 2002:a05:6000:186f:b0:386:1ab5:f0e1 with SMTP id
 ffacd0b85a97d-38a19b050a5mr2431215f8f.14.1734597216446; 
 Thu, 19 Dec 2024 00:33:36 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436604e9c2csm12851605e9.43.2024.12.19.00.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/41] rust: qom: add initial subset of methods on Object
Date: Thu, 19 Dec 2024 09:32:18 +0100
Message-ID: <20241219083228.363430-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Add an example of implementing instance methods and converting the
result back to a Rust type.  In this case the returned types are a
string (actually a Cow<str>; but that's transparent as long as it derefs
to &str) and a QOM class.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/prelude.rs |  1 +
 rust/qemu-api/src/qom.rs     | 56 ++++++++++++++++++++++++++++++++++--
 rust/qemu-api/tests/tests.rs | 12 ++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index a0a71fcd6bc..6f32deeb2ed 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -12,6 +12,7 @@
 pub use crate::qom::ObjectCast;
 pub use crate::qom::ObjectCastMut;
 pub use crate::qom::ObjectDeref;
+pub use crate::qom::ObjectMethods;
 pub use crate::qom::ObjectType;
 
 pub use crate::qom_isa;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 74ea5721f77..7d5fbef1e17 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -5,8 +5,8 @@
 //! Bindings to access QOM functionality from Rust.
 //!
 //! The QEMU Object Model (QOM) provides inheritance and dynamic typing for QEMU
-//! devices. This module makes QOM's features available in Rust through two main
-//! mechanisms:
+//! devices. This module makes QOM's features available in Rust through three
+//! main mechanisms:
 //!
 //! * Automatic creation and registration of `TypeInfo` for classes that are
 //!   written in Rust, as well as mapping between Rust traits and QOM vtables.
@@ -15,6 +15,11 @@
 //!   trait and methods such as [`upcast`](ObjectCast::upcast) and
 //!   [`downcast`](ObjectCast::downcast).
 //!
+//! * Automatic delegation of parent class methods to child classes. When a
+//!   trait uses [`IsA`] as a bound, its contents become available to all child
+//!   classes through blanket implementations. This works both for class methods
+//!   and for instance methods accessed through references or smart pointers.
+//!
 //! # Structure of a class
 //!
 //! A leaf class only needs a struct holding instance state. The struct must
@@ -37,6 +42,16 @@
 //!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct;
 //!   the source for this is the `*Impl` trait; the associated consts and
 //!   functions if needed are wrapped to map C types into Rust types.
+//!
+//! * a trait for instance methods, for example `DeviceMethods`. This trait is
+//!   automatically implemented for any reference or smart pointer to a device
+//!   instance.  It calls into the vtable provides access across all subclasses
+//!   to methods defined for the class.
+//!
+//! * optionally, a trait for class methods, for example `DeviceClassMethods`.
+//!   This provides access to class-wide functionality that doesn't depend on
+//!   instance data. Like instance methods, these are automatically inherited by
+//!   child classes.
 
 use std::{
     ffi::CStr,
@@ -46,7 +61,7 @@
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, object_dynamic_cast, TypeInfo};
+use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
 
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
@@ -532,3 +547,38 @@ unsafe impl ObjectType for Object {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
 }
+
+/// Trait for methods exposed by the Object class.  The methods can be
+/// called on all objects that have the trait `IsA<Object>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`
+pub trait ObjectMethods: ObjectDeref
+where
+    Self::Target: IsA<Object>,
+{
+    /// Return the name of the type of `self`
+    fn typename(&self) -> std::borrow::Cow<'_, str> {
+        let obj = self.upcast::<Object>();
+        // SAFETY: safety of this is the requirement for implementing IsA
+        // The result of the C API has static lifetime
+        unsafe {
+            let p = object_get_typename(obj.as_mut_ptr());
+            CStr::from_ptr(p).to_string_lossy()
+        }
+    }
+
+    fn get_class(&self) -> &'static <Self::Target as ObjectType>::Class {
+        let obj = self.upcast::<Object>();
+
+        // SAFETY: all objects can call object_get_class; the actual class
+        // type is guaranteed by the implementation of `ObjectType` and
+        // `ObjectImpl`.
+        let klass: &'static <Self::Target as ObjectType>::Class =
+            unsafe { &*object_get_class(obj.as_mut_ptr()).cast() };
+
+        klass
+    }
+}
+
+impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 5d9f13b15d4..41ea4026b83 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -94,6 +94,18 @@ fn test_object_new() {
     }
 }
 
+#[test]
+/// Try invoking a method on an object.
+fn test_typename() {
+    init_qom();
+    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
+    let p_ref: &DummyState = unsafe { &*p };
+    assert_eq!(p_ref.typename(), "dummy");
+    unsafe {
+        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
+    }
+}
+
 // a note on all "cast" tests: usually, especially for downcasts the desired
 // class would be placed on the right, for example:
 //
-- 
2.47.1


