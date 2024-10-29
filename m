Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD60D5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hp8-0002zb-NU; Tue, 29 Oct 2024 04:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp6-0002yQ-Qg
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:32 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp5-00082C-5K
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191411; x=1761727411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yIyb1abKVnDFJMflWs366PCqnWxkWmaMhCPGF5VbeKc=;
 b=cXqOJNS6Rhgtp2CDX52QQ5j3sk6xanATw3g47cObUvju7PJn2lCp4H8/
 /koLJvWyK820nWPvFSe9XNbPCiBy1+7lhWwxFFYjcB/nmUpEP6AeCTCJM
 y/0xg9cBQVr9g3D/6/9OXL1ll1k3Y7Yr50Ory61LAmUmMcZ2JAtY7MO3S
 zuIBN/PIl0UNkX3l3/sxTTPFoya/Md+w7B7o8CXOQU5vvcKj9cjtt4hJU
 NQDw0TE2eKax1p4p5wrrD17fk0cumWQScE0Of0pQ9MESW59M+IpC0mHEV
 ABocYuTTq0DJowVHXyOn8lFiGeS2mlALEV+5vJlDgmG12cgMMcCyj60Wn w==;
X-CSE-ConnectionGUID: /ZtrOBH1SyGwUCQ9oN0Frw==
X-CSE-MsgGUID: Zn38FSwCTtaBiN7PiTSnWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592774"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592774"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:27 -0700
X-CSE-ConnectionGUID: 6vq/QPBkRbG/5rlI1kn72Q==
X-CSE-MsgGUID: lOZi8fveSjegZ71TBuSZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847119"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/16] hw/block: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:20 +0800
Message-Id: <20241029085934.2799066-3-zhao1.liu@intel.com>
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
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e2e84f8b5f8d..748594524e3f 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1894,7 +1894,7 @@ static void m25p80_register_types(void)
             .class_init = m25p80_class_init,
             .class_data = (void *)&known_devices[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
-- 
2.34.1


