Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17707D5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpB-00030T-9n; Tue, 29 Oct 2024 04:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp8-0002zl-PE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:34 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp7-000823-6Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191413; x=1761727413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9kYnldw41cJdWUJuuIJhFYvlphLmKS447wGYWCEh280=;
 b=Fe/kRe2K8Mo9U1Vciu6ez9pICJH71uwIT0IKtT1PjJu6WO8E7HCR2+FX
 KyOELW1B6/gsINqKIk6FRlKM1Wxk1lv5f5ujZFxm1grcXveIzvaaUeGTT
 IhBKTycftA3cXz25FBcvNsszF5zIpwGCthzvB/uom1ZsRINuCOHdFH4fL
 uI/2nARR4SZUAL/zSevd1zbWEu+c7btPmk7M1JcqVV0PkBQDr+5vX5VgE
 o405WTSZjn91BAUvszmLsQj/IA9/Unkr2ZyoBerwQCQK8VKD3EHY7hseU
 q5z9L2TqnqeFO41T1MLPqtFRx1M/zWpqCTjGWvfMbmmjk0nhI5O376sUo Q==;
X-CSE-ConnectionGUID: DjhvNda7TJuzgNKew4Uszw==
X-CSE-MsgGUID: JAGEyqAzQza38rpQqAsiuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592796"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592796"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:32 -0700
X-CSE-ConnectionGUID: 9S+eylurSzW+pqDejO0eqg==
X-CSE-MsgGUID: NdJHCqV0Siyxz8H5h9x68g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847167"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/16] hw/rtc: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:23 +0800
Message-Id: <20241029085934.2799066-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/rtc/m48t59-isa.c | 2 +-
 hw/rtc/m48t59.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 6e9723fdf19f..b642b82680d8 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -161,7 +161,7 @@ static void m48t59_isa_register_types(void)
     for (i = 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
         isa_type_info.name = m48txx_isa_info[i].bus_name;
         isa_type_info.class_data = &m48txx_isa_info[i];
-        type_register(&isa_type_info);
+        type_register_static(&isa_type_info);
     }
 }
 
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 48846d8df409..90299ea56fe3 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -679,7 +679,7 @@ static void m48t59_register_types(void)
     for (i = 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
         sysbus_type_info.name = m48txx_sysbus_info[i].bus_name;
         sysbus_type_info.class_data = &m48txx_sysbus_info[i];
-        type_register(&sysbus_type_info);
+        type_register_static(&sysbus_type_info);
     }
 }
 
-- 
2.34.1


