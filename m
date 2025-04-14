Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC98C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoH-0003Iv-TX; Mon, 14 Apr 2025 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko7-0003Cz-Qa; Mon, 14 Apr 2025 10:29:08 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko6-00064c-5Z; Mon, 14 Apr 2025 10:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640946; x=1776176946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xmXhAXufJu3sy+jBApLS1oicn7zUw2MrY8g9h6TstV4=;
 b=OzNs4vnpS3ZdIvyRvmE/+mr8srskJW8Y//lAg6huav5wmlAaa2jT8QcY
 4Cjy6V3yCBJ764oRe1S3O/Iw+W6yzk4HE1PD1dIrqGHlOu4OkqSMgnucy
 0oPBN9GuEkNzHCT9Uy5s+WYje6FyWnP9XyFvbGCgT5cEHmXXtqvSLi/eA
 jlnX+81gHFR218Qqqxw8x13zumVgVfO8n1pTIZsXrF6gQFr2AF6/Md/So
 snZlCnfaZ/HucPjMTKv6Y78mAp9WAjQyyl8BW3KLvWZD+GI/xWasrGGqz
 4+cMWExROS4E99mdQF0bOGmpvtC/EltjWfBqXjnX/mItBjXqrMIK/BZQ+ w==;
X-CSE-ConnectionGUID: mKMsD/DOQHCeHeugUDCrhw==
X-CSE-MsgGUID: md7Ll7oiScOD+vNeiBvoHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501836"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:03 -0700
X-CSE-ConnectionGUID: kjni5+TyTiWDscgLuKhgvw==
X-CSE-MsgGUID: 3ue7hE8gTSeRJ0fc7gpohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606067"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/9] rust/vmstate_test: Test varray with num field wrapped in
 BqlCell
Date: Mon, 14 Apr 2025 22:49:37 +0800
Message-Id: <20250414144943.1112885-4-zhao1.liu@intel.com>
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 41 ++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index b8d8b45b19de..d1e37c45eea4 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -28,7 +28,7 @@
 //     - VMSTATE_VARRAY_UINT16_UNSAFE
 //     - VMSTATE_VARRAY_MULTIPLY
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(Default, qemu_api_macros::offsets)]
 struct FooA {
     arr: [u8; FOO_ARRAY_MAX],
     num: u16,
@@ -147,8 +147,9 @@ fn test_vmstate_varray_multiply() {
 //     - VMSTATE_STRUCT_VARRAY_UINT8
 //     - (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
 //     - VMSTATE_ARRAY
+//     - VMSTATE_STRUCT_VARRAY_UINT8 with BqlCell wrapper & test_fn
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(Default, qemu_api_macros::offsets)]
 struct FooB {
     arr_a: [FooA; FOO_ARRAY_MAX],
     num_a: u8,
@@ -158,6 +159,12 @@ struct FooB {
     val: bool,
     // FIXME: Use Timer array. Now we can't since it's hard to link savevm.c to test.
     arr_i64: [i64; FOO_ARRAY_MAX],
+    arr_a_wrap: [FooA; FOO_ARRAY_MAX],
+    num_a_wrap: BqlCell<u32>,
+}
+
+fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
+    true
 }
 
 static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
@@ -170,13 +177,14 @@ struct FooB {
         vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
         vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
         vmstate_of!(FooB, arr_i64),
+        vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
     },
     ..Zeroable::ZERO
 };
 
 #[test]
 fn test_vmstate_bool_v() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 1st VMStateField ("val") in VMSTATE_FOOB (corresponding to VMSTATE_BOOL_V)
     assert_eq!(
@@ -196,7 +204,7 @@ fn test_vmstate_bool_v() {
 
 #[test]
 fn test_vmstate_uint64() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 2nd VMStateField ("wrap") in VMSTATE_FOOB (corresponding to VMSTATE_U64)
     assert_eq!(
@@ -216,7 +224,7 @@ fn test_vmstate_uint64() {
 
 #[test]
 fn test_vmstate_struct_varray_uint8() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 3rd VMStateField ("arr_a") in VMSTATE_FOOB (corresponding to
     // VMSTATE_STRUCT_VARRAY_UINT8)
@@ -240,7 +248,7 @@ fn test_vmstate_struct_varray_uint8() {
 
 #[test]
 fn test_vmstate_struct_varray_uint32_multiply() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
     // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
@@ -266,7 +274,7 @@ fn test_vmstate_struct_varray_uint32_multiply() {
 
 #[test]
 fn test_vmstate_macro_array() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 5th VMStateField ("arr_i64") in VMSTATE_FOOB (corresponding to
     // VMSTATE_ARRAY)
@@ -283,9 +291,26 @@ fn test_vmstate_macro_array() {
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_ARRAY);
     assert!(foo_fields[4].vmsd.is_null());
     assert!(foo_fields[4].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_struct_varray_uint8_wrapper() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let mut foo_b: FooB = Default::default();
+    let foo_b_p = std::ptr::addr_of_mut!(foo_b).cast::<c_void>();
+
+    // 6th VMStateField ("arr_a_wrap") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_STRUCT_VARRAY_UINT8). Other fields are checked in
+    // test_vmstate_struct_varray_uint8.
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[5].name) }.to_bytes_with_nul(),
+        b"arr_a_wrap\0"
+    );
+    assert_eq!(foo_fields[5].num_offset, 228);
+    assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
 
     // The last VMStateField in VMSTATE_FOOB.
-    assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
+    assert_eq!(foo_fields[6].flags, VMStateFlags::VMS_END);
 }
 
 // =========================== Test VMSTATE_FOOC ===========================
-- 
2.34.1


