Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5461C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibeq-0000vu-Vg; Thu, 13 Feb 2025 11:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeU-0000pv-Qf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeR-0005SQ-7G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJKsboCr/rz3b2EwIlGZQLj7iVI/rClT9i/wfrBfAQo=;
 b=g4VgqoMUvBIy7yO+lSvwgjAqoPpdP2tJ6w8++pwL4+uJXe4WxIZSGHzeXwEfbCoWRICDxP
 PptYD6sv8+X8QDNreRlP1FRW+8JtyQdUfTjtzKkYd6nQAaIVH1YmQnoWCihugHA0kMFZNn
 ghpnedpXjV4XuEMEbYNqgd6TYTgbCVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-cN9ZZz2ZPtGDHb5iij73hg-1; Thu, 13 Feb 2025 11:01:15 -0500
X-MC-Unique: cN9ZZz2ZPtGDHb5iij73hg-1
X-Mimecast-MFC-AGG-ID: cN9ZZz2ZPtGDHb5iij73hg_1739462474
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso8356655e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462473; x=1740067273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJKsboCr/rz3b2EwIlGZQLj7iVI/rClT9i/wfrBfAQo=;
 b=qkQ40+zvVe066GdnFq1Twk2g20AZhexutJWxw5nif4DZnsFfDWzQjYSJt6fOchVOP3
 UNR5V4IrhVD/Pv6UqM3J+lxsCMPJ47aiophkDhm9XP2Ql593bgAvtEC3liKnS5fydWUb
 GMrdnMGyI/c6jQKtOjPJOlZ/IA05ApyWB+oqN9IghlPrOPOnzQH466ZVTdgSwPen83TX
 OXXEVl5R67jR8WUjdO900rt2Nc9eiVnHx0OiuRFWwqegHAgN2UbPkAO5nCfDZRAy14Wy
 SAgX7kKIN3x1Pp3+iwvbh9lUIpA2dof0RV90z9wfy98TYTx8+1Ie/+O272Ocyc8g1i4V
 XLyQ==
X-Gm-Message-State: AOJu0YyJsjU7nFJADCChUXmvdiqNGzjo6p5rD4KPRQdnYDqZus+n9MWc
 oRiQSa3geHHXdHEET4fjSlkhzB2CVR1rpnVv9r2Un0eXHzpjjHqu73yDsqHmP6UFxmad/JUBfI6
 nONrJw6HVGX8ZgEotGLqez0FpVwYPnRZweutGHDqflqqv76yqhTMPSHqfMV3Lkmr/kOoEtbpQAb
 4eujITzZAnsIubqZ/viJA6rP6UaxIv01U3zMQf53U=
X-Gm-Gg: ASbGncsTUZZC8nY+v6uBacrYU5JeUZV0CIL/TYiVoWyfcCJb9ZcHonxVDsCLybsKpub
 6lFh8R07qxRX8rx7TiMi+a2LQ5c6kGoixdAIhy9fp6c/Wdw6rpA8VBKgO719Jqj6WanI9nVz707
 5ZPxso1nuOy/X5dBuXjl2fUPRFC/Pa4r1GXu3vKSEnBWJcJEaYIOgkqZewmEYHo6UF1Uchb4XFT
 Gbs7DncrxFVhVVsXgU54lwIyU/BcWzLZmVtbUFTAQwU06XA9PW5a7ELjfyqJkAE/UVSBxkQjT41
 PVRvgFnvbR3qVgAoJblLBY3B3Fs89i1IdAlN0fW1WLaj2Q==
X-Received: by 2002:a05:600c:c8c:b0:439:31e0:d9a4 with SMTP id
 5b1f17b1804b1-4396018a6ccmr56667245e9.10.1739462472874; 
 Thu, 13 Feb 2025 08:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRHUW8qwvjg/1btvDVyIM03bqYSZSR0qlQmqgXiFpx3SPgXfRfBHXL6+K61nXB+LRTqcPg0g==
X-Received: by 2002:a05:600c:c8c:b0:439:31e0:d9a4 with SMTP id
 5b1f17b1804b1-4396018a6ccmr56665135e9.10.1739462470816; 
 Thu, 13 Feb 2025 08:01:10 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961885077sm21118335e9.25.2025.02.13.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/27] rust: qom: allow initializing interface vtables
Date: Thu, 13 Feb 2025 17:00:33 +0100
Message-ID: <20250213160054.3937012-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index 3e63cb30ca6..3d5ab2d9018 100644
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


