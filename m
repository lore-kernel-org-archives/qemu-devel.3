Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEF7CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9A-0006qm-Hs; Tue, 16 Sep 2025 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8z-0006bG-Cn; Tue, 16 Sep 2025 04:34:33 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8u-000603-BK; Tue, 16 Sep 2025 04:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011668; x=1789547668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t3omqHEsRg+fRPfTqu4MF2QVT2GB6AIlVz871hzEnu4=;
 b=GK4evcO8srX2XtSO9paV8I605Cf6oqcHRjmHE2Xpu7C9FQhdBikFwnBg
 Ilb2IceuNUlXfxcv5vI/yZ6H2Lhp8OXsbLziR5cTCVOO5CxT0k3Yk8CsY
 KZMZ4qzjwlOXam6DL4GA/Ddjqfi2RSEUJt5Wpz3rnXPqo/fRulcFQKUqA
 MPkeNDFTfcZQPFzzyeZa2IzX1XDtmkeGrPvWMxpaA29X59rQ2IhOTFQVC
 4dFNLR4k4XfHSQmUf82ryzaf40NC+0uOfeqQ/2Uzv9tzCFjnoDIAReQC8
 ztPzk/F2qtRnW6sCVMQYABqr9vFWoPjav3HkoypQfiq9lIrzYKLapYvjx w==;
X-CSE-ConnectionGUID: 5Zskk2gtSyuC1BcvgNHLxQ==
X-CSE-MsgGUID: HsQEXiCeRIe0EjSHecUPiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725163"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725163"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:19 -0700
X-CSE-ConnectionGUID: hAOW4vpKRxyMPdwEdnayrw==
X-CSE-MsgGUID: 6ynezYD6Ri2EVLqfHLTaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691055"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:17 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/12] rust/qdev: use addr_of! in QDevProp
Date: Tue, 16 Sep 2025 16:55:50 +0800
Message-Id: <20250916085557.2008344-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We want a &raw pointer, so unsafe { &_ } is not needed.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 71b9ef141c3a..3ee5b242622d 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -6,7 +6,7 @@
 
 use std::{
     ffi::{c_int, c_void, CStr, CString},
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
 };
 
 use chardev::Chardev;
@@ -129,17 +129,17 @@ pub unsafe trait QDevProp {
 
 /// Use [`bindings::qdev_prop_bool`] for `bool`.
 unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_bool };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
 }
 
 /// Use [`bindings::qdev_prop_uint64`] for `u64`.
 unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_uint64 };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
 }
 
 /// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
 unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_chr };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
 }
 
 /// Trait to define device properties.
-- 
2.34.1


