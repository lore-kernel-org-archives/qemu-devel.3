Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4102C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbyp-0005D1-7E; Tue, 01 Apr 2025 09:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbul-00014d-Qu
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:29 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbui-0006ZP-J2
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515064; x=1775051064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dCqogoyYG6qGaIWRDdW3DG5t0kRWSGhPDSbOwdRrrSk=;
 b=bIuKlxho8NSsN48AFwJxC8DDpXXWeYFEl8gocjIjryfxe2iFMOh+/6h9
 rtZzf5ii0AS6H4TDXhzWKPszvYEUvvIIuiUUBqbrKaTZcTP/IsUyJkBun
 QrD2oL8BWIxoRmvSKBP/uExLHKUpRfl4Uge6hs+t5QH59wxA2vRr1vUVX
 R8jeLEODGLGIxAVU3DbNbnv/wkWeLELwahXOaSX3SdcEwbMnYTbT8zpde
 T2kZU90cZNwy2sdxizL7eEW75L7ZgckdK8IOJNd1KR4p3yaTs/7gkmrpS
 T1QESSLvW601ppoAcDRi82l30rTmWB9Kyxt3YVEjb0A8JCMUlY4oVSv1h A==;
X-CSE-ConnectionGUID: 2W1ZzjQESvG8OfNo+rFM/A==
X-CSE-MsgGUID: ThBA7TLUT6+oEcuK24GHkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433529"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433529"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:05 -0700
X-CSE-ConnectionGUID: cfaMfFdgQ5KpGkX2jBRt8g==
X-CSE-MsgGUID: wMJvDbbhS+WP6gaC8mFz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640233"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:02 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 45/55] i386/tdx: Add TDX fixed1 bits to supported CPUIDs
Date: Tue,  1 Apr 2025 09:01:55 -0400
Message-Id: <20250401130205.2198253-46-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

TDX architecture forcibly sets some CPUID bits for TD guest that VMM
cannot disable it. They are fixed1 bits.

Fixed1 bits are not covered by tdx_caps.cpuid (which only contians the
directly configurable bits), while fixed1 bits are supported for TD guest
obviously.

Add fixed1 bits to tdx_supported_cpuid. Besides, set all the fixed1
bits to the initial set of KVM's support since KVM might not report them
as supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h          |   2 +
 target/i386/kvm/kvm_i386.h |   7 ++
 target/i386/kvm/tdx.c      | 132 +++++++++++++++++++++++++++++++++++++
 target/i386/sev.c          |   5 --
 4 files changed, 141 insertions(+), 5 deletions(-)

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
index b9a96c2e392d..49a94d8ffe7d 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -369,6 +369,131 @@ static Notifier tdx_machine_done_notify = {
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
+        .edx = (1U << 0) | (1U << 1) | (1U << 2) | (1U << 4),
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
+        /* strictly speaking, SYSCALL is not fixed1 bit since it depends on
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
@@ -381,6 +506,8 @@ static void tdx_setup_supported_cpuid(void)
     memcpy(tdx_supported_cpuid->entries, tdx_caps->cpuid.entries,
            tdx_caps->cpuid.nent * sizeof(struct kvm_cpuid_entry2));
     tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
+
+    tdx_add_supported_cpuid_by_fixed1_bits();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
@@ -465,6 +592,11 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
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
index a6c0a697250b..217b19ad7bc6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -214,11 +214,6 @@ static const char *const sev_fw_errlist[] = {
 /* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
 #define KVM_MAX_CPUID_ENTRIES 100
 
-typedef struct KvmCpuidInfo {
-    struct kvm_cpuid2 cpuid;
-    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
-} KvmCpuidInfo;
-
 #define SNP_CPUID_FUNCTION_MAXCOUNT 64
 #define SNP_CPUID_FUNCTION_UNKNOWN 0xFFFFFFFF
 
-- 
2.34.1


