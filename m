Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094AFC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihQ-0004rJ-R1; Wed, 22 May 2024 05:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihM-0004OD-NU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihK-0001nu-PR
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q2GVlx4T78UrS5NSTaGqL+rb9an85n4nQ6EqCCzH1hk=;
 b=QOOj2prgNKO1DkJBLy1M+QLxK3tTxDKMr5Z36Q0vA2XtJ7JMgNdQrjcpfDEBbP++sbWGAS
 LIs6ebUhAm4ebA1z/UbVkwUBk9wVW50BluSA43BCvRq2DkWRMTy8Grj1u7oGd15xM7aCvH
 sP47RT3TWTLctWdFQqr8OZK+SfcG7zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-7GoPZ7bANgaC_vW9ap0ePg-1; Wed, 22 May 2024 05:55:48 -0400
X-MC-Unique: 7GoPZ7bANgaC_vW9ap0ePg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C31018029EB;
 Wed, 22 May 2024 09:55:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A19BB28E3;
 Wed, 22 May 2024 09:55:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 41/47] vfio/pci: Make vfio_populate_vga() return bool
Date: Wed, 22 May 2024 11:54:36 +0200
Message-ID: <20240522095442.195243-42-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  2 +-
 hw/vfio/igd.c |  2 +-
 hw/vfio/pci.c | 11 +++++------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a5ac9efd4bb6d4070cac02f3eeb156d1018cd20f..7914f019d5ed563ae7b60be17033aedacaaa00ff 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -225,7 +225,7 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
-int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b31ee79c60b5e567f84f561cfb63849960648340..ffe57c5954e5d05a57a66b2a3f0cc44fef508126 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,7 +478,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * try to enable it.  Probably shouldn't be using legacy mode without VGA,
      * but also no point in us enabling VGA if disabled in hardware.
      */
-    if (!(gmch & 0x2) && !vdev->vga && vfio_populate_vga(vdev, &err)) {
+    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f35cb8a29176840412652afe5ab31cd52a1bf06..ab8f74299eab85e224a02f45d4b506e860b514f9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2670,7 +2670,7 @@ static VFIODeviceOps vfio_pci_ops = {
     .vfio_load_config = vfio_pci_load_config,
 };
 
-int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info;
@@ -2681,7 +2681,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
         error_setg_errno(errp, -ret,
                          "failed getting region info for VGA region index %d",
                          VFIO_PCI_VGA_REGION_INDEX);
-        return ret;
+        return false;
     }
 
     if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
@@ -2691,7 +2691,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                    (unsigned long)reg_info->flags,
                    (unsigned long)reg_info->size);
         g_free(reg_info);
-        return -EINVAL;
+        return false;
     }
 
     vdev->vga = g_new0(VFIOVGA, 1);
@@ -2735,7 +2735,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                      &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
 
-    return 0;
+    return true;
 }
 
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
@@ -2798,8 +2798,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     g_free(reg_info);
 
     if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
-        ret = vfio_populate_vga(vdev, errp);
-        if (ret) {
+        if (!vfio_populate_vga(vdev, errp)) {
             error_append_hint(errp, "device does not support "
                               "requested feature x-vga\n");
             return false;
-- 
2.45.1


