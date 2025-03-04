Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D4C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 06:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpLMt-00062w-Nv; Tue, 04 Mar 2025 01:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMd-00061F-0P
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:49 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpLMZ-0001Md-2V
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 01:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741068163; x=1772604163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fy0TkX2wQllTy9MHur8muKr6xSbxEwpFjemwmKsds1s=;
 b=Tx1lp51douQjuNKJU717DSPPKkN9vydvB2dRe2JghBH48yd/Q8z2qdzi
 dvdd9Md7mGN8aayl1GmSj/s9xy15x3kxJ++42x3ZRXR0m0hxJGxx13Sl0
 UBJgnrwlMdHafEn9e7FAkDamNY2qmBZRe5aiddm4HLjErwWwSMeaY2tTX
 QoJvcMSMvQBbVtIQn5sPP8x8p10uj8kX0rIUaGU1bALrkj3BxAWp9tfXn
 rUIi46omVzhuzIK+PjDVT89V0jAmXCWL0T+AcQFJnroNViuOOoLf5vHHO
 Z8h4yEfy+FRc3r8FOPq4k9iJKm0K8IKjKm4+zQqY3hoW9v2zRTR4dZrUU Q==;
X-CSE-ConnectionGUID: sYIXZGDcR3SNM8M0hhrwYA==
X-CSE-MsgGUID: sHSn6XnMQaukL9hkLvJoSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59519166"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="59519166"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 22:02:31 -0800
X-CSE-ConnectionGUID: wVV0h19QQsSOUs9DRZiFEA==
X-CSE-MsgGUID: NN6ESXhtTI6p4T1Oz5/TAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118132367"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 22:02:29 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH 1/2] i386/cpu: Move adjustment of CPUID_EXT_PDCM before
 feature_dependencies[] check
Date: Tue,  4 Mar 2025 00:24:49 -0500
Message-Id: <20250304052450.465445-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304052450.465445-1-xiaoyao.li@intel.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

There is one entry relates to CPUID_EXT_PDCM in feature_dependencies[].
So it needs to get correct value of CPUID_EXT_PDCM before using
feature_dependencies[] to apply dependencies.

Besides, it also ensures CPUID_EXT_PDCM value is tracked in
env->features[FEAT_1_ECX].

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e851a..2bf6495140a0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6693,9 +6693,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
         }
-        if (!cpu->enable_pmu) {
-            *ecx &= ~CPUID_EXT_PDCM;
-        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
@@ -7684,6 +7681,10 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    if (!cpu->enable_pmu) {
+        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    }
+
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.34.1


