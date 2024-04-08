Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D48CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtke2-0001TK-JY; Mon, 08 Apr 2024 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtke0-0001Sf-PE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:25 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkdw-0004F1-MW
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712565980; x=1744101980;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4iqDzx+o8VGVbyPMjkJ5o6FsUdIj82k8Z3munL5eLvk=;
 b=ifWNqpUtd0+LzbxpDcrOHVAdfsdikH0TeYmPjU35BLL0TUrE4TAHY2i5
 9K/SrG9WtgG1M1WV6G+sROyd6kgrw1y//qAIxo0PiVGM9YC+sUbUaDf7r
 f7w/3EUaWcvffP4Bh7VPSUPcNaq/8PC8vnIcasQuke/ST/U8LAY5KjqvM
 k9TM30oSQTo2WwdSsLCr11BxYgqtWwwkufleZcpdmEh7ak2zXoYj6q9Sj
 0eZQU17J9ORIlz2xtnnlG/vCUjCQzbvnr69eHCoQgebCOLnU9YEH2iNGG
 EUoDQg7ywVC4T2dAagprNianSbBijvOj2d6iJ8pswr90MLSBGD+5ZKIm5 A==;
X-CSE-ConnectionGUID: IMbZB5H7Qaivawz2QAJQ0A==
X-CSE-MsgGUID: LpU/So3GTkWKuT6ljSMGUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19269423"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19269423"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:17 -0700
X-CSE-ConnectionGUID: ETMXVOYjStSrVG79d9zdLw==
X-CSE-MsgGUID: uowvfNogSCyTXOQXMEhXRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="42985848"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/5] Check host IOMMU compatilibity with vIOMMU
Date: Mon,  8 Apr 2024 16:43:59 +0800
Message-Id: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
is further splitted to host IOMMU device abstract part [2] and vIOMMU
check part. This series implements the 2nd part.

1st part implements get_host_iommu_info() callback which vIOMMU can call to
get host IOMMU info. For legacy VFIO or VDPA device, aw_bits is provided;
for IOMMUFD backed device, IOMMUFD uAPI provides detailed cap/ecap bits from
host.

vIOMMU implements set/unset_iommu_device() callback to get HostIOMMUDevice
and call get_host_iommu_info(). So vIOMMU can do compatibility check with
the return host IOMMU info.

This is also a prerequisite for incoming iommufd nesting series:
'intel_iommu: Enable stage-1 translation' where HostIOMMUDevice provides
more data such as iommufd/devid/ioas_id and callback attach/detach_hwpt()
for vIOMMU to create nested hwpt, attaching/detaching hwpt, etc.

The major change of this version is dropping the cap/ecap update logic based
on MST's suggestion. We can add property for any cap/ecap bit when necessary
just like "aw-bits". This way we don't need to concern about migration
compatibility and code is cleaner.

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_part2_v2

[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00763.html

Thanks
Zhenzhong

Changelog:
v2:
- drop cap/ecap update logic (MST)
- check aw-bits from get_host_iommu_info() in legacy mode

v1:
- convert HostIOMMUDevice to sub object pointer in vtd_check_hdev

rfcv2:
- introduce common abstract HostIOMMUDevice and sub struct for different BEs (Eric, Cédric)
- remove iommufd_device.[ch] (Cédric)
- remove duplicate iommufd/devid define from VFIODevice (Eric)
- drop the p in aliased_pbus and aliased_pdevfn (Eric)
- assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (Cédric, Eric)
- use errp in iommufd_device_get_info (Eric)
- split and simplify cap/ecap check/sync code in intel_iommu.c (Cédric)
- move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (Cédric)
- make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (Cédric)
- block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
- add R-B


Yi Liu (2):
  intel_iommu: Implement set/unset_iommu_device() callback
  intel_iommu: Add a framework to do compatibility check with host IOMMU
    cap/ecap

Zhenzhong Duan (3):
  intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
  intel_iommu: Check for compatibility with legacy device
  intel_iommu: Check for compatibility with iommufd backed device

 hw/i386/intel_iommu_internal.h |   8 ++
 include/hw/i386/intel_iommu.h  |   3 +
 hw/i386/intel_iommu.c          | 242 +++++++++++++++++++++++++++------
 3 files changed, 211 insertions(+), 42 deletions(-)

-- 
2.34.1


