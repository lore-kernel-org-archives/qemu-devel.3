Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AC8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCZ-0001XA-Mx; Fri, 17 Jan 2025 14:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCY-0001WG-Qv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCW-0002Br-V0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0ARwjCk/01hXKDGIyxRI2rwcuyqDQN//xQ3CzCZhAQ=;
 b=iWbXtjHKfBdMPxdWLGtvC2TjtVOjjIQ1uqo3+9VRlfjbmAgmWAfVowRBszWZASyBPLme7q
 utp3+5MNSVWvfj1FTeoH6WhSxiKoTqivEYbOUb7e6jU5BCPZfjdlQed8etZ4l9MIi1FYCy
 hdqPjOxd2BWqfHV6FsGmsWGFXsxGYeU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-vaWV2lSqN2-wBwHycmbBZg-1; Fri, 17 Jan 2025 14:40:13 -0500
X-MC-Unique: vaWV2lSqN2-wBwHycmbBZg-1
X-Mimecast-MFC-AGG-ID: vaWV2lSqN2-wBwHycmbBZg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aaf901a0ef9so213269666b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142809; x=1737747609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0ARwjCk/01hXKDGIyxRI2rwcuyqDQN//xQ3CzCZhAQ=;
 b=RiRIK2+kh+hAubrmuqpvUnq439yHNFAc9h8CB6+nBy4+OcdVlYBrUFpl6suSP6s8OL
 goSOIMVzqt41/YNNk0f3NOTGi4oNAt9EkzzaLLa8f+0zbtjq0duWtTlMIjh70KUS19zT
 OhflGvXkhmnVbZERtlr+n25ft1MQ8c05pUbb+9Ghvmsq69XhLkoUZHZdNzB9wIVn64IP
 rzBcIX3oEHTQ5vFebHaivsGVsGaIvxlOxdhS1/Lqqfvlor6xLXPu/YTEWa1EvAMSO9Uh
 fmp36uB/Ow1MyDS+9BnwCVo1MBPhrCvFk03S5m5Yzrzz3lOEMihKmXdpuNjHLk5Pavs0
 Lt/Q==
X-Gm-Message-State: AOJu0YzBST4Il307XNOE295A1sb+DdCGT146NRSZEuri6zcBAsTNF1kh
 7DVBPIc05/j+Blmt407YxNrw6qyLHF8sGLig8g01HCZHpU5CuO+25zZkPaLWzkn9bRpby437qmM
 w701Ha1Ze+qq1Uw9aCBPccGXFifFdSRxbftbJHyYCB8vN1qvYZDcJK0wZ5Ze1l6rEiwwsDHuK35
 XNe5J2UP1u5MXQvrMY8C6ZUP7WgDvlshjSsTQj3G8=
X-Gm-Gg: ASbGncsYZcHefKZhTSEeEs1wJYk5ZH3+76yIHgPJEaAYBBn/HgI4mKVOVMfT3NW+tXh
 kavshq5w6bC9xSQKQ90YL1h1Kla2ZbTEff371VOVgI7m9BDmqiMdgd9kKc5eimLT464vndD06OY
 WfSgAg2g/DMPwH8XXmJ5MY70q1ct3lsK7jfT7gCMAOM6fi9bNU6cwOXtowjHBSGuUkHsSuWTfz3
 fed224VTSnGDQye5Hqd6lULWVxA3TSeQEYN3nhNH6rNWyJ4J6e5vCAjpd8o+w==
X-Received: by 2002:a17:907:1b15:b0:aae:b259:ef5e with SMTP id
 a640c23a62f3a-ab38aedb10amr439699366b.0.1737142809427; 
 Fri, 17 Jan 2025 11:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMDRdERqU2cfUiTl47s86HjchaelOmwLr6bdW4pbj5I3PpuiERcQKQgI69m80YCaGYdfXq3w==
X-Received: by 2002:a17:907:1b15:b0:aae:b259:ef5e with SMTP id
 a640c23a62f3a-ab38aedb10amr439696366b.0.1737142808843; 
 Fri, 17 Jan 2025 11:40:08 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c61388sm217563366b.20.2025.01.17.11.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 02/10] rust: qom: add reference counting functionality
Date: Fri, 17 Jan 2025 20:39:55 +0100
Message-ID: <20250117194003.1173231-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

Add a smart pointer that allows to add and remove references from
QOM objects.  It's important to note that while all QOM objects have a
reference count, in practice not all of them have their lifetime guarded
by it.  Embedded objects, specifically, are confined to the lifetime of
the owner.

When writing Rust bindings this is important, because embedded objects are
*never* used through the "Owned<>" smart pointer that is introduced here.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs     | 121 ++++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/vmstate.rs |   6 +-
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 97901fb9084..c404f8a1aa7 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -56,13 +56,21 @@
 use std::{
     ffi::CStr,
     fmt,
+    mem::ManuallyDrop,
     ops::{Deref, DerefMut},
     os::raw::c_void,
+    ptr::NonNull,
 };
 
 pub use bindings::{Object, ObjectClass};
 
