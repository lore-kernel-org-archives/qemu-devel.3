Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98054E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1Q-0003wf-5t; Mon, 09 Dec 2024 07:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1O-0003vN-AT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1M-0007RP-An
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KnA6nxj6wRieH/eonLUIy1D83UK4FyVWaqyO6ZnPKE=;
 b=dD2I905alHuZIa0spzNH5tDj3kw3lfegu2KN46OV83FDi7H3X2G/1VrZS+RYtTgF0hAP08
 HPoKjX8MhnEw5liiFXOVZQZUzhZKRE8CtbaVBkgjNg6e21aNeXu15cgtUR6XuVwHcExhLm
 /h4cXPjfyi6KjK3X9pIhZCNa4EIffEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-5c8j9pdjN1ugjvp4kixtPA-1; Mon, 09 Dec 2024 07:37:45 -0500
X-MC-Unique: 5c8j9pdjN1ugjvp4kixtPA-1
X-Mimecast-MFC-AGG-ID: 5c8j9pdjN1ugjvp4kixtPA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434fe2b605eso2636015e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747864; x=1734352664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KnA6nxj6wRieH/eonLUIy1D83UK4FyVWaqyO6ZnPKE=;
 b=OqCJXrvJ9iQOJBA01VlOZfgWm8H7lwZi8T8P4CseJ00A+lsH4qoYjfXJUfHe5hGCEQ
 LLVysGzMyjATgvhaHpyFMqnj3qn9O4hvkfzUadbIZOROZ0yZOxeZ+MFjtXI9QYQUD/Dq
 D6VcbYnHKrDL4ZsYgVyRg8XH4k/SKYOeGGYONbV7VckaNEExWurWEY7+lKObfXx3LUgQ
 aGHZHVNqxuM6mOWJwVRt3SOGrog9Z+hn6/3cqHK4COYlZKhH7H4OLd+7QPikYISJ0KVH
 vzvWCvRnWZzfQzo76Zzsiv93zC1R9IyV5FBHy21RCJ9HKP1oVVkYabK+GtDle5bZj5a+
 A2iA==
X-Gm-Message-State: AOJu0YwxS/ETdZmYwGbQ67+nEqFWlohLYOpLwdtmjUP7TfKiYMi8UMGL
 PlE/kHC+/V3i0RCI1xXKT0kx/EuPZ9CiLbyu5ygPDfQQQ6eIafvE4A2/CF+CaaeD65V4yZCrVuW
 uiD+hYoSg2PeHjWJAxbVz8dSJQ8nPQduhy3qHsk551uqn2/2OlCEkmnPFJASi3lOAXfaQVR8mWD
 BtXYAFY8EPNf/xGyXXnHrPitb5ee4nhZzks9sh
X-Gm-Gg: ASbGncuGgqjLQScWXPimMER25O84riVzlfRO6zAmHhvdFWfe0AvWiQquvWZN2LhZBWe
 cu8+h5sTQVo0V+piOIAr9umZSuSaR/qUIa0lqwVp4X0EXk+z1YarL8eliojLzNb9e15oPbxyzS8
 L+/nplN8mHEPUSQL/HxuNf9pYRwc4BJyQyaQcGXjYnoJ6TInTHs7hKx3KambPtNPW7iq9i798rO
 T7UBZZOuNncQDPkqbeNOlWEUhScNUpz4uxodQSDeO9E+UGQfiXt9A==
X-Received: by 2002:a05:600c:4447:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-434fffa2a31mr2416485e9.24.1733747862537; 
 Mon, 09 Dec 2024 04:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEAVQBoTp9SPcNz6rRg1uImK74hwNwwXWayI3C2hJkGn6J5hBPTMiDx3R2ecMnTcnDOHcz/g==
X-Received: by 2002:a05:600c:4447:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-434fffa2a31mr2416285e9.24.1733747862149; 
 Mon, 09 Dec 2024 04:37:42 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f7160599sm43836515e9.23.2024.12.09.04.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 09/26] rust: qom: convert type_info! macro to an associated
 const
