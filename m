Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6897C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9c-0006FF-Qa; Sat, 03 Feb 2024 04:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9a-0006Ea-Rw
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:38 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9Z-0001VV-2p
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951857; x=1738487857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qw/YbJpx31Y4rkwPhKpfzP6ZtmWqCYJuII8bNQ2v5T0=;
 b=LWkqzO0xrA6ivYL/QuknokXIQo/NSwdVDKBdHlC+326QrvkI22MTx0rt
 wR/adBB9qsv45JpoaPn98nu0WD0zzsHclv4isSTj/KnQP80W/1Y5jyUng
 v+NRiRzKQ7Gqdzxrq/0M9tx7Ibz2zl6kIJyDFYZXo04frqDWq9XUwDIYU
 rE/180WzRCrlGSwdIr6wNES3gNN6XQmJPa9Mko3W9QEX/v22Hs8LsuPEc
 9hPzIYIDadc4SDqRRaLKezOUZftpGZvXoGkBxldHOhnx4BhL+1hU0LmbV
 MU+p66Y3wGbzXb/l3Z7eUdimJWiHVgVZRCPzcICQuUkWBWt+HPM2kt7ev w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216371"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216371"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31379008"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:34 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 4/6] target/i386: Add support for Intel Thread Director feature
Date: Sat,  3 Feb 2024 17:30:52 +0800
Message-Id: <20240203093054.412135-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
References: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Intel Thread Director (ITD) is the extension of HFI, and it extends
the HFI to provide performance and energy efficiency data for advanced
classes of instructions [1].

From Alder Lake, Intel's client products support ITD, and this feature
can be used in VM to optimize scheduling on hybrid architectures.

Like HFI, ITD virtualization also has the same topology limitations
(only 1 die and 1 socket) because ITD's virtualization support is based
on HFI.

In order to avoid potential contention problems caused by multiple
virtual-packages/dies, add the following restrictions to the ITD feature
bit:

1. Mark ITD as no_autoenable_flags and it won't be enabled by default.
2. ITD can't be enabled for the case with multiple packages/dies.

ITD feature depends on HFI, so also add its dependency.

[1]: SDM, vol. 3B, section 15.6 HARDWARE FEEDBACK INTERFACE AND INTEL
     THREAD DIRECTOR

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e3eb361436c9..55287d0a3e73 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1118,17 +1118,18 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, "hfi",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "itd",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
         /*
-         * PTS and HFI shouldn't be enabled by default since they have
+         * PTS, HFI and ITD shouldn't be enabled by default since they have
          * requirement for cpu topology.
          */
-        .no_autoenable_flags = CPUID_6_EAX_PTS | CPUID_6_EAX_HFI,
+        .no_autoenable_flags = CPUID_6_EAX_PTS | CPUID_6_EAX_HFI |
+                               CPUID_6_EAX_ITD,
     },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
@@ -1569,6 +1570,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_6_EAX,               CPUID_6_EAX_PTS },
         .to = { FEAT_6_EAX,                 CPUID_6_EAX_HFI },
     },
+    {
+        .from = { FEAT_6_EAX,               CPUID_6_EAX_HFI },
+        .to = { FEAT_6_EAX,                 CPUID_6_EAX_ITD },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -7468,10 +7473,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (env->features[FEAT_6_EAX] & CPUID_6_EAX_HFI &&
+    if (env->features[FEAT_6_EAX] & (CPUID_6_EAX_HFI | CPUID_6_EAX_ITD) &&
         (ms->smp.dies > 1 || ms->smp.sockets > 1)) {
         error_setg(errp,
-                   "HFI currently only supports die/package, "
+                   "HFI/ITD currently only supports die/package, "
                    "please set by \"-smp ...,sockets=1,dies=1\"");
         return;
     }
-- 
2.34.1


