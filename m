Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D96CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOD-0003OA-18; Fri, 24 Oct 2025 02:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBO9-0003Na-6k
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:01 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBO7-0003kG-4b
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287699; x=1792823699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1GH9vquHN74+5LSVXHe36NI2rCkzhbhdx3Lz3Tfme0M=;
 b=fP4jIpKrT6HBv1/eifk3tqo0i+ESJDuEzPJhjDDQ0ZLAUw1mwffOHS5W
 bPzi2QKXaMv+AsqfJoJTxUZVgjbjKwdjCyj7i699PWUt8Ta+e/9uQk2OH
 UvPmRVq21yuHIw9jrczlhJP8H9gr/ZmBRjaEFbsegVVUfAUk+5/qCd631
 1lLHZdj1FDfwIZDV3eXttAZrYudi+QUDEd18jIGG8wgNWfApjApCUbMyY
 6g0U4WMIaTOUb+k2DGM7jPnHODIkfYKZDm/gPYpPUyz1pHcqbHaW+9wO7
 jLKecTvHNohifxRmSFJU3svsncFUGubbo1ja+NBjuutmfWEdteFg73VYg g==;
X-CSE-ConnectionGUID: RQHDUqqKQlGKBph6DDgOTA==
X-CSE-MsgGUID: lLktCpLWRk2qKJvAERcPHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137872"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137872"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:34:59 -0700
X-CSE-ConnectionGUID: OTV5HSueQcegg7LYrw+/3Q==
X-CSE-MsgGUID: G++/779WSp2AQWxCYxEhPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184275927"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:34:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 05/20] i386/cpu: Make ExtSaveArea store an array of
 dependencies
Date: Fri, 24 Oct 2025 14:56:17 +0800
Message-Id: <20251024065632.1448606-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

Some XSAVE components depend on multiple features. For example, Opmask/
ZMM_Hi256/Hi16_ZMM depend on avx512f OR avx10, and for CET (which will
be supported later), cet_u/cet_s will depend on shstk OR ibt.

Although previously there's the special check for the dependencies of
AVX512F OR AVX10 on their respective XSAVE components (in
cpuid_has_xsave_feature()), to make the code more general and avoid
adding more special cases, make ExtSaveArea store a features array
instead of a single feature, so that it can describe multiple
dependencies.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 71 ++++++++++++++++++++++++++++++++++-------------
 target/i386/cpu.h |  9 +++++-
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b9a5a0400dea..cd269d15ce0b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2020,53 +2020,77 @@ static const X86RegisterInfo32 x86_reg_info_32[CPU_NB_REGS32] = {
 ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     [XSTATE_FP_BIT] = {
         /* x87 FP state component is always enabled if XSAVE is supported */
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_XSAVE },
+        },
     },
     [XSTATE_SSE_BIT] = {
         /* SSE state component is always enabled if XSAVE is supported */
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_XSAVE,
         .size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_XSAVE },
+        },
     },
     [XSTATE_YMM_BIT] = {
-        .feature = FEAT_1_ECX, .bits = CPUID_EXT_AVX,
         .size = sizeof(XSaveAVX),
+        .features = {
+            { FEAT_1_ECX,           CPUID_EXT_AVX },
+        },
     },
     [XSTATE_BNDREGS_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
         .size = sizeof(XSaveBNDREG),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_MPX },
+        },
     },
     [XSTATE_BNDCSR_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_MPX,
         .size = sizeof(XSaveBNDCSR),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_MPX },
+        },
     },
     [XSTATE_OPMASK_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveOpmask),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_ZMM_Hi256_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveZMM_Hi256),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_Hi16_ZMM_BIT] = {
-        .feature = FEAT_7_0_EBX, .bits = CPUID_7_0_EBX_AVX512F,
         .size = sizeof(XSaveHi16_ZMM),
+        .features = {
+            { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+        },
     },
     [XSTATE_PKRU_BIT] = {
-        .feature = FEAT_7_0_ECX, .bits = CPUID_7_0_ECX_PKU,
         .size = sizeof(XSavePKRU),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_PKU },
+        },
     },
     [XSTATE_ARCH_LBR_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
         .size = sizeof(XSaveArchLBR),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_ARCH_LBR },
+        },
     },
     [XSTATE_XTILE_CFG_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILECFG),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_AMX_TILE },
+        },
     },
     [XSTATE_XTILE_DATA_BIT] = {
-        .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
         .size = sizeof(XSaveXTILEDATA),
+        .features = {
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_AMX_TILE },
+        },
     },
 };
 
@@ -7137,10 +7161,13 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     if (w == FEAT_XSAVE_XCR0_LO || w == FEAT_XSAVE_XCR0_HI) {
         int comp = (w == FEAT_XSAVE_XCR0_HI) ? bitnr + 32 : bitnr;
 
-        if (comp < ARRAY_SIZE(x86_ext_save_areas) &&
-            x86_ext_save_areas[comp].bits) {
-            w = x86_ext_save_areas[comp].feature;
-            bitnr = ctz32(x86_ext_save_areas[comp].bits);
+        if (comp < ARRAY_SIZE(x86_ext_save_areas)) {
+            /* Present the first feature as the default. */
+            const FeatureMask *fm = &x86_ext_save_areas[comp].features[0];
+            if (fm->mask != 0) {
+                w = fm->index;
+                bitnr = ctz32(fm->mask);
+            }
         }
     }
 
@@ -8610,11 +8637,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         return false;
     }
 
-    if (env->features[esa->feature] & esa->bits) {
-        return true;
+    for (int i = 0; i < ARRAY_SIZE(esa->features); i++) {
+        if (env->features[esa->features[i].index] & esa->features[i].mask) {
+            return true;
+        }
     }
-    if (esa->feature == FEAT_7_0_EBX && esa->bits == CPUID_7_0_EBX_AVX512F
-        && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+
+    if (esa->features[0].index == FEAT_7_0_EBX &&
+        esa->features[0].mask == CPUID_7_0_EBX_AVX512F &&
+        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
         return true;
     }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ac527971d8cd..6537affcf067 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1769,9 +1769,16 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
 
 typedef struct ExtSaveArea {
-    uint32_t feature, bits;
     uint32_t offset, size;
     uint32_t ecx;
+    /*
+     * The dependencies in the array work as OR relationships, which
+     * means having just one of those features is enough.
+     *
+     * At most two features are sharing the same xsave area.
+     * Number of features can be adjusted if necessary.
+     */
+    const FeatureMask features[2];
 } ExtSaveArea;
 
 #define XSAVE_STATE_AREA_COUNT (XSTATE_XTILE_DATA_BIT + 1)
-- 
2.34.1


