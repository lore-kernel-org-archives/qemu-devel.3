Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB71C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOefw-0000U6-Bp; Mon, 09 Jun 2025 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOeft-0000Q3-NR
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefs-0007hZ-3I
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XtFw1Gm8P8SykWkqXaUzKJqdfFMOaemdUuq3TQP0wE=;
 b=CNlabHVMGB4vyvCejNNbI7LvFpqkub4INgfPgOsQyQqxbDQxCgPHhgEmu1p43FEJ64QE7N
 IrRALg/R1m22pXxesIXm1Pr/QYAfASqSXiNfC+kc9Sqs0bQXXa13A/kD9NZkvfDdijVeHU
 FfLArKVsSkiob7oudhR/xy69Fl5iVJs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-DKml0V4VMB2HAuI3cxdufg-1; Mon, 09 Jun 2025 11:44:34 -0400
X-MC-Unique: DKml0V4VMB2HAuI3cxdufg-1
X-Mimecast-MFC-AGG-ID: DKml0V4VMB2HAuI3cxdufg_1749483873
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so2312547f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483872; x=1750088672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0XtFw1Gm8P8SykWkqXaUzKJqdfFMOaemdUuq3TQP0wE=;
 b=LKy7RmBzDr7Wre80aiAmjRWQMvHfEfnSCW5HPiJaqzxl0w0+G9QKPSDUvMqV/Z2SXK
 WR1Hi6vpX9alqoplJq62Zdu36B1amZ9AZqmaX0Qp5ilKFAjBz3HYsgi5GkBWUY41dyzj
 vBcCAv8nmXyzusu5LUxqZKh0cXO+jCBQyfjY+vnrZVp0/upjzJ3rShgX70QdjRzf3T2t
 5J1HHnf0M++bqsrQ1iT+FTn5tYV0WjR1oVflvVU1z82gvjR9Pk7LPUCNUyGONnSF40Xm
 k/FQy7Kn+InxK2k2vJm4vJc1U4G9KO3J5/RoXjtSTlAS51aoRm3t4du+xUvGhGPl1eB6
 E0Zw==
X-Gm-Message-State: AOJu0YwxotWx1CnMd7+qwKEEyhzqBRU+f9hzRDoIZUQeqNgb3DEpiUjG
 JWzZa25uSrrA+xnKY353vzX8yyez9TrX0P9d4GHeagfYbuG9V2ZlWKQeXuARbLsb7Gbt2XI+loD
 3+Y0JAARb4j42ovgkIP2eM5dZSFYaR1v9SK1HAMa7qLiC28xBAavQT1xUkfT/89NuyFhpKdbOsV
 wR8P1BZ/MwGXbZTIH1vLD534HO6cPbIlisY8nBhM8U
X-Gm-Gg: ASbGnculcL/7L9/xv/D1RAdY2rXb0sJVRSPwGC6/g2dmWQQgUR6YGooIQftk8HDZnQr
 k5zigQrRFYkCo9yeJJgHsD/ILiOrb5MmCkSJKgkblT5XeogCHbHAETYcFTSDhNIRctZjK3MsqAm
 XfZiIhvQOl9fhyaPLvsPqeHky84RtSVpv95ySZx5fUSfqqkHU4AAFg9JWyHOmGOC5CLLlWSSsHR
 ifcLiZCSKpVXIoQ+8bFVYxknynppI4BYF4viq84zq5oIblxMeCDcKzmB4pv0Jo+VKAYVMOlCEFX
 vQqxRsAlDfBYWM6be61sIrGh
X-Received: by 2002:a05:6000:124c:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a5513f6775mr11945f8f.16.1749483872259; 
 Mon, 09 Jun 2025 08:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA887dzRG+kwqNJMKkT2oJADBvSV+FfV5SewknSuJ4Z+XFGr12R8krTTB0SZuf5A77jgfh+Q==
X-Received: by 2002:a05:6000:124c:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a5513f6775mr11932f8f.16.1749483871720; 
 Mon, 09 Jun 2025 08:44:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464575sm9901756f8f.97.2025.06.09.08.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/5] rust: qom: introduce ParentInit
Date: Mon,  9 Jun 2025 17:44:21 +0200
Message-ID: <20250609154423.706056-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609154423.706056-1-pbonzini@redhat.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is a smart pointer for MaybeUninit; it can be upcasted to the
already-initialized parent classes, or dereferenced to a MaybeUninit
for the class that is being initialized.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 86 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 14f98fee60a..21c271cd2f9 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -95,7 +95,7 @@
 use std::{
     ffi::{c_void, CStr},
     fmt,
-    mem::ManuallyDrop,
+    mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
@@ -206,6 +206,90 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     }
 }
 
+/// This struct knows that the superclasses of the object have already been
+/// initialized.
+pub struct ParentInit<'a, T>(&'a mut MaybeUninit<T>);
+
+impl<'a, T> ParentInit<'a, T> {
+    #[inline]
+    pub fn with(obj: &'a mut MaybeUninit<T>, f: impl FnOnce(ParentInit<'a, T>)) {
+        let parent_init = ParentInit(obj);
+        f(parent_init)
+    }
+}
+
+impl<T: ObjectType> ParentInit<'_, T> {
+    /// Return the receiver as a mutable raw pointer to Object.
+    pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
+        self.as_object_ptr().cast_mut()
+    }
+
+    /// Return the receiver as a const raw pointer to Object.
+    /// This is preferrable to `as_object_mut_ptr()` if a C
+    /// function only needs a `const Object *`.
+    pub fn as_object_ptr(&self) -> *const bindings::Object {
+        self.0.as_ptr().cast()
+    }
+}
+
+impl<'a, T: ObjectImpl> ParentInit<'a, T> {
+    /// Convert from a derived type to one of its parent types, which
+    /// have already been initialized.
+    ///
+    /// # Safety
+    ///
+    /// Structurally this is always a safe operation; the [`IsA`] trait
+    /// provides static verification trait that `Self` dereferences to `U` or
+    /// a child of `U`, and only parent types of `T` are allowed.
+    ///
+    /// However, while the fields of the resulting reference are initialized,
+    /// calls might use uninitialized fields of the subclass.  It is your
+    /// responsibility to avoid this.
+    pub unsafe fn upcast<U: ObjectType>(&self) -> &'a U
+    where
+        T::ParentType: IsA<U>,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait;
+        // the parent has been initialized before `instance_init `is called
+        unsafe { &*(self.0.as_ptr().cast::<U>()) }
+    }
+
+    /// Convert from a derived type to one of its parent types, which
+    /// have already been initialized.
+    ///
+    /// # Safety
+    ///
+    /// Structurally this is always a safe operation; the [`IsA`] trait
+    /// provides static verification trait that `Self` dereferences to `U` or
+    /// a child of `U`, and only parent types of `T` are allowed.
+    ///
+    /// However, while the fields of the resulting reference are initialized,
+    /// calls might use uninitialized fields of the subclass.  It is your
+    /// responsibility to avoid this.
+    pub unsafe fn upcast_mut<U: ObjectType>(&mut self) -> &'a mut U
+    where
+        T::ParentType: IsA<U>,
+    {
+        // SAFETY: soundness is declared via IsA<U>, which is an unsafe trait;
+        // the parent has been initialized before `instance_init `is called
+        unsafe { &mut *(self.0.as_mut_ptr().cast::<U>()) }
+    }
+}
+
+impl<T> Deref for ParentInit<'_, T> {
+    type Target = MaybeUninit<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl<T> DerefMut for ParentInit<'_, T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        self.0
+    }
+}
+
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut bindings::Object) {
     let mut state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
-- 
2.49.0


