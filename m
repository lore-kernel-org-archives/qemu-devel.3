Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08FED149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mn0-0002Vh-0M; Fri, 25 Oct 2024 12:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mmg-0002Gs-Gu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mme-0004rJ-5E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRpYd5gLU5pnd2gn0TumqBM3kJhFe2BgTXzKLOcnZGg=;
 b=WD2n3WVRfI5YkzaCGCzoK7G86WjlcdptbLVRqWCSfsfjhyhO3R1Z6O9MKaWvUJs8s2C0SG
 t6nLnPR8sbfaf0NAJ6+uTixAlxlbLW1bzvzfVQO3uRZtTMrEe26QTzIxF+0bo5ZpArH5Sl
 0gTvAYJnSOv0fJsBE8+LnOMrLuReSI4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Cm8Df4srMIqyHq_jvTusWg-1; Fri, 25 Oct 2024 12:03:24 -0400
X-MC-Unique: Cm8Df4srMIqyHq_jvTusWg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a194d672bso159445666b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872201; x=1730477001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRpYd5gLU5pnd2gn0TumqBM3kJhFe2BgTXzKLOcnZGg=;
 b=fLInT2+6QJE23q/IEUSjzlkJV+4FpZ6SFqh69l4TJEzEloqVY+NSNOjoxb2kk9pi6I
 HhLbu4B+Y7hdtOBVvxFyX0XdldyD/5c+BxX32WOCoCht2p7JT0bda+/kGp5HgMrh7wkl
 hoFKqJwR3mdmRKGndKHDaLkLASSo/TFec1IGvv5STxBz3t5qU5nHZJELtZk9mmUg59kd
 9Ml3GfDJ8bqxTMmJ/mMwAOSo/kKfab35svq4QJWkHJJ65RtjqFh5tH4gK2xuHxl2W/xe
 1V5NmKXr7kWhP4W479osMRHSUkf8MsL0rVk+QcFTusF27qJsPREFmSpPukdksbPOg1pz
 f5hg==
X-Gm-Message-State: AOJu0YzrqnhiNRtI3ARNA1s5elWG2fCSS/zozyq283eKpmPxSNihNh0V
 5JydCedseAksfTXuqucYFq2F7tbgNtTO/bJQE56OEwfVruXN3uAxt30Wq7r41A2ORpqOVDgDiVg
 5HYmytsJBcrXD7LP4YLyxfqcSbmReiEI7KiioL4fKQtE8SbHsn37qh0etEMy5PVe30fkOH1K8Xr
 qJ7mCVuWe2cv/Na3PaYLoi4jhjbnaFJfFiZJaavLU=
X-Received: by 2002:a17:907:5015:b0:a9d:e1d6:42a1 with SMTP id
 a640c23a62f3a-a9de1d6435emr21190166b.30.1729872201011; 
 Fri, 25 Oct 2024 09:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyt2JvE9VYA2xkI3VIFOyVoR52tOPHTdEzenqsysH29mMicK8aICqmXcRNSvL5Hv7W8Z+0rw==
X-Received: by 2002:a17:907:5015:b0:a9d:e1d6:42a1 with SMTP id
 a640c23a62f3a-a9de1d6435emr21186166b.30.1729872200346; 
 Fri, 25 Oct 2024 09:03:20 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f0698c0sm85027666b.95.2024.10.25.09.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 10/23] rust: use std::os::raw instead of core::ffi
Date: Fri, 25 Oct 2024 18:01:55 +0200
Message-ID: <20241025160209.194307-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

