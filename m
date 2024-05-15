Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vW-00025N-Du; Wed, 15 May 2024 04:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vT-00024u-Ll
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:51 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vQ-00074Z-4f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761428; x=1747297428;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VlvBMGhf60hfdjyVlOQFajbnzmL35wKO33aDoRdZ4yQ=;
 b=AU5JDGtA4moi1IghHFU1bJTH4AONY9nWikOaGsH/W9noqmxARxaHt/XX
 LnSveXEQXQQMyVxSgxWh+jbUHvTPXMlXojhp4zbJ9UQTPS2sjffJUsKsa
 9AntcyBAF0PfE79jBbi7p+d207m5InHQCKKEF2WRDR0SjEKn9vJ3ohmO+
 XkyxbBw9IStYlqAMEBzlo/fOlT6k+xnxWfNt0AdpYA1jLv45F4WJhDjpF
 PSQApNdALZHJMUAZxSCuhwephWsKiopqqdZpOjfYnqOaUOYsjn0phrc7r
 nqE+omGuQ0gxlC5IJ+0WvPIh7JgVy8BNx3NlE/1mwSolED1FI+tsObrtA w==;
X-CSE-ConnectionGUID: sO9k9fcsRDyhPyJostEiIQ==
X-CSE-MsgGUID: 5C3PlVMFTdqhARORZH0nwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961521"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961521"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:47 -0700
X-CSE-ConnectionGUID: TpSNSSeIRa6LIfIzU+juxQ==
X-CSE-MsgGUID: /au0eGn0Qs28TDlnELG2DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396255"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:23:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 03/16] vfio/helpers: Use g_autofree in hw/vfio/helpers.c
Date: Wed, 15 May 2024 16:20:28 +0800
Message-Id: <20240515082041.556571-4-zhenzhong.duan@intel.com>
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

Changed functions include vfio_set_irq_signaling() and vfio_region_setup().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/helpers.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 47b4096c05..0bb7b40a6a 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -111,7 +111,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                            int action, int fd, Error **errp)
 {
     ERRP_GUARD();
-    struct vfio_irq_set *irq_set;
+    g_autofree struct vfio_irq_set *irq_set = NULL;
     int argsz, ret = 0;
     const char *name;
     int32_t *pfd;
@@ -130,7 +130,6 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
     if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
         ret = -errno;
     }
-    g_free(irq_set);
 
     if (!ret) {
         return 0;
@@ -348,7 +347,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    struct vfio_region_info *info;
+    g_autofree struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -381,8 +380,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
         }
     }
 
-    g_free(info);
-
     trace_vfio_region_setup(vbasedev->name, index, name,
                             region->flags, region->fd_offset, region->size);
     return 0;
-- 
2.34.1


