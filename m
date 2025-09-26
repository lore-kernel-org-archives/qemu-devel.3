Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F6CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1y8d-0003C7-Le; Thu, 25 Sep 2025 22:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8a-0003Bb-3M
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:45 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8O-0005Re-Pr
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853473; x=1790389473;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X+Emfv4DcrVssxkKvR+Bpa6J8phmDa7Bb2D55UY7z9I=;
 b=WHwo+l4h4rwi1lbjciqZl5Hdl+jzRlobq53eIzAJTZ2phxLwZA6gUIRh
 sn+/Ht2xwM2e2xh5hNvbkyq1SH8mGA78/iCksv8e5YXuUm96JZZ34BF2E
 +YXQI3hObn5VUy35BuGtjumrOzs9R7zXK4nE+NwpXdIJW1hGZfBK3stgS
 BlKiGsYvrT1zYdGjzn4Yo3fGqAYD5JFwox5XAVB50ve5d6ylSCXVpM4v+
 aw2UC/x6coyC9cfYQ+QmSVzH7oj2gS7GnouQxd1h75S1MP+NpjtIxTzRf
 gOV66IzuYhKPkAzYITPBR2PpaC+s482uGgySlDr4PFk1Ae8xnPaDJdThI A==;
X-CSE-ConnectionGUID: Cs2OztZ6RyOxjM7oyzVBOg==
X-CSE-MsgGUID: YWwddEqlSxy6hYzbmeVPfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61234094"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61234094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:10 -0700
X-CSE-ConnectionGUID: 1c3RcsLTRAmvK3gc+GeUtw==
X-CSE-MsgGUID: NzBu1uxWT2qLMNHFBtiIEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176613450"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 4/5] vfio/iommufd: Restore vbasedev's reference to hwpt after
 CPR transfer
Date: Thu, 25 Sep 2025 22:23:47 -0400
Message-ID: <20250926022348.1883776-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

After CPR transfer, if there are more than one VFIO devices, the second
device's reference to hwpt isn't restored on destination. We still need
to call iommufd_cdev_attach_container() to restore it after a matching
container is found, or else SIGSEV triggers.

Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 103ff43426..6df99d3aa6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -565,10 +565,9 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
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


