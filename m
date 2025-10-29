Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9199CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2t4-0005sW-MA; Wed, 29 Oct 2025 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2sz-0005sE-Ck
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:33 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2su-0002mX-5s
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731668; x=1793267668;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s1ifJv8p25HdxRd8jyYP3Zm+E+xWOQrXq6lp5ilkyTI=;
 b=fj/zyclfcypcOaJX159MEUQBAmuc0+iYhpEHjIeJE51HVoyL7cVrDJAg
 mcxXmIXwcKIFbs6hMGJq+Apzmlwx9rC60xPT2365c5vDElR0esa69IAND
 0PnhklnOkNf1gD2BdwJ7DnQyvRICqr9OmPTVyqiaphDBPhuRFDag39omi
 T+DxsgD6xTdrwP7cFoSK+JJGVVDE3+x5G8500pl2GYXtVZIQFjnaDp+7e
 nAK7D2iTbHyhb3Zprvtcb04BPC+0nXsm3wHiyZlZj6+ewEkbmoy+LG2mV
 IlZXGDWc+LHGOTk4zpLt871VX54HzESBU7WMXr+8oNkPOXZiPtSIvfAUI w==;
X-CSE-ConnectionGUID: mINXIDS1QLqGLKCQlj/GAw==
X-CSE-MsgGUID: C/G+/C36T9mMQaFmet81wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685104"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:22 -0700
X-CSE-ConnectionGUID: Z02+iXYFTL2gDaRp0ceeJw==
X-CSE-MsgGUID: H/9s6CcLSuKdgLJvoSwD9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529818"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 00/10] vfio: relax the vIOMMU check
Date: Wed, 29 Oct 2025 05:53:43 -0400
Message-ID: <20251029095354.56305-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
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

Hi,

This series relax the vIOMMU check and allows live migration with vIOMMU
without VFs using device dirty tracking. It's rewritten based on first 4
patches of [1] from Joao.

Currently what block us is the lack of dirty bitmap query with iommufd
before unmap. By adding that query and handle some corner case we can
relax the check.

Based on vfio-next branch:

patch1-2: add dirty bitmap query with iommufd
patch3-4: cleanup and preparing work
patch5-6: unmap_bitmap optimization
patch7-8: fix issues with legacy backend
patch9:   add a blocker if VM memory is really quite large for unmap_bitmap
patch10:  relax vIOMMU check


We tested VM live migration (running QAT workload in VM) with QAT
device passthrough, below matrix configs:
1.Scalable mode vIOMMU + IOMMUFD cdev mode
2.Scalable mode vIOMMU + legacy VFIO mode
3.legacy mode vIOMMU + IOMMUFD cdev mode
4.legacy mode vIOMMU + legacy VFIO mode

[1] https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/

Thanks
Zhenzhong

Changelog:
v4:
- bypass memory size check for device dirty tracking as it's unrelated (Avihai)
- split vfio_device_dirty_pages_disabled() helper out as a separate patch
- add a patch to fix minor error on checking vbasedev->iommu_dirty_tracking

v3:
- return bitmap query failure to fail migration (Avihai)
- refine patch7, set IOMMUFD backend 'dirty_pgsizes' and 'max_dirty_bitmap_size' (Cedric)
- refine patch7, calculate memory limit instead of hardcode 8TB (Liuyi)
- refine commit log (Cedric, Liuyi)

v2:
- add backend_flag parameter to pass DIRTY_BITMAP_NO_CLEAR (Joao, Cedric)
- add a cleanup patch to rename vfio_dma_unmap_bitmap (Cedric)
- add blocker if unmap_bitmap limit check fail (Liuyi)


Joao Martins (1):
  vfio: Add a backend_flag parameter to
    vfio_contianer_query_dirty_bitmap()

Zhenzhong Duan (9):
  vfio/iommufd: Add framework code to support getting dirty bitmap
    before unmap
  vfio/iommufd: Query dirty bitmap before DMA unmap
  vfio/container-legacy: rename vfio_dma_unmap_bitmap() to
    vfio_legacy_dma_unmap_get_dirty_bitmap()
  vfio: Introduce a helper vfio_device_dirty_pages_disabled()
  vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
  intel_iommu: Fix unmap_bitmap failure with legacy VFIO backend
  vfio/migration: Fix a check on vbasedev->iommu_dirty_tracking
  vfio/migration: Add migration blocker if VM memory is too large to
    cause unmap_bitmap failure
  vfio/migration: Allow live migration with vIOMMU without VFs using
    device dirty tracking

 include/hw/vfio/vfio-container.h |  8 +++--
 include/hw/vfio/vfio-device.h    | 10 ++++++
 include/system/iommufd.h         |  2 +-
 backends/iommufd.c               |  5 +--
 hw/i386/intel_iommu.c            | 42 +++++++++++++++++++++++
 hw/vfio-user/container.c         |  5 +--
 hw/vfio/container-legacy.c       | 19 +++++++----
 hw/vfio/container.c              | 20 +++++------
 hw/vfio/device.c                 |  6 ++++
 hw/vfio/iommufd.c                | 58 +++++++++++++++++++++++++++++---
 hw/vfio/listener.c               |  6 ++--
 hw/vfio/migration.c              | 35 +++++++++++++++++--
 backends/trace-events            |  2 +-
 hw/vfio/trace-events             |  2 +-
 14 files changed, 183 insertions(+), 37 deletions(-)

-- 
2.47.1


