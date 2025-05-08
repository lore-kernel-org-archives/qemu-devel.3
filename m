Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2EBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2rQ-0004Bg-FD; Thu, 08 May 2025 11:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rN-0003r8-Je
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:29 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rJ-0007UR-Ll
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716905; x=1778252905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e9oQQbUuVFnD2yUp7MAAvRQXcEzbsQkQNA1ukXyYs6U=;
 b=K+39xvcX8BDfrLxrmenoXtiefwVRW+HZb3LUG6Z55BhUVFUeVdb3dhAz
 zIer5i/T54tO7ni8Ek1HJxnOnfFW+rJ7pfOVWeldvlwCZwgqUSyT/wwYx
 o8Mlu1ffoRx6hoR0JJ3KQY6yVaCv/cKO+pF0jBZjnYJ1GB7rOj50m7Tzg
 G4PMsXaf+NV3oAIUje//svZX8WrMiPWiObJUoiH/hUhpIpCvbQftCyWVI
 2ZZUMNhE4KY0ESmIKflXOTXtW4kXSgVKVeDhiiy2iup1H06XoH4Xm8V/8
 QVBcXblVhNXQKxth/ifJxia0ePcaVAFmEi3hSjCoOlhq+WEjczzBWEPJD Q==;
X-CSE-ConnectionGUID: SikjW/goSWafLDlkzuhP/A==
X-CSE-MsgGUID: k+wdQIniSBWRtSclOzN7sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888499"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:14 -0700
X-CSE-ConnectionGUID: yFG925/xQkyNJiJBdE2Cyg==
X-CSE-MsgGUID: dW3Ndon8TdS6AGLeV9YtDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440410"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:11 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 45/55] i386/tdx: Add TDX fixed1 bits to supported CPUIDs
Date: Thu,  8 May 2025 10:59:51 -0400
Message-ID: <20250508150002.689633-46-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

TDX architecture forcibly sets some CPUID bits for TD guest that VMM
cannot disable it. They are fixed1 bits.

Fixed1 bits are not covered by tdx_caps.cpuid (which only contains the
directly configurable bits), while fixed1 bits are supported for TD guest
obviously.

Add fixed1 bits to tdx_supported_cpuid. Besides, set all the fixed1
bits to the initial set of KVM's support since KVM might not report them
as supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v9:
 - Use the MACRO for bits in CPUID leaf 0x7_2_EDX; (Zhao Liu)
 - cleanup KVM_MAX_CPUID_ENTRIES in sev.c; (Zhao Liu)
---
 target/i386/cpu.h          |   2 +
 target/i386/kvm/kvm_i386.h |   7 ++
 target/i386/kvm/tdx.c      | 134 +++++++++++++++++++++++++++++++++++++
 target/i386/sev.c          |   8 ---
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 42ef77789ded..115137279a1a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -924,6 +924,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EDX_FSRM              (1U << 4)
 /* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
+ /* "md_clear" VERW clears CPU buffers */
+#define CPUID_7_0_EDX_MD_CLEAR          (1U << 10)
 /* SERIALIZE instruction */
 #define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
 /* TSX Suspend Load Address Tracking instruction */
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 484a1de84d51..c1bafcfc9b63 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,8 +13,15 @@
 
 #include "system/kvm.h"
 
+#include <linux/kvm.h>
+
 #define KVM_MAX_CPUID_ENTRIES  100
 
+typedef struct KvmCpuidInfo {
+    struct kvm_cpuid2 cpuid;
+    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+} KvmCpuidInfo;
+
 /* always false if !CONFIG_KVM */
 #define kvm_pit_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 91c6295ddd17..cbbbbf399309 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -374,6 +374,133 @@ static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
 
