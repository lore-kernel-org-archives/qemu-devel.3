Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3126CD3B7E7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFU6D-0004pw-9T; Mon, 25 Nov 2024 03:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU63-0004ni-M1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFU60-0007Hs-N2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732521920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQhR97xfSSLWGt+89NRShLRBPBcpvzkoM5n21YvipV0=;
 b=goHs06QSuMUqYVfk4UMtvRq+xCkxyGL59z+180/LZLzlP4HsWH8FK20OHejr0t6zaEBn0o
 bB/CCaPpW//FSWJ3/HAm+T0bkKKnXPQj+GD/ZHcgd45lJUPe6y2eQJYcWFYAenHojRDd33
 Vt/hxZtGcCHcMGcEmLfRj8LbicC/Wgw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-oVO7hjaLNU69AH-TJ8wkFg-1; Mon, 25 Nov 2024 03:05:17 -0500
X-MC-Unique: oVO7hjaLNU69AH-TJ8wkFg-1
X-Mimecast-MFC-AGG-ID: oVO7hjaLNU69AH-TJ8wkFg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38231e6b4cbso3171846f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 00:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732521915; x=1733126715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQhR97xfSSLWGt+89NRShLRBPBcpvzkoM5n21YvipV0=;
 b=TwapgLhJIPnx6BoVjoDkYI/mvi+ZGOa7WyIaXI9frEMpiR/090csaO3mQj5adGTUSB
 KUqy9r9+xgTBd0aa9XKv7NnZnp8rYN6B3RJysxmoUpDQgT5GS452aePg4QgxoHGj7wwk
 2kwZVZGHaCS4uJaawFr+axUylZBjETrTDkSgcQO+wI3cwneTzbJJFjh9O5uNpYLXB9mg
 OWqwA86ZmWbaPFjhp5m9aSJHwZCFfK8kLvZF/L5vzTrNASVsr8+/2ljELVdkTbLpRtOX
 WvnV2/DdILr4D7guswwfSBtp2C+VreUHrgES9UQLl01w+xWnlH8UUV8Mk/4Gg1w58c5u
 zNbA==
X-Gm-Message-State: AOJu0YzuBfXEV0ecDTk1hKgWF5zj6kjoydqVuYoeE6vn9ozDN4zSHLi+
 UJuFWgoCtmdB7iDMDMmDkHPBsid4umbUtkEej9PFDX0k8A+IaVKRA+MJMIH87QaipIjSHpI1+YY
 B/G6rrfHKJFTPeNFKPFdzD0gztIIXaXV7lG9ZuJR/Nn3uXegYWzBmWvZfKiA8c6a6HTpcojU18U
 aPYW77ZC5ZUzk8JtQu/Syu4Q25pJ2jPT6A3qB0
X-Gm-Gg: ASbGncsvKCX19aZwZDChY/CKGvg4X8+GTeZ1Ia4iH72pSwsRGveswyqOnp+Yh53v4zg
 7RTH5FV8MCMmOYLfYLa3k3MvwXlKOjvsp0fVdTEKk0pd3c2Uv3DZvJSiJzTgtCskX7osqkROs1U
 5/GCY7GCpn9lWc/4FIpRAsY744B0g6hqluRw51sk6Hrx038CEtPd6XAivHhzr3opyrJ0IZcyWo1
 jzFpZaYhTzdzcG3XvUAAPRjOmWc6/v48sPdECR2XT9ow9YNjSv0CBc=
X-Received: by 2002:a5d:64e4:0:b0:382:4edb:19c7 with SMTP id
 ffacd0b85a97d-38260be676emr11625230f8f.54.1732521915528; 
 Mon, 25 Nov 2024 00:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+by0dU2iwf5y1vPGKGQKWOGXE4oXRIyDvEk2R/g0VnuYUlBUxcDgP9a4Y0uJK5Oyf1bFq1A==
X-Received: by 2002:a5d:64e4:0:b0:382:4edb:19c7 with SMTP id
 ffacd0b85a97d-38260be676emr11625192f8f.54.1732521914995; 
 Mon, 25 Nov 2024 00:05:14 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad641fsm9590466f8f.20.2024.11.25.00.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:05:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/8] rust: qom: rename Class trait to ClassInitImpl
Date: Mon, 25 Nov 2024 09:05:01 +0100
Message-ID: <20241125080507.115450-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125080507.115450-1-pbonzini@redhat.com>
References: <20241125080507.115450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

While at it, document it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  4 ++--
 rust/qemu-api/src/definitions.rs | 25 ++++++++++++++++++++++---
 rust/qemu-api/tests/tests.rs     |  4 ++--
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f47e0f48d8a..763605d4776 100644
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
2.47.0


