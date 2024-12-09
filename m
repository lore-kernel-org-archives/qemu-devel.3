Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C0CE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd4w-0007Xz-1e; Mon, 09 Dec 2024 07:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1k-00046U-G0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1f-0007WQ-Mz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AU4cR1A44Kzwr9V6X5ZqvFDrGfSGtRe4ER0j2E/bzHc=;
 b=WfIha0+FuM2La1Jkvty9/+FH/Es4h0ZSZo2alf5lWIBAuKUjdMS6o4b2yi07w2pu2WZZTn
 GWrrZQ2U6CVQNPTDJcqjyyjr4nrnUrx4ILHV4SIOT36edtm9pQ/QEtx9tOReykFjkTKbsI
 IcsirJt31P5nm1vdYT8LgNtNm4OCW0s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Cb_NfbdzOEC58wcGq7gr8g-1; Mon, 09 Dec 2024 07:38:08 -0500
X-MC-Unique: Cb_NfbdzOEC58wcGq7gr8g-1
X-Mimecast-MFC-AGG-ID: Cb_NfbdzOEC58wcGq7gr8g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f2cb3b4bso11475305e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747886; x=1734352686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU4cR1A44Kzwr9V6X5ZqvFDrGfSGtRe4ER0j2E/bzHc=;
 b=Y6/DInLIrpshlbAYcz0n3XU2jvcUTBuElZq9nyOw4dAM10nN2r9Hw+DK+6W4ke3Lk2
 X87IfxRlzA6696E021XbFiCnRp5DNTl5mmLFWnBptWwcd1+M2aQy3VhxAJ1cC/bGPp+y
 tV7jCV+gC76cAqwX4/DIWFZ1Oi73F2H4u/oweHxA05mlkwOoda/T3q2nSh9PmVQ6DwMt
 3BNvFJsBAjA90LDp5KA78hKoSKoOMSI0dOjJ7zePW9aUMFSPiuZhKdoAPNNyl0qHXnmr
 Oyv2vi/AXWT7rjrbbSAXAD2Fv5w+hZbqmqEBJlypNgInLliJ7d7uBLTDJ/eWBAR3y9a+
 /lXQ==
X-Gm-Message-State: AOJu0Yw+2YbbAsRHImRfZd/R4b8TPJMMqosD9Yyns4x6IJYRXTVPlw16
 HTlH9pg/MnFLsYUMaAb4+6jJhOOvuqaqLpy9ooBz0EmeZSiVXrm6RIFBzItMqunW9IY3ffBqK4v
 GYjxBjl6BEOpFOTpaRvFRUHZNhSbOGAhAi1n18n444A6wSx9FeyKjqQob1dYZxVC6iJawSYHVJ9
 vA4aSPERp6kaouyDhUOWRUzPIEvIswrcy9i7ib
X-Gm-Gg: ASbGnctDoF5iLxFodiWAxVnlvDfrCom2AX2HnENBK0dhRh5CklMFLVpHqbK+l7XGv5m
 2CC9jXhOj0JBDvbCeDFnCQkNzaLjHyxh0pRPvHMudOMMXINSSnZcKiHuxo4ygcu3wVDUc8hCrck
 qmcFxLfwpkS7wRdWAw8mz8Q08toIc5rFeMyqsqLJZ6pRjQqLMdy0qn30iEzyCC9ynd5hgbxFtNe
 XtabiOWLH8iHja036FiUn8DhVTCpf9c9QW9ZaT5N/sQ5Uqj/fF57Q==
X-Received: by 2002:a05:600c:1e12:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-434fd153f18mr13117025e9.25.1733747886153; 
 Mon, 09 Dec 2024 04:38:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH792a2/w5pAGOwu2vIm8ipECAnESvUp2uFmPmy4nFPNNnT/IKjgVfrNZbB+CwJ2RXP4mmUZQ==
X-Received: by 2002:a05:600c:1e12:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-434fd153f18mr13116705e9.25.1733747885593; 
 Mon, 09 Dec 2024 04:38:05 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d43b8557sm130234165e9.1.2024.12.09.04.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 19/26] rust: rename qemu-api modules to follow C code a bit
 more
Date: Mon,  9 Dec 2024 13:37:10 +0100
Message-ID: <20241209123717.99077-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

