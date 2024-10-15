Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C91D2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRQ-00027i-QD; Tue, 15 Oct 2024 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRO-00027D-NA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRK-0001Kq-Qx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkEvuhMOPAMN7lnR0ouyDabIAyuNADYTX1dRMur0+m0=;
 b=MczpqMTH8lkvleT899oXyeL7paDRT1hkew90AMV6zJzAFAKT9Qc8ICAj4FZW+6DfJRhY/K
 1POK7CX6y8g5+KsYmvM93imzjffDswRDCHlSHzXdB5ncCQ4FIJzy3v1Rc/fk7bjVpyjykK
 TNx8bdk6Y0T9UT3fivd5qnLw6BN4Gn8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-jYEpXeqBPheLbgMg6Q2qQg-1; Tue, 15 Oct 2024 09:18:15 -0400
X-MC-Unique: jYEpXeqBPheLbgMg6Q2qQg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d603515cfso1317228f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998294; x=1729603094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkEvuhMOPAMN7lnR0ouyDabIAyuNADYTX1dRMur0+m0=;
 b=m1WexgKn49eZc6QehmDOppVH5DlQAGMY3myOqcoXABGBdhLjglRLHG4CZ8FEIzDziq
 TIV3hamZg77x49jyNWGCoO6rbG38m3HEikmNEDiAqbfoHfiFCrv/FVXj66CiwXExj+no
 MTtQdOTRLzTurTXjuO0U7B2PuhyHN5a08kpFHDQVInW40ElFYpofZFCaPHASwZ9XgH2E
 h2HWVxlDFNjHuItVRI69fkYyB+xZkSGDc/ZiXPZGXS53qYGK6FpFnf/fhF4QcJISUm8F
 fGT30Ja7q31NZEMYWR2RF0ShjDGJs30H9vXvZtjBJWVoB3DWi/SIGk+Yc4mXl5Ej9zym
 QRzw==
X-Gm-Message-State: AOJu0YzaGkvmOHUKqSTYetLLIVvkVBVOdpXvg1nZC0PI6oTNmOwoxdD3
 7dxuvgpb26fRS9OkJJhpQU9UD7zw9iebEDi87omIHtpF7PG4sXJNn3OdHMvEDWWQ8HnMJJ8rkBN
 oZovnadcxME0nR+sIKvC/akE/OYODxLEZquZ6fj/6XkdyXIEMtlLpK9Shq/um/dUr8CgEqwkkGI
 a1KHASnpTDyxxSD0WUVS3OmpUxoRj7nHQg0BF/Voc=
X-Received: by 2002:a5d:4f84:0:b0:37d:377f:51e6 with SMTP id
 ffacd0b85a97d-37d5ffb3611mr8124421f8f.56.1728998293654; 
 Tue, 15 Oct 2024 06:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaG95vug18FDwMQ5amOXCt7Hv7dIHE8q0TMIPOeaEbftqGGEr0FJC0Ub4VldF2tiHOkp0WeA==
X-Received: by 2002:a5d:4f84:0:b0:37d:377f:51e6 with SMTP id
 ffacd0b85a97d-37d5ffb3611mr8124393f8f.56.1728998293108; 
 Tue, 15 Oct 2024 06:18:13 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa9090asm1565509f8f.57.2024.10.15.06.18.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] rust: do not use MaybeUninit::zeroed()
Date: Tue, 15 Oct 2024 15:17:29 +0200
Message-ID: <20241015131735.518771-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

MaybeUninit::zeroed() is handy, but it introduces unsafe (and has a pretty =
heavy
syntax in general) and anyway it is not available as a "const" function unt=
il
Rust 1.75.0.

Introduce a trait that provides the same functionality while staying within
safe Rust.  In the future we may want to add automatic derivation and
implementation of the trait, once we can assume Rust 1.75.0; for now the
implementation is manual.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs |  5 +-
 rust/hw/char/pl011/src/memory_ops.rs   | 11 ++--
 rust/qemu-api/meson.build              |  1 +
 rust/qemu-api/src/device_class.rs      |  4 +-
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/zeroable.rs          | 75 ++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 8 deletions(-)
 create mode 100644 rust/qemu-api/src/zeroable.rs

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/sr=
c/device_class.rs
index a3d1b1e929a..37bbf6d36cc 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -7,7 +7,8 @@
 use qemu_api::{
     bindings::*,
     c_str,
-    definitions::ObjectImpl
+    definitions::ObjectImpl,
+    zeroable::Zeroable,
 };
=20
 use crate::device::PL011State;
@@ -16,7 +17,7 @@
 pub static VMSTATE_PL011: VMStateDescription =3D VMStateDescription {
     name: PL011State::TYPE_INFO.name,
     unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().as=
sume_init() }
+    ..Zeroable::ZERO
 };
