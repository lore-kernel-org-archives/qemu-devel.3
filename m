Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CE3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS5G-00033i-IK; Tue, 18 Mar 2025 04:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4p-0002q7-Rh; Tue, 18 Mar 2025 04:13:39 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4j-0001JW-3R; Tue, 18 Mar 2025 04:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285605; x=1773821605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WRV9q3I4BxY6pISOntlXgPbEbz688/th6OA3C2ous9s=;
 b=h7dNLyanEvlm/E0QPYoBonRV37obMtMcExCuigEfeBFjEYHb2EK2D4wQ
 29e4jFGUwmph98ZsZQoxP1sA/MkxZykBxn1wobtG8ZYA7DqkMd3emewyR
 7I+alrXrHlzm6hgqj2m49g1Ybsnabsmms2ykMyYfFfZ0p7S839aoY9E8e
 onIuRUEd2Wl2QNmXruNWD0DVGrzLHZ1C/bsMQSvJJYCERrsyYBaae69gt
 sFFUiR4B54NojXB16CWi351cJ8lqQAn05gA7jBEI0KtpFPt2rXRCr7W+c
 lu3b10AEbr8Kuue3cXlRuIHtUkx+jroUouXfPrLiIIFxq2nrmbG0BB4QC w==;
X-CSE-ConnectionGUID: oabX3jhDTgmmS4Y3ctM/kw==
X-CSE-MsgGUID: N5XxMpBsSu+Hvm988elt1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621610"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621610"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:13:03 -0700
X-CSE-ConnectionGUID: BMPsBdZTTb6ueLpgwFFFxA==
X-CSE-MsgGUID: P+V6M/v8TvGs9izez2tagw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363294"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:13:02 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 13/14] rust/vmstate: Add unit test for pointer case
Date: Tue, 18 Mar 2025 16:32:47 +0800
Message-Id: <20250318083248.1402990-14-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318083248.1402990-1-zhao1.liu@intel.com>
References: <20250318083248.1402990-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

Add a unit test to cover some patterns accepted by vmstate_of macro,
which correspond to the following C version macros:
 * VMSTATE_POINTER
 * VMSTATE_ARRAY_OF_POINTER

Note: Currently, vmstate_struct can't handle the pointer to structure
case. Leave this case as a FIXME and use vmstate_unused as a place
holder.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 115 ++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 4 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index fbdc3ee955e4..9fcaad6a01ac 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,15 +2,16 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, slice};
+use std::{ffi::CStr, mem::size_of, ptr::NonNull, slice};
 
 use qemu_api::{
     bindings::{
-        vmstate_info_bool, vmstate_info_int64, vmstate_info_int8, vmstate_info_uint64,
-        vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
+        vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
+        vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
     c_str,
-    cell::BqlCell,
+    cell::{BqlCell, Opaque},
+    impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
     zeroable::Zeroable,
@@ -251,3 +252,109 @@ fn test_vmstate_macro_foob() {
     // The last VMStateField in VMSTATE_FOOB.
     assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOC ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOC:
+//     - VMSTATE_POINTER
+//     - VMSTATE_ARRAY_OF_POINTER
+struct FooCWrapper([Opaque<*mut u8>; FOO_ARRAY_MAX]); // Though Opaque<> array is almost impossible.
+
+impl_vmstate_forward!(FooCWrapper);
+
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooC {
+    ptr: *const i32,
+    ptr_a: NonNull<FooA>,
+    arr_ptr: [Box<u8>; FOO_ARRAY_MAX],
+    arr_ptr_wrap: FooCWrapper,
+}
+
+static VMSTATE_FOOC: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_c").as_ptr(),
+    version_id: 3,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooC, ptr).with_version_id(2),
+        // FIXME: Currently vmstate_struct doesn't support the pointer to structure.
+        // VMSTATE_STRUCT_POINTER: vmstate_struct!(FooC, ptr_a, VMSTATE_FOOA, NonNull<FooA>)
+        vmstate_unused!(size_of::<NonNull<FooA>>()),
+        vmstate_of!(FooC, arr_ptr),
+        vmstate_of!(FooC, arr_ptr_wrap),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_macro_fooc() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+
+    // 1st VMStateField ("ptr") in VMSTATE_FOOC (corresponding to VMSTATE_POINTER)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"ptr\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int32 });
+    assert_eq!(foo_fields[0].version_id, 2);
+    assert_eq!(foo_fields[0].size, 4);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(
+        foo_fields[0].flags.0,
+        VMStateFlags::VMS_SINGLE.0 | VMStateFlags::VMS_POINTER.0
+    );
+    assert_eq!(foo_fields[0].vmsd.is_null(), true);
+    assert_eq!(foo_fields[0].field_exists.is_none(), true);
+
+    // 2nd VMStateField ("unused") in VMSTATE_FOOC
+    let mut offset = size_of::<*const i32>();
+    let size_ptr_a = size_of::<NonNull<FooA>>();
+
+    // 3rd VMStateField ("arr_ptr") in VMSTATE_FOOC (corresponding to
+    // VMSTATE_ARRAY_OF_POINTER)
+    offset = offset + size_ptr_a;
+    let size_arr_ptr = size_of::<Box<[FooB; FOO_ARRAY_MAX]>>();
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr_ptr\0"
+    );
+    assert_eq!(foo_fields[2].offset, offset);
+    assert_eq!(foo_fields[2].num_offset, 0);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[2].version_id, 0);
+    assert_eq!(foo_fields[2].size, size_arr_ptr);
+    assert_eq!(foo_fields[2].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
+    );
+    assert_eq!(foo_fields[2].vmsd.is_null(), true);
+    assert_eq!(foo_fields[2].field_exists.is_none(), true);
+
+    // 4th VMStateField ("arr_ptr_wrap") in VMSTATE_FOOC (corresponding to
+    // VMSTATE_ARRAY_OF_POINTER)
+    offset = offset + size_of::<Box<u8>>() * FOO_ARRAY_MAX;
+    let size_arr_ptr_wrap = size_of::<Opaque<*mut u8>>();
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_ptr_wrap\0"
+    );
+    assert_eq!(foo_fields[3].offset, offset);
+    assert_eq!(foo_fields[3].num_offset, 0);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[3].version_id, 0);
+    assert_eq!(foo_fields[3].size, size_arr_ptr_wrap);
+    assert_eq!(foo_fields[3].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
+    );
+    assert_eq!(foo_fields[3].vmsd.is_null(), true);
+    assert_eq!(foo_fields[3].field_exists.is_none(), true);
+
+    // The last VMStateField in VMSTATE_FOOC.
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
+}
-- 
2.34.1


