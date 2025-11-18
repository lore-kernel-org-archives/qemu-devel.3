Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DCFCEBF9A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCIB-0003Xc-A5; Mon, 17 Nov 2025 22:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHu-0002Zs-Ma
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHr-0004HZ-Ik
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436108; x=1794972108;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kMqBy7CxyEmFl74t7tv9rzwXuI+1Gc0Y9duW9Lw4FqE=;
 b=BQlUOqi1JZdRuog4W78vEAGO5svvQa5w6bl+jv4uAvAmyE/AgdlzGKAH
 HmFJ5PIhA2i10LimTzGpUQpgWjBi+ZRyCKPvuDhteAiWWoLTAvz7kkU/p
 8/M2BJxpofZV9UJbSVsYZAVqZFhiSP5kjE50bHV4FSpKiyTBKD9Q1FD02
 al2qesee1xJQCMoJLLIUoTiMxKFLHvDCuD58Yw2BUVE62I0Ef5YX/Di9D
 J6OyTiuRdLjcSJVzrE9BdEx77GBqGnKP0qBYuUkPBh6t+03jhoEN/GApr
 kvds6FB4guCnlpwmnATXdNPZzvsKqf8AEczXNklN1VlC7t/CV0MM+h+uC A==;
X-CSE-ConnectionGUID: XStaM3ruQYmnHfFF6SnVKw==
X-CSE-MsgGUID: 1lSe30PmQnmbN+peWpBhvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053924"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:24 -0800
X-CSE-ConnectionGUID: lvZ5Y8FHQ4O9xXAhUCWG6g==
X-CSE-MsgGUID: yMxHwHelT1Wult8IrPLcng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537366"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:21:20 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 19/23] i386/cpu: Mark cet-u & cet-s xstates as migratable
Date: Tue, 18 Nov 2025 11:42:27 +0800
Message-Id: <20251118034231.704240-20-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
saving/loading related CET MSRs. And there're the "vmstate_cet" and
"vmstate_pl0_ssp" to migrate these MSRs.

Thus, it's safe to mark them as migratable.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Add the flags in FEAT_XSAVE_XSS_LO.
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d29e784061c..848e3ccbb8e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1484,7 +1484,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .ecx = 1,
             .reg = R_ECX,
         },
-        .migratable_flags = XSTATE_ARCH_LBR_MASK,
+        .migratable_flags = XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |
+            XSTATE_ARCH_LBR_MASK,
     },
     [FEAT_XSAVE_XSS_HI] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.34.1


