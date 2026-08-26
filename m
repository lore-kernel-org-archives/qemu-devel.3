Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D0BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Jf-00080n-N7; Wed, 26 Aug 2026 04:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wz9Jd-00080d-9z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:01 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1wz9Ja-0001ZN-H2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:01 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ6cjJzcYn0d;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ4CHxzbQJxB;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTP86b39bd78b002a7930acc90d38cf50d3
 Wed, 26 Aug 2026 16:48:45 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v4 3/4] target/i386: Introduce Zhaoxin Shijidadao CPU model
Date: Wed, 26 Aug 2026 16:48:37 +0800
Message-Id: <20260826084838.2107629-4-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Introduce the Zhaoxin Shijidadao CPU model with two versions:

- v1 (alias: Shijidadao-Server) - Server variant with CORE_CAPABILITY
  and SPLIT_LOCK_DETECT support
- v2 (alias: Shijidadao-Client) - Client variant with different FMS
  (model=0x6b, stepping=1), with neither CORE_CAPABILITY features nor
  the ACE2 feature pair

Both versions include the SM2, CCS, RNG2, PHE2 and RSA feature pairs
exposed by KVM.

The model_id for both variants is 'Zhaoxin Shijidadao Processor'.

Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1107d1243c..70904810b5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7409,6 +7409,159 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
+    {
+        .name = "Shijidadao",
+        .level = 0x1f,
+        .vendor = CPUID_VENDOR_ZHAOXIN1,
+        .family = 7,
+        .model = 0x7b,
+        .stepping = 0,
+        .cpuid_0x1f = true,
+        /* missing: CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_ACPI | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
+            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
+            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
+            CPUID_PSE | CPUID_DE | CPUID_VME | CPUID_FP87,
+        /*
+         * missing: CPUID_EXT_OSXSAVE, CPUID_EXT_XTPR, CPUID_EXT_TM2,
+         * CPUID_EXT_EST, CPUID_EXT_SMX, CPUID_EXT_VMX
+         */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES | CPUID_EXT_TSC_DEADLINE_TIMER |
+            CPUID_EXT_POPCNT | CPUID_EXT_MOVBE | CPUID_EXT_X2APIC |
+            CPUID_EXT_SSE42 | CPUID_EXT_SSE41 | CPUID_EXT_PCID |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_FSGSBASE,
+        /* missing: CPUID_7_0_ECX_OSPKE */
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_UMIP,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_CORE_CAPABILITY,
+        .features[FEAT_CORE_CAPABILITY] =
+            MSR_CORE_CAP_SPLIT_LOCK_DETECT,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
+        .features[FEAT_8000_0007_EDX] = CPUID_APM_INVTSC,
+        /* missing: PARALLAX/PARALLAX_EN, TM3/TM3_EN */
+        .features[FEAT_C000_0001_EDX] =
+            CPUID_C000_0001_EDX_RSA_EN | CPUID_C000_0001_EDX_RSA |
+            CPUID_C000_0001_EDX_PHE2_EN | CPUID_C000_0001_EDX_PHE2 |
+            CPUID_C000_0001_EDX_RNG2_EN | CPUID_C000_0001_EDX_RNG2 |
+            CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
+            CPUID_C000_0001_EDX_PHE_EN | CPUID_C000_0001_EDX_PHE |
+            CPUID_C000_0001_EDX_ACE2_EN | CPUID_C000_0001_EDX_ACE2 |
+            CPUID_C000_0001_EDX_XCRYPT_EN | CPUID_C000_0001_EDX_XCRYPT |
+            CPUID_C000_0001_EDX_CCS_EN | CPUID_C000_0001_EDX_CCS |
+            CPUID_C000_0001_EDX_XSTORE_EN | CPUID_C000_0001_EDX_XSTORE |
+            CPUID_C000_0001_EDX_SM2_EN | CPUID_C000_0001_EDX_SM2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC | CPUID_XSAVE_XGETBV1 |
+            CPUID_XSAVE_XSAVES,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY |
+            MSR_ARCH_CAP_MDS_NO | MSR_ARCH_CAP_PSCHANGE_MC_NO |
+            MSR_ARCH_CAP_SSB_NO,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_INVLPG_EXITING |
+            VMX_CPU_BASED_MWAIT_EXITING | VMX_CPU_BASED_RDPMC_EXITING |
+            VMX_CPU_BASED_RDTSC_EXITING | VMX_CPU_BASED_CR3_LOAD_EXITING |
+            VMX_CPU_BASED_CR3_STORE_EXITING | VMX_CPU_BASED_CR8_LOAD_EXITING |
+            VMX_CPU_BASED_CR8_STORE_EXITING | VMX_CPU_BASED_TPR_SHADOW |
+            VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_MOV_DR_EXITING |
+            VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+            VMX_CPU_BASED_MONITOR_TRAP_FLAG | VMX_CPU_BASED_USE_MSR_BITMAPS |
+            VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        /*
+         * missing: VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
+         * VMX_SECONDARY_EXEC_TSC_SCALING
+         */
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP | VMX_SECONDARY_EXEC_ENABLE_VPID |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC |
+            VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_XSAVES      |
+            VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        /* missing: VMX_VM_ENTRY_SMM, VMX_VM_ENTRY_DEACT_DUAL_MONITOR */
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        /*
+         * missing: MSR_VMX_MISC_ACTIVITY_SHUTDOWN,
+         * MSR_VMX_MISC_ACTIVITY_WAIT_SIPI
+         */
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        /* missing: MSR_VMX_EPT_UC */
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Zhaoxin Shijidadao Processor",
+        .cache_info = &shijidadao_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            {
+                .version = 1,
+                .alias = "Shijidadao-Server",
+            },
+            {
+                .version = 2,
+                .alias = "Shijidadao-Client",
+                .note = "client variant",
+                .props = (PropValue[]) {
+                    { "model", "0x6b" },
+                    { "stepping", "1" },
+                    { "ace2", "off" },
+                    { "ace2-en", "off" },
+                    { "core-capability", "off" },
+                    { "split-lock-detect", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
+    },
 };
 
 /*
-- 
2.34.1