A full match would mean calling them qom::object and hw::core::qdev.  For now,
keep the names shorter but still a bit easier to find.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs              |  4 +-
 rust/qemu-api-macros/src/lib.rs               |  2 +-
 rust/qemu-api/meson.build                     |  5 +-
 rust/qemu-api/src/lib.rs                      |  5 +-
 rust/qemu-api/src/module.rs                   | 43 +++++++++++
 rust/qemu-api/src/prelude.rs                  |  2 +-
 .../qemu-api/src/{device_class.rs => qdev.rs} |  4 +-
 rust/qemu-api/src/{definitions.rs => qom.rs}  | 74 +++++++++----------
 rust/qemu-api/src/sysbus.rs                   |  2 +-
 rust/qemu-api/tests/tests.rs                  |  5 +-
 10 files changed, 92 insertions(+), 54 deletions(-)
 create mode 100644 rust/qemu-api/src/module.rs
 rename rust/qemu-api/src/{device_class.rs => qdev.rs} (97%)
 rename rust/qemu-api/src/{definitions.rs => qom.rs} (83%)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index d9e9f35f456..3fed8b4ad25 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -11,10 +11,10 @@
 use qemu_api::{
     bindings::{self, *},
     c_str,
-    definitions::ObjectImpl,
-    device_class::DeviceImpl,
     irq::InterruptSource,
     prelude::*,
+    qdev::DeviceImpl,
+    qom::ObjectImpl,
 };
 
 use crate::{
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index cf99ac04b8f..74a8bc7503e 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -40,7 +40,7 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     let expanded = quote! {
         ::qemu_api::module_init! {
             MODULE_INIT_QOM => unsafe {
-                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
+                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
         }
     };
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index adcee661150..7ff408ad68e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -19,11 +19,12 @@ _qemu_api_rs = static_library(
       'src/bitops.rs',
       'src/cell.rs',
       'src/c_str.rs',
-      'src/definitions.rs',
-      'src/device_class.rs',
       'src/irq.rs',
+      'src/module.rs',
       'src/offset_of.rs',
       'src/prelude.rs',
+      'src/qdev.rs',
+      'src/qom.rs',
       'src/sysbus.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 9e007e16354..124bece0449 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -15,10 +15,11 @@
 pub mod bitops;
 pub mod c_str;
 pub mod cell;
-pub mod definitions;
-pub mod device_class;
 pub mod irq;
+pub mod module;
 pub mod offset_of;
+pub mod qdev;
+pub mod qom;
 pub mod sysbus;
 pub mod vmstate;
 pub mod zeroable;
diff --git a/rust/qemu-api/src/module.rs b/rust/qemu-api/src/module.rs
new file mode 100644
index 00000000000..fa5cea3598f
--- /dev/null
+++ b/rust/qemu-api/src/module.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Macro to register blocks of code that run as QEMU starts up.
+
+#[macro_export]
+macro_rules! module_init {
+    ($type:ident => $body:block) => {
+        const _: () = {
+            #[used]
+            #[cfg_attr(
+                not(any(target_vendor = "apple", target_os = "windows")),
+                link_section = ".init_array"
+            )]
+            #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
+            #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+            pub static LOAD_MODULE: extern "C" fn() = {
+                extern "C" fn init_fn() {
+                    $body
+                }
+
+                extern "C" fn ctor_fn() {
+                    unsafe {
+                        $crate::bindings::register_module_init(
+                            Some(init_fn),
+                            $crate::bindings::module_init_type::$type,
+                        );
+                    }
+                }
+
+                ctor_fn
+            };
+        };
+    };
+
+    // shortcut because it's quite common that $body needs unsafe {}
+    ($type:ident => unsafe $body:block) => {
+        $crate::module_init! {
+            $type => { unsafe { $body } }
+        }
+    };
+}
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 1b8677b2d9a..5cc41f081f9 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,4 +7,4 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
-pub use crate::definitions::ObjectType;
+pub use crate::qom::ObjectType;
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/qdev.rs
similarity index 97%
rename from rust/qemu-api/src/device_class.rs
rename to rust/qemu-api/src/qdev.rs
index 285dfe582c7..1228dabaaaf 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -2,12 +2,14 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+//! Bindings to create devices and access device functionality from Rust.
+
 use std::ffi::CStr;
 
 use crate::{
     bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
-    definitions::ClassInitImpl,
     prelude::*,
+    qom::ClassInitImpl,
     zeroable::Zeroable,
 };
 
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/qom.rs
similarity index 83%
rename from rust/qemu-api/src/definitions.rs
rename to rust/qemu-api/src/qom.rs
index 958ea34decc..9b316e07efa 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -2,7 +2,37 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-//! Definitions required by QEMU when registering a device.
+//! Bindings to access QOM functionality from Rust.
+//!
+//! This module provides automatic creation and registration of `TypeInfo`
+//! for classes that are written in Rust, and mapping between Rust traits
+//! and QOM vtables.
+//!
+//! # Structure of a class
+//!
+//! A concrete class only needs a struct holding instance state. The struct must
+//! implement the [`ObjectType`] and [`IsA`] traits, as well as any `*Impl`
+//! traits provided by its superclasses.
+//!
+//! An abstract class will also provide a struct for instance data, with the
+//! same characteristics as for concrete classes, but it also needs additional
+//! components to support virtual methods:
+//!
+//! * a struct for instance data, with the same characteristics as for concrete
+//!   classes.
+//!
+//! * a struct for class data, for example `DeviceClass`. This corresponds to
+//!   the C "class struct" and holds the vtable that is used by instances of the
+//!   class and its subclasses. It must start with its parent's class struct.
+//!
+//! * a trait for virtual method implementations, for example `DeviceImpl`.
+//!   Child classes implement this trait to provide their own behavior for
+//!   virtual methods. The trait's methods take `&self` to access instance data.
+//!
+//! * an implementation of [`ClassInitImpl`], for example
+//!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct,
+//!   typically with wrappers that call into the
+//!   [`DeviceImpl`](crate::qdev::DeviceImpl) implementations.
 
 use std::{ffi::CStr, os::raw::c_void};
 