=20
 qemu_api::declare_properties! {
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/=
memory_ops.rs
index 2c664fd45ed..88d17ec2e3a 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -2,11 +2,14 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::{mem::MaybeUninit, ptr::NonNull};
+use core::ptr::NonNull;
=20
 use std::os::raw::{c_uint, c_void};
=20
-use qemu_api::bindings::*;
+use qemu_api::{
+    bindings::*,
+    zeroable::Zeroable
+};
=20
 use crate::device::PL011State;
=20
@@ -16,11 +19,11 @@
     read_with_attrs: None,
     write_with_attrs: None,
     endianness: device_endian::DEVICE_NATIVE_ENDIAN,
-    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed()=
.assume_init() },
+    valid: Zeroable::ZERO,
     impl_: MemoryRegionOps__bindgen_ty_2 {
         min_access_size: 4,
         max_access_size: 4,
-        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().=
assume_init() }
+        ..Zeroable::ZERO
     },
 };
=20
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 57f813fc8f9..547fc5caa3a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,6 +14,7 @@ _qemu_api_rs =3D static_library(
       'src/device_class.rs',
       'src/offset_of.rs',
       'src/tests.rs',
+      'src/zeroable.rs',
     ],
     {'.' : bindings_rs},
   ),
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index d4fa544df39..d2535125c48 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -100,7 +100,7 @@ const fn _calc_prop_len() -> usize {
         fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
             [
                 $($prop),*,
-                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::=
Property>::zeroed().assume_init() },
+                $crate::zeroable::Zeroable::ZERO,
             ]
         }
=20
@@ -125,7 +125,7 @@ macro_rules! vm_state_description {
                 $vname.as_ptr()
             },)*
             unmigratable: true,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStat=
eDescription>::zeroed().assume_init() }
+            ..$crate::zeroable::Zeroable::ZERO
         };
     }
 }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 082f1addb10..50951d20e14 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -31,6 +31,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 pub mod definitions;
 pub mod device_class;
 pub mod offset_of;
+pub mod zeroable;
=20
 #[cfg(test)]
 mod tests;
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
new file mode 100644
index 00000000000..faa93d1fb33
--- /dev/null
+++ b/rust/qemu-api/src/zeroable.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::ptr;
+
+/// This trait provides a replacement for core::mem::zeroed() that can be
+/// used as a `const fn` prior to Rust 1.75.0.  As an added bonus it remov=
es
+/// usage of `unsafe` blocks.
+///
+/// Unlike other Zeroable traits found in other crates (e.g.
+/// [`pinned_init`](https://docs.rs/pinned-init/latest/pinned_init/trait.Z=
eroable.html))
+/// this is a safe trait because the value `ZERO` constant has to be writt=
en by
+/// hand.  The `pinned_init` crate instead makes the trait unsafe, but it
+/// provides a `#[derive(Zeroable)]` macro to define it with compile-time
+/// safety checks. Once we can assume Rust 1.75.0 is available, we could
+/// switch to their idea, and use `core::mem::zeroed()` to provide a blank=
ed
+/// implementation of the `ZERO` constant.
+pub trait Zeroable: Default {
+    const ZERO: Self;
+}
+
+impl Zeroable for crate::bindings::Property__bindgen_ty_1 {
+    const ZERO: Self =3D Self { i: 0 };
+}
+
+impl Zeroable for crate::bindings::Property {
+    const ZERO: Self =3D Self {
+        name: ptr::null(),
+        info: ptr::null(),
+        offset: 0,
+        bitnr: 0,
+        bitmask: 0,
+        set_default: false,
+        defval: Zeroable::ZERO,
+        arrayoffset: 0,
+        arrayinfo: ptr::null(),
+        arrayfieldsize: 0,
+        link_type: ptr::null(),
+    };
+}
+
+impl Zeroable for crate::bindings::VMStateDescription {
+    const ZERO: Self =3D Self {
+        name: ptr::null(),
+        unmigratable: false,
+        early_setup: false,
+        version_id: 0,
+        minimum_version_id: 0,
+        priority: crate::bindings::MigrationPriority::MIG_PRI_DEFAULT,
+        pre_load: None,
+        post_load: None,
+        pre_save: None,
+        post_save: None,
+        needed: None,
+        dev_unplug_pending: None,
+        fields: ptr::null(),
+        subsections: ptr::null(),
+    };
+}
+
+impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {
+    const ZERO: Self =3D Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+        accepts: None,
+    };
+}
+
+impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {
+    const ZERO: Self =3D Self {
+        min_access_size: 0,
+        max_access_size: 0,
+        unaligned: false,
+    };
+}
--=20
2.46.2


