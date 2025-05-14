Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5BEC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 03:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF2hA-0005wV-QT; Tue, 13 May 2025 23:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h9-0005wK-Sh
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:11 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uF2h3-0004vx-Vq
 for qemu-devel@nongnu.org; Tue, 13 May 2025 23:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747192926; x=1778728926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ABbVyqWRkb8ZKcPKB8hAeYGZtAB5nyG/TIgyRAif9dE=;
 b=aaFe0W+IU0YfCQsvd5wY83yiJo+crtuLIj04rOVTTNRZ2U4g4QnxFB8t
 eNo8z3R8D16urgnhD3ImlRLwhIdudrfRmmKoOR6HUXR3gE9hX8C2e8Kxe
 FpH+V2iOyfg0Od+QFjD5Akwyo9AVl4e29HlZ5mVNs8MlNXCTUpLUJB/zf
 hV7M2+qX/CqWbumXUxc05O+y+z+jj+dL6MnRODjUUSM8il1OHtMIBfmyD
 9F9BTsJCTdmw4cWTx+CycX5SSZG2Ihi6oQbNHLiQDDN3u2oG2lxfMpRAH
 wBpO/s/yvncQlQkAMKaqQXk3+yxwg1STm0ejv5h1bKJawtQ25Qz5q+1MR w==;
X-CSE-ConnectionGUID: g86bazaXTvCOCU8fKV5jxg==
X-CSE-MsgGUID: f1fWH+TtSSytmvCs8OsIzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59296766"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="59296766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 20:22:02 -0700
X-CSE-ConnectionGUID: cRTGU93XTDO3SnXxCXYCMA==
X-CSE-MsgGUID: 1bKTDcrgTE20U1/lzd22rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="161203435"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 13 May 2025 20:21:59 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/2] i386/hvf: Make CPUID_HT supported
Date: Tue, 13 May 2025 23:16:52 -0400
Message-ID: <20250514031652.838763-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514031652.838763-1-xiaoyao.li@intel.com>
References: <20250514031652.838763-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since Commit c6bd2dd63420 ("i386/cpu: Set up CPUID_HT in
x86_cpu_expand_features() instead of cpu_x86_cpuid()"), CPUID_HT will be
set in env->features[] in x86_cpu_expand_features() when vcpus >= 2.

Later in x86_cpu_filter_features() it will check against the HVF
supported bits. It will trigger the warning like

    qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]

Add CPUID_HT to HVF supported CPUID bits to fix it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Note, the issue is totally by my analysis (which should be the same as
the TCG warnings) because I don't have HVF environment to verify it.

If would be helpful if anyone can help reproduce it and test the patch
in HVF environment.
---
 target/i386/hvf/x86_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index fa131b18c6d1..0798a0cbafb9 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -73,7 +73,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
              CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
              CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
              CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
-             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS;
+             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_HT;
         ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
              CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
              CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
-- 
2.43.0