core::ffi::c_* types were introduced in Rust 1.64.0.  Use the older types
in std::os::raw, which are now aliases of the types in core::ffi.  There is
no need to compile QEMU as no_std, so this is acceptable as long as we supp=
ort
a version of Debian with Rust 1.63.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                          |  3 +--
 rust/hw/char/pl011/src/device.rs     | 35 +++++++++++-----------------
 rust/hw/char/pl011/src/lib.rs        |  4 ++--
 rust/hw/char/pl011/src/memory_ops.rs | 14 +++--------
 rust/qemu-api/src/definitions.rs     |  2 +-
 rust/qemu-api/src/device_class.rs    |  6 ++---
 rust/qemu-api/src/lib.rs             | 11 +++++----
 rust/qemu-api/src/vmstate.rs         | 10 ++++----
 rust/qemu-api/tests/tests.rs         |  9 ++++---
 9 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/meson.build b/meson.build
index 5e2b0fb82b2..e819148f36c 100644
--- a/meson.build
+++ b/meson.build
@@ -3933,14 +3933,13 @@ if have_rust and have_system
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
-    '--ctypes-prefix', 'core::ffi',
+    '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
     '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
-    '--use-core',
     '--with-derive-default',
     '--no-layout-tests',
     '--no-prepend-enum-name',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 788b47203b1..036757f7f3a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,9 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::{
-    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
-    ptr::{addr_of, addr_of_mut, NonNull},
+use core::ptr::{addr_of, addr_of_mut, NonNull};
+use std::{
+    ffi::CStr,
+    os::raw::{c_int, c_uchar, c_uint, c_void},
 };
=20
 use qemu_api::{
@@ -117,11 +118,10 @@ pub struct PL011Class {
 }
=20
 impl qemu_api::definitions::Class for PL011Class {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
-    > =3D Some(crate::device_class::pl011_class_init);
+    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass,=
 data: *mut c_void)> =3D
+        Some(crate::device_class::pl011_class_init);
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > =3D None;
 }
=20
@@ -176,11 +176,7 @@ unsafe fn init(&mut self) {
         }
     }
=20
-    pub fn read(
-        &mut self,
-        offset: hwaddr,
-        _size: core::ffi::c_uint,
-    ) -> std::ops::ControlFlow<u64, u64> {
+    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::Con=
trolFlow<u64, u64> {
         use RegisterOffset::*;
=20
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset=
) {
@@ -562,11 +558,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Resul=
t<(), ()> {
 /// readable/writeable from one thread at any time.
 ///
 /// The buffer and size arguments must also be valid.
-pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
-    buf: *const u8,
-    size: core::ffi::c_int,
-) {
+pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8=
, size: c_int) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>=
());
@@ -585,7 +577,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result=
<(), ()> {
 /// We expect the FFI user of this function to pass a valid pointer, that =
has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event=
: QEMUChrEvent) {
+pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEv=
ent) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>=
());
@@ -656,11 +648,10 @@ pub struct PL011LuminaryClass {
 }
=20
 impl qemu_api::definitions::Class for PL011LuminaryClass {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
-    > =3D None;
+    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass,=
 data: *mut c_void)> =3D
+        None;
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > =3D None;
 }
=20
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index c6bb76a7926..a539062aa30 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -45,8 +45,8 @@
 pub mod device_class;
 pub mod memory_ops;
=20
-pub const TYPE_PL011: &::core::ffi::CStr =3D c"pl011";
-pub const TYPE_PL011_LUMINARY: &::core::ffi::CStr =3D c"pl011_luminary";
+pub const TYPE_PL011: &::std::ffi::CStr =3D c"pl011";
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr =3D c"pl011_luminary";
=20
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/=
memory_ops.rs
index fc69922fbf3..169d485a4d2 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -3,6 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
 use core::ptr::NonNull;
+use std::os::raw::{c_uint, c_void};
=20
 use qemu_api::{bindings::*, zeroable::Zeroable};
=20
@@ -22,11 +23,7 @@
     },
 };
=20
-unsafe extern "C" fn pl011_read(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    size: core::ffi::c_uint,
-) -> u64 {
+unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c=
_uint) -> u64 {
     assert!(!opaque.is_null());
     let mut state =3D unsafe { NonNull::new_unchecked(opaque.cast::<PL011S=
tate>()) };
     let val =3D unsafe { state.as_mut().read(addr, size) };
@@ -43,12 +40,7 @@
     }
 }
