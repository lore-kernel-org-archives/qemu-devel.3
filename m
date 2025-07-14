Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFC9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEF4-0007wL-Ma; Mon, 14 Jul 2025 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuj-0004gQ-Tt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:54 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDue-0007P2-B7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479268; x=1784015268;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=46Zv6ouztE1Lvhxo7s0FPuq1ew+8otHrJ05oqC+ySy8=;
 b=fAGVCLVj3DN47MHnHw2m0WauYS2z+Gq38UMzNC9Qi9okuf1S1InVr/BZ
 GSKa3040djYpq63NV/vnyId90wklkkI0s8jyU5xIRf0YLQt/EwdF7T90U
 P/5PTXch8iEdMRjuTXt2KPQQQ39hbyjNM7EX55Wn1fq9htobrChcDDIOD
 zl3/Banw2hYRzNRQUJXfOOBDJWSIGZYKbA8fy9k0qTcQupIiR1kWhw14F
 BWvHTlOdfafpvQMjzMuWPlpT1CITfxs+2OP0WA0xNL1RuUSl7FMtv0dRP
 EIhaSrNz4RyW0VgDhZZBiosK4gfXTV9v6agQwTCAMPcxAO/XpSMCbefCV A==;
X-CSE-ConnectionGUID: 8cy2KsvVTWiLXcI4Law19A==
X-CSE-MsgGUID: 1nsimMk0SuqNOL35fzjSGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324672"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324672"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:46 -0700
X-CSE-ConnectionGUID: yvuy8wuYSgWQ6CpMM8BvPg==
X-CSE-MsgGUID: n1oU+dSgSNqq5Rxgi0GvtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952213"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:42 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v2 4/7] i386/cpu: Fix number of addressable IDs field for
 CPUID.01H.EBX[23:16]
Date: Mon, 14 Jul 2025 16:08:56 +0800
Message-Id: <20250714080859.1960104-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

Use the "x-vendor-cpuid-only-v2" compat option to fix this issue.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since New v1 [**]:
 * Drop Igor's Acked-by since this version uses the newly added
   x-vendor-cpuid-only-v2.
 * Add Zhaoxin since this is the behavior defined in SDM.

Changes Since original v6 [*] :
 * Rebase on the b69801dd6b1e ("Merge tag 'for_upstream' of
   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging").
 * Polish the comment in code.
 * Explain the change doesn't need extra compat property.

[*] original v6: https://lore.kernel.org/qemu-devel/20241009035638.59330-1-xuchuangxclwt@bytedance.com/
[**] new v1: https://lore.kernel.org/qemu-devel/20250227062523.124601-2-zhao1.liu@intel.com/
---
 target/i386/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e110e49ab8a..7fcb6c144d94 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7869,7 +7869,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
+             * count, but Intel needs maximum number of addressable IDs for
+             * logical processors per package.
+             */
+            if (cpu->vendor_cpuid_only_v2 &&
+                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+            } else {
+                *ebx |= threads_per_pkg << 16;
+            }
         }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
-- 
2.34.1


