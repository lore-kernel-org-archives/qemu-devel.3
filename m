Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276CFC531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8xy-0002O6-Ss; Wed, 14 Aug 2024 04:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xw-0002IR-1H
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:44 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xq-0007sl-Ga
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622559; x=1755158559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cg5NURAi8EL/prAcQEbdCLOiFO5T+SW5x3k5dhQ2JYo=;
 b=YrW9Qk+HrYhr1beXXnTzb/ay5pcgEKslfmuuAuS64evROvHbosPeGhW/
 Sz9Cx5STKjbKYMqMmEIeACystkfrkT0tSpc4vJHnbEW6HaAkaGePTa2Ab
 3NwreCYKyzkfX+j3+D0Dmf0qM2Qd6x6v7BFACuc8Vwn7FF/nNrlaeL+8I
 IO0QYmiNLAMmUqSJUCI5/7CzkRmicqmOuGDQkYGDBbH9OvJQFmcsOzCmd
 u8G1TgoW8kd653F3TvFRS8TUDkHmOmNqeYLbxN8MMuNXsvLIHBqLVO1Lr
 3bKuczDGYUzYe00ZtAFUldT6Or7fC5PqJ6xLElWvYVSlqjL6rVE2wz0GF g==;
X-CSE-ConnectionGUID: NOtlfraCRcuM7cZBVF8zFw==
X-CSE-MsgGUID: Er4RBYmiTom9WbQAK972qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584468"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:36 -0700
X-CSE-ConnectionGUID: MkQ/j6iMStqhvnomGk60Ew==
X-CSE-MsgGUID: m4F72zKTRqiPog9YBMx+XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048946"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:34 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 2/9] i386/cpu: Enable fdp-excptn-only and zero-fcs-fds
Date: Wed, 14 Aug 2024 03:54:24 -0400
Message-Id: <20240814075431.339209-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

- CPUID.(EAX=07H,ECX=0H):EBX[bit 6]: x87 FPU Data Pointer updated only
  on x87 exceptions if 1.

- CPUID.(EAX=07H,ECX=0H):EBX[bit 13]: Deprecates FPU CS and FPU DS
  values if 1. i.e., X87 FCS and FDS are always zero.

Define names for them so that they can be exposed to guest with -cpu host.

Also define the bit field MACROs so that named cpu models can add it as
well in the future.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04e..e60d9dd58b60 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1054,9 +1054,9 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "fsgsbase", "tsc-adjust", "sgx", "bmi1",
-            "hle", "avx2", NULL, "smep",
+            "hle", "avx2", "fdp-excptn-only", "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, NULL, "mpx", NULL,
+            NULL, "zero-fcs-fds", "mpx", NULL,
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3d8..542512f65dec 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -826,6 +826,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_HLE               (1U << 4)
 /* Intel Advanced Vector Extensions 2 */
 #define CPUID_7_0_EBX_AVX2              (1U << 5)
+/* FPU data pointer updated only on x87 exceptions */
+#define CPUID_7_0_EBX_FDP_EXCPTN_ONLY (1u << 6)
 /* Supervisor-mode Execution Prevention */
 #define CPUID_7_0_EBX_SMEP              (1U << 7)
 /* 2nd Group of Advanced Bit Manipulation Extensions */
@@ -836,6 +838,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_INVPCID           (1U << 10)
 /* Restricted Transactional Memory */
 #define CPUID_7_0_EBX_RTM               (1U << 11)
+/* Zero out FPU CS and FPU DS */
+#define CPUID_7_0_EBX_ZERO_FCS_FDS      (1U << 13)
 /* Memory Protection Extension */
 #define CPUID_7_0_EBX_MPX               (1U << 14)
 /* AVX-512 Foundation */
-- 
2.34.1


