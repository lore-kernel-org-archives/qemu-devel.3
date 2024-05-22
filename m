Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75093C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihX-0005aU-Hk; Wed, 22 May 2024 05:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihR-0004xl-Vj
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihQ-0001tl-BB
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3A+EghA+9cMUObGB+bwhp8bYWIKjsA69gpm6h6H9oo=;
 b=WtpaiktO3gHyK+vzTSeMhWlWMcFIsJmTIJpD5/TwTdTUlqRzVJ/bW8MH93Ox2IuOO9dOYC
 Gc9YIikWQVBFtwgpiee4PiIkanfIutig8/EfDAVYgf2m47tEp6Lw8MyBbRm2+ue5y6q2aH
 SY7OlOBUqNLrzJ93XIMTBwWhtCvIRag=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-eocvhGdLPLCt9UWwp_iT5Q-1; Wed, 22 May 2024 05:55:52 -0400
X-MC-Unique: eocvhGdLPLCt9UWwp_iT5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCFAC81227E;
 Wed, 22 May 2024 09:55:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B95417412;
 Wed, 22 May 2024 09:55:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/47] vfio/pci-quirks: Make vfio_pci_igd_opregion_init()
 return bool
Date: Wed, 22 May 2024 11:54:39 +0200
Message-ID: <20240522095442.195243-45-clg@redhat.com>
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        | 6 +++---
 hw/vfio/igd.c        | 3 +--
 hw/vfio/pci-quirks.c | 8 ++++----
 hw/vfio/pci.c        | 3 +--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7914f019d5ed563ae7b60be17033aedacaaa00ff..f1586810726584ecfc35ef685646faacabefbec0 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -227,9 +227,9 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                               struct vfio_region_info *info,
-                               Error **errp);
+bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
+                                struct vfio_region_info *info,
+                                Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ffe57c5954e5d05a57a66b2a3f0cc44fef508126..402fc5ce1da966fda1340f328e0611cb1a2a0635 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -502,8 +502,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Setup OpRegion access */
-    ret = vfio_pci_igd_opregion_init(vdev, opregion, &err);
-    if (ret) {
+    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         goto out;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 496fd1ee86bd2d53bf094860e330f4f0a5081365..ca27917159785f760f688c8db0a9ac492080d74b 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1169,8 +1169,8 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  * the table and to write the base address of that memory to the ASLS register
  * of the IGD device.
  */
-int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                               struct vfio_region_info *info, Error **errp)
+bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
+                                struct vfio_region_info *info, Error **errp)
 {
     int ret;
 
@@ -1181,7 +1181,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
         error_setg(errp, "failed to read IGD OpRegion");
         g_free(vdev->igd_opregion);
         vdev->igd_opregion = NULL;
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -1206,7 +1206,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
     pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
-    return 0;
+    return true;
 }
 
 /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8379d2284a20bed0c0bd24e46bbb39e321dc9767..76a3931dba1da1a638ae574825fe9dfe1390b21f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3161,8 +3161,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             goto out_teardown;
         }
 
-        ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
-        if (ret) {
+        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
             goto out_teardown;
         }
     }
-- 
2.45.1


