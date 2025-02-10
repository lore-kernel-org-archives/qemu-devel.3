Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12940C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJju-00007v-4V; Sun, 09 Feb 2025 21:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjq-00006E-Hv; Sun, 09 Feb 2025 21:41:34 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjo-00087T-W3; Sun, 09 Feb 2025 21:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155293; x=1770691293;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5TXEKFg+zQhVhHBDXza0KM1l2M9Z0UBiB6ob1BWDPi8=;
 b=ag8RN4BAytFKAslKJDuSTtMGuxI52L4LZOvdjZ5BgA1WMQ4wUVdJdDdR
 1lhPGbyeRNdSSwD4xsnp+rJC/GefgYcguPYRDJI9AHq/cbvc5sXzuRU3T
 68eEnLdX5W4LiQVRHO6pXgoxL4Lrp4MVxWCpbvc0DmPxrsREJucVo2zwQ
 Eni4Nt2PHjG1Xr/dQAeD7adMtlLnwnr5D7cUTsI3RZnJCIITi7BWimAum
 obVV5ptqp2n32Q0Sg6AaGiIbq2Q9tVDWdYfaTlHcmKZgtVj41JfnwW0PS
 EQ9vBfyf8sPP1wMG3YdiIphL7vBeRbhaD4Li+jY5l5n+f1aohuLiBDEt4 Q==;
X-CSE-ConnectionGUID: PdpFf4ZTT76sR1OnNf8R+g==
X-CSE-MsgGUID: kyywwWvPRSK4aJRQ2zXVtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351249"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:32 -0800
X-CSE-ConnectionGUID: oHCvXLY1T4yhKt79gyU+5w==
X-CSE-MsgGUID: JELxZuK4Qn+zIGEAAmAwXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938215"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:30 -0800
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
Subject: [PATCH v2 03/10] rust/irq: Add a helper to convert [InterruptSource]
 to pointer
Date: Mon, 10 Feb 2025 11:00:44 +0800
Message-Id: <20250210030051.2562726-4-zhao1.liu@intel.com>
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

This is useful to hanlde InterruptSource slice and pass it to C
bindings.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * New commit.

Changes since Patch v1:
 * Drop `pub(crate) use crate::bindings::IRQState`.
 * Derefer `slice[0]` directly.
---
 rust/qemu-api/src/irq.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 835b027d5e5a..05f617b5684a 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -83,6 +83,12 @@ pub fn set(&self, level: T) {
     pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
         self.cell.as_ptr()
     }
+
+    #[allow(dead_code)]
+    pub(crate) fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
+        assert!(!slice.is_empty());
+        slice[0].as_ptr()
+    }
 }
 
 impl Default for InterruptSource {
-- 
2.34.1


