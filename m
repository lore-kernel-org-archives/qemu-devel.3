Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A64FD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2le-00036z-Hq; Mon, 15 Dec 2025 02:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lc-00035h-OM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:12 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2la-0008DW-Vd
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782791; x=1797318791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x/GWY5xCsiPSP8QT5GyO13Q2zely1l5tmVx6MnF5Izk=;
 b=FthllGDATsASj72DWCFNI2GLe1Mtjdh1/j8+0stpaZnPcdFhEC44cTrK
 GYaGaize0l0QdX4eq543234Anc2a77dK90y2Q0fko+vJsSfBqK4vmOk2q
 Ku13wPxQdvI4/ONseK7Ci/pqzf+GH1nqd9o05QWQhOcWFBEyCyWwaUmwD
 RWbLoryDOj4TvGgGN097DWeh4erFEW8/2z93SZjqHd1leLI6oqOlPNC4Q
 Wz1fRpH73BXNQXJPW1KcxPcCEd+SoM9xG1AsIwaI7rPNx9XE3oeBBJC5Q
 7wyEE0gR/DKvGEZ3QRSocUV1LkVilNiH1IbgcXRi+Q+KSCV9VSZxhTJ+7 Q==;
X-CSE-ConnectionGUID: 9VPYhRFnTm2UCJ2Cj6hPMg==
X-CSE-MsgGUID: Uwc8DQB2QpmNT+L5KvgZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332252"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332252"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:11 -0800
X-CSE-ConnectionGUID: 7ja6MCILQca1nDG1dsrUKg==
X-CSE-MsgGUID: ehGfwQzyTG6ltpcnGInocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265949"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:09 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/11] i386/cpu: Add a helper to get host avx10 version
Date: Mon, 15 Dec 2025 15:37:37 +0800
Message-Id: <20251215073743.4055227-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215073743.4055227-1-zhao1.liu@intel.com>
References: <20251215073743.4055227-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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
index 05b001b80cfd..c47e06cb79e7 100644
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
@@ -9265,11 +9272,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
@@ -9491,9 +9497,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
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


