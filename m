Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F81C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW9eD-00041w-E3; Mon, 30 Jun 2025 04:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9eB-0003yy-0P
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:51 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9e4-0008Fu-PQ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751271225; x=1782807225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yQgKgn2Ex9EvBdQ8riuYt22CkUp1eI23OAyzDnMSZkw=;
 b=ZtSYHAXxnx39IJpKdDPVmGxI1BeR839YhdRex09+/UY3pxZEGEWOjUkO
 wDQ6/UgPdk3eSRd06P5nfLmcg0XV0aA9eHPEvWq/hMMe9E3uCc9HUWURV
 ZAXnIQvduio8HftKVenmfMr+A1wp0k+G2kqyBkTL1RgWCLnQNrCycaCvn
 WGjWo1Jiu5vouIHHwxf5d4OaI+JU2HX+IQSqSXuwMMtzkmpvQAbVk206m
 cZRkUiBgp0i4Vj9q6MZf7yIpIJItKjaWn6ftwOPWr8eBxxrl7PZxzQXY7
 OoEwr+l4PO64lLYTgdzaHT0dvT3C7xFHOifbvJpws6FimHMQkfDt53uh8 A==;
X-CSE-ConnectionGUID: m8SeCVJyQvaU8B/KY88gtQ==
X-CSE-MsgGUID: 9uJZh4nuSheX2Wp27vLlIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53637401"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="53637401"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 01:13:39 -0700
X-CSE-ConnectionGUID: TF7/saBLTPmbty4ccvWQ6g==
X-CSE-MsgGUID: VmayMKPESu+teMMwxiCvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="152777291"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 01:13:38 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 2/4] i386: Cleanup the usage of CPUID_VENDOR_INTEL_1
Date: Mon, 30 Jun 2025 16:06:08 +0800
Message-ID: <20250630080610.3151956-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630080610.3151956-1-xiaoyao.li@intel.com>
References: <20250630080610.3151956-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are code using "env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1" to
check if it is Intel vcpu. Cleanup them to just use IS_INTEL_CPU()

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c                | 2 +-
 target/i386/tcg/decode-new.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d80e57d0cc0d..83858358f5ec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7760,7 +7760,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
-        if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
+        if (tcg_enabled() && IS_INTEL_CPU(env) &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 55216e0d2490..853b1c8bf95e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2722,14 +2722,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             if (decode.e.check & X86_CHECK_i64) {
                 goto illegal_op;
             }
-            if ((decode.e.check & X86_CHECK_i64_amd) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
+            if ((decode.e.check & X86_CHECK_i64_amd) && !IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
         } else {
             if (decode.e.check & X86_CHECK_o64) {
                 goto illegal_op;
             }
-            if ((decode.e.check & X86_CHECK_o64_intel) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            if ((decode.e.check & X86_CHECK_o64_intel) && IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
         }
-- 
2.43.0


