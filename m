Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqr-0005cR-L7; Mon, 17 Mar 2025 10:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBqX-0005B4-0R; Mon, 17 Mar 2025 10:53:41 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBqU-00061l-4N; Mon, 17 Mar 2025 10:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223218; x=1773759218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o/cCiZqwR2S01d6FSeGG52kdEOPERtZPPVXkHHmKRGM=;
 b=fjD1xLhTMLKOlGCb5MxJVzDXI53lptt4JsUI1zLDnRCG9K7Oofsv0eZN
 h3HRseoKh/5OIrQ2Xj4TACDUjAZVlanufv+MvzrqigNfke9+/G2le8L4T
 M0RKucgRZ0sByCzhJr2gtYMeT1MzMLZx9Xa+dgPqeMbmva89TRmARrdpn
 MIzKBOixGRtCaQNe5rUi+chMoULUapmMQvyyul79yfKVy1arvNyL7iu4I
 crKjXW8E5MoLhp5zUFq7PHL+dwQoDnLL1MolGRr4l2s/pVwRcU7128nCR
 l0qRanL/tjwo65R2byIOHF5chvsI6+0SUStZUsnzGVcz2ZaFW3gCjFx2r Q==;
X-CSE-ConnectionGUID: o5e9cyn9Tw+l0Q2sW3Rn1Q==
X-CSE-MsgGUID: 8nz5ty/BQQ6CbS8Uk5wu3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694633"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:48 -0700
X-CSE-ConnectionGUID: 6nYwngHvRXaX8M7x8sdqLg==
X-CSE-MsgGUID: Dhs3Fb9+TLCjp7If2KtZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988563"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:46 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 15/17] rust/vmstate: Add unit test for vmstate_{of|struct}
 macro
Date: Mon, 17 Mar 2025 23:12:34 +0800
Message-Id: <20250317151236.536673-16-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317151236.536673-1-zhao1.liu@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

