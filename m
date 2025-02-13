Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88080C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfK-00015P-0z; Thu, 13 Feb 2025 11:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf6-00010C-7W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf3-0005bz-9b
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnt5OnVQ+l+gmS65l633q8WW3swGA/w0Xihg0kZvStU=;
 b=cQSmG2c8L72ceo42l/1oB05RVO1HqK0YTs5RJm/3bm42F4kos2AdW59JmQgjPR13GDVNCD
 8Pmj0GR60tfk8yHKZ7gB0ISqyjB+wZfaatm5skW/aGj9/7dAGa4c73xSr+jmw5ptnU52iw
 FgOd2pc4cB+sP43WkaGJiEfSkzYjtb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-X8cjJkbFMWGzg1d6QV3x9Q-1; Thu, 13 Feb 2025 11:01:54 -0500
X-MC-Unique: X8cjJkbFMWGzg1d6QV3x9Q-1
X-Mimecast-MFC-AGG-ID: X8cjJkbFMWGzg1d6QV3x9Q_1739462514
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dd8d11139so912476f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462513; x=1740067313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnt5OnVQ+l+gmS65l633q8WW3swGA/w0Xihg0kZvStU=;
 b=I95GBcvdmUT+u/DqRE9wvM3K6qrqLQoV4XzL3T+28ZM+Wqg6NMapO2Q6aI2p2b13xU
 zbpKvOnKqm5YxKDuF73qYZbISVEjB5ldMwtdzb+6dyExYS7OLa1s/i9d8MCA+dtZPnz+
 Io7CJX7Icjc+UteJc3wMYOxRTW1hlT5Sr4v4JZ/TETZ2cFmHwPQpuXm3UVdgVNxt2AkS
 rHrjOy4OzoJjPXr+AEqezSSQm2FekkteSOpfb5wR3NWd/+XXLOAJMfItKHTZRguV9ovF
 7RpEpz4HBX0axkNOf7xKZ4yyyu99bo0Pnt+IcnhQzcBqu79OI2+S3d0uFDW5y/5vlvpK
 /YFw==
X-Gm-Message-State: AOJu0YxZuZ/cOI4wno/FFWANjkXggDlGbOrhI4Mf2krHuJyyfdgJxowB
 QDKqbCn92EmjbVf3Mr7m3oyaFfUkvD6Df+ngtz2YcvcFJSTZhQyq1hzGHHmVJ8XLu2ojMpfokjh
 zgcrIuUq0BC3EQbS2IDJ0uU3dEILCaxWwNIHPoM4K09khLgGA+XKY5W7/J2i5z2JF8TPKc6m9TW
 NZvDfyP2ome+kAsy5ylwFsl52TvEP+ZzyJnwCRjas=
X-Gm-Gg: ASbGncujge+IeL4ziNERc9CiwBntsGXTFm5b7Lri8PXaAIlIzu1U79tK+hKBovVe7CJ
 OS4ZmhYkrkQDWdOjhTGoYFp6nYT2uSLvl+YCa9Tu33Xst6UfAN1koG11tGEO1Mm3ZI2g/nRpF84
 Pzva19OYxaU8Oxy6NAme8Eppr18hDFoUiaB/tt/Tng1wI7KK/ABRFnx0qworLrkPlrbPwvyH1du
 j0ke0BvhAZuPZu0z6uDQf6h1SDDVSFPjMjTcbQZfmeO14asajMLCY3nWEihNl0XjgOqpkIkaOmb
 Q0BNjniLp5/pTD9PhDw8yxooKXNuR8lmFI+byJm/ffBW+A==
X-Received: by 2002:a05:6000:18ab:b0:38f:276a:1662 with SMTP id
 ffacd0b85a97d-38f276a1705mr3405677f8f.13.1739462511457; 
 Thu, 13 Feb 2025 08:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVSQh0DLrXYu8O4DuxNCMUcLqamW/yKRgbf0WcvUWqkNdOO+vq/t+rZqjBW0+OfHavVyM9lg==
X-Received: by 2002:a05:6000:18ab:b0:38f:276a:1662 with SMTP id
 ffacd0b85a97d-38f276a1705mr3405579f8f.13.1739462510554; 
 Thu, 13 Feb 2025 08:01:50 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913f5asm2280440f8f.52.2025.02.13.08.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/27] rust: add bindings for timer
Date: Thu, 13 Feb 2025 17:00:46 +0100
Message-ID: <20250213160054.3937012-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add timer bindings to help handle idiomatic Rust callbacks.

Additionally, wrap QEMUClockType in ClockType binding to avoid unsafe
calls in device code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst        |  1 +
 meson.build                |  7 +++
 rust/wrapper.h             |  1 +
 rust/qemu-api/meson.build  |  1 +
 rust/qemu-api/src/lib.rs   |  1 +
 rust/qemu-api/src/timer.rs | 98 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+)
 create mode 100644 rust/qemu-api/src/timer.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index a5399db50b5..90958e5a306 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -186,6 +186,7 @@ module           status
 ``qdev``         stable
 ``qom``          stable
 ``sysbus``       stable
+``timer``        stable
 ``vmstate``      proof of concept
 ``zeroable``     stable
 ================ ======================
diff --git a/meson.build b/meson.build
index 16c76c493f3..8ed10b6624e 100644
--- a/meson.build
+++ b/meson.build
@@ -4087,6 +4087,13 @@ if have_rust
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
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 54839ce0f51..a35bfbd1760 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -63,3 +63,4 @@ typedef enum memory_order {
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
+#include "qemu/timer.h"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 45e30324b29..2e9c1078b9b 100644
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
index 2a338a888a0..ed1a8f9a2b4 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -26,6 +26,7 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
+pub mod timer;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
new file mode 100644
index 00000000000..a593538917a
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
+    pub const MS: u32 = bindings::SCALE_MS;
+    pub const US: u32 = bindings::SCALE_US;
+    pub const NS: u32 = bindings::SCALE_NS;
+
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
-- 
2.48.1


