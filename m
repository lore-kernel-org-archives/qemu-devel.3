Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD443C19F38
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnX1n-00036Q-VO; Thu, 27 Feb 2025 01:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1l-00035Z-KP; Thu, 27 Feb 2025 01:05:45 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1j-0001sC-7R; Thu, 27 Feb 2025 01:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740636343; x=1772172343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ow8EniQ5IIOCH+GchW7ZYFO2keelHhkAHFkJBcnFMZA=;
 b=dZtyWpvPQzu39NJVaT6XJET8s8r2MGif0XbUp5ofiLBaGVTm8ZXLJJ8V
 bG1gckFg33VbqyzxObUontpfSFD8UmmGq9S0iud+7F+O+NRG0gvTEh0v8
 Z2tiSHNCNLMk7CpW01ZUBvZI1rhzLr/rqVxx69lBb9uWM2Jxr/nRsatej
 pnrNFIzyGcsHbkChFNc2oEOTUKroQ8FgawsYSeAy3u6kDhTxeBjgysaPS
 choyJc/8AUSKlxh1QLd38QBacB0FrcVNpZmrAd9A71HDkjQHAwizAlvB3
 diNh/8GzZDwDqJmI5iq+juGtJF1skcLB/rX0dON7+9tJx6xVAeo0kWoBe g==;
X-CSE-ConnectionGUID: rDmIKoRJQbmwc0YCrr7rUQ==
X-CSE-MsgGUID: MRMtqtBMSRuQKmd3Xi14xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52148172"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52148172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:05:38 -0800
X-CSE-ConnectionGUID: gsYuQWBzS5+kW6FBSSCQfA==
X-CSE-MsgGUID: 4pbF97+tTRWTZwbCUXeKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="121938256"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 22:05:35 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH 1/4] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Date: Thu, 27 Feb 2025 14:25:20 +0800
Message-Id: <20250227062523.124601-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227062523.124601-1-zhao1.liu@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Chuang Xu <xuchuangxclwt@bytedance.com>

When QEMU is started with:
-cpu host,migratable=on,host-cache-info=on,l3-cache=off
-smp 180,sockets=2,dies=1,cores=45,threads=2

On Intel platform:
CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
logical processors in the physical package".

When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
CPUID.04H.EAX[31:26], which matches the expected result.

As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
it's necessary to round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise there would be unexpected results in guest with
older kernel.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though threads-per-core should actually be 2.

And on AMD platform:
CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
result meets our expectation.

So round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer only
for Intel platform to solve the unexpected result.

This change doesn't need to add compat property since it does not affect
live migration between different versions of pc machines.

Cc: qemu-stable@nongnu.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since original v6 [*] :
 * Rebase on the b69801dd6b1e ("Merge tag 'for_upstream' of
   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging").
 * Polish the comment in code.
 * Explain the change doesn't need extra compat property.

[*] original v6: https://lore.kernel.org/qemu-devel/20241009035638.59330-1-xuchuangxclwt@bytedance.com/
---
 target/i386/cpu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 72ab147e851a..b8a78276cd50 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6691,7 +6691,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
+             * count, but Intel needs maximum number of addressable IDs for
+             * logical processors per package.
+             */
+            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+                *ebx |= threads_per_pkg << 16;
+            } else {
+                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+            }
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
-- 
2.34.1


