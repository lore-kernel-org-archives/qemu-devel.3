Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B47D5E144
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9JGs-0006Uj-Qj; Fri, 08 Nov 2024 02:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGb-0006Nr-9e
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:49 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t9JGZ-0007Po-L1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731050327; x=1762586327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CIy5dPUvwqW57qY3sj4mBIedFmwRWWxMjES6nwTfxNM=;
 b=NGhFH1aIkl7+adv3T6Qq8XxCJbMUaxxoY2RYU+HTik+Yr2pWS5kIeY7T
 zgCYNBxVritW2ZuqTNuxSB41XCeWsw6HErJ5kciuFuc6DT+MaMg3+RoZT
 WeOzw7XUP2ez+HmFQia2MssMze0fmfSj/h7Aq4xXOdQ9uaJUyfkm30Vwa
 0N1iyfH6KFjkIv/QrGtmQ7DxQwhRiddtfK7tDE4/pcq2XlCR/2pdT5nqB
 e4/W/E9mV8MqlD0dHmB1jyKlPof5q8LR9gM7BB/NIiluxryA9ke/DZywR
 HfNKAxpJthOY2eOwbVxHodfftvT4lmJO1BZCOxupMvYByMM+N2or7Bgc4 g==;
X-CSE-ConnectionGUID: /nLoMfmPTCKB78ybi1O9UA==
X-CSE-MsgGUID: uio5sAcDTLqgvCD/puXnCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31082935"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="31082935"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 23:18:46 -0800
X-CSE-ConnectionGUID: qzq3du5cTLyaZoAVCgcIIQ==
X-CSE-MsgGUID: TK+F+UT4R9ikjroVBqr2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="86240968"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa008.jf.intel.com with ESMTP; 07 Nov 2024 23:18:43 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH v1 3/4] i386/cpu: Set and track CPUID_EXT3_CMP_LEG in
 env->features[FEAT_8000_0001_ECX]
Date: Fri,  8 Nov 2024 02:06:08 -0500
Message-Id: <20241108070609.3653085-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108070609.3653085-1-xiaoyao.li@intel.com>
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

... instead of manually set it in cpu_x86_cpuid().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0c5a61ff615..015e085fa66c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6959,17 +6959,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
-        /* The Linux kernel checks for the CMPLegacy bit and
-         * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
-         */
-        if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
-                *ecx |= 1 << 1;    /* CmpLegacy bit */
-            }
-        }
         if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
@@ -7533,6 +7522,15 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     if (cs->nr_cores * cs->nr_threads > 1) {
         env->features[FEAT_1_EDX] |= CPUID_HT;
+
+        /*
+         * The Linux kernel checks for the CMPLegacy bit and
+         * discards multiple thread information if it is set.
+         * So don't set it here for Intel to make Linux guests happy.
+         */
+        if (!IS_INTEL_CPU(env)) {
+            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.34.1


