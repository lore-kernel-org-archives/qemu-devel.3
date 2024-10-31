Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34300E68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 09:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R1G-0000sw-H4; Thu, 31 Oct 2024 04:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R18-0000m7-M4
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R16-0003GX-Rp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365137; x=1761901137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+ps4gCQE+MIUJn7vxlxvfPld8Y2qokFJ/P0+6xKo2k=;
 b=WLGxoXFienHry37dADWmZA0tz86+QibccR87D3R2qeuA/lmBqm8yWH3e
 U6bseQrRGn9HeKNYUdqeBtW+SFIAbFaF9if6FM4ZoCb/+KL8o1yI8SRpJ
 0xFcA7CS1HXDmHHzYdyWQtXCSdc99ueo3pkhRr0/P6ndTtBu6m8XP+2bN
 5I5sG8PGQ/8LSWZryzGH/U4csYO3fb5rykcN/+8+Ps1L1Hu+rkTtpbGXm
 CF3V+UMR0SOkzhPJ6ZsOJ7HRj8Zl3iIVeHleBPKyPSMuVAeH/mLaJXuBa
 +esjjUGwo5DROLzXcvO71BkDABlQacCh47F93sxIaiwU8eNWl1CR87JTj Q==;
X-CSE-ConnectionGUID: HM//nMkZQ/KZlVcbZ4YcVQ==
X-CSE-MsgGUID: 5ec3n6D0SSy+A1nU0I3mBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492759"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492759"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:36 -0700
X-CSE-ConnectionGUID: rcJGz0P2RVyuMBIxEhv2fw==
X-CSE-MsgGUID: 9MkbZiopTOC8FY7CLgf8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489564"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:34 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 7/8] target/i386: Add AVX512 state when AVX10 is supported
Date: Thu, 31 Oct 2024 16:52:32 +0800
Message-Id: <20241031085233.425388-8-tao1.su@linux.intel.com>
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

AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
are identical to AVX512 state regardless of the supported vector lengths.

Given that some E-cores will support AVX10 but not support AVX512, add
AVX512 state components to guest when AVX10 is enabled.

Based on a patch by Tao Su <tao1.su@linux.intel.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d8d86edd67..cc7e4ce665 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7123,7 +7123,15 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
         return false;
     }
 
-    return (env->features[esa->feature] & esa->bits);
+    if (env->features[esa->feature] & esa->bits) {
+        return true;
+    }
+    if (esa->feature == FEAT_7_0_EBX && esa->bits == CPUID_7_0_EBX_AVX512F
+        && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+        return true;
+    }
+
+    return false;
 }
 
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
-- 
2.34.1


