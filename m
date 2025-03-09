Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B035C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDxO-0000dI-3K; Sun, 09 Mar 2025 06:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDxA-0000BC-8v
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx8-00045l-Av
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+11c/N4D4n5nsZ2e2p64dlWgYqM6+Rie5jL418qQFDM=;
 b=KTuedrZ1LeyyggNy/1uT0KfGKj2JsOrl2Pq//ZNhrtZzage84GjtVJQPXScuD2fsV5kmgM
 librU7Z9pMXxb6KZnbi0U4laGGr5N0AF5ed70WBmPCXVicJJieAey1abu4QyAa0FOzzn9e
 moFnFgCyNKVyFROS0akSTsjLaJY7Hw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-9Y99PB1INtOf-1lOTGr2lQ-1; Sun, 09 Mar 2025 06:32:11 -0400
X-MC-Unique: 9Y99PB1INtOf-1lOTGr2lQ-1
X-Mimecast-MFC-AGG-ID: 9Y99PB1INtOf-1lOTGr2lQ_1741516331
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so1974612f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516330; x=1742121130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+11c/N4D4n5nsZ2e2p64dlWgYqM6+Rie5jL418qQFDM=;
 b=O4oUUsSWJwSwVPNMRkb5fXJfT6gc3uK6qt1vdCjMVcbWTDizvNYPjN07B9+9MgF8tD
 sk4iRSOQOx66R/7PLfADe+c5GkkPnRt9YF9LSloehgy+LIQE6GeYPxrXT3rX02zOH3QH
 meJMFggyOv9C/BGkrtOs9Z2lapgg2nOiDJIMK1wHpqnLW4gK6Bmm2Oelzrsv8bD0Sc+8
 w9XbeY/FIK5x+ifw0QJrBiR90Dy6xB2fiNWly5Brf+tjV+sAgrB+l9fOUcQrINwvi2x4
 NrrrNTgNVOEGNh/M84s5+NjWvAAAmaT1qraEk6JZptzVhsF6hA7BwQHvGdK6uurTWRun
 oeWQ==
X-Gm-Message-State: AOJu0YzGqqFBlvNrDvSqmGua88ASaF/VBrRb6380/1Nc+57G9wFTC85q
 ZAJTPV1ytw8lw/BHbXzTgD9ocHKScoHKiTvGLiDdR8kuG9u7/1pY8O5v5a8fIyCOaTbyeTDDbJs
 75Mz46XzaB/16+XAao3IfL2ufwTTc5h0oC4j8NFguy1grnS041BIoZkoqh+YlKR/QFC/sdOWjR9
 WSpcmCMC2+hPCcbUjdEPs72NDiQrv+BPNrRiiLR4A=
X-Gm-Gg: ASbGncujUNNngfsO1uydxnC2+hFh+IeMEWgsJXmJ2GHXEIsfyKSt7zEm5QWzR5L2d7d
 aBWAqVcKRvqiRNXVcqtm0OkNm43VH6H2qNcp5w6/W98cmtWQqdOM8GP/L5JVEQM2LRweZ68J2R9
 gAfPxR5VbXINiHwQkzyog05Xqeuy7JwZBQfwG0U9DU8hsrxz3+VXxEG6AOMUAur2uTgvWJq0Q+U
 qfq30qTkjtKNI+7WP/IvGUlCyzRZOuLV3LREeYLlW+fI03zqaVUqnF3oI3X5R2RDXLURj9kN4ZB
 17xXdK60YmdAdLV1sk39gg==
X-Received: by 2002:a5d:6483:0:b0:38f:28cb:4d35 with SMTP id
 ffacd0b85a97d-39132d4e38cmr6390587f8f.13.1741516330206; 
 Sun, 09 Mar 2025 03:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyDahsDFJKm03RaFadlSUd4jcH2SDu8CYjbfEAiNNa8zSJjrJr216wdNO99+gnaY5j3TnMxg==
X-Received: by 2002:a5d:6483:0:b0:38f:28cb:4d35 with SMTP id
 ffacd0b85a97d-39132d4e38cmr6390568f8f.13.1741516329647; 
 Sun, 09 Mar 2025 03:32:09 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba8a9sm11511475f8f.9.2025.03.09.03.32.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] rust: qom: remove operations on &mut
Date: Sun,  9 Mar 2025 11:31:17 +0100
Message-ID: <20250309103120.1116448-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The dubious casts of mutable references to objects are not used
anymore: the wrappers for qdev_init_clock_in and for IRQ and MMIO
initialization can be called directly on the subclasses, without
casts, plus they take a shared reference so they can just use
"upcast()" instead of "upcast_mut()".  Remove them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/memory.rs  |  5 ---
 rust/qemu-api/src/prelude.rs |  1 -
 rust/qemu-api/src/qom.rs     | 83 ------------------------------------
 rust/qemu-api/tests/tests.rs | 34 +--------------
 4 files changed, 2 insertions(+), 121 deletions(-)

diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index eff9f09fd7f..fdb1ea11fcf 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -175,11 +175,6 @@ pub fn init_io<T: IsA<Object>>(
     ) {
         unsafe {
             Self::do_init_io(
-                // self.0.as_mut_ptr() needed because Rust tries to call
-                // ObjectDeref::as_mut_ptr() on "&mut Self", instead of coercing
-                // to "&Self" and then calling MemoryRegion::as_mut_ptr().
-                // Revisit if/when ObjectCastMut is not needed anymore; it is
-                // only used in a couple places for initialization.
                 self.0.as_mut_ptr(),
                 owner.cast::<Object>(),
                 &ops.0,
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 634acf37a85..43bfcd5fcab 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -17,7 +17,6 @@
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
-pub use crate::qom::ObjectCastMut;
 pub use crate::qom::ObjectDeref;
 pub use crate::qom::ObjectClassMethods;
 pub use crate::qom::ObjectMethods;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 2defbd23516..34d7bc0ef96 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -463,90 +463,7 @@ unsafe fn unsafe_cast<'a, U: ObjectType>(self) -> &'a U
 impl<T: ObjectType> ObjectDeref for &T {}
 impl<T: ObjectType> ObjectCast for &T {}
 
-/// Trait for mutable type casting operations in the QOM hierarchy.
-///
-/// This trait provides the mutable counterparts to [`ObjectCast`]'s conversion
-/// functions. Unlike `ObjectCast`, this trait returns `Result` for fallible
-/// conversions to preserve the original smart pointer if the cast fails. This
-/// is necessary because mutable references cannot be copied, so a failed cast
-/// must return ownership of the original reference. For example:
-///
-/// ```ignore
-/// let mut dev = get_device();
-/// // If this fails, we need the original `dev` back to try something else
-/// match dev.dynamic_cast_mut::<FooDevice>() {
-///    Ok(foodev) => /* use foodev */,
-///    Err(dev) => /* still have ownership of dev */
-/// }
-/// ```
-pub trait ObjectCastMut: Sized + ObjectDeref + DerefMut
-where
-    Self::Target: ObjectType,
-{
-    /// Safely convert from a derived type to one of its parent types.
-    ///
-    /// This is always safe; the [`IsA`] trait provides static verification
-    /// that `Self` dereferences to `U` or a child of `U`.
-    fn upcast_mut<'a, U: ObjectType>(self) -> &'a mut U
-    where
-        Self::Target: IsA<U>,
-        Self: 'a,
-    {
-        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait
-        unsafe { self.unsafe_cast_mut::<U>() }
-    }
-
-    /// Attempt to convert to a derived type.
-    ///
-    /// Returns `Ok(..)` if the object is of type `U`, or `Err(self)` if the
-    /// object if the conversion failed. This is verified at runtime by
-    /// checking the object's type information.
-    fn downcast_mut<'a, U: IsA<Self::Target>>(self) -> Result<&'a mut U, Self>
-    where
-        Self: 'a,
-    {
-        self.dynamic_cast_mut::<U>()
-    }
-
-    /// Attempt to convert between any two types in the QOM hierarchy.
-    ///
-    /// Returns `Ok(..)` if the object is of type `U`, or `Err(self)` if the
-    /// object if the conversion failed. This is verified at runtime by
-    /// checking the object's type information.
-    fn dynamic_cast_mut<'a, U: ObjectType>(self) -> Result<&'a mut U, Self>
-    where
-        Self: 'a,
-    {
-        unsafe {
-            // SAFETY: upcasting to Object is always valid, and the
-            // return type is either NULL or the argument itself
-            let result: *mut U =
-                object_dynamic_cast(self.as_object_mut_ptr(), U::TYPE_NAME.as_ptr()).cast();
-
-            result.as_mut().ok_or(self)
-        }
-    }
-
-    /// Convert to any QOM type without verification.
-    ///
-    /// # Safety
-    ///
-    /// What safety? You need to know yourself that the cast is correct; only
-    /// use when performance is paramount.  It is still better than a raw
-    /// pointer `cast()`, which does not even check that you remain in the
-    /// realm of QOM `ObjectType`s.
-    ///
-    /// `unsafe_cast::<Object>()` is always safe.
-    unsafe fn unsafe_cast_mut<'a, U: ObjectType>(self) -> &'a mut U
-    where
-        Self: 'a,
-    {
-        unsafe { &mut *self.as_mut_ptr::<Self::Target>().cast::<U>() }
-    }
-}
-
 impl<T: ObjectType> ObjectDeref for &mut T {}
-impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl: ObjectType + IsA<Object> {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index e3985782a38..269122e7ec1 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,13 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{
-    ffi::{c_void, CStr},
-    ptr::{addr_of, addr_of_mut},
-};
+use std::{ffi::CStr, ptr::addr_of};
 
 use qemu_api::{
-    bindings::{module_call_init, module_init_type, object_new, object_unref, qdev_prop_bool},
+    bindings::{module_call_init, module_init_type, qdev_prop_bool},
     c_str,
     cell::{self, BqlCell},
     declare_properties, define_property,
@@ -182,30 +179,3 @@ fn test_cast() {
         assert_eq!(addr_of!(*sbd_ref), p_ptr.cast());
     }
 }
-
-#[test]
-#[allow(clippy::shadow_unrelated)]
-/// Test casts on mutable references.
-fn test_cast_mut() {
-    init_qom();
-    let p: *mut DummyState = unsafe { object_new(DummyState::TYPE_NAME.as_ptr()).cast() };
-
-    let p_ref: &mut DummyState = unsafe { &mut *p };
-    let obj_ref: &mut Object = p_ref.upcast_mut();
-    assert_eq!(addr_of_mut!(*obj_ref), p.cast());
-
-    let sbd_ref: Result<&mut SysBusDevice, &mut Object> = obj_ref.dynamic_cast_mut();
-    let obj_ref = sbd_ref.unwrap_err();
-
-    let dev_ref: Result<&mut DeviceState, &mut Object> = obj_ref.downcast_mut();
-    let dev_ref = dev_ref.unwrap();
-    assert_eq!(addr_of_mut!(*dev_ref), p.cast());
-
-    // SAFETY: the cast is wrong, but the value is only used for comparison
-    unsafe {
-        let sbd_ref: &mut SysBusDevice = obj_ref.unsafe_cast_mut();
-        assert_eq!(addr_of_mut!(*sbd_ref), p.cast());
-
-        object_unref(p_ref.as_object_mut_ptr().cast::<c_void>());
-    }
-}
-- 
2.48.1


