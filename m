Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97061E77172
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4jz-0006Cf-Jb; Thu, 05 Dec 2024 00:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jy-0006C8-DF; Thu, 05 Dec 2024 00:49:30 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jw-00079A-OJ; Thu, 05 Dec 2024 00:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377769; x=1764913769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=voF79vowTR6fMRnGLbc8fHjowgWUVNqNwTCb10ZYV1o=;
 b=bio/VIQZu/EGqyXiJIGlmcAJVq6gJ6jy7vKvZh1ImyKfHyBH0IU8BMZf
 g9S3hdWTvuVMEdoNrOq40DFVsnbF80Dcr2Yy8YOJu86+FY2VJYyeH/WqF
 vKLJJnCSnw4DvwnFwXLIt6p28jATIQIdTI98v6mzO0TaEqztzx8CyZzc7
 q5DyGKKSiz15txFsWXKzaM258oVNt21ymfDXG5r6yL1ymjEmXuicY8APn
 2b5VNNEnP7OkhZGpw2uGRqrmUkP7piMXMKY7QI7gjxQCj6A5lSptA2/Sx
 q20aWHZDtauyfl5OOqzBlX1357M3+TUhfJpQElNRFIq0ObkXS8dTjsBCV Q==;
X-CSE-ConnectionGUID: nz2aGToOTGOFIo7URgGWAQ==
X-CSE-MsgGUID: 6DvI+7iBSVuBAt4HiRs4gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815634"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815634"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:27 -0800
X-CSE-ConnectionGUID: 1fB97pmNSHW/arkgG+nckQ==
X-CSE-MsgGUID: K3zGE1hdTcGll9X0qPA74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94454985"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:24 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
Date: Thu,  5 Dec 2024 14:07:05 +0800
Message-Id: <20241205060714.256270-5-zhao1.liu@intel.com>
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

The qdev_init_gpio_{in|out} are qdev interfaces, so that it's natural to
wrap them as DeviceState's methods in Rust API, which could eliminate
unsafe cases in the device lib.

Wrap qdev_init_gpio_{in|out} as methods in a new trait DeviceGPIOImpl.

In addition, for qdev_init_gpio_in(), to convert the idiomatic Rust
callback into a C-style callback qemu_irq_handler, add a handler pointer
member in DeviceGPIOImpl. For any device needs to initialize GPIO in, it
needs to define a handler. And for device which just wants to initialize
GPIO out, it can leave the GPIO_IRQ_HANDLER as None.

Then device could use init_gpio_in() and init_gpio_out() to initialize
GPIO in and out, like C code.

Note, for qemu_irq_handler, assume the opaque parameter refers to the
self DeviceState, and this is enough as for now, as it's the most common
case in QEMU.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/qdev.rs | 55 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 23a06b377b2c..5e6580b6f261 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -4,12 +4,17 @@
 
 //! Bindings to create devices and access device functionality from Rust.
 
-use std::ffi::CStr;
+use std::{
+    ffi::CStr,
+    os::raw::{c_int, c_void},
+    ptr::{addr_of, NonNull},
+};
 
 pub use bindings::{DeviceClass, DeviceState, Property};
 
 use crate::{
-    bindings::{self, Error},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error},
+    irq::InterruptSource,
     qom::{ClassInitImpl, Object, ObjectClass, ObjectType},
     qom_isa,
     vmstate::VMStateDescription,
@@ -144,3 +149,49 @@ unsafe impl ObjectType for DeviceState {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
 qom_isa!(DeviceState: Object);
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+///
+/// Note: Always assume opaque is referred to the self DeviceState, and
+/// this is also the most common case in QEMU.
+unsafe extern "C" fn rust_irq_handler<T: DeviceGPIOImpl>(
+    opaque: *mut c_void,
+    lines_num: c_int,
+    level: c_int,
+) {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state = unsafe { NonNull::new(opaque.cast::<T>()).unwrap().as_mut() };
+
+    T::GPIO_IRQ_HANDLER.unwrap()(state, lines_num as u32, level as u32);
+}
+
+/// Trait that defines the irq handler for GPIO in.
+pub trait DeviceGPIOImpl {
+    const GPIO_IRQ_HANDLER: Option<fn(&mut Self, lines_num: u32, level: u32)> = None;
+
+    fn init_gpio_in(&self, lines_num: u32)
+    where
+        Self: Sized,
+    {
+        assert!(Self::GPIO_IRQ_HANDLER.is_some());
+
+        unsafe {
+            qdev_init_gpio_in(
+                addr_of!(*self) as *mut _,
+                Some(rust_irq_handler::<Self>),
+                lines_num as c_int,
+            );
+        }
+    }
+
+    fn init_gpio_out(&self, pins: &InterruptSource, lines_num: u32) {
+        unsafe {
+            qdev_init_gpio_out(addr_of!(*self) as *mut _, pins.as_ptr(), lines_num as c_int);
+        }
+    }
+}
-- 
2.34.1


