Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB85C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihJ-000437-GF; Wed, 22 May 2024 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihG-0003pz-R8
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihD-0001ll-L4
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOI4wBHXF1so/a94L2k2ZhYao0kW/v+zFhWWTorCMZE=;
 b=WYhr/OxLQJs/GDvUZ+vjvj2DYLIDPW1CC2rbiyUX/Rx5eLgveB+PZO+i409+0MZHhLPRG+
 NXiZ4jBy6CR6A4CZOdnaH16epoHTo9LZj7AHEyg0hr4RoAG5Asoct70roGpyfnDyvUYpOm
 bBuRFofyrBm4O02SGYDkieocMla7Aas=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Kcr5uj7nMKeYRYWO1sE8eQ-1; Wed,
 22 May 2024 05:55:41 -0400
X-MC-Unique: Kcr5uj7nMKeYRYWO1sE8eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D223C025D2;
 Wed, 22 May 2024 09:55:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE46228E2;
 Wed, 22 May 2024 09:55:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/47] vfio/ccw: Make vfio_ccw_get_region() return a bool
Date: Wed, 22 May 2024 11:54:31 +0200
Message-ID: <20240522095442.195243-37-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Since vfio_populate_device() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8850ca17c84632d278e27819cd52e104ed436d6c..2600e62e37238779800dc2b3a0bd315d7633017b 100644
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
2.45.1


