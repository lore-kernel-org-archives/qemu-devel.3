Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50701EFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqlA-0005XM-Q4; Wed, 04 Mar 2026 13:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxql6-0005T1-LP
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:45 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkw-0004QO-RC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648135; x=1804184135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QEP92vBSwHQx5y1RIYH9jHcfZSZY2SQok02SXDN/lGk=;
 b=VUbUSQHZHOy+UVSs2gaJNrPee0o4yPIMkfmuyyPstWQFCOU7a9tlN7Ie
 3E0U1/djjwn2O/93IfgLtuTEz184ZJW/okON+uV15HXDISXyqVg7yRXMl
 G4cFlb5UGt2qFdnYbP+WrAy4zl40XymS0orafvo7pLnG3WJihoDfjWBWE
 YeJ0kLlQxpcXmgkCGsCP0VBwHwh3+93AAWQXULX7UAyANV5szv4qIrpvv
 IOCnOIxZIMB6aK3+aqPuuQFv8dtraG6h2H6L0eeTne37Fgl93n0R/0h09
 wbYapzdb1Si/P+1uLBxxCY+bP9urROC2b1CtcA1TsNDdYWxI2vok3zOoQ w==;
X-CSE-ConnectionGUID: QNEFT5C1TFmX6aswH/Zagw==
X-CSE-MsgGUID: QfutLJYyQkm+RdkLMom0aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909400"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:25 -0800
X-CSE-ConnectionGUID: QOqgkkB0QIqoSq/qQOtWlQ==
X-CSE-MsgGUID: TfQNgZRaRgydxgPG46P9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542857"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:24 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature
 dependencies
Date: Wed,  4 Mar 2026 10:07:11 -0800
Message-ID: <20260304180713.360471-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
- When PMU is disabled, Debug Store must not be exposed to the guest,
  which implicitly disables legacy DS-based PEBS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Update title to be more accurate.
- Make DTES64 depend on DS.
- Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
- Clean up the commit message.

V2: New patch.
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2e1dea65d708..3ff9f76cf7da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
         .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
     },
+    {
+        .from = { FEAT_1_EDX,               CPUID_DTS},
+        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
+    },
     {
         .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
         .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
@@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }
 
+        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
         env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
     }
 
-- 
2.53.0


