Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F3DCED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGa-0001IB-Gh; Mon, 17 Nov 2025 22:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGY-0001Hy-Rm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:26 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGX-0004Cz-5k
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436025; x=1794972025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=enKcO38L6D4368mFk9WuGh+dSr2WFd6BUxl4+hq0Pz4=;
 b=HBYI7k617H5oqeSL+lNSk0IluxoOiDBM11bws3uZxZkzXCgZ2tdWyZE9
 RQok+joCbGAN9B8ixY0PPfe6YFpVE/ra8Qf2KZmkclnP5uG+0ROxq3bq9
 S6ftAuY/b7SmBR3+uWFbQGe6BPTYaOvzCim5TaZn5EZUHuKE9AlPNM1eB
 BmLKtwQg4AX80dQ68Qht+RIjk/miK0315m0/pFVGGogvxcV0LK5ul4wNr
 HwuIyqGVuyw+YkW0rpP8wcuchlD/8vp9foZKaP1r7hcwVfFU0yi/LUDlo
 2WjR/Vlrw+eQuPwaKCRUFAf7dCxEQ1nl7Yw/+8yl8zUwWD3mVZ1feblvr A==;
X-CSE-ConnectionGUID: Q+H5fnxbTAeqfgqICsKk2g==
X-CSE-MsgGUID: 08VedOSbTBGX86aKV1QSYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053738"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:24 -0800
X-CSE-ConnectionGUID: KloAmZodSrWOopC6xpWqrg==
X-CSE-MsgGUID: B3BIwUb5Rsuu6KBSN/t8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537139"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:20 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 02/23] i386/cpu: Clean up arch lbr xsave struct and comment
Date: Tue, 18 Nov 2025 11:42:10 +0800
Message-Id: <20251118034231.704240-3-zhao1.liu@intel.com>
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

Arch LBR state is area 15, not 19. Fix this comment. And considerring
other areas don't mention user or supervisor state, for consistent
style, remove "Supervisor mode" from its comment.

Moreover, rename XSavesArchLBR to XSaveArchLBR since there's no need to
emphasize XSAVES in naming; the XSAVE related structure is mainly
used to represent memory layout.

In addition, arch lbr specifies its offset of xsave component as 0. But
this cannot help on anything. The offset of ExtSaveArea is initialized
by accelerators (e.g., hvf_cpu_xsave_init(), kvm_cpu_xsave_init() and
x86_tcg_cpu_xsave_init()), so explicitly setting the offset doesn't
work and CPUID 0xD encoding has already ensure supervisor states won't
have non-zero offsets. Drop the offset initialization and its comment
from the xsave area of arch lbr.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 +--
 target/i386/cpu.h | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c598f09f3d50..34a4c2410d03 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2058,8 +2058,7 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
     },
     [XSTATE_ARCH_LBR_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
-        .offset = 0 /*supervisor mode component, offset = 0 */,
-        .size = sizeof(XSavesArchLBR),
+        .size = sizeof(XSaveArchLBR),
     },
     [XSTATE_XTILE_CFG_BIT] = {
         .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c3..c95b772719ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1747,15 +1747,15 @@ typedef struct {
 
 #define ARCH_LBR_NR_ENTRIES            32
 
-/* Ext. save area 19: Supervisor mode Arch LBR state */
-typedef struct XSavesArchLBR {
+/* Ext. save area 15: Arch LBR state */
+typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
     uint64_t lbr_depth;
     uint64_t ler_from;
     uint64_t ler_to;
     uint64_t ler_info;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
-} XSavesArchLBR;
+} XSaveArchLBR;
 
 QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
 QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
@@ -1766,7 +1766,7 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
-QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
+QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 
 typedef struct ExtSaveArea {
     uint32_t feature, bits;
-- 
2.34.1


