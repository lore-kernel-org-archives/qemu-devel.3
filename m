Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09EDC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIH-0005q3-4V; Fri, 24 Jan 2025 04:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGH-0007cP-ME
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGE-0003xU-Fs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNWd0azXgUd9sSMT4kGbMLXTGKtKYehwsaTDvX4Hyhc=;
 b=IyruKMr3g2g1OHc8Q/z/VK9iWbdJuZ0ijjB5yzfYqdSdw1XIDhvUh0DVuWKKC71BmWSl9j
 l1hIDwHYqUAYONgI/OybYhytSKPyUroDUCbEiq2kJfQ7flPu2kz1WJS6FjutODhCCqpEZu
 NH5lbVzjskag6Dz7K/oHN53dvQRuk4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-B_XD4nRSOWGQw8ScdCxHGQ-1; Fri, 24 Jan 2025 04:45:54 -0500
X-MC-Unique: B_XD4nRSOWGQw8ScdCxHGQ-1
X-Mimecast-MFC-AGG-ID: B_XD4nRSOWGQw8ScdCxHGQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so1541615f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711952; x=1738316752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNWd0azXgUd9sSMT4kGbMLXTGKtKYehwsaTDvX4Hyhc=;
 b=QZ9M4vin/s/wG+KixS3VEZDBe5IF7NzVFrayq0y0QO2daOsXdL/f0yLRImWwimY/NR
 kK8L0RrjW5uZmTPqj4RfR+LAxsA53qDbtNS408koo3QHo1zb7ha/zUN3auiZFvYi6l/W
 +b8W8VsRSXNc40lc991pqyUSVJcSqNub5dIzq7GA3vLoLwEUqOBWrdaNiEZxtRfqiqpY
 VqMSQNwl/CMqMCHqbIbqD7GQNLOJJtDsJWTbB29CY3u9+8Ik80BV8WhYeN300fD1gnyA
 h1bsPDDwO/LPgACqbXfHzeB0G53YoOJoCI9/BCxYPic3HXa3nKJIDGn+UWKdSOr5AffE
 0f+Q==
X-Gm-Message-State: AOJu0YyAA4acY/2iuaxHhY/Y5h4OD+zxG+2US3eDfk4M2wVF3z2Sytan
 mqJdWKJ72a04tNevdIJiv2XokrpbHwEGbL4TEi1lv4L4OoBnIjnNFnCqtr8z0KQfrRhUZ11hM+8
 9E5sQJGlc54EBOUnq1x9YPYZC7LSzQj/lZ/tlftzFP8D84Gu641udG5U+R6mJNauu68iYNV4N07
 NkKVXbPSKJpKrsVvcenpL9/PneBqLNifuSGkEh3aY=
X-Gm-Gg: ASbGnctb2HiIa3PRmfGGNY27Srqji4qJS2o2d2zvu5PYI0epJ93DUTBGqKTcDrPSNla
 xiCZmKdYkcpKVYRI9j8uKpQqRU04ZraDpjYHP0kOS2VsIWXkt+GMp4x1yqj8aY+Dr0NgcaKzMNq
 +C7PHukyvW+ZY5VJIRDSAUsfhbd9bcBKu9DAACDQ6ftxzEvTPWKJducyWmfFFVpj9N9WyZew/qc
 HuJIgcSgCvIWZHNimJy6DZvLOWJjb4OPk20SwPH42Ue9p0WwIELfzIq0+puZ5OL4mfVqMQaFw==
X-Received: by 2002:a5d:64eb:0:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-38bf59ecb69mr29263172f8f.50.1737711952285; 
 Fri, 24 Jan 2025 01:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHug1mOEp4gPWlIm6m1dTVjvGq2gbv8pGjETnDCeokDkOefOv1bCruhmO9I4PHzf4Hy1nyZCQ==
X-Received: by 2002:a5d:64eb:0:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-38bf59ecb69mr29263126f8f.50.1737711951656; 
 Fri, 24 Jan 2025 01:45:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1885besm2138844f8f.49.2025.01.24.01.45.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/48] rust: vmstate: remove translation of C vmstate macros
Date: Fri, 24 Jan 2025 10:44:27 +0100
Message-ID: <20250124094442.13207-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Keep vmstate_clock!; because it uses a field of type VMStateDescription,
it cannot be converted to the VMState trait without access to the
const_refs_static feature.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 274 +++--------------------------------
 1 file changed, 23 insertions(+), 251 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index d3a9cffdf3f..120933e60da 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -21,8 +21,8 @@
 //!   [`vmstate_fields`](crate::vmstate_fields).
 //!
 //! * direct equivalents to the C macros declared in
