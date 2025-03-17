Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD9DC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqq-0005Xv-Vx; Mon, 17 Mar 2025 10:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBqe-0005Fj-7H; Mon, 17 Mar 2025 10:53:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBqY-00061x-QK; Mon, 17 Mar 2025 10:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223223; x=1773759223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BOyzweld7qKvF11RnRDBGAq2KZU7zdOCfadzYxmbETI=;
 b=atgX2EKC8UmfEyKemKvSfwCTgBzri3SGe9Siz5ByeHeZu6290/dH9tCj
 R4dPLyrHwZF2kThdwgSv6eEw13MINpRiIApvg72/CYlh8p4yxZ5zesWhZ
 FxXiEJpxS63c9L3czbYP4L5+PtAbjfPleAHYaBu0jhNo8lAzikuXrg6ig
 SqxQZcUIzu+yoSI2y6lzITDSkk3IeOCb2DJiKbKoka225zW5qhHeUHuwA
 1vRmt/7/HRiI7ptmySHQ6hz4euiq2tRDqGDv0ZNa0NXkmXc4Te7xXDBjs
 6m4CnFQ7G552KikL3JtOQIWW6SBTqGXH+0SKNsSVbWwCP/2U+Og+/0R+n g==;
X-CSE-ConnectionGUID: 69H+VQS9TXGdmhXkfduncA==
X-CSE-MsgGUID: le1LMVSnQpicnhGvZAgchQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694641"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694641"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:51 -0700
X-CSE-ConnectionGUID: sXzEP//9QxShK6RLPse3uQ==
X-CSE-MsgGUID: IVEJBiLOQGm1ceiIQz4G3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988571"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:50 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 17/17] rust/vmstate: Add unit test for vmstate_validate
Date: Mon, 17 Mar 2025 23:12:36 +0800
Message-Id: <20250317151236.536673-18-zhao1.liu@intel.com>
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

Add a unit test for vmstate_validate, which corresponds to the C version
macro: VMSTATE_VALIDATE.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 91 +++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index a8bc00a56494..bb615fd7bdee 100644
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
     vmstate::{VMStateDescription, VMStateField, VMStateFlags},
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
     zeroable::Zeroable,
 };
 
@@ -378,3 +378,90 @@ fn test_vmstate_macro_fooc() {
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


