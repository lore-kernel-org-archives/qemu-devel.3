Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E3C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bv-0006aI-Sa; Thu, 05 Jun 2025 04:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bq-0006YL-Pv
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bn-0008Es-RH
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4Wdr37b3J8t6NXfTIrly27lZXfIDpYC3kV5BPKN79s=;
 b=euTaKEqcVvmDjHrMui/Zwm5SqvVIB4Y2qyVb0lB3epavgIwK2UAZr2oBKDrJvBvo6wBTwu
 MXlDmjc5ea7xwMLYiZwjlPpHvsDEjok7trKMDS21peaztkkoL40xUIsnwEmcsQAWqSD5dz
 GVHUPzlcsD7aVa7250xw+57CQJndatk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-jQeqZMBkPm-ywixcbcg7lg-1; Thu,
 05 Jun 2025 04:43:03 -0400
X-MC-Unique: jQeqZMBkPm-ywixcbcg7lg-1
X-Mimecast-MFC-AGG-ID: jQeqZMBkPm-ywixcbcg7lg_1749112982
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0F5E18002B2; Thu,  5 Jun 2025 08:43:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C71A71954B33; Thu,  5 Jun 2025 08:43:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/16] vfio: refactor out IRQ signalling setup
Date: Thu,  5 Jun 2025 10:42:34 +0200
Message-ID: <20250605084245.1520562-6-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

This makes for a slightly more readable vfio_msix_vector_do_use()
implementation, and we will rely on this shortly.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250520150419.2172078-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a873f82aeb355cfef68033e43b4829f64145d606..b1250d85bf0124a22e3ba3859a47d2b176ade648 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -511,6 +511,25 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
+                               unsigned int nr)
+{
+    Error *err = NULL;
+    int32_t fd;
+
+    if (vector->virq >= 0) {
+        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+    } else {
+        fd = event_notifier_get_fd(&vector->interrupt);
+    }
+
+    if (!vfio_device_irq_set_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER,
+                                       fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
@@ -583,21 +602,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                              strerror(-ret));
             }
         } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
-            } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_device_irq_set_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-            }
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
-- 
2.49.0


