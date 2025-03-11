Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A0C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts476-0006lX-3M; Tue, 11 Mar 2025 14:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts473-0006jC-3D
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts470-0006fx-58
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrgBFMyu2+Qv9boswWCyCyHftGQhvmSk00T36toUyTQ=;
 b=caQqszzjIJmK7P3EdS65f/9b8rCVbH+S4kQVY9vvOzGAs/7cOnndRUI/2RXWG4i3jw3Mfx
 ZFO0FnapvG2TZZlJ7B461J8mFe7PjPg+DMhVCdftb5Ok5aTXtqi5jGpX+KdxK6GnAM+gjI
 do2qbKLOde/HKV65lzCenAuygoD8Nj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-tWSN57FXPTuPkFmkWDAZ3Q-1; Tue,
 11 Mar 2025 14:13:47 -0400
X-MC-Unique: tWSN57FXPTuPkFmkWDAZ3Q-1
X-Mimecast-MFC-AGG-ID: tWSN57FXPTuPkFmkWDAZ3Q_1741716826
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD871801A07; Tue, 11 Mar 2025 18:13:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C65691828A96; Tue, 11 Mar 2025 18:13:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/21] vfio/pci: Add placeholder for device-specific config
 space quirks
Date: Tue, 11 Mar 2025 19:13:12 +0100
Message-ID: <20250311181328.1200431-6-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

IGD devices require device-specific quirk to be applied to their PCI
config space. Currently, it is put in the BAR4 quirk that does nothing
to BAR4 itself. Add a placeholder for PCI config space quirks to hold
that quirk later.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-6-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        | 1 +
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci.c        | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f660b0d80fcfcb81129d443732fe887b084d7a52..d125e738655a43ec01348b784af90f7e121bd695 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -204,6 +204,7 @@ uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_exit(VFIOPCIDevice *vdev);
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 37966e17f0178bbf2d82b2d84da40ba2e261d9f3..78aef7d60eff7f8e776c030942439523b2197ded 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1117,6 +1117,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
 /*
  * Common quirk probe entry points.
  */
+bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
+
 void vfio_vga_quirk_setup(VFIOPCIDevice *vdev)
 {
     vfio_vga_probe_ati_3c3_quirk(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 419dc2c4c85ffeed3b794e65f8040e11ba58bb0e..ff1e720dbadc2251d76e4c71c026757e2cef1a8c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3128,6 +3128,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_unset_idev;
     }
 
+    if (!vfio_config_quirk_setup(vdev, errp)) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
-- 
2.48.1


