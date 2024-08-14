Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8C0C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yh-0003IY-Bj; Wed, 14 Aug 2024 04:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yT-0002tJ-1N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:23 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yL-0007rt-9N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622589; x=1755158589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+1CShJKpDmVBjOQNUIrC3GWrHShE0+pF4rvqTJMJim8=;
 b=B1OVSrxgfqxn6/VYAbhQpQd/vRDDXI2iB5P+7PnDzydv/2RLfNkYJd7z
 WAgHVIIImGfg4c8UflJxf6wLO1Zw7udzh4ZRevg7NZQxBK+txyGQhC6dZ
 sIxxkTQJ8Tdm+WgfpNVKuyx8bP1TWsq1qQb8yMOj5DJuVXq2qmdTP+nMg
 0qt515Sy6mwADjF/9gOx2F21rbd02BpS5JrRHA/guwN509a22wLyL0h3O
 xWStRds2h7U1PvC5n4FOxpSU5XS2DYB2RQMGS79+4Be5cbwwc2hs8RJck
 wlRClMxcvuePTsyWUva82qZ+DaaA43N/ZBu7bBtTIkpyrBLaCfBbvl/8h w==;
X-CSE-ConnectionGUID: ph3zYcS0RiymqV8OAZl5Lw==
X-CSE-MsgGUID: tQJf5YMTSUmHh1LLbBTr8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584500"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:43 -0700
X-CSE-ConnectionGUID: KEfZ5W48QYaoJauvCfm6gQ==
X-CSE-MsgGUID: 0Haszx6eSjqibH/f847CBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048963"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 7/9] i386/cpu: Suppress CPUID values not defined by Intel
Date: Wed, 14 Aug 2024 03:54:29 -0400
Message-Id: <20240814075431.339209-8-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some CPUID leaves are defined by AMD while it also gets exposed to Intel
VMs by QEMU. It causes no issue with current VMs however it will not work
with Intel TDX because these CPUID leaves are enforced by TDX module as
reserved.

Stop to advertise them to Intel VMs when vendor_cpuid_only is true.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4835289760..fed805e04aeb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6863,12 +6863,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
-        *ebx = env->cpuid_vendor1;
-        *edx = env->cpuid_vendor2;
-        *ecx = env->cpuid_vendor3;
+        if (cpu->vendor_cpuid_only && IS_INTEL_CPU(env)) {
+            *ebx = *ecx = *edx = 0;
+        } else {
+            *ebx = env->cpuid_vendor1;
+            *edx = env->cpuid_vendor2;
+            *ecx = env->cpuid_vendor3;
+        }
         break;
     case 0x80000001:
-        *eax = env->cpuid_version;
+        *eax = (cpu->vendor_cpuid_only && IS_INTEL_CPU(env)) ? 0 : env->cpuid_version;
         *ebx = 0;
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
-- 
2.34.1


