Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7F9C35FFA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWLz-0003bd-5i; Tue, 18 Mar 2025 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHV-0008I6-UH; Tue, 18 Mar 2025 08:42:53 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWHT-0002we-AG; Tue, 18 Mar 2025 08:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301772; x=1773837772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S0m7KRq5Ui1gk8/x2KtA7lizHbDll0NmXB5KwgO99qI=;
 b=dcUkwDgwva7U1za+qYcfG6Kf6/NEoGZDei3m3m1j3kwZ7OUz3aMzz1th
 GBJqIBhKiEhPecddduX7aUMciuAMotFgaBy18ImHFb5ChzM5+W9dkzhkp
 DL6qKF0T+CrXdgU0SPnMNRnf4q+SoTnWYRoTSBE0pNhNa4Og8c5/MVeWh
 wgHGXhyj1MEoNaOw1lQclMj5xlcO0QgFT9NjQ/+DkVu7MIsAe6OhKAl/O
 TGFPl2NWLMHJxnqsIsxWyL1YZwImP8I3K9JPOwkWdqR8WWEZi3JUc2O9j
 h8d6dp4NT0JGf/HVaoPDXf+KFhCeejiH+jR69HqXTJ80u3grt+0iireVA Q==;
X-CSE-ConnectionGUID: dDmE3jwMT7aE5oL/j717sw==
X-CSE-MsgGUID: CTeJ4X5fTcej4aQ/gRasIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824614"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824614"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:23 -0700
X-CSE-ConnectionGUID: Cx6t65SHQOaZx0yWFfI64A==
X-CSE-MsgGUID: 4kBWLVX/Sk+awEDf/Q+G3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980467"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 10/15] rust/vmstate: Support vmstate_validate
Date: Tue, 18 Mar 2025 21:02:14 +0800
Message-Id: <20250318130219.1799170-11-zhao1.liu@intel.com>
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
Changes since v1:
 * Rename `with_exist_check()` to `with_validate_flag()`.
 * Add a `with_exist_check()` method to help add field_exists callback,
   though it can't be used in static VMStateDescription definition but
   will be useful for vmstate builder.

Changes since v2:
 * Drop `with_exist_check()` and `with_validate_flag()`.
---
 rust/qemu-api/src/vmstate.rs | 52 +++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 01f06ed7379e..9740931fb16a 100644
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
@@ -508,6 +511,53 @@ macro_rules! vmstate_fields {
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
+            flags: $crate::bindings::VMStateFlags(
+                $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
+                    | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
+            ),
+            num: 0, // 0 elements: no data, only run test_fn callback
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    };
+}
+
 /// A transparent wrapper type for the `subsections` field of
 /// [`VMStateDescription`].
 ///
-- 
2.34.1


