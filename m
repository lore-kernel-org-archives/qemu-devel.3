Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC0C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiEI-00021d-Pc; Fri, 17 Jan 2025 04:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEH-00020R-3A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiE9-00085T-5P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOt3f+8UTPP9tgmhHLRL6fKjbSiAqZOk7IsRwsCirFA=;
 b=VNBp+/yMoAGFqh9za6rEHrG4Txai2lUhcupUMtMEthilNoBTccRBBs5yedqhw2PYkFIVIo
 d0opxUnkurQ62H/58YVVnCWQeyXPE+pN735joVo3tHchbmX46n/fIkYeAugjTmkyt3JhVd
 n0Rc9gkXF9rj64ZcqlE8sm64A/2Ov8M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-OJxVoxQ6PkCGqWmGv9bJ8g-1; Fri, 17 Jan 2025 04:01:14 -0500
X-MC-Unique: OJxVoxQ6PkCGqWmGv9bJ8g-1
X-Mimecast-MFC-AGG-ID: OJxVoxQ6PkCGqWmGv9bJ8g
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aafc90962ffso211913566b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104473; x=1737709273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOt3f+8UTPP9tgmhHLRL6fKjbSiAqZOk7IsRwsCirFA=;
 b=pAwbwf8xpim9pidb4wWOu01RfFv3pRxGlNoB4aJKkeNd/6VAoVJM8D3hnf+alwIUMf
 ZUqsPjt7CiqsxcxFR7+0jzYM6xBJq4OTs6r5PEqwCPLQqxP5yYu46iLDKbkoiq3iPYhA
 RwzYi3l8acZpfLIMZUAPLej7gz5UKypVqHZVEbSVCkC5KCUCEfFjqDebK1Upe4QsUfCY
 UT4oegf/bo3ulAZSxcubNv+ThVBkd+0D1zii4DhNQ+M5A+gHqTr7c4kit4VASss/JHpM
 5d1w8P8VHpSAjYITVjG+X52BsZfVEebLhavKIqz/TOq+TEpSqCica2ek7ZkRgXEOdTvt
 M1qA==
X-Gm-Message-State: AOJu0YwW5FUyie359DEGdNn1yPLWDbbfbfSpXhlzGLs1My0u53B1eJqQ
 1xW8hOECvQokAXqg8AaHxlnoHNfoeoO0rOYiVTKG504cPoOVcB5TkxLow1KM3pKrRRrXVXzx0Li
 h4knVWuo1x7Va9u5hsNcArXytSwYSDP4fKCYq9fxLSWHU2PdrkEpwmDuiPour2dcXa/hFxn8dZl
 GQuyGvuPu44XRUVYtSTDdhzLgR9QuLIzXDrFjI3ps=
X-Gm-Gg: ASbGncvaa7NxH6b69k5sBmPFdv93x2hqzFlpY2Q1c2ttYYfLVJHTKhSKDAFilEjAYEs
 RgE3YSHZwIXBS29t7jy7uWH83DNZ6YMdrz2DxvwaI/7mlg+vWJcUgNaIEi1gYLoiyuBKA8wPM9w
 iMj6LtDylDStWdjiTRHtiTYDH0N+an3sn0/PC0hLkAjA8e1/5W8I+WBhz3HoFvIsyvcWrmTgHDR
 VCBz7dXthiky7Z5vC/pZDWv7UjFmbokuCY5HDhmwxPmFnfgJBMDrrT4lHd2
X-Received: by 2002:a17:907:97ca:b0:aa6:7881:1e84 with SMTP id
 a640c23a62f3a-ab38b231d63mr146345166b.15.1737104472745; 
 Fri, 17 Jan 2025 01:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF90MTO1Q4FoHoXxivuEUIRCUnY5Wx26PnCJeB1XPqPFzYUIszV5CcOn3jBnQ9CRzS194WjpA==
X-Received: by 2002:a17:907:97ca:b0:aa6:7881:1e84 with SMTP id
 a640c23a62f3a-ab38b231d63mr146341266b.15.1737104471920; 
 Fri, 17 Jan 2025 01:01:11 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8442esm133647466b.129.2025.01.17.01.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:01:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 09/10] rust: vmstate: remove translation of C vmstate macros
Date: Fri, 17 Jan 2025 10:00:45 +0100
Message-ID: <20250117090046.1045010-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

Keep vmstate_clock!; because it uses a field of type VMStateDescription,
it cannot be converted to the VMState trait without access to the
const_refs_static feature.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 274 +++--------------------------------
 1 file changed, 23 insertions(+), 251 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 94a2a29fe7e..70dd3c4fc48 100644
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
2.47.1


