Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC0CCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2tb-000658-6o; Wed, 29 Oct 2025 05:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tY-00063x-Ci
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:55:08 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tV-0002qs-6A
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731705; x=1793267705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=27Kzqt4KNnkxv05PFDVsUqXyUhhKvyijxvUko4OI5iI=;
 b=H83AUPYje8kMNen5sHQfkOL6C8Qc4yIGXuysSO0agA7L33l/A+j/TA+l
 Me76NRHGMD1BYSjsIhaEZ9TwGWScQ4knFR1rorYh3k0KQXmX5nMf/7Biq
 /0wmQIa6lY/YFHh+eMG2yNi/A3SgYq/fi6I8HGEJbZYAq2VWK8/SIqG/s
 C8aRF3HwSGrZ6A1SfnHAW4XEvO3NW/dgd69mWvJGeWqfCWFrRsC6A3YG9
 o6bMyNn/B0rzv9mszYkj+g97b8lXULkwRMib944sr+1B765hu4WzycApU
 eip5rdKEgvPfte0+XnlrvgApKBgGBHw3pjeD74h+IDQ2VxSRVppM/ylul g==;
X-CSE-ConnectionGUID: cgQqXPfgSWuaQmAAmS3gDg==
X-CSE-MsgGUID: El09PmXcSza2aa+FYKPBqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685164"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:55:01 -0700
X-CSE-ConnectionGUID: 8g5uNG2dQWSwRbfaOrBeuA==
X-CSE-MsgGUID: Z10q+nCnR0e7Xj9MLFogDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529932"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Zeng <jason.zeng@intel.com>
Subject: [PATCH v4 10/10] vfio/migration: Allow live migration with vIOMMU
 without VFs using device dirty tracking
Date: Wed, 29 Oct 2025 05:53:53 -0400
Message-ID: <20251029095354.56305-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029095354.56305-1-zhenzhong.duan@intel.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Commit e46883204c38 ("vfio/migration: Block migration with vIOMMU")
introduces a migration blocker when vIOMMU is enabled, because we need
to calculate the IOVA ranges for device dirty tracking. But this is
unnecessary for iommu dirty tracking.

Limit the vfio_viommu_preset() check to those devices which use device
dirty tracking. This allows live migration with VFIO devices which use
iommu dirty tracking.

Suggested-by: Jason Zeng <jason.zeng@intel.com>
Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 hw/vfio/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 0a1d8cac2c..40f337b798 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1230,7 +1230,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         goto out_deinit;
     }
 
-    if (vfio_viommu_preset(vbasedev)) {
+    if (!vfio_device_dirty_pages_disabled(vbasedev) &&
+        vfio_viommu_preset(vbasedev)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
         goto add_blocker;
-- 
2.47.1


