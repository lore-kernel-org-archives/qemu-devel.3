Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DF1CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCHw-0002gX-NK; Mon, 17 Nov 2025 22:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHq-0002JB-D7
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:47 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHa-0004HZ-Jm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436091; x=1794972091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OT9yXKg8cGU4vWhy5aN4ndDqiEVed8ea36SkVfyMMTw=;
 b=bp0Ubenk1v0XESjWV7kowGOSJzm0pQmVqyv+bo5isip+d74dgQqUl1GF
 TqehXT7ZWevq2Gni6YvpeeFI6kNnWYlFcp2MxVIAJhwK5GWbU/C7A/wUP
 k7OmUHr/GLk8m2rOU1VHbXn3EhjBD4uNXp2KvUStmMhm3+6n6jjminzDk
 9uU3gm32L+sY9eWJJu46r960Vn8XyRI04179aTPQh36dpgCFs1JAiwa2F
 lJfqQZT6cI5Xx4tH5xNlCJFCrqN8ARiwdi7UkyowhD+qoLxZUR7krvDqk
 E4QvuXBrx6jc4JECd5Sedorr3VvguWVvYXD2kGH5hPWacMovMV83UbVuQ A==;
X-CSE-ConnectionGUID: xrS2irVRQ6mIYTVYK+daeA==
X-CSE-MsgGUID: 9+1Etd+2TSiOYBvZxaKp5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053886"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053886"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:10 -0800
X-CSE-ConnectionGUID: z3MWa+37RL2HVBKD4nv5tA==
X-CSE-MsgGUID: cwPmblDqQneNRq0+Oxn7fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537295"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:05 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v4 15/23] i386/kvm: Add save/restore support for CET MSRs
Date: Tue, 18 Nov 2025 11:42:23 +0800
Message-Id: <20251118034231.704240-16-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

CET (architectural) MSRs include:
MSR_IA32_U_CET - user mode CET control bits.
MSR_IA32_S_CET - supervisor mode CET control bits.
MSR_IA32_PL{0,1,2,3}_SSP - linear addresses of SSPs for user/kernel modes.
MSR_IA32_INT_SSP_TAB - linear address of interrupt SSP table

Since FRED also needs to save/restore MSR_IA32_PL0_SSP, to avoid duplicate
operations, make FRED only save/restore MSR_IA32_PL0_SSP when CET-SHSTK
is not enumerated.

And considerring MSR_IA32_SSP_TBL_ADDR is only presented on 64 bit
processor, wrap it with TARGET_X86_64 macro.

For other MSRs, add save/restore support directly.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Suggested-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Make FRED only save/restore MSR_IA32_PL0_SSP when CET-SHSTK isn't
   enumerated.
 - Wrap MSR_IA32_INT_SSP_TAB with TARGET_X86_64 since it's a
   x86_64-specific MSR.

Changes Since v2:
 - Rename MSR_IA32_SSP_TBL_ADDR to MSR_IA32_INT_SSP_TAB.
 - Rename X86CPUState.ssp_table_addr to X86CPUState.int_ssp_table.
 - Drop X86CPUStete.guest_ssp since it is not used in current commit.
 - Do not check CET-S & CET-U xtates when get/set MSTs since CET
   is XSAVE-managed feature but is not XSAVE-enabled.
---
 target/i386/cpu.h     | 26 ++++++++++---
 target/i386/kvm/kvm.c | 91 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0432af1769d2..661b798da4d0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -543,7 +543,7 @@ typedef enum X86Seg {
 #define MSR_IA32_XFD                    0x000001c4
 #define MSR_IA32_XFD_ERR                0x000001c5
 
-/* FRED MSRs */
+/* FRED MSRs (MSR_IA32_FRED_SSP0 is defined as MSR_IA32_PL0_SSP in CET MSRs) */
 #define MSR_IA32_FRED_RSP0              0x000001cc       /* Stack level 0 regular stack pointer */
 #define MSR_IA32_FRED_RSP1              0x000001cd       /* Stack level 1 regular stack pointer */
 #define MSR_IA32_FRED_RSP2              0x000001ce       /* Stack level 2 regular stack pointer */
@@ -554,9 +554,6 @@ typedef enum X86Seg {
 #define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
 #define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
 
-/* FRED and CET MSR */
-#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer (aka MSR_IA32_FRED_SSP0 for FRED) */
-
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -583,6 +580,15 @@ typedef enum X86Seg {
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
 
+/* CET MSRs */
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
@@ -1976,8 +1982,16 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
-    /* MSR used for both FRED and CET (SHSTK) */
-    uint64_t pl0_ssp;
+    /* CET MSRs */
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp; /* also used for FRED */
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+    uint64_t pl3_ssp;
+#ifdef TARGET_X86_64
+    uint64_t int_ssp_table;
+#endif
 
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 00fead0827ed..4eb58ca19d79 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4008,11 +4008,14 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
-            /*
-             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
-             * CET shadow stack is not supported.
-             */
-            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+
+            if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+                /*
+                 * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+                 * CET shadow stack is not supported.
+                 */
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+            }
         }
     }
 #endif
@@ -4266,6 +4269,26 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
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
+#ifdef TARGET_X86_64
+            if (lm_capable_kernel) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB,
+                                  env->int_ssp_table);
+            }
+#endif
+        }
+    }
+
     return kvm_buf_set_msrs(cpu);
 }
 
@@ -4500,11 +4523,14 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
-            /*
-             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
-             * CET shadow stack is not supported.
-             */
-            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+
+            if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+                /*
+                 * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+                 * CET shadow stack is not supported.
+                 */
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+            }
         }
     }
 #endif
@@ -4662,6 +4688,25 @@ static int kvm_get_msrs(X86CPU *cpu)
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
+#ifdef TARGET_X86_64
+            if (lm_capable_kernel) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB, 0);
+            }
+#endif
+        }
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -4756,9 +4801,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_FRED_CONFIG:
             env->fred_config = msrs[i].data;
             break;
-        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
-            env->pl0_ssp = msrs[i].data;
-            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
@@ -5012,6 +5054,29 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
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
+#ifdef TARGET_X86_64
+        case MSR_IA32_INT_SSP_TAB:
+            env->int_ssp_table = msrs[i].data;
+            break;
+#endif
         case MSR_K7_HWCR:
             env->msr_hwcr = msrs[i].data;
             break;
-- 
2.34.1


