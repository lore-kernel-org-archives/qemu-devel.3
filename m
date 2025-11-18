Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FF5CEBF9A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCHD-0001Pn-6B; Mon, 17 Nov 2025 22:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCHA-0001PJ-F9
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:05 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCH8-0004Cz-MO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436063; x=1794972063;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FtN3GnlS9XpEdZZ5ADMYto6Z66Ic1LkzQp5aPpZOx4E=;
 b=TmDZ2ixuM3LcZh4GxrdKY8jpFz43vZoXJj69PbA5sLDYQbwb/ht/5Pza
 2DieS8i4fMfUQ3EXsr+x8jKTH3cMcoLpUyrr8AfIJUw3wga6YfYSs43Ls
 Ndx/xOsY2PR5cVwnRwDypQXyh9atiz2ayZmjNN4Qg2M1Feo/c5ObGqJIL
 oDta0gWa7DHNK7RW6QokCwucNqLkPz4nmrzTecVogH0zUd46dtAyZEG5W
 RRu80mP0lyTsgBfLsefiMGSHPuSChMvCdSRoBr4hWRSQPaejvojLiVCCz
 7XGzlyFpSkkqqLFA6727ew82cT/Ktm6fjYDIW9b/XPgjkZi3KJwxAbFIa w==;
X-CSE-ConnectionGUID: SBVBUFz6TS2RqKAcfaq4hg==
X-CSE-MsgGUID: WxjvInN8SRmuWyVgqsL/JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053859"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:21:02 -0800
X-CSE-ConnectionGUID: EsWihIMhRZG0T8NjBlfN/A==
X-CSE-MsgGUID: 9jIsDCHTR1CiHx3n6juJ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537237"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:58 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 13/23] i386/cpu: Add CET support in CR4
Date: Tue, 18 Nov 2025 11:42:21 +0800
Message-Id: <20251118034231.704240-14-zhao1.liu@intel.com>
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

CR4.CET bit (bit 23) is as master enable for CET.
Check and adjust CR4.CET bit based on CET CPUIDs.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v3:
 - Reorder CR4_RESERVED_MASK.
---
 target/i386/cpu.h    |  9 +++++++--
 target/i386/helper.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bfc38830e29e..f4cb1dc49b71 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -257,6 +257,7 @@ typedef enum X86Seg {
 #define CR4_SMEP_MASK   (1U << 20)
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
+#define CR4_CET_MASK   (1U << 23)
 #define CR4_PKS_MASK   (1U << 24)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
@@ -273,8 +274,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
-                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_CET_MASK \
+                | CR4_PKS_MASK | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -2951,6 +2952,10 @@ static inline uint64_t cr4_reserved_bits(CPUX86State *env)
     if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED)) {
         reserved_bits |= CR4_FRED_MASK;
     }
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) {
+        reserved_bits |= CR4_CET_MASK;
+    }
     return reserved_bits;
 }
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 72b2e195a31e..3f179c6c11f8 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -232,6 +232,18 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
         new_cr4 &= ~CR4_LAM_SUP_MASK;
     }
 
+    /*
+     * In fact, "CR4.CET can be set only if CR0.WP is set, and it must be
+     * clear before CR0.WP can be cleared". However, here we only check
+     * CR4.CET based on the supported CPUID CET bit, without checking the
+     * dependency on CR4.WP - the latter need to be determined by the
+     * underlying accelerators.
+     */
+    if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) {
+        new_cr4 &= ~CR4_CET_MASK;
+    }
+
     env->cr[4] = new_cr4;
     env->hflags = hflags;
 
-- 
2.34.1


