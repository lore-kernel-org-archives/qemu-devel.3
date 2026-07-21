Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B032C44534
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5ge-0000sq-D7; Tue, 21 Jul 2026 04:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5ga-0000m5-ES; Tue, 21 Jul 2026 04:18:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5gU-0001Zb-Vl; Tue, 21 Jul 2026 04:18:44 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsBs050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=B44uFrmxRfhYGb5k8pU6lVLkvRUw3cNMaPCaQQlmDFM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621855; v=1;
 b=MGaY1UmFW4a3EqUPL77YF0HC8OAqs90vJVI4YdAnv3Dcjr5cN5jP3dJfQX6jM1Iq
 ae2+ynTwGo/CW4d2qJgNif1wgMDuxcAzXI7mZhrhwEWpedV0SKuB5igX9f7s08WA
 2aTRMgG99YZl+saKkwH4eRL2+BHdyrQ154zyBV4Q1RkDCDvakx/OonoKXcRPo6qx
 xq5GxK7R/uMAFA+i15IeRowb2kEC13yUtZXoJu6n+X8+xXaOCPQB/uuK+J4/04cw
 xhj0Guce5wQ+GsPUZTX1rKNOJnP6r+22oG+awvEXLmSErGG9B0l6EItloLXuk3FY
 Zthhp0GbnZdNvC9XzSvd9g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Jul 2026 17:16:59 +0900
Subject: [PATCH for-11.2 v3 09/15] hw/vfio: Use qdev_is_realized()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-qdev-v3-9-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=dW/+Mp6HznhHde/NuhrAUCtUJzM3vwYiHzzfCC/pIMA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8tnh4urju2mWLq5m9/yZHPq49tUNn/quEmhdvVL5nf
 vd2kDPtKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEj4EUaGPrHwQtfrX+bs+771
 vvi+UyGNXhJXm7sFLQIPc145UdD5hZFhavHHpZ8WdLVzfulMYo7i5nSJ/KStey6VT+honO7q8Me
 8AA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/vfio/container-legacy.c | 4 ++--
 hw/vfio/device.c           | 4 ++--
 hw/vfio/iommufd.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index d301b27aa652..7ac7b3721458 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -1075,7 +1075,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
 
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
+            if (!qdev_is_realized(vbasedev_iter->dev) ||
                 !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
@@ -1160,7 +1160,7 @@ out:
         }
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
-            if (!vbasedev_iter->dev->realized ||
+            if (!qdev_is_realized(vbasedev_iter->dev) ||
                 !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 1a7f8088aad9..4f119596336f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -59,13 +59,13 @@ void vfio_device_reset_handler(void *opaque)
 
     trace_vfio_device_reset_handler();
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized) {
+        if (qdev_is_realized(vbasedev->dev)) {
             vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
     QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+        if (qdev_is_realized(vbasedev->dev) && vbasedev->needs_reset) {
             vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6ff668d2597e..242644aa0010 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -829,7 +829,7 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
 
     vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
     if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
-        !vbasedev_tmp->dev->realized) {
+        !qdev_is_realized(vbasedev_tmp->dev)) {
         return NULL;
     }
 

-- 
2.55.0


