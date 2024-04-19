Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxhy3-0007nh-0E; Fri, 19 Apr 2024 02:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhxv-0007mZ-DX; Fri, 19 Apr 2024 02:43:19 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxhxt-0001Bv-Ce; Fri, 19 Apr 2024 02:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713508997; x=1745044997;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iWKKaHfg5cqYfoIHDCIm+pcw/eQF/WdGOSbon8iw0RM=;
 b=el2QQQEYpRFW1ZCJYflrLob1JdWP3qpoTgpfGY8DplZzeOKhuogauvO6
 awM9WN4VmqLJh0vKx/lYznk/xrY7KYkNxp5Lx6vkuSDOr7/5o+NGQDniF
 Zaeyk6xsSRaAl1NzuWiwjgd40JvkD1SIuGyP91Os3ljKRulZemoJbAz+t
 6JbeEDi1qmDCN9GDf61VIDQCRUfr55AiWcIU/5hdUpJekUqzHu51HW24o
 lUtZy1rXCEoY2X22rqJ4zECpFAQOnj5Ry8bM2jWxJojGRNCHmacMnL0ec
 nVEH/CLOsFGd+o+RCz3VQjC7FpqJbPAHqvwhEJ25dxDcTGdo94HRII4s1 Q==;
X-CSE-ConnectionGUID: DuSyXQ1/RaCzf2q0dlWeXw==
X-CSE-MsgGUID: 2itpKq9jRgqYJOYlZnw0Zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19659918"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="19659918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 23:43:14 -0700
X-CSE-ConnectionGUID: joRA+eebTfWnqvk/AuGOPw==
X-CSE-MsgGUID: s9AhufdzQTGPrt2bpVtnxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="28071842"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 18 Apr 2024 23:43:11 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/6] target/s390x/cpu_model: Make check_compatibility() return
 boolean
Date: Fri, 19 Apr 2024 14:57:07 +0800
Message-Id: <20240419065712.1225038-2-zhao1.liu@linux.intel.com>
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

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

With returned boolean, there's no need to check @err.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
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


