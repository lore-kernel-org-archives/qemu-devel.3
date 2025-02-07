Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FABFC0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQ4-0007Ur-2q; Fri, 07 Feb 2025 05:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPv-0007Pf-HF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPu-0004Hc-2F
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8ugkz2MCTVi9k0wZ/H/gZ6hjpuLYxOLaMc5B1rAzi0=;
 b=cmqBMnWSdKLdmKXESraUkoraBDV7jfv/Ytal+oJlgfV/kg6Hv3lxQ1b566xC8p3zMaNFT1
 wKo8+H48h1yKI6A3hmYBVVaxSErreHWM6Shur5VNNj99iDgDntg+YdZjhSk4ZGEyi5vWxx
 Krxm9hZ2H1HnD1pq2Ut/Px6pPWcMk0g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-GS6K0KNGMhC6aO2VD5gKSw-1; Fri, 07 Feb 2025 05:16:56 -0500
X-MC-Unique: GS6K0KNGMhC6aO2VD5gKSw-1
X-Mimecast-MFC-AGG-ID: GS6K0KNGMhC6aO2VD5gKSw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab2e44dc9b8so312064666b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923413; x=1739528213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8ugkz2MCTVi9k0wZ/H/gZ6hjpuLYxOLaMc5B1rAzi0=;
 b=Xd3Y1l4/offFQ7GIkhQ8aj7yoPLWaVlyHVPOHplYAYf+6y7vMvFUH4nzOTLpPV8d1X
 lDkpI5P1JZJUGtSjSZ0gp5plBkYv4QJczfSy96LxtvS7v6oHuDiMwMXVce4XL3usaNaG
 i5r4eVDsCttLsbuuct+vE0Eb1x16iBkzdxtqW+8se/XZZ/rkmUsNXrGubpKJ2IY1GaSe
 DkCvTulU2NoWUvmFSHdW3T7LvtoAo7OwBhA1wC8KSmMg83JOCEUx7O8EjG6LVWK+hXwc
 6ImLMCcx/wPBUn+cDmBcY5JHdkPyuEpZWmjCi3X7HWXz8WJZa8mrfGFaPzSt7DVpMC1w
 afFg==
X-Gm-Message-State: AOJu0Yyc6SUyTiS0CFh19sd/9PMd41H9he/hHp6/LQplP50HIViZGlgh
 x6ZQ6bJ7ViN598afQzHAUpulfNcMDm08eoeCI1ndrwLBzYvQ7Wx0vWf32D2gUtbyFhwdyS/C43G
 engWCQ5vCU6FY/SlWKlEx36BsewyRgFjH/uhVvaxQW+vtGSUxIkygKQnmDu+OrzaDl8k0t4NKez
 QLlp3Mk6WnJjdcgTqUlTXJjWkasGsItH+NVIseRmY=
X-Gm-Gg: ASbGncu6A1S97fP1nC0ULYuUYmIP6hF8inAE54RXf0eDdUnMxfcoi3DWCf+x9PTJr0Q
 WBpbXAoC+Kqs/39314QFytPvWWD5hRYyOFW7phSU69cykrS614GrgNQ65AzlPAKkMSvsDqu7ZLM
 jJQrNOyYS8wtKAsumhzCjTjJ+36EuD+J/4Za1wJD46m1bBzfiqwV5id8UPiTpRQ280QVQhwAc7x
 ublC/JkQNRdl3qS7PX8GOWo4/cGYBcdWa2aQGwmwwqWhaiGcjf+vskjXF0WyoB68+aE7HEZLzn8
 GmSj6w==
X-Received: by 2002:a17:907:7e8c:b0:ab6:f782:3ee2 with SMTP id
 a640c23a62f3a-ab76e896c1cmr679681466b.9.1738923412914; 
 Fri, 07 Feb 2025 02:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM3lk2ydc7epwpkztg3w/h+v1br1TpLcOGK5HJ3x0fJvwRo4UJf6MhFQZ1H9LxVlL2Y6xFHw==
X-Received: by 2002:a17:907:7e8c:b0:ab6:f782:3ee2 with SMTP id
 a640c23a62f3a-ab76e896c1cmr679677266b.9.1738923412411; 
 Fri, 07 Feb 2025 02:16:52 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7732e7232sm241982766b.97.2025.02.07.02.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 05/12] rust: qom: allow initializing interface vtables
Date: Fri,  7 Feb 2025 11:16:16 +0100
Message-ID: <20250207101623.2443552-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
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

Unlike regular classes, interface vtables can only be obtained via
object_class_dynamic_cast.  Provide a wrapper that allows accessing
the vtable and pass it to a ClassInitImpl implementation, for example
ClassInitImpl<ResettableClass>.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/prelude.rs |  1 +
 rust/qemu-api/src/qom.rs     | 45 ++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 87e3ce90f26..254edb476dd 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -9,6 +9,7 @@
 
 pub use crate::qdev::DeviceMethods;
 
+pub use crate::qom::InterfaceType;
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index fad4759d7a6..fa69ae4c702 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -66,8 +66,8 @@
 
 use crate::{
     bindings::{
-        self, object_dynamic_cast, object_get_class, object_get_typename, object_new, object_ref,
-        object_unref, TypeInfo,
+        self, object_class_dynamic_cast, object_dynamic_cast, object_get_class,
+        object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::bql_locked,
 };
@@ -263,6 +263,47 @@ unsafe fn as_object_mut_ptr(&self) -> *mut Object {
     }
 }
 
+/// Trait exposed by all structs corresponding to QOM interfaces.
+/// Unlike `ObjectType`, it is implemented on the class type (which provides
+/// the vtable for the interfaces).
+///
+/// # Safety
+///
+/// `TYPE` must match the contents of the `TypeInfo` as found in the C code;
+/// right now, interfaces can only be declared in C.
+pub unsafe trait InterfaceType: Sized {
+    /// The name of the type, which can be passed to
+    /// `object_class_dynamic_cast()` to obtain the pointer to the vtable
+    /// for this interface.
+    const TYPE_NAME: &'static CStr;
+
+    /// Initialize the vtable for the interface; the generic argument `T` is the
+    /// type being initialized, while the generic argument `U` is the type that
+    /// lists the interface in its `TypeInfo`.
+    ///
+    /// # Panics
+    ///
+    /// Panic if the incoming argument if `T` does not implement the interface.
+    fn interface_init<
+        T: ObjectType + ClassInitImpl<Self> + ClassInitImpl<U::Class>,
+        U: ObjectType,
+    >(
+        klass: &mut U::Class,
+    ) {
+        unsafe {
+            // SAFETY: upcasting to ObjectClass is always valid, and the
+            // return type is either NULL or the argument itself
+            let result: *mut Self = object_class_dynamic_cast(
+                (klass as *mut U::Class).cast(),
+                Self::TYPE_NAME.as_ptr(),
+            )
+            .cast();
+
+            <T as ClassInitImpl<Self>>::class_init(result.as_mut().unwrap())
+        }
+    }
+}
+
 /// This trait provides safe casting operations for QOM objects to raw pointers,
 /// to be used for example for FFI. The trait can be applied to any kind of
 /// reference or smart pointers, and enforces correctness through the [`IsA`]
-- 
2.48.1


