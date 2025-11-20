Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA4CCF64BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTC-0005DT-2r; Thu, 20 Nov 2025 01:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT6-00057A-Bl
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT3-0005rC-A5
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621313; x=1795157313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ovsxg3hrz20CGPJgoBcOeGCszgdZlpPS7etlhX5Nax4=;
 b=mJKYJKf/OqAPvB4MPjMXIMICBVHig9PBQgKUXvfAnirKPTn3qAx3j/pd
 CIXrhNysN3oMdIJJAw7kzRkOqU4fu4zoytcIRGROKKCLh6+SSgQCscFgh
 qWc1xnYC/w3ndnoQH4RpvdHYJfsoxyXG3MH+z3QfMbG7bENnL7md9f/Qz
 j+AA2rICUsLpkqzyiNyndXTrVALCqaC1TaUlIQAQ9OMkSGxfkzpVUD3Hg
 q96eRelYs6LGSremCz3BJvUR+tWICN/+oHLu+T7j15o8vdnd7i6Wch9de
 A5PaRkbWSsRgXed2TwMHQrfUHrcuI8TZTBg5hurr99xJpd4AKaYevSjrC w==;
X-CSE-ConnectionGUID: pvD6G2JkTyqbtHPtDZMv1A==
X-CSE-MsgGUID: oBmBLREfQ7e9OiLw+cNwCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572546"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572546"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:26 -0800
X-CSE-ConnectionGUID: 4v6YAkJQTDSFIzHNcnzBLg==
X-CSE-MsgGUID: pe2+VRDpSYSFeVJ1cGoFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296123"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/10] i386/cpu: Add a helper to get host avx10 version
Date: Thu, 20 Nov 2025 15:10:25 +0800
Message-Id: <20251120071030.961230-6-zhao1.liu@intel.com>
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

Factor out a helper to get host avx10 version, to reduce duplicate
codes.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f0ed575dce59..118ce43e4267 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7757,6 +7757,13 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
 #endif /* !CONFIG_USER_ONLY */
 
+static uint8_t x86_cpu_get_host_avx10_version(void)
+{
+    uint32_t eax, ebx, ecx, edx;
+    x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+    return ebx & 0xff;
+}
+
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
@@ -9255,11 +9262,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
 
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
-            uint32_t eax, ebx, ecx, edx;
-            x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+            uint8_t version = x86_cpu_get_host_avx10_version();
 
             if (!object_property_set_uint(OBJECT(cpu), "avx10-version",
-                                          ebx & 0xff, errp)) {
+                                          version, errp)) {
                 return;
             }
         }
@@ -9481,9 +9487,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     have_filtered_features = x86_cpu_have_filtered_features(cpu);
 
     if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
-        x86_cpu_get_supported_cpuid(0x24, 0,
-                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
-        uint8_t version = ebx_0 & 0xff;
+        uint8_t version = x86_cpu_get_host_avx10_version();
 
         if (version < env->avx10_version) {
             if (prefix) {
-- 
2.34.1


