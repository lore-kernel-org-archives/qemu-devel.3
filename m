Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B817DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 03:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzpKE-0006pH-4m; Wed, 24 Apr 2024 22:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpKB-0006oX-O3; Wed, 24 Apr 2024 22:59:03 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzpK9-00056r-Uq; Wed, 24 Apr 2024 22:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714013942; x=1745549942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e6dWcRslgN31Ixzu7lX4pSShuZhqx1IOMDBdHBsvI1s=;
 b=JmIcghzRpIu9Zzv463rTWjJV4jTVBX3hyW05NqNyC/ri5f2NV3rxZ9ZB
 TGdBCsXpKlBx0vz/F0WBsKgISIzS/dxzrQMzk3DpOk1qaw7FS15cykLkr
 aHTwi6bQAQbQ/muzUjgTfqd7boaEqoQr1GONgmdNpf6IzPFBDF7sBoHMm
 XwlW8vk2KxkefG+KVapWd68fFjON6u7veN3ur5ysXpqUjPCyDi5EvUxOF
 adJyGfCoI3INThCjL+iM3L9/oHc3eFwmrpMN0SjEiIbhhNc3Pb9e0f10t
 vNnPb113GJYDjMy4JgLqXoS0DMTMlrbWul1HycdOljuaHXxt8XhjnG29R w==;
X-CSE-ConnectionGUID: 2tc3/r70S/ChhA+M40CpSg==
X-CSE-MsgGUID: Tb5f8RNpT8+P+Lntstpm6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9605680"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9605680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 19:59:01 -0700
X-CSE-ConnectionGUID: l7G0jNmSTwi5Z/YFaUnDuQ==
X-CSE-MsgGUID: laHNVvLhQVSWNWpylqWM/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="62395713"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 19:58:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 7/7] target/s390x/cpu_models_sysemu: Drop local @err in
 apply_cpu_model()
Date: Thu, 25 Apr 2024 11:12:32 +0800
Message-Id: <20240425031232.1586401-8-zhao1.liu@intel.com>
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