-//!   `include/migration/vmstate.h`. These are not type-safe and should not be
-//!   used if the equivalent functionality is available with `vmstate_of!`.
+//!   `include/migration/vmstate.h`. These are not type-safe and only provide
+//!   functionality that is missing from `vmstate_of!`.
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
@@ -407,223 +407,16 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
     const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
-#[doc(alias = "VMSTATE_UNUSED_BUFFER")]
-#[macro_export]
-macro_rules! vmstate_unused_buffer {
-    ($field_exists_fn:expr, $version_id:expr, $size:expr) => {{
-        $crate::bindings::VMStateField {
-            name: c_str!("unused").as_ptr(),
-            err_hint: ::core::ptr::null(),
-            offset: 0,
-            size: $size,
-            start: 0,
-            num: 0,
-            num_offset: 0,
-            size_offset: 0,
-            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
-            flags: VMStateFlags::VMS_BUFFER,
-            vmsd: ::core::ptr::null(),
-            version_id: $version_id,
-            struct_version_id: 0,
-            field_exists: $field_exists_fn,
-        }
-    }};
-}
-
-#[doc(alias = "VMSTATE_UNUSED_V")]
-#[macro_export]
-macro_rules! vmstate_unused_v {
-    ($version_id:expr, $size:expr) => {{
-        $crate::vmstate_unused_buffer!(None, $version_id, $size)
-    }};
-}
-
 #[doc(alias = "VMSTATE_UNUSED")]
 #[macro_export]
 macro_rules! vmstate_unused {
     ($size:expr) => {{
-        $crate::vmstate_unused_v!(0, $size)
-    }};
-}
-
-#[doc(alias = "VMSTATE_SINGLE_TEST")]
-#[macro_export]
-macro_rules! vmstate_single_test {
-    ($field_name:ident, $struct_name:ty, $field_exists_fn:expr, $version_id:expr, $info:expr, $size:expr) => {{
         $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), 0)
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            err_hint: ::core::ptr::null(),
-            offset: $crate::offset_of!($struct_name, $field_name),
+            name: $crate::c_str!("unused").as_ptr(),
             size: $size,
-            start: 0,
-            num: 0,
-            num_offset: 0,
-            size_offset: 0,
-            info: unsafe { $info },
-            flags: VMStateFlags::VMS_SINGLE,
-            vmsd: ::core::ptr::null(),
-            version_id: $version_id,
-            struct_version_id: 0,
-            field_exists: $field_exists_fn,
-        }
-    }};
-}
-
-#[doc(alias = "VMSTATE_SINGLE")]
-#[macro_export]
-macro_rules! vmstate_single {
-    ($field_name:ident, $struct_name:ty, $version_id:expr, $info:expr, $size:expr) => {{
-        $crate::vmstate_single_test!($field_name, $struct_name, None, $version_id, $info, $size)
-    }};
-}
-
-#[doc(alias = "VMSTATE_UINT32_V")]
-#[macro_export]
-macro_rules! vmstate_uint32_v {
-    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
-        $crate::vmstate_single!(
-            $field_name,
-            $struct_name,
-            $version_id,
-            ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32),
-            ::core::mem::size_of::<u32>()
-        )
-    }};
-}
-
-#[doc(alias = "VMSTATE_UINT32")]
-#[macro_export]
-macro_rules! vmstate_uint32 {
-    ($field_name:ident, $struct_name:ty) => {{
-        $crate::vmstate_uint32_v!($field_name, $struct_name, 0)
-    }};
-}
-
-#[doc(alias = "VMSTATE_ARRAY")]
-#[macro_export]
-macro_rules! vmstate_array {
-    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr, $info:expr, $size:expr) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), 0)
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            err_hint: ::core::ptr::null(),
-            offset: $crate::offset_of!($struct_name, $field_name),
-            size: $size,
-            start: 0,
-            num: $length as _,
-            num_offset: 0,
-            size_offset: 0,
-            info: unsafe { $info },
-            flags: VMStateFlags::VMS_ARRAY,
-            vmsd: ::core::ptr::null(),
-            version_id: $version_id,
-            struct_version_id: 0,
-            field_exists: None,
-        }
-    }};
-}
-
-#[doc(alias = "VMSTATE_UINT32_ARRAY_V")]
-#[macro_export]
-macro_rules! vmstate_uint32_array_v {
-    ($field_name:ident, $struct_name:ty, $length:expr, $version_id:expr) => {{
-        $crate::vmstate_array!(
-            $field_name,
-            $struct_name,
-            $length,
-            $version_id,
-            ::core::ptr::addr_of!($crate::bindings::vmstate_info_uint32),
-            ::core::mem::size_of::<u32>()
-        )
-    }};
-}
-
-#[doc(alias = "VMSTATE_UINT32_ARRAY")]
-#[macro_export]
-macro_rules! vmstate_uint32_array {
-    ($field_name:ident, $struct_name:ty, $length:expr) => {{
-        $crate::vmstate_uint32_array_v!($field_name, $struct_name, $length, 0)
-    }};
-}
-
-#[doc(alias = "VMSTATE_STRUCT_POINTER_V")]
-#[macro_export]
-macro_rules! vmstate_struct_pointer_v {
-    ($field_name:ident, $struct_name:ty, $version_id:expr, $vmsd:expr, $type:ty) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), 0)
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            err_hint: ::core::ptr::null(),
-            offset: $crate::offset_of!($struct_name, $field_name),
-            size: ::core::mem::size_of::<*const $type>(),
-            start: 0,
-            num: 0,
-            num_offset: 0,
-            size_offset: 0,
-            info: ::core::ptr::null(),
-            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
-            vmsd: unsafe { $vmsd },
-            version_id: $version_id,
-            struct_version_id: 0,
-            field_exists: None,
-        }
-    }};
-}
-
-#[doc(alias = "VMSTATE_ARRAY_OF_POINTER")]
-#[macro_export]
-macro_rules! vmstate_array_of_pointer {
-    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $info:expr, $type:ty) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), 0)
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            version_id: $version_id,
-            num: $num as _,
-            info: unsafe { $info },
-            size: ::core::mem::size_of::<*const $type>(),
-            flags: VMStateFlags(VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0),
-            offset: $crate::offset_of!($struct_name, $field_name),
-            err_hint: ::core::ptr::null(),
-            start: 0,
-            num_offset: 0,
-            size_offset: 0,
-            vmsd: ::core::ptr::null(),
-            struct_version_id: 0,
-            field_exists: None,
-        }
-    }};
-}
-
-#[doc(alias = "VMSTATE_ARRAY_OF_POINTER_TO_STRUCT")]
-#[macro_export]
-macro_rules! vmstate_array_of_pointer_to_struct {
-    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr, $vmsd:expr, $type:ty) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), 0)
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            version_id: $version_id,
-            num: $num as _,
-            vmsd: unsafe { $vmsd },
-            size: ::core::mem::size_of::<*const $type>(),
-            flags: VMStateFlags(
-                VMStateFlags::VMS_ARRAY.0
-                    | VMStateFlags::VMS_STRUCT.0
-                    | VMStateFlags::VMS_ARRAY_OF_POINTER.0,
-            ),
-            offset: $crate::offset_of!($struct_name, $field_name),
-            err_hint: ::core::ptr::null(),
-            start: 0,
-            num_offset: 0,
-            size_offset: 0,
-            vmsd: ::core::ptr::null(),
-            struct_version_id: 0,
-            field_exists: None,
+            info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
+            flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
+            ..$crate::zeroable::Zeroable::ZERO
         }
     }};
 }
