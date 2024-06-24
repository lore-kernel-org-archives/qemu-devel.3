Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F02EC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfjS-0007y2-J3; Mon, 24 Jun 2024 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjQ-0007x6-Kw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjE-0003se-OF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZCWoghW6mfWaxFSn5bGpDr/y6Xavj3Z3HJ9b2fqrd0=;
 b=F3Nlduz2akdcC1P2A9T52a2ljoFku65ZuPrPiOaUXoLL0QAmVcFdNbNBxxI11h0/x8Rn3E
 xv382IuAco9/I8WExHtREO65TtzDB4dSvbhWYb4sLmPx+jXp9FixDQ75sA/7PfRsTqVF0N
 LDUvHDuCIZa8qSGFnIJAGQDVvr4/Vpc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-2uKoE2kGP_yokzTOi95mTQ-1; Mon,
 24 Jun 2024 05:11:06 -0400
X-MC-Unique: 2uKoE2kGP_yokzTOi95mTQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7D1D19560A3; Mon, 24 Jun 2024 09:11:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98EA53000219; Mon, 24 Jun 2024 09:11:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/11] vfio/ccw: Use the 'Error **errp' argument of
 vfio_ccw_realize()
Date: Mon, 24 Jun 2024 11:10:37 +0200
Message-ID: <20240624091043.177484-6-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

The local error variable is kept for vfio_ccw_register_irq_notifier()
because it is not considered as a failing condition. We will change
how error reporting is done in following changes.

Remove the error_propagate() call.

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240522170107.289532-6-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/ccw.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9a8e052711..a468fa2342 100644
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
2.45.2


