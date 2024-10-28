Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7504BD13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5FqR-0006CE-P3; Sun, 27 Oct 2024 22:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqQ-0006C5-V1
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:02 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqP-0003WL-D3
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083862; x=1761619862;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pj2U9uplUz8z6bqWi1sM4VvoRJ/ZcUej6DcjHWlpReE=;
 b=M7erfta/q73WibkM1Izhvoeze31smGZyAA5fiPBQBbG7aGPeFjehIeeI
 1XlYaamFpL1Y4NgBi+hp4Oc0gzK6os05entEKFuR+UZ5+TtF00j+ntFrh
 5tlgf/Z4A1PREmnhehcBpZy0DxeoZ1TU6a2OQar/YlRJX3hmi9xM15B5t
 0dJiy2WVzKZuXdmrEV9m/goNDdz5Pb/TxoBdxxRx0KAREmUIdiJEli5eZ
 z+nefJQj8yrBwhRXmUK5wG6E72bZCOPCx562JXyTOndUNdsEIbZI8AAVj
 nhNkUeiuGHbvyz8Fel2v2E7adTG/np4MRwaTj/ewi6RngZx5tBStd2j57 w==;
X-CSE-ConnectionGUID: ZNaGuL88RD6+XA9N1zQkwA==
X-CSE-MsgGUID: jh3ZvO2MQ3qPgisbX2C8Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249471"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249471"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:51:01 -0700
X-CSE-ConnectionGUID: WJsDUTziQwmHwDycveLuPA==
X-CSE-MsgGUID: gczonL7ZSOWZhQZn9PyX9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420947"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:50:59 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
Date: Mon, 28 Oct 2024 10:45:10 +0800
Message-Id: <20241028024512.156724-5-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024512.156724-1-tao1.su@linux.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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
---
 target/i386/cpu.c | 16 ++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 91fae0dcb7..9666dbf29c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1760,6 +1760,22 @@ static FeatureDep feature_dependencies[] = {
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


