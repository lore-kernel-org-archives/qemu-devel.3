Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A6606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=krjuTD9g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnIf-0003TQ-Dd; Tue, 24 Nov 2026 04:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnId-0003SM-Fh; Tue, 24 Nov 2026 04:58:55 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIb-0003KH-CS; Tue, 24 Nov 2026 04:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795514333; x=1827050333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yt8r2a9q/r9XIHexB7j+/pOGrtFAgUSVVVn8elAYLhU=;
 b=krjuTD9gnsdz4pxdG/GePMV9hF/SNZ4ZUJJJrLD9+8fHtf2JfsRhwaec
 2dWQx2HjO4PY7OCpUJ2BeCRXvTpL9i4Ls1tGHuqbphrOqwqLNu1H8M2TA
 bKeLHyPSQthS5JgeFVnp0IyZY/6toidaHdkWtBrtSnMOp9pwFEpiLgc9Y
 m4EyFSzM1wXCfzkhSmmdQ5G/nvpNMnslA6aKEsEFvfae2waJE5CCzZB7A
 9TN48T6/bN2mGsZC71C2c8hMwDYswHUgE8MRByVQwka6EkSMeUMJhgIP9
 X8z9QBxqO1uFl09eaZClAQD6EOiNC45LTpaboe2gU8dR+a3RXSy96bdON g==;
X-CSE-ConnectionGUID: j4xPE8yBTEGAmwkj5Y8izQ==
X-CSE-MsgGUID: Jpyp3sbQTeO5Gia39QP/gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4398044"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4398044"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:58:38 -0800
X-CSE-ConnectionGUID: phs0CoebRU2k2/qBo3Ug4g==
X-CSE-MsgGUID: RuNdwEufR4q0uCFXCsluyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13206426"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa012.fm.intel.com with ESMTP; 24 Nov 2026 01:58:36 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/3] rust/migration: Remove vmstate_validate!() macro and test
Date: Tue, 24 Nov 2026 17:58:14 +0800
Message-Id: <20261124095814.437738-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124095814.437738-1-zhao1.liu@intel.com>
References: <20261124095814.437738-1-zhao1.liu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We have moved all users (in Rust side) to other API, now they're never
used.

After the related test (originally FOOD) was removed, rename FOOE to
new FOOD test.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/migration/src/prelude.rs     |  1 -
 rust/migration/src/vmstate.rs     | 17 ------
 rust/tests/tests/vmstate_tests.rs | 93 +++----------------------------
 3 files changed, 8 insertions(+), 103 deletions(-)

diff --git a/rust/migration/src/prelude.rs b/rust/migration/src/prelude.rs
index 797e7ec59d1b..e2cbbda43e0a 100644
--- a/rust/migration/src/prelude.rs
+++ b/rust/migration/src/prelude.rs
@@ -16,4 +16,3 @@
 pub use crate::vmstate_of;
 pub use crate::vmstate_subsections;
 pub use crate::vmstate_unused;
-pub use crate::vmstate_validate;
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 0b05db4e7049..ec8b712cbf86 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -384,23 +384,6 @@ macro_rules! vmstate_fields {
     }}
 }
 
-#[doc(alias = "VMSTATE_VALIDATE")]
-#[macro_export]
-macro_rules! vmstate_validate {
-    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
-        $crate::bindings::VMStateField {
-            name: ::std::ffi::CStr::as_ptr($test_name),
-            field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
-                    | $crate::bindings::VMStateFlags::VMS_NO_STATE.0,
-            ),
-            num: 0, // 0 elements: no data, only run test_fn callback
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-}
-
 /// Helper macro to allow using a struct in [`vmstate_of!`]
 ///
 /// # Safety
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index b680cfd3c783..9dbbb848b85c 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -411,106 +411,29 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
 // Test the use cases of the vmstate macro, corresponding to the following C
 // macro variants:
 //   * VMSTATE_FOOD:
-//     - VMSTATE_VALIDATE
-
-// Add more member fields when vmstate_of support "test" parameter.
-struct FooD;
-
-impl FooD {
-    fn validate_food_0(&self, _version_id: u8) -> bool {
-        true
-    }
-
-    fn validate_food_1(_state: &FooD, _version_id: u8) -> bool {
-        false
-    }
-}
-
-fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
-    true
-}
-
-static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
-    .name(c"foo_d")
-    .version_id(3)
-    .minimum_version_id(1)
-    .fields(vmstate_fields! {
-        vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
-        vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
-        vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
-    })
-    .build();
-
-#[test]
-fn test_vmstate_validate() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 4) };
-    let mut foo_d = FooD;
-    let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
-
-    // 1st VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
-        b"foo_d_0\0"
-    );
-    assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_indirect.size, 0);
-    assert!(foo_fields[0].info.is_null());
-    assert_eq!(foo_fields[0].version_id, 0);
-    assert_eq!(foo_fields[0].size, 0);
-    assert_eq!(foo_fields[0].num, 0);
-    assert_eq!(
-        foo_fields[0].flags.0,
-        VMStateFlags::VMS_NO_STATE.0 | VMStateFlags::VMS_MUST_EXIST.0
-    );
-    assert!(foo_fields[0].vmsd.is_null());
-    assert!(unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) });
-
-    // 2nd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
-        b"foo_d_1\0"
-    );
-    assert!(!unsafe { foo_fields[1].field_exists.unwrap()(foo_d_p, 1) });
-
-    // 3rd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
-        b"foo_d_2\0"
-    );
-    assert!(unsafe { foo_fields[2].field_exists.unwrap()(foo_d_p, 2) });
-
-    // The last VMStateField in VMSTATE_FOOD.
-    assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
-}
-
-// =========================== Test VMSTATE_FOOE ===========================
-// Test the use cases of the vmstate macro, corresponding to the following C
-// macro variants:
-//   * VMSTATE_FOOE:
 //     - VMSTATE_VARRAY with a `usize` length
 #[repr(C)]
 #[derive(Default)]
-struct FooE {
+struct FooD {
     arr: [u8; FOO_ARRAY_MAX],
     num: usize,
 }
 
-static VMSTATE_FOOE: VMStateDescription<FooE> = VMStateDescriptionBuilder::<FooE>::new()
-    .name(c"foo_e")
+static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
+    .name(c"foo_d")
     .version_id(1)
     .minimum_version_id(1)
     .fields(vmstate_fields! {
-        vmstate_of!(FooE, arr[0 .. num]),
+        vmstate_of!(FooD, arr[0 .. num]),
     })
     .build();
 
 #[test]
 fn test_vmstate_varray_usize() {
     let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOE.as_ref().fields, 2) };
+        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 2) };
 
-    // 1st VMStateField ("arr") in VMSTATE_FOOE
+    // 1st VMStateField ("arr") in VMSTATE_FOOD
     assert_eq!(
         unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
         b"arr\0"
@@ -518,7 +441,7 @@ fn test_vmstate_varray_usize() {
     assert_eq!(foo_fields[0].offset, 0);
     assert_eq!(
         foo_fields[0].num_indirect.offset,
-        std::mem::offset_of!(FooE, num) as u32
+        std::mem::offset_of!(FooD, num) as u32
     );
     assert_eq!(foo_fields[0].num_indirect.size, size_of::<usize>() as u8);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_uint8 });
@@ -529,6 +452,6 @@ fn test_vmstate_varray_usize() {
     assert!(foo_fields[0].vmsd.is_null());
     assert!(foo_fields[0].field_exists.is_none());
 
-    // The last VMStateField in VMSTATE_FOOE.
+    // The last VMStateField in VMSTATE_FOOD.
     assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_END);
 }
-- 
2.34.1


