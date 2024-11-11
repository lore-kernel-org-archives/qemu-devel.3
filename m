Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B20D2E9C0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwM-0004rn-Be; Mon, 11 Nov 2024 03:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPw0-0004qH-PA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:08 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPvy-0003TI-2V
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314286; x=1762850286;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gd/dyXmkEugCdMRbB1CJu0a57+26hDHB/UNo2iSuSus=;
 b=LYIORQxE6aS3/3ol+h/ytwvxMC4jdmxP1+nDjZEInHiZGezV4CpIPbBn
 DM9DMiaSzy62CsA0UUpyEvY3yVp/gFZpPYYOF0OxtTjf4Gz6FylK78uxB
 tstcZYT6mi0wnJ5So1keMD2D5zfdZD6DjY3sUu6xs+yvYzRfygutZHSwI
 aDdDNNHkJCfecnpopxJ1zzQTOdelQ13SOf/XtNty77p3sP6aaVrPpLvoF
 kZx96bAhTLOr41+t3A30W7JkLAqwsWcEBo1ZZgYnxUibJ5+j5mlTKKPGf
 h5KEl07KgZ+z+2wtAQOl14bYx79OOYs7EtnHNRiOFAFAvwD1a41IfIrlK w==;
X-CSE-ConnectionGUID: qVBPsAyXSn+XcXSrfKduDQ==
X-CSE-MsgGUID: 4GWdaDIZSyO9Rv0o9Oa/FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334315"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334315"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:03 -0800
X-CSE-ConnectionGUID: LX8kmjDFTGiAxyhi0vogZQ==
X-CSE-MsgGUID: Qlx+TZNfR7uFC5t5uaEfJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608214"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:00 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 00/20] intel_iommu: Enable stage-1 translation for emulated
 device
Date: Mon, 11 Nov 2024 16:34:37 +0800
Message-Id: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

Per Jason Wang's suggestion, iommufd nesting series[1] is split into
"Enable stage-1 translation for emulated device" series and
"Enable stage-1 translation for passthrough device" series.

This series enables stage-1 translation support for emulated device
in intel iommu which we called "modern" mode.

PATCH1-5:  Some preparing work before support stage-1 translation
PATCH6-9:  Implement stage-1 translation for emulated device
PATCH10-14:Emulate iotlb invalidation of stage-1 mapping
PATCH15-17:Set default aw_bits to 48 in all modes, update DMAR table
PATCH18-19:Expose scalable modern mode "x-flts" and "fs1gp" to cmdline
PATCH20:   Add qtest

Note in spec revision 3.4, it renames "First-level" to "First-stage",
"Second-level" to "Second-stage". But the scalable mode was added
before that change. So we keep old favor using First-level/fl/Second-level/sl
in code but change to use stage-1/stage-2 in commit log.
But keep in mind First-level/fl/stage-1 all have same meaning,
same for Second-level/sl/stage-2.

Test done:
- two VFIO devices hotplug/unplug in legacy and scalable modern/legacy mode
- vhost with caching-mode=off
- windows 2019 VM bootup

Qemu code can be found at [2]
The whole nesting series can be found at [3]

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_emu_v5
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
v5:
- add new patch8 to check if translation result fall in ir range (Liuyi)
- remove unused parameter ih from vtd_piotlb_page_invalidate() (Liuyi)
- define target as pointer in vtd_find_as_by_sid_and_pasid() (Liuyi)
- s/x-fls/x-flts (Liuyi)
- set default aw_bits to 48 for all modes (jason)
- fix return value of vtd_iova_to_flpte()
- merge piotlb inv notify to vtd_iotlb_page_invalidate_notify(),
  no functional change

v4:
- s/Scalable legacy/Scalable in logging (Clement)
- test the mode first to make the intention clearer (Clement)
- s/x-cap-fs1gp/fs1gp and s/VTD_FL_RW_MASK/VTD_FL_RW (Jason)
- introduce x-fls instead of updating x-scalable-mode (Jason)
- Refine comment log in patch4 (jason)
- s/tansltion/translation/ and s/VTD_SPTE_RSVD_LEN/VTD_FPTE_RSVD_LEN/ (Liuyi)
- update the order and naming of VTD_FPTE_PAGE_* (Liuyi)

v3:
- drop unnecessary !(s->ecap & VTD_ECAP_SMTS) (Clement)
- simplify calculation of return value for vtd_iova_fl_check_canonical() (Liuyi)
- make A/D bit setting atomic (Liuyi)
- refine error msg (Clement, Liuyi)

v2:
- check ecap/cap bits instead of s->scalable_modern in vtd_pe_type_check() (Clement)
- declare VTD_ECAP_FLTS/FS1GP after the feature is implemented (Clement)
- define VTD_INV_DESC_PIOTLB_G (Clement)
- make error msg consistent in vtd_process_piotlb_desc() (Clement)
- refine commit log in patch16 (Clement)
- add VTD_ECAP_IR to ECAP_MODERN_FIXED1 (Clement)
- add a knob x-cap-fs1gp to control stage-1 1G paging capability
- collect Clement's R-B

v1:
- define VTD_HOST_AW_AUTO (Clement)
- passing pgtt as a parameter to vtd_update_iotlb (Clement)
- prefix sl_/fl_ to second/first level specific functions (Clement)
- pick reserved bit check from Clement, add his Co-developed-by
- Update test without using libqtest-single.h (Thomas)

rfcv2:
- split from nesting series (Jason)
- merged some commits from Clement
- add qtest (jason)


Clément Mathieu--Drif (4):
  intel_iommu: Check if the input address is canonical
  intel_iommu: Set accessed and dirty bits during stage-1 translation
  intel_iommu: Add an internal API to find an address space with PASID
  intel_iommu: Add support for PASID-based device IOTLB invalidation

Yi Liu (2):
  intel_iommu: Rename slpte to pte
  intel_iommu: Implement stage-1 translation

Yu Zhang (1):
  intel_iommu: Use the latest fault reasons defined by spec

Zhenzhong Duan (13):
  intel_iommu: Make pasid entry type check accurate
  intel_iommu: Add a placeholder variable for scalable modern mode
  intel_iommu: Flush stage-2 cache in PASID-selective PASID-based iotlb
    invalidation
  intel_iommu: Check stage-1 translation result with interrupt range
  intel_iommu: Flush stage-1 cache in iotlb invalidation
  intel_iommu: Process PASID-based iotlb invalidation
  intel_iommu: piotlb invalidation should notify unmap
  tests/acpi: q35: allow DMAR acpi table changes
  intel_iommu: Set default aw_bits to 48 starting from QEMU 9.2
  tests/acpi: q35: Update host address width in DMAR
  intel_iommu: Introduce a property x-flts for scalable modern mode
  intel_iommu: Introduce a property to control FS1GP cap bit setting
  tests/qtest: Add intel-iommu test

 MAINTAINERS                       |   1 +
 hw/i386/intel_iommu_internal.h    | 101 ++++-
 include/hw/i386/intel_iommu.h     |   8 +-
 hw/i386/intel_iommu.c             | 732 ++++++++++++++++++++++++------
 hw/i386/pc.c                      |   1 +
 tests/qtest/intel-iommu-test.c    |  65 +++
 tests/data/acpi/x86/q35/DMAR.dmar | Bin 120 -> 120 bytes
 tests/qtest/meson.build           |   1 +
 8 files changed, 749 insertions(+), 160 deletions(-)
 create mode 100644 tests/qtest/intel-iommu-test.c

-- 
2.34.1


