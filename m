Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA30CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyNt-0001TV-PP; Wed, 03 Jun 2026 23:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNr-0001Sa-Qk
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:39 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNp-0007rh-IT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780542278; x=1812078278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PMzI3YZ0L+NAo/l8+Nt3RSqvHcB4Y/+2l1U9Rw+fXbQ=;
 b=UXZw+86cG/khbayF8UJWGGwIxZBX86UjFy5+Gj0p8tk9OLuRunyuWpkR
 6x2X5OlMtvf2QExA8qkvBJiNwG71GIcQr9Ly8EN15yk+4UA1z1P44N4uu
 PF8ibRExndfevu8yoPFqr9Zhrh09XtAhqTUKRMeeVmOWvMgKg81c3E+WE
 +77DQVjQo04/2PuchlhVQUGZMh0p8UXvpJY3I/ugec/+5eB3lROgchIwp
 XlpMzUdoDN9pFhOHcbWDnE2QYIVeycoFLNBQ6nGGXGjhI6MetTat9Z4A8
 72fp6vcEosbGPjoWZqFAuneltI15c8vGYFdlu6/mQzDb/xwOIv5N8WsPL A==;
X-CSE-ConnectionGUID: JW4npmLkQ2KRO3l5i4DPkA==
X-CSE-MsgGUID: iXWt/tVpQhG+Xk9Bw4XuDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399637"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="80399637"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: QhnE5wOERjaep8zYLB+3pQ==
X-CSE-MsgGUID: GXcGaxnBSbaVjZcxxO0idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="241915843"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 3/6] target/i386: Adjust maximum number of PMU counters
Date: Wed,  3 Jun 2026 19:55:43 -0700
Message-ID: <20260604025546.19378-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604025546.19378-1-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changing either MAX_GP_COUNTERS or MAX_FIXED_COUNTERS affects the
VMState layout and therefore requires bumping the migration version
IDs.  Adjust both limits together to avoid repeated VMState version
bumps in follow-up patches.

To support full-width writes, QEMU needs to handle the alias MSRs
starting at 0x4c1.  With the current limits, the alias range can
extend into MSR_MCG_EXT_CTL (0x4d0).  Reducing MAX_GP_COUNTERS from 18
to 15 avoids the overlap while still leaving room for future expansion
beyond current hardware (which supports at most 10 GP counters).

Increase MAX_FIXED_COUNTERS to 7 to support additional fixed counters
(e.g. Topdown metric events).

With these changes, bump version_id to prevent migration to older
QEMU, and bump minimum_version_id to prevent migration from older
QEMU, which could otherwise result in VMState overflows.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     | 8 ++------
 target/i386/machine.c | 4 ++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ff44487d0b6d..5288c92fe52f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1751,12 +1751,8 @@ typedef struct {
 #define CPU_NB_REGS CPU_NB_REGS32
 #endif
 
-#define MAX_FIXED_COUNTERS 3
-/*
- * This formula is based on Intel's MSR. The current size also meets AMD's
- * needs.
- */
-#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
+#define MAX_FIXED_COUNTERS 7
+#define MAX_GP_COUNTERS    15
 
 #define NB_OPMASK_REGS 8
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index e0a5a5da6f5a..05aa38a8a43d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -685,8 +685,8 @@ static bool pmu_enable_needed(void *opaque)
 
 static const VMStateDescription vmstate_msr_architectural_pmu = {
     .name = "cpu/msr_architectural_pmu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmu_enable_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
-- 
2.54.0


