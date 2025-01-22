Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C543C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeMZ-0004Qu-Ny; Wed, 22 Jan 2025 12:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMW-0004Q4-Fl
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:17:56 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1taeMU-0008Gc-BQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:17:56 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2166651f752so166553705ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566273; x=1738171073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiv+xmaf6VB7kBegyDiMT0hLoID7B9Kq0HTGVF+DZXY=;
 b=HYetyiNAylSJG/YE3e95du4eB3HI1gNSMS2xZC6gCs0QhYo3qA0QzRSSjOScAZok5i
 PJh9QynqN1nJLpEPim3ledadaUcOjqYWb8yvKIk8iEU/7cMQLSeuqXe6L43HhojDD3mk
 gYra9nX9hqbnCBpW60nmg4yQsate+p5UMboxK1b+5xE1XImrzlB/ErIQQlmV0uTKDkaJ
 novz0/ceH5Itp5gx5rZP7Y1Hw4AxIjVqIhRStqwKqgxXXP52iYFtvY/rYYZL74TfGN6M
 nN9LM4IktaJwQ7e6/u8xQxf7/fbhf9kQI8gbuUP45DQm6lFUrow1OcQ34JK6liogJUMI
 VRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566273; x=1738171073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiv+xmaf6VB7kBegyDiMT0hLoID7B9Kq0HTGVF+DZXY=;
 b=tJZVxUReJNrEtgdYk8IXVVZ29Yz47DAccZDf+7kHS7IWrkyYRoonlWb/h1EjL61zv+
 +CQ7lMqJakBMU+ysTQZjd/xDRfzKqTDPhs/7gYCyve5O8v2gRqw1qTm4JRbcGXLzxw4c
 F1H+fOeTG0iKZcuGb/8loqvLvGXgk2cLqDv3cQDmp8PPvgbhNWRCVUQSViPu9/SSlm06
 O4e8XhUNndaaeUnKDZr/KFCDDfRce24NQQ2QpNuAUJAMRHV79i0TsME+fnzQ0F7Jlwia
 NqfBM5v/lY+LkVIyRoGPqA2wh1jqr8ruibA2xNXtBqPx98K6eJTJj2X34CAkQn3Pljfs
 hvUg==
X-Gm-Message-State: AOJu0YwZ6J1qa5vToXgJUDmhGBJFzscdAruN3Tkxsl1mIM0dZycDi+1s
 GEr58ArMxu+9/y5P/zRXXTd2ISaruSOoR6kOW1nWVyyC4127QEo=
X-Gm-Gg: ASbGnctR5+XLfxd2FLZXQKH7PzUoIJ3o5AuyxLJc/YVOR+ANrjI8k1FxNlbzObS73e5
 B02rqgdp/7zEFqJwQaRlk9uESDGk8xAG0EbeAAlT8W5CcHNljsM1tgX9GHo5+ULYM4sTE8DVsHF
 IRX4rJUWjqxwPwTSf+Gs5X6QUwJwQ8+bAo2/gvr/iHNbC0fP1cp4ercqS46XW0JV0FTlQoGh0ma
 MPO8E+CNF3hYJDTjvb//ojKinp+RD6ndDaxkBTo7/LRKdu4Zp2E8Ho4LnkagRHke818bG2tDdMk
 3t2jo8c=
X-Google-Smtp-Source: AGHT+IHeCi2T3bfBVC+zFH9rscaf5aSi8Ba0LlC7ODYhftO41b+Gcjp6R6Fr8rHv6Ee3/6jf+loBgA==
X-Received: by 2002:a05:6a20:4303:b0:1e1:9fef:e975 with SMTP id
 adf61e73a8af0-1eb215815a0mr30239163637.26.1737566272760; 
 Wed, 22 Jan 2025 09:17:52 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.217])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba48eb8sm11597818b3a.136.2025.01.22.09.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:17:52 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 3/4] vfio/igd: refactor vfio_probe_igd_bar4_quirk() into pci
 config quirk
Date: Thu, 23 Jan 2025 01:17:30 +0800
Message-ID: <20250122171731.40444-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250122171731.40444-1-tomitamoeko@gmail.com>
References: <20250122171731.40444-1-tomitamoeko@gmail.com>
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

The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk() was
removed in previous change, leaving the function not matching its name,
so move it into the newly introduced vfio_config_quirk_setup(). There
is no functional change in this commit. If any failure occurs, the
function simply returns and proceeds.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 30 ++++++++++++++++--------------
 hw/vfio/pci-quirks.c |  6 +++++-
 hw/vfio/pci.h        |  2 +-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4f9a90f36f..33e5202052 100644
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
@@ -378,10 +379,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        nr != 4 ||
         &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
                                        0, PCI_DEVFN(0x2, 0))) {
-        return;
+        return true;
     }
 
     /*
@@ -395,7 +395,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                                            "vfio-pci-igd-lpc-bridge")) {
         error_report("IGD device %s cannot support legacy mode due to existing "
                      "devices at address 1f.0", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -407,7 +407,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -420,7 +420,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -431,7 +431,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        return;
+        return true;
     }
 
     /*
@@ -444,7 +444,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support OpRegion access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -453,7 +453,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support host bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -462,7 +462,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support LPC bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -476,7 +476,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Create our LPC/ISA bridge */
@@ -484,7 +484,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to create LPC bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Stuff some host values into the VM PCI host bridge */
@@ -492,14 +492,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -561,4 +561,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
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


