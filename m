Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE205C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dph-0003J8-3V; Wed, 22 May 2024 00:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpX-00038E-01; Wed, 22 May 2024 00:44:00 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpV-0005wQ-Bx; Wed, 22 May 2024 00:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353037; x=1747889037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NOv++k7YIHXe3mdhvNwiZ7ufitLLfKDDIQWej2awCVw=;
 b=fVw7hCUnBu2G+HfsDep4vjgpg8bpIElHMXKO+WYcxRyQIbsuLAxBhMA4
 1QMwr0g7brivtQe5P6Eh7sNN5OdPfO4C2WWM3ltUKYPZ5IV11RVpQPkkp
 DdITMfXFUc1N89FcXYQ3x5mXVceaBVOJ06c+ru6bUh0lD5NBGGIrO87Jv
 8GHMOy5JtSAwG/QFFOKf2ykzWor46FldPLNUg4S1wUbkFSIYsOV7x0lsG
 rwgoe2Gb9HJ5MIUCuLo4Xfn6k9UdJU3KHIwGW5xk9nJx6DKuP2tXCHjEw
 z+a8gdAUE6xTKKs4Jjr5iYfnQTtbQ4NveDryAz/xZeUPAlvxCjfcPsjoJ g==;
X-CSE-ConnectionGUID: 76dDk/nkQSWX9waplNIO4g==
X-CSE-MsgGUID: uNWP6dFtQ3SWYjkQRXw6oQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994222"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994222"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:26 -0700
X-CSE-ConnectionGUID: 8qQ1aQAwRGODSSZ+ui4pQg==
X-CSE-MsgGUID: 9ZBqyuXsR06wHAM0pFaxSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683818"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in error
 path
Date: Wed, 22 May 2024 12:40:15 +0800
Message-Id: <20240522044015.412951-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When get name failed, we should call unrealize() so that
vfio_ccw_realize() is self contained.

Fixes: 909a6254eda ("vfio/ccw: Make vfio cdev pre-openable by passing a file handle")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 168c9e5973..161704cd7b 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -589,7 +589,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vfio_device_get_name(vbasedev, errp)) {
-        return;
+        goto out_unrealize;
     }
 
     if (!vfio_attach_device(cdev->mdevid, vbasedev,
@@ -633,6 +633,7 @@ out_region_err:
     vfio_detach_device(vbasedev);
 out_attach_dev_err:
     g_free(vbasedev->name);
+out_unrealize:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
     }
-- 
2.34.1


