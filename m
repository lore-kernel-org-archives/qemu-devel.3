Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDAC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zK-0002op-VU; Mon, 03 Mar 2025 12:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y5-0001Yg-NO
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:45 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y3-0000J9-B5
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:41 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-223959039f4so37462555ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024355; x=1741629155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mvd2byRBLj1EWurRow3kwEAQYrHkAuspw1kE35aVtA8=;
 b=VDAmKuNOpzN/vJn2ayzVCQ88IcFj2JcXtGGr4INrMZCQdmrHfHw+pheAJx7mW8/Ulb
 du8io2ChfASk0xDX9xynewaQNa9LqwGCYzLbb8t/MH5HZf5/Udn6QGYDWEmc867eWctZ
 FTzsVKzZ036FKNpkWmR8BI9P0HltW8j6XnpluWhmzOkDmk5Fi0q0kMHxNGpMtRoJcbyd
 QpUzV5JhXs2GS32aWstqlIesL6WNdC/jBXZrhC5LiczP6v5cODyfQ71COrf9JdV0b549
 NwXq9k3GF1FIm3rlpmyqYu+HCwjBjL6/vUQ1TEfOomm3J0yaPqpIbZHYHoajd98L/1t/
 V5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024355; x=1741629155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mvd2byRBLj1EWurRow3kwEAQYrHkAuspw1kE35aVtA8=;
 b=EQ+V96d5LJvgf6hlrjkfbqppDierW2q1X8C1nl7Q39BOd31D1kbtFzTAq22Sliiv/4
 K47powPK88JdMpwkIkpZR/IxMlw3jQchHjEOAMgIUNFt5IaLSG7qIlVQwBqxpJn8mDUs
 Ybm+GljoRncPDssw75qFe6P/wM4Bf1IpXX3OIur6iGysh/eKu6knzv15aNKm0bTuf+P4
 aGhgNx9cpx9Cz4slxIpclE0LUf7QFH5Gpxi4IaBOU3A/CB6TIbk3RcAaOrtkv2LUvpsc
 dCeVeYuwEx2T/VS9QuVD2uJdNEzHzgAQwEPZs6SoR2hqkd73zOMuzdCfSY9EVGAOffL3
 wpUw==
X-Gm-Message-State: AOJu0Yx2dspGfq9CmtlsFruiS+YQJsbmWFOVNi5VRf3IxFOcHdIIFA32
 gV2H76A9/8VeU51Wc+97W4PrN+mtiTmAcz5gTfBcC/0SxSQ2IrAfmutsit6ylA==
X-Gm-Gg: ASbGncuwUAq5N2o6fGP09DKkcsGaGoeKvCgMBp1mCGyubNcaOAWJLH0hUbpB4RJaDTr
 MdekuWQjmJD64jd0BtuI5N5so7e/UN8JQ2U+r6VdK+HkLUb8A7APxvFC9dbcCb7boAzRjrj+86v
 RQH4OZ9eNPcK5U6R5nO4H4fVRIlj0lWIZD4oSbFXxpHPvdF60DFwFvbFmka0NY7nQb/Z3u0zkx0
 AjnDlSI3rXa0UkxQXIkti+ziPfO+PFlHEcALaBTB2R1v9EBMdvoAOLgigzyVben2qg6dA/c3JWM
 IHQsb56pu/C/OSwBUnIak+XMHCnz0lWH04xfqS20uPXgrhs/tfAKMwRHiw==
X-Google-Smtp-Source: AGHT+IHzJS1tsyugZrX3KjEkCdkosAbjgjnSWifoNETh+SRLwxEZa6eyhUAm66s4d1YAjuq7ABk6NA==
X-Received: by 2002:a17:902:c951:b0:21c:1140:136c with SMTP id
 d9443c01a7336-22368f6a15cmr200767725ad.3.1741024355016; 
 Mon, 03 Mar 2025 09:52:35 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:34 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 4/9] vfio/igd: Move LPC bridge initialization to a separate
 function
