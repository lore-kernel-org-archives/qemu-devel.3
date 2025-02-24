Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C834C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdH5-0002JJ-P0; Mon, 24 Feb 2025 13:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDS-0005sW-Rd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:07 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDQ-0003QU-DG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:06 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-221050f3f00so107688515ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421799; x=1741026599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZ0KWWRMjO58+2EwLS0op2e0oRMhMHw5+zLruMclF5A=;
 b=gjWJwzRDf40jS6xSAMctQ3GFuBMvol03jNtEDUE2eTCoybuxFP3SGbonETFw8kYPGP
 nZP1hU4gVp3B5f0sUs1FB8v1eP25UY5VVjUJSPMdpaJogFarsZUvY7JRUtyyUFwnR0eM
 bjPAf0XHKOrCV6pip8WL68RhHuO9+P7yX/DkgYXdEIjdCs9nYfNpYs+yi50yVUp3eoKs
 2C/TKPAgpVGSkM5feGQIvLozYtnXApYJMKkomAaioHLUgJd+mgQCOFUZQAzS1QgxULqh
 4/Kd7dA7M/O8MdoKOfxukUPUNlFWKQxixUHOLDrWOczVmhwQa/u4+88Djq8Blp4oapfs
 4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421799; x=1741026599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZ0KWWRMjO58+2EwLS0op2e0oRMhMHw5+zLruMclF5A=;
 b=edAiIhzjztY223RSqVCOMFGmhT7EqVB3Ml515/x3TfqSbm7LFHKogNoMaGzFn5yfkn
 gbFw1HkTkQ0wtz113snjvjdDZdd7bJO11TSDhhpYbBzjCdk/qytaXFqjmSqsfZY98nbQ
 ZIdKEx6wtmRNIYzPDIe8v8sx1m6Ue81QktoS6ca7Zoyu/hJ7JVMnVmk3WaDZNNPwjFPu
 XkqUJ+ThESJhNN4VcPb5qYVeyvM1pJQ+A5lDg6DA4MJ2c8UgJXT59AtoClouF7xoxank
 j/qny37cwdBDkrk/8ktgmWYI9oWVJAH6kSWx7/ocQdObToyDObm3M5GtLQ9LDVCHNalY
 4EZg==
X-Gm-Message-State: AOJu0YzCLPAJuI14+u6xAYIhNn86BstXxRE4f0JRrPvj4jmKVTXoHWEA
 riU3QpHw33X0WBLF/mjHfVwvtiYTGvxDRhZqeLaBWxx/Pd0hfQQ=
X-Gm-Gg: ASbGnctmzqSBjrtk9tv37RXz+kYXSDU5CJvsYUmi3j4zj/esol163EuKQ2Byw3gtH5l
 h9hk6/d4G1DytFa+pRIz0/mykSPbfVIHNfyFlAxwQyvDGYuIQJp33224Uwc6jyHuC+yVdklka2l
 FgAPI5eVCJIj6YTNIZuhaPH9NQiuDa+2rEOhikxRrb2AmzkUGF982hNBzK7KswXkImQUxY23FPQ
 hX1P0E61Q3BZjXyULHZjcm2Hb2KLnTru2LmwZBEN558VmIhrGsU3yMApW83Ah2DmWHK9sH+7LoP
 msba++PLXwCA1NZVt35KnhLD7wY9Hhe7ofMlkps=
X-Google-Smtp-Source: AGHT+IFhRVxjQEqWCOV1a6/3ejmShP2JjfN6oBDMopUq+Emqa/9oA9boGbK2aSDj4DTF/G4vL/xdug==
X-Received: by 2002:a17:902:db0f:b0:21f:988d:5756 with SMTP id
 d9443c01a7336-22307e6ccf6mr3065925ad.42.1740421799009; 
 Mon, 24 Feb 2025 10:29:59 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:58 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 10/10] vfio/igd: Replace legacy mode with options
Date: Tue, 25 Feb 2025 02:29:27 +0800
Message-ID: <20250224182927.31519-11-tomitamoeko@gmail.com>
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

IGD-specific quirks are implicitly enabled by legacy mode, which is
toggled by assigning IGD to 00:02.0. This patch replaces legacy mode
with explicit options for these quirks. The OpRegion quirk is merged to
the exisiting x-igd-opregion option, while a new option x-igd-lpc is
defined for the LPC bridge / Host bridge ID quirk.

The BDSM and GGC register quirks is applied to all known IGD devices.
BDSM register, which contains HPA (meaningless to guest), is initialized
to 0. GGC register is just a copy if x-igd-gms is not specified.

Unlike legacy mode, these options do not require IGD BDF being 00:02.0,
but guest drivers like EFI GOP driver still hardcodes the BDF. It is
highly recommended to assign IGD to 00:02.0.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 38 +++++++++-----------------------------
 hw/vfio/pci.c | 11 ++---------
 hw/vfio/pci.h |  3 +++
 3 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 1ed364b497..54a6a7b97f 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -426,15 +426,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode. Some driver have dependencies on the PCI
-     * bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0 ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev) || nr != 0) {
         return;
     }
 
@@ -482,24 +475,15 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
-                                 Error **errp G_GNUC_UNUSED)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     int gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
-    Error *err = NULL;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev)) {
         return true;
     }
 
@@ -510,23 +494,19 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
      */
     gen = igd_gen(vdev);
     if (gen == -1) {
-        error_report("IGD device %s is unsupported in legacy mode, "
-                     "try SandyBridge or newer", vdev->vbasedev.name);
         return true;
     }
 
     /* Setup OpRegion access */
-    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_report_err(err);
-        return true;
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
+        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        return false;
     }
 
     /* Setup LPC bridge / Host bridge PCI IDs */
-    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_report_err(err);
-        return true;
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LPC) &&
+        !vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
+        return false;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 10f63d4589..dde2b34d9d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3136,15 +3136,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-#ifdef CONFIG_VFIO_IGD
-    if (!vdev->igd_opregion &&
-        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
-            goto out_unset_idev;
-        }
-    }
-#endif
-
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
         memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
@@ -3363,6 +3354,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6fe25c9701..596c78e99e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -154,6 +154,9 @@ struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_IGD_LPC_BIT 3
+#define VFIO_FEATURE_ENABLE_IGD_LPC \
+                                (1 << VFIO_FEATURE_ENABLE_IGD_LPC_BIT)
     OnOffAuto display;
     uint32_t display_xres;
     uint32_t display_yres;
-- 
2.47.2


