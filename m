Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5C6CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1y8X-0003BY-P0; Thu, 25 Sep 2025 22:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8T-0003AW-FG
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:37 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8I-0005UN-Gj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853467; x=1790389467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y9HIeCRAoLqdRnWGHA3GZcPqZziWNCu5DNYoOnTaoHQ=;
 b=azwvltey8+WLhgAqw8diuUgniXVZBwrgDYgqeP3eYhiaPaRKl8iNUoMC
 zyGQbA4fwA6yd5lvIZBWyVulEFfQOQV4djVt4MhufMaRluJZhalBdLYAa
 G+HP10S32rvU10FzVSej87im4JdUHZYruzD///hN/pv14tyDKffpJX3q/
 BpvZQGYHkwZwZv1UNsIhliSDjko81tg5YTcsXYUNO3v2Gj5/aBUbycWro
 jVOLQs7LnpQItm1T+SlnB0+zRhx1NaL56tlhaHy8lIWDqBQ5M4XAgdXab
 I6jt6VMNc0HpkivQ8g0VxifqrUnMVUC3OPglrgLs+XPBoQVdJGW9m7Er2 w==;
X-CSE-ConnectionGUID: u5yTWPTgSy2Om/8AQmzBeg==
X-CSE-MsgGUID: 2VVJ1kUTTbaBjSATBX54EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61234091"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61234091"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:08 -0700
X-CSE-ConnectionGUID: RWFOYq/iSHedVizpFTHK6g==
X-CSE-MsgGUID: BhURmNkISRyNL6ACjcfADA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176613447"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/5] vfio/iommufd: Save cpr.ioas_id on source side for CPR
 transfer
Date: Thu, 25 Sep 2025 22:23:46 -0400
Message-ID: <20250926022348.1883776-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On source side, if there are more than one VFIO devices and they
attach to same container, only the first device saves cpr.ioas_id,
the others are bypassed. We should same it for each device, or
else only first device works.

Fixes: 4296ee07455e ("vfio/iommufd: reconstruct device")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..103ff43426 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -607,7 +607,6 @@ skip_ioas_alloc:
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
     QLIST_INIT(&container->hwpt_list);
-    vbasedev->cpr.ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
@@ -641,6 +640,8 @@ skip_ioas_alloc:
     bcontainer->initialized = true;
 
 found_container:
+    vbasedev->cpr.ioas_id = container->ioas_id;
+
     ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
     if (ret) {
         error_setg_errno(errp, errno, "error getting device info");
-- 
2.47.1


