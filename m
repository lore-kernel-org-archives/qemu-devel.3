Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB1C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbwP-0003Ec-2G; Tue, 01 Apr 2025 09:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuz-0001Qw-7o
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbux-0006XQ-4q
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515079; x=1775051079;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ok8qhyI9I7c1GkICpo3h+qBKvmZgesDdAiav3DZU3tc=;
 b=lgoUBQjV8eAHcwzsa/X0Lg5i9e++XDJ+OUMp1tYfQziGg5sRjS75ReeJ
 DbbqTQdXrhrImKfStztinYHbxd+Q9SQmmGr/Y1c8aHpe7iFcelAGQDc2W
 uIHREmFyPF8JQCrYmKNTxpFzXFEaJgxXoEFIb4VltVTMi6HVMypMwjhBO
 kCEPWD7lydaNqMyHsE3+AGwDTbjMe8AvElSakyD768D/Thz6c2dLbia9M
 /MnrjM+tFMsgbTZ0+oROwxMKKDWLHDiWjo0eb0rrhBVqbt/FjwuEtjj7c
 ydW1Ks1Hmditg/vajJBPGN+n58WXgp8gIDX0wMqGoGfvQ/wlRDMChx7CU A==;
X-CSE-ConnectionGUID: b5CoOM/sQhm1Ts8oEXGAow==
X-CSE-MsgGUID: QdfS1J4sQgaPWWhyYwzZOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433547"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433547"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:10 -0700
X-CSE-ConnectionGUID: B84GwlDPT7qzxTcwiNy5wg==
X-CSE-MsgGUID: mgkIRpqTRqWD35K9ol0CSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640247"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:08 -0700
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
Subject: [PATCH v8 47/55] i386/tdx: Add supported CPUID bits relates to XFAM
Date: Tue,  1 Apr 2025 09:01:57 -0400
Message-Id: <20250401130205.2198253-48-xiaoyao.li@intel.com>
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

Some CPUID bits are controlled by XFAM. They are not covered by
tdx_caps.cpuid (which only contians the directly configurable bits), but
they are actually supported when the related XFAM bit is supported.

Add these XFAM controlled bits to TDX supported CPUID bits based on the
supported_xfam.

Besides, incorporate the supported_xfam into the supported CPUID leaf of
0xD.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     | 12 -------
 target/i386/cpu.h     | 16 ++++++++++
 target/i386/kvm/tdx.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4061d38d3fbe..f09a1caac071 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1673,15 +1673,6 @@ bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg)
     return false;
 }
 
-typedef struct FeatureMask {
-    FeatureWord index;
-    uint64_t mask;
-} FeatureMask;
-
-typedef struct FeatureDep {
-    FeatureMask from, to;
-} FeatureDep;
-
 static FeatureDep feature_dependencies[] = {
     {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
@@ -1850,9 +1841,6 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 };
 #undef REGISTER
 
-/* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
-
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0e984ec42bb6..132312d70a54 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -588,6 +588,7 @@ typedef enum X86Seg {
 #define XSTATE_OPMASK_BIT               5
 #define XSTATE_ZMM_Hi256_BIT            6
 #define XSTATE_Hi16_ZMM_BIT             7
+#define XSTATE_PT_BIT                   8
 #define XSTATE_PKRU_BIT                 9
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
@@ -601,6 +602,7 @@ typedef enum X86Seg {
 #define XSTATE_OPMASK_MASK              (1ULL << XSTATE_OPMASK_BIT)
 #define XSTATE_ZMM_Hi256_MASK           (1ULL << XSTATE_ZMM_Hi256_BIT)
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
+#define XSTATE_PT_MASK                  (1ULL << XSTATE_PT_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
@@ -623,6 +625,11 @@ typedef enum X86Seg {
                                  XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK | \
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+
+#define CPUID_XSTATE_MASK       (CPUID_XSTATE_XCR0_MASK | CPUID_XSTATE_XSS_MASK)
+
 /* CPUID feature words */
 typedef enum FeatureWord {
     FEAT_1_EDX,         /* CPUID[1].EDX */
@@ -671,6 +678,15 @@ typedef enum FeatureWord {
     FEATURE_WORDS,
 } FeatureWord;
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint64_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
 typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 5d72f1814606..c7b4a098d12f 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -23,6 +23,8 @@
 
 #include <linux/kvm_para.h>
 
+#include "cpu.h"
+#include "cpu-internal.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -485,6 +487,32 @@ static TdxAttrsMap tdx_attrs_maps[] = {
     },
 };
 
+typedef struct TdxXFAMDep {
+    int xfam_bit;
+    FeatureMask feat_mask;
+} TdxXFAMDep;
+
+/*
+ * Note, only the CPUID bits whose virtualization type are "XFAM & Native" are
+ * defiend here.
+ *
+ * For those whose virtualization type are "XFAM & Configured & Native", they
+ * are reported as configurable bits. And they are not supported if not in the
+ * configureable bits list from KVM even if the corresponding XFAM bit is
+ * supported.
+ */
+TdxXFAMDep tdx_xfam_deps[] = {
+    { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA }},
+    { XSTATE_YMM_BIT,       { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 }},
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_ECX, CPUID_7_0_ECX_AVX512_VBMI}},
+    { XSTATE_OPMASK_BIT,    { FEAT_7_0_EDX, CPUID_7_0_EDX_AVX512_FP16}},
+    { XSTATE_PT_BIT,        { FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT}},
+    { XSTATE_PKRU_BIT,      { FEAT_7_0_ECX, CPUID_7_0_ECX_PKU}},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 }},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE }},
+    { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 }},
+};
+
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
                                                         uint32_t index)
 {
@@ -552,6 +580,50 @@ static void tdx_add_supported_cpuid_by_attrs(void)
     }
 }
 
+static void tdx_add_supported_cpuid_by_xfam(void)
+{
+    struct kvm_cpuid_entry2 *e;
+    int i;
+
+    const TdxXFAMDep *xfam_dep;
+    const FeatureWordInfo *f;
+    for (i = 0; i < ARRAY_SIZE(tdx_xfam_deps); i++) {
+        xfam_dep = &tdx_xfam_deps[i];
+        if (!((1ULL << xfam_dep->xfam_bit) & tdx_caps->supported_xfam)) {
+            continue;
+        }
+
+        f = &feature_word_info[xfam_dep->feat_mask.index];
+        if (f->type != CPUID_FEATURE_WORD) {
+            continue;
+        }
+
+        e = find_in_supported_entry(f->cpuid.eax, f->cpuid.ecx);
+        switch(f->cpuid.reg) {
+        case R_EAX:
+            e->eax |= xfam_dep->feat_mask.mask;
+            break;
+        case R_EBX:
+            e->ebx |= xfam_dep->feat_mask.mask;
+            break;
+        case R_ECX:
+            e->ecx |= xfam_dep->feat_mask.mask;
+            break;
+        case R_EDX:
+            e->edx |= xfam_dep->feat_mask.mask;
+            break;
+        }
+    }
+
+    e = find_in_supported_entry(0xd, 0);
+    e->eax |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK);
+    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
+
+    e = find_in_supported_entry(0xd, 1);
+    e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
+    e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -567,6 +639,7 @@ static void tdx_setup_supported_cpuid(void)
 
     tdx_add_supported_cpuid_by_fixed1_bits();
     tdx_add_supported_cpuid_by_attrs();
+    tdx_add_supported_cpuid_by_xfam();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.34.1


