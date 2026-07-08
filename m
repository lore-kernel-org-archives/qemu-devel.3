Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64738C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaN6-0005IL-PC; Wed, 08 Jul 2026 18:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1whZqE-00010l-BG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 17:30:02 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1whZqB-0006pr-Po
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 17:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783546198; x=1815082198;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QjeTRN+FK7k9xkJDzuHDoJBvVVs+L6bOx34tQOMEAf8=;
 b=b5zRH59XnkgO2qZ9SVZkK/Xur/QiiLvZs35e5r4o0VXuf0fq8IzoSU7u
 jczOh9TNJWXMiUSh/VY6X5Q1ZAlyx7cF+21vQQiZcPszmop1r8qywcIUu
 fDibvd9UPvC6n3GvQg0SmxJ/4S3UPvcfkMRPfouQP6ALO8bYDHO/bcTrz
 ASbD1LreGINE2hsBDKlHBY9aqpQOUcw2xqbUam1G8BCGYbIAV0j11BTbw
 bPOduDe00/lVFbZJ5eKaS4xzcbAe3eLDz383WhIQ+bitRO61F//qd7PLY
 7pu7IOQU4iELRfs1rdUMQem4Km9FFyc9icegDfRrv8tCsxgSYpLdVeXKJ w==;
X-CSE-ConnectionGUID: Xb9clflST2qKpUx+PYnTxw==
X-CSE-MsgGUID: NAJxniIzTo2PFJfhH4nuuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84099387"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84099387"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 14:29:20 -0700
X-CSE-ConnectionGUID: lFnvozDVStex33gPfgmN4Q==
X-CSE-MsgGUID: NBqFidJuTcqRps/yGwOA4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="258268349"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3)
 ([172.25.66.174])
 by orviesa004.jf.intel.com with ESMTP; 08 Jul 2026 14:29:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, seanjc@google.com,
 chang.seok.bae@intel.com, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] i386/cpu: Remove AMX-TF32 CPUID bit
Date: Wed,  8 Jul 2026 21:03:26 +0000
Message-ID: <20260708210326.402054-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Jul 2026 18:03:56 -0400
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

A recent revision of the Intel document [1] removed AMX-TF32, confirming
that the feature will not be implemented in future processors. Remove the
feature bit definition and its enumeration from the Diamond Rapids CPU
model.

[1] Intel Architecture Instruction Set Extensions and Future Features
    (Rev.062)

Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
KVM side posting: 
https://lore.kernel.org/all/20260708210118.402005-1-chang.seok.bae@intel.com
---
 target/i386/cpu.c | 5 ++---
 target/i386/cpu.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92d..bde501ad8f7b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1319,7 +1319,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "amx-int8-alias", "amx-bf16-alias", "amx-complex-alias", "amx-fp16-alias",
-            "amx-fp8", NULL, "amx-tf32", "amx-avx512",
+            "amx-fp8", NULL, NULL, "amx-avx512",
             "amx-movrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -5726,8 +5726,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_1E_1_EAX_AMX_INT8_ALIAS | CPUID_1E_1_EAX_AMX_BF16_ALIAS |
             CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS |
             CPUID_1E_1_EAX_AMX_FP16_ALIAS | CPUID_1E_1_EAX_AMX_FP8 |
-            CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
-            CPUID_1E_1_EAX_AMX_MOVRS,
+            CPUID_1E_1_EAX_AMX_AVX512 | CPUID_1E_1_EAX_AMX_MOVRS,
         .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
         /*
          * Though this bit will be set by avx_version=2, it's better to
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d87..8354c0753f0d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1111,8 +1111,6 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_1E_1_EAX_AMX_FP16_ALIAS      (1U << 3)
 /* AMX_FP8 instruction */
 #define CPUID_1E_1_EAX_AMX_FP8              (1U << 4)
-/* AMX_TF32 instruction */
-#define CPUID_1E_1_EAX_AMX_TF32             (1U << 6)
 /* AMX_AVX512 instruction */
 #define CPUID_1E_1_EAX_AMX_AVX512           (1U << 7)
 /* AMX_MOVRS instruction */
-- 
2.53.0


