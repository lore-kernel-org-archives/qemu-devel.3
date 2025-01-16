Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2F5C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYN6P-00027v-8v; Thu, 16 Jan 2025 05:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tYN6H-000275-QH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:27:47 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tYN6F-0002lb-5e
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737023263; x=1768559263;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PRUOhBzHcGIqfXPiUDXEC/acxL1CyLuVY8wILUvpSDs=;
 b=P2vlPEOIWtJgtT2FGaw8FQXTcFKPNTJ2+GhBJUNsCFgzzgtyhnv7RXb8
 9/RdATR2/kk3+wT8pif3tGQYZUnQtxHeCpn4rJ5mGhqAYfP1XeU1ovhZ0
 Kz/VzXxGtYOr29+FmyLBbejR3IuTty5bW0LY8kAvzo50+CkMVawxR3AFf
 Tw7ReSaS2DKwCheFJanmnKsI10MQb37XyHU94TazRqFpmsxu0CcGBsJ6K
 FKPxDvmnsnLzU7OHGapNXbHXxGoNHWBORa6reljT/rR6GgVAlOziNsQmo
 vGkXUR/ISAWw+LRJQavtpo6FEP4lZZhuhtnG9TxMClKmMjDc9yp3fXJ2b Q==;
X-CSE-ConnectionGUID: RThZWeEvT7Ws68PShfm6rg==
X-CSE-MsgGUID: 9XwDySOGRvmmxDerC89kLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48816743"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="48816743"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 02:27:32 -0800
X-CSE-ConnectionGUID: UUZjsHmxQmq4u/uahRrI7A==
X-CSE-MsgGUID: fuBoaYVcTdalVHvrNeHXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="105300550"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 02:27:30 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
Date: Thu, 16 Jan 2025 18:23:07 +0800
Message-Id: <20250116102307.260849-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
errp should be set or else SIGSEV is triggered in vfio_realize() when
error_prepend() is called.

By this chance, use the same error message for both legacy and iommufd
backend.

Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f1eb..df61edffc0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -515,8 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         } else {
             ret = iommufd_cdev_ram_block_discard_disable(true);
             if (ret) {
-                error_setg(errp,
-                              "Cannot set discarding of RAM broken (%d)", ret);
+                error_setg_errno(errp, -ret,
+                                 "Cannot set discarding of RAM broken");
                 goto err_discard_disable;
             }
             goto found_container;
@@ -544,6 +544,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     ret = iommufd_cdev_ram_block_discard_disable(true);
     if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
         goto err_discard_disable;
     }
 
-- 
2.34.1