Date: Tue,  4 Mar 2025 01:52:14 +0800
Message-ID: <20250303175220.74917-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

A new option will soon be introduced to decouple the LPC bridge/Host
bridge ID quirk from legacy mode. To prepare for this, move the LPC
bridge initialization into a separate function.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 122 +++++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 52 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 50e4007abe..9d2b761d1d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -351,6 +351,72 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     return ret;
 }
 
+static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
+{
+    g_autofree struct vfio_region_info *host = NULL;
+    g_autofree struct vfio_region_info *lpc = NULL;
+    PCIDevice *lpc_bridge;
+    int ret;
+
+    /*
+     * Copying IDs or creating new devices are not supported on hotplug
+     */
+    if (vdev->pdev.qdev.hotplugged) {
+        error_setg(errp, "IGD LPC is not supported on hotplugged device");
+        return false;
+    }
+
+    /*
+     * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
+     * can stuff host values into, so if there's already one there and it's not
+     * one we can hack on, this quirk is no-go.  Sorry Q35.
+     */
+    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+                                 0, PCI_DEVFN(0x1f, 0));
+    if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
+                                           "vfio-pci-igd-lpc-bridge")) {
+        error_setg(errp,
+                   "Cannot create LPC bridge due to existing device at 1f.0");
+        return false;
+    }
+
+    /*
+     * Check whether we have all the vfio device specific regions to
+     * support LPC quirk (added in Linux v4.6).
+     */
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                        VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG, &lpc);
+    if (ret) {
+        error_setg(errp, "IGD LPC bridge access is not supported by kernel");
+        return false;
+    }
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                        VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
+    if (ret) {
+        error_setg(errp, "IGD host bridge access is not supported by kernel");
+        return false;
+    }
+
+    /* Create/modify LPC bridge */
+    ret = vfio_pci_igd_lpc_init(vdev, lpc);
+    if (ret) {
+        error_setg(errp, "Failed to create/modify LPC bridge for IGD");
+        return false;
+    }
+
+    /* Stuff some host values into the VM PCI host bridge */
+    ret = vfio_pci_igd_host_init(vdev, host);
+    if (ret) {
+        error_setg(errp, "Failed to modify host bridge for IGD");
+        return false;
+    }
+
+    return true;
+}
+
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -419,9 +485,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
-    PCIDevice *lpc_bridge;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -440,20 +503,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /*
-     * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
-     * can stuff host values into, so if there's already one there and it's not
-     * one we can hack on, legacy mode is no-go.  Sorry Q35.
-     */
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                 0, PCI_DEVFN(0x1f, 0));
-    if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
-                                           "vfio-pci-igd-lpc-bridge")) {
-        error_report("IGD device %s cannot support legacy mode due to existing "
-                     "devices at address 1f.0", vdev->vbasedev.name);
-        return;
-    }
-
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -490,28 +539,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /*
-     * Check whether we have all the vfio device specific regions to
-     * support legacy mode (added in Linux v4.6).  If not, bail.
-     */
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
-    if (ret) {
-        error_report("IGD device %s does not support host bridge access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG, &lpc);
-    if (ret) {
-        error_report("IGD device %s does not support LPC bridge access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
@@ -533,19 +560,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Create our LPC/ISA bridge */
-    ret = vfio_pci_igd_lpc_init(vdev, lpc);
-    if (ret) {
-        error_report("IGD device %s failed to create LPC bridge, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
-    /* Stuff some host values into the VM PCI host bridge */
-    ret = vfio_pci_igd_host_init(vdev, host);
-    if (ret) {
-        error_report("IGD device %s failed to modify host bridge, "
-                     "legacy mode disabled", vdev->vbasedev.name);
+    /* Setup LPC bridge / Host bridge PCI IDs */
+    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
+        error_append_hint(&err, "IGD legacy mode disabled\n");
+        error_report_err(err);
         return;
     }
 
-- 
2.47.2


