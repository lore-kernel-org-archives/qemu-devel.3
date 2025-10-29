Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2tW-0005yN-V2; Wed, 29 Oct 2025 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tP-0005x1-Nz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:59 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tN-0002pk-9q
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731698; x=1793267698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=INo9zFVHFO7PnVTAEL7U6nieTC6v0bt514H4r0YlqN0=;
 b=a3bXT+jPosCrAVF858XIayBB0LhV0pK6NBnMArdzO0x+XIJ1ae1q4BJr
 kHjr6hIayOcsjTr6yg5QbIR0O2dMn+Kd/fM2T2xmWNeqHx/+ehnsRcsdN
 ypKhaW5bxM70Rbz1dWPailUtaiHXosrXoIVv5S3+vNcKkEPskPB49DkK4
 B4qKD+ik31FVQie4d/aegc32g3c46gEMgLyootIVBENcy5LTpPIDmIN9I
 YJevzUzwK2+miT89s8zHYVsaWJDDKxImHg+sUs2a5VxvyndRhnuITn7DK
 /Qn0VwCl5CFJC/2hZ3p+6LOD4CYdLI9BUER8ZpmGeGVywGqdD3MK3OehQ w==;
X-CSE-ConnectionGUID: fzA+bfKnQyqN0XG7fjHbiA==
X-CSE-MsgGUID: 8ys0FL9GQraZSfAnLlK7MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685146"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685146"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:53 -0700
X-CSE-ConnectionGUID: lkHz89efQBqT/UNKHyOUew==
X-CSE-MsgGUID: LecCX/G6T1e4nO4X0X1RRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529902"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Date: Wed, 29 Oct 2025 05:53:51 -0400
Message-ID: <20251029095354.56305-9-zhenzhong.duan@intel.com>
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

VFIO IOMMU type1 claims to support IOMMU dirty tracking by setting
bcontainer->dirty_pages_supported, but in vfio_migration_realize()
vbasedev->iommu_dirty_tracking is checked, we should pass
bcontainer->dirty_pages_supported to vbasedev->iommu_dirty_tracking
in legacy backend so that the check is accurate.

Fixes: 30b916778517 ("vfio/common: Allow disabling device dirty page tracking")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container-legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index dd9c4a6a5a..fa726a2733 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -845,6 +845,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
                             VFIODevice *vbasedev, Error **errp)
 {
     g_autofree struct vfio_device_info *info = NULL;
+    VFIOContainer *bcontainer = VFIO_IOMMU(group->container);
     int fd;
 
     fd = vfio_cpr_group_get_device_fd(group->fd, name);
@@ -883,7 +884,8 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
-    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container), info);
+    vfio_device_prepare(vbasedev, bcontainer, info);
+    vbasedev->iommu_dirty_tracking = bcontainer->dirty_pages_supported;
 
     vbasedev->fd = fd;
     vbasedev->group = group;
-- 
2.47.1


