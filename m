Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F647C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2UI-0002Pt-Ai; Mon, 03 Jun 2024 03:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sE2UH-0002Pl-C5
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:52:13 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sE2UE-0001CG-64
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717401130; x=1748937130;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w9YIIUf/5C7FHss0rgAraaR4ET4kMcP20VUjyG9Z30U=;
 b=LZSB4armBPhcNxf5SdXvSfcv8m+vylkcm6e6EBBnGb5dGuSSRNPbMn+/
 HXdsfg04D40QJzc5wheVjnYOujwMk9KPry1P2/J2MJdUB/41GiHMs6HX0
 wf+AjwuIBqPy1GL/PaCwAZjutUwciaNx2Oniq5I6up0y5TeZWqjirhCb1
 AOoEjo6Bcl/Xlyuh2cofQrGMfIAsPcD04sBG0LGeFzsWsjIGDko+0y+c2
 2vqJIsWt1s6td4JVBDLiGAM14f+YmTjNe9cZhuBrZjXP8y6DIaR+IzDYU
 YXzkcHuLpusEtOtFk9G43WpOab88R7CvqRDGPxBP6/mtb0GR5u4SzZniv Q==;
X-CSE-ConnectionGUID: fytPHrPXRN2MK3Ec0VnTgg==
X-CSE-MsgGUID: 2kTn6NOJSWmnCCO2ku6Luw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17723555"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; d="scan'208";a="17723555"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 00:52:04 -0700
X-CSE-ConnectionGUID: u+r/XwjITzG0FwPIp5jYsA==
X-CSE-MsgGUID: BUb3ah6LTF6U3n1p1Og3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; d="scan'208";a="41724308"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 03 Jun 2024 00:52:03 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PATCH] target/i386/tcg: Fix RDPID feature check
Date: Mon,  3 Jun 2024 16:07:23 +0800
Message-Id: <20240603080723.1256662-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DisasContext.cpuid_ext_features indicates CPUID.01H.ECX.

Use DisasContext.cpuid_7_0_ecx_features field to check RDPID feature bit
(CPUID_7_0_ECX_RDPID).

Fixes: 6750485bf42a ("target/i386: implement RDPID in TCG")
Inspired-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6dedfe94c04c..0486ab691120 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3199,7 +3199,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
-                if (!(s->cpuid_ext_features & CPUID_7_0_ECX_RDPID)) {
+                if (!(s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_RDPID)) {
                     goto illegal_op;
                 }
                 gen_helper_rdpid(s->T0, tcg_env);
-- 
2.34.1


