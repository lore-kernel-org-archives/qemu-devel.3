Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F1DCED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCHB-0001P8-LC; Mon, 17 Nov 2025 22:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCH7-0001OM-5D
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:01 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCH5-0004Cz-9X
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436059; x=1794972059;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NHn+nG8NE3ybLMhwAmk/PNwzcXZNoyi5s9vO5Z2x3JQ=;
 b=JoUlpIcN5G/VwJsFQXBhlkrHca3ig7JL1Umb2s11ZJaMlMpt+OCCNPwA
 e+V8Fjdc/xNYn2CYDcH2wKflgN+DlobaTPnOogNpVQQR8B8SeA4Db6k9Q
 8S/zOKFF+yDbBK2sFl9S6662wl7ZD46QKaVFXEH6YyjNLYfrScFj+TSfb
 +akdz9s7s89pP0ZFKTsuOSBr74j/OQWh/VYWZ2gVJFRXphW51UQF9u20v
 i5e0guVKQ5kmPkxAWx8erkYR+LhdlflHzmCtlfRhTVux+3VQ6bXpXBWEU
 wWKOjaLKn+QPPZHW1LLUFU/Isha0EkthRmdS1NMDBSbuGV4dFk37pXMi2 g==;
X-CSE-ConnectionGUID: T8chlvusT+KYUOpbNjiE+w==
X-CSE-MsgGUID: PN2oaqnmSP6iB1zJK9JCEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053849"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053849"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:59 -0800
X-CSE-ConnectionGUID: h1k8TwFyQp6SD4kV0kCFIQ==
X-CSE-MsgGUID: hiQMhN89QNyYVm2dziwisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537215"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:55 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v4 12/23] i386/cpu: Enable xsave support for CET states
Date: Tue, 18 Nov 2025 11:42:20 +0800
Message-Id: <20251118034231.704240-13-zhao1.liu@intel.com>
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add CET_U/S bits in xstate area and report support in xstate
feature mask.
MSR_XSS[bit 11] corresponds to CET user mode states.
MSR_XSS[bit 12] corresponds to CET supervisor mode states.

CET Shadow Stack(SHSTK) and Indirect Branch Tracking(IBT) features
are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[7] and EDX[20]
respectively, two features share the same state bits in XSS, so
if either of the features is enabled, set CET_U and CET_S bits
together.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 - Rename XSavesCETU/XSavesCETS to XSaveCETU/XSaveCETS.
 - Refine the comments.
 - Drop ".offset = 0" and its comment.
 - Re-describe xstate dependencies via features array.
 - Drop "cet-u" & "cet-s" enumeration from FEAT_XSAVE_XSS_LO's
   feat_name array sicne currently xsave doesn't use named features.
---
 target/i386/cpu.c | 14 ++++++++++++++
 target/i386/cpu.h | 26 +++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d2a89c03caec..4d29e784061c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2078,6 +2078,20 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
             { FEAT_7_0_ECX,         CPUID_7_0_ECX_PKU },
         },
     },
+    [XSTATE_CET_U_BIT] = {
+        .size = sizeof(XSaveCETU),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_CET_SHSTK },
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_CET_IBT },
+        },
+    },
+    [XSTATE_CET_S_BIT] = {
+        .size = sizeof(XSaveCETS),
+        .features = {
+            { FEAT_7_0_ECX,         CPUID_7_0_ECX_CET_SHSTK },
+            { FEAT_7_0_EDX,         CPUID_7_0_EDX_CET_IBT },
+        },
+    },
     [XSTATE_ARCH_LBR_BIT] = {
         .size = sizeof(XSaveArchLBR),
         .features = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f065527757c4..bfc38830e29e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -589,6 +589,8 @@ typedef enum X86Seg {
 #define XSTATE_Hi16_ZMM_BIT             7
 #define XSTATE_PT_BIT                   8
 #define XSTATE_PKRU_BIT                 9
+#define XSTATE_CET_U_BIT                11
+#define XSTATE_CET_S_BIT                12
 #define XSTATE_ARCH_LBR_BIT             15
 #define XSTATE_XTILE_CFG_BIT            17
 #define XSTATE_XTILE_DATA_BIT           18
@@ -603,6 +605,8 @@ typedef enum X86Seg {
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PT_MASK                  (1ULL << XSTATE_PT_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
+#define XSTATE_CET_U_MASK               (1ULL << XSTATE_CET_U_BIT)
+#define XSTATE_CET_S_MASK               (1ULL << XSTATE_CET_S_BIT)
 #define XSTATE_ARCH_LBR_MASK            (1ULL << XSTATE_ARCH_LBR_BIT)
 #define XSTATE_XTILE_CFG_MASK           (1ULL << XSTATE_XTILE_CFG_BIT)
 #define XSTATE_XTILE_DATA_MASK          (1ULL << XSTATE_XTILE_DATA_BIT)
@@ -628,7 +632,8 @@ typedef enum X86Seg {
                                  XSTATE_XTILE_CFG_MASK | XSTATE_XTILE_DATA_MASK)
 
 /* CPUID feature bits available in XSS */
-#define CPUID_XSTATE_XSS_MASK    (XSTATE_ARCH_LBR_MASK)
+#define CPUID_XSTATE_XSS_MASK   (XSTATE_ARCH_LBR_MASK | XSTATE_CET_U_MASK | \
+                                 XSTATE_CET_S_MASK)
 
 #define CPUID_XSTATE_MASK       (CPUID_XSTATE_XCR0_MASK | CPUID_XSTATE_XSS_MASK)
 
@@ -907,6 +912,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_ECX_WAITPKG           (1U << 5)
 /* Additional AVX-512 Vector Byte Manipulation Instruction */
 #define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
+/* Control-flow enforcement technology: shadow stack */
+#define CPUID_7_0_ECX_CET_SHSTK         (1U << 7)
 /* Galois Field New Instructions */
 #define CPUID_7_0_ECX_GFNI              (1U << 8)
 /* Vector AES Instructions */
@@ -954,6 +961,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
 /* Architectural LBRs */
 #define CPUID_7_0_EDX_ARCH_LBR          (1U << 19)
+/* Control-flow enforcement technology: indirect branch tracking */
+#define CPUID_7_0_EDX_CET_IBT           (1U << 20)
 /* AMX_BF16 instruction */
 #define CPUID_7_0_EDX_AMX_BF16          (1U << 22)
 /* AVX512_FP16 instruction */
@@ -1740,6 +1749,19 @@ typedef struct XSavePKRU {
     uint32_t padding;
 } XSavePKRU;
 
+/* Ext. save area 11: CET_U state */
+typedef struct XSaveCETU {
+    uint64_t u_cet;
+    uint64_t pl3_ssp;
+} XSaveCETU;
+
+/* Ext. save area 12: CET_S state */
+typedef struct XSaveCETS {
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+} XSaveCETS;
+
 /* Ext. save area 15: Arch LBR state */
 typedef struct XSaveArchLBR {
     uint64_t lbr_ctl;
@@ -1767,6 +1789,8 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveOpmask) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveZMM_Hi256) != 0x200);
 QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
 QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
+QEMU_BUILD_BUG_ON(sizeof(XSaveCETU) != 0x10);
+QEMU_BUILD_BUG_ON(sizeof(XSaveCETS) != 0x18);
 QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
 QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
-- 
2.34.1


