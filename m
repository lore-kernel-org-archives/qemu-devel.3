Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD4E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByR-0005eq-TX; Thu, 19 Dec 2024 03:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByP-0005bl-VI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByN-0005DZ-OX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daXIX4qhJQvUvabkI8ft1TwFgegwlmO6KSYPGJnvFVo=;
 b=NRX6zpMH1tqOWJUoJ7HywqlNq9VXj2vgIjnrJcLIU2ipTKi517P23uQjIrxiS9XkRqEWCw
 MYzCTqlnSfCXVWHGJ/wm5989aoMq9JGHW4QSTMgDxwUQxeTd7zbqtXaE3Tlq+i7bKjezkx
 LYimK4koKFnBIVSieLkHwgCwRfTgjGc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-MwOLdUcKPJa5PZATZA6B3A-1; Thu, 19 Dec 2024 03:33:29 -0500
X-MC-Unique: MwOLdUcKPJa5PZATZA6B3A-1
X-Mimecast-MFC-AGG-ID: MwOLdUcKPJa5PZATZA6B3A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso327437f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597207; x=1735202007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daXIX4qhJQvUvabkI8ft1TwFgegwlmO6KSYPGJnvFVo=;
 b=u91Q8CqH1PZU36LNX16Epheboof+koHzNtW8vmS2/+vfGK8UTBaJLI0Bh5WlIr6mDt
 Z/zodMZs0RBeBoEcqhjlSnSqXo3dps+t6wWv+iYWrg9dqbyhl2lItLGWUO5upwXbxk3H
 L3FiDxQ0eH2yxgX4kVOKXe8TyX9Gf8dYhB9rdaYaVvL5TW8TxrhQuZJlcE80ykzz9jDS
 eY/UwOr7zeOxDXQ+e+3Md5LSbjsQwcoPqTFoJQXXlKqmkesPMPbF7m+AUeLWPbo0Qs+I
 MoiihmuVSoT9A3JZdtELAVKs+883Efzn+cfU8+ff/Y6WLXEG3ZHRiDu+d2U/XQRHP+5x
 rdoQ==
X-Gm-Message-State: AOJu0YyhMaas6RTAPTro78f+rk1YYvC77ex817Nj7kUWv5jCQPvHcBkK
 JEsjkiVptyP7avWsSM7VegABNOexcXchq/e6GyC8SLCp1Dzn8IlSzmPU71dMJvmBn0a8ymxNgrJ
 qwjUZkUrJhyUBSMmWRyrHBUIxdo95bMVo7fxsp9Z6cSNxbdepQlUYJ81uq4uAznGDo8cGI1ho8M
 F0nJM4iOHvQf7KkwuX5riVjD+Fywv/FgLWm2Rd
X-Gm-Gg: ASbGncsyj/pQoXGG6uDXVebOXw3mj/HWzZpbbj3RvHaUBQvfml0OpBSQq0g/h/S7q5s
 1ZQ2up72m8ai19KVIXr1JvVcY3Cf/oiDLh5tDT8IltcgFfsBxkORoMZ3ESGF/kpcd9fAaw2Ourc
 cf59MjGWM2Hs+kwUwmOM9OkQVT+/WHmgTf5UU7Dyo3/RSezYTqXAqFVHc6jbc/3JFDGRpmUzZOQ
 kqBXg1tbTAdncj9OZUiU5VntJRBqvB9CDOhRv+M111ILXlaQYaVPNrWZO4H
X-Received: by 2002:a5d:648c:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a19b34d45mr2547362f8f.44.1734597206594; 
 Thu, 19 Dec 2024 00:33:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELv+0okT3YyluCSaV6T+pO+CmxsHf8UVXLFilooXvgj2/Y7XlN1meiK7tZIqCbxvoUSPj8uA==
X-Received: by 2002:a5d:648c:0:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-38a19b34d45mr2547313f8f.44.1734597206023; 
 Thu, 19 Dec 2024 00:33:26 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474b6sm989965f8f.51.2024.12.19.00.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/41] rust: rename qemu-api modules to follow C code a bit more
