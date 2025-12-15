Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8CD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2lb-00034M-VZ; Mon, 15 Dec 2025 02:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lY-00031W-V2
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:09 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lW-0008DF-Dt
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782787; x=1797318787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B5KsWLdeYBGnKB0r8a9UJrHbD4BabWmPHKGbGEUZ0Go=;
 b=KmSF4lpUGvBs+DV6iDQLcQaGp9hRV8TgGRvzbrghs+zPj4mdihZT3P6T
 8HB1NJs7YJszyktfUm5Sbz/0fp+8hIr/jsDdlJ4Rco8i2jiCGNDjPh74H
 4t0w7xj1pNHZkgMCDlyL8Ckmbzrf4dGxUnRIQJE4fxQpPVGWHYGutWenl
 T2dP2wOFWi2qh/kzSfCv7BxeiZwdOoR58bmuUzQGHJU1Y1oRtk4Sgcuuv
 CvMBVp5OQuEdE6U/L133NQL9yXEN3YpomGo/1bkK8oo45SWgQAG/V9Wyh
 UiU3tDmbMU3MjFrKXIPNHSawvVCCkC28yYwuHb5RjzEFvc+lv6fYFfslu g==;
X-CSE-ConnectionGUID: 9IOrUwxsQpq/51gzCOSHJw==
X-CSE-MsgGUID: ac2YUdeBQ7evqiTGxcELDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332235"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:04 -0800
X-CSE-ConnectionGUID: SDz5MvHGTQyUzZBI1pDnFw==
X-CSE-MsgGUID: tgJoFCkPTFSzBWpmIwqtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265927"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:02 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/11] i386/cpu: Add support for MOVRS in CPUID enumeration
Date: Mon, 15 Dec 2025 15:37:33 +0800
Message-Id: <20251215073743.4055227-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215073743.4055227-1-zhao1.liu@intel.com>
References: <20251215073743.4055227-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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
index 64dbef0ee154..7efb628e17a7 100644
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
index e405ec1dbc7e..0edba739c4e2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1045,6 +1045,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
 /* Linear Address Masking */
 #define CPUID_7_1_EAX_LAM               (1U << 26)
+/* MOVRS Instructions */
+#define CPUID_7_1_EAX_MOVRS             (1U << 31)
 
 /* The immediate form of MSR access instructions */
 #define CPUID_7_1_ECX_MSR_IMM           (1U << 5)
-- 
2.34.1


