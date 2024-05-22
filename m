Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDDDC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doZ-0001QB-G6; Wed, 22 May 2024 00:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doX-0001PY-T7; Wed, 22 May 2024 00:42:57 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doW-0005u5-9G; Wed, 22 May 2024 00:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352977; x=1747888977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tozqz6eV0xU3+zpVgG2ovdlclK14n3ngNUd3Q6FA2xM=;
 b=m/cRoheGfPmOTTUMb0WWPwtt/3wFSS0U8mMzFsAb+2G2rJpFa53CTKvW
 WhIN3y5N5Qgp/FSUq48xXdsY5vd0p8U2QrUCXNtRq96v4QjOFgezIlrcK
 /1LnO9uj7zN+2FLUFB2vaCewk4VUSGp19t1gsmRB5cpdt6j5YE3lfmrZ4
 POcVWKuUi5kPjT13CBRWvRFtuOPNlB4kol5e46+X9IOuvS2x7b1OdZYCW
 o2GH6FDXpg4/P0yrWP6/N7AJYnJVJRITdHBJa5Z/J+/4TDkmoGcqWd1dG
 dVQ3feEAUx44wm6Y6EIdMWAmNr0+2fwMrA6RFJyMYH+za0pBLPi3VImzs w==;
X-CSE-ConnectionGUID: w70PTAvuSGC6vDbd7lT54g==
X-CSE-MsgGUID: GktIPAp8SXquJiqZI9dxdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994142"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994142"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:55 -0700
X-CSE-ConnectionGUID: 2OrjmukBQsOXBPFcuHL9HQ==
X-CSE-MsgGUID: GRdHtx3ATNCBkM6SDszd6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683707"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH v2 07/20] vfio/ccw: Make vfio_ccw_get_region() return a bool
Date: Wed, 22 May 2024 12:40:02 +0800
Message-Id: <20240522044015.412951-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since vfio_populate_device() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8850ca17c8..2600e62e37 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -474,7 +474,7 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
     event_notifier_cleanup(notifier);
 }
 
-static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
+static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
     struct vfio_region_info *info;
@@ -483,7 +483,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
     /* Sanity check device */
     if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
         error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
-        return;
+        return false;
     }
 
     /*
@@ -493,13 +493,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
     if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "vfio: too few regions (%u), expected at least %u",
                    vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
-        return;
+        return false;
     }
 
     ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
     if (ret) {
         error_setg_errno(errp, -ret, "vfio: Error getting config info");
-        return;
+        return false;
     }
 
     vcdev->io_region_size = info->size;
@@ -553,7 +553,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         g_free(info);
     }
 
-    return;
+    return true;
 
 out_err:
     g_free(vcdev->crw_region);
@@ -561,7 +561,7 @@ out_err:
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
     g_free(info);
-    return;
+    return false;
 }
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
@@ -597,8 +597,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_attach_dev_err;
     }
 
-    vfio_ccw_get_region(vcdev, &err);
-    if (err) {
+    if (!vfio_ccw_get_region(vcdev, &err)) {
         goto out_region_err;
     }
 
-- 
2.34.1


