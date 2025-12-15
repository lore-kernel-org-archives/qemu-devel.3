Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5B7D5B16C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2lh-00038R-UT; Mon, 15 Dec 2025 02:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2le-00036r-9i
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lc-0008DF-Fh
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782793; x=1797318793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VcO5I41SMkUWDYwzgsYbLxVHGQ75PO+VCvmvvKQrwrc=;
 b=H+SHpTs6bTkKZL1qbO1zfqSgmLg+acIa7BMkpR5OHaFuleoT8AsUIZFh
 VK/9wRSqu96LHXQU+S1kDaO1Y1b6ncsyvgaGs++nYoxe+WIBPm2Ibn9fF
 JKDFZNno8B1B707B8FY7rtuxJLj7IoR3W8tF6RRjzY7wl3kupHgXUTTBM
 hKs2Dqbl7FOEfwEljKTzr4G4Gvv6NmLF+5Qg3m95KbYHl9b7kGGsV6oj9
 GDhwtQ1LydiTTpskq0iB3qJP2NoYzbfRBhdJTgO6NWRm2+HVdizqAqzc3
 aDWd2stefPz8d/tQUfHGUeF54BpQN35H0ktYrnJIEb7jbzKBssaTiHzQr g==;
X-CSE-ConnectionGUID: A1XBW9T1SoSqdIBYooKl3g==
X-CSE-MsgGUID: NYT072BPTSaw3kSYdKwztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332254"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332254"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:12 -0800
X-CSE-ConnectionGUID: WDYFwABUTvCTaKI9OHx0JQ==
X-CSE-MsgGUID: aTRJDeuxTv6HTqAAfZQGpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265952"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:10 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 06/11] i386/cpu: Allow unsupported avx10_version with
 x-force-features
Date: Mon, 15 Dec 2025 15:37:38 +0800
Message-Id: <20251215073743.4055227-7-zhao1.liu@intel.com>
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

The "force_features" ("x-force-features" property) forces setting
feature even if host doesn't support, but also reports the warning.

Given its function, it's useful for debug, so even if the AVX10
version is unsupported by host, force to set this AVX10 version if
x-force-features=on.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New patch.
---
 target/i386/cpu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c47e06cb79e7..41ff4058871a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9500,16 +9500,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         uint8_t version = x86_cpu_get_host_avx10_version();
 
         if (version < env->avx10_version) {
-            if (prefix) {
-                warn_report("%s: avx10.%d. Adjust to avx10.%d",
-                            prefix, env->avx10_version, version);
-            }
             /*
-             * Discrete feature bits have been checked and filtered based on
-             * host support. So it's safe to change version without reverting
-             * other feature bits.
+             * With x-force-features=on, CPUID_7_1_EDX_AVX10 will not be masked
+             * off, so there's no need to zero avx10 version.
              */
-            env->avx10_version = version;
+            if (!cpu->force_features) {
+                if (prefix) {
+                    warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                                prefix, env->avx10_version, version);
+                }
+                /*
+                 * Discrete feature bits have been checked and filtered based
+                 * on host support. So it's safe to change version without
+                 * reverting other feature bits.
+                 */
+                env->avx10_version = version;
+            } else {
+                if (prefix) {
+                    warn_report("%s: avx10.%d.",
+                                prefix, env->avx10_version);
+                }
+            }
             have_filtered_features = true;
         }
     } else if (env->avx10_version) {
-- 
2.34.1


