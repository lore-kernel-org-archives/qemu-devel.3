Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B4C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLC-0008FC-1F; Sat, 25 Jan 2025 07:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL2-0008DB-F2; Sat, 25 Jan 2025 07:32:37 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKz-0005Tn-Tn; Sat, 25 Jan 2025 07:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808354; x=1769344354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g2Nb+4+IFvjo/YNhUOjtEgb72fVfBiMk6M52lBhjmVA=;
 b=iNzXPL/UHa2WH/USw/k54QGSlMVmp/0Y1kHNDkX6cAUNe9GGRe8JvqIR
 jdnNsGTz6qvt5gCTr4nOoXa31ipAu+0CG+QCKAjyLcxrH28ACdSy+kRpV
 hg0v4KIjtHZLlTsepLENol5IzNy4ubnDyZLI5JAPtlF9axgv5qXym/k/A
 SqxyCK+FSzgjUe6Iz864s1C+2pRioGMu4oqzq8Ac2uJyqWej7YkYNLxMW
 JxJK+vbU15LvSW98Kr65YoFkawY+tySZf24d8D6BAZcki8Qx04OxCeILe
 XjCo+u0WQq88dVtd/1X+55TLARMo28UHry6qMsgnPEd4w1v2LPYW0yyxc Q==;
X-CSE-ConnectionGUID: 18ODjvVRRsat0x5mdvkdbw==
X-CSE-MsgGUID: KENYnHVGRMSd943nIIh1oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434706"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434706"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:32 -0800
X-CSE-ConnectionGUID: 1jKWWoHKQPu2yQGtfejnPw==
X-CSE-MsgGUID: SfP/7m22RgWE/3NXrvmXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897660"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:30 -0800
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
Subject: [PATCH 03/10] rust/irq: Add a helper to convert [InterruptSource] to
 [*mut IRQState]
Date: Sat, 25 Jan 2025 20:51:30 +0800
Message-Id: <20250125125137.1223277-4-zhao1.liu@intel.com>
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

This is useful to hanlde InterruptSource slice and pass it to C
bindings.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * New commit.
---
 rust/qemu-api/src/irq.rs | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 638545c3a649..7dca3b9ee5a8 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -5,12 +5,10 @@
 //! Bindings for interrupt sources
 
 use core::ptr;
-use std::{marker::PhantomData, os::raw::c_int};
+use std::{marker::PhantomData, os::raw::c_int, slice};
 
-use crate::{
-    bindings::{qemu_set_irq, IRQState},
-    prelude::*,
-};
+pub(crate) use crate::bindings::IRQState;
+use crate::{bindings::qemu_set_irq, prelude::*};
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
 /// a boolean).  The interrupt sink is usually an interrupt controller or
@@ -81,6 +79,16 @@ pub fn set(&self, level: T) {
     pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
         self.cell.as_ptr()
     }
+
+    #[allow(dead_code)]
+    pub(crate) fn as_slice_of_qemu_irq(slice: &[Self]) -> &[*mut IRQState] {
+        unsafe {
+            // SAFETY: InterruptSource has the same memory layout as *mut IRQState.
+            // Additionally, the slice parameter itself, as a reference to a slice type,
+            // can be converted into a valid pointer and has a valid length.
+            slice::from_raw_parts(slice.as_ptr().cast::<*mut IRQState>(), slice.len())
+        }
+    }
 }
 
 impl Default for InterruptSource {
-- 
2.34.1


