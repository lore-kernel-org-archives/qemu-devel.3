Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB43C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypn4-000490-49; Tue, 25 Aug 2026 07:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1wyn5I-0008GW-KV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:04:44 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1wyn5H-0003NQ-22
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787648684; x=1819184684;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IRospQUnhQ5VlCdPiqzdzA8GrVNZTBQfRJl7Pzsv5LY=;
 b=Xp0MS7fJa+tDzir6BpR/2aFU05PQN2iWrBVs8SCFfZVGW41eGSl+mSgh
 LnX9l5X7ALtYfnJJ/fZ5dnecSsetTVTP2++pxwzQ2hvNSIphQeQmNEodZ
 f65OxD55AYON6N4Q65wI95HyJJfGfNRiiu7UmWO0WYE2xw9cTsIUu9G8L
 wemiQouZxlVFLH0tBBx8GI2JOCSf1rz0g+jUL7ol18SQJkUm6YbkABgvj
 OwVCRD7tFSkM5vkFuhx6DXZKJJhIqcTai6JgGWMJXnxjU4+Owox1lCzs1
 mDydi9DhyChS/h9FW7Oi4P1yJ8Y8euf9Q8E0QtI+4q2fw6AZwuHOKsRsB Q==;
X-CSE-ConnectionGUID: 078963zCTOOtQDcOoOAd3w==
X-CSE-MsgGUID: NwfijpfgTw+j0H+XbGR1AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88128061"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88128061"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 02:04:40 -0700
X-CSE-ConnectionGUID: 0MnKJLNIRWOogCb/kQC/dg==
X-CSE-MsgGUID: CeNaN+1nSa+EtC/EycT3lw==
X-ExtLoop1: 1
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2026 02:04:38 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and Arrow
 Lake
Date: Tue, 25 Aug 2026 17:04:35 +0800
Message-Id: <20260825090435.1492485-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yuan1.wang@intel.com;
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
v2:
- Resending because the v1 patch was sent with an incorrect future 
  system timestamp due to an unsynchronized local clock. No code
  changes.
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