+/*
+ * Some CPUID bits change from fixed1 to configurable bits when TDX module
+ * supports TDX_FEATURES0.VE_REDUCTION. e.g., MCA/MCE/MTRR/CORE_CAPABILITY.
+ *
+ * To make QEMU work with all the versions of TDX module, keep the fixed1 bits
+ * here if they are ever fixed1 bits in any of the version though not fixed1 in
+ * the latest version. Otherwise, with the older version of TDX module, QEMU may
+ * treat the fixed1 bit as unsupported.
+ *
+ * For newer TDX module, it does no harm to keep them in tdx_fixed1_bits even
+ * though they changed to configurable bits. Because tdx_fixed1_bits is used to
+ * setup the supported bits.
+ */
+KvmCpuidInfo tdx_fixed1_bits = {
+    .cpuid.nent = 8,
+    .entries[0] = {
+        .function = 0x1,
+        .index = 0,
+        .ecx = CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_DTES64 |
+               CPUID_EXT_DSCPL | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 |
+               CPUID_EXT_PDCM | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+               CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+               CPUID_EXT_POPCNT | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+               CPUID_EXT_RDRAND | CPUID_EXT_HYPERVISOR,
+        .edx = CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+               CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+               CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+               CPUID_PAT | CPUID_CLFLUSH | CPUID_DTS | CPUID_MMX | CPUID_FXSR |
+               CPUID_SSE | CPUID_SSE2,
+    },
+    .entries[1] = {
+        .function = 0x6,
+        .index = 0,
+        .eax = CPUID_6_EAX_ARAT,
+    },
+    .entries[2] = {
+        .function = 0x7,
+        .index = 0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .ebx = CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_FDP_EXCPTN_ONLY |
+               CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_INVPCID |
+               CPUID_7_0_EBX_ZERO_FCS_FDS | CPUID_7_0_EBX_RDSEED |
+               CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+               CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_SHA_NI,
+        .ecx = CPUID_7_0_ECX_BUS_LOCK_DETECT | CPUID_7_0_ECX_MOVDIRI |
+               CPUID_7_0_ECX_MOVDIR64B,
+        .edx = CPUID_7_0_EDX_MD_CLEAR | CPUID_7_0_EDX_SPEC_CTRL |
+               CPUID_7_0_EDX_STIBP | CPUID_7_0_EDX_FLUSH_L1D |
+               CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_CORE_CAPABILITY |
+               CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+    },
+    .entries[3] = {
+        .function = 0x7,
+        .index = 2,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .edx = CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
+               CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_BHI_CTRL,
+    },
+    .entries[4] = {
+        .function = 0xD,
+        .index = 0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .eax = XSTATE_FP_MASK | XSTATE_SSE_MASK,
+    },
+    .entries[5] = {
+        .function = 0xD,
+        .index = 1,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .eax = CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC|
+               CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+    },
+    .entries[6] = {
+        .function = 0x80000001,
+        .index = 0,
+        .ecx = CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        /*
+         * Strictly speaking, SYSCALL is not fixed1 bit since it depends on
+         * the CPU to be in 64-bit mode. But here fixed1 is used to serve the
+         * purpose of supported bits for TDX. In this sense, SYACALL is always
+         * supported.
+         */
+        .edx = CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+               CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+    },
+    .entries[7] = {
+        .function = 0x80000007,
+        .index = 0,
+        .edx = CPUID_APM_INVTSC,
+    },
+};
+
+static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
+                                                        uint32_t index)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    e = cpuid_find_entry(tdx_supported_cpuid, function, index);
+    if (!e) {
+        if (tdx_supported_cpuid->nent >= KVM_MAX_CPUID_ENTRIES) {
+            error_report("tdx_supported_cpuid requries more space than %d entries",
+                          KVM_MAX_CPUID_ENTRIES);
+            exit(1);
+        }
+        e = &tdx_supported_cpuid->entries[tdx_supported_cpuid->nent++];
+        e->function = function;
+        e->index = index;
+    }
+
+    return e;
+}
+
+static void tdx_add_supported_cpuid_by_fixed1_bits(void)
+{
+    struct kvm_cpuid_entry2 *e, *e1;
+    int i;
+
+    for (i = 0; i < tdx_fixed1_bits.cpuid.nent; i++) {
+        e = &tdx_fixed1_bits.entries[i];
+
+        e1 = find_in_supported_entry(e->function, e->index);
+        e1->eax |= e->eax;
+        e1->ebx |= e->ebx;
+        e1->ecx |= e->ecx;
+        e1->edx |= e->edx;
+    }
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -386,6 +513,8 @@ static void tdx_setup_supported_cpuid(void)
     memcpy(tdx_supported_cpuid->entries, tdx_caps->cpuid.entries,
            tdx_caps->cpuid.nent * sizeof(struct kvm_cpuid_entry2));
     tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
+
+    tdx_add_supported_cpuid_by_fixed1_bits();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
@@ -470,6 +599,11 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
 {
     struct kvm_cpuid_entry2 *e;
 
+    e = cpuid_find_entry(&tdx_fixed1_bits.cpuid, feature, index);
+    if (e) {
+        value |= cpuid_entry_get_reg(e, reg);
+    }
+
     if (is_feature_word_cpuid(feature, index, reg)) {
         e = cpuid_find_entry(tdx_supported_cpuid, feature, index);
         if (e) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index a6c0a697250b..d03c2f157844 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -211,14 +211,6 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
-/* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
-#define KVM_MAX_CPUID_ENTRIES 100
-
-typedef struct KvmCpuidInfo {
-    struct kvm_cpuid2 cpuid;
-    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
-} KvmCpuidInfo;
-
 #define SNP_CPUID_FUNCTION_MAXCOUNT 64
 #define SNP_CPUID_FUNCTION_UNKNOWN 0xFFFFFFFF
 
-- 
2.43.0


