Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BABC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoG-0003Hl-Pw; Mon, 14 Apr 2025 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoC-0003EC-4a; Mon, 14 Apr 2025 10:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoA-00066W-HA; Mon, 14 Apr 2025 10:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640951; x=1776176951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GYLXl6z0NzXsCEMB9cH1u8o2NEOag8csYLmTuoyZnLM=;
 b=XQW+G9Yf+x/cdVvnEz62paW6BSTX/qP/xVHkZvFPXkwQ52/3mFIJFR4j
 fGhMM1w7x3HjfE2lwCcd+mVb7+Dq2J6A4BfTkOhJ2Cdwuu4NsWctIT/Vu
 fbIwVwnynhSZSoEBH842UYcLfW0QdRlAMo58qZ/vPPmp6VSUq/ghd6jYJ
 1oicg5ReJjSBVswWeZPAah/JAelOKzpsDSOAb+7levyusPgm/h98Mzn+y
 frxJCLS683ce0mNtt8FKuspNTJ+u0BTMPCiJdykXwuqxQ4cpYC3lAxuWf
 gL19UVYjiKk/0duYwlQ2j2k39wrcXRs+aR9nBixTyGBz/Sg0d8Mz/Qi6k g==;
X-CSE-ConnectionGUID: qN5GQ3Y5TReJV51/0SDj6Q==
X-CSE-MsgGUID: +1SiSsHPQu+DpVUcKH5FDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501845"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501845"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:05 -0700
X-CSE-ConnectionGUID: bGxuCsRLTyWU3CAbjPOCtg==
X-CSE-MsgGUID: RUlzdQk3SxC2SUDKM+Hg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606078"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/9] rust/timer: Define NANOSECONDS_PER_SECOND binding as u64
Date: Mon, 14 Apr 2025 22:49:39 +0800
Message-Id: <20250414144943.1112885-6-zhao1.liu@intel.com>
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

NANOSECONDS_PER_SECOND is often used in operations with get_ns(), which
currently returns a u64.

Therefore, define a new NANOSECONDS_PER_SECOND binding is with u64 type
to eliminate unnecessary type conversions (from u32 to u64).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/timer.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index f0b04ef95d7e..e769f8bc910d 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -121,3 +121,5 @@ pub fn get_ns(&self) -> u64 {
 pub const CLOCK_VIRTUAL: ClockType = ClockType {
     id: QEMUClockType::QEMU_CLOCK_VIRTUAL,
 };
+
+pub const NANOSECONDS_PER_SECOND: u64 = 1000000000;
-- 
2.34.1