Date: Thu, 19 Dec 2024 09:32:14 +0100
Message-ID: <20241219083228.363430-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

A full match would mean calling them qom::object and hw::core::qdev.  For now,
keep the names shorter but still a bit easier to find.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs              |  4 +-
 rust/qemu-api-macros/src/lib.rs               |  2 +-
 rust/qemu-api/meson.build                     |  5 +-
 rust/qemu-api/src/lib.rs                      |  5 +-
 rust/qemu-api/src/module.rs                   | 43 +++++++++++
 rust/qemu-api/src/prelude.rs                  |  2 +-
 .../qemu-api/src/{device_class.rs => qdev.rs} |  4 +-
 rust/qemu-api/src/{definitions.rs => qom.rs}  | 76 ++++++++-----------
 rust/qemu-api/src/sysbus.rs                   |  2 +-
 rust/qemu-api/tests/tests.rs                  |  4 +-
 10 files changed, 91 insertions(+), 56 deletions(-)
 create mode 100644 rust/qemu-api/src/module.rs
 rename rust/qemu-api/src/{device_class.rs => qdev.rs} (97%)
 rename rust/qemu-api/src/{definitions.rs => qom.rs} (84%)

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
index a9965d1f123..ad4c12d097e 100644
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
 };
 
 /// Trait providing the contents of [`DeviceClass`].
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/qom.rs
similarity index 84%
rename from rust/qemu-api/src/definitions.rs
rename to rust/qemu-api/src/qom.rs
index a2481c1fe70..2222d1a5ab9 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -2,7 +2,34 @@
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
+//! A leaf class only needs a struct holding instance state. The struct must
+//! implement the [`ObjectType`] trait, as well as any `*Impl` traits that exist
+//! for its superclasses.
+//!
+//! If a class has subclasses, it will also provide a struct for instance data,
+//! with the same characteristics as for concrete classes, but it also needs
+//! additional components to support virtual methods:
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
+//!   `ClassInitImpl<DeviceClass>`. This fills the vtable in the class struct;
+//!   the source for this is the `*Impl` trait; the associated consts and
+//!   functions if needed are wrapped to map C types into Rust types.
 
 use std::{ffi::CStr, os::raw::c_void};
 
@@ -143,10 +170,9 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
 /// crate itself.  The Rust implementation of methods will come from a
-/// trait like [`ObjectImpl`] or
-/// [`DeviceImpl`](crate::device_class::DeviceImpl), and `ClassInitImpl` is
-/// provided by blanket implementations that operate on all implementors of the
-/// `*Impl`* trait.  For example:
+/// trait like [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl),
+/// and `ClassInitImpl` is provided by blanket implementations that
+/// operate on all implementors of the `*Impl`* trait.  For example:
 ///
 /// ```ignore
 /// impl<T> ClassInitImpl<DeviceClass> for T
@@ -194,7 +220,7 @@ pub trait ClassInitImpl<T> {
     /// can change them to override virtual methods of a parent class.
     ///
     /// The virtual method implementations usually come from another
-    /// trait, for example [`DeviceImpl`](crate::device_class::DeviceImpl)
+    /// trait, for example [`DeviceImpl`](crate::qdev::DeviceImpl)
     /// when `T` is [`DeviceClass`](crate::bindings::DeviceClass).
     ///
     /// On entry, `klass`'s parent class is initialized, while the other fields
@@ -206,44 +232,6 @@ pub trait ClassInitImpl<T> {
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
index ed3a555e76d..78f7da474b2 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,8 +5,8 @@
 use std::ffi::CStr;
 
 use qemu_api::{
-    bindings::*, c_str, declare_properties, define_property, definitions::ObjectImpl,
-    device_class::DeviceImpl, impl_device_class, prelude::*, zeroable::Zeroable,
+    bindings::*, c_str, declare_properties, define_property, prelude::*, qdev::DeviceImpl,
+    qom::ObjectImpl, zeroable::Zeroable,
 };
 
 #[test]
-- 
2.47.1


