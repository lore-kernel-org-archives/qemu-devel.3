Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D942E6895E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0l-0000js-GM; Thu, 31 Oct 2024 04:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0k-0000jZ-7F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:34 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0i-0003Df-I7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365112; x=1761901112;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2I6/6P79f4JXvf6/DXeQbTo6OJI0mWYZ67sPRPD1190=;
 b=ffpR9SzFjxfjEKdwElRzwZRNHcjDktKu1xQCUlPZqPFN+82X0EJ0Jn0Q
 jDcMOh4gywE4svJMZgiARVkvrxeiDR3mtWq/T0VzRmirOePyI386Ot/rN
 ZbQgWirPfbkQH6ikhpd5Sy8fv48pXtZ2lcD0+BZDU8623O9eJrtIrvBCd
 kQKR87kKhl3eoIya9jq26+ybnsPpDCPTE9jP37FmIb+5lo57+YawuXdeN
 MBgkjgDry1Md+ORm22mQpTJSRkYThB719PaEsL4aISVlBTxi4VF5XeFb5
 vRZ1gCaV0SapSnqkkdNxEYeuk5TRLDhTJIrja/qmHi+GtBJlQDA3vv0af A==;
X-CSE-ConnectionGUID: Mr74xCzRQ3KzQls4NKM/KA==
X-CSE-MsgGUID: IEFi/yMXRDGbxAg+N4F48A==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492690"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492690"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:32 -0700
X-CSE-ConnectionGUID: jKS2wT4RSF6CcFtUll5oDQ==
X-CSE-MsgGUID: JnXFS98bSpegqxc+I5avAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489528"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:29 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 5/8] target/i386: add CPUID.24 features for AVX10
Date: Thu, 31 Oct 2024 16:52:30 +0800
Message-Id: <20241031085233.425388-6-tao1.su@linux.intel.com>
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

Introduce features for the supported vector bit lengths.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
---
 target/i386/cpu.c | 15 +++++++++++++++
 target/i386/cpu.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 284ff062df..762c69d0b9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -901,6 +901,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EAX_FEATURES 0
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
+#define TCG_24_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1166,6 +1167,20 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
+    [FEAT_24_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [16] = "avx10-128",
+            [17] = "avx10-256",
+            [18] = "avx10-512",
+        },
+        .cpuid = {
+            .eax = 0x24,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_24_0_EBX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d845384dcd..5566a13f4f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -662,6 +662,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
+    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -990,6 +991,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* AVX10 128-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
+/* AVX10 256-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
+/* AVX10 512-bit vector support is present */
+#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
+
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
-- 
2.34.1


