Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE130C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4A9-0002AY-ER; Tue, 11 Mar 2025 14:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47W-00079k-Rq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47M-0006iy-1M
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0+dW0t1gfW4iu9l/geeuyCvsAMnYny4vxyiLS4xO3M=;
 b=UqH1PP1SbLt/4mwKILXKW7If04yMRtx6tvUSBGlqLRbuAx72EEds5i+u/R42a9xBXRe0kc
 Ep2hhmkXA8mGYRn3OxPUrs3xTJ8ORRjTlq4K7sS4UfdhiMuKBHrnrgjI4xiCSJqN0azwKC
 4qzcqcHihNFsdonGMbbJW4p3PQChEGE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-7BAL_tMBN7CTV3nI_9aJFA-1; Tue,
 11 Mar 2025 14:13:59 -0400
X-MC-Unique: 7BAL_tMBN7CTV3nI_9aJFA-1
X-Mimecast-MFC-AGG-ID: 7BAL_tMBN7CTV3nI_9aJFA_1741716838
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC37F1956048; Tue, 11 Mar 2025 18:13:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C238A18001F6; Tue, 11 Mar 2025 18:13:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/21] vfio/igd: Fix broken KVMGT OpRegion support
Date: Tue, 11 Mar 2025 19:13:17 +0100
Message-ID: <20250311181328.1200431-11-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
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

From: Tomita Moeko <tomitamoeko@gmail.com>

The KVMGT/GVT-g vGPU also exposes OpRegion. But unlike IGD passthrough,
it only needs the OpRegion quirk. A previous change moved x-igd-opregion
handling to config quirk breaks KVMGT functionality as it brings extra
checks and applied other quirks. Here we check if the device is mdev
(KVMGT) or not (passthrough), and then applies corresponding quirks.

As before, users must manually specify x-igd-opregion=on to enable it
on KVMGT devices. In the future, we may check the VID/DID and enable
OpRegion automatically.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-11-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8a88dbab13ede764d0610a043132a3acfe208134..265fffc2aa52d032ba619b1c3759ecebad438033 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -481,7 +481,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     int ret, gen;
     uint64_t gms_size;
@@ -655,3 +655,28 @@ error:
     error_propagate(errp, err);
     return false;
 }
+
+/*
+ * KVMGT/GVT-g vGPU exposes an emulated OpRegion. So far, users have to specify
+ * x-igd-opregion=on to enable the access.
+ * TODO: Check VID/DID and enable opregion access automatically
+ */
+static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
+        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    /* KVMGT/GVT-g vGPU is exposed as mdev */
+    if (vdev->vbasedev.mdev) {
+        return vfio_pci_kvmgt_config_quirk(vdev, errp);
+    }
+
+    return vfio_pci_igd_config_quirk(vdev, errp);
+}
-- 
2.48.1


