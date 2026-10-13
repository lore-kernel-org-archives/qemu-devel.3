Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A64ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGRGb-0001Ia-J2; Mon, 12 Oct 2026 21:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asdfkwang@gmail.com>)
 id 1xGRGa-0001IG-Bt
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 21:25:20 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asdfkwang@gmail.com>)
 id 1xGRGX-0007MB-GN
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 21:25:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso981672a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 18:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791854716; x=1792459516; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=btVRxtACW8mwgkW/xnvsqLXKbFqRc4qN1iYVabO/zHI=;
 b=e68S98yoMdIqKVBcNGaLb6iaSN+O4XE9qhKLA7ZPaRzCIu/DFhq6k/Jxd8xspwQTZM
 bthoHDv1b/WMiQzgzt9tRS6D+8nC/0L7L58oI6CGI5xJHY1Ldirm6ShH1MYoYODBeFeI
 9Triz8H/sR7fevEBsOwVgKmIcwxss4hNd7e/o+my4Kt80/Wx6byv7ZPnXpsvpe7SI0gG
 CAJ0BnIVWBO5qhCDWf0dE2L1GLXCnl7qkXxejtIu7jy7ggpCazThBgoQQrkgjaUMR/J9
 eGjaDPlf/0FJvUA7MieE16pMXp5libkT4PDjZPuuWpjcYUGIGIDPW7q7F9NAtejFT+Aw
 33XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791854716; x=1792459516;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=btVRxtACW8mwgkW/xnvsqLXKbFqRc4qN1iYVabO/zHI=;
 b=VgnlQeVy1YnRzetBWyjWXlVaRm3eHO3Al0m9iTDWw+A1bX3iutyjGdWWVa2LSfyOVN
 j6Vk7ysw1OrCtkaAz7hWyEUQ4mF3yZJ1Rmqut5lYgdd5wDfbdynFbXJzNQhz180WRh7U
 uDbGVZsNb6Pc4BpSFO9ix9hVRq89RhT6qlRzqLRBgIrhlGIvCiVY3FMx25dzozUEegBq
 lFi1TMg/zdo8WVfNOXGcjbll46wT3wDgd6mV91rQL/s7IdT2xJZrTlYEc3IOYtDK6GAK
 Rfo0Hc4CoApHv7a8Mlt75lF9sr89YNiroodJ55xCjXdT3vxTO8r8yxeEJcoqVUouKSWN
 XRhw==
X-Gm-Message-State: AFq9FYKkEgrak16YyeTwb4fgtFhUKsq73SXgWX8VsAK4iHs4WsXCLQgS
 BSZ/FaG427nxEHA+0dpPBbnvRSHnXOx3JPqkRrmzIIZ1U3hrH7Kys9H9
X-Gm-Gg: AYBFou2xZfH90332+0DfDb6jPLP+377QUuaNDrEqgGlb2ERXQnRtXOtt6VCIuW52eW4
 bjp7WrtF2y7UIFj1Z/CvS1zrp73YkdIyzrH5vxEK2dM/qIIYWpW0YHLxhkRlbqrxKKfxc4nMoWd
 bI2SzU1Z0SdbfsEaHRg3bFOY1ACiyHBFD4JZz4FSbI4URSlPaet36Y2yWotSId7DsTV31mBWuWr
 hOf6+zEHrRDP7dgZXRVEQjXk0s942KJoXpn88K1EAznK7Z2iNDvO6gtP5BtK0lzW+4pfuTTsUo+
 kSRDXz+OZcy4rURN+w2+qgI2sgVSLhdjSOdmDumHRDJqmSO+m055l9ir8uSthBUlYfxzobcMWwR
 YGRIDlmWjzLqXwpCVXLHGrHfqzSvBE3gxknWqtSgYPfS18z1qSVhkQKj9pBZ737aPyxK6dDHIw5
 vY0JRIoydSXbtfdVEDN9j1GgfiE/kVeSRG1glzLcxF9A0MpTRACvsNarIV1fgv1SaYXwn0Ww==
