Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FC1E77181
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1T-0003yh-Au; Mon, 09 Dec 2024 07:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1O-0003wP-Sh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1F-0007QW-Pt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2ZIv/PAvz3komJwq6oypf8CScK5YKxPKfhuCNRvYs8=;
 b=A/lsY9wBaT4SRVdI5JgEFcBMayNnbcwJS3ZgMEqCUpRNgZDcZEFRvNmCAHHZJQxCkHC4bL
 PCPtrz3+YTgkz65KbLdGpxgvflOUNkKNM782eO3VdwsFqMDas6dpJZC2p3AhLfBoPzcwnx
 WNj3DsHgPlNqYIbGPYt2sPxfdQinYJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Q78XRElBOKGkjTW2D88B-Q-1; Mon, 09 Dec 2024 07:37:42 -0500
X-MC-Unique: Q78XRElBOKGkjTW2D88B-Q-1
X-Mimecast-MFC-AGG-ID: Q78XRElBOKGkjTW2D88B-Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434fff37885so669195e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747860; x=1734352660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2ZIv/PAvz3komJwq6oypf8CScK5YKxPKfhuCNRvYs8=;
 b=ANOhALfNe11R6ustUKKSubEfplZSXR3RsrcMO9YBtEdiBbCWrngrQ/ra2/cVje07Dm
 9TX+mbmKMMo5JBrOzSeEm8npqRTqTOTgd6Ghkv76r7xpsk/oVgwF4704M4pm/Jl8V7w7
 FOrNkQ9AWBsVoC7r0IjuieO4McrXg5zgmyKfZp1c+5E8JZQkJY7tfNIVNhXxc7E66oe2
 WAL33SzIjeqc/tIxEz5k0JOv6iVnfuPqRqfvsJ1kSXIQhiutUfLBI7ci9u+1CZEUMY8y
 TNXKa2fkv0Ef42EnjQiRPFxzlFzOj9zXqommQnIVcOv4L8I8j1tw+gUcI4jfDrWRhVAK
 bnZw==
X-Gm-Message-State: AOJu0YzWf/UuXwSLyXWLRwGrieyn4jUU2b1rPQZol+vuN3g1urODoBIw
 ggCQvt9/9h9fkKWQCf7udWoimFU8YxopRNRV1U99m+TZZQcWtjM93ylhe3zrfb64Vt7BMBBDCe4
 8OgTs2d1RHtVvLiG45wGVD8rYfNnLLqY9bsXyhLHzYpGp/aVMxJGJHxm4+iZ9dYZv7Ax3ao69sr
 cMIIvh/9ESfPCOvyI1Z+w+x3Tzr7m4uqZwAnxy
X-Gm-Gg: ASbGncuqobaS1cy4koZsmsVqJCsnb/bQw8Q9+UzaTapIEaDQkfkqm/kAvICnijG4gsl
 QTf4hgqsqI1/orBVXH9XBXwn/Ctm7MZnNd8bRtuKD2RLyAl7gNpjyFTLsq3PIeC4jNSa8kOZIf5
 fFsUDP/0+sMAvq+0rhjw/iX96yljf3uNwM60WbAFGfY2v0XEspZoR+Jiz204jYY/z9x9tZtr5mg
 OEqSlzJ+DKVRzM2VfbWN8BWcEjsnDnZBqf1CBGy8CEtAUw73CTwdQ==
X-Received: by 2002:a05:600c:5108:b0:434:a7b6:10e0 with SMTP id
 5b1f17b1804b1-434fff80a6cmr2781205e9.18.1733747859810; 
 Mon, 09 Dec 2024 04:37:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTzrWqUo1UrlDef9gTX0dvO1xC+x7VjkryApIESqwOJvaVHc0eFXP98N3waTQkkhIbvtJ4BQ==
X-Received: by 2002:a05:600c:5108:b0:434:a7b6:10e0 with SMTP id
 5b1f17b1804b1-434fff80a6cmr2780875e9.18.1733747859365; 
 Mon, 09 Dec 2024 04:37:39 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d69dfsm153106035e9.14.2024.12.09.04.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 08/26] rust: qom: rename Class trait to ClassInitImpl
Date: Mon,  9 Dec 2024 13:36:59 +0100
Message-ID: <20241209123717.99077-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

While at it, document it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  4 ++--
 rust/qemu-api/src/definitions.rs | 25 ++++++++++++++++++++++---
 rust/qemu-api/tests/tests.rs     |  4 ++--
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 3d173ae816d..bd12067aaf0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -117,7 +117,7 @@ pub struct PL011Class {
     _inner: [u8; 0],
 }
 
-impl qemu_api::definitions::Class for PL011Class {
+impl qemu_api::definitions::ClassInitImpl for PL011Class {
     const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
         Some(crate::device_class::pl011_class_init);
     const CLASS_BASE_INIT: Option<
@@ -650,7 +650,7 @@ pub struct PL011LuminaryClass {
     }
 }
 
-impl qemu_api::definitions::Class for PL011LuminaryClass {
+impl qemu_api::definitions::ClassInitImpl for PL011LuminaryClass {
     const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
         None;
     const CLASS_BASE_INIT: Option<
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 92b3c6f9118..3291f4242ce 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -20,8 +20,27 @@ pub trait ObjectImpl {
     const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
 }
 
-pub trait Class {
+/// Trait used to fill in a class struct.
+///
+/// Each QOM class that has virtual methods describes them in a
+/// _class struct_.  Class structs include a parent field corresponding
+/// to the vtable of the parent class, all the way up to [`ObjectClass`].
+/// Each QOM type has one such class struct.
+///
+/// The Rust implementation of methods will usually come from a trait
+/// like [`ObjectImpl`].
+pub trait ClassInitImpl {
+    /// Function that is called after all parent class initialization
+    /// has occurred.  On entry, the virtual method pointers are set to
+    /// the default values coming from the parent classes; the function
+    /// can change them to override virtual methods of a parent class.
     const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
+
+    /// Called on descendent classes after all parent class initialization
+    /// has occurred, but before the class itself is initialized.  This
+    /// is only useful if a class is not a leaf, and can be used to undo
+    /// the effects of copying the contents of the parent's class struct
+    /// to the descendants.
     const CLASS_BASE_INIT: Option<
         unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     >;
@@ -82,8 +101,8 @@ macro_rules! type_info {
             instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
             abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
             class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
-            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
-            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
+            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_INIT,
+            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_BASE_INIT,
             class_data: ::core::ptr::null_mut(),
             interfaces: ::core::ptr::null_mut(),
         };
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index f793ff26e5d..704c63c846f 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -7,7 +7,7 @@
 use qemu_api::{
     bindings::*,
     c_str, declare_properties, define_property,
-    definitions::{Class, ObjectImpl},
+    definitions::{ClassInitImpl, ObjectImpl},
     device_class, device_class_init,
     zeroable::Zeroable,
 };
@@ -60,7 +60,7 @@ impl ObjectImpl for DummyState {
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
     }
 
-    impl Class for DummyClass {
+    impl ClassInitImpl for DummyClass {
         const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
             Some(dummy_class_init);
         const CLASS_BASE_INIT: Option<
-- 
2.47.1


