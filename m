Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54903C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dpb-0003DH-47; Wed, 22 May 2024 00:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpU-0002z9-FR; Wed, 22 May 2024 00:43:56 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpS-0005wM-Q4; Wed, 22 May 2024 00:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353034; x=1747889034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xmbGRIz1xb4wMoX4jBHY9Ji8BqoSSIVbjok4WXnrOz4=;
 b=MyToYGtWa8/o0S0rMvKje+vly4Y2VZUPGQ5TBp68S1ZNEfJZCEFLASLJ
 KM7pXPPMxONR8+zJh2F1p0vnp6BfFHz5rnvnCg1W/rkk45GFU/Vtlg/52
 /x25kFX0uE8uFMOxDzNxO3Nne8exfK+UKjGjDdSxjsxBiU2Pd5nkCmy6C
 /umb8QjD8QBODxRNbXVdsk1zQqwuG+hF80E+VBBVRjg7rg4uP9Nr/g46Z
 /3iGsDJD9KiigkJeba8Kd0PKNwg7LekRtFqPV3ZB6ubqgt1jtBXWukL5b
 E1FXERzJ5v59AHNyvp2oCKteQpE7HLMh0Spv0zYZamz9wC6B+THSFNFq6 Q==;
X-CSE-ConnectionGUID: cMH0IS8WSx6DWuBlv47T5w==
X-CSE-MsgGUID: NcP09iLKTtuYd76ifCqHMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994218"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994218"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:23 -0700
X-CSE-ConnectionGUID: B4s/Lw4VRnivmw6/JJC7WA==
X-CSE-MsgGUID: 33i6URHjRBu+rVmJ3Qwk6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683809"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH v2 19/20] vfio/ccw: Drop local @err in vfio_ccw_realize()
Date: Wed, 22 May 2024 12:40:14 +0800
Message-Id: <20240522044015.412951-20-zhenzhong.duan@intel.com>
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

Use @errp to fetch error information directly and drop the local
variable @err.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2600e62e37..168c9e5973 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -574,17 +574,17 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
     VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIODevice *vbasedev = &vcdev->vdev;
-    Error *err = NULL;
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
-        cdc->realize(cdev, vcdev->vdev.sysfsdev, &err);
-        if (err) {
-            goto out_err_propagate;
+        cdc->realize(cdev, vcdev->vdev.sysfsdev, errp);
+        if (*errp) {
+            return;
         }
     }
 
@@ -597,27 +597,28 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_attach_dev_err;
     }
 
-    if (!vfio_ccw_get_region(vcdev, &err)) {
+    if (!vfio_ccw_get_region(vcdev, errp)) {
         goto out_region_err;
     }
 
-    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err)) {
+    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, errp)) {
         goto out_io_notifier_err;
     }
 
     if (vcdev->crw_region) {
         if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX,
-                                            &err)) {
+                                            errp)) {
             goto out_irq_notifier_err;
         }
     }
 
-    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &err)) {
+    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, errp)) {
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
          */
-        error_report_err(err);
+        error_report_err(*errp);
+        *errp = NULL;
     }
 
     return;
@@ -635,8 +636,6 @@ out_attach_dev_err:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
     }
-out_err_propagate:
-    error_propagate(errp, err);
 }
 
 static void vfio_ccw_unrealize(DeviceState *dev)
-- 
2.34.1


