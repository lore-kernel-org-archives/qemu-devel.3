Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC8DC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoK-0003Jc-4m; Mon, 14 Apr 2025 10:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoF-0003Fr-Dy; Mon, 14 Apr 2025 10:29:15 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoD-00064c-Og; Mon, 14 Apr 2025 10:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640954; x=1776176954;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XsGrtLVwTs/ZI2MFwxj+EKuixussWmFTuUI3aTIAi3E=;
 b=E0hrcFX/pIiZqyeBdC2irC1oOwJ4+U+5tCdLbueQ0af/d1veQjOc31re
 zcI7i/iefNvHTtclbXAH5xv6fEBDWZx67DNKfG78Gz15xA+Nr3JcImac3
 5f7wwjcQ86r+n62P3Nqv+Hrlhfp37QQEKlkfZaAwM8ajjQ4800+kfjudv
 cBywZiXuzKCTjR+k8npQCOfmES0yYr69CnspZrReXmY73oQJWrPUlYnag
 GMrh4lHgm5B+aEM5stiHzYq/dHHA2U6tC/O1I0u6IeLE7sgd6UTohSS+d
 uagAT+DVxVBFEGUxJmD8j4v/TExkTqXc4jlJxdAOr8g4HpnyCJDqn7qwB A==;
X-CSE-ConnectionGUID: ej6uLHLoSnmfuw9V72P0Dw==
X-CSE-MsgGUID: AGErsfwhRjq8mhwT18Cogw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501863"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:11 -0700
X-CSE-ConnectionGUID: RCmlcCtFSdiwq2lk4Has2w==
X-CSE-MsgGUID: uoJBF7DVSsSzG12c0OZwAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606094"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:10 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 9/9] rust/hpet: Fix a clippy error
Date: Mon, 14 Apr 2025 22:49:43 +0800
Message-Id: <20250414144943.1112885-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

Carge clippy complained about:

error: casts from `u8` to `u32` can be expressed infallibly using `From`

So use `From` to convert `u8` to `u32`.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 983f3882f8d3..a3538af14b48 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -357,7 +357,7 @@ fn update_irq(&mut self, set: bool) {
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
         self.get_state()
-            .update_int_status(self.index as u32, set && self.is_int_level_triggered());
+            .update_int_status(u32::from(self.index), set && self.is_int_level_triggered());
         self.set_irq(set);
     }
 
-- 
2.34.1


