Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9C5D3E782
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZT1-0000dy-Vi; Thu, 11 Dec 2025 00:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSw-0000dU-Iz
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:51 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSu-0001OC-VS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431829; x=1796967829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OLmeyBkc275l2fFpoH7p7H8roBE/4ZOOO8W3RLBkAq8=;
 b=YSOir6SAX/fXwzZeXAcmcNgcQju8lM1/vuUKZkf4v6uES+skLHdANG+E
 AF8jOH0ziD63H60U5YOs0zCdVisLVfYfhA3ZJyO+CZPX68+Pp725v+BUZ
 bcVlyP7h9pNrnJ+T2LHf7Plb806NuvD/eokDNEKvcKd2SCYBASJA5KiNy
 kgl9BtnUPPTj8SdDVjI2DDK8OVg/V52XhThuFpqTW+6FkU5SMlZGI6etz
 /R+em0aqE26P+bG6Ypu1c0phJ/5lV5bqeCbicczjle1YxakcQ58egIkcN
 haJmHaFJkjHi2pMdADtFqkTTkNiizd2ZtjqMMinfn2ocesnCBoKiFtz5c A==;
X-CSE-ConnectionGUID: y88N2/MTRZijTExYgRvVyg==
X-CSE-MsgGUID: MhIGxJ1cRDChLwPVRxjTAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66409869"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66409869"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:43:48 -0800
X-CSE-ConnectionGUID: 0mfNbpUGSmKzsAOP+ctacg==
X-CSE-MsgGUID: vlX8I5qaT2qZyP9vFByNDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227366054"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:43:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 07/22] i386/cpu: Reorganize dependency check for arch lbr
 state
Date: Thu, 11 Dec 2025 14:07:46 +0800
Message-Id: <20251211060801.3600039-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211060801.3600039-1-zhao1.liu@intel.com>
References: <20251211060801.3600039-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

The arch lbr state has 2 dependencies:
 * Arch lbr feature bit (CPUID 0x7.0x0:EDX[bit 19]):

   This bit also depends on pmu property. Mask it off if pmu is disabled
   in x86_cpu_expand_features(), so that it is not needed to repeatedly
   check whether this bit is set as well as pmu is enabled.

   Note this doesn't need compat option, since even KVM hasn't support
   arch lbr yet.

   The supported xstate is constructed based such dependency in
   cpuid_has_xsave_feature(), so if pmu is disabled and arch lbr bit is
   masked off, then arch lbr state won't be included in supported
   xstates.

   Thus it's safe to drop the check on arch lbr bit in CPUID 0xD
   encoding.

 * XSAVES feature bit (CPUID 0xD.0x1.EAX[bit 3]):

   Arch lbr state is a supervisor state, which requires the XSAVES
   feature support. Enumerate supported supervisor state based on XSAVES
   feature bit in x86_cpu_enable_xsave_components().

   Then it's safe to drop the check on XSAVES feature support during
   CPUID 0XD encoding.

Suggested-by: Zide Chen <zide.chen@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f3bf7f892214..56b4c57969c1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8179,20 +8179,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = xsave_area_size(xstate, true);
             *ecx = env->features[FEAT_XSAVE_XSS_LO];
             *edx = env->features[FEAT_XSAVE_XSS_HI];
-            if (kvm_enabled() && cpu->enable_pmu &&
-                (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
-                (*eax & CPUID_XSAVE_XSAVES)) {
-                *ecx |= XSTATE_ARCH_LBR_MASK;
-            } else {
-                *ecx &= ~XSTATE_ARCH_LBR_MASK;
-            }
-        } else if (count == 0xf && cpu->enable_pmu
-                   && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            const ExtSaveArea *esa = &x86_ext_save_areas[count];
-
-            *eax = esa->size;
-            *ebx = esa->offset;
-            *ecx = esa->ecx;
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
@@ -8910,6 +8896,12 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
 
     mask = 0;
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        /* Skip supervisor states if XSAVES is not supported. */
+        if (CPUID_XSTATE_XSS_MASK & (1 << i) &&
+            !(env->features[FEAT_XSAVE] & CPUID_XSAVE_XSAVES)) {
+            continue;
+        }
+
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
         if (cpuid_has_xsave_feature(env, esa)) {
             mask |= (1ULL << i);
@@ -9027,11 +9019,13 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (!cpu->pdcm_on_even_without_pmu) {
+    if (!cpu->enable_pmu) {
         /* PDCM is fixed1 bit for TDX */
-        if (!cpu->enable_pmu && !is_tdx_vm()) {
+        if (!cpu->pdcm_on_even_without_pmu && !is_tdx_vm()) {
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }
+
+        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.34.1


