Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55511E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaF-00038m-QW; Wed, 11 Dec 2024 11:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaC-0002mC-Cq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaA-0000dN-8N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2ZIv/PAvz3komJwq6oypf8CScK5YKxPKfhuCNRvYs8=;
 b=TNG+L+R5Z1E/nUFS29xUe6CMvSEaSIuLIgn3HTZFgha/2cBIm2LfGX/0kuE2dTYYiMrSKT
 QjaXfsDiOrk6OTFj19hScRA++WNPQrTN9C3ypwMvOVecCFKxZE9Ua+EaYAr6762y8/SKVd
 XVXPnL8IVdsIokgB+6q9oIXm1aMyqMI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZpyszVJ1ONeETWBfZTCnkQ-1; Wed, 11 Dec 2024 11:29:00 -0500
X-MC-Unique: ZpyszVJ1ONeETWBfZTCnkQ-1
X-Mimecast-MFC-AGG-ID: ZpyszVJ1ONeETWBfZTCnkQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so3047315f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934538; x=1734539338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2ZIv/PAvz3komJwq6oypf8CScK5YKxPKfhuCNRvYs8=;
 b=bDUMe+ZvATKcgMRGzz5n2NC9MPU4Ov6jL+LTQ00iyLdZWHa6QO7xqe2NGzx8sZNlNY
 /j+kUxTY8Fo80VhfHoNAP2+ggJTo3ImOaH6cn8fDZ4ddoLmSnpGF4cPYWJfmcQgnOW08
 sp2JdKFhYDaK4f6KHqvXHjszQE3AKW6uAhHU4SrHudOVir6czgQT9nKFQUHVTtqEmJEY
 squOuErEqqCdQ0mwW5kMnCoCbCsAasvQyHw8SLJs8ZywjOGuCU7bf/V8lan9vEHU01JM
 7pFk4LMy5zab4WqGxAuQ9297HQ8IJFr7QjWDQKvXMs/6pLmI+6gl0pTNo6u+bgB/ahnM
 FG8g==
X-Gm-Message-State: AOJu0YxdLkIYKk16/QDHSe7B2zsLOwZv0+PKuH4kRqS9VUc3+B/V4NdJ
 9U8m6G1JOeFx9WEpYFiyKPg3cM+eoJE4jjdCwF9dvVAOL54Id8gJIlbXV4xjscCsFNDqYpNfQjO
 u1jAdu5vNt5ASYPakknvE67zsjHXI/BxOuotf6CZiVGZK6vV17z1V+HxKr/Bam+qW7aNZJCUY8v
 Iwcmyqnlg3eDU/6wVqkC+o52GbFvbtBKLYqhdB
X-Gm-Gg: ASbGncuIdIpqKUBjbPzymL4+Sryof/ZYl52oP7QdxYCcNjyLZC3X/VXvzmZz9kqjsGp
 Dx9LCPy+HLEiDiaxLXccpgpZj47DNqPMw5uYIpwojuz6CMbvS3vQJN3Lt6ks+ao7B5bH2wIwf41
 8Vu8zZKUbmK56tgIJWYW48a92CRt0cgv10XOkmj7lzl4D/1pd3/pcGdoowdngd6Txy5lTI6V3f7
 jdyDhbgMgJHGsYGVgxe/5VL7y8ddcjWhqjUutROBCtgGmqZcgTBiJSN
X-Received: by 2002:a05:6000:2d06:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-3864ce54e99mr1855744f8f.18.1733934538511; 
 Wed, 11 Dec 2024 08:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzZEh0zfHQt0LE3ncM/wMXoifhf+IKYgNed+nSnYPzXI3DaqzXLzJCYZ/c7t2hWNpT95Riuw==
X-Received: by 2002:a05:6000:2d06:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-3864ce54e99mr1855721f8f.18.1733934537812; 
 Wed, 11 Dec 2024 08:28:57 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c1d7sm1606234f8f.91.2024.12.11.08.28.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] rust: qom: rename Class trait to ClassInitImpl
Date: Wed, 11 Dec 2024 17:27:12 +0100
Message-ID: <20241211162720.320070-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


