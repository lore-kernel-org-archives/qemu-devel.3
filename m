Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7663AC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhYs-00034A-W8; Wed, 04 Jun 2025 02:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhYn-00033G-FH
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:15 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhYk-0001Zb-PT
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749018311; x=1780554311;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E5IF7P/0i3p+6b4bLBeKfIUZR0fg11pBBpf/YRZpShM=;
 b=D5LkdognOCLIKyGOWSvFLk4ZVGAW/xnP+1mu49yLD6ICKFGdfrYZ37y/
 Jx8C6NsgytsSBqNJ4eAF5lTbVtXXfppZKekCCshUGQRCL3D7IYFNN0fHh
 gnNkFJA7W8iTJEWEkhbsztJTSEbSxKWXlCnj11JLutdKDvICAtD8teTgm
 tgTtb/FXWUpGHZZAFmy1TgXw6Ll+5bn33TEP/jk032RIUa9e8GmBOjn+u
 dB7gb6YyjNwzuOIBSIwJCSTpJGqdkAxvMUHEaByEk/KgTvwggPPZKgtc1
 pvoEhqHFKUwGJI1U1397UZqKpiSdTQQAjS6iuNGMynYadFHymlZxLQSgt g==;
X-CSE-ConnectionGUID: O5Ut2LxNQQiYHRJ4RmoC1g==
X-CSE-MsgGUID: Z/nUfO5rSe+IQLLK2rSlcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73614503"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="73614503"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:07 -0700
X-CSE-ConnectionGUID: ITrfX2ueRJ2eXZnpWL8zuQ==
X-CSE-MsgGUID: jjp9bKcvRZmc6dskAel3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145693529"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/4] VFIO and IOMMU prerequisite stuff for IOMMU nesting
 support
Date: Wed,  4 Jun 2025 14:21:11 +0800
Message-Id: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

The first 6 patches of [1] are all VFIO or IOMMUFD related additions.
Split them out per Cédric and seek for quick acceptance.

I didn't copy changelog from [1] as it's a mix of the whole nesting series.

For who want a quick view of the whole nesting series [2].

Test done:
- VFIO devices hotplug/unplug
- build test on Windows

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05002.html
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v1.wip

Thanks
Zhenzhong

Changelog:
v3:
- add doc comment update for new field vendor_caps (Eric)

v2:
- report kernel BUG as error instead of assert (Cédric)
- merge patch2 and patch3 (Cédric)
- handle vendor cap check directly from vtd_check_hiod, so patch6 removed (Cédric)
- s/data_ptr/data (Cédric)
- s/totally/total (Donald)

v1:
- changed to save raw data in VendorCaps, so we can keep all vendor structure
  decoding inside the backend and VFIO wouldn't need to care about types nor
  what's inside the data.


Zhenzhong Duan (4):
  backends/iommufd: Add a helper to invalidate user-managed HWPT
  vfio/iommufd: Add properties and handlers to
    TYPE_HOST_IOMMU_DEVICE_IOMMUFD
  vfio/iommufd: Implement [at|de]tach_hwpt handlers
  vfio/iommufd: Save vendor specific device info

 include/system/host_iommu_device.h | 15 ++++++++
 include/system/iommufd.h           | 54 ++++++++++++++++++++++++++++
 backends/iommufd.c                 | 58 ++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c                  | 36 ++++++++++++++++---
 backends/trace-events              |  1 +
 5 files changed, 159 insertions(+), 5 deletions(-)

-- 
2.34.1


