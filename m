Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B6BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpK2-0006jy-7M; Wed, 24 Apr 2024 22:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJw-0006jG-V5; Wed, 24 Apr 2024 22:58:49 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpJt-00055o-Pm; Wed, 24 Apr 2024 22:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013926; x=1745549926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UzWS39yvXKazwXHx6xonklzmLlk2yJapDzB+gzVW8+M=;
 b=Pl+Z+/MUrOccy8fms21/DOhx4gL+AwEtcAK/cwst26slv/rOScasT+Fx
 AS7gZ8qzDO2XOMpKEJlgqbKGfmjcOHl9fovjZ7Zub/RltJ8uBr39KfL6O
 dQCHNfnLzGLT9A5QF6Mn6XqLU1IYYpFZGRN1+3QQacWBStv79ZelFiuTp
 2+6VqjkJ+CiygVaFgZUazpXQZcs/pe3PtFPeQxUTRc77Vmqh2yDHzNkwy
 GbQI7BAs2IJNyAFxrw8tiZ5WldxUNr0l6y9FNjsI/h8mhmLC45RZ9KF6N
 9FbOCFRltoHBFiMN5ZwHQTxm7KWasxjvEsiq/hyug7IaIcQfM/1OBUtat w==;
X-CSE-ConnectionGUID: WoD+nZARR2mvdMHrUnf7ZA==
X-CSE-MsgGUID: VEfG/y5cTCegrXi0Mv4mSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605640"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605640"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:44 -0700
X-CSE-ConnectionGUID: DtCxYZWmQw+kAYNsZ+vd9Q==
X-CSE-MsgGUID: jyoXAQWLRderQF3JIjyKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395656"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:41 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/7] target/s390x/cpu_model: Make check_compatibility()
 return boolean
Date: Thu, 25 Apr 2024 11:12:26 +0800
Message-Id: <20240425031232.1586401-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425031232.1586401-1-zhao1.liu@intel.com>
References: <20240425031232.1586401-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

With returned boolean, there's no need to check @err.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ed3bb6a27b3..8cb47d905fb4 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -510,7 +510,7 @@ static void check_compat_model_failed(Error **errp,
     return;
 }
 
-static void check_compatibility(const S390CPUModel *max_model,
+static bool check_compatibility(const S390CPUModel *max_model,
                                 const S390CPUModel *model, Error **errp)
 {
     ERRP_GUARD();
@@ -518,11 +518,11 @@ static void check_compatibility(const S390CPUModel *max_model,
 
     if (model->def->gen > max_model->def->gen) {
         check_compat_model_failed(errp, max_model, "Selected CPU generation is too new");
-        return;
+        return false;
     } else if (model->def->gen == max_model->def->gen &&
                model->def->ec_ga > max_model->def->ec_ga) {
         check_compat_model_failed(errp, max_model, "Selected CPU GA level is too new");
-        return;
+        return false;
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -530,14 +530,14 @@ static void check_compatibility(const S390CPUModel *max_model,
         error_setg(errp, "The unpack facility is not compatible with "
                    "the --only-migratable option. You must remove either "
                    "the 'unpack' facility or the --only-migratable option");
-        return;
+        return false;
     }
 #endif
 
     /* detect the missing features to properly report them */
     bitmap_andnot(missing, model->features, max_model->features, S390_FEAT_MAX);
     if (bitmap_empty(missing, S390_FEAT_MAX)) {
-        return;
+        return true;
     }
 
     error_setg(errp, " ");
@@ -546,6 +546,7 @@ static void check_compatibility(const S390CPUModel *max_model,
                   "available in the current configuration: ");
     error_append_hint(errp,
                       "Consider a different accelerator, QEMU, or kernel version\n");
+    return false;
 }
 
 S390CPUModel *get_max_cpu_model(Error **errp)
@@ -605,8 +606,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->model->cpu_ver = max_model->cpu_ver;
 
     check_consistency(cpu->model);
-    check_compatibility(max_model, cpu->model, &err);
-    if (err) {
+    if (!check_compatibility(max_model, cpu->model, &err)) {
         error_propagate(errp, err);
         return;
     }
-- 
2.34.1


