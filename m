Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB1BE68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0h-0000iX-Hh; Thu, 31 Oct 2024 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0d-0000hU-U3
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:27 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0c-0003Ct-Cu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365106; x=1761901106;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cBVM67PjgPHVUfUCuivJND+qiKNLwjMKHkFx1MDlePg=;
 b=DgHO+12g4ljb5/8lzT9LJsJitPyNDwrmSEuvYYR2ICi5eShrBb/wlFTD
 G3aivr5dbMdvlHdWhUuRnTU8CvhzI3iFSxlMJPVxQbKNaxPq5GM2xLc/h
 LBz8MBopwnzfdejCsvo8TOicmXL5dJjVkZW284BNSTZKR/TERFYml+fCr
 Xixebkd2XPjyeZSqeTTpsU5rh5zbTgJ6Pa1YQN87Ns7JphTDMh+XMB3Xo
 93VOvwdrPb2egigaKY7celSxOx73H3aPo2yV4Ma3E1x7axLFfB4U1qxR8
 95OQKiK52P5GngnI7qQ04ZAsHbpDtEl4XcHJ1ga15t7o9C4SvqKtidwIu A==;
X-CSE-ConnectionGUID: H5OkrsbGRseHLB0I8AoyJg==
X-CSE-MsgGUID: KRfpvuNAR0OXBXIeUgHGjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492670"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:23 -0700
X-CSE-ConnectionGUID: qey9tPBBTgqKLHV5K6BFkA==
X-CSE-MsgGUID: sopHw02hRpmu+/KsG6i+sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489451"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:21 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 1/8] target/i386: cpu: set correct supported XCR0 features
 for TCG
Date: Thu, 31 Oct 2024 16:52:26 +0800
Message-Id: <20241031085233.425388-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031085233.425388-1-tao1.su@linux.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032e..b912dba2e5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1296,7 +1296,9 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EAX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
+            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
+            XSTATE_PKRU_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -1309,7 +1311,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .needs_ecx = true, .ecx = 0,
             .reg = R_EDX,
         },
-        .tcg_features = ~0U,
+        .tcg_features = 0U,
     },
     /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
-- 
2.34.1


