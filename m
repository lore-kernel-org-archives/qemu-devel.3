Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C92C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBqW-00059F-7S; Mon, 17 Mar 2025 10:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBqC-00053Z-Mw; Mon, 17 Mar 2025 10:53:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBq7-00061r-Pp; Mon, 17 Mar 2025 10:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223196; x=1773759196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JJzBpmkuXBkWgo/j127Zd05e1uWPFCqolsBxz46da9s=;
 b=HyiBHneNnh3/2NaiIqi50k2yLmLTcrfucgAW/yTb7NSTxW5uWRX07IoF
 uMyZiqiEbKiixxcuZmmmI8y3Qdb0yvz3Z1IUdRdvvVrk6rb6jtWtmK2jY
 v9rFX/YiDFblCpH3S7QnFEFVIAnbDfRWaxpidWGkNjvbpiKPpP7y/U+qQ
 hRreBB6sa3IBSr01qby1ma3APd3UGX/0p1hIMgPgMb1D4NPoApyMAPAtM
 FfgbHaQYHls4/dP5+8WYfE8H+NpC28DZpapKoxxbNz3vIp6z22PU2S0Vf
 /fw7i7pAnyzszne0YUI6iwJCxMlw0o8jZtvcp/EIAcCLGPTVmQZMnk1Wr Q==;
X-CSE-ConnectionGUID: VDqHH0HyRvuQ0/cz6oOlNQ==
X-CSE-MsgGUID: fXaWtS7bQRi3woTYjo6fxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694629"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694629"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:45 -0700
X-CSE-ConnectionGUID: 31M0k6ldTOKjVWuc8I5mow==
X-CSE-MsgGUID: xdsA3wCpSmmlfj64COZg3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988548"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 13/17] rust/vmstate: Support vmstate_validate
Date: Mon, 17 Mar 2025 23:12:32 +0800
Message-Id: <20250317151236.536673-14-zhao1.liu@intel.com>
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

In C version, VMSTATE_VALIDATE accepts the function pointer, which is
used to check if some conditions of structure could meet, although the
C version macro doesn't accept any structure as the opaque type.

But it's hard to integrate VMSTATE_VALIDAE into vmstate_struct, a new
macro has to be introduced to specifically handle the case corresponding
to VMSTATE_VALIDATE.

One of the difficulties is inferring the type of a callback by its name
`test_fn`. We can't directly use `test_fn` as a parameter of
test_cb_builder__() to get its type "F", because in this way, Rust
compiler will be too conservative on drop check and complain "the
destructor for this type cannot be evaluated in constant functions".

Fortunately, PhantomData<T> could help in this case, because it is
considered to never have a destructor, no matter its field type [*].

The `phantom__()` in the `call_func_with_field` macro provides a good
example of using PhantomData to infer type. So copy this idea and apply
it to the `vmstate_validate` macro.

[*]: https://doc.rust-lang.org/std/ops/trait.Drop.html#drop-check

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/vmstate.rs | 57 +++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index bb41bfd291c0..4eefd54ca120 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -25,9 +25,12 @@
 //!   functionality that is missing from `vmstate_of!`.
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
+use std::os::raw::{c_int, c_void};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Zeroable};
+use crate::{
+    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
+};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -292,6 +295,14 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
         self.num = num as i32;
         self
     }
+
+    #[must_use]
+    pub const fn with_exist_check(mut self) -> Self {
+        assert!(self.flags.0 == 0);
+        self.flags = VMStateFlags(VMStateFlags::VMS_MUST_EXIST.0 | VMStateFlags::VMS_ARRAY.0);
+        self.num = 0; // 0 elements: no data, only run test_fn callback
+        self
+    }
 }
 
 /// This macro can be used (by just passing it a type) to forward the `VMState`
@@ -510,6 +521,50 @@ macro_rules! vmstate_fields {
     }}
 }
 
+pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> bool {
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((owner, version))
+}
+
+pub type VMSFieldExistCb = unsafe extern "C" fn(
+    opaque: *mut std::os::raw::c_void,
+    version_id: std::os::raw::c_int,
+) -> bool;
+
+#[doc(alias = "VMSTATE_VALIDATE")]
+#[macro_export]
+macro_rules! vmstate_validate {
+    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::std::ffi::CStr::as_ptr($test_name),
+            // TODO: Use safe callback.
+            field_exists: {
+                const fn test_cb_builder__<
+                    T,
+                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>,
+                >(
+                    _phantom: ::core::marker::PhantomData<F>,
+                ) -> $crate::vmstate::VMSFieldExistCb {
+                    let _: () = F::ASSERT_IS_SOME;
+                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
+                }
+
+                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
+                    ::core::marker::PhantomData
+                }
+                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
+            },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+        .with_exist_check()
+    };
+}
+
 /// A transparent wrapper type for the `subsections` field of
 /// [`VMStateDescription`].
 ///
-- 
2.34.1


