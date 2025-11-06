Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A02ECCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrUP-0006ab-ML; Wed, 05 Nov 2025 23:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUO-0006aM-Bf
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:48 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUM-0000nM-0G
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762402846; x=1793938846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Lj2pkVNFIt3WN6qCCv5rX6S1wQrDs0M+lY093vg5m8Q=;
 b=WklA+2cmm9vIBPhUlViXHohhsWrgVVCIvuRUrh35lgFJNfiA6YNPrdWQ
 ibCQ3dXaNETJmmYj06UkNpQ6FmbDKQGWVCiLYSxXpNb7YL7cwWit9k1WP
 PPiw3m7OEPulheXf+4rMvSl66FNiy8hCExsG5JtKeTnnJUgvJDuMsZnzt
 e6KukTg0kDoojRpP74kmOD/5kVbhPQ/YWki6NCNweNGy/fw6e+4++D69H
 yEyGgU03WScBTXkE3oj8JQeVX3Ne5Wd/ZLoMu3XzyLq93ROo4Ts8kATHI
 IJm2+ZQRU5fJb1qFzpkUtp1d4nTCO/W1cybTBKfvm/7CydwM6oh/WEbUF A==;
X-CSE-ConnectionGUID: XpD7xloyRfCyFsSdPKkiZA==
X-CSE-MsgGUID: 0ImIJ8YEQQKvz73lNUlQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64412840"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="64412840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:41 -0800
X-CSE-ConnectionGUID: rLmeB0EzR7iqT3/wA4IdSw==
X-CSE-MsgGUID: OWBEByIaQTKEezr4nrVGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="186901219"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 0/9] vfio: relax the vIOMMU check
Date: Wed,  5 Nov 2025 23:20:17 -0500
Message-ID: <20251106042027.856594-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
patch3:   a ranaming cleanup
patch4-5: unmap_bitmap optimization
patch6-7: fixes to avoid losing dirty pages
patch8:   add a blocker if VM memory is really quite large for unmap_bitmap
patch9:   relax vIOMMU check


We used [2] to test, it contains dom_switch series + this series +
nesting series. I included nesting series just because I'd like to confirm
the two patches optimizing out dirty tracking for readonly pages work.

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
[2] https://github.com/yiliu1765/qemu/tree/liuyi/zhenzhong/iommufd_nesting.v8.DS_LM.wip

Changelog:
v5:
- drop the patch checking iommu_dirty_tracking (Avihai, Joao)
- pass iotlb info to unmap_bitmap when switch out of system AS

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

Zhenzhong Duan (8):
  vfio/iommufd: Add framework code to support getting dirty bitmap
    before unmap
  vfio/iommufd: Query dirty bitmap before DMA unmap
  vfio/container-legacy: rename vfio_dma_unmap_bitmap() to
    vfio_legacy_dma_unmap_get_dirty_bitmap()
  vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
  intel_iommu: Fix unmap_bitmap failure with legacy VFIO backend
  vfio/listener: Construct iotlb entry when unmap memory address space
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
 hw/vfio/listener.c               | 21 ++++++++++---
 hw/vfio/migration.c              | 40 ++++++++++++++++++++++--
 backends/trace-events            |  2 +-
 hw/vfio/trace-events             |  2 +-
 14 files changed, 194 insertions(+), 37 deletions(-)

-- 
2.47.1