=20
-unsafe extern "C" fn pl011_write(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    data: u64,
-    _size: core::ffi::c_uint,
-) {
+unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: =
u64, _size: c_uint) {
     unsafe {
         assert!(!opaque.is_null());
         let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>=
());
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitio=
ns.rs
index 064afe60549..26597934bbd 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -4,7 +4,7 @@
=20
 //! Definitions required by QEMU when registering a device.
=20
-use ::core::ffi::{c_void, CStr};
+use std::{ffi::CStr, os::raw::c_void};
=20
 use crate::bindings::{Object, ObjectClass, TypeInfo};
=20
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 3d40256f60f..cb4573ca6ef 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -7,7 +7,7 @@ macro_rules! device_class_init {
     ($func:ident, props =3D> $props:ident, realize_fn =3D> $realize_fn:exp=
r, legacy_reset_fn =3D> $legacy_reset_fn:expr, vmsd =3D> $vmsd:ident$(,)*) =
=3D> {
         pub unsafe extern "C" fn $func(
             klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::core::ffi::c_void,
+            _: *mut ::std::os::raw::c_void,
         ) {
             let mut dc =3D
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::D=
eviceClass>()).unwrap();
@@ -26,7 +26,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
@@ -37,7 +37,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) =3D>=
 {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 10ab3d7e639..ed840ee2f72 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -34,7 +34,10 @@ unsafe impl Sync for bindings::VMStateInfo {}
 pub mod vmstate;
 pub mod zeroable;
=20
-use std::alloc::{GlobalAlloc, Layout};
+use std::{
+    alloc::{GlobalAlloc, Layout},
+    os::raw::c_void,
+};
=20
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
@@ -48,8 +51,8 @@ fn g_aligned_alloc0(
=20
 #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
 extern "C" {
-    fn qemu_memalign(alignment: usize, size: usize) -> *mut ::core::ffi::c=
_void;
-    fn qemu_vfree(ptr: *mut ::core::ffi::c_void);
+    fn qemu_memalign(alignment: usize, size: usize) -> *mut c_void;
+    fn qemu_vfree(ptr: *mut c_void);
 }
=20
 extern "C" {
@@ -114,7 +117,7 @@ fn default() -> Self {
 }
=20
 // Sanity check.
-const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut ::core::ffi::c_void>=
()];
+const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut c_void>()];
=20
 unsafe impl GlobalAlloc for QemuAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 2a626137e25..5dd783a902a 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -55,7 +55,7 @@ macro_rules! vmstate_single_test {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: $size,
@@ -132,7 +132,7 @@ macro_rules! vmstate_array {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: $size,
@@ -180,7 +180,7 @@ macro_rules! vmstate_struct_pointer_v {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: ::core::mem::size_of::<*const $type>(),
@@ -205,7 +205,7 @@ macro_rules! vmstate_array_of_pointer {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             version_id: $version_id,
             num: $num as _,
             info: $info,
@@ -230,7 +230,7 @@ macro_rules! vmstate_array_of_pointer_to_struct {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             version_id: $version_id,
             num: $num as _,
             vmsd: $vmsd,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 37c4dd44f81..c7089f0cf21 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::ffi::CStr;
+use std::{ffi::CStr, os::raw::c_void};
=20
 use qemu_api::{
     bindings::*,
@@ -64,11 +64,10 @@ impl ObjectImpl for DummyState {
     }
=20
     impl Class for DummyClass {
-        const CLASS_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core:=
:ffi::c_void),
-        > =3D Some(dummy_class_init);
+        const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectCl=
ass, data: *mut c_void)> =3D
+            Some(dummy_class_init);
         const CLASS_BASE_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core:=
:ffi::c_void),
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_voi=
d),
         > =3D None;
     }
=20
--=20
2.47.0


