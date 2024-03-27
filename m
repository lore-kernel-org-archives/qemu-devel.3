Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQVG-0008H6-0S; Wed, 27 Mar 2024 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQUC-0007NH-Fw
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:24 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQU4-0007aP-J9
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711535176; x=1743071176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NN7bJ9kcE9ymRjA80j4SFQrPkSHGU1tCOZouHjnJcSA=;
 b=EvoE/PCEAXhJGBZL0VFp4K6GHzLBNi0fZmyNMDcG4XAwFfQc88RwIr/B
 shFNLebGtlnuHfYPSzpi6tiDmpGyGdEuFmykmL2+rVUiHEevw7u6nkPll
 rpDpK4pqcHzHC8uSt25ehTcA0LvlDOQsEJyuvG1Mb7sFcVo6qhNbG2Qrs
 n+NEhW4IAnlN0ChUbFmJyoc/j0T+vJ1LGQJ+fudad30rasnOiejD+QKb1
 Xg2VKkF827+mQ6pMoBTJig2oOh5QRFgttD9sqyOKNH3a3SKtFwQ0dyCDi
 gMkPdm+CFDyqFv7dnZvDWpzCudDNkAKvbwjIErJevZNN3OxNFIx14tMPX w==;
X-CSE-ConnectionGUID: 5zLAERswTACTsWLPcoRbTA==
X-CSE-MsgGUID: ucRV/GsCT8adfBTFBnTxxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6489758"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6489758"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 03:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16354475"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 03:25:59 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] target/i386/cpu: Consolidate the use of warn_report_once()
Date: Wed, 27 Mar 2024 18:39:50 +0800
Message-Id: <20240327103951.3853425-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
References: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The difference between error_printf() and error_report() is the latter
may contain more information, such as the name of the program
("qemu-system-x86_64").

Thus its variant error_report_once() and warn_report()'s variant
warn_report_once() can be used here to print the information only once
without a static local variable "ht_warned".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee163..0487469d75f3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7230,7 +7230,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    static bool ht_warned;
     unsigned requested_lbr_fmt;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -7453,13 +7452,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     if (IS_AMD_CPU(env) &&
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        cs->nr_threads > 1 && !ht_warned) {
-            warn_report("This family of AMD CPU doesn't support "
-                        "hyperthreading(%d)",
-                        cs->nr_threads);
-            error_printf("Please configure -smp options properly"
-                         " or try enabling topoext feature.\n");
-            ht_warned = true;
+        cs->nr_threads > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d).", cs->nr_threads);
+            error_report_once("Please configure -smp options properly"
+                              " or try enabling topoext feature.");
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


