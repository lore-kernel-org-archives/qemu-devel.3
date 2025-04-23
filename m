Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CEFC369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFx-0004HF-LT; Wed, 23 Apr 2025 07:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFR-0003yf-Hr
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:39 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFP-0002wd-3X
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407595; x=1776943595;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SmfkHcD+Un/2Y5famAC96LL5S3HRw5afHfM+nkbE5Pg=;
 b=RpMLhF1EBB1spju55DHtmztUre6hgUN6ONX3T4WC6nUTQx5u8HTKm3Wj
 oJp2CWxjf1bU4clxsGd+rJtaDPGIb4BtGfdh5jxl1vu1Xggnh4sFmUFkb
 cSXDbxMddFmagfiQpBvT5HwPV6p7uk1hGg+a0njsH+nmbAF3RltbYOQ7j
 aEtHfsTic+jl0pBlJChNVBJDCgRx87k07z+kqFjrswt3CKdsLRCIjkd1/
 JjHqmUEP6txIQ3/QyT3kzgp1ERIrtUV0hNQHYXnP05hVdFpeneC4oLhq5
 um1q2+Ledt0muCTnLTIA7wFrsopkdGHE5CEFbilorbXEbjzTOMpRMvvEb w==;
X-CSE-ConnectionGUID: /MLxW+XUSGiprWEnzpxzCg==
X-CSE-MsgGUID: CiCjWDsyTSWbSgR+W8VDsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825298"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825298"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:34 -0700
X-CSE-ConnectionGUID: 8NomLIi9RI+LJInP581nBg==
X-CSE-MsgGUID: nE4Xi+ZLSUe5NiEWwkKwkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150776"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 06/10] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Date: Wed, 23 Apr 2025 19:46:58 +0800
Message-Id: <20250423114702.1529340-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423114702.1529340-1-zhao1.liu@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
when topology level that cannot be enumerated by leaf 0xB, e.g., die or
module level, are configured for the guest, e.g., -smp xx,dies=2.

However, TDX architecture forces to require CPUID 0x1f to configure CPU
topology.

Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
requires CPUID leaf 0x1f to be exposed to guest.

Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
to enable cpuid leaf 0x1f for the guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     | 4 ++--
 target/i386/cpu.h     | 9 +++++++++
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d90e048d48f2..e0716dbe5934 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7292,7 +7292,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_cpuid_0x1f(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -8178,7 +8178,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if (x86_has_cpuid_0x1f(cpu) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55d..3910b488f775 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,6 +2251,9 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Force to enable cpuid 0x1f */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -2513,6 +2516,12 @@ void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
 
+static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
+{
+    return cpu->enable_cpuid_0x1f ||
+           x86_has_extended_topo(cpu->env.avail_cpu_topo);
+}
+
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee812..23b8de308525 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1863,7 +1863,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
                 cpuid_i--;
                 break;
             }
-- 
2.34.1


