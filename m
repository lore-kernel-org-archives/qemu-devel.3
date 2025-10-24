Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D8BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOm-0003cp-43; Fri, 24 Oct 2025 02:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOk-0003cf-O2
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:38 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOi-0003zC-La
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287737; x=1792823737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J041AyqDu393CENrSjsYGiKHkAgugONGgNt6ugUkk3A=;
 b=gyMs5PyhEm9P47phLXvsvc4/ki8wB7REvAgIoHcLw14lO8aPeqVbZxiN
 F07AZdP2pKqUwBPj77e3Bd+T2YOzo02c164ME/rh1QfGhFrpMO+9h442U
 /1N583APyVVk/lFOTCMk9u/K0qO88XSW2oWM1R79uWV6Qq2VjSw2TpjFU
 CU8TEDnngAavyGJ0IM+9vFM/6+g4s0EOmBHbJZ355MgWPILhvbAak9d3O
 1Qk3CnE87S5iTnx+AMC39iZsr3dUJise+qtVc4rDVDR8sQTNtqwbJhOn7
 6FX5eDsKXNjmsexRhaHcLMDv8X7PP1JzyYU2BSGmQ8/gnibByYvzoOslS Q==;
X-CSE-ConnectionGUID: sil7nKIySc2DqktRg6adwg==
X-CSE-MsgGUID: DaQAvaGMR6qJQJ4ht/IzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63170916"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="63170916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:32 -0700
X-CSE-ConnectionGUID: Ha6JoebcTaezDh11zjjpDA==
X-CSE-MsgGUID: aNZv1DHrSRy9ZHsUbcgWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276097"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:24 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v3 13/20] i386/kvm: Add save/load support for CET MSRs
Date: Fri, 24 Oct 2025 14:56:25 +0800
Message-Id: <20251024065632.1448606-14-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

CET (architectural) MSRs include:
MSR_IA32_U_CET - user mode CET control bits.
MSR_IA32_S_CET - supervisor mode CET control bits.
MSR_IA32_PL{0,1,2,3}_SSP - linear addresses of SSPs for user/kernel modes.
MSR_IA32_SSP_TBL_ADDR - linear address of interrupt SSP table

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 - Rename MSR_IA32_SSP_TBL_ADDR to MSR_IA32_INT_SSP_TAB.
 - Rename X86CPUState.ssp_table_addr to X86CPUState.int_ssp_table.
 - Drop X86CPUStete.guest_ssp since it is not used in current commit.
 - Do not check CET-S & CET-U xtates when get/set MSTs since CET
   is XSAVE-managed feature but is not XSAVE-enabled.
---
 target/i386/cpu.h     | 16 +++++++++++
 target/i386/kvm/kvm.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 86fbfd5e4023..4edb977575e2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -580,6 +580,14 @@ typedef enum X86Seg {
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
 
+#define MSR_IA32_U_CET                  0x000006a0       /* user mode cet */
+#define MSR_IA32_S_CET                  0x000006a2       /* kernel mode cet */
+#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer */
+#define MSR_IA32_PL1_SSP                0x000006a5       /* ring-1 shadow stack pointer */
+#define MSR_IA32_PL2_SSP                0x000006a6       /* ring-2 shadow stack pointer */
+#define MSR_IA32_PL3_SSP                0x000006a7       /* ring-3 shadow stack pointer */
+#define MSR_IA32_INT_SSP_TAB            0x000006a8       /* exception shadow stack table */
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -2090,6 +2098,14 @@ typedef struct CPUArchState {
     uint64_t msr_rapl_power_unit;
     uint64_t msr_pkg_energy_status;
 
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+    uint64_t pl3_ssp;
+    uint64_t int_ssp_table;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f7a6ef650af7..92c2fd6d6aee 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4255,6 +4255,28 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
         }
     }
 
+    if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK ||
+        env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, env->pl1_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, env->pl2_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, env->pl3_ssp);
+
+            /*
+             * This MSR is not present on processors that do not support
+             * Intel 64 architecture.
+             */
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB,
+                                  env->int_ssp_table);
+            }
+        }
+    }
+
     return kvm_buf_set_msrs(cpu);
 }
 
@@ -4646,6 +4668,27 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK ||
+        env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+
+        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, 0);
+
+            /*
+             * This MSR is not present on processors that do not support
+             * Intel 64 architecture.
+             */
+            if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB, 0);
+            }
+        }
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -4993,6 +5036,27 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP:
+            env->pl0_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL1_SSP:
+            env->pl1_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL2_SSP:
+            env->pl2_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL3_SSP:
+            env->pl3_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_INT_SSP_TAB:
+            env->int_ssp_table = msrs[i].data;
+            break;
         case MSR_K7_HWCR:
             env->msr_hwcr = msrs[i].data;
             break;
-- 
2.34.1