Add a unit test to cover some patterns accepted by vmstate_of and
vmstate_struct macros, which correspond to the following C version
macros:

 * VMSTATE_BOOL_V
 * VMSTATE_U64
 * VMSTATE_STRUCT_VARRAY_UINT8
 * (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
 * VMSTATE_ARRAY

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 144 ++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 25b28b298066..27df66b5766e 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -5,10 +5,14 @@
 use std::{ffi::CStr, mem::size_of, slice};
 
 use qemu_api::{
-    bindings::{vmstate_info_int8, vmstate_info_uint8, vmstate_info_unused_buffer},
+    bindings::{
+        vmstate_info_bool, vmstate_info_int64, vmstate_info_int8, vmstate_info_uint64,
+        vmstate_info_uint8, vmstate_info_unused_buffer,
+    },
     c_str,
+    cell::BqlCell,
     vmstate::{VMStateDescription, VMStateField, VMStateFlags},
-    vmstate_fields, vmstate_of, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
     zeroable::Zeroable,
 };
 
@@ -125,3 +129,139 @@ fn test_vmstate_macro_fooa() {
     // The last VMStateField in VMSTATE_FOOA.
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOB ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOB:
+//     - VMSTATE_BOOL_V
+//     - VMSTATE_U64
+//     - VMSTATE_STRUCT_VARRAY_UINT8
+//     - (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
+//     - VMSTATE_ARRAY
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooB {
+    arr_a: [FooA; FOO_ARRAY_MAX],
+    num_a: u8,
+    arr_a_mul: [FooA; FOO_ARRAY_MAX],
+    num_a_mul: u32,
+    wrap: BqlCell<u64>,
+    val: bool,
+    // FIXME: Use Timer array. Now we can't since it's hard to link savevm.c to test.
+    arr_i64: [i64; FOO_ARRAY_MAX],
+}
+
+static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_b").as_ptr(),
+    version_id: 2,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooB, val, version = 2),
+        vmstate_of!(FooB, wrap),
+        vmstate_struct!(FooB, arr_a, [0 .. num_a], VMSTATE_FOOA, FooA, version = 1),
+        vmstate_struct!(FooB, arr_a_mul, [0 .. num_a_mul * 32], VMSTATE_FOOA, FooA, version = 2),
+        vmstate_of!(FooB, arr_i64),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_macro_foob() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 1st VMStateField ("val") in VMSTATE_FOOB (corresponding to VMSTATE_BOOL_V)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"val\0"
+    );
+    assert_eq!(foo_fields[0].offset, 136);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe {
+        ::core::ptr::addr_of!(vmstate_info_bool)
+    });
+    assert_eq!(foo_fields[0].version_id, 2);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_SINGLE);
+    assert_eq!(foo_fields[0].vmsd.is_null(), true);
+    assert_eq!(foo_fields[0].field_exists.is_none(), true);
+
+    // 2nd VMStateField ("wrap") in VMSTATE_FOOB (corresponding to VMSTATE_U64)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"wrap\0"
+    );
+    assert_eq!(foo_fields[1].offset, 128);
+    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].info, unsafe {
+        ::core::ptr::addr_of!(vmstate_info_uint64)
+    });
+    assert_eq!(foo_fields[1].version_id, 0);
+    assert_eq!(foo_fields[1].size, 8);
+    assert_eq!(foo_fields[1].num, 0);
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_SINGLE);
+    assert_eq!(foo_fields[1].vmsd.is_null(), true);
+    assert_eq!(foo_fields[1].field_exists.is_none(), true);
+
+    // 3rd VMStateField ("arr_a") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_STRUCT_VARRAY_UINT8)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr_a\0"
+    );
+    assert_eq!(foo_fields[2].offset, 0);
+    assert_eq!(foo_fields[2].num_offset, 60);
+    assert_eq!(foo_fields[2].info.is_null(), true); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
+    assert_eq!(foo_fields[2].version_id, 1);
+    assert_eq!(foo_fields[2].size, 20);
+    assert_eq!(foo_fields[2].num, 0);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY_UINT8.0
+    );
+    assert_eq!(foo_fields[2].vmsd, &VMSTATE_FOOA);
+    assert_eq!(foo_fields[2].field_exists.is_none(), true);
+
+    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
+    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_a_mul\0"
+    );
+    assert_eq!(foo_fields[3].offset, 64);
+    assert_eq!(foo_fields[3].num_offset, 124);
+    assert_eq!(foo_fields[3].info.is_null(), true); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
+    assert_eq!(foo_fields[3].version_id, 2);
+    assert_eq!(foo_fields[3].size, 20);
+    assert_eq!(foo_fields[3].num, 32);
+    assert_eq!(
+        foo_fields[3].flags.0,
+        VMStateFlags::VMS_STRUCT.0
+            | VMStateFlags::VMS_VARRAY_UINT32.0
+            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
+    );
+    assert_eq!(foo_fields[3].vmsd, &VMSTATE_FOOA);
+    assert_eq!(foo_fields[3].field_exists.is_none(), true);
+
+    // 5th VMStateField ("arr_i64") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_ARRAY)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[4].name) }.to_bytes_with_nul(),
+        b"arr_i64\0"
+    );
+    assert_eq!(foo_fields[4].offset, 144);
+    assert_eq!(foo_fields[4].num_offset, 0);
+    assert_eq!(foo_fields[4].info, unsafe {
+        ::core::ptr::addr_of!(vmstate_info_int64)
+    });
+    assert_eq!(foo_fields[4].version_id, 0);
+    assert_eq!(foo_fields[4].size, 8);
+    assert_eq!(foo_fields[4].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_ARRAY);
+    assert_eq!(foo_fields[4].vmsd.is_null(), true);
+    assert_eq!(foo_fields[4].field_exists.is_none(), true);
+
+    // The last VMStateField in VMSTATE_FOOB.
+    assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
+}
-- 
2.34.1


