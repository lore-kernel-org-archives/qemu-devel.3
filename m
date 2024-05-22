Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DD0C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dp7-0001Zs-Ax; Wed, 22 May 2024 00:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp5-0001ZT-6M
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:31 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp3-0005wI-Fk
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353010; x=1747889010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dn6e14o4vAD81Eqr3Acm7f/diTt8zZe65YgDglDEtUs=;
 b=TibGnC3Sy/ObPNrbKaeGvCsWNfLVIWXQvZlvRV8QGWmf0Vw043HdioNj
 QOwGfA6KndNlxI7GQJjhvWiHx5XSgrXldoS3fVZfkDYTgObjNfXlDoDEe
 Cme8gjmMAF0M98PvlbVqLgZKS0GCvXmOfBiJK9rMK80aXAsZ5yFR7kEtP
 NUhoj9wJWSjww8qk/dkYQOm/zX0FpODqUqY7Hwg23r2YJdyTZccEMNB3A
 hacbaKuBKkNZKQmsqalUAR4I3NBYHys8YfHyZKx/Fsg7nvmFkOKYAa2Nd
 rKgVDYeyd2JS47CvSYG9+0PB3mCUu0m8I0Ke6Mk8sxCpzqcmYLDM97/KI Q==;
X-CSE-ConnectionGUID: pz+1dr53RXmIk+N85VdM4w==
X-CSE-MsgGUID: 57WWA//HThKSF9J+EFDwmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994196"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994196"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:13 -0700
X-CSE-ConnectionGUID: Cgya3eysSHCqT2AG/rtg5g==
X-CSE-MsgGUID: ktb9ao4eRJu8hV5bOizDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683773"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 15/20] vfio/pci-quirks: Make vfio_pci_igd_opregion_init()
 return bool
Date: Wed, 22 May 2024 12:40:10 +0800
Message-Id: <20240522044015.412951-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        | 6 +++---
 hw/vfio/igd.c        | 3 +--
 hw/vfio/pci-quirks.c | 8 ++++----
 hw/vfio/pci.c        | 3 +--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7914f019d5..f158681072 100644
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
index ffe57c5954..402fc5ce1d 100644
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
index 496fd1ee86..ca27917159 100644
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
index 8379d2284a..76a3931dba 100644
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
2.34.1


