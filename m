Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBF3CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS77N-0006C2-St; Wed, 27 May 2026 01:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77I-0006Bc-KM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:45 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77A-0000Y7-QH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860857; x=1811396857;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6bMdeNuSFmUSUOOKpWJqiR3I8MzwrD1C40zrHH6mP30=;
 b=Kdni9ZpVOe6VzHLop3fuZUR6SL23AYNCylGkEDPLGRy5JPoss5pcKZMf
 1tn/sczHdOdg9Anp5KtlJs+ghDDuCdT8x5uEHcK7AjMG7UMgIDgpoDZGc
 Wd8de/b94b8BVbtThCG0iPLT9/XbXDiAhjKSl5wwaiwuKiM85sQalgEYD
 zAmwi5We5vi+rFeOULN8FNtECg4w4swAvFTXmpoacr6Ndg2Uy3eg3wl90
 5t631sa31OgwePj0pntTW9wYmna7buZWw6ScvPCLWhpuhc7mceZ1ebH3d
 hM5IAvo/7eHmA5Ikd+L6XR7g1/lAPc0tOnVEgrK/eDrkYfM4TvD+k38tZ Q==;
X-CSE-ConnectionGUID: 4M2qu8n6StmFUIGXVffzHg==
X-CSE-MsgGUID: 5YgRZU2XQAy8g2fi/mkMTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988071"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:33 -0700
X-CSE-ConnectionGUID: 3V7T1C/jRESWmsRO+MV55g==
X-CSE-MsgGUID: 7Ba7lO2kSgyf3f6wVr/Dnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086644"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 00/17] intel_iommu: Enable PASID support for passthrough
 device
Date: Wed, 27 May 2026 01:46:38 -0400
Message-ID: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Now we already support first stage translation with passthrough device
backed by nested translation in host, but only for IOMMU_NO_PASID.

Structure VTDAddressSpace includes some elements suitable for emulated
device and passthrough device without PASID, e.g., address space,
different memory regions, etc, it is also protected by vtd iommu lock,
all these are useless and become a burden for passthrough device with
PASID.

When there are lots of PASIDs used in one device, the AS and MRs are
all registered to memory core and impact the whole system performance.

So instead of using VTDAddressSpace to cache pasid entry for each pasid
of a passthrough device, we define a light weight structure
VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
will use this struct as a parameter to conduct binding/unbinding to
nested hwpt, to record the current binded nested hwpt and even future
PRQ support. It's also designed to support IOMMU_NO_PASID.

The potential full definition of VTDAccelPASIDCacheEntry may like:

  typedef struct VTDAccelPASIDCacheEntry {
      VTDHostIOMMUDevice *vtd_hiod;
      VTDPASIDEntry pasid_entry;
      uint32_t pasid;
      uint32_t fs_hwpt_id;
      uint32_t fault_id;
      int fault_fd;
      QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
      IOMMUPRINotifier pri_notifier_entry;
      IOMMUPRINotifier *pri_notifier;
      QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
  } VTDAccelPASIDCacheEntry;

Based on newest master branch.
GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_pasid.v6

PATCH01-10: Some preparing work
PATCH11-15: Handle PASID entry addition/removal and bind/unbind
PATCH16-17: Add PASID related check and enable PASID for passthrough device

Tests:
Tested with DSA device which driver uses 2 PASIDs by default.

Thanks
Zhenzhong

Changelog:
v6:
- add comments that IOMMU_NO_PASID should be fixed to 0 (Clement)
- add a refactor patch to update vtd_dev_get_pe_from_pasid() with passing in BDF (Liuyi)
- add a fix patch to pass pasid != IOMMU_NO_PASID to vtd_report_fault() (Liuyi)
- delete vtd_hiod_get_pe_from_pasid() and use vtd_dev_get_pe_from_pasid() instead (Liuyi)
- polish commit log and comments in code (Liuyi)

v5:
- use %u for pasid print (Shammer)
- s/attachment/detachment in API doc (Shammer)
- save iommu pasid in vtd_as to avoid the check of PCI pasid whenever possible (Clement)
- commit log minor tweak on patch3 and patch7 (Liuyi)
- use name 'pasid-bits' for pasid property (Liuyi)

