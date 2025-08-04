Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DDC87FD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 05:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uinX9-0000xL-0P; Mon, 04 Aug 2025 01:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uinWt-0000rh-JG; Mon, 04 Aug 2025 01:14:37 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uinWq-0002jt-Nf; Mon, 04 Aug 2025 01:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754284473; x=1785820473;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eAash09ynJi/5Z1480JePS6uGwe/HI/5Jxdso0UCAuk=;
 b=R+Lu8wyi9+7B1jG/XVcH08u2prGESjgFSObIDKRcLiHN6Il3gMAbdWwh
 S6A8K3aDtR505djf/En3UnJTm/3D3jK2NVI79xzKKZ5EJgk+BPJjeYqOs
 JdIr5D7Rkg1mLLkeymYUUaqzIWEeCi8SXPuEMQ8UqyAE7OGuHU8KzXJLx
 MqwPH+kGI7VGxqkQV5tFAp1fIjQD9Hrk/zHs9vrFqFLHg4Q5QkmXjFFoO
 9bRGlRdQ2bmEiGzOI6c1/6huxt4+ydjLW0kSVtM+KenQd/YfwABew779S
 1rUh6oDEtBuHiPo5a4/sATmODqv0Ieujqn3cJNiH4dj34KQorJVPtRJEs w==;
X-CSE-ConnectionGUID: ybetperpRqa+vNIBTqlUzw==
X-CSE-MsgGUID: Q9oJtorcRaO0Tf3jjqJtTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67984539"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="67984539"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 22:14:28 -0700
X-CSE-ConnectionGUID: SE3GmI7+Q8mHr0BWKUob/Q==
X-CSE-MsgGUID: K9zzfTQ8Qpig6S62sFz/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="164515751"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 03 Aug 2025 22:14:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Chuang Xu <xuchuangxclwt@bytedance.com>
Subject: [PATCH for v10.1] i386/cpu: Move addressable ID encoding out of
 compat property in CPUID[0x1]
Date: Mon,  4 Aug 2025 13:35:48 +0800
Message-Id: <20250804053548.1808629-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

Currently, the addressable ID encoding for CPUID[0x1].EBX[bits 16-23]
(Maximum number of addressable IDs for logical processors in this
physical package) is covered by vendor_cpuid_only_v2 compat property.
The previous consideration was to avoid breaking migration and this
compat property makes it unfriendly to backport the commit f985a1195ba2
("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX
[23:16]").

However, NetBSD booting is broken since the commit 88dd4ca06c83
("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]"),
because NetBSD calculates smt information via `lp_max` / `core_max` for
legacy Intel CPUs which doesn't support 0xb leaf, where `lp_max` is from
CPUID[0x1].EBX.bits[16-23] and `core_max` is from CPUID[0x4].0x0.bits[26
-31].

The commit 88dd4ca0 changed the encoding rule of `core_max` but didn't
update `lp_max`, so that NetBSD would get the wrong smt information,
which leads to the module loading failure.

Luckily, the commit f985a1195ba2 ("i386/cpu: Fix number of addressable
IDs field for CPUID.01H.EBX[23:16]") updated the encoding rule for
`lp_max` and accidentally fixed the NetBSD issue too. This also shows
that using CPUID[0x1] and CPUID[0x4].0x0 to calculate HT/SMT information
is a common practice to detect CPU topology on legacy Intel CPUs.

Therefore, it's necessary to backport the commit f985a1195ba2 to
previous stable QEMU to help address the similar issues as well. Then
the compat property is not needed any more since all stable QEMUs will
follow the same encoding way.

So, in CPUID[0x1], move addressable ID encoding out of compat property.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Inspired-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Fixes: commit f985a1195ba2 ("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3061
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 251d5760a0bd..673f8583c809 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7885,8 +7885,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * count, but Intel needs maximum number of addressable IDs for
              * logical processors per package.
              */
-            if (cpu->vendor_cpuid_only_v2 &&
-                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
                 num = 1 << apicid_pkg_offset(topo_info);
             } else {
                 num = threads_per_pkg;
-- 
2.34.1