-use crate::bindings::{self, object_dynamic_cast, object_get_class, object_get_typename, TypeInfo};
+use crate::{
+    bindings::{
+        self, object_dynamic_cast, object_get_class, object_get_typename, object_ref, object_unref,
+        TypeInfo,
+    },
+    cell::bql_locked,
+};
 
 /// Marker trait: `Self` can be statically upcasted to `P` (i.e. `P` is a direct
 /// or indirect parent of `Self`).
@@ -605,6 +613,110 @@ unsafe impl ObjectType for Object {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_OBJECT) };
 }
 
+/// A reference-counted pointer to a QOM object.
+///
+/// `Owned<T>` wraps `T` with automatic reference counting.  It increases the
+/// reference count when created via [`Owned::from`] and decreases it when
+/// dropped. This ensures that the reference count remains elevated as long as
+/// any `Owned<T>` references to it exist. Note that however the object may
+/// disappear if it is *embedded* within a larger object. For more information
+/// see the [`Owned::from`].
+///
+/// It is *not* safe to send `Owned<T>` to another thread, because currently
+/// `object_unref` requires the Big QEMU Lock.
+#[repr(transparent)]
+#[derive(PartialEq, Eq, Hash, PartialOrd, Ord)]
+pub struct Owned<T: ObjectType>(NonNull<T>);
+
+// SAFETY: the implementation asserts via `bql_locked` that the BQL is taken
+unsafe impl<T: ObjectType + Sync> Sync for Owned<T> {}
+
+impl<T: ObjectType> Owned<T> {
+    /// Convert a raw C pointer into an owned reference to the QOM
+    /// object it points to.  The object's reference count will be
+    /// decreased when the `Owned` is dropped.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `ptr` is NULL.
+    ///
+    /// # Safety
+    ///
+    /// The caller must indeed own a reference to the QOM object.
+    /// The object must not be embedded in another unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    ///
+    /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
+    /// back to `from_raw()` (assuming the original `Owned` was valid!),
+    /// since the owned reference remains there between the calls to
+    /// `into_raw()` and `from_raw()`.
+    #[allow(clippy::missing_const_for_fn)]
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY NOTE: while NonNull requires a mutable pointer, only
+        // Deref is implemented so the pointer passed to from_raw
+        // remains const
+        Owned(NonNull::new(ptr as *mut T).unwrap())
+    }
+
+    /// Obtain a raw C pointer from a reference.  `src` is consumed
+    /// and the reference is leaked.
+    #[allow(clippy::missing_const_for_fn)]
+    pub fn into_raw(src: Owned<T>) -> *mut T {
+        let src = ManuallyDrop::new(src);
+        src.0.as_ptr()
+    }
+
+    /// Increase the reference count of a QOM object and return
+    /// a new owned reference to it.
+    ///
+    /// # Safety
+    ///
+    /// The object must not be embedded in another, unless the outer
+    /// object is guaranteed to have a longer lifetime.
+    pub unsafe fn from(obj: &T) -> Self {
+        unsafe {
+            object_ref(obj.as_object_mut_ptr().cast::<c_void>());
+
+            // SAFETY NOTE: while NonNull requires a mutable pointer, only
+            // Deref is implemented so the reference passed to from_raw
+            // remains shared
+            Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
+        }
+    }
+}
+
+impl<T: ObjectType> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: creation method is unsafe; whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>`.
+        // With that guarantee, reference counting ensures that
+        // the object remains alive.
+        unsafe { &*self.0.as_ptr() }
+    }
+}
+impl<T: ObjectType> ObjectDeref for Owned<T> {}
+
+impl<T: ObjectType> Drop for Owned<T> {
+    fn drop(&mut self) {
+        assert!(bql_locked());
+        // SAFETY: creation method is unsafe, and whoever calls it has
+        // responsibility that the pointer is valid, and remains valid
+        // throughout the lifetime of the `Owned<T>`.
+        unsafe {
+            object_unref(self.as_object_mut_ptr().cast::<c_void>());
+        }
+    }
+}
+
+impl<T: IsA<Object>> fmt::Debug for Owned<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        self.deref().debug_fmt(f)
+    }
+}
+
 /// Trait for methods exposed by the Object class.  The methods can be
 /// called on all objects that have the trait `IsA<Object>`.
 ///
@@ -636,6 +748,13 @@ fn get_class(&self) -> &'static <Self::Target as ObjectType>::Class {
 
         klass
     }
+
+    /// Convenience function for implementing the Debug trait
+    fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        f.debug_tuple(&self.typename())
+            .field(&(self as *const Self))
+            .finish()
+    }
 }
 
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6ac432cf52f..11d21b8791c 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -29,6 +29,8 @@
 pub use crate::bindings::{VMStateDescription, VMStateField};
 use crate::{
     bindings::{self, VMStateFlags},
+    prelude::*,
+    qom::Owned,
     zeroable::Zeroable,
 };
 
@@ -191,7 +193,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
 ///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer or a `Box` for any of the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
+///   the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
@@ -398,6 +401,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
-- 
2.47.1


