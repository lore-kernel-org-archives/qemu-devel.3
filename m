Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDFBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxhyH-0007tS-TR; Fri, 19 Apr 2024 02:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhy6-0007ov-7v; Fri, 19 Apr 2024 02:43:31 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhy4-0001CX-L9; Fri, 19 Apr 2024 02:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713509008; x=1745045008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QW0U6rqEdHhhrUN6J4GUhhbNLR4rcAUCgpYyl5CCOUg=;
 b=gYHtscWrXwtPsmRzhGd4kG+Y8Ha2X4SstYd/iU06D8CmlW+Ya57KK2TD
 eg27vY++KSAO55p7bSwfA4ldu97mXkUh/REA60QsPPXe2IOfLzuIi/lML
 jMV4vsjp4Afa13eJNyUCyCkKGVE1bgi1rkZvumkJdm3HJIiimrr75IjYC
 V7jVvy38eS1SxRJLZe+C4pivaZFwFKndkD07UJqJDaS9tnFRyBmdIAkaX
 lddsdqabr1e/LlE46W2buIvlSqVJonzfzRFsCKrnXIMAJ8XI2uiv6HNhl
 ttIsWzdK8zaqF85F2eSztV58GprpLlnxSMl/9NX/EV1JCywCod4XafoOZ g==;
X-CSE-ConnectionGUID: jq94hL5bT920tJDdBRd1hg==
X-CSE-MsgGUID: noKV8yJbTCGXUlO0TY2Htw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19659959"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="19659959"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 23:43:27 -0700
X-CSE-ConnectionGUID: DWmkPqKvR1eDdtP7gcRgIg==
X-CSE-MsgGUID: cokQpEhZSsWGHwmJ33GhqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="28071927"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 18 Apr 2024 23:43:24 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 6/6] target/s390x/cpu_models_sysemu: Drop local @err in
 apply_cpu_model()
Date: Fri, 19 Apr 2024 14:57:12 +0800
Message-Id: <20240419065712.1225038-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Zhao Liu <zhao1.liu@intel.com>

Use @errp to fetech error information directly and drop the local
virable @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/s390x/cpu_models_sysemu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index bf855c659d5e..15be729c3d48 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -389,7 +389,6 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
 
 void apply_cpu_model(const S390CPUModel *model, Error **errp)
 {
-    Error *err = NULL;
     static S390CPUModel applied_model;
     static bool applied;
 
@@ -405,8 +404,7 @@ void apply_cpu_model(const S390CPUModel *model, Error **errp)
     }
 
     if (kvm_enabled()) {
-        if (!kvm_s390_apply_cpu_model(model, &err)) {
-            error_propagate(errp, err);
+        if (!kvm_s390_apply_cpu_model(model, errp)) {
             return;
         }
     }
-- 
2.34.1


