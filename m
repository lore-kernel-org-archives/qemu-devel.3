Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792EED5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hp9-0002zp-2k; Tue, 29 Oct 2024 04:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp7-0002yu-RD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:33 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp5-00081u-TY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191412; x=1761727412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0iSoAeOpi77343UM4NHKAfHRqjgggjq71Vzm1FN1fVU=;
 b=Y1FCfDF4lqH23nzWnN9vzpMPbl2OH4cLnAsb08j2I7TQfGhhNxVFYfoZ
 r9xgn91c0vPjlIAYoqTwhihI5XZtp9JSjtZSF9cXF2TS27ugmuB1qH7aY
 u4BN9OXBi1jbp18809pm8slef+DnUUSpJhvVQVuUhRdVKe+Z/O7PQOoLL
 y5iOm0XkH/DfyHlJL8uzzUjcpy6CxvaxWUsQNcH2Tu9hiqB0Py7VLR7ah
 gC0KaioG+5dHdx2I3bMKJszEnnYTUlKnuxxLOTBCHVNw+c2bsgVHgVIBM
 Y7fBIA7/aIt6T45lzKov9Lc3qeH4c9/TiGXpatWtsHZDsdLWuwkm7Pk3u g==;
X-CSE-ConnectionGUID: sIOhjz9PQ0GUctj+FKiOmQ==
X-CSE-MsgGUID: HUXkKN8ORiy/lFepz9VYsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592778"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592778"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:29 -0700
X-CSE-ConnectionGUID: DtW0M8zzQ/ChAt8c6UB5YA==
X-CSE-MsgGUID: +LreawYARICLdD0xgwbURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847132"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/16] hw/net: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:21 +0800
Message-Id: <20241029085934.2799066-4-zhao1.liu@intel.com>
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
 hw/net/e1000.c    | 2 +-
 hw/net/eepro100.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 5012b964640d..ab72236d1831 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1774,7 +1774,7 @@ static void e1000_register_types(void)
         type_info.class_data = (void *)info;
         type_info.class_init = e1000_class_init;
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index c8a88b9813f0..20b22d8e49cb 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2102,7 +2102,7 @@ static void eepro100_register_types(void)
             { },
         };
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
-- 
2.34.1


