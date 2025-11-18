Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E85CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 06:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFKB-0005mG-VB; Tue, 18 Nov 2025 01:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFK2-0005jc-Ct
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:15 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLFK0-0007C8-RK
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 01:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763447773; x=1794983773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1XhH2LXoPRYyYcYy5qWLa8QGY0M70kIQwv5hJ1y6GGo=;
 b=R3ITuPASXLWTdA6m4pBPzqfOYBO8H62UIphOJjn7oa3V0aPkaH/+0XqA
 DVOG1ga3cEcsnWks5mqBKGzom35VNwmySjfMrPxHTDTM8/rScuHGHJoOs
 jHc/Zt2Pw0taCgC/eRDv1sfSSJqQWdIga2vPA8DaQPgYLADVnwytTdZWM
 3JJqecj2QDZI5bzGtG4nZ8K4jM9kF5gwdORWo2bHJlREaQhpWUo3Nb/9S
 k87V+dUlyDDhjhtiIIuw1i88/A1TdX+pU4Xxu0LaDVPBFYAc3ZV4zQ7RV
 G/pP7tjAXGapHMlJOplwEx7X2lDrkAiTNJqThN9DQLtobEvs8pW7dbrzz Q==;
X-CSE-ConnectionGUID: SOlYezRiTGWCoyNFRWpw3g==
X-CSE-MsgGUID: Jyl6brYjRI2LpxrUzpWv7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82850982"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="82850982"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 22:36:12 -0800
X-CSE-ConnectionGUID: zlKmW00rTzO4QaXpCn7qfg==
X-CSE-MsgGUID: vMYZRm97RHeO1BIHzRv60Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="189962704"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Nov 2025 22:36:10 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/5] i386/cpu: Mark apx xstate as migratable
Date: Tue, 18 Nov 2025 14:58:17 +0800
Message-Id: <20251118065817.835017-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118065817.835017-1-zhao1.liu@intel.com>
References: <20251118065817.835017-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

Apx xstate is user xstate. The related registers are cached in
X86CPUState. And there's a vmsd "vmstate_apx" to migrate these
registers.

Thus, it's safe to mark it as migratable.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9cc553a86442..f703b1478d71 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1544,7 +1544,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
-            XSTATE_PKRU_MASK | XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK,
+            XSTATE_PKRU_MASK | XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK |
+            XSTATE_APX_MASK,
     },
     [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
-- 
2.34.1


