Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D81C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEZs-0000S0-UW; Tue, 21 Jan 2025 08:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZc-0000QY-SK; Tue, 21 Jan 2025 08:45:44 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEZb-0005st-85; Tue, 21 Jan 2025 08:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737467143; x=1769003143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rxFIH1V2S/qGBuJ+RX3At6R9o8UedyIffIiZqAZTIuA=;
 b=b8i/veLYoBFNLZ/zPdBKmGRwjpENOt937PxByVb7M9p5g89wXBbHesdw
 YVcfyqVItMXzm8Su0SFVTa2iShfBDulBGbv3bOpcH4/HCiiG+WiCwaTvO
 iQBGZcDyg/paLTboLNTZHvpT9e9VRb1B2KKQbNm/OoLcPZHCuPm41D3tm
 jiVfLVhMVKPSxYLt9HBmWXTs0cIhWt+/Wephf75lA+kwXxnyvYWrpcVUP
 iCvi4kUYleMnbA+7cQX6jTUOQxnEUJ3y3ZOUO9WQcZhLQ6mqm3mdDH8Mu
 xpH8nNOCOCSUa5kKsWFCxIyNpgA40uEcvcj5hSpMIafJaqL7XsjL2U1+k A==;
X-CSE-ConnectionGUID: dsXMQPEqRsGI9DTpT++g+g==
X-CSE-MsgGUID: cHwz4T2gTq639t7xuKf/+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38123104"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="38123104"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:45:40 -0800
X-CSE-ConnectionGUID: 9YozACHrSDGMLWJ5IMzMLA==
X-CSE-MsgGUID: 0T50GAtRRs6qFq18ZHUK8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106822605"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 21 Jan 2025 05:45:39 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH RESEND 1/2] rust/qdev: Make REALIZE safe
Date: Tue, 21 Jan 2025 22:04:56 +0800
Message-Id: <20250121140457.84631-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121140457.84631-1-zhao1.liu@intel.com>
References: <20250121140457.84631-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

A safe REALIZE accepts immutable reference.

Since current PL011's realize() only calls a char binding function (
qemu_chr_fe_set_handlers), it is possible to convert mutable reference
(&mut self) to immutable reference (&self), which only needs to convert
the pointers passed to C to mutable pointers.

Thus, make REALIZE accept immutable reference.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device.rs | 10 +++++-----
 rust/qemu-api/src/qdev.rs        |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 994c2fc0593c..c64af2684b7d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of_mut, NonNull};
+use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_uint, c_void},
@@ -155,7 +155,7 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
-    const REALIZE: Option<fn(&mut Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
     const RESET: Option<fn(&mut Self)> = Some(Self::reset);
 }
 
@@ -438,17 +438,17 @@ fn set_read_trigger(&mut self) {
         self.read_trigger = 1;
     }
 
-    pub fn realize(&mut self) {
+    pub fn realize(&self) {
         // SAFETY: self.char_backend has the correct size and alignment for a
         // CharBackend object, and its callbacks are of the correct types.
         unsafe {
             qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
+                addr_of!(self.char_backend) as *mut CharBackend,
                 Some(pl011_can_receive),
                 Some(pl011_receive),
                 Some(pl011_event),
                 None,
-                addr_of_mut!(*self).cast::<c_void>(),
+                addr_of!(*self).cast::<c_void>() as *mut c_void,
                 core::ptr::null_mut(),
                 true,
             );
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 686054e737ac..a5121e31a37a 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -23,7 +23,7 @@ pub trait DeviceImpl {
     ///
     /// If not `None`, the parent class's `realize` method is overridden
     /// with the function pointed to by `REALIZE`.
-    const REALIZE: Option<fn(&mut Self)> = None;
+    const REALIZE: Option<fn(&Self)> = None;
 
     /// If not `None`, the parent class's `reset` method is overridden
     /// with the function pointed to by `RESET`.
-- 
2.34.1


