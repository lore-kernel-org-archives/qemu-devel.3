Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF91DC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkILy-0000Li-IH; Tue, 18 Feb 2025 02:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkILw-0000LE-B5; Tue, 18 Feb 2025 02:49:12 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkILs-0005uX-Oo; Tue, 18 Feb 2025 02:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739864949; x=1771400949;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xbrKOGJ3m9gms1trzv21PXPE753tlMOzvuu2KDFvoZk=;
 b=TU6fr4TtpQAYNOso7ntK3cjOrPRPh+rWa4zU/NT3YEcdSDxjb7eJZkc1
 FM3rB2AOeB3RTYRMvYanNVFW77W83aG8vWhwn1iMs/AW3pzQYs9oV0qnm
 dJNA6iNALO10yBwlawpbiLbKKA16VbC7gbTNXbNAkjtIH7a/JjtUBt0LT
 /qw2nk135o/dUdoPSMD0mn8yhsK4O/nt1ciSRDP0FddV5qoHZPkh8soaC
 a9Nru8WJFT3SrOjCl2iSkk2AD2Ra9gSGqw2tERnBPbCZ4SOlX2PTB+Uyj
 1YhlqqYIMzDPHxle1DufkqotZV5jeg2WwXlphxXpKKAECHofKygFGmp3T w==;
X-CSE-ConnectionGUID: qS/7g2SkQlKKgXyY7rc2mA==
X-CSE-MsgGUID: zpnkbZCSSuiNWT5INAkAxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51190819"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="51190819"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 23:49:05 -0800
X-CSE-ConnectionGUID: c5vcaEq6QXOozNFMZRIeww==
X-CSE-MsgGUID: b58VZPcnTGuQ9e9woxbVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119529994"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 17 Feb 2025 23:49:04 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] rust: Prefer std::ptr over core::ptr
Date: Tue, 18 Feb 2025 16:08:35 +0800
Message-Id: <20250218080835.3341082-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The std::ptr is same as core::ptr, but std has already been used in many
cases and there's no need to choose non-std library.

So, use std::ptr directly to make the used ptr library as consistent as
possible.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device.rs       | 2 +-
 rust/hw/char/pl011/src/device_class.rs | 6 ++++--
 rust/qemu-api/src/irq.rs               | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index fe73771021e7..59a689fdcd77 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,10 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of, addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_void},
+    ptr::{addr_of, addr_of_mut, NonNull},
 };
 
 use qemu_api::{
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index dbef93f6cb3e..0b2076ddaa0f 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,8 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::NonNull;
-use std::os::raw::{c_int, c_void};
+use std::{
+    os::raw::{c_int, c_void},
+    ptr::NonNull,
+};
 
 use qemu_api::{
     bindings::*, c_str, prelude::*, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index d1c9dc96eff3..34c19263c233 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -4,8 +4,7 @@
 
 //! Bindings for interrupt sources
 
-use core::ptr;
-use std::{ffi::CStr, marker::PhantomData, os::raw::c_int};
+use std::{ffi::CStr, marker::PhantomData, os::raw::c_int, ptr};
 
 use crate::{
     bindings::{self, qemu_set_irq},
-- 
2.34.1


