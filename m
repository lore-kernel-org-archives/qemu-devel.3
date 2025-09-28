Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9537CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nCC-0006Tv-1w; Sun, 28 Sep 2025 04:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC8-0006TE-Dq
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:49 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC1-00045O-TN
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049742; x=1790585742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3UQj2hJs2Apvsru+FUO6+kmR91IJA7eedlHTGTktHRA=;
 b=XpMZXS0RA1YZugkL/paQ2LQxf4/eS3OptRCuS0NhORKW+rrqBkyfppkw
 KWjBlOcZVhZtCWoD2B7m6uwW+dXTWInBNVoPGr4XNnfKDrY7DIdBK5VUW
 EwaZKVz4pkhiTsb7vev054kQCEvwQqXKgt1EDxe//cAO05ppkKolG/ua6
 32O7N4l/WqvbcTU004JY+Brgb5gczyLmCk7s3W7nogULZLHAgYp+81Ww8
 +gWTDV1osfmR5EMhMkTopz7JHsLyWcMStB+K4Wp2GyqITGOJyZecNiK3l
 STjALWAVldDr28qhiff89aRwrrLUBr7ljCV3bZe6hNDHmnex9PlwryZl7 g==;
X-CSE-ConnectionGUID: fxEBmT44TBeHhMrDUGzedg==
X-CSE-MsgGUID: bp/jEMH/RviWbSZs07KkOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167439"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167439"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:24 -0700
X-CSE-ConnectionGUID: ldyHBXjvR2uMmdaZaB8a+A==
X-CSE-MsgGUID: NckImwntR7aZfgMDfIOceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810815"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 4/6] vfio/iommufd: Restore vbasedev's reference to hwpt
 after CPR transfer
Date: Sun, 28 Sep 2025 04:54:30 -0400
Message-ID: <20250928085432.40107-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
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

After CPR transfer, if there are more than one VFIO devices, device is
not added to hwpt->device_list and its reference to hwpt isn't restored
on destination. We still need to call iommufd_cdev_attach_container() to
restore it after a matching container is found, or else SIGSEV triggers.

Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 13c5c49d5e..c6ca5db009 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -560,10 +560,9 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             continue;
         }
 
-        if (!cpr_is_incoming()) {
+        if (!cpr_is_incoming() ||
+            (vbasedev->cpr.ioas_id == container->ioas_id)) {
             res = iommufd_cdev_attach_container(vbasedev, container, &err);
-        } else if (vbasedev->cpr.ioas_id == container->ioas_id) {
-            res = true;
         } else {
             continue;
         }
-- 
2.47.1


