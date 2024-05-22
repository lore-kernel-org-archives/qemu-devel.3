Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC6C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihU-0005Eg-VN; Wed, 22 May 2024 05:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihS-000524-Ps
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihQ-0001uG-Sm
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yanOxKaS7eId/4S/INjcbQanK+cHyaJV4bzSFLnJpok=;
 b=GoYUXaKgplB3yVXGYHr/Mo+GiFCe9PbHIWyA1Ue749nkSO6Tv+UR5MtVxBKX0JRCIPretF
 SyJW4yM0f+9dMUgi8xx4twpw2X0hd3zTyW+63HzZIL2jqwJilOv0J6EI1HRzCFglhfLA2s
 DTdKRv/sxp2Ffve1i7XwwvxkxjGQq9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-tXeuvYV7Mh21350McE-9EA-1; Wed, 22 May 2024 05:55:53 -0400
X-MC-Unique: tXeuvYV7Mh21350McE-9EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC02800CA2;
 Wed, 22 May 2024 09:55:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E83D28E2;
 Wed, 22 May 2024 09:55:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 45/47] vfio/pci-quirks: Make vfio_add_*_cap() return bool
Date: Wed, 22 May 2024 11:54:40 +0200
Message-ID: <20240522095442.195243-46-clg@redhat.com>
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

Include below functions:
vfio_add_virt_caps()
vfio_add_nv_gpudirect_cap()
vfio_add_vmd_shadow_cap()

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  2 +-
 hw/vfio/pci-quirks.c | 42 +++++++++++++++++++-----------------------
 hw/vfio/pci.c        |  3 +--
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f1586810726584ecfc35ef685646faacabefbec0..bf67df2fbc09b3d0fd97d25dfaa5290ab33b03ea 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -212,7 +212,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index ca27917159785f760f688c8db0a9ac492080d74b..39dae72497e0315eeb580dbcd5255c58bc38c8ed 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1536,7 +1536,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
             pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
 }
 
-static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
     PCIDevice *pdev = &vdev->pdev;
@@ -1545,18 +1545,18 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     uint8_t tmp;
 
     if (vdev->nv_gpudirect_clique == 0xFF) {
-        return 0;
+        return true;
     }
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid device vendor");
-        return -EINVAL;
+        return false;
     }
 
     if (pci_get_byte(pdev->config + PCI_CLASS_DEVICE + 1) !=
         PCI_BASE_CLASS_DISPLAY) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: unsupported PCI class");
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -1572,7 +1572,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
                 vdev->config_offset + PCI_CAPABILITY_LIST);
     if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
-        return -EINVAL;
+        return false;
     }
 
     do {
@@ -1590,13 +1590,13 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
         pos = 0xD4;
     } else {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
-        return -EINVAL;
+        return false;
     }
 
     ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
-        return ret;
+        return false;
     }
 
     memset(vdev->emulated_config_bits + pos, 0xFF, 8);
@@ -1608,7 +1608,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     pci_set_byte(pdev->config + pos++, vdev->nv_gpudirect_clique << 3);
     pci_set_byte(pdev->config + pos, 0);
 
-    return 0;
+    return true;
 }
 
 /*
@@ -1629,7 +1629,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
  */
 #define VMD_SHADOW_CAP_VER 1
 #define VMD_SHADOW_CAP_LEN 24
-static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
     uint8_t membar_phys[16];
@@ -1639,7 +1639,7 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x467F) ||
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x4C3D) ||
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x9A0B))) {
-        return 0;
+        return true;
     }
 
     ret = pread(vdev->vbasedev.fd, membar_phys, 16,
@@ -1647,14 +1647,14 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
     if (ret != 16) {
         error_report("VMD %s cannot read MEMBARs (%d)",
                      vdev->vbasedev.name, ret);
-        return -EFAULT;
+        return false;
     }
 
     ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
                              VMD_SHADOW_CAP_LEN, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
-        return ret;
+        return false;
     }
 
     memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
@@ -1664,22 +1664,18 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
     pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
     memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
 
-    return 0;
+    return true;
 }
 
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 {
-    int ret;
-
-    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_add_nv_gpudirect_cap(vdev, errp)) {
+        return false;
     }
 
-    ret = vfio_add_vmd_shadow_cap(vdev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_add_vmd_shadow_cap(vdev, errp)) {
+        return false;
     }
 
-    return 0;
+    return true;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 76a3931dba1da1a638ae574825fe9dfe1390b21f..35ad9b582f6b99510a812edab5c2855c697a1da2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2194,8 +2194,7 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         vdev->emulated_config_bits[PCI_CAPABILITY_LIST] = 0xff;
         vdev->emulated_config_bits[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
 
-        ret = vfio_add_virt_caps(vdev, errp);
-        if (ret) {
+        if (!vfio_add_virt_caps(vdev, errp)) {
             return false;
         }
     }
-- 
2.45.1


