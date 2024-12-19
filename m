Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B5CE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVj-0004Y2-KT; Thu, 19 Dec 2024 06:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVb-0004Vz-Ud
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:00 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVY-0005HS-P7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606957; x=1766142957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DxXDnN+O/WwzGOcacl7nzyyO6E4y6vh1Z1+71dP+W94=;
 b=cJ6jG4M+HxGdgcQGCXzKebyHizokYHvXr19ThhQOf2bBbasCfkOdVRSa
 VBR5XC92MtmjN4y/1QGsOzXAiwfHhh4r/6TzI+XCBY1EktVXAF4fuHgP1
 +8sUpqO+RFDYX/sejefN9AcsgjfFbWgPNnymyX85QRxycU4l9X1y8PpKr
 KroMB8drthlggd0urBc1ocUj+cWpJxPTi6yN62/TNdsRDM7CtTXIkgLhr
 3QHQddrnJtan7A5B32FTNbq6qA49DH17xszZ1JOiUPsNBFuoACODMmQXt
 4SXIJKwmZC0WZBR03qG/KQ8PmUkYe0OSCe2eZVg3cx6QY4Bbe5M2sCvOr w==;
X-CSE-ConnectionGUID: HH80fenOSdmlrChVBDKMiQ==
X-CSE-MsgGUID: amVDAtymSDudAZQ0mdHkoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994924"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:15:54 -0800
X-CSE-ConnectionGUID: 3ZhCPKwkQLubGHKE5dqV7g==
X-CSE-MsgGUID: GBEQRhl2RGWufLAoiN2N7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956108"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:15:50 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 01/10] i386/cpu: Extract a common fucntion to setup value
 of MSR_CORE_THREAD_COUNT
Date: Thu, 19 Dec 2024 06:01:16 -0500
Message-Id: <20241219110125.1266461-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
Extract a common function for it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v2:
- move the implementation of cpu_x86_get_msr_core_thread_count() to
  target/i386/cpu-sysemu.c;
---
 target/i386/cpu-sysemu.c             | 11 +++++++++++
 target/i386/cpu.h                    |  2 ++
 target/i386/hvf/x86_emu.c            |  3 +--
 target/i386/kvm/kvm.c                |  5 +----
 target/i386/tcg/sysemu/misc_helper.c |  3 +--
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 227ac021f62f..4e9df0bc0156 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -309,3 +309,14 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+
+uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t val;
+
+    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
+    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+
+    return val;
+}
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970fd..5e1beca94a62 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2390,6 +2390,8 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
     cs->halted = 0;
 }
 
+uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu);
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


