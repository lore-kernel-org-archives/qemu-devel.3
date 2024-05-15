Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E9C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vT-00022o-23; Wed, 15 May 2024 04:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vP-000219-Db
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:47 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vN-00074Z-Rg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761425; x=1747297425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WKdlfZRZ+uV5fBUr0kfvuBkrXP/k7AsBL/srbsncrLI=;
 b=dGn4CQCFVUdON0nAsjD900tf9ef/Cg7b3wThU2ipitGNBrJTCbF8otGk
 ANN5eY636n+TsyTGjrij5NW3IkThhRIG+8KTylQd+m8aCZB39IRBo6h43
 JeXJVd3OCjl8nIipT9fxQBzmA3gVqbJsuLuKTZGD9BnOlYdN2J1nn99pD
 WIDgYZVkEFvZF5nGyOPo96lJAyumZAMvKzsWLBnFQ/sfOW0j1HAGxcNu0
 8gKkFCL4cnPfS5NkL12GTWqiCe0GbPh+XlA6Ar2XR6rIEsb7NWvtgYGte
 SgDDv1XQ5QZ2pj6XSDogLiQI11bWxzmLlL5ADCTwDnknopVMakhdYHqly A==;
X-CSE-ConnectionGUID: d220hxoLTbWMmgwWK6Escg==
X-CSE-MsgGUID: yppCUdcZQEG+fS5FFOgcXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961508"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:43 -0700
X-CSE-ConnectionGUID: Xhh9an+xQBSm7sNINrg3CQ==
X-CSE-MsgGUID: xIw4OxI1RbiAOXJyVJxXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396225"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 01/16] vfio/display: Fix error path in call site of
 ramfb_setup()
Date: Wed, 15 May 2024 16:20:26 +0800
Message-Id: <20240515082041.556571-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

vfio_display_dmabuf_init() and vfio_display_region_init() calls
ramfb_setup() without checking its return value.

So we may run into a situation that vfio_display_probe() succeed
but errp is set. This is risky and may lead to assert failure in
error_setv().

Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: b290659fc3d ("hw/vfio/display: add ramfb support")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..57c5ae0b2a 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -359,6 +359,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -486,6 +489,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     return 0;
 }
-- 
2.34.1


