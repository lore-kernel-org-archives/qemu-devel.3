Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8061C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 03:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpKB-0006oC-1T; Wed, 24 Apr 2024 22:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK6-0006m7-IO; Wed, 24 Apr 2024 22:58:58 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK4-00056r-7p; Wed, 24 Apr 2024 22:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013937; x=1745549937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uIA3FScaT/QajfQBBLkqnXQiTMjVrt19xThYfs85OUY=;
 b=KNo8jFjwQBmpOo7qJ8GzJoWPoRDEl0YfvrqbjWEM4yFzTkg+VPYZ+FI3
 VQze0WCNO4Qkkg1oruAJD2TkyHnn36XkFKUa1yzAynYk/Aj/jVh4ZJFy5
 +VqUj5GKeG7cj2EQdfBsm9a/kLv7YSN9g/qpnT6jObc9jmDB0mBrg+R7k
 HlyXyTodZIx5eI1FF45Crd4xegCnhu/W2lszxECuMiGk1UQMhvYMG7FAa
 WLGuAiZRH8Fd/DEP4GrPK1AtmhKVGAjb4psGQwz+6MGSUEcxkByffaXT5
 xUVMm9lUQyz6GTxhr4/3tlmmkNe2RoErP/ZMhOavS7vOXES5PezjkTDTk Q==;
X-CSE-ConnectionGUID: hDhse/ZrSJ+rxIDePN568g==
X-CSE-MsgGUID: t50j6gsbQcemGxtnOydkCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605671"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:58:55 -0700
X-CSE-ConnectionGUID: jFHP8G1BRw23n7tv/Ys9ug==
X-CSE-MsgGUID: 6vGgELU5QiqIFN9/ejOtCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395703"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:53 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 5/7] target/s390x/cpu_models: Drop local @err in
 get_max_cpu_model()
Date: Thu, 25 Apr 2024 11:12:30 +0800
Message-Id: <20240425031232.1586401-6-zhao1.liu@intel.com>
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

Use @errp to fetch error information directly and drop the local
variable @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a0e4acb707d7..aae452cfd3fc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -551,7 +551,6 @@ static bool check_compatibility(const S390CPUModel *max_model,
 
 S390CPUModel *get_max_cpu_model(Error **errp)
 {
-    Error *err = NULL;
     static S390CPUModel max_model;
     static bool cached;
 
@@ -560,8 +559,7 @@ S390CPUModel *get_max_cpu_model(Error **errp)
     }
 
     if (kvm_enabled()) {
-        if (!kvm_s390_get_host_cpu_model(&max_model, &err)) {
-            error_propagate(errp, err);
+        if (!kvm_s390_get_host_cpu_model(&max_model, errp)) {
             return NULL;
         }
     } else {
-- 
2.34.1


