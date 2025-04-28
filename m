Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCBCC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R5t-0003gj-Qj; Mon, 28 Apr 2025 12:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R49-0002BL-53
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:54 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3y-0008PO-CS
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-22c33e5013aso60109005ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856630; x=1746461430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5z/5Pn/MHMC5yQ1xd7cZlEMU1fDDg/ajH/oCS93mEs=;
 b=KOUfeaHiizzUkyXsphGcJLII/qG/qHT3UutNFuEyFA/af9JVBFPeK4wWgjPdjpeh5H
 3+KURqSdbabKgeat3+pYMjSFjoAvpNvIp5H7mawNeEJDHtj5oDgs76BC+vwxYMD+F/zQ
 0v/QQUhh31w9dvCcjAnNp5Sg1Xgusa1t96JVsMvqv7q73lxgW0cC7FrFqI0EYfl11ae+
 Hoj4SEzEyUmhP5Hz9KvW4afCG+IAgzMSPInxcX+gSEaAeDqGhqZKJWRWTX6PjbKKHW2w
 V4fpDwqosXx09PeBc9rOHo/mhMgiChFi87GAoBJdE0Ook/2++6opXOinGVh2N3uMp53s
 mmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856630; x=1746461430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5z/5Pn/MHMC5yQ1xd7cZlEMU1fDDg/ajH/oCS93mEs=;
 b=gAQUtCHgwRdhFY7PeFQCKOSfxxce8dXXzN45U8w1E2swZHCFKsNcIZhnTy50zsHcOP
 QDq9SzK8V3x467o3YCe3ORI2djsJyCD43Yx674hvXjeKcuh9GLSBMJxv3VzJLeJ3xyDO
 49sLzfnlMpJ46CE3wd9IRvFPXkP8pEkQSflzJa0oOf0Dc1GixfGK5WRJN1YHj3VuUYHA
 djlmUrVdO/C9aVCEPJeMnK134diFpv7/dXRWkTc9GVEHnZ15SgxndoYEBZu+4dJ5ZoB1
 NQsKFNkDXwR1DKwi4gWpAEGGwBygdjSjLkpTd61LbylPMDQfrmBOcFnPtP7eKFiaY4Jq
 s/Wg==
X-Gm-Message-State: AOJu0YxPCjuBa/xEloEhMLRMdyXUsNkr3ctXXVccifiaIhaiVq2W+s62
 DnF66iuWlJFDQQP1j1LY4pPsyU8KehA3ldW1NXfm83IP5w3v6SI=
X-Gm-Gg: ASbGncs6pxgq5JRRJBAvPpn/jYcYkIo9wujRw1bEqOgHONqiTAAE2D3p1CCWGq6L2Go
 SHEtg0oJOLhB3I5H/ClCpCfpsiGFc6jR1dls54PJgT7kIOz+UlYaBiHw1OLPv44f4i9G+ssR/1A
 mgn37HJLfqVFhcrxY05rpjBIA/W11Chhm9tkGMr73qa8HM0Kil85iFWSVb9oGAlk9WwG6WaB1e9
 YPy4tIqyxIZnexonoqSTYYNL3oBqjEx1Ii/lnQTRnwbMWRaqqz+yZu/GvM2h6lpDZSZUAjfmJFb
 J3vlwR5ANkL6fCJGbf0GTToaQRyp4Xe9HHpdgsRyMuXYl4/HfIIFIGpLVqhOaOR+spw=
X-Google-Smtp-Source: AGHT+IGkLldzK/oIf+6Q9o2RJOYSxFihpPBU1ofBoRRD4ecytderRXUylBMq5xZSOEngRJdUcEhNOA==
X-Received: by 2002:a17:902:ea03:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-22dc6a6c939mr148864215ad.36.1745856630174; 
 Mon, 28 Apr 2025 09:10:30 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:29 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 3/9] vfio/igd: Detect IGD device by OpRegion
Date: Tue, 29 Apr 2025 00:09:58 +0800
Message-ID: <20250428161004.35613-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428161004.35613-1-tomitamoeko@gmail.com>
References: <20250428161004.35613-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

There is currently no straightforward way to distinguish if a Intel
graphics device is IGD or discrete GPU. However, only IGD devices have
OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
to identify IGD devices. Still, OpRegion on hotplugged IGD device is
not supported.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ae19456457..d6880cbff7 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -185,9 +185,10 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
+                                         struct vfio_region_info **opregion,
+                                         Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
     int ret;
 
     /* Hotplugging is not supported for opregion access */
@@ -198,17 +199,13 @@ static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
         error_setg_errno(errp, -ret,
                          "Device does not supports IGD OpRegion feature");
         return false;
     }
 
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-        return false;
-    }
-
     return true;
 }
 
@@ -479,6 +476,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -486,16 +484,17 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     bool legacy_mode_enabled = false;
     Error *err = NULL;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
         !vfio_is_vga(vdev)) {
         return true;
     }
 
+    /* IGD device always comes with OpRegion */
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+        return true;
+    }
+    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
+
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -571,7 +570,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /* Setup OpRegion access */
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        !vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
         goto error;
     }
 
@@ -671,8 +670,11 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
+
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
+         !vfio_pci_igd_opregion_init(vdev, opregion, errp))) {
         return false;
     }
 
-- 
2.47.2


