Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D32FEFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkm-0005Pi-2C; Wed, 04 Mar 2026 13:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkh-0005Mn-PE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkg-0004ky-2N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648119; x=1804184119;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w0fJWokOyWUWajqVIT+j5dZD4HdLLo1t7Fu/mRVcycI=;
 b=MdsPN0cvn/j3+VaovaE40jremSAZMPsSwG4W1J4JAdZ26FFY76LtYhIT
 pl2+ZBVeOXtHkM1Dc1t/O4idxHWaAnVJL/j4J5MDF7vCjoXb1oM7mwAbt
 BWxBvk40HGzislSw1bHOy7NDeRMa/PaK5ZFf6/nXUNE1ydFVUWcaP7FdX
 ieDv6Q4uDgblhbynABf4oMuDqctFDImQLOEe4aSSiG3Bcc8BR9UCBMrjI
 AK1f1927Ti4icWGdt7XBEiA5lN7julY4ASrnXZkhaFrZVjztPCq6AhpQ+
 FxcKyUzGldbl7b6JJb+7TJ8ApaUP5Bx62W5+1pYcTK2ZncLDQagF2LRho A==;
X-CSE-ConnectionGUID: gE40qKOZQRClHYq3JB3Tlw==
X-CSE-MsgGUID: 5PSxrtiUR/q6JtP197b0iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909310"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909310"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:12 -0800
X-CSE-ConnectionGUID: DcMg9nmPQqGWiHwMF3Gjag==
X-CSE-MsgGUID: dAKDEJrLSFazhBKLONOqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542797"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:11 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 04/13] target/i386: Adjust maximum number of PMU counters
Date: Wed,  4 Mar 2026 10:07:03 -0800
Message-ID: <20260304180713.360471-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     | 8 ++------
 target/i386/machine.c | 4 ++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6d3e70395dbd..23d4ee13abfa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1749,12 +1749,8 @@ typedef struct {
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
index 1125c8a64ec5..7d08a05835fc 100644
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
2.53.0


