Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DBFCF64BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTA-0005Cl-E3; Thu, 20 Nov 2025 01:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT0-00055I-5o
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:32 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLySu-0005r2-RU
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621305; x=1795157305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=487ITGVr9i8c/gw4YoNyHsP0ApJoxPWCX3AhdoyG/F8=;
 b=e7MvUt0xXTfVW7iIoYUVh4qLOq+cNOgcKJyuOIOcqQQIoHVn5pBXVx1D
 gd8C7qiKM0Z2BAKC2Tx/MnpC/s+wyMlAjv6UMjgdALC8gYkxnNlLjLhvY
 bGtTNXrRElOnT2FChGRyW20rxu10QnGQcUynQzefg75iO6dUvkjPXnbvY
 CQsefVp2p/H4cfv/Qpij6ue+fZXF1G1lApfRfLCOvOsSAwWk3X6cipLZg
 cIrccufYWuQgblfc1KBWPQ1tGnBxhQZNZzZh/5Hk0IHdhWeourFutMFi0
 DZbPBSbOJ25t/0j2ZcHDDPRRsn24CbzNUkswrnBi8GyqK7iZ7UkWCS8ks Q==;
X-CSE-ConnectionGUID: K2BcrqNXR/2NJfSS19ljHQ==
X-CSE-MsgGUID: pH1JjFnpR9OhxzhbISUqzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572528"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572528"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:19 -0800
X-CSE-ConnectionGUID: Q3YeRrSiSoiXgvEYsKThsg==
X-CSE-MsgGUID: ZxhSNNFES9iWYFmf+CplDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296105"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:18 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/10] i386/cpu: Add support for MOVRS in CPUID enumeration
Date: Thu, 20 Nov 2025 15:10:21 +0800
Message-Id: <20251120071030.961230-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

MOVRS is a new set of instructions introduced in the Intel platform
Diamond Rapids, to load instructions that carry a read-shared hint.

Functionally, MOVRS family is equivalent to existing load instructions,
but its read-shared hint indicates the source memory location is likely
to become read-shared by multiple processors, i.e., read in the future
by at least one other processor before it is written (assuming it is
ever written in the future). It could optimize the behavior of the
caches, especially shared caches, for this data for future reads by
multiple processors. Additionally, MOVRS family also includes a software
prefetch instruction, PREFETCHRST2, that carries the same read-shared
hint. [*]

MOVRS family is enumerated by CPUID single-bit (0x7.0x1.EAX[bit 31]).
Add its enumeration support.

[*]: Intel Architecture Instruction Set Extensions and Future Features
     (rev.059).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Reference link: https://cdrdv2.intel.com/v1/dl/getContent/865891
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0c954202cea8..1aae9cba13af 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1266,7 +1266,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "fred", "lkgs", "wrmsrns",
             NULL, "amx-fp16", NULL, "avx-ifma",
             NULL, NULL, "lam", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "movrs",
         },
         .cpuid = {
             .eax = 7,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d15a89f8c72e..7b50c0c04f6e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1030,6 +1030,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
 /* Linear Address Masking */
 #define CPUID_7_1_EAX_LAM               (1U << 26)
+/* MOVRS Instructions */
+#define CPUID_7_1_EAX_MOVRS             (1U << 31)
 
 /* The immediate form of MSR access instructions */
 #define CPUID_7_1_ECX_MSR_IMM           (1U << 5)
-- 
2.34.1


