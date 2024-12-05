Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2BEE77172
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDVa-0005fA-VP; Thu, 05 Dec 2024 10:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVa-0005ep-3v
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:14 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tJDVY-0005Mv-8L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733411472; x=1764947472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5OZZXoHmzqfDaY3OPEU1rYYDn/0dOdmC6yIyc0+ynfs=;
 b=ZKwkXkkJlXg3hmFrpCAFJYvwyCGQdHaYnaRHrsq9eVGbn3w8mkvD6t/p
 9nGapsytce/1xgfOWUENC+YftW9+fxUzZ+mbWbtvbgdVq71A+gzLgbtgZ
 Uh+0NrId+QSa+rsgsjnEpDwR9mAhpZvoD5tm4VDwjAZJJOZWmJWsK8WTh
 okZZvB664VXxfBTtQgL52+EwHX7MPp92hOiQJiSE3PnVaY56pPAa+oC2B
 CDvH3TD5ddTNPs7GCD6dtnbyZXr83wSkSNXcR1mpvunqXeFF0tqBo/NnD
 jH1qhIT1RO7z8/mauh1rnKDvZL1uHGGD62GapRD/z3Uggfp5hpVyaHfgA A==;
X-CSE-ConnectionGUID: FTdPQGfxSNCjVgnqYbsEqA==
X-CSE-MsgGUID: QfyOoLRlRQCn6OgrE6biRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33786171"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="33786171"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 07:11:10 -0800
X-CSE-ConnectionGUID: Vz2ECWqNR8SjjOfACrJy3A==
X-CSE-MsgGUID: 7AkyqjIKTwus29W34govlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; d="scan'208";a="93803118"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 05 Dec 2024 07:11:07 -0800
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
Subject: [RFC PATCH 3/4] i386: Track cores_per_module in CPUX86State
Date: Thu,  5 Dec 2024 09:57:15 -0500
Message-Id: <20241205145716.472456-4-xiaoyao.li@intel.com>
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

x86 is the only user of CPUState::nr_cores.

Define cores_per_module in CPUX86State, which can serve as the
substitute of CPUState::nr_cores. After x86 switches to use
CPUX86State::cores_per_module, CPUState::nr_cores will lose the only
user and QEMU can drop it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c | 2 ++
 target/i386/cpu.c    | 2 +-
 target/i386/cpu.h    | 9 +++++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dc031af66217..f7a20c1da30c 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -271,6 +271,8 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
+    env->nr_cores = ms->smp.cores;
+
     if (ms->smp.modules > 1) {
         env->nr_modules = ms->smp.modules;
         set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b3f..15b50c44ae79 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6503,7 +6503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.modules_per_die = env->nr_modules;
-    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
+    topo_info.cores_per_module = env->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
 
     cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5795a497e567..c37a49a1a02b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2051,6 +2051,9 @@ typedef struct CPUArchState {
     /* Number of modules within one die. */
     unsigned nr_modules;
 
+    /* Number of cores within one module. */
+    unsigned nr_cores;
+
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
 } CPUX86State;
@@ -2393,10 +2396,12 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
 static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
+    CPUX86State *env = &cpu->env;
     uint64_t val;
+    uint64_t cores_per_package = env->nr_cores * env->nr_modules * env->nr_dies;
 
-    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
-    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+    val = cs->nr_threads * cores_per_package;  /* thread count, bits 15..0 */
+    val |= (cores_per_package << 16); /* core count, bits 31..16 */
 
     return val;
 }
-- 
2.34.1


