Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF07E77176
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDVZ-0005eo-UI; Thu, 05 Dec 2024 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVX-0005e0-TW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:12 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVV-0005Mv-C8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733411469; x=1764947469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5wJyvwlOPKfr/u0glTCnSt2gyjP+AJEu8XtdgGtzWR8=;
 b=ej9PdSKlxacpSCiYJXmCPRAx5WH6Z3hWmZQhvshG/byFwQPoeel9Ae0e
 61GxvnZIjHmF9HkQxMrQsx2t3/pU11/LKl8lTnpl47SS+7/1Nd/RgXxWQ
 ojBN/ZzpbzJtEjD3ccvlizZEtiidB+jIXov55nTrMoYNxtPBmcAYKLyy0
 ZTObzkfGdzpRPhPkH3E2888JJgSGmq0+Oum/L6nELVnMTWE0j09Gallvl
 swOzLAod6RxTjTS3LtO79b1T74Fl8UBSK8inc/Y8amdULnuxTJvpdaeS3
 dGqO4q5VbsLSOvpgDD6dTQdoe9A44BtyKi7pjNcbgguCoZKRzk3fTHJZt A==;
X-CSE-ConnectionGUID: o96jG/OVS3yhfUIpmvz4sw==
X-CSE-MsgGUID: oUNRJB3STXy+PTw/HAalGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33786137"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33786137"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 07:11:07 -0800
X-CSE-ConnectionGUID: 91Q0Wg6HShCwjfjgZBXwfA==
X-CSE-MsgGUID: R7TUV8f/R7OlcA1ES63rHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="93803100"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 05 Dec 2024 07:11:04 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: xiaoyao.li@intel.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 2/4] i386: Extract a common fucntion to setup value of
 MSR_CORE_THREAD_COUNT
Date: Thu,  5 Dec 2024 09:57:14 -0500
Message-Id: <20241205145716.472456-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205145716.472456-1-xiaoyao.li@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.822, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
Extract a common function for it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h                    | 11 +++++++++++
 target/i386/hvf/x86_emu.c            |  3 +--
 target/i386/kvm/kvm.c                |  5 +----
 target/i386/tcg/sysemu/misc_helper.c |  3 +--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970fd..5795a497e567 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2390,6 +2390,17 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
     cs->halted = 0;
 }
 
+static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t val;
+
+    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
+    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+
+    return val;
+}
+
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
                             target_ulong *base, unsigned int *limit,
                             unsigned int *flags);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 015f760acb39..69c61c9c0737 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -765,8 +765,7 @@ void simulate_rdmsr(CPUX86State *env)
         val = env->mtrr_deftype;
         break;
     case MSR_CORE_THREAD_COUNT:
-        val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
-        val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+        val = cpu_x86_get_msr_core_thread_count(cpu);
         break;
     default:
         /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3ba1..18a1bd1297a4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2602,10 +2602,7 @@ static bool kvm_rdmsr_core_thread_count(X86CPU *cpu,
                                         uint32_t msr,
                                         uint64_t *val)
 {
-    CPUState *cs = CPU(cpu);
-
-    *val = cs->nr_threads * cs->nr_cores; /* thread count, bits 15..0 */
-    *val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+    *val = cpu_x86_get_msr_core_thread_count(cpu);
 
     return true;
 }
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 094aa56a20d1..ff7b201b44d8 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -468,8 +468,7 @@ void helper_rdmsr(CPUX86State *env)
         val = x86_cpu->ucode_rev;
         break;
     case MSR_CORE_THREAD_COUNT: {
-        CPUState *cs = CPU(x86_cpu);
-        val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
+        val = cpu_x86_get_msr_core_thread_count(x86_cpu);
         break;
     }
     case MSR_APIC_START ... MSR_APIC_END: {
-- 
2.34.1


