Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02FFC021A1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJk1-0000An-3G; Sun, 09 Feb 2025 21:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjz-0000AI-PQ; Sun, 09 Feb 2025 21:41:43 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjx-00088s-Ns; Sun, 09 Feb 2025 21:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155302; x=1770691302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=atlW9CPzWUlAleUv5uCC+01KqSDTHP8baoSghJqOJ4E=;
 b=Pgb6/c/HtJb/mxRQsGcpI3Aiz0QV/x5SvZyz28nLKIB2NCTSXQbvf+oO
 EP7es/YFaTYM2GuriBuYHZZfN7iAwdhflXK5pUl2d/52kvEuo3qJuW+BK
 tcPH3G1JZCg07R9snzjf5M3vjyO8AtNRyrwGI3mR+/zFAlsk/XO0dGkUk
 D8VObNSQyQl40G36arbJNOYOkgWLz/5ZAArtPi1o2+QYUJAbMrtT9h/25
 FMrUp7vCPK27+P9TapfOhc2geIWRU9i1HHUifcFlPgp06xRlsdsvF9v07
 G1tuARAN/I4nB9kvDqcqkipcaGKxtkxDOFFyd/1ne4eqYNDJS7WY7sUVT A==;
X-CSE-ConnectionGUID: Ms/PnYTRSRqvKK9/x42Yjw==
X-CSE-MsgGUID: s8I7S8DpR5aSW4y+xx3d2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351269"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:41 -0800
X-CSE-ConnectionGUID: w0DHvat3TuqpLC1jwuEEcA==
X-CSE-MsgGUID: sMBZTORGTli6URDuipyBsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938227"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:38 -0800
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
Subject: [PATCH v2 06/10] rust: add bindings for timer
Date: Mon, 10 Feb 2025 11:00:47 +0800
Message-Id: <20250210030051.2562726-7-zhao1.liu@intel.com>
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

Add timer bindings to help handle idiomatic Rust callbacks.

Additionally, wrap QEMUClockType in ClockType binding to avoid unsafe
calls in device code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Use FnCall to support timer callback.
 * Only add timer_init_full() binding. timer_new() is unnecessary since
   device (HPET) could create and allocate QEMUTimer.
 * Implement Drop for QEMUTimer.
 * Add ClockType binding.

Changes since Patch v1:
 * Use Timer/TimerListGroup in Rust code instead of
   QEMUTimer/QEMUTimerListGroup.
 * Rename timer_init_full()/timer_mod() to init_full()/modify().
 * Ensure the callback passed to Timer::init() is not none.
 * Add as_mut_ptr()/delete() method for Timer.
 * Make ClockType's `id` field private, as well as make Timer::init()
   accept ClockType instead of QEMUClockType.
 * Drop used qemu_clock_get_virtual_ns().
 * Add MS/US/NS wrappers.
---
 meson.build                |  7 +++
 rust/qemu-api/meson.build  |  1 +
 rust/qemu-api/src/lib.rs   |  1 +
 rust/qemu-api/src/timer.rs | 98 ++++++++++++++++++++++++++++++++++++++
 rust/wrapper.h             |  1 +
 5 files changed, 108 insertions(+)
 create mode 100644 rust/qemu-api/src/timer.rs

diff --git a/meson.build b/meson.build
index 32abefb7c48c..20192347d4d6 100644
--- a/meson.build
+++ b/meson.build
@@ -4086,6 +4086,13 @@ if have_rust
   foreach enum : c_bitfields
     bindgen_args += ['--bitfield-enum', enum]
   endforeach
+  c_nocopy = [
+    'QEMUTimer',
+  ]
+  # Used to customize Drop trait
+  foreach struct : c_nocopy
+    bindgen_args += ['--no-copy', struct]
+  endforeach
 
   # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
   #
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 45e30324b295..2e9c1078b9b2 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -30,6 +30,7 @@ _qemu_api_rs = static_library(
       'src/qdev.rs',
       'src/qom.rs',
       'src/sysbus.rs',
+      'src/timer.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 1d7112445e24..047511d36487 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -25,6 +25,7 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
+pub mod timer;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
new file mode 100644
index 000000000000..05a5061b6dda
--- /dev/null
+++ b/rust/qemu-api/src/timer.rs
@@ -0,0 +1,98 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::os::raw::{c_int, c_void};
+
+use crate::{
+    bindings::{self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType},
+    callbacks::FnCall,
+};
+
+pub type Timer = bindings::QEMUTimer;
+pub type TimerListGroup = bindings::QEMUTimerListGroup;
+
+impl Timer {
+    pub fn new() -> Self {
+        Default::default()
+    }
+
+    const fn as_mut_ptr(&self) -> *mut Self {
+        self as *const Timer as *mut _
+    }
+
+    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
+        &'timer mut self,
+        timer_list_group: Option<&TimerListGroup>,
+        clk_type: ClockType,
+        scale: u32,
+        attributes: u32,
+        _cb: F,
+        opaque: &'opaque T,
+    ) where
+        F: for<'a> FnCall<(&'a T,)>,
+    {
+        let _: () = F::ASSERT_IS_SOME;
+
+        /// timer expiration callback
+        unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(
+            opaque: *mut c_void,
+        ) {
+            // SAFETY: the opaque was passed as a reference to `T`.
+            F::call((unsafe { &*(opaque.cast::<T>()) },))
+        }
+
+        let timer_cb: unsafe extern "C" fn(*mut c_void) = rust_timer_handler::<T, F>;
+
+        // SAFETY: the opaque outlives the timer
+        unsafe {
+            timer_init_full(
+                self,
+                if let Some(g) = timer_list_group {
+                    g as *const TimerListGroup as *mut _
+                } else {
+                    ::core::ptr::null_mut()
+                },
+                clk_type.id,
+                scale as c_int,
+                attributes as c_int,
+                Some(timer_cb),
+                (opaque as *const T).cast::<c_void>() as *mut c_void,
+            )
+        }
+    }
+
+    pub fn modify(&self, expire_time: u64) {
+        unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
+    }
+
+    pub fn delete(&self) {
+        unsafe { timer_del(self.as_mut_ptr()) }
+    }
+}
+
+impl Drop for Timer {
+    fn drop(&mut self) {
+        self.delete()
+    }
+}
+
+pub struct ClockType {
+    id: QEMUClockType,
+}
+
+impl ClockType {
+    pub fn get_ns(&self) -> u64 {
+        // SAFETY: cannot be created outside this module, therefore id
+        // is valid
+        (unsafe { qemu_clock_get_ns(self.id) }) as u64
+    }
+}
+
+pub const CLOCK_VIRTUAL: ClockType = ClockType {
+    id: QEMUClockType::QEMU_CLOCK_VIRTUAL,
+};
+
+pub const MS: u32 = bindings::SCALE_MS;
+pub const US: u32 = bindings::SCALE_US;
+pub const NS: u32 = bindings::SCALE_NS;
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 54839ce0f510..a35bfbd1760d 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -63,3 +63,4 @@ typedef enum memory_order {
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
+#include "qemu/timer.h"
-- 
2.34.1