v4:
- improve documents of VIOMMU_FLAGs (Cédric)
- add a cleanup patch to simplify the check between PCI pasid and VTD pasid (Clement)
- rebase to newest master branch

v3:
- fix @Pasid parameter's comment (Liuyi)
- introduce a wrapper vtd_accel_delete_pc() (Liuyi)
- drop patch12 in v2 to avoid a race condition (Clement)
- s/PASID_0/IOMMU_NO_PASID s/gloal/global s/as_it/hiod_it (Liuyi)
- make trace_vtd_device_at/detach_hwpt use IOMMU_NO_PASID (Liuyi)
- change _accel subfix style naming to vtd_accel_ prefix style (Liuyi)
- drop unnecessary parameter vtd_hiod* from vtd_destroy_old_fs_hwpt() (Liuyi)
- introduce a new flag VIOMMU_FLAG_WANT_PASID_ATTACH for pasid attach (Nicolin)

v2:
- move the check "s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH" to patch5 (Clement)
- move #include "hw/core/iommu.h" before #include "hw/core/qdev.h" (Liuyi)
- polish the comment about @Pasid parameter (Liuyi)
- s/pe/pasid_entry, s/as_it/hiod_it, s/vtd_find_add_pc/vtd_accel_fill_pc (Liuyi)
- s/VTDACCELPASIDCacheEntry/VTDAccelPASIDCacheEntry (Liuyi)
- add explanation in code about PASID removal before addition (Liuyi)
- polish the comment about scope of VTDAccelPASIDCacheEntry vs VTDPASIDCacheEntry (Liuyi)
- add an optimization to bypass PASID entry addition for PASID selective pv_inv_dsc (Liuyi)

v1:
- use naming pattern "XXX_SET_THENAME" same as smmu (Clement)
- fix s->pasid check (Clement)

RFCv2:
- extend attach/detach_hwpt() instead of introducing new callbacks (Shammer)
- Define IOMMU_NO_PASID for device attachment without pasid (Nicolin)
- update vtd_destroy_old_fs_hwpt()'s parameter for naming consistency (Clement)
- check pasid bits size to be no more than 20 bits (Clement)
- initialize local variable max_pasid_log2 to 0 (Cédric)


Zhenzhong Duan (17):
  vfio/iommufd: Extend attach/detach_hwpt callback implementations with
    pasid
  iommufd: Extend attach/detach_hwpt callbacks to support pasid
  vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
    flag
  intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID flag
  intel_iommu: Rename pasid property to "pasid-bits" and define it as
    type uint8
  intel_iommu: make vtd_dev_get_pe_from_pasid() more generic
  intel_iommu: Export some functions
  intel_iommu: Fix PASID validity check in fault reporting
  intel_iommu: Use IOMMU_NO_PASID and delete PASID_0
  intel_iommu: Refactor PASID processing to use IOMMU_NO_PASID
    internally
  intel_iommu_accel: Handle PASID entry addition for pc_inv_dsc request
  intel_iommu_accel: Handle PASID entry removal for pc_inv_dsc request
  intel_iommu_accel: Bypass PASID entry addition for just deleted entry
  intel_iommu_accel: Handle PASID entry removal for system reset
  intel_iommu_accel: Switch to VTDAccelPASIDCacheEntry for PASID
    bind/unbind and PIOTLB invalidation
  intel_iommu_accel: Add pasid bits size check
  intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED and
    VIOMMU_FLAG_WANT_PASID_ATTACH

 hw/i386/intel_iommu_accel.h    |  20 +-
 hw/i386/intel_iommu_internal.h |  44 +++-
 include/hw/core/iommu.h        |  14 ++
 include/hw/i386/intel_iommu.h  |   4 +-
 include/hw/vfio/vfio-device.h  |   1 +
 include/system/iommufd.h       |  18 +-
 include/system/memory.h        |   2 +-
 backends/iommufd.c             |   9 +-
 hw/arm/smmuv3-accel.c          |  12 +-
 hw/i386/intel_iommu.c          | 264 ++++++++++------------
 hw/i386/intel_iommu_accel.c    | 395 +++++++++++++++++++++++++++------
 hw/vfio/device.c               |  11 +
 hw/vfio/iommufd.c              |  56 +++--
 hw/vfio/trace-events           |   4 +-
 14 files changed, 594 insertions(+), 260 deletions(-)

-- 
2.47.3


