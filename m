Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D3AE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4k8-0006Gl-Bo; Thu, 05 Dec 2024 00:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k5-0006Fz-Pd; Thu, 05 Dec 2024 00:49:37 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k3-0007AB-Sl; Thu, 05 Dec 2024 00:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377776; x=1764913776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HOiFDozy8NrNAjDI+/O7a547R/8wQv3FfO4ASH2GLSE=;
 b=JithTF0rdaGoTb2SZBU+gk0DrhA219wupSQzQLqB2ogmqaZNeAC73SZx
 xarWjtY6122Z5ScSuvu4WibeQ+Wyz8uOBksypXYiI1yZ1PuVT3Pip88Ga
 8NEDKkUYV8Iu3zqPNJnKLayyxdw4/MaU5UQ9LXSRgmOvIGxVNOJOzIBAu
 gSOFXOasaBrh+FLVbgSG+1H0nffvxzj1IqkudW2dXABH5Q6ouvX/sS5s/
 fHrVLMz2vgqMVq5jSWRvW/+6ln+7+Jyf0ZLnZCxj/7Ut7zgebKmgJ12GI
 DU6l0JGxaOFMgAx+J/KC6tNebryeqtdvJqQcSsP3zrK2jODvh90eXQzi3 g==;
X-CSE-ConnectionGUID: 3T8qcSEIRj+mjNsPHF/F2A==
X-CSE-MsgGUID: 4pZ5nhRbSXe16HCUVcN8qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815652"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815652"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:35 -0800
X-CSE-ConnectionGUID: ku2QwvUMQhS8uiHTQDpqVQ==
X-CSE-MsgGUID: DGQj/cYjQkG1BtHFNzXpqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455026"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 07/13] rust: add bindings for timer
Date: Thu,  5 Dec 2024 14:07:08 +0800
Message-Id: <20241205060714.256270-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

The bindgen supports `static inline` function binding since v0.64.0 as
an experimental feature (`--wrap-static-fns`), and stabilizes it after
v0.70.0.

But the oldest version of bindgen supported by QEMU is v0.60.1, so
there's no way to generate the bindings for timer_new() and its variants
which are `static inline` (in include/qemu/timer.h).

Manually implement bindings to help create new timers in Rust.
Additionally, wrap timer_mod(), timer_del() and
qemu_clock_get_virtual_ns() as safe functions to make timer interfaces
more Rust-idiomatic.

In addition, for timer_new() and its variants, to convert the idiomatic
Rust callback into a C-style callback QEMUTimerCB, introduce a trait
QEMUTimerImpl. For any object needs to initialize a new timer, it needs
to implement QEMUTimerImpl trait and define a handler.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/meson.build  |   1 +
 rust/qemu-api/src/lib.rs   |   1 +
 rust/qemu-api/src/timer.rs | 123 +++++++++++++++++++++++++++++++++++++
 rust/wrapper.h             |   1 +
 4 files changed, 126 insertions(+)
 create mode 100644 rust/qemu-api/src/timer.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 508986948883..5bf3c3dfab67 100644
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
index e60c9ac16409..495261976dbc 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -17,6 +17,7 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
+pub mod timer;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
new file mode 100644
index 000000000000..4f9e8c9277c6
--- /dev/null
+++ b/rust/qemu-api/src/timer.rs
@@ -0,0 +1,123 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{
+    borrow::BorrowMut,
+    boxed::Box,
+    os::raw::{c_int, c_void},
+    ptr::NonNull,
+};
+
+pub use bindings::QEMUTimer;
+
+use crate::bindings::{self, *};
+
+impl QEMUTimer {
+    fn new() -> Self {
+        QEMUTimer {
+            expire_time: 0,
+            timer_list: ::core::ptr::null_mut(),
+            cb: None,
+            opaque: ::core::ptr::null_mut(),
+            next: ::core::ptr::null_mut(),
+            attributes: 0,
+            scale: 0,
+        }
+    }
+
+    // TODO: Consider how to avoid passing in C style callbacks directly.
+    fn timer_new_full<T: QEMUTimerImpl>(
+        timer_list_group: Option<&mut QEMUTimerListGroup>,
+        clk_type: QEMUClockType,
+        scale: u32,
+        attributes: u32,
+        opaque: &mut T::Opaque,
+    ) -> Self {
+        let mut ts: Box<QEMUTimer> = Box::new(QEMUTimer::new());
+        let group_ptr = if let Some(g) = timer_list_group {
+            g
+        } else {
+            ::core::ptr::null_mut()
+        };
+
+        // Safety:
+        // ts is a valid Box object which can borrow a valid mutable
+        // pointer, and opaque is converted from a reference so it's
+        // also valid.
+        unsafe {
+            timer_init_full(
+                ts.borrow_mut(),
+                group_ptr,
+                clk_type,
+                scale as c_int,
+                attributes as c_int,
+                Some(rust_timer_handler::<T>),
+                (opaque as *mut T::Opaque).cast::<c_void>(),
+            )
+        };
+
+        *ts
+    }
+
+    pub fn timer_mod(&mut self, expire_time: u64) {
+        unsafe { timer_mod(self as *mut QEMUTimer, expire_time as i64) }
+    }
+
+    pub fn timer_del(&mut self) {
+        unsafe { timer_del(self as *mut QEMUTimer) };
+    }
+}
+
+/// timer expiration callback
+unsafe extern "C" fn rust_timer_handler<T: QEMUTimerImpl>(opaque: *mut c_void) {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let para = unsafe { NonNull::new(opaque.cast::<T::Opaque>()).unwrap().as_mut() };
+
+    T::QEMU_TIMER_CB.unwrap()(para);
+}
+
+pub trait QEMUTimerImpl {
+    type Opaque;
+
+    // To be more general, opaque is mutable here. But it still should
+    // be protected by BqlCell/BqlRefCell.
+    //
+    // FIXME: limit opaque to immutable?
+    const QEMU_TIMER_CB: Option<fn(opaque: &mut Self::Opaque)> = None;
+
+    fn timer_new(clk_type: QEMUClockType, scale: u32, opaque: &mut Self::Opaque) -> QEMUTimer
+    where
+        Self: Sized,
+    {
+        QEMUTimer::timer_new_full::<Self>(None, clk_type, scale, 0, opaque)
+    }
+
+    fn timer_new_ns(clk_type: QEMUClockType, opaque: &mut Self::Opaque) -> QEMUTimer
+    where
+        Self: Sized,
+    {
+        Self::timer_new(clk_type, SCALE_NS, opaque)
+    }
+
+    fn timer_new_us(clk_type: QEMUClockType, opaque: &mut Self::Opaque) -> QEMUTimer
+    where
+        Self: Sized,
+    {
+        Self::timer_new(clk_type, SCALE_US, opaque)
+    }
+
+    fn timer_new_ms(clk_type: QEMUClockType, opaque: &mut Self::Opaque) -> QEMUTimer
+    where
+        Self: Sized,
+    {
+        Self::timer_new(clk_type, SCALE_MS, opaque)
+    }
+}
+
+pub fn qemu_clock_get_virtual_ns() -> u64 {
+    // SAFETY:
+    // Valid parameter.
+    (unsafe { qemu_clock_get_ns(QEMUClockType::QEMU_CLOCK_VIRTUAL) }) as u64
+}
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 033f3e9cf32c..0da42e84933a 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -63,3 +63,4 @@ typedef enum memory_order {
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
+#include "qemu/timer.h"
-- 
2.34.1


