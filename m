Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1425C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uam-0006jW-7p; Wed, 23 Apr 2025 03:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uad-0006gn-FT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uaa-0002Yx-Hv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393533; x=1776929533;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XjYbvMBGW5zkX0IbKDJWhi42I1hI/WeNS8xrLVjdVpY=;
 b=irDh+qxknyzY48GArgLUKMojEzjaCcZW/Keq5pYwhhbxj0d004s9ds8B
 FZ1WZ1HzhKUMiqxgM0tsGdrAusSynAKMbf2H+KjOpCPQtDpWhICAiIK45
 EEGJJk8CtfOy2oqWJagGziEBs1s+6LRLHvY8vqkIMZ0mmLIu+Dm77cmhD
 /8hJKd2mxb48z9AH3jzvfVf7PlNNTWP5dRgb1NYCCdCLEuHvc7ECAafxy
 dif0Dtbdeo3qF4cpcDL5AI2zlVmUAOOrU71tPO/O5Vr5CTqRA3GcZG+me
 ScrMD/ArJV7ySNzxSUACwB0jbEv0BQGDEUTuMiMvflQPOIUq88DgUcDHO A==;
X-CSE-ConnectionGUID: Odx6BNkiTJ6WqIAvvUTbLQ==
X-CSE-MsgGUID: Ecs9DQYPRimLa8tUGDyFEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959251"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:08 -0700
X-CSE-ConnectionGUID: NfVwH7AFSiuMvLiNqVa4vg==
X-CSE-MsgGUID: G2Squ+1kS2aq6I6y6erh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025331"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/5] vfio: Move realize after attach_dev
Date: Wed, 23 Apr 2025 15:28:19 +0800
Message-Id: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

This series addresses Cédric's suggestion[1] and Donald's suggestion[2] to
move realize() call after attach_device().

This way avoid the need to introduce realize_late() to further complex the
interface in nesting series.

[1] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01211.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00898.html

Test:
net card passthrough and ping test
hotplug/unplug

Based on vfio-next(856f36c005).

Thanks
Zhenzhong

Changelog:
v2:
- drop the idea to save host iommu capabilities in VFIODevice.caps
- introduce a new function to create and realize hiod
- remove hiod_typename property

Zhenzhong Duan (5):
  vfio/iommufd: Make a separate call to get IOMMU capabilities
  vfio/iommufd: Move realize() after attachment
  vfio/container: Move realize() after attachment
  vfio: Cleanup host IOMMU device creation
  vfio: Remove hiod_typename property

 include/hw/vfio/vfio-container-base.h |  3 ---
 include/hw/vfio/vfio-device.h         |  3 ++-
 hw/vfio/container.c                   | 25 ++++++++++++--------
 hw/vfio/device.c                      | 33 ++++++++++++---------------
 hw/vfio/iommufd.c                     | 31 +++++++++++++------------
 5 files changed, 47 insertions(+), 48 deletions(-)

-- 
2.34.1


