Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF86AC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS5B-0002yv-VG; Tue, 18 Mar 2025 04:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4p-0002q6-Qy; Tue, 18 Mar 2025 04:13:40 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4i-0001KN-HG; Tue, 18 Mar 2025 04:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285605; x=1773821605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ew3K9SiHr4mLMopCrq9vIDhx0busd8/4CABZ0pIW3OQ=;
 b=XkHTsaN0BrwPHzVChtBH5Gec3nwXXkfz8rMalxbPsiZ2//atQ+xDE7g+
 thRlerOoajxe5jLL7WbixdolN/CWFYqUZaehy7aiUOauYsQhsDL1jL+cb
 CCtMPQAgm1T+CoShtHerQgY/GgxU5h3tVjRtIo15G/xv7Fv0NB0jJ/88N
 jkjSLiIUEyj1iX8d1bygTbEYf3AMz0YUN0IAsUbt6E+tdrZS3gOpYcyId
 +bGW/2u4RsB5LjaAg075syHRuEn+WiSOBoFYKfQ4VGOMrf3OMECU4R8jt
 hVxzRiwZOGtcFfsUY2ny1siylxVfz8zVUk14wqNIVxgvRhhRyNTJaasft Q==;
X-CSE-ConnectionGUID: qWk/ZO8TRROvwBOBcUN6Wg==
X-CSE-MsgGUID: axA0HLGbREy//n6ucoI05g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621604"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621604"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:13:02 -0700
X-CSE-ConnectionGUID: le/hRlNhSKCFbXJMsYMFpg==
X-CSE-MsgGUID: /Fbxc0ebTSKxqzSQGq+MKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363278"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:13:00 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 12/14] rust/vmstate: Add unit test for vmstate_{of|struct}
 macro
Date: Tue, 18 Mar 2025 16:32:46 +0800
Message-Id: <20250318083248.1402990-13-zhao1.liu@intel.com>
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
 rust/qemu-api/tests/vmstate_tests.rs | 138 ++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 29d4ea774850..fbdc3ee955e4 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -5,10 +5,14 @@
 use std::{ffi::CStr, mem::size_of, slice};
 
 use qemu_api::{
-    bindings::{vmstate_info_int8, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags},
+    bindings::{
+        vmstate_info_bool, vmstate_info_int64, vmstate_info_int8, vmstate_info_uint64,
+        vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
+    },
     c_str,
+    cell::BqlCell,
     vmstate::{VMStateDescription, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
     zeroable::Zeroable,
 };
 
@@ -117,3 +121,133 @@ fn test_vmstate_macro_fooa() {
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
+        vmstate_of!(FooB, val).with_version_id(2),
+        vmstate_of!(FooB, wrap),
+        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
+        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
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
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_bool });
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
+    assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_uint64 });
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
+    assert_eq!(foo_fields[4].info, unsafe { &vmstate_info_int64 });
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


