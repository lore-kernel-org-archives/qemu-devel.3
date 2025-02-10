Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D08C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJjz-0000AC-I4; Sun, 09 Feb 2025 21:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjy-00009P-53; Sun, 09 Feb 2025 21:41:42 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjr-00087T-S1; Sun, 09 Feb 2025 21:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155296; x=1770691296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8WPc18u0djTU3OQIdYk4SifKW86kcsabADf2I4OvMZM=;
 b=HDBx0Ih3a68w53gChkKk1hyCSDJIK4UbnmHAOtc/W/TwIAgX5/McVw5b
 txaDQkAfjdn3Xsv7+UJi9mlitInm2r8uKj+MylV3MtohKt7LBkr+E6c6c
 frTQK3IMx3nZwlyX2C3HWAFrH1pktv9OJIV489xfHuVzywOwxwvpbJh/Q
 q8woRMBlR1cwH5PMsvwZvkxk1WA8SGMiupJBf9dt22NAfZmDf1L5Bsnrx
 UFDtRigJDqa1jGn7QuW000GbAXkhocZAujY7Twz/JY6GfAqkb2Ruq+pzn
 zMnkw/b88x5z4Ie06YLzmpc8FPPkWzMEPqpqphnvR77XTUpbHuOB0SiPM A==;
X-CSE-ConnectionGUID: fUGNWf3qRfO5P8HTUHPNhw==
X-CSE-MsgGUID: N1EdpplSR9O4SW82BNWm9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351254"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351254"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:35 -0800
X-CSE-ConnectionGUID: Zlt4wv88QseNUpg5M+oaTA==
X-CSE-MsgGUID: 7PD3YtXATWOL+pEM2QuaSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938219"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 04/10] rust: add bindings for gpio_{in|out} initialization
Date: Mon, 10 Feb 2025 11:00:45 +0800
Message-Id: <20250210030051.2562726-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

Wrap qdev_init_gpio_{in|out} as methods in DeviceMethods. And for
qdev_init_gpio_in, based on FnCall, it can support idiomatic Rust
callback without the need for C style wrapper.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Use FnCall to support gpio in callback.
 * Place gpio_{in|out} in DeviceMethods.
 * Accept &[InterruptSource] as the parameter of gpio_out.

Changes since Patch v1:
 * Ensure the handler of input GPIO is not none.
 * Fix doc issue. No need to specify InterruptSource path in doc.
---
 rust/qemu-api/src/irq.rs  |  1 -
 rust/qemu-api/src/qdev.rs | 47 +++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 05f617b5684a..f87cd0c7d318 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -84,7 +84,6 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
         self.cell.as_ptr()
     }
 
-    #[allow(dead_code)]
     pub(crate) fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 28d9be723d89..17f12ad1361c 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -6,17 +6,18 @@
 
 use std::{
     ffi::{CStr, CString},
-    os::raw::c_void,
+    os::raw::{c_int, c_void},
     ptr::NonNull,
 };
 
 pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property, ResetType};
 
 use crate::{
-    bindings::{self, Error, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error, ResettableClass},
     callbacks::FnCall,
     cell::bql_locked,
     chardev::Chardev,
+    irq::InterruptSource,
     prelude::*,
     qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
@@ -28,8 +29,8 @@ pub trait ResettablePhasesImpl {
     /// If not None, this is called when the object enters reset. It
     /// can reset local state of the object, but it must not do anything that
     /// has a side-effect on other objects, such as raising or lowering an
-    /// [`InterruptSource`](crate::irq::InterruptSource), or reading or
-    /// writing guest memory. It takes the reset's type as argument.
+    /// [`InterruptSource`], or reading or writing guest memory. It takes the
+    /// reset's type as argument.
     const ENTER: Option<fn(&Self, ResetType)> = None;
 
     /// If not None, this is called when the object for entry into reset, once
@@ -320,6 +321,44 @@ fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
             bindings::qdev_prop_set_chr(self.as_mut_ptr(), c_propname.as_ptr(), chr.as_mut_ptr());
         }
     }
+
+    fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(
+        &self,
+        num_lines: u32,
+        _cb: F,
+    ) {
+        let _: () = F::ASSERT_IS_SOME;
+
+        unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
+            opaque: *mut c_void,
+            line: c_int,
+            level: c_int,
+        ) {
+            // SAFETY: the opaque was passed as a reference to `T`
+            F::call((unsafe { &*(opaque.cast::<T>()) }, line as u32, level as u32))
+        }
+
+        let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
+            rust_irq_handler::<Self::Target, F>;
+
+        unsafe {
+            qdev_init_gpio_in(
+                self.as_mut_ptr::<DeviceState>(),
+                Some(gpio_in_cb),
+                num_lines as c_int,
+            );
+        }
+    }
+
+    fn init_gpio_out(&self, pins: &[InterruptSource]) {
+        unsafe {
+            qdev_init_gpio_out(
+                self.as_mut_ptr::<DeviceState>(),
+                InterruptSource::slice_as_ptr(pins),
+                pins.len() as c_int,
+            );
+        }
+    }
 }
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
-- 
2.34.1


