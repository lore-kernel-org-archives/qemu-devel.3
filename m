Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA7CC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBNg-0004vH-8S; Wed, 31 Jan 2024 09:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVBNd-0004sj-KD; Wed, 31 Jan 2024 09:15:57 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVBNb-0002qQ-Bb; Wed, 31 Jan 2024 09:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706710555; x=1738246555;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vNZ3Qwk2YIFHiawrhPyHwk3jpKPqcLya/p4039Y/Sjo=;
 b=ivCqGZA1AW5fjiJLfLQ2t9Qybe+YL57F3OAY9VBrRpf0TsL9+XyfA+BG
 UXYrLJyNvetwm7MGbwojPj73ra6u5bD5IIDEwAi3gMoGErJwgve17QZoZ
 A1dk2OApLZKGRJntsvkvN/vbULgTDWzAKm0+esA99E5eZk8PNa3p8rzNz
 zr5X2xaHIrPhqA9yNL/cX7/ZZB6Nu6vxf6tL0AJqhPhsIwABKHcUNqUnZ
 WJ/vED8tWjAFr6FtxcT9wxiGKpHxTX78mEz0/jaxfugEwPZzBKF9WZ9Gg
 H6F5+7eIKA2mkQ9AfVLwtkOogW1yMT6ggcUiu6xRYY8D7ig1/w7dtgwWh A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403232303"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="403232303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 06:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822581775"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="822581775"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 31 Jan 2024 06:15:40 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] hw/intc: Handle the error of IOAPICCommonClass.realize()
Date: Wed, 31 Jan 2024 22:29:02 +0800
Message-Id: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

IOAPICCommonClass implements its own private realize(), and this private
realize() allows error.

Therefore, return directly if IOAPICCommonClass.realize() meets error.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/intc/ioapic_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf6214608..3772863377c2 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -162,6 +162,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
 
     info = IOAPIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io_memory);
     ioapic_no++;
-- 
2.34.1


