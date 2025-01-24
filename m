Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6CAC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbP79-0006ju-FB; Fri, 24 Jan 2025 14:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP77-0006jL-AC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:09 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP75-0007pS-92
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21bc1512a63so49280405ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745986; x=1738350786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Em6RHhak2GvKHZXMSIavsdqeWIHHg4HYo+MkTfEaIeM=;
 b=kWyveV0nfBbM5aKtU+f9m7iHKlyzfB9CEidQTEvipPCnVueLEo/QtLX+/r5oY818XR
 RsxGYBq69Te9bLn1EZ+YPPZDGFG8X2vZWGLlBX5W8/hqpbWt6CVo76zyt0V+VfXSHBD+
 eySzymeC265FhpDA48WYOlC1qzaxZSuFOVib3jqF6ydLjFP2AeSG9ZQ2BRAF0sHxis+H
 w8RsA7xNrVbVPomLJ6/0fe3OM6baULClHK019FJeHG/EqbwrWzCJyy0UaE+ghYGA0l3j
 88oDxwYZ/850YfwmlgxGWJQ5lUyq3KlKpEaeImgjQ5FqxEE/FmpOlX9sSNp+drHWqu1X
 ZoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745986; x=1738350786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Em6RHhak2GvKHZXMSIavsdqeWIHHg4HYo+MkTfEaIeM=;
 b=U8mMQ6NPyzyZF65TJ/ect18QQ9Hf9LxUzCaqRnR1xH74u6LEA7lA4jMHtyWOiN2rgt
 2w6QHdSL8ByBX48L9Zovp+dNml9sL0MPNcuQyeP+2kAHx3X7JNEU71Y3ujiWspuNrh2P
 LWHsGtFx0WLJrMUxKJVmgnhl26TqWmPLfKQqQmDLMzSRadoR/HI83GlqKalIwGX1JYiC
 G8yC3Lxp5YHfz363hlqgl9mvui7Pu/q4ObXPEOu1bnFi0udWtR61O+9qvsvKDZ8phEqW
 mq+4Kj+vjNWFWa+/KIQnCCa7r32WBJBneAqsOaxFyETmL378r+5gCOHs3ZFQeVtOSr2y
 JHVg==
X-Gm-Message-State: AOJu0Yz2KSVh1VEECxQJQxRSA3koCJKSwboLaUf+De1L+IzVtgx/ZuSW
 2icD+9ocVdQXWUsSnVzjaORqSJ4ZxvNR6MxnX3Pwq8Vuk89A1+9Fz2b7dPGGXA==
X-Gm-Gg: ASbGncsS53qNyABid9OOCTZjEUkg25UqUs1Et8mCFYv1VxQRE+DIlRQy1S1BcSCnI8v
 CQLrcybLJC9s1qYXrLU8IIIl/4LrGeV+/N5/aX7F2yP0ZtjS+S0ymsHrvFYXWrV1irN8xNsvl7h
 pRU3QiPAKo11H6CXQqu0rkGCiOXqXGeBEqRghi+Zlq7HBfLy8AyENzH58Z9l7I4KEB3CvbET6NW
 iZAlgbGz6jg4qEZ3LCeT6u++H7OR+YVzyrHZMENwxDMSShy6txLZtG5VFUwDA10OY4zJ34KaHGQ
 ScBjlcjoYQjB4NBoEA==
X-Google-Smtp-Source: AGHT+IFlJZwbQOCEud+HN5vEW8YFK1taPgB8ORI70aXuBp2ZirboxYW5qerAPCfMuWGRYCdljNYGZg==
X-Received: by 2002:a05:6a20:7f89:b0:1e0:dc34:2e7d with SMTP id
 adf61e73a8af0-1eb214650camr44843344637.5.1737745985605; 
 Fri, 24 Jan 2025 11:13:05 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm2318406b3a.12.2025.01.24.11.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:13:05 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 3/5] vfio/igd: refactor vfio_probe_igd_bar4_quirk() into
 pci config quirk
Date: Sat, 25 Jan 2025 03:12:43 +0800
Message-ID: <20250124191245.12464-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124191245.12464-1-tomitamoeko@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk() was
removed in previous change, leaving the function not matching its name,
so move it into the newly introduced vfio_config_quirk_setup(). There
is no functional change in this commit. If any failure occurs, the
function simply returns and proceeds.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 31 +++++++++++++++++--------------
 hw/vfio/pci-quirks.c |  6 +++++-
 hw/vfio/pci.h        |  2 +-
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ca3a32f4f2..376a26fbae 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -359,7 +359,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
+                                 Error **errp G_GNUC_UNUSED)
 {
     g_autofree struct vfio_region_info *rom = NULL;
     g_autofree struct vfio_region_info *opregion = NULL;
@@ -378,10 +379,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 4 ||
+        !vfio_is_vga(vdev) ||
         &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
                                        0, PCI_DEVFN(0x2, 0))) {
-        return;
+        return true;
     }
 
     /*
@@ -395,7 +396,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                                            "vfio-pci-igd-lpc-bridge")) {
         error_report("IGD device %s cannot support legacy mode due to existing "
                      "devices at address 1f.0", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -407,7 +408,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -420,7 +421,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -431,7 +432,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        return;
+        return true;
     }
 
     /*
@@ -444,7 +445,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support OpRegion access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -453,7 +454,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support host bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -462,7 +463,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support LPC bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -476,7 +477,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Create our LPC/ISA bridge */
@@ -484,7 +485,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to create LPC bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Stuff some host values into the VM PCI host bridge */
@@ -492,14 +493,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to modify host bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -561,4 +562,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
                                     (ggms_size + gms_size) / MiB);
+
+    return true;
 }
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c40e3ca88f..b8379cb512 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1169,6 +1169,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
  */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+#ifdef CONFIG_VFIO_IGD
+    if (!vfio_probe_igd_config_quirk(vdev, errp)) {
+        return false;
+    }
+#endif
     return true;
 }
 
@@ -1220,7 +1225,6 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
 #ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-    vfio_probe_igd_bar4_quirk(vdev, nr);
 #endif
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5359e94f18..5c64de0270 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -217,7 +217,7 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
-- 
2.45.2


