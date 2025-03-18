Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03894C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWIU-0001EJ-RB; Tue, 18 Mar 2025 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHa-0008Rh-EN; Tue, 18 Mar 2025 08:42:59 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHY-0002we-6I; Tue, 18 Mar 2025 08:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301777; x=1773837777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LUXWJuyyc6fHNfaVCBSggoXhRDzrtT3wzS+QLB2WhFg=;
 b=URDaO0yE0zYwFlg1wDc3cEEwY0yogldUv9AwAbg8E8cTKwhFX+9AoEYw
 9ktLSuj9YDszyEGAAM3WwdGdqMi5y47FQd00jQR4UfPY57IFTzOZ0JBIC
 rc2Tub550S0kscuKJhb8n+kAz1nMhjVi2dO7ZHELB3wCx3TucqMHCcxiW
 EI1RLv72T2TGFU+4tkIOGvPwzBpFcpOtAffu2DNqDNyiAc0PgkyphY9n3
 2T1BxDufNm7ke2Qmy8+AjYdX6P1l6NO49aSCpCjQypjaT2RDT1vt/kIWB
 PuYwNVFnjuf9N8PTjaIoTeDTjRWAwsnXC1zJ8a1ram/5FSI9ivbPjmFCG w==;
X-CSE-ConnectionGUID: SvrrKiDxSwePmIQ1vDOA5w==
X-CSE-MsgGUID: h0l+OxONRdODYjrC47sJmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824645"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824645"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:29 -0700
X-CSE-ConnectionGUID: Et3taQeRQDKjSu3HkHY5PQ==
X-CSE-MsgGUID: +sRWdBtmQPqmrIig3lciZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980499"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 14/15] rust/vmstate: Add unit test for vmstate_validate
Date: Tue, 18 Mar 2025 21:02:18 +0800
Message-Id: <20250318130219.1799170-15-zhao1.liu@intel.com>
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

Add a unit test for vmstate_validate, which corresponds to the C version
macro: VMSTATE_VALIDATE.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 91 +++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 9fcaad6a01ac..aa6bd18ef784 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, ptr::NonNull, slice};
+use std::{ffi::CStr, mem::size_of, os::raw::c_void, ptr::NonNull, slice};
 
 use qemu_api::{
     bindings::{
@@ -13,7 +13,7 @@
     cell::{BqlCell, Opaque},
     impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
     zeroable::Zeroable,
 };
 
@@ -358,3 +358,90 @@ fn test_vmstate_macro_fooc() {
     // The last VMStateField in VMSTATE_FOOC.
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOD ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOD:
+//     - VMSTATE_VALIDATE
+
+// Add more member fields when vmstate_of/vmstate_struct support "test"
+// parameter.
+struct FooD;
+
+impl FooD {
+    fn validate_food_0(&self, _version_id: u8) -> bool {
+        true
+    }
+
+    fn validate_food_1(_state: &FooD, _version_id: u8) -> bool {
+        false
+    }
+}
+
+fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
+    true
+}
+
+static VMSTATE_FOOD: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_d").as_ptr(),
+    version_id: 3,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_validate!(FooD, c_str!("foo_d_0"), FooD::validate_food_0),
+        vmstate_validate!(FooD, c_str!("foo_d_1"), FooD::validate_food_1),
+        vmstate_validate!(FooD, c_str!("foo_d_2"), validate_food_2),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_macro_food() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOD.fields, 4) };
+    let mut foo_d = FooD;
+    let foo_d_p = &mut foo_d as *mut _ as *mut c_void;
+
+    // 1st VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"foo_d_0\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info.is_null(), true);
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 0);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(
+        foo_fields[0].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_MUST_EXIST.0
+    );
+    assert_eq!(foo_fields[0].vmsd.is_null(), true);
+    assert_eq!(
+        unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) },
+        true
+    );
+
+    // 2nd VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"foo_d_1\0"
+    );
+    assert_eq!(
+        unsafe { foo_fields[1].field_exists.unwrap()(foo_d_p, 1) },
+        false
+    );
+
+    // 3rd VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"foo_d_2\0"
+    );
+    assert_eq!(
+        unsafe { foo_fields[2].field_exists.unwrap()(foo_d_p, 2) },
+        true
+    );
+
+    // The last VMStateField in VMSTATE_FOOD.
+    assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
+}
-- 
2.34.1


