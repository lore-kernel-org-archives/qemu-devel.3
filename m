Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9FEC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIc0-0006NC-7C; Thu, 04 Jul 2024 05:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1sPIbu-0006MK-Ea; Thu, 04 Jul 2024 05:18:38 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1sPIbr-0001br-0q; Thu, 04 Jul 2024 05:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720084715; x=1751620715;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2yWda5+RJ5YHltmBgTNQsmoOCifxWuqxZL3/wnZPkyo=;
 b=lmi0LTQ8FKeeAA07jXM2Pcci3CFZSV3rR6dheE8TIhFTJTSi6rmkfw8q
 2+pz6lEfV7VPEhI7mjjeEeddV4O2lyKyam00oBuK4FpM4B3l64S/GdMgz
 lUE6HqTbA6uwu8eBSCKcMzxr80iv52h1QiqVcun38puqXdn0stAfdZoNF
 oQIOZIPRWCUtn4+A8jwCL7M1gGfSYhnYKI2RO6PMRrDnzy6UKzWJkLWY6
 DCVPOzmI9DP23AExNx6T+odzbgDjbfq3/6+0IXGG1tfYmVUZKd09ZrrRN
 y692zW6S6s+V6+5KU0CZmCHQMrPuY5D4XZTvCe4CHCyODVh0zrNMKUNd6 A==;
X-CSE-ConnectionGUID: /zi5M0lRTRCNrEC2DGVo1g==
X-CSE-MsgGUID: 6x2jhHUdRQ6fKIzbYHeVjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17487617"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17487617"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 02:18:31 -0700
X-CSE-ConnectionGUID: wKOGwyB6QpWVKu8euJf57Q==
X-CSE-MsgGUID: f6mIF49JR16jMnM5i269TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="50863190"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2024 02:18:29 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw property
Date: Thu,  4 Jul 2024 17:34:04 +0800
Message-Id: <20240704093404.1848132-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Guest crashes (Segmentation fault) when getting cxl-fmw property via
qmp:

(QEMU) qom-get path=machine property=cxl-fmw

This issue is caused by accessing wrong callback (opaque) type in
machine_get_cfmw().

cxl_machine_init() sets the callback as `CXLState *` type but
machine_get_cfmw() treats the callback as
`CXLFixedMemoryWindowOptionsList **`.

Fix this error by casting opaque to `CXLState *` type in
machine_get_cfmw().

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cxl/cxl-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64d0..e9f2543c43c6 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
 static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    CXLFixedMemoryWindowOptionsList **list = opaque;
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList **list = &state->cfmw_list;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
 }
-- 
2.34.1


