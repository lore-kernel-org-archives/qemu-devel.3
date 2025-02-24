Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B3C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdFC-00086I-FH; Mon, 24 Feb 2025 13:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDQ-0005oZ-S5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:05 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDK-0003O5-4G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:03 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so16485075ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421793; x=1741026593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhY1Lg5VGsGDQFWbkyrZVwx/wHZ+zRcPYDq3BO+PT9Y=;
 b=E+sG5b9Hc02ni4kazm+SpdMwX/D6ByclLMmtRDwsw/vxbR3m6ZWUIviVo44ZYukAJl
 rdavItCw1uU5HTcA7Sil8FJvCJTbWIljlEx/tN2gcgoeFkt5rE/LKatnLg7GPi3HwAdQ
 EoNpKV6FIbC+QNjeUnqRX437pG7y02MJWmTaLxqpR7e+/w3OQCO0CAauTMgnrSdhkWuM
 wOFe0ehgbAaShrT6DEWMPrZSP2itkU5yuWDc9WujUny0EcstzBKmF9X/i6AryVapekES
 FoPAg3Yr7mPbiOneGRV5CAjE2VOYHlKyPv0NkLG2OVEyGq8N8oAWHpDfsqvUaI+lLeg7
 Q4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421793; x=1741026593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhY1Lg5VGsGDQFWbkyrZVwx/wHZ+zRcPYDq3BO+PT9Y=;
 b=auS54ONoRcYprnGxpqj2VkCRNj/52Y1CDEypCHCPcwW3U+vs77aN6zRzCEoELDLXaY
 OS/qZ2r42l5jw1JsTVFqCJPv3C85ACTHT3WBI1pFlM7pDjkNSMHBPrp0HvmWPJjDUOzv
 I9jHjCGraWvccga/SpYCZbCvzj2HVKafJcrJ5zR719eg06Qo/obnUWSG0gLr+1KjJ2rJ
 uCv6YWH43fNi+r1zU1j9W1nYLk0YCSwhJwXTLdnZa4VyqHKYbRO8lcfpenHk9MXvZbwm
 knPdg0KZYhy1Z3cvbxU63JsJ7bQR5/SP3w9ro0Imu4gAThfCRaioNllf+z0D/9UoN1Ki
 icuw==
X-Gm-Message-State: AOJu0YwEUYJgH3SSgxsbquIvO8pShVfeVWzp91yQKF9OyNgqyRYt+NJq
 hFBcA6H8XdUPFpM6awMwr0Enf8kiSNs91DBSwDl5Tq5t9JB93iM=
X-Gm-Gg: ASbGnctsrk/bZgxd/nQB+i0suvF90MtgtdLHNq8yH8bRkFFlsy8BdR1XBOgvkVa+vkr
 YFEAbF8R0Ml1H6y4SI/xHChhgwNFEDSigUyyk4oJILN+k8A1K57p4uRF0CxfJoYNxb8E+P0cpGj
 g7S+CKCUEReb7c9UrtpPYgdUBteLn/IkQy59y24PmTrnXXa3svBvyOxogsqGIcLbmD0v3fLo9UB
 /Btwquxa0sRtHoyCjLtWgeZWNlIYWExqxwjo8bF1AN5z+DhYSM94QtT98h1eSFD+PvjBV8WfKp1
 Fk2cz/jtILMtAb7TlVU690EIWSf5FgOeSIGNwy0=
X-Google-Smtp-Source: AGHT+IECHXff/G9p6rbvUA3LqO3W8a5ccNBfY9hRLK//ox9eBZN9z9vDNy3ueyETS82dOqPvTITkhw==
X-Received: by 2002:a17:902:e803:b0:220:bc9e:fd6 with SMTP id
 d9443c01a7336-221a118a228mr234734815ad.44.1740421793036; 
 Mon, 24 Feb 2025 10:29:53 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:52 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 07/10] vfio/igd: Move LPC bridge initialization to a separate
 function
Date: Tue, 25 Feb 2025 02:29:24 +0800
Message-ID: <20250224182927.31519-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
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

A new option will soon be introduced to control whether to apply the
LPC bridge/Host bridge ID quirk for the removal of implicit legacy mode.
To prepare for this, move the LPC bridge initialization into a separate
function.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 125 ++++++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 7c7461e22d..17e731d7a0 100644
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
 
@@ -419,10 +485,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
-    PCIDevice *lpc_bridge;
-    int ret, gen;
+    int gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
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
@@ -466,29 +515,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-
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
     /* Setup OpRegion access */
     if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
@@ -496,19 +522,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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