@@ -136,7 +166,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// Fortunately, this is almost never necessary.  Instead, the Rust
 /// implementation of methods will usually come from a trait like
-/// [`ObjectImpl`] or [`DeviceImpl`](crate::device_class::DeviceImpl).
+/// [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl).
 /// `ClassInitImpl` then can be provided by blanket implementations
 /// that operate on all implementors of the `*Impl`* trait.  For example:
 ///
@@ -162,7 +192,7 @@ pub trait ClassInitImpl<T> {
     /// can change them to override virtual methods of a parent class.
     ///
     /// The virtual method implementations usually come from another
-    /// trait, for example [`DeviceImpl`](crate::device_class::DeviceImpl)
+    /// trait, for example [`DeviceImpl`](crate::qdev::DeviceImpl)
     /// when `T` is [`DeviceClass`](crate::bindings::DeviceClass).
     ///
     /// On entry, `klass`'s parent class is initialized, while the other fields
@@ -174,44 +204,6 @@ pub trait ClassInitImpl<T> {
     fn class_init(klass: &mut T);
 }
 
-#[macro_export]
-macro_rules! module_init {
-    ($type:ident => $body:block) => {
-        const _: () = {
-            #[used]
-            #[cfg_attr(
-                not(any(target_vendor = "apple", target_os = "windows")),
-                link_section = ".init_array"
-            )]
-            #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
-            #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-            pub static LOAD_MODULE: extern "C" fn() = {
-                extern "C" fn init_fn() {
-                    $body
-                }
-
-                extern "C" fn ctor_fn() {
-                    unsafe {
-                        $crate::bindings::register_module_init(
-                            Some(init_fn),
-                            $crate::bindings::module_init_type::$type,
-                        );
-                    }
-                }
-
-                ctor_fn
-            };
-        };
-    };
-
-    // shortcut because it's quite common that $body needs unsafe {}
-    ($type:ident => unsafe $body:block) => {
-        $crate::module_init! {
-            $type => { unsafe { $body } }
-        }
-    };
-}
-
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer that
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 5d15b317405..fa69cadd7c1 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -9,9 +9,9 @@
 use crate::{
     bindings::{self, DeviceClass},
     cell::bql_locked,
-    definitions::ClassInitImpl,
     irq::InterruptSource,
     prelude::*,
+    qom::ClassInitImpl,
 };
 
 unsafe impl ObjectType for SysBusDevice {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 4ce1bd19247..fc57eb81290 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -7,10 +7,9 @@
 use qemu_api::{
     bindings::*,
     c_str, declare_properties, define_property,
-    definitions::ObjectImpl,
-    device_class::DeviceImpl,
-    impl_device_class,
     prelude::*,
+    qdev::DeviceImpl,
+    qom::ObjectImpl,
     zeroable::Zeroable,
 };
 
-- 
2.47.1


