Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF24DC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLH-0008Ii-DV; Sat, 25 Jan 2025 07:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfLA-0008EM-Cw; Sat, 25 Jan 2025 07:32:44 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL8-0005Un-KY; Sat, 25 Jan 2025 07:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808362; x=1769344362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CG+zEQTxRSGBCyngVJmO+rcdFlbWKDTPQVhDRFOBO2E=;
 b=TnxMTzsLcPDPloB0sdpxIksLoIwVS051bHq69c5UvpHBHwNL29taCR+F
 pnCS84qUW5vucHl2NtbB+PmnbjA//ZHfQdPF5vpH4Tt6d8pC7tDJh4HWe
 5wmR9P8ehLSO7t/lc+2jCL8ySuZbTLUqIH+Uj8h0GNgNEQA4YhxKySgRy
 iM5y63w4cLWh+vvYvSAB09zQhdyhJh2l4h5hz3wcxjv/yljwpL5869dz4
 j+PAKbp3HmhtWqbCzfjFLhNoh9oVF7eNnN+wU6Co+RMx71iXWILbCCuCm
 5uJEWQPoUlU+j9rVpSzVREpD6bLayGXBO9fSm2UctT1R92WBthM/ahNto A==;
X-CSE-ConnectionGUID: xqULjQZrSdarcVbhB/zF2g==
X-CSE-MsgGUID: dnupu+TfSVS381pRfu+tvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434720"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:41 -0800
X-CSE-ConnectionGUID: BmSnw5WQQ9+FXMXJEeL7tw==
X-CSE-MsgGUID: 3xo0NBwBQPG2KrEgKNBfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897697"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:38 -0800
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
Subject: [PATCH 06/10] rust: add bindings for timer
Date: Sat, 25 Jan 2025 20:51:33 +0800
Message-Id: <20250125125137.1223277-7-zhao1.liu@intel.com>
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
---
 meson.build                |  7 +++
 rust/qemu-api/meson.build  |  1 +
 rust/qemu-api/src/lib.rs   |  1 +
 rust/qemu-api/src/timer.rs | 92 ++++++++++++++++++++++++++++++++++++++
 rust/wrapper.h             |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 rust/qemu-api/src/timer.rs

diff --git a/meson.build b/meson.build
index da91b47be48b..1ec88770a60a 100644
--- a/meson.build
+++ b/meson.build
@@ -4079,6 +4079,13 @@ if have_rust
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
index 80eafc7f6bd8..caed2b233991 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -29,6 +29,7 @@ _qemu_api_rs = static_library(
       'src/qdev.rs',
       'src/qom.rs',
       'src/sysbus.rs',
+      'src/timer.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 8cc095b13f6f..88825b69cff8 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -24,6 +24,7 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
+pub mod timer;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
new file mode 100644
index 000000000000..a1c7c7b4d9e6
--- /dev/null
+++ b/rust/qemu-api/src/timer.rs
@@ -0,0 +1,92 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::os::raw::{c_int, c_void};
+
+pub use bindings::QEMUTimer;
+
+use crate::{
+    bindings::{
+        self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
+        QEMUTimerListGroup,
+    },
+    callbacks::FnCall,
+};
+
+impl QEMUTimer {
+    pub fn new() -> Self {
+        Default::default()
+    }
+
+    pub fn timer_init_full<'timer, 'opaque: 'timer, T, F>(
+        &'timer mut self,
+        timer_list_group: Option<&QEMUTimerListGroup>,
+        clk_type: QEMUClockType,
+        scale: u32,
+        attributes: u32,
+        _f: F,
+        opaque: &'opaque T,
+    ) where
+        F: for<'a> FnCall<(&'a T,)>,
+    {
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
+                    g as *const QEMUTimerListGroup as *mut QEMUTimerListGroup
+                } else {
+                    ::core::ptr::null_mut()
+                },
+                clk_type,
+                scale as c_int,
+                attributes as c_int,
+                Some(timer_cb),
+                (opaque as *const T).cast::<c_void>() as *mut c_void,
+            )
+        }
+    }
+
+    pub fn timer_mod(&mut self, expire_time: u64) {
+        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
+    }
+}
+
+impl Drop for QEMUTimer {
+    fn drop(&mut self) {
+        unsafe { timer_del(self as *mut QEMUTimer) }
+    }
+}
+
+pub fn qemu_clock_get_virtual_ns() -> u64 {
+    // SAFETY:
+    // Valid parameter.
+    (unsafe { qemu_clock_get_ns(QEMUClockType::QEMU_CLOCK_VIRTUAL) }) as u64
+}
+
+pub struct ClockType {
+    pub id: QEMUClockType,
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


