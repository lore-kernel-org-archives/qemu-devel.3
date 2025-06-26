Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA510C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJk-0005MY-PA; Thu, 26 Jun 2025 03:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJU-0004kk-Po
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJP-0001ys-Ji
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otGVkjCf0opn+vETCAGncq2bMRafF3DOvc1cBsAO+2s=;
 b=KEpINegZEm/0xlYZKWKFrW8uJL47kG9L0Ynuc/JACWRF0weeJREv1fxks/fPvbQvSq887d
 KvLHSw1LB5ycZNVLoanCxQASsMxoYNp4S+763WO5CFRHEs8D2trWNGNdBkQsb0Wf7gli36
 L9UkMsSJEAuD394KrRpaQIN4tUatX0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-P1n4hmnePDiMmlmkC1o09g-1; Thu,
 26 Jun 2025 03:46:15 -0400
X-MC-Unique: P1n4hmnePDiMmlmkC1o09g-1
X-Mimecast-MFC-AGG-ID: P1n4hmnePDiMmlmkC1o09g_1750923974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D3A18001D1; Thu, 26 Jun 2025 07:46:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06FA3180045B; Thu, 26 Jun 2025 07:46:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/25] vfio-user: set up PCI in vfio_user_pci_realize()
Date: Thu, 26 Jun 2025 09:45:18 +0200
Message-ID: <20250626074529.1384114-15-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Re-use PCI setup functions from hw/vfio/pci.c to realize the vfio-user
PCI device.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-9-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d704e3d390c71444c9d913e38c4dc064ff1c6625..b49f42b980017d61a2676c5dd7e01a869a63ac50 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -126,10 +126,39 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_pci_populate_device(vdev, errp)) {
+        goto error;
+    }
+
+    if (!vfio_pci_config_setup(vdev, errp)) {
+        goto error;
+    }
+
+    /*
+     * vfio_pci_config_setup will have registered the device's BARs
+     * and setup any MSIX BARs, so errors after it succeeds must
+     * use out_teardown
+     */
+
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+        goto out_teardown;
+    }
+
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
+
     return;
 
+out_teardown:
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    vfio_pci_put_device(vdev);
 }
 
 static void vfio_user_instance_init(Object *obj)
-- 
2.49.0


