Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E09CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 04:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6hrR-0005oB-1Z; Thu, 09 Oct 2025 00:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hrN-0005nZ-O7
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6hr8-0002ap-Ga
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759982538; x=1791518538;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d/hyPvwUK6UULFTnf0dC3gIquUeG7cEIM/sC3abOq9E=;
 b=i2ZT3xDgT1wHKzjq7qoVLo7/8jmXCX+aJL6H2CHLRFzogSyBN7JpJHj/
 HW7Adq6p5fxcAJiX04XCgjOIcn9kBslohn99G7Cew+2KKnimo36dzYc9I
 L2RkMgyxYYexzpY63fDNkb9/gJdPiJ8btUfFxYA6pcgU0q//xmxY21o0y
 g0YWc/5dyx6chHWe5FCOuFFngK2rSGt2gFatRCWCd1KJEx/zUzVvGwfJ2
 GiH80ImJ4+z3I0wJ30v2L7mP/Lbn4zl4M6Q360brkPY4mL7yvCpVTWC4w
 hpGPAWMtaQe3kpK3DFYOKInFA5gZ1Hfn+E+A6FduF/LGgO0X/Z98dGmXQ w==;
X-CSE-ConnectionGUID: C/yMwMjsRwSBHfH5n3GSCw==
X-CSE-MsgGUID: B/pH8wVBTYmaeeucndmfmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="84804124"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="84804124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:13 -0700
X-CSE-ConnectionGUID: 7Wer4l3oSzKjgZehiU13GQ==
X-CSE-MsgGUID: uC8mY/XERG67KRADr4FnTQ==
X-ExtLoop1: 1
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 21:02:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 levon@movementarian.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/3] Optimize unmap_all with one ioctl()
Date: Thu,  9 Oct 2025 00:01:31 -0400
Message-ID: <20251009040134.334251-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Currently unmap_all is split into two ioctl() with each unmap half of
the whole iova space.

IOMMUFD supports unmap_all ioctl() from beginning, after kernel commit
c19650995374 ("vfio/type1: implement unmap all") added same support
for VFIO type1, the split becomes unnecessary.

So optimize the code to only do one ioctl() to unmap_all for both
backends.

Test:
In order to trigger unmap_all request, I have to fake a unmap_all request
on x86. Maybe it's easy to trigger unmap_all with other arch, e.g., arm smmu,
but for x86, iommu memory region is split by iommu_ir, unmap_all isn't
triggered by default. See
https://github.com/yiliu1765/qemu/commit/7afc7adac8fa601abd978b821c86e90e073d31ba
for details.

Thanks
Zhenzhong

Changelog:
v2:
- check unmap_all_supported instead of ioctl() for every unmap_all (John Levon)
- make assertion a separate patch (Cedric)
- pass VFIOLegacyContainer pointer in vfio_legacy_dma_unmap_one() (Cedric)

Zhenzhong Duan (3):
  vfio/container: Support unmap all in one ioctl()
  vfio/iommufd: Support unmap all in one ioctl()
  vfio/listener: Add an assertion for unmap_all

 include/hw/vfio/vfio-container-legacy.h |  1 +
 hw/vfio/container-legacy.c              | 38 ++++++++++++++-----------
 hw/vfio/iommufd.c                       | 15 +---------
 hw/vfio/listener.c                      |  1 +
 4 files changed, 25 insertions(+), 30 deletions(-)

-- 
2.47.1


