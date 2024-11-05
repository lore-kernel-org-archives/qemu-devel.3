Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4862CD1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DGJ-0003wC-FS; Tue, 05 Nov 2024 01:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEZ-0003Jp-H3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:12 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEX-0001vj-Lv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788810; x=1762324810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=st5/vyvnaPY+w7rPqzvPYRhQDfLRvMD4QU7tirPy57w=;
 b=iJxjlLww7BNiFkAYoXyPBWZwzy30x0TtsrRp1/OJhGG9LIHGDrUPlLOT
 iUdtWB4gbE4AEq1gPMg5Fr70k/zn/oUjQ4P2abYCuNM+geefvBRmpX1Wc
 e2u5jvd/t6TA7sxoqJwu7N0PJbmeNmGKW8in8f7ELf7LRPq3DFTto/MTa
 owdOORmaDYERJFwJU+/ACgWcer5On+pIDByUmsKlGcx1RSyE4nEWiTCZy
 j7bdBHhXqaEndwPGp79lC2B+ON3aoIZlhflzm58UV6tx8rN5bs+/XW+Jo
 RHR3cfK6TqKJYs9qDMtgn7UepIcKlVWakUDv9WN34y0lMZHFMPgFqDlsE g==;
X-CSE-ConnectionGUID: LieXTUHJTECa6eTN059MJg==
X-CSE-MsgGUID: s561OErZQsq58I0Zx7SzDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689854"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:39:53 -0800
X-CSE-ConnectionGUID: 5WJ5xED5SVGuZQVUr6MnSA==
X-CSE-MsgGUID: 5It1nMLzSeKHTxiykp0Vsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989825"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:39:48 -0800
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
Subject: [PATCH v6 49/60] i386/tdx: Mask off CPUID bits by unsupported TD
 Attributes
Date: Tue,  5 Nov 2024 01:23:57 -0500
Message-Id: <20241105062408.3533704-50-xiaoyao.li@intel.com>
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

For TDX, some CPUID feature bit is configured via TD attributes. Adjust
the supported CPUID to mask off the bit if its matched attribute is
unsupported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/tdx.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8118356af4fc..e02e23d972a0 100644
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
@@ -955,6 +957,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* Linear address space separation */
+#define CPUID_7_1_EAX_LASS              (1U << 6)
 /* CMPCCXADD Instructions */
 #define CPUID_7_1_EAX_CMPCCXADD         (1U << 7)
 /* Fast Zero REP MOVS */
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index bc1581d1e43b..5ac5f93907ca 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -533,6 +533,58 @@ KvmCpuidInfo tdx_fixed1_bits = {
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
+static void tdx_mask_cpuid_by_attrs(uint32_t feature, uint32_t index,
+                                    int reg, uint32_t *value)
+{
+    TdxAttrsMap *map;
+    uint64_t unavail = 0;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(tdx_attrs_maps); i++) {
+        map = &tdx_attrs_maps[i];
+
+        if (feature != map->cpuid_leaf || index != map->cpuid_subleaf ||
+            reg != map->cpuid_reg) {
+            continue;
+        }
+
+        if (!((1ULL << map->attr_index) & tdx_caps->supported_attrs)) {
+            unavail |= map->feat_mask;
+        }
+    }
+
+    if (unavail) {
+        *value &= ~unavail;
+    }
+}
+
 static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                           uint32_t feature, uint32_t index,
                                           int reg, uint32_t value)
@@ -566,6 +618,8 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
         break;
     }
 
+    tdx_mask_cpuid_by_attrs(feature, index, reg, &value);
+
     e = cpuid_find_entry(&tdx_fixed0_bits.cpuid, feature, index);
     if (e) {
         fixed0 = cpuid_entry_get_reg(e, reg);
-- 
2.34.1


