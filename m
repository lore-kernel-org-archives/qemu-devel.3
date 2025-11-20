Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C8CF8549
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTE-0005EK-6t; Thu, 20 Nov 2025 01:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT9-0005CQ-4W
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:39 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT6-0005ql-P0
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621317; x=1795157317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TPn7r7hr8aDsQrWHjR6/JJ2HIYOQiLPNrvox7D2MP50=;
 b=nIdgVr8p37oAz54B0RGXZEFKFwB6lXnVlk6fiev8WZpT8x3ga1gbE0LH
 wWY8YYuomCi3f7z03/FZ9ysb9v45Oz38Z3uN0W0reHHafpIhF9dZyj8YG
 Oj+X8DoFTevww304AGRMloNX1McBJO7vPdhbT0gqRM3GpVNWVg5fl5D4a
 EcYWL6M7uBhiAhh18w2bR5+g8dT7vxBjoi34rr/rannI/4SUDx/eTKaon
 Mwshneg/Bti+zX6xXRA4WBfw8/HACQ6aLR764vHPxo4YibZD8msRRsD0x
 xwBJdPsr6Kv/Ge7XPWP7VMYtBPQ0M25lyRxdAn1fqslcsf+l9F3DWr+M3 A==;
X-CSE-ConnectionGUID: kyBXchONTn+37XbNE+upMw==
X-CSE-MsgGUID: Y9DPO15mQnubV4Qdwwx4sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572562"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572562"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:34 -0800
X-CSE-ConnectionGUID: dd8C0j4jQgOnJRq+d+nRkw==
X-CSE-MsgGUID: 7Dqjx9JKTf6IusWRoDynqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296137"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/10] i386/cpu: Add CPU model for Diamond Rapids
Date: Thu, 20 Nov 2025 15:10:29 +0800
Message-Id: <20251120071030.961230-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

According to table 1-2 in Intel Architecture Instruction Set Extensions
and Future Features (rev 059), Diamond Rapids has the following new
features which have already been supported for guest:
 * SM4 (EVEX)
 * Intel Advanced Vector Extensions 10 Version 2 (Intel AVX10.2)
 * MOVRS and the PREFETCHRST2 instruction
 * AMX-MOVRS, AMX-AVX512, AMX-FP8, AMX-TF32
 * Intel Advanced Performance Extensions

And FRED - Flexible Return and Event Delivery (FRED) and the LKGS
instruction (introduced since Clearwater Forest & Diamond Rapids) - is
included in Diamond Rapids CPU model.

In addition, the following features are added into Diamond Rapids CPU
model:
 * CET: Control-flow Enforcement Technology (introduced since Sapphire
   Rapids & Sierra Forest).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Reference link: https://cdrdv2.intel.com/v1/dl/getContent/865891
---
 target/i386/cpu.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e891883fa72f..e2d728d38d6f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5443,6 +5443,198 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ },
         },
     },
