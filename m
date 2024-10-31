Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA7E68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R1D-0000pH-Q0; Thu, 31 Oct 2024 04:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R16-0000lk-8q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:57 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R13-0003GX-TZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365134; x=1761901134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BjgUHeb+QxtWbqmhNFPKp+hAK9Yqmy9MNVj33Q2H5jo=;
 b=Ev7Mry7A9r6RxsIR0tIcWSJ/eIACTrI9eo22FralJUKEAluj0exsx5Pa
 7DgLgbbbfgQxhYDHdWUFWmA8kOp27S3vLQ0pDEriYMGzti9j09kurnf95
 P3w8eadwrKGgOr4/zuO17eH25hmWv68BNqwULKomJD4pqC5MO+BFlcZLS
 QeGf9PUiSorjgCpdbk9Ni1vl7Lbxs20uUEZdzYqxAQeipf+hdGMBhfqsF
 V5hLQBspLO+SALRHL1LY6ykeat2+dgSlu3E1puE7boVXmHg/+sv+K7LZt
 9plvSFN0POY0SsOolngXmSUT+EmI7kSh54Sc3LtJ9LIUCH0U0/pTgfeQw A==;
X-CSE-ConnectionGUID: ZSXGVEXiTmS/Mfcl4zizIA==
X-CSE-MsgGUID: j8OUy4g8RqOWzKZoFodrzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492718"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:34 -0700
X-CSE-ConnectionGUID: kmin5mpBRca/vH3+wU8iMQ==
X-CSE-MsgGUID: nOUsool0RvKeSU1VKzDMaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489542"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:32 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 6/8] target/i386: Add feature dependencies for AVX10
Date: Thu, 31 Oct 2024 16:52:31 +0800
Message-Id: <20241031085233.425388-7-tao1.su@linux.intel.com>
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

Since the highest supported vector length for a processor implies that
all lesser vector lengths are also supported, add the dependencies of
the supported vector lengths. If all vector lengths aren't supported,
clear AVX10 enable bit as well.

Note that the order of AVX10 related dependencies should be kept as:
        CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
        CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
        CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,
        CPUID_7_1_EDX_AVX10          -> CPUID_24_0_EBX,
so that prevent user from setting weird CPUID combinations, e.g. 256-bits
and 512-bits are supported but 128-bits is not, no vector lengths are
supported but AVX10 enable bit is still set.

Since AVX10_128 will be reserved as 1, adding these dependencies has the
bonus that when user sets -cpu host,-avx10-128, CPUID_7_1_EDX_AVX10 and
CPUID_24_0_EBX will be disabled automatically.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-5-tao1.su@linux.intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 16 ++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 762c69d0b9..d8d86edd67 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1765,6 +1765,22 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_SGX_12_1_EAX,          ~0ull },
     },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
+        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
+    },
+    {
+        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
+        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
+    },
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
+        .to = { FEAT_24_0_EBX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5566a13f4f..e4c947b478 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -997,6 +997,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_24_0_EBX_AVX10_256        (1U << 17)
 /* AVX10 512-bit vector support is present */
 #define CPUID_24_0_EBX_AVX10_512        (1U << 18)
+/* AVX10 vector length support mask */
+#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
+                                         CPUID_24_0_EBX_AVX10_256 | \
+                                         CPUID_24_0_EBX_AVX10_512)
 
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
-- 
2.34.1


