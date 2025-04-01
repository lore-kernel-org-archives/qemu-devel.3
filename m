Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F8C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbva-0002cL-VS; Tue, 01 Apr 2025 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuu-0001Iy-4t
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:41 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbus-0006Zf-3A
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515074; x=1775051074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZhwC6hibePhTCwcaMfL+r3F4/lIzR3KteqZx+VX9tQE=;
 b=HuUndlpAqrGxnbOJUsLT/eCSCcmTTyUTXsK1V0CH7dH9J/wgyrQUGvfo
 zYkWSAw4sn9M9APVFDV9erDpkBeG5fCubsHpD0dGXJb6/scblSkSunFqZ
 xxOvFQfPRwE2al4o/wtzSepy+7py2oCKqop9bya7LIIb/Gxchs/YhlBi7
 vn4hsAGamQEnUtT5uLaindeCnHWceak9HP0cAksKgf8xMoTCqMvcRsBDt
 lw9kHglRm8/B+AZQaU0EHwRklwNbHGkN8QOh61JYp0iMABVAqETVzblpe
 Qh4cgLHYzsePYcfgrmTtl2gEN0dSBKuWILPJLnwBbfQZF6xHotOSCi7gc g==;
X-CSE-ConnectionGUID: iuknbXx/S1upo47gfMNN0Q==
X-CSE-MsgGUID: iqOUF0auS3KKgyKqo7u1yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433539"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433539"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:08 -0700
X-CSE-ConnectionGUID: RMpW43U9S+uxtw7cQW/2qg==
X-CSE-MsgGUID: Mi65CvthQyuF36zqMHLwkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640240"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:05 -0700
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
Subject: [PATCH v8 46/55] i386/tdx: Add supported CPUID bits related to TD
 Attributes
Date: Tue,  1 Apr 2025 09:01:56 -0400
Message-Id: <20250401130205.2198253-47-xiaoyao.li@intel.com>
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

For TDX, some CPUID feature bit is configured via TD attributes. They
are not covered by tdx_caps.cpuid (which only contians the configurable
bits), but they are actually supported when the related attributre bit
is supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h     |  4 +++
 target/i386/kvm/tdx.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 115137279a1a..0e984ec42bb6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -903,6 +903,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_ECX_LA57              (1U << 16)
 /* Read Processor ID */
 #define CPUID_7_0_ECX_RDPID             (1U << 22)
+/* KeyLocker */
+#define CPUID_7_0_ECX_KeyLocker         (1U << 23)
 /* Bus Lock Debug Exception */
 #define CPUID_7_0_ECX_BUS_LOCK_DETECT   (1U << 24)
 /* Cache Line Demote Instruction */
@@ -963,6 +965,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* Linear address space separation */
+#define CPUID_7_1_EAX_LASS              (1U << 6)
 /* CMPCCXADD Instructions */
 #define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
 /* Fast Zero REP MOVS */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 49a94d8ffe7d..5d72f1814606 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -458,6 +458,33 @@ KvmCpuidInfo tdx_fixed1_bits = {
     },
 };
 
+typedef struct TdxAttrsMap {
+    uint32_t attr_index;
+    uint32_t cpuid_leaf;
+    uint32_t cpuid_subleaf;
+    int cpuid_reg;
+    uint32_t feat_mask;
+} TdxAttrsMap;
+
+static TdxAttrsMap tdx_attrs_maps[] = {
+    {.attr_index = 27,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 1,
+     .cpuid_reg = R_EAX,
+     .feat_mask = CPUID_7_1_EAX_LASS},
+    {.attr_index = 30,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 0,
+     .cpuid_reg = R_ECX,
+     .feat_mask = CPUID_7_0_ECX_PKS,},
+    {.attr_index = 31,
+     .cpuid_leaf = 7,
+     .cpuid_subleaf = 0,
+     .cpuid_reg = R_ECX,
+     .feat_mask = CPUID_7_0_ECX_KeyLocker,
+    },
+};
+
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
                                                         uint32_t index)
 {
@@ -494,6 +521,37 @@ static void tdx_add_supported_cpuid_by_fixed1_bits(void)
     }
 }
 
+static void tdx_add_supported_cpuid_by_attrs(void)
+{
+    struct kvm_cpuid_entry2 *e;
+    TdxAttrsMap *map;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(tdx_attrs_maps); i++) {
+        map = &tdx_attrs_maps[i];
+        if (!((1ULL << map->attr_index) & tdx_caps->supported_attrs)) {
+            continue;
+        }
+
+        e = find_in_supported_entry(map->cpuid_leaf, map->cpuid_subleaf);
+
+        switch(map->cpuid_reg) {
+        case R_EAX:
+            e->eax |= map->feat_mask;
+            break;
+        case R_EBX:
+            e->ebx |= map->feat_mask;
+            break;
+        case R_ECX:
+            e->ecx |= map->feat_mask;
+            break;
+        case R_EDX:
+            e->edx |= map->feat_mask;
+            break;
+        }
+    }
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -508,6 +566,7 @@ static void tdx_setup_supported_cpuid(void)
     tdx_supported_cpuid->nent = tdx_caps->cpuid.nent;
 
     tdx_add_supported_cpuid_by_fixed1_bits();
+    tdx_add_supported_cpuid_by_attrs();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.34.1


