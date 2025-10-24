Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56226CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOH-0003SP-Jp; Fri, 24 Oct 2025 02:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOC-0003Oy-RP
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:04 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOB-0003kG-2K
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287703; x=1792823703;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MDD3UDmX4/TjoBSUbSkkNvFBKgw/jTaSm8KWZIYQic8=;
 b=maYZM4PQUxcernYqQl+6GLhTqy18PgEx4XjFi/InGj6RmYXZtSVD3Wf7
 MRfqCV8VD6MRqHSDyF6xpLxYIeXlquKc2oBD/HPH37m0DTDJ7OboWkwSN
 gqyrUk8DzRC6dRb9RygzLMv1lUU9teAsrjYJq1QweLnuupJjz7IkGtBuN
 HA0wXmoAsnx1jw80JkLwzOvARZIEPyuEunNOi/k7TlsnB8xsgxomaTJBf
 +QaVFzvJ1XpZRWFHVCRxT5W3zTrmgKDoMCo1IoSr9Qn9gmVFqFEwJCWgo
 VqCpo0NjSUCgLUlIl/omxX/rgoTHV3gB9Y6Iv8BMgXFub9VSx5xRvgwnK w==;
X-CSE-ConnectionGUID: axhksbrwQ+6Np4HQesiM/A==
X-CSE-MsgGUID: ZV1vusi9Tk6GhDwny7dbEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137877"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:02 -0700
X-CSE-ConnectionGUID: Jb4PQH+FRyaVh2fd2GrpTg==
X-CSE-MsgGUID: n6YJ5yxRQHa/JhPyDhbFFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184275952"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:34:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 06/20] i386/cpu: Add avx10 dependency for
 Opmask/ZMM_Hi256/Hi16_ZMM
Date: Fri, 24 Oct 2025 14:56:18 +0800
Message-Id: <20251024065632.1448606-7-zhao1.liu@intel.com>
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

With feature array in ExtSaveArea, add avx10 as the second dependency
for Opmask/ZMM_Hi256/Hi16_ZMM xsave components, and drop the special
check in cpuid_has_xsave_feature().

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd269d15ce0b..236a2f3a9426 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2054,18 +2054,21 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
         .size = sizeof(XSaveOpmask),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_ZMM_Hi256_BIT] = {
         .size = sizeof(XSaveZMM_Hi256),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_Hi16_ZMM_BIT] = {
         .size = sizeof(XSaveHi16_ZMM),
         .features = {
             { FEAT_7_0_EBX,         CPUID_7_0_EBX_AVX512F },
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10   },
         },
     },
     [XSTATE_PKRU_BIT] = {
@@ -8643,12 +8646,6 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         }
     }
 
-    if (esa->features[0].index == FEAT_7_0_EBX &&
-        esa->features[0].mask == CPUID_7_0_EBX_AVX512F &&
-        (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
-        return true;
-    }
-
     return false;
 }
 
-- 
2.34.1


