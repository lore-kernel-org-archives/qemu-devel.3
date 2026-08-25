Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31D1C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypn4-00048z-3W; Tue, 25 Aug 2026 07:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1wykvB-0001fD-6g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:46:09 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1wykv9-0002mn-51
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787640367; x=1819176367;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kPEjrqGKp8iyJ+pi30jeL97fI58FWtdJNx9O0zq7lXE=;
 b=Ar/xMlhkl32s6OvzyBF4DW3kTu2egKh8Vvo5RXzjoEOb+3KKI4x5pl9/
 vmdP8ACtsiRyzypwM1Mfn6+yqo5w1tgd/iw6o22VNX969SsXmvMrDFFUo
 yftY3TK26r+ZM3qyLkCQb9npnpus+UqJFgciOCZg3LE9i6NwM5SL+bv67
 PFQLYPdeKgO/4I2SW4mZ1F2sUskEDrT0S98BKF5NrhnYA+ixo1BOPuP4Y
 Gr706y4IxcqlvaCVG8DQ0MaypR+Bvg8W4pWiTb/5G6UoCTwyjhptGkie5
 05YZ2kaXntX1fsoZphXGBsbTdh+lLk0bZhLehGpHt2VitaxIvu0v+FNvy g==;
X-CSE-ConnectionGUID: xu7lMOonSJm26HJMvoYiaw==
X-CSE-MsgGUID: +5VcmDYQQkq2f5WZAGYypQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87974263"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="87974263"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 23:45:55 -0700
X-CSE-ConnectionGUID: Hsf8e+rwTK+I2rpGzJXipw==
X-CSE-MsgGUID: Rr8dPqTFQWGq3RpG8Gq0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="271412263"
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by orviesa005.jf.intel.com with ESMTP; 24 Aug 2026 23:45:53 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH] vfio/igd: Add device ID support for Meteor Lake and Arrow Lake
Date: Tue, 25 Aug 2026 07:30:52 +0000
Message-Id: <20260825073052.1466186-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 07:58:04 -0400
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

Currently, igd_gen() does not include the PCI device IDs for Meteor
Lake and Arrow Lake platforms, causing it to return -1 for these GPUs.

As a result, QEMU calculates the stolen memory size as 0 and exposes a
zero-sized 'etc/igd-bdsm-size' entry via fw_cfg. When OVMF boots,
IgdAssignmentDxe fails validation on the zero BDSM size and aborts
without programming the ASLS register. Consequently, the guest Intel
GOP driver fails to locate and read the OpRegion (ASLS remains 0x0).

Add the device ID prefixes (0x7D00 and 0xB600) to igd_gen() as Gen 12
so that stolen memory is correctly determined, allowing OVMF to properly
initialize the OpRegion and BDSM for the Intel GOP driver.

Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
 hw/vfio/igd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9..a0b6b34d81 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+    case 0x7D00:    /* Meteor Lake / Arrow Lake */
+    case 0xB600:    /* Arrow Lake */
         return 12;
     }
 
-- 
2.34.1