@@ -661,48 +454,27 @@ macro_rules! vmstate_struct {
     };
 }
 
-#[doc(alias = "VMSTATE_CLOCK_V")]
-#[macro_export]
-macro_rules! vmstate_clock_v {
-    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
-        $crate::vmstate_struct_pointer_v!(
-            $field_name,
-            $struct_name,
-            $version_id,
-            ::core::ptr::addr_of!($crate::bindings::vmstate_clock),
-            $crate::bindings::Clock
-        )
-    }};
-}
-
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
 macro_rules! vmstate_clock {
     ($field_name:ident, $struct_name:ty) => {{
-        $crate::vmstate_clock_v!($field_name, $struct_name, 0)
-    }};
-}
-
-#[doc(alias = "VMSTATE_ARRAY_CLOCK_V")]
-#[macro_export]
-macro_rules! vmstate_array_clock_v {
-    ($field_name:ident, $struct_name:ty, $num:expr, $version_id:expr) => {{
-        $crate::vmstate_array_of_pointer_to_struct!(
-            $field_name,
-            $struct_name,
-            $num,
-            $version_id,
-            ::core::ptr::addr_of!($crate::bindings::vmstate_clock),
-            $crate::bindings::Clock
-        )
-    }};
-}
-
-#[doc(alias = "VMSTATE_ARRAY_CLOCK")]
-#[macro_export]
-macro_rules! vmstate_array_clock {
-    ($field_name:ident, $struct_name:ty, $num:expr) => {{
-        $crate::vmstate_array_clock_v!($field_name, $struct_name, $name, 0)
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            offset: {
+                $crate::assert_field_type!(
+                    $struct_name,
+                    $field_name,
+                    core::ptr::NonNull<$crate::bindings::Clock>
+                );
+                $crate::offset_of!($struct_name, $field_name)
+            },
+            size: ::core::mem::size_of::<*const $crate::bindings::Clock>(),
+            flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
+            vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
     }};
 }
 
-- 
2.48.1


