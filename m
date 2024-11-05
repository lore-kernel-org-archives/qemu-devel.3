Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E798AD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DGR-0003wQ-8F; Tue, 05 Nov 2024 01:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEP-0002jw-Pt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:02 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEN-0001w0-Iy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788800; x=1762324800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=deJjyJ9mt80ns5ej0bXUJMHjNBnYjzuUgaD7RaYuZHg=;
 b=CF65ixPH+49hN905BvW6k43KUERifGoUZAlsw44RLH4lZZNOvEBXVO2t
 tdRmyUJC6qbYa7vmaVaMmNwZn5l59FCjRMNXMpyrQMexAv+yGp5aCtzIp
 pXasCk7HtJZvXkP8VSL9SL1APKAsLoyMsNwzIfAJvyopotW5+vvqZLkKE
 DA1SzCJOgDWjZ2jWUPEJaHoFmTCUkyJ4p+wdyVs+xPTEfiI7tXIFQeRwZ
 xxMd5zZ/E1oHT8URO5gYRSRi1qVRPnrN3549WKyBTjxs7Jhswc/HRrXIK
 4QaetMTq+IxReymnea1Or6lbPDQj0dUHPDG678OxY3nlsqR+tylum+yLN w==;
X-CSE-ConnectionGUID: PJebBBoRSJWk53Sn+1iXNg==
X-CSE-MsgGUID: GQGVILnERTS6KPyHQrA9GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689844"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689844"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:39:48 -0800
X-CSE-ConnectionGUID: DRI0gvHuR1iEyNYSoW/T8w==
X-CSE-MsgGUID: XNjENJeDQkSChrVYaaBSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989792"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:39:44 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 48/60] i386/tdx: Apply TDX fixed0 and fixed1 information to
 supported CPUIDs
Date: Tue,  5 Nov 2024 01:23:56 -0500
Message-Id: <20241105062408.3533704-49-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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
cannot disable it. It also disallows some CPUID bits though they might
be supported for VMX VMs.

The fixed0 and fixed1 bits may vary on different TDX module and on
different host. It's a huge burden to maintain all combination. To
simplify it, hardcode the fixed0 and fixed1 CPUID bits that irrelative
with host in QEMU based on a new enough TDX module version.

Ideally, future TDX module can expose such fixed0 and fixed1 information
via some interface, then KVM can reported them to QEMU.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h          |   2 +
 target/i386/kvm/kvm_i386.h |   6 +++
 target/i386/kvm/tdx.c      | 102 +++++++++++++++++++++++++++++++++++++
 target/i386/sev.c          |   5 --
 4 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dcc673262c06..8118356af4fc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -854,6 +854,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EBX_SMAP              (1U << 20)
 /* AVX-512 Integer Fused Multiply Add */
 #define CPUID_7_0_EBX_AVX512IFMA        (1U << 21)
+/* PCOMMIT instruction */
+#define CPUID_7_0_EBX_PCOMMIT           (1U << 22)
 /* Flush a Cache Line Optimized */
 #define CPUID_7_0_EBX_CLFLUSHOPT        (1U << 23)
 /* Cache Line Write Back */
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index b1baf9e7f910..0b8240266dd9 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -12,9 +12,15 @@
 #define QEMU_KVM_I386_H
 
 #include "sysemu/kvm.h"
+#include <linux/kvm.h>
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
+typedef struct KvmCpuidInfo {
+    struct kvm_cpuid2 cpuid;
+    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+} KvmCpuidInfo;
+
 #ifdef CONFIG_KVM
 
 #define kvm_pit_in_kernel() \
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ba723db92bfe..bc1581d1e43b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -446,10 +446,100 @@ static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
     }
 }
 
+/*
+ * Fixed0 and Fixed1 bits info are grabbed from TDX 1.5.06 spec.
+ */
+KvmCpuidInfo tdx_fixed0_bits = {
+    .cpuid.nent = 3,
+    .entries[0] = {
+        .function = 0x1,
+        .index = 0x0,
+        .ecx = CPUID_EXT_VMX | CPUID_EXT_SMX,
+        .edx = CPUID_PSE36 | CPUID_IA64,
+    },
+    .entries[1] = {
+        .function = 0x7,
+        .index = 0x0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .ebx = CPUID_7_0_EBX_TSC_ADJUST | CPUID_7_0_EBX_SGX |
+               CPUID_7_0_EBX_PCOMMIT,
+        .ecx = CPUID_7_0_ECX_SGX_LC | (1U << 15) | (0x1fU << 17) | (1U << 26) |
+               (1U << 29),
+        .edx = (1U << 0) | (1U << 1) | (1U << 7) | (1U << 9) | (1U << 11) |
+               (1U << 12) | (1U << 13) | (1U << 15) | (1U << 17) | (1U << 21),
+    },
+    .entries[2] = {
+        .function = 0x80000001,
+        .index = 0x0,
+        .ecx = 0xFFFFFEDE,
+        .edx = 0xD3EFF7FF,
+    },
+};
+
+KvmCpuidInfo tdx_fixed1_bits = {
+    .cpuid.nent = 6,
+    .entries[0] = {
+        .function = 0x1,
+        .index = 0,
+        .ecx = CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_DTES64 |
+               CPUID_EXT_DSCPL | CPUID_EXT_SSE3 | CPUID_EXT_CX16 |
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
+        .edx = (1U << 10) | CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_STIBP |
+               CPUID_7_0_EDX_FLUSH_L1D | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+               CPUID_7_0_EDX_CORE_CAPABILITY | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+    },
+    .entries[3] = {
+        .function = 0x7,
+        .index = 2,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .edx = (1U << 0) | (1U << 1) | (1U << 2) | (1U << 4),
+    },
+    .entries[4] = {
+        .function = 0x80000001,
+        .index = 0,
+        .ecx = CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .edx = CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+               CPUID_EXT2_LM,
+    },
+    .entries[5] = {
+        .function = 0x80000007,
+        .index = 0,
+        .edx = CPUID_APM_INVTSC,
+    },
+};
+
 static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                           uint32_t feature, uint32_t index,
                                           int reg, uint32_t value)
 {
+    struct kvm_cpuid_entry2 *e;
+    uint32_t fixed0, fixed1;
+
     switch (feature) {
     case 0x7:
         if (index == 0 && reg == R_EBX) {
@@ -476,6 +566,18 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
         break;
     }
 
+    e = cpuid_find_entry(&tdx_fixed0_bits.cpuid, feature, index);
+    if (e) {
+        fixed0 = cpuid_entry_get_reg(e, reg);
+        value &= ~fixed0;
+    }
+
+    e = cpuid_find_entry(&tdx_fixed1_bits.cpuid, feature, index);
+    if (e) {
+        fixed1 = cpuid_entry_get_reg(e, reg);
+        value |= fixed1;
+    }
+
     return value;
 }
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4e6582c6a666..6982a957a6f7 100644
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


