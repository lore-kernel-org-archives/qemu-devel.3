Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6265D68BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7Tx-0003KU-2j; Thu, 18 Dec 2025 01:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7Tu-0003KE-Ry
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:23 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7Ts-00014o-1g
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766039240; x=1797575240;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rTY/Eu4tk0oC+6yLaZgKeMVGeYV+L5caLDdv7cY1wjA=;
 b=W6MoRQ8oIOXdGRwZw/W9fVsSFiX1XMdmSTWiVeVp67UZjnmS3b0GsCC6
 inQtmddhFiO+FQSgEtet6OpbmnZhU+SqPIRlV/ZT6SAj/ow8JqxgYHf8l
 GH6EvxukeXNYnVrsPKfIJtGqHRD2NbUICUutd2FsFsmiycPekT0QvAIeY
 asaByP40Fdzo5NLyiDiXmuIGFqLrP+mIbaiKdS/Tu9aDLqe+H6kHX2O6p
 Cd5lbBGiU7C/NGnapORvGSGNap4k9TcZ/m3/XNxBM8QiJrcFqupdKjvgN
 rMmpbAQ6Rgiic98z4+1NilnlvrZ7xnNJd+A4CSwCoNG8Bu0WrX40LgfYA w==;
X-CSE-ConnectionGUID: n5+u3mw+TS6OvpI1B180YQ==
X-CSE-MsgGUID: STbY4VavSXKFxHK8MlhQlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68028486"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="68028486"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:16 -0800
X-CSE-ConnectionGUID: f6P2dYKVTVKjdGOYRTaTJA==
X-CSE-MsgGUID: 92Aw2b8cQWOJsLVPU2Fvug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203569829"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 0/9] vfio: relax the vIOMMU check
Date: Thu, 18 Dec 2025 01:26:21 -0500
Message-ID: <20251218062643.624796-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

This series relax the vIOMMU check and allows live migration with vIOMMU
without VFs using device dirty tracking. It's rewritten based on first 4
patches of [1] from Joao.

Currently what block us is the lack of dirty bitmap query with iommufd
before unmap. By adding that query and handle some corner case we can
relax the check.

Based on vfio-next branch:

patch1-2: add dirty bitmap query with iommufd
patch3:   a ranaming cleanup
patch4-5: unmap_bitmap optimization
patch6-7: fixes to avoid losing dirty pages
patch8:   add a blocker if VM memory is really quite large for unmap_bitmap
patch9:   relax vIOMMU check

Qemu code can be found at [2], it's based on vfio-next + base nesting series.

We tested VM live migration (running QAT workload in VM) with QAT device
passthrough, below matrix configs with guest config 'iommu=pt' and 'iommu=nopt':
1.Scalable mode vIOMMU + IOMMUFD cdev mode
2.Scalable mode vIOMMU + legacy VFIO mode
3.legacy mode vIOMMU + IOMMUFD cdev mode
4.legacy mode vIOMMU + legacy VFIO mode

The QAT workload is a user level app that utilizes VFIO to control QAT device.

Thanks
Zhenzhong

[1] https://github.com/jpemartins/qemu/commits/vfio-migration-viommu/
[2] https://github.com/yiliu1765/qemu/tree/liuyi/zhenzhong/relax_viommu_check

Changelog:
v6:
- check global_dirty_tracking in vfio_listener_region_del() (Liuyi)
- add note and update subject of patch7 (Liuyi)
- check global_dirty_tracking in vtd_address_space_unmap()

v5:
- drop the patch checking iommu_dirty_tracking (Avihai, Joao)
- pass iotlb info to unmap_bitmap when switch out of system AS

v4:
- bypass memory size check for device dirty tracking as it's unrelated (Avihai)
- split vfio_device_dirty_pages_disabled() helper out as a separate patch
- add a patch to fix minor error on checking vbasedev->iommu_dirty_tracking

v3:
- return bitmap query failure to fail migration (Avihai)
- refine patch7, set IOMMUFD backend 'dirty_pgsizes' and 'max_dirty_bitmap_size' (Cédric)
- refine patch7, calculate memory limit instead of hardcode 8TB (Liuyi)
- refine commit log (Cédric, Liuyi)

v2:
- add backend_flag parameter to pass DIRTY_BITMAP_NO_CLEAR (Joao, Cédric)
- add a cleanup patch to rename vfio_dma_unmap_bitmap (Cédric)
- add blocker if unmap_bitmap limit check fail (Liuyi)


Joao Martins (1):
  vfio: Add a backend_flag parameter to
    vfio_contianer_query_dirty_bitmap()

Zhenzhong Duan (8):
  vfio/iommufd: Add framework code to support getting dirty bitmap
    before unmap
  vfio/iommufd: Query dirty bitmap before DMA unmap
  vfio/container-legacy: rename vfio_dma_unmap_bitmap() to
    vfio_legacy_dma_unmap_get_dirty_bitmap()
  vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
  intel_iommu: Fix unmap_bitmap failure with legacy VFIO backend
  vfio/listener: Add missing dirty tracking in region_del
  vfio/migration: Add migration blocker if VM memory is too large to
    cause unmap_bitmap failure
  vfio/migration: Allow live migration with vIOMMU without VFs using
    device dirty tracking

 include/hw/vfio/vfio-container.h |  8 +++--
 include/hw/vfio/vfio-device.h    | 10 ++++++
 include/system/iommufd.h         |  2 +-
 backends/iommufd.c               |  5 +--
 hw/i386/intel_iommu.c            | 42 +++++++++++++++++++++++++
 hw/vfio-user/container.c         |  5 +--
 hw/vfio/container-legacy.c       | 15 +++++----
 hw/vfio/container.c              | 20 ++++++------
 hw/vfio/device.c                 |  6 ++++
 hw/vfio/iommufd.c                | 53 +++++++++++++++++++++++++++++---
 hw/vfio/listener.c               | 28 ++++++++++++++---
 hw/vfio/migration.c              | 40 ++++++++++++++++++++++--
 backends/trace-events            |  2 +-
 hw/vfio/trace-events             |  2 +-
 14 files changed, 201 insertions(+), 37 deletions(-)

-- 
2.47.1


