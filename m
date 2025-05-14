Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A9C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 03:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF2h6-0005wB-FA; Tue, 13 May 2025 23:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h3-0005vO-Sn
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:05 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h1-0004w9-Ue
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747192924; x=1778728924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gE9lt1CJ0kbLSrj2puCku5k69h60+nVb88z27oVWhSI=;
 b=ih4+O9FwbKYiBuwOOnrwUM/yYeAudAKMhV5PJE100Wx7npI5LZ3ZC4ym
 fprPUie4b8bdk1M0aJQz81mEn/002BF/gZVbbCePFfrwNAo/w/aicPQsU
 acFor60noBKdiQK425HF8jPQSO6r7IbobhUEXJc9QmXkNMzXRinnSDh/t
 R16SfAFNsYVerRPCXkQe4hHeZSCoWJNPN94uZCeTyKskHAw0AhUcaNgUF
 meVrrZrCDk/vW55+7hE8FW9cqNzWJj5Pj83gzWYlyIe+S4D2bwP79CUH7
 n7Bg/fz+T4H74TOhn3gVz0hOxejb6xyuakEM7VwK+QQLSzfKsgd7PeA1q w==;
X-CSE-ConnectionGUID: 7hVOQoGzQxypNnW7UcJbyQ==
X-CSE-MsgGUID: zGHH5ZNLQzept+MXGmsNlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59296759"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="59296759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 20:22:00 -0700
X-CSE-ConnectionGUID: gDjpdu0CTQ+0OmvpI5fvjg==
X-CSE-MsgGUID: 06hCddw7TmCoVHGk4f4vYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="161203401"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 13 May 2025 20:21:57 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/2] i386/tcg: Make CPUID_HT and CPUID_EXT3_CMP_LEG supported
Date: Tue, 13 May 2025 23:16:51 -0400
Message-ID: <20250514031652.838763-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514031652.838763-1-xiaoyao.li@intel.com>
References: <20250514031652.838763-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

Since commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
x86_cpu_expand_features() instead of cpu_x86_cpuid()") and
commit 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
env->features[FEAT_8000_0001_ECX]"), it gets warnings when booting the
VM with vcpus >= 2 and with tcg:

  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.cmp-legacy [bit 1]

This is because, after the two commits, CPUID_HT and CPUID_EXT3_CMP_LEG
are set in env->features[] when vcpus >=2 (in x86_cpu_expand_features())
later in x86_cpu_filter_features() it will check against the TCG supported
bits. However, current TCG doesn't mark the two bits as supported, hence
the warnings.

Fix it by adding the two bits to the supported bits of TCG since multiple
vcpus are supported by TCG.

Fixes: c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()")
Fixes: 99a637a86f55 ("i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]")
Reported-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ca6307c72ef..c5a1fe1e8afe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -776,11 +776,12 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC | CPUID_SEP | \
           CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV | CPUID_PAT | \
           CPUID_PSE36 | CPUID_CLFLUSH | CPUID_ACPI | CPUID_MMX | \
-          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE)
+          CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_DE | \
+          CPUID_HT)
           /* partly implemented:
           CPUID_MTRR, CPUID_MCA, CPUID_CLFLUSH (needed for Win64) */
           /* missing:
-          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_HT, CPUID_TM, CPUID_PBE */
+          CPUID_VME, CPUID_DTS, CPUID_SS, CPUID_TM, CPUID_PBE */
 
 /*
  * Kernel-only features that can be shown to usermode programs even if
@@ -848,7 +849,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
-          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES)
+          CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_KERNEL_FEATURES | \
+          CPUID_EXT3_CMP_LEG)
 
 #define TCG_EXT4_FEATURES 0
 
-- 
2.43.0


