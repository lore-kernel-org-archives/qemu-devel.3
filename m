Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12674C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarEg-0001pt-UH; Mon, 05 Aug 2024 02:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEX-0001pC-9D
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:17 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarET-00029G-KC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839414; x=1754375414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=p7wFuXhoGbra2VszxYDKcCWTsL6+aR8q1CT8fd+RXOo=;
 b=VfbVsM9VHVr6XjmsStY8IJ0h4n8fwtKUXiDA/eQ/Cn45HfHGX39qtlFu
 r8O/B+CjvknuOFLaG3Dc36X80tFcdCyRFBmeZb7iqL47PDawDYp4nJzRE
 inLuvr/gqgWw/cdK+ZJO0iJ+7E/IXbbKLRaBCwBreLaw/eJS4hAaGOcc2
 JxGpgoOIY9bLrtE9InkdrgxFB3qij2zEkRJkh53VyNTLfFYEQEDxxgIRF
 XatW1Oh5SBAPkanXxHZJDCa8Mt8X6tJc+qcUUsZiHR+qo2+ttJTskHkzQ
 Km7JRXdS0Rhzryhp5ug6MpZZgMqANKB6q0n1E66sWhE3s2utApDKtn0te Q==;
X-CSE-ConnectionGUID: SMocyzAPSi21s2OPOGxG0g==
X-CSE-MsgGUID: lb1hnYATTxueQrPhBs8DLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282657"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282657"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:08 -0700
X-CSE-ConnectionGUID: HouqdQ8XQuGys3ji/rQPlw==
X-CSE-MsgGUID: NKNFh/tuTDWZWTMxLA9+xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786437"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: [PATCH v2 00/17] intel_iommu: Enable stage-1 translation for emulated
 device
Date: Mon,  5 Aug 2024 14:27:10 +0800
Message-Id: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Hi,

Per Jason Wang's suggestion, iommufd nesting series[1] is split into
"Enable stage-1 translation for emulated device" series and
"Enable stage-1 translation for passthrough device" series.

This series enables stage-1 translation support for emulated device
in intel iommu which we called "modern" mode.

PATCH1-5:  Some preparing work before support stage-1 translation
PATCH6-8:  Implement stage-1 translation for emulated device
PATCH9-13: Emulate iotlb invalidation of stage-1 mapping
PATCH14:   Set default aw_bits to 48 in scalable modren mode
PATCH15-16:Expose scalable "modern" mode and "x-cap-fs1gp" to cmdline
PATCH17:   Add qtest

Note in spec revision 3.4, it renamed "First-level" to "First-stage",
"Second-level" to "Second-stage". But the scalable mode was added
before that change. So we keep old favor using First-level/fl/Second-level/sl
in code but change to use stage-1/stage-2 in commit log.
But keep in mind First-level/fl/stage-1 all have same meaning,
same for Second-level/sl/stage-2.

Qemu code can be found at [2]
The whole nesting series can be found at [3]

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_stage1_emu_v2
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
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
  intel_iommu: Set accessed and dirty bits during first stage
    translation
  intel_iommu: Add an internal API to find an address space with PASID
  intel_iommu: Add support for PASID-based device IOTLB invalidation

Yi Liu (3):
  intel_iommu: Rename slpte to pte
  intel_iommu: Implement stage-1 translation
  intel_iommu: Modify x-scalable-mode to be string option to expose
    scalable modern mode

Yu Zhang (1):
  intel_iommu: Use the latest fault reasons defined by spec

Zhenzhong Duan (9):
  intel_iommu: Make pasid entry type check accurate
  intel_iommu: Add a placeholder variable for scalable modern mode
  intel_iommu: Flush stage-2 cache in PASID-selective PASID-based iotlb
    invalidation
  intel_iommu: Flush stage-1 cache in iotlb invalidation
  intel_iommu: Process PASID-based iotlb invalidation
  intel_iommu: piotlb invalidation should notify unmap
  intel_iommu: Set default aw_bits to 48 in scalable modren mode
  intel_iommu: Introduce a property to control FS1GP cap bit setting
  tests/qtest: Add intel-iommu test

 MAINTAINERS                    |   1 +
 hw/i386/intel_iommu_internal.h |  91 ++++-
 include/hw/i386/intel_iommu.h  |   9 +-
 hw/i386/intel_iommu.c          | 689 +++++++++++++++++++++++++++------
 tests/qtest/intel-iommu-test.c |  70 ++++
 tests/qtest/meson.build        |   1 +
 6 files changed, 731 insertions(+), 130 deletions(-)
 create mode 100644 tests/qtest/intel-iommu-test.c

-- 
2.34.1


