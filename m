Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CFAE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPaK-0003R2-QS; Wed, 11 Dec 2024 11:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaE-00031Q-AC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPaC-0000ds-EF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KnA6nxj6wRieH/eonLUIy1D83UK4FyVWaqyO6ZnPKE=;
 b=iwCh8N/oh6wRsKYf/F9zv4/jZhCB+ITFMRcsneReZxA1zQCaPPDV6iBELeukf872Jzi0zr
 9PzQW47gsaaoQHSlG6LhPhj3VxGK2xL/dackV5OQWMl3qVGlWIyHYb/G99SKgUMknV7o7M
 OZk4/a6CL3CxqTDEn3i8NDWS9e0cYJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-pReGUimgPQOpmQ-O0F0hhw-1; Wed, 11 Dec 2024 11:29:02 -0500
X-MC-Unique: pReGUimgPQOpmQ-O0F0hhw-1
X-Mimecast-MFC-AGG-ID: pReGUimgPQOpmQ-O0F0hhw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so3755009f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934540; x=1734539340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KnA6nxj6wRieH/eonLUIy1D83UK4FyVWaqyO6ZnPKE=;
 b=aCzISkk7X/ETi05+BZEx54XwvtdNM56nbEOlncB6GF4axr7fKFVSsuLiiz8/tOV7P0
 t10x4xbHFbc9PYKVFKoallLtlZkHpeA5FYAfHY9abdknB3uXUerkt86Vw6wkLRnroK9J
 zeyB/3AAzpA9ZL6MEfFC1b5LLYbx7Ukqgdmdh34Y0owIJmJPMhKz5FeVWXngAIouDpSP
 GsRfuO8RzAz5VyMSMs8+rhFdRcOzhUnrdcKFIRYlWRUM9MO/sYcPB1/yZzeB4yCB21K5
 Rb0UHeT0cJScol73gLlXIS6hzkl1qAHjzuWHnNtEHFmJxINOAASXkfQ+w7DglhwUr6Zg
 NeQg==
X-Gm-Message-State: AOJu0Yx6cwJvYuPz8A4fF+wJzUouzxiboXlo1EJDcLMLkrzp919aj4w8
 adHueBhEuzSp/RY9PbXHPzSP6MtnnRE32pAz1cqcaQDVu2duJa/Za94MmLfUCN9SleuHyjh1Zj5
 O7weOG/pGs3fCxZdBleqKPIE7rboarwQJ2gudSOuRnb8M8Z8g9TN0a+ec3IvtDX4Z9OLhsdC9ni
 f3SgSX+IqBcTPErJuf7iQbE3B6AaWoPpGUK9Sr
X-Gm-Gg: ASbGnctnJ9/qPA/gYpyuUmVwQLOYSTsge8zWtWy93y1XSsPQoHY7HjlWTQgFtz5VlOD
 G3aaOE5xattPg0gjZGoI2+0mAeRI7CakEe6AR6HE4epL4tqfvJNb+2yUJELhNut5q7v2jYnQ4MX
 NBQAlXBJJZLMvvrBSDbVBSuncssKhmHoQY8XRzyMovfRKCzqCZAoi8dLZR9vNe5p5SV7cgjkP2x
 6Cz8EFg+AOj7ti/Xc2ajJhPpqJ00Af//Er5nyG6oroVPswzWHia0RdB
X-Received: by 2002:a05:6000:178b:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-3864cea04aamr3370659f8f.35.1733934540432; 
 Wed, 11 Dec 2024 08:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAQi60zHVnPa1mlyIjdUVJ/MZQ8K5xv5PogQnNt48xLS9Ds2sDhQOtYKyTMCJQ0w01u9Mwrw==
X-Received: by 2002:a05:6000:178b:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-3864cea04aamr3370638f8f.35.1733934539899; 
 Wed, 11 Dec 2024 08:28:59 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f566sm1672579f8f.1.2024.12.11.08.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/49] rust: qom: convert type_info! macro to an associated
 const
Date: Wed, 11 Dec 2024 17:27:13 +0100
Message-ID: <20241211162720.320070-44-pbonzini@redhat.com>
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


