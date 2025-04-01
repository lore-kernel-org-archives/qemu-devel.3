Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFCDC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbyu-0005e9-19; Tue, 01 Apr 2025 09:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvJ-0001tV-GC
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:45:02 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvH-0006Zf-NH
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515099; x=1775051099;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kqJ6YMAigc2oOLvepy0MLHccWgmrlM/N47RQdC2WKiw=;
 b=jUCUTISMJPKLguTE7TF+dgwOmT0NhWq8Cx+XJ7mWq1DFCvWFrNIBaNJ/
 FGG68SQnRUtVL3+jhPUUO7n3aY2cdpPeo4/vl0pk2a0t8UE4wvdZu/KcA
 d9kNZrNz0OjzCP37gPTPlLVjROdVcIugsTSpJSn+hBZ2vbG1DlM81wcZ2
 3ytB3ccx71+tKLcLUCHzjXKXi60d2rANRToFOuTSePxt+AfPfKUPaWPcX
 TgRlJjzGZeFwSJbf4M75hs1NNpFEBxbq6xwJPOsewO0d+mv43+1nQUW9F
 Afy7yIGZ9WI/fQNRUR+2m1Wv4NgWGzFGWAm3XoSZvrK9tpXet8Jg9AlnU g==;
X-CSE-ConnectionGUID: pAHsWdNWT66aU20wMLZM6w==
X-CSE-MsgGUID: YaJW5ygnRGKNTIzpQqfp7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433592"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433592"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:22 -0700
X-CSE-ConnectionGUID: ZV68wfqgR3C5EqD6bIsn1A==
X-CSE-MsgGUID: b3rLLittR9W9jxJV7yZXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640286"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:20 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 52/55] i386/tdx: Don't treat SYSCALL as unavailable
Date: Tue,  1 Apr 2025 09:02:02 -0400
Message-Id: <20250401130205.2198253-53-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v7:
 - fix CPUID_EXT2_SYSCALL by adding it to actual;
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 58797470ba7e..cd8e96d476b8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -841,6 +841,19 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
             continue;
         }
 
+        /* Fixup for special cases */
+        switch (w) {
+        case FEAT_8000_0001_EDX:
+            /*
+             * Intel enumerates SYSCALL bit as 1 only when processor in 64-bit
+             * mode and before vcpu running it's not in 64-bit mode.
+             */
+            actual |= CPUID_EXT2_SYSCALL;
+            break;
+        default:
+            break;
+        }
+
         requested = env->features[w];
         unavailable = requested & ~actual;
         mark_unavailable_features(cpu, w, unavailable, unav_prefix);
-- 
2.34.1


