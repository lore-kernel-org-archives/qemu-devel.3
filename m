Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4E8C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8yt-00044v-1d; Wed, 14 Aug 2024 04:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yT-0002tI-0z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:24 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8yL-0007sl-4D
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622589; x=1755158589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YQXU1V8cjOIRfFnAkE3ZUsJxcIpDFj6x85Y7iJEOblI=;
 b=TYzM23AsAf9p6dfW+88Q1nlM0rzvVhU0YDmNH1Hne1q4QMzEl9q8xkSW
 EP0sZBvx8fzYSS+fNcWcSglxvhrYHeD7yS74zZo8sWNDLAZJN2CJsGJW5
 6BjiWKGqSFmckC/DpGmIl48ObTJ0uST0npySw9K0BDL5QjolgpJA0dMVX
 P/m9xU0EZOhu6fvCROJjZSZtAFTiWQ6xmoKrZ5CoYTYLhBWR/Qy2U81k3
 OvmQo4WZsn4TlV761vrMDMKYB3NGIencFkj80DRLj4GtqFTH0o45UOGKU
 5wMhdZqScdy0q6Dz78MUunUvpLOtNunTExY5R7D7RoOK6NPUsXF5gDXJ0 w==;
X-CSE-ConnectionGUID: PFdy1yh/TbuBFS/wW4Py9w==
X-CSE-MsgGUID: 7Nar7dGnTsOZQAsaKeafYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584506"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584506"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:44 -0700
X-CSE-ConnectionGUID: aHkv1BIkToCVIdaFFa7Yyg==
X-CSE-MsgGUID: t1AZl/TdSAq9Ftp1CBFuKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048966"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:43 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 8/9] i386/cpu: Drop AMD alias bits in FEAT_8000_0001_EDX for
 non-AMD guests
Date: Wed, 14 Aug 2024 03:54:30 -0400
Message-Id: <20240814075431.339209-9-xiaoyao.li@intel.com>
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

The AMD alias bits are reserved for Intel.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fed805e04aeb..85ce405ece80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6118,6 +6118,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 #endif
         break;
 
+    case FEAT_8000_0001_EDX:
+        if (cpu && !IS_AMD_CPU(&cpu->env)) {
+            unavail = CPUID_EXT2_AMD_ALIASES;
+        }
+        break;
     default:
         break;
     }
-- 
2.34.1


