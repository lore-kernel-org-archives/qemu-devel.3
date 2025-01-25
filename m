Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D81C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLC-0008FQ-AN; Sat, 25 Jan 2025 07:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL5-0008Dc-7I; Sat, 25 Jan 2025 07:32:42 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL2-0005TJ-IR; Sat, 25 Jan 2025 07:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808356; x=1769344356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uG8yPSeRPHsZyPZ+Zad72ZfjphYl5oyDQSD5QikG5aM=;
 b=TnBuRoVIiBHsypTvR7FSrG6g9qIKmlWYHA8P3/mLdXlOKjLtR7useWEn
 fvYEil4H65Z6RIFD7a+SHc5qu9uCH7t8oYvFzKA+poRphcBTmhyzTd8ev
 1wcah65iUPrzkpZc1V+SWwL1qe9Ri2/PtgTQ1XXj8wc/8f0xGFrewDOox
 hED4Y0bXc9eWrCUV1jHdUZQoWRfVJOmhsiBtezYI0VJcnpO+YDiSMrmhD
 bN+KIZuAKkTtJlvNY/PZJMfdXnq+MCKpoIK7sYo4GvLh0CSndepcCk3Oo
 xXKsfxSqcZIfhd0jy0Fa6i81TmwVFqtc74MYHSLK80yjVZ9zrZfd7ZCz+ w==;
X-CSE-ConnectionGUID: MBTQvNuBTJOFKlfUE7u42A==
X-CSE-MsgGUID: CGaHuT2jTMesHmRJe5EHIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434711"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434711"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:35 -0800
X-CSE-ConnectionGUID: gHZ4qDm7TEiGsE4fzd9baQ==
X-CSE-MsgGUID: kqtPSj9YRfS4kuRIzKraOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897670"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:32 -0800
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
Subject: [PATCH 04/10] rust: add bindings for gpio_{in|out} initialization
Date: Sat, 25 Jan 2025 20:51:31 +0800
Message-Id: <20250125125137.1223277-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125125137.1223277-1-zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 rust/qemu-api/src/qdev.rs | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 32740c873604..96ca8b8aa9ad 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -6,16 +6,17 @@
 
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
+    irq::{IRQState, InterruptSource},
     prelude::*,
     qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
@@ -278,6 +279,38 @@ fn do_init_clock_in(
         // IsA<DeviceState> bound.
         do_init_clock_in(unsafe { self.as_mut_ptr() }, name, cb, events)
     }
+
+    fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(&self, num_lines: u32, _f: F) {
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
+                InterruptSource::as_slice_of_qemu_irq(pins).as_ptr() as *mut *mut IRQState,
+                pins.len() as c_int,
+            );
+        }
+    }
 }
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
-- 
2.34.1


