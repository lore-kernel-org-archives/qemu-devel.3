Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAAAC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pLM-0000TW-Ih; Wed, 22 May 2024 13:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLJ-0000R1-UP
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9pLA-0006H7-My
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716397284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66Bm2P/DmlIK9VNORtEOlS10BkUqgh5w4G4kzZgH418=;
 b=g/H5j2EwGdJXemSAG7IIAdceSF+J382z/vgij0/ag10DIFoe191H8QH14As2K0GvIZkG4K
 AcMtgNYxGr6SeRwFw8bOEb7af4KnEvu9S9pGUYwQiJR5GepirPGLwobqBtcdGSORWAGTje
 AzWiDwySw9k8uVi43d703zlTvqahzxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-n28t7gNEMwS6hPueYTB_yQ-1; Wed, 22 May 2024 13:01:19 -0400
X-MC-Unique: n28t7gNEMwS6hPueYTB_yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FCD4185A783;
 Wed, 22 May 2024 17:01:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8151561A;
 Wed, 22 May 2024 17:01:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/7] vfio/ccw: Use the 'Error **errp' argument of
 vfio_ccw_realize()
Date: Wed, 22 May 2024 19:01:05 +0200
Message-ID: <20240522170107.289532-6-clg@redhat.com>
In-Reply-To: <20240522170107.289532-1-clg@redhat.com>
References: <20240522170107.289532-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

The local error variable is kept for vfio_ccw_register_irq_notifier()
because it is not considered as a failing condition. We will change
how error reporting is done in following changes.

Remove the error_propagate() call.

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9a8e052711fe2f7c067c52808b2af30d0ebfee0c..a468fa2342b97e0ee36bd5fb8443025cc90a0453 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -582,8 +582,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
-        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, &err)) {
-            goto out_err_propagate;
+        if (!cdc->realize(cdev, vcdev->vdev.sysfsdev, errp)) {
+            return;
         }
     }
 
@@ -596,17 +596,17 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
@@ -634,8 +634,6 @@ out_attach_dev_err:
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
     }
-out_err_propagate:
-    error_propagate(errp, err);
 }
 
 static void vfio_ccw_unrealize(DeviceState *dev)
-- 
2.45.1