X-Received: by 2002:a17:90a:109:b0:3a8:2046:7e5f with SMTP id
 98e67ed59e1d1-3ab3a747e69mr6673501a91.12.1791854715338; 
 Mon, 12 Oct 2026 18:25:15 -0700 (PDT)
Received: from [127.0.1.1] ([169.211.140.146])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da04596dsm4749513a12.29.2026.10.12.18.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:25:14 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
Date: Mon, 12 Oct 2026 21:24:33 -0400
Subject: [PATCH] rust: convert addr_of!/addr_of_mut! to &raw const/mut
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rawp-v1-1-c87049a5673d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFCIzWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3aLE8gJdkxSDpFSLVKNU82RjJaDSgqLUtMwKsDHRsbW1AJwClMV
 WAAAA
X-Change-ID: 20261012-rawp-4d0be8e2e7c3
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-rust@nongnu.org, Kwanghoon Son <asdfkwang@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=asdfkwang@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rust 1.82 stabilized raw reference syntax (&raw mut, &raw const).
Replace the macro equivalents with the modern syntax. QEMU's MSRV
(1.83.0) supports this.

- addr_of_mut!(expr)  -> &raw mut expr
- addr_of!(expr)      -> &raw const expr

No semantic difference; improves readability and follows modern Rust
idioms.

Signed-off-by: Kwanghoon Son <asdfkwang@gmail.com>
---
 rust/chardev/src/chardev.rs       | 15 +++++++--------
 rust/common/src/uninit.rs         |  2 +-
 rust/hw/core/src/qdev.rs          |  6 +++---
 rust/hw/core/tests/tests.rs       |  8 ++++----
 rust/hw/timer/hpet/src/device.rs  |  4 ++--
 rust/hw/timer/hpet/src/fw_cfg.rs  |  6 ++----
 rust/migration/src/migratable.rs  |  4 ++--
 rust/migration/src/vmstate.rs     | 12 ++++++------
 rust/tests/tests/vmstate_tests.rs |  4 ++--
 rust/util/src/error.rs            |  9 +++------
 10 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index fb9674b3fb478c6149dcc2cd0d5535b6c1d2128f..3e2cf405cd105da922f9ece465c068acef27e499 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -14,7 +14,6 @@
     fmt::{self, Debug},
     io::{self, ErrorKind, Write},
     marker::PhantomPinned,
-    ptr::addr_of_mut,
     slice,
 };
 
@@ -53,7 +52,7 @@ fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
         let chr: &mut bindings::CharFrontend = &mut self.0;
 
         let len = buf.len().try_into().unwrap();
-        let r = unsafe { bindings::qemu_chr_fe_write(addr_of_mut!(*chr), buf.as_ptr(), len) };
+        let r = unsafe { bindings::qemu_chr_fe_write(&raw mut *chr, buf.as_ptr(), len) };
         errno::into_io_result(r).map(|cnt| cnt as usize)
     }
 
