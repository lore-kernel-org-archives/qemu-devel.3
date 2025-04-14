Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81095C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoG-0003H4-AF; Mon, 14 Apr 2025 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko5-0003Ci-HJ; Mon, 14 Apr 2025 10:29:07 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko3-00064t-DK; Mon, 14 Apr 2025 10:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640943; x=1776176943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GzS64O2hk/JA+khEXR5sy4DpnE89caJbyZrlyQSwIBE=;
 b=mQx+NFvTKov2dpzzkIT5POz2j8945OsZuE9XJOkHMyWjW31drlu+wyJZ
 0gAXgRtJkHnHILIHy0jUhfTH96k8JXY2qfj6CemDqPf1YGVQlQQdfjMKw
 YHp3lnOAdi8e3G5rCcpuvQ2VUJqvR8oxStPznyVm//YgM6oeZG1oct7fG
 tBLx1P7ZPgW3Yhgl/pSsyAeYh1b1yeGs/RImDjEiC7V8nT/A3qXnxFf8W
 XTvSPLlMXZ5QTfZVDs8+QsLgC8A5Vy3Lt3uBptpnHYEhfjFdpOZ8LAS2J
 TFSk3cqkZR4hM6a3McQRNFxr3P0gM7Q4PjMEdUZSGyTZN/0BzogxZ1Jgk w==;
X-CSE-ConnectionGUID: NgAkI0i2ReiS6qEfwLGURg==
X-CSE-MsgGUID: uhXGdTWqQ+yAh2CbZwh3rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501829"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501829"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:28:59 -0700
X-CSE-ConnectionGUID: 87EZugvOS1WCk/nYiSK/og==
X-CSE-MsgGUID: 2QJh8lE3S8i4NdHnc/zYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606054"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:28:57 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/9] rust/vmstate: Support field_exists check in
 vmstate_struct macro
Date: Mon, 14 Apr 2025 22:49:35 +0800
Message-Id: <20250414144943.1112885-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unfortunately, at present it's not possible to have a const
"with_exist_check" method to append test_fn after vmstate_struct (due
to error on "constant functions cannot evaluate destructors" for `F`).

Before the vmstate builder, the only way to support "test_fn" is to
extend vmstate_struct macro to add the such new optional member (and
fortunately, Rust can still parse the current expansion!).

Abstract the previous callback implementation of vmstate_validate into
a separate macro, and moves it before vmstate_struct for vmstate_struct
to call.

Note that there's no need to add any extra flag for a new test_fn added
in the VMStateField.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 67 +++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 1b2b12eadd6e..7d9f3a2ca6f2 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -435,6 +435,38 @@ macro_rules! vmstate_unused {
     }};
 }
 
+pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> bool {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    F::call((owner, version))
+}
+
+pub type VMSFieldExistCb = unsafe extern "C" fn(
+    opaque: *mut std::os::raw::c_void,
+    version_id: std::os::raw::c_int,
+) -> bool;
+
+#[macro_export]
+macro_rules! vmstate_exist_fn {
+    ($struct_name:ty, $test_fn:expr) => {{
+        const fn test_cb_builder__<T, F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>>(
+            _phantom: ::core::marker::PhantomData<F>,
+        ) -> $crate::vmstate::VMSFieldExistCb {
+            let _: () = F::ASSERT_IS_SOME;
+            $crate::vmstate::rust_vms_test_field_exists::<T, F>
+        }
+
+        const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
+            ::core::marker::PhantomData
+        }
+        Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
+    }};
+}
+
 // FIXME: including the `vmsd` field in a `const` is not possible without
 // the const_refs_static feature (stabilized in Rust 1.83.0).  Without it,
 // it is not possible to use VMS_STRUCT in a transparent manner using
@@ -445,7 +477,7 @@ macro_rules! vmstate_unused {
 #[doc(alias = "VMSTATE_STRUCT")]
 #[macro_export]
 macro_rules! vmstate_struct {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(, $test_fn:expr)? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
@@ -458,6 +490,7 @@ macro_rules! vmstate_struct {
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
+            $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             ..$crate::zeroable::Zeroable::ZERO
          } $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
@@ -514,43 +547,13 @@ macro_rules! vmstate_fields {
     }}
 }
 
-pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
-    opaque: *mut c_void,
-    version_id: c_int,
-) -> bool {
-    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
-    let version: u8 = version_id.try_into().unwrap();
-    // SAFETY: the opaque was passed as a reference to `T`.
-    F::call((owner, version))
-}
-
-pub type VMSFieldExistCb = unsafe extern "C" fn(
-    opaque: *mut std::os::raw::c_void,
-    version_id: std::os::raw::c_int,
-) -> bool;
-
 #[doc(alias = "VMSTATE_VALIDATE")]
 #[macro_export]
 macro_rules! vmstate_validate {
     ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::std::ffi::CStr::as_ptr($test_name),
-            field_exists: {
-                const fn test_cb_builder__<
-                    T,
-                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>,
-                >(
-                    _phantom: ::core::marker::PhantomData<F>,
-                ) -> $crate::vmstate::VMSFieldExistCb {
-                    let _: () = F::ASSERT_IS_SOME;
-                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
-                }
-
-                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
-                    ::core::marker::PhantomData
-                }
-                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
-            },
+            field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
             flags: $crate::bindings::VMStateFlags(
                 $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
                     | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
-- 
2.34.1


