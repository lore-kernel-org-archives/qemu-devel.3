Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD0606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvnmF6sY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnId-0003Sd-N5; Tue, 24 Nov 2026 04:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIc-0003Ro-7J; Tue, 24 Nov 2026 04:58:54 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIY-0003K3-GD; Tue, 24 Nov 2026 04:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795514331; x=1827050331;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DVwYvVWxMY1PdzYQsm5pfXAd4doI2HvJzCprfOKzqDU=;
 b=mvnmF6sY4jdJYF/lVetLkOn/GNZ4J7T2NkZNppse1/TqtG/NvWxpvj4C
 6tGDuXc72fJB6/UuS2qUiWZQWPzei0fqXsL0Ju1Qgb+D00GQ5w6/CNF2m
 s3b3NAq7r3w6jgkrzHXUbx3YInPIEKpTJpHO8UmKZdV9LO1X4r6sfm7in
 R2Aj3O5PCnHe1f5Mp6ugR20sitpEogd9TdTJyo7fsEZK8ajG/kr7W2h68
 0WruAQM+bX4mrB8htDVQBdBK4PXXiv7fpCo5Q465qNELoxm2tWTcz9Z8Y
 hAwFsGOZ3iveGiN8zBJALwBvyKw5dTI00oWXw6zzOpEgUqy39pthOaCmq A==;
X-CSE-ConnectionGUID: KlhQL6AgRO2gQZ5FbfPCrQ==
X-CSE-MsgGUID: PNOL+sp3SNqN8NXBVzkl0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4398007"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4398007"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:58:33 -0800
X-CSE-ConnectionGUID: WINqE3TUSgqXfFoOCfiSEQ==
X-CSE-MsgGUID: clquDMuMQ8qenzg5u+Az4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13206390"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa012.fm.intel.com with ESMTP; 24 Nov 2026 01:58:31 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] rust/migration: Allow usize as the length of a varray
Date: Tue, 24 Nov 2026 17:58:12 +0800
Message-Id: <20261124095814.437738-2-zhao1.liu@intel.com>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit f9f70b50e3eb ("migration: Introduce VMStateStructMember")
and commit 1f0b40dccfe5 ("Rmigration: Remove redundant flags"), the
length of a varray is no longer tied to a specific integer type.

This makes it possible to use `usize` type for varray length. It's safe
since it is used only to resolve varray lengths in the local vmstate
code and is not used for migration.

Thus, implement a "dummy" VMState for `usize` so that it can provide
VARRAY_FLAG, and panic when anyone tries to define VMStateField with
`usize` type (including integers, pointers, [usize; N], Box<usize>,
BqlCell<usize>, etc).

In addition, add a test case for such case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/migration/src/vmstate.rs     | 16 ++++++++--
 rust/tests/tests/vmstate_tests.rs | 49 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5ed061f2abb6..0b05db4e7049 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -97,8 +97,8 @@ pub unsafe trait VMState {
 
     /// A flag that is added to another field's `VMStateField` to specify the
     /// length's type in a variable-sized array.  If this is not a supported
-    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
-    /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
+    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`, `usize`),
+    /// using it in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
     /// compile-time error.
     #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const VARRAY_FLAG: VMStateFlags = {
@@ -256,6 +256,18 @@ unsafe impl $crate::vmstate::VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, util::timer::Timer);
 
+// SAFETY: BASE is never produced (any use of a usize as migrated data will
+// always result in a compile-time error). VARRAY_FLAG only tells the C code to
+// read `size_of::<usize>()` bytes (see `size_of_field_type!`) at the length's
+// offset.
+unsafe impl VMState for usize {
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
+    const BASE: VMStateField = {
+        panic!("usize cannot be migrated, use a fixed-size integer type");
+    };
+    const VARRAY_FLAG: VMStateFlags = VMStateFlags::VMS_VARRAY;
+}
+
 #[macro_export]
 macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 6578d54b37d4..b680cfd3c783 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -483,3 +483,52 @@ fn test_vmstate_validate() {
     // The last VMStateField in VMSTATE_FOOD.
     assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOE ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOE:
+//     - VMSTATE_VARRAY with a `usize` length
+#[repr(C)]
+#[derive(Default)]
+struct FooE {
+    arr: [u8; FOO_ARRAY_MAX],
+    num: usize,
+}
+
+static VMSTATE_FOOE: VMStateDescription<FooE> = VMStateDescriptionBuilder::<FooE>::new()
+    .name(c"foo_e")
+    .version_id(1)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
+        vmstate_of!(FooE, arr[0 .. num]),
+    })
+    .build();
+
+#[test]
+fn test_vmstate_varray_usize() {
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOE.as_ref().fields, 2) };
+
+    // 1st VMStateField ("arr") in VMSTATE_FOOE
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"arr\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(
+        foo_fields[0].num_indirect.offset,
+        std::mem::offset_of!(FooE, num) as u32
+    );
+    assert_eq!(foo_fields[0].num_indirect.size, size_of::<usize>() as u8);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_VARRAY);
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(foo_fields[0].field_exists.is_none());
+
+    // The last VMStateField in VMSTATE_FOOE.
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_END);
+}
-- 
2.34.1