+    {
+        .name = "DiamondRapids",
+        .level = 0x29,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 0x13, /* family: 0xf, extended famil: 0x4 */
+        .model = 0x1, /* model: 0x1, extended model: 0x0 */
+        .stepping = 0,
+        .avx10_version = 2, /* avx10.2 */
+        .cpuid_0x1f = true,
+        /*
+         * Please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         *
+         * Missing: CPUID_EXT_DTES64, CPUID_EXT_MONITOR, CPUID_EXT_DSCPL,
+         * CPUID_EXT_VMX, CPUID_EXT_SMX, CPUID_EXT_EST, CPUID_EXT_TM2,
+         * CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_DCA, CPUID_EXT_OSXSAVE
+         */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        /* Missing: CPUID_DTS, CPUID_ACPI, CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2 | CPUID_SS,
+        .features[FEAT_6_EAX] = CPUID_6_EAX_ARAT,
+        /*
+         * Missing: CPUID_7_0_EBX_SGX, "cqm" Cache QoS Monitoring,
+         * "rdt_a" Resource Director Technology Allocation,
+         * CPUID_7_0_EBX_INTEL_PT,
+         */
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
+            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_FDP_EXCPTN_ONLY | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_ZERO_FCS_FDS |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_AVX512BW |
+            CPUID_7_0_EBX_AVX512VL,
+        /*
+         * Missing: CPUID_7_0_ECX_OSPKE, CPUID_7_0_ECX_WAITPKG, TME, ENQCMD,
+         * CPUID_7_0_ECX_SGX_LC, CPUID_7_0_ECX_PKS
+         */
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP |
+            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_AVX512_VBMI2 |
+            CPUID_7_0_ECX_CET_SHSTK | CPUID_7_0_ECX_GFNI | CPUID_7_0_ECX_VAES |
+            CPUID_7_0_ECX_VPCLMULQDQ | CPUID_7_0_ECX_AVX512VNNI |
+            CPUID_7_0_ECX_AVX512BITALG | CPUID_7_0_ECX_AVX512_VPOPCNTDQ |
+            CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_RDPID |
+            CPUID_7_0_ECX_BUS_LOCK_DETECT | CPUID_7_0_ECX_CLDEMOTE |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_MOVDIR64B,
+        /*
+         * Missing: SGX-KEYS, UINTR, PCONFIG, ARCH LBR,
+         * CPUID_7_0_EDX_CORE_CAPABILITY
+         */
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_MD_CLEAR |
+            CPUID_7_0_EDX_SERIALIZE | CPUID_7_0_EDX_TSX_LDTRK |
+            CPUID_7_0_EDX_CET_IBT | CPUID_7_0_EDX_AMX_BF16 |
+            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
+            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_STIBP | CPUID_7_0_EDX_FLUSH_L1D |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* Missing: CPUID_7_1_EAX_LASS, ArchPerfmonExt (0x23 leaf), MSRLIST */
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
+            CPUID_7_1_EAX_CMPCCXADD | CPUID_7_1_EAX_FZRM |
+            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_FRED |
+            CPUID_7_1_EAX_LKGS | CPUID_7_1_EAX_WRMSRNS |
+            CPUID_7_1_EAX_AMX_FP16 | CPUID_7_1_EAX_AVX_IFMA |
+            CPUID_7_1_EAX_LAM | CPUID_7_1_EAX_MOVRS,
+        /* Missing: CET_SSS */
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT |
+            CPUID_7_1_EDX_AMX_COMPLEX | CPUID_7_1_EDX_PREFETCHITI |
+            CPUID_7_1_EDX_AVX10 | CPUID_7_1_EDX_APX,
+        /* Missing: UC-lock disable */
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
+            CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_DDPD_U |
+            CPUID_7_2_EDX_BHI_CTRL | CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
+        .features[FEAT_1E_1_EAX] =
+            CPUID_1E_1_EAX_AMX_INT8_MIRROR | CPUID_1E_1_EAX_AMX_BF16_MIRROR |
+            CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR |
+            CPUID_1E_1_EAX_AMX_FP16_MIRROR | CPUID_1E_1_EAX_AMX_FP8 |
+            CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
+            CPUID_1E_1_EAX_AMX_MOVRS,
+        .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
+        /*
+         * Though this bit will be set by avx_version=2, it's better to
+         * explicitly enumerate this feature here.
+         */
+        .features[FEAT_24_1_ECX] = CPUID_24_1_ECX_AVX10_VNNI_INT,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0008_EBX] = CPUID_8000_0008_EBX_WBNOINVD,
+        /*
+         * Missing: ARCH_CAP_RRSBA (KVM bit 19), ARCH_CAP_RFDS_CLEAR (KVM bit
+         * 28), MCU_CONTROL (bit 9), MISC_PACKAGE_CTLS (bit 10),
+         * ENERGY_FILTERING_CTL (bit 11), DOITM (bit 12), MCU_ENUMERATION (bit
+         * 16), RRSBA (bit 19), XAPIC_DISABLE_STATUS (bit 21),
+         * OVERCLOCKING_STATUS (bit 23).
+         */
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO |
+            MSR_ARCH_CAP_SBDR_SSDP_NO | MSR_ARCH_CAP_FBSDP_NO |
+            MSR_ARCH_CAP_PSDP_NO | MSR_ARCH_CAP_BHI_NO |
+            MSR_ARCH_CAP_PBRSB_NO | MSR_ARCH_CAP_GDS_NO |
+            MSR_ARCH_CAP_RFDS_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS |
+            MSR_VMX_BASIC_NESTED_EXCEPTION,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER |
+            VMX_VM_ENTRY_LOAD_CET | VMX_VM_ENTRY_LOAD_IA32_FRED,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY |
+            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE,
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
+            VMX_VM_EXIT_SAVE_CET | VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_ACTIVITY_SHUTDOWN | MSR_VMX_MISC_ACTIVITY_WAIT_SIPI |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES | VMX_SECONDARY_EXEC_TSC_SCALING |
+            VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (DiamondRapids)",
+    },
     {
         .name = "SierraForest",
         .level = 0x23,
-- 
2.34.1


