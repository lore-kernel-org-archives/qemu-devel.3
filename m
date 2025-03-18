Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5560EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWI8-0000iV-FD; Tue, 18 Mar 2025 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHE-0007vQ-6S; Tue, 18 Mar 2025 08:42:37 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWH7-0002wP-TP; Tue, 18 Mar 2025 08:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301750; x=1773837750;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wX3QMai9xL8PQqOayrd5Iq357bOMqNE+wmwuWyUDFeE=;
 b=m79glV8ZIs51fIBvtRaMRSp5ucX9ninvyKSuiiQ0CQwzZrSrIoJYn4ri
 SwQnQWs64ZzNVxcdq97+apNDuLyVfJAQwXeafXLybdP/GT3j/GfQI2Byi
 yfWWswIpfOu9Y+BfeBFPpDqOSPsoXeipakgKypgxrfJhNv0cfHhCl18Im
 L6X0gqylSd/1gaZYha9hYQS4BQVwgNdbXSDxRF/8uKNnX4M2sQluf1F6s
 Zt1BDBrKeVl27gl+/f7VFwoNcRPrLURDdc35rnyILFX4gw+4GKXfb4QDw
 5Ds6ponxgsdJvnbIyiRRTITzl0ECO8Ta4OQdxjGqTvgbMWbaNFtHcWSzV w==;
X-CSE-ConnectionGUID: HwD2FVjkQzGtgvSJE6DkqQ==
X-CSE-MsgGUID: 2rAD1009R7Cl2VGpXeWLoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824621"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824621"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:24 -0700
X-CSE-ConnectionGUID: WGXmqjYMRsOtOFwRHGtSVA==
X-CSE-MsgGUID: XouxEgTdQsugm2PkMrQfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980475"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 11/15] rust/vmstate: Add unit test for vmstate_of macro
Date: Tue, 18 Mar 2025 21:02:15 +0800
Message-Id: <20250318130219.1799170-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318130219.1799170-1-zhao1.liu@intel.com>
References: <20250318130219.1799170-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The vmstate has too many combinations of VMStateFlags and VMStateField.
Currently, the best way to test is to ensure that the Rust vmstate
definition is consistent with the (possibly corresponding) C version.

Add a unit test to cover some patterns accepted by vmstate_of macro,
which correspond to the following C version macros:
 * VMSTATE_U16
 * VMSTATE_UNUSED
 * VMSTATE_VARRAY_UINT16_UNSAFE
 * VMSTATE_VARRAY_MULTIPLY

Note: Because vmstate_info_* are defined in vmstate-types.c, it's
necessary to link libmigration to rust unit tests. In the future,
maybe it's possible to spilt libmigration from rust_qemu_api_objs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/meson.build            |   5 +-
 rust/qemu-api/tests/tests.rs         |   2 +
 rust/qemu-api/tests/vmstate_tests.rs | 119 +++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a3f226ccc2a5..858685ddd4a4 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -58,7 +58,8 @@ rust_qemu_api_objs = static_library(
               libchardev.extract_all_objects(recursive: false),
               libcrypto.extract_all_objects(recursive: false),
               libauthz.extract_all_objects(recursive: false),
-              libio.extract_all_objects(recursive: false)])
+              libio.extract_all_objects(recursive: false),
+              libmigration.extract_all_objects(recursive: false)])
 rust_qemu_api_deps = declare_dependency(
     dependencies: [
       qom_ss.dependencies(),
@@ -71,7 +72,7 @@ rust_qemu_api_deps = declare_dependency(
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-        'tests/tests.rs',
+        files('tests/tests.rs', 'tests/vmstate_tests.rs'),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 269122e7ec19..99a7aab6fed9 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -17,6 +17,8 @@
     zeroable::Zeroable,
 };
 
+mod vmstate_tests;
+
 // Test that macros can compile.
 pub static VMSTATE: VMStateDescription = VMStateDescription {
     name: c_str!("name").as_ptr(),
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
new file mode 100644
index 000000000000..29d4ea774850
--- /dev/null
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -0,0 +1,119 @@
+// Copyright (C) 2025 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{ffi::CStr, mem::size_of, slice};
+
+use qemu_api::{
+    bindings::{vmstate_info_int8, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags},
+    c_str,
+    vmstate::{VMStateDescription, VMStateField},
+    vmstate_fields, vmstate_of, vmstate_unused,
+    zeroable::Zeroable,
+};
+
+const FOO_ARRAY_MAX: usize = 3;
+
+// =========================== Test VMSTATE_FOOA ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOA:
+//     - VMSTATE_U16
+//     - VMSTATE_UNUSED
+//     - VMSTATE_VARRAY_UINT16_UNSAFE
+//     - VMSTATE_VARRAY_MULTIPLY
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooA {
+    arr: [u8; FOO_ARRAY_MAX],
+    num: u16,
+    arr_mul: [i8; FOO_ARRAY_MAX],
+    num_mul: u32,
+    elem: i8,
+}
+
+static VMSTATE_FOOA: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_a").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooA, elem),
+        vmstate_unused!(size_of::<i64>()),
+        vmstate_of!(FooA, arr[0 .. num]).with_version_id(0),
+        vmstate_of!(FooA, arr_mul[0 .. num_mul * 16]),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_macro_fooa() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+
+    // 1st VMStateField ("elem") in VMSTATE_FOOA (corresponding to VMSTATE_U16)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"elem\0"
+    );
+    assert_eq!(foo_fields[0].offset, 16);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int8 });
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_SINGLE);
+    assert_eq!(foo_fields[0].vmsd.is_null(), true);
+    assert_eq!(foo_fields[0].field_exists.is_none(), true);
+
+    // 2nd VMStateField ("unused") in VMSTATE_FOOA (corresponding to VMSTATE_UNUSED)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"unused\0"
+    );
+    assert_eq!(foo_fields[1].offset, 0);
+    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_unused_buffer });
+    assert_eq!(foo_fields[1].version_id, 0);
+    assert_eq!(foo_fields[1].size, 8);
+    assert_eq!(foo_fields[1].num, 0);
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_BUFFER);
+    assert_eq!(foo_fields[1].vmsd.is_null(), true);
+    assert_eq!(foo_fields[1].field_exists.is_none(), true);
+
+    // 3rd VMStateField ("arr") in VMSTATE_FOOA (corresponding to
+    // VMSTATE_VARRAY_UINT16_UNSAFE)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr\0"
+    );
+    assert_eq!(foo_fields[2].offset, 0);
+    assert_eq!(foo_fields[2].num_offset, 4);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[2].version_id, 0);
+    assert_eq!(foo_fields[2].size, 1);
+    assert_eq!(foo_fields[2].num, 0);
+    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY_UINT16);
+    assert_eq!(foo_fields[2].vmsd.is_null(), true);
+    assert_eq!(foo_fields[2].field_exists.is_none(), true);
+
+    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
+    // VMSTATE_VARRAY_MULTIPLY)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_mul\0"
+    );
+    assert_eq!(foo_fields[3].offset, 6);
+    assert_eq!(foo_fields[3].num_offset, 12);
+    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
+    assert_eq!(foo_fields[3].version_id, 0);
+    assert_eq!(foo_fields[3].size, 1);
+    assert_eq!(foo_fields[3].num, 16);
+    assert_eq!(
+        foo_fields[3].flags.0,
+        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
+    );
+    assert_eq!(foo_fields[3].vmsd.is_null(), true);
+    assert_eq!(foo_fields[3].field_exists.is_none(), true);
+
+    // The last VMStateField in VMSTATE_FOOA.
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
+}
-- 
2.34.1


