Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA68D5B16F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpF-000325-Cj; Tue, 29 Oct 2024 04:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpC-000310-LR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:38 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpB-00081u-2f
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191417; x=1761727417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rnz6R4FgIlH4YI0tBu1NrnmfxYTvCccvvkVAtxUSMQE=;
 b=eNbNrMaaZiuhWK1sGZDTm7SVMmCXrdXzwfCehYIweGxISn2shMOwrB+y
 Whlp3zr599XtuMRQsAKqP7rlnrvY/gCz3M7yfyAKPXvusyVj6f7dtqpxH
 oqXs5z/TgdRVosreZB6g6M8DC9iYAs9/WNZIHTyuB19el2FBPyWccvnye
 6eFW4mLBckXDz5qi4qdK80sczWSRBnybsi1nYODtVkqJp+MhbRCvYlgRO
 f7dgMKbePlwpZCPh4SYDQLizSYAVev/6W5SqNChk6AG6OnX+pUBuQyz+j
 bOX2KIspZ2jzvB36cZuLMsPqslXDiW+MrK6EolfiwCbFN9Pg0/qC2Q7CK w==;
X-CSE-ConnectionGUID: FnKqjB4tSVOxzWHweLW0FA==
X-CSE-MsgGUID: QlLNunbjQh6zVjHQjMV/Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592802"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592802"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:35 -0700
X-CSE-ConnectionGUID: vxj9VGx9R4ia+Yd8Z5qx4g==
X-CSE-MsgGUID: UxiJgwwGRf2HtJAVLYq2MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847182"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/16] hw/sensor: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:25 +0800
Message-Id: <20241029085934.2799066-8-zhao1.liu@intel.com>
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
 hw/sensor/tmp421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index b6f0b62ab11b..82e604279c5a 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -384,7 +384,7 @@ static void tmp421_register_types(void)
             .class_init = tmp421_class_init,
             .class_data = (void *) &devices[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
-- 
2.34.1