Date: Mon,  9 Dec 2024 13:37:00 +0100
Message-ID: <20241209123717.99077-10-pbonzini@redhat.com>
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

type_info! is only used in the definition of ObjectImpl::TYPE_INFO, and
in fact in all of them.  Pull type_info!'s definition into the ObjectImpl
trait, thus simplifying the external interface of qemu_api::definitions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 ++--
 rust/qemu-api/src/definitions.rs | 50 ++++++++++++++------------------
 rust/qemu-api/tests/tests.rs     |  1 -
 3 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bd12067aaf0..bcb146c24d6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -106,7 +106,6 @@ pub struct PL011State {
 
 impl ObjectImpl for PL011State {
     type Class = PL011Class;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
@@ -149,7 +148,7 @@ unsafe fn init(&mut self) {
                 addr_of_mut!(*self).cast::<Object>(),
                 &PL011_OPS,
                 addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_INFO.name,
+                Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
             sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
@@ -598,7 +597,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
     chr: *mut Chardev,
 ) -> *mut DeviceState {
     unsafe {
-        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
+        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_NAME.as_ptr());
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
         qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
@@ -660,7 +659,6 @@ impl qemu_api::definitions::ClassInitImpl for PL011LuminaryClass {
 
 impl ObjectImpl for PL011Luminary {
     type Class = PL011LuminaryClass;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_luminary_init);
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 3291f4242ce..6ecfaf51b09 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -9,15 +9,34 @@
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl {
-    type Class;
-    const TYPE_INFO: TypeInfo;
+pub trait ObjectImpl: Sized {
+    type Class: ClassInitImpl;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
     const ABSTRACT: bool = false;
     const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
     const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
+
+    const TYPE_INFO: TypeInfo = TypeInfo {
+        name: Self::TYPE_NAME.as_ptr(),
+        parent: if let Some(pname) = Self::PARENT_TYPE_NAME {
+            pname.as_ptr()
+        } else {
+            core::ptr::null_mut()
+        },
+        instance_size: core::mem::size_of::<Self>(),
+        instance_align: core::mem::align_of::<Self>(),
+        instance_init: Self::INSTANCE_INIT,
+        instance_post_init: Self::INSTANCE_POST_INIT,
+        instance_finalize: Self::INSTANCE_FINALIZE,
+        abstract_: Self::ABSTRACT,
+        class_size: core::mem::size_of::<Self::Class>(),
+        class_init: <Self::Class as ClassInitImpl>::CLASS_INIT,
+        class_base_init: <Self::Class as ClassInitImpl>::CLASS_BASE_INIT,
+        class_data: core::ptr::null_mut(),
+        interfaces: core::ptr::null_mut(),
+    };
 }
 
 /// Trait used to fill in a class struct.
@@ -83,28 +102,3 @@ extern "C" fn ctor_fn() {
         }
     };
 }
-
-#[macro_export]
-macro_rules! type_info {
-    ($t:ty) => {
-        $crate::bindings::TypeInfo {
-            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
-            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
-                pname.as_ptr()
-            } else {
-                ::core::ptr::null_mut()
-            },
-            instance_size: ::core::mem::size_of::<$t>(),
-            instance_align: ::core::mem::align_of::<$t>(),
-            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
-            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
-            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
-            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
-            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_INIT,
-            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::ClassInitImpl>::CLASS_BASE_INIT,
-            class_data: ::core::ptr::null_mut(),
-            interfaces: ::core::ptr::null_mut(),
-        };
-    }
-}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 704c63c846f..7f9df348b00 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -55,7 +55,6 @@ pub struct DummyClass {
 
     impl ObjectImpl for DummyState {
         type Class = DummyClass;
-        const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
         const TYPE_NAME: &'static CStr = c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
     }
-- 
2.47.1


