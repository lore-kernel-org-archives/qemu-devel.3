Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E283E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd56-0007eo-LQ; Mon, 09 Dec 2024 07:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1r-0004AV-Mz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1p-0007ZL-QT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uEcPFIxXxKd/mahbXkvWTwydRcIWtDLPmh0PhjQLUk=;
 b=A73kbRsHv7SiU+Iw7zzFDXNrxMLfP36fKOAIKeJUOdNgHxrs58dW/yF0p0P9t5F4me4pen
 mUF6U8+9mYLGYnbMByDGGOatynVPzloU35boR0zdgw96LxFIkyZoqN+WLEamtFRF/GB5Ls
 daIECAQVRMTxdDm1ejZtl8pcDaIbHnE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nXVJ5KmGOriX5qyrtsg14A-1; Mon, 09 Dec 2024 07:38:18 -0500
X-MC-Unique: nXVJ5KmGOriX5qyrtsg14A-1
X-Mimecast-MFC-AGG-ID: nXVJ5KmGOriX5qyrtsg14A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso1568752f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747895; x=1734352695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uEcPFIxXxKd/mahbXkvWTwydRcIWtDLPmh0PhjQLUk=;
 b=YHbhY8WTeVi/F3mKkGezT/qLWeyn6lpEpImOJ7qVfJtmnHQKyjQ8CF66xmwGqy7esz
 oNCSD7jgnQdmwWP9/Lwnd3Qz+2kn70WKEXAZqFIDZYNG7hRdEqh+nInzcX/7Ku9TLBUA
 3TkagcNP/k9eYxPxpdfDi1mZ5zakHimIfdIRvxDhR9IV0X/UFTpWSiIfaEOJnH9RdvSS
 Ai2EvcxxGHlXL1/w8G/SXRG80Gk6cbbb4UWeoSsOLpgf/gfq+Lq5zkmLmM5bgK6esQIQ
 pUja+6jxT8SK/KMn8gZdi/I6QsMkyTkOlSGI/ZwwG7sm0cPv1yVovmKL8RqeQEHOWwQD
 OsZQ==
X-Gm-Message-State: AOJu0Yw87ge28BHHff/6H5EOLwohuPv99xLB4aoCqJd+9Me6bcQjo+Nt
 g63Uxqmj/PLGPWAhW8FqbuZUwL1/HhMhcGptIPa3pujojOHuIKhqFeRUlvrdhuGllrO0+urUIo4
 cNBUkQVaZmh7pm7Z3fl0RoHAlsIOheugdGblvAwZd/u0oCa+YixLHsD/Fv5Djf1xZ7EcbmqOeMi
 dXkrXBWvo7GHWIQDW5nOxihxvjjpKpzi/6bmE1
X-Gm-Gg: ASbGnctw/F6GnYUVAfVR3Qy2r/KNNW3jNzrw6aAmpmPUG9oh3GoibgFbPODa/Xdk0g0
 9IdS18aCjUCPxyDtYKq7SVR2UDwZC5R/TzTjA7nvAws8tbC8PmQaTp8aC0KOTew8I/XtKYI/PR9
 JejDsaUUu9VLuN33m5Ru2Y6yh3qiH7EijAlVHnFvI3HD4AUPa4lW+F4B1ZuzBR0ulVePoivjP51
 Kqt5wu9EN7UllBvruB7ee47kQ8FZ4IRpu7an8IoeNxRZs4INIKGDg==
X-Received: by 2002:a05:6000:184d:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-3862b33ef3dmr8472042f8f.1.1733747895442; 
 Mon, 09 Dec 2024 04:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWJMYdNT8YTYcEVF0k48QxoZc6Rdq22mNcPglVw95b1mKCZ+fBrZ9tkmS/t/2k80Wvfqg3Dg==
X-Received: by 2002:a05:6000:184d:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-3862b33ef3dmr8472015f8f.1.1733747894960; 
 Mon, 09 Dec 2024 04:38:14 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862de365f0sm9885129f8f.3.2024.12.09.04.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 23/26] rust: qom: add initial subset of methods on Object
Date: Mon,  9 Dec 2024 13:37:14 +0100
Message-ID: <20241209123717.99077-24-pbonzini@redhat.com>
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

Add an example of implementing instance methods and converting the
result back to a Rust type.  In this case the returned types are a
string (actually a Cow<str>; but that's transparent as long as it derefs
to &str) and a QOM class.

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
index 7115d85df6f..d7475b8ed6a 100644
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
 //! A concrete class only needs a struct holding instance state. The struct must
@@ -40,6 +45,16 @@
 //!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct,
 //!   typically with wrappers that call into the
 //!   [`DeviceImpl`](crate::qdev::DeviceImpl) implementations.
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
@@ -49,7 +64,7 @@
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, object_dynamic_cast, TypeInfo};
+use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
 
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
@@ -504,3 +519,38 @@ unsafe impl ObjectType for Object {
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
index 549e9699c26..4c766c7f808 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -88,6 +88,18 @@ fn test_object_new() {
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