@@ -61,7 +60,7 @@ fn write_all(&mut self, buf: &[u8]) -> io::Result<()> {
         let chr: &mut bindings::CharFrontend = &mut self.0;
 
         let len = buf.len().try_into().unwrap();
-        let r = unsafe { bindings::qemu_chr_fe_write_all(addr_of_mut!(*chr), buf.as_ptr(), len) };
+        let r = unsafe { bindings::qemu_chr_fe_write_all(&raw mut *chr, buf.as_ptr(), len) };
         errno::into_io_result(r).and_then(|cnt| {
             if cnt as usize == buf.len() {
                 Ok(())
@@ -156,7 +155,7 @@ pub fn enable_handlers<
         // SAFETY: the borrow promises that the BQL is taken
         unsafe {
             bindings::qemu_chr_fe_set_handlers(
-                addr_of_mut!(*chr),
+                &raw mut *chr,
                 Some(rust_can_receive_cb::<T, CanReceiveFn>),
                 receive_cb,
                 event_cb,
@@ -174,7 +173,7 @@ pub fn disable_handlers(&self) {
         // SAFETY: the borrow promises that the BQL is taken
         unsafe {
             bindings::qemu_chr_fe_set_handlers(
-                addr_of_mut!(*chr),
+                &raw mut *chr,
                 None,
                 None,
                 None,
@@ -190,7 +189,7 @@ pub fn disable_handlers(&self) {
     pub fn accept_input(&self) {
         let mut chr = self.inner.borrow_mut();
         // SAFETY: the borrow promises that the BQL is taken
-        unsafe { bindings::qemu_chr_fe_accept_input(addr_of_mut!(*chr)) }
+        unsafe { bindings::qemu_chr_fe_accept_input(&raw mut *chr) }
     }
 
     /// Temporarily borrow the character device, allowing it to be used
@@ -209,9 +208,9 @@ pub fn send_break(&self, long: bool) -> io::Result<()> {
         // SAFETY: the borrow promises that the BQL is taken
         let r = unsafe {
             bindings::qemu_chr_fe_ioctl(
-                addr_of_mut!(*chr),
+                &raw mut *chr,
                 bindings::CHR_IOCTL_SERIAL_SET_BREAK as i32,
-                addr_of_mut!(duration).cast::<c_void>(),
+                (&raw mut duration).cast::<c_void>(),
             )
         };
 
diff --git a/rust/common/src/uninit.rs b/rust/common/src/uninit.rs
index 8d021b1dfc6e957653e9a0e011f68fa44d57030a..99021ae2be416bc0e4aa36675ceb894a19d363f8 100644
--- a/rust/common/src/uninit.rs
+++ b/rust/common/src/uninit.rs
@@ -79,7 +79,7 @@ macro_rules! uninit_field_mut {
         // SAFETY: the container is not used directly, only through a MaybeUninit<>,
         // so the safety is delegated to the caller and to final invocation of
         // assume_init()
-        let target__ = unsafe { std::ptr::addr_of_mut!((*container_ptr__).$($field)+) };
+        let target__ = unsafe { &raw mut ((*container_ptr__).$($field)+) };
         $crate::uninit::MaybeUninitField::new(container__, target__)
     }};
 }
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index b2e5441079d3e2de9769f110e9490cb5c5549086..d8d512c068059fefd181170dad47a4d0052099a9 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -6,7 +6,7 @@
 
 use std::{
     ffi::{c_int, c_void, CStr, CString},
-    ptr::{addr_of, NonNull},
+    ptr::NonNull,
 };
 
 use chardev::Chardev;
@@ -142,9 +142,9 @@ macro_rules! impl_qdev_prop {
     ($type:ty,$info:ident$(, $bit_info:ident)?) => {
         unsafe impl $crate::qdev::QDevProp for $type {
             const BASE_INFO: *const $crate::bindings::PropertyInfo =
-                addr_of!($crate::bindings::$info);
+                &raw const $crate::bindings::$info;
             $(const BIT_INFO: *const $crate::bindings::PropertyInfo =
-                addr_of!($crate::bindings::$bit_info);)?
+                &raw const $crate::bindings::$bit_info;)?
         }
     };
 }
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 05aa5d4a37775a562a33d89a08c8083c6a1c78f6..562b54cf23ce9eb0aff47925d3adf8e5e910ca18 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, ptr::addr_of};
+use std::ffi::CStr;
 
 use bql::prelude::*;
 use hwcore::prelude::*;
@@ -140,17 +140,17 @@ fn test_cast() {
     let p_ref: &mut DummyState = unsafe { &mut *p_ptr };
 
     let obj_ref: &Object = p_ref.upcast();
-    assert_eq!(addr_of!(*obj_ref), p_ptr.cast());
+    assert_eq!(&raw const (*obj_ref), p_ptr.cast());
 
     let sbd_ref: Option<&DummyChildState> = obj_ref.dynamic_cast();
     assert!(sbd_ref.is_none());
 
     let dev_ref: Option<&DeviceState> = obj_ref.downcast();
-    assert_eq!(addr_of!(*dev_ref.unwrap()), p_ptr.cast());
+    assert_eq!(&raw const (*dev_ref.unwrap()), p_ptr.cast());
 
     // SAFETY: the cast is wrong, but the value is only used for comparison
     unsafe {
         let sbd_ref: &DummyChildState = obj_ref.unsafe_cast();
-        assert_eq!(addr_of!(*sbd_ref), p_ptr.cast());
+        assert_eq!(&raw const (*sbd_ref), p_ptr.cast());
     }
 }
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 89ba7a5c4d219e460402bafad1c39e959cdde6d7..53707270ee1573b15fd00ea3f44f89a501318a42 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -6,7 +6,7 @@
     ffi::CStr,
     mem::MaybeUninit,
     pin::Pin,
-    ptr::{addr_of_mut, null_mut, NonNull},
+    ptr::{null_mut, NonNull},
     slice::from_ref,
 };
 
@@ -331,7 +331,7 @@ fn set_irq(&self, regs: &HPETRegisters, set: bool) {
                 // the parameters are valid.
                 unsafe {
                     address_space_stl_le(
-                        addr_of_mut!(address_space_memory),
+                        &raw mut address_space_memory,
                         tn_regs.fsb >> 32,  // Timer N FSB int addr
                         tn_regs.fsb as u32, // Timer N FSB int value, truncate!
                         MEMTXATTRS_UNSPECIFIED,
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index ad80acd998c3e46a823d2e8b230b8c7ec84e08c1..18e1ac5eb9ab47aee7a2f39748eac9c924bd3e3d 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -2,8 +2,6 @@
 // Author(s): Zhao Liu <zhao1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ptr::addr_of_mut;
-
 use common::Zeroable;
 use util::{self, prelude::*};
 
@@ -41,7 +39,7 @@ pub(crate) fn assign_hpet_id() -> util::Result<usize> {
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *&raw mut hpet_fw_cfg };
 
         if fw_cfg.count == u8::MAX {
             // first instance
@@ -59,7 +57,7 @@ pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64)
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *&raw mut hpet_fw_cfg };
 
         fw_cfg.hpet[hpet_id].event_timer_block_id = timer_block_id;
         fw_cfg.hpet[hpet_id].address = address;
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index b9e5e1fc15dfbb18cf354ea242d63fd56115a409..49bf0beda5b9466f4ee3c067f127b3c3b5657f27 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -5,7 +5,7 @@
 use std::{
     fmt,
     mem::size_of,
-    ptr::{self, addr_of, NonNull},
+    ptr::{self, NonNull},
     sync::{Arc, Mutex},
 };
 
@@ -469,7 +469,7 @@ impl<T: 'static + ToMigrationStateShared> Migratable<T> {
 unsafe impl<T: 'static + ToMigrationStateShared> VMState for Migratable<T> {
     const BASE: bindings::VMStateField = {
         bindings::VMStateField {
-            vmsd: addr_of!(*Self::VMSD),
+            vmsd: &raw const *Self::VMSD,
             size: size_of::<Self>(),
             flags: bindings::VMStateFlags::VMS_STRUCT,
             ..Zeroable::ZERO
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5ed061f2abb68277ec7dbc7d5eb3de80b64c6af3..e003c45e81dcc6ed70951f043cb225a42cffbfd5 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -31,7 +31,7 @@
     fmt, io,
     marker::PhantomData,
     mem,
-    ptr::{addr_of, NonNull},
+    ptr::NonNull,
 };
 
 use common::{
@@ -129,7 +129,7 @@ pub const fn size_of_ptr_type<T>(_: *const T) -> usize {
 macro_rules! size_of_field_type {
     ($struct_name:ty, $($field_name:ident).+) => {
         $crate::vmstate::size_of_ptr_type(unsafe {
-            ::core::ptr::addr_of!(
+            &raw const (
                 (*$crate::vmstate::OPAQUE.as_ptr().cast::<$struct_name>()).$($field_name).+
             )
         })
@@ -235,7 +235,7 @@ macro_rules! impl_vmstate_scalar {
     ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
         unsafe impl $crate::vmstate::VMState for $type {
             const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
-                info: addr_of!(bindings::$info),
+                info: &raw const bindings::$info,
                 size: mem::size_of::<$type>(),
                 flags: $crate::vmstate::VMStateFlags::VMS_SINGLE,
                 ..::common::zeroable::Zeroable::ZERO
@@ -261,7 +261,7 @@ macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
         unsafe impl $crate::vmstate::VMState for $type {
             const BASE: $crate::bindings::VMStateField = $crate::bindings::VMStateField {
-                vmsd: ::std::ptr::addr_of!($vmsd),
+                vmsd: &raw const $vmsd,
                 size: ::std::mem::size_of::<$type>(),
                 flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
                 ..::common::zeroable::Zeroable::ZERO
@@ -305,7 +305,7 @@ macro_rules! vmstate_unused {
         $crate::bindings::VMStateField {
             name: c"unused".as_ptr(),
             size: $size,
-            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
+            info: unsafe { &raw const ($crate::bindings::vmstate_info_unused_buffer) },
             flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
             ..::common::Zeroable::ZERO
         }
@@ -403,7 +403,7 @@ unsafe impl $crate::vmstate::VMState for $type {
                 static VMSD: &$crate::bindings::VMStateDescription = $vmsd.as_ref();
 
                 $crate::bindings::VMStateField {
-                    vmsd: ::core::ptr::addr_of!(*VMSD),
+                    vmsd: &raw const (*VMSD),
                     size: ::core::mem::size_of::<$type>(),
                     flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
                     ..common::Zeroable::ZERO
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 6578d54b37d413fb07e92a4c76b8cd32e6823b0b..d3604edd5b109e350933e69c0c27d3e93a5ec3c1 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -255,7 +255,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
     let foo_fields: &[VMStateField] =
         unsafe { slice::from_raw_parts(VMSTATE_FOOB.as_ref().fields, 7) };
     let mut foo_b: FooB = Default::default();
-    let foo_b_p = std::ptr::addr_of_mut!(foo_b).cast::<c_void>();
+    let foo_b_p = (&raw mut foo_b).cast::<c_void>();
 
     // 6th VMStateField ("arr_a_wrap") in VMSTATE_FOOB (corresponding to
     // VMSTATE_STRUCT_VARRAY_UINT8). Other fields are checked in
@@ -446,7 +446,7 @@ fn test_vmstate_validate() {
     let foo_fields: &[VMStateField] =
         unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 4) };
     let mut foo_d = FooD;
-    let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
+    let foo_d_p = (&raw mut foo_d).cast::<c_void>();
 
     // 1st VMStateField in VMSTATE_FOOD
     assert_eq!(
diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index 4edceff42f3bcb6e19eceb184d7db77723b0511a..f89ade4ad116b27cef37c3ecc7abb834d965cfe5 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -38,8 +38,7 @@
     ffi::{c_char, c_int, c_void, CStr},
     fmt::{self, Display},
     ops::Deref,
-    panic,
-    ptr::{self, addr_of_mut},
+    panic, ptr,
 };
 
 use foreign::{prelude::*, OwnedPointer};
@@ -253,10 +252,8 @@ impl<T, E> ResultExt for std::result::Result<T, E>
 
     fn unwrap_fatal(self) -> T {
         // SAFETY: errp is valid
-        self.map_err(|err| unsafe {
-            Error::from(err).propagate(addr_of_mut!(bindings::error_fatal))
-        })
-        .unwrap()
+        self.map_err(|err| unsafe { Error::from(err).propagate(&raw mut bindings::error_fatal) })
+            .unwrap()
     }
 }
 

---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-rawp-4d0be8e2e7c3

Best regards,
-- 
Kwanghoon Son <asdfkwang@gmail.com>


