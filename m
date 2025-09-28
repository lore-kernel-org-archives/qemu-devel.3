Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ECBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nC9-0006Sy-QT; Sun, 28 Sep 2025 04:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC5-0006Sa-Vj
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:46 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nBs-00044H-HI
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049733; x=1790585733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZaOR0GwkP7gj0Qjq7ISfL5dfkwjjlxyWj/oRNzcntF8=;
 b=M/I8Ig/+0i+P8JlLKbA2c+/qqYzGDYA5Imacaxfc/NnqVyjkY7BvX5qY
 wKgI6ynq/Pwz3a7fZQbU3JQYxhGPazI1xiuvCu+PjJe721KlG7byewG6f
 DiKWaquX+VPBrwnKP3b6vmPSyy23PxJ2ITWvzc1NmuugliaPUIuDbekLI
 OG+lTSvXmPCFFs+eHQRbwsxk/V4nR7sf4gDtCCCG+aUq9gNf8GOwNncRz
 v6gfzpaq67dBA+FfE/A09ZdisT+pYm+Ljt9QEclzsvy0YfMRdCIgy25or
 nWArqWOWd1WJeDkjsDYa7EZYG7vdBaP3QdfOpchypmLq73U7kAPQ8BOsb A==;
X-CSE-ConnectionGUID: HhRCF9QCRWC9lEQkjge+SQ==
X-CSE-MsgGUID: aZUEMEsCQeCEED8UL3cpCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167436"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167436"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:22 -0700
X-CSE-ConnectionGUID: SzKgkaStTA2XU/LkjxfU/g==
X-CSE-MsgGUID: BMSXHGg3Tiu+XLNMWgjaDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810810"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/6] vfio/iommufd: Set cpr.ioas_id on source side for CPR
 transfer
Date: Sun, 28 Sep 2025 04:54:29 -0400
Message-ID: <20250928085432.40107-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On source side, if there are more than one VFIO devices and they
attach to same container, only the first device sets cpr.ioas_id,
the others are bypassed. We should set it for each device, or
else only first device works.

Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f0ffe23591..13c5c49d5e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -602,7 +602,6 @@ skip_ioas_alloc:
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
     QLIST_INIT(&container->hwpt_list);
-    vbasedev->cpr.ioas_id = ioas_id;
 
     bcontainer = VFIO_IOMMU(container);
     vfio_address_space_insert(space, bcontainer);
@@ -636,6 +635,8 @@ skip_ioas_alloc:
     bcontainer->initialized = true;
 
 found_container:
+    vbasedev->cpr.ioas_id = container->ioas_id;
+
     ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
     if (ret) {
         error_setg_errno(errp, errno, "error getting device info");
-- 
2.47.1


