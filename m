Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB04C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u4O-00084j-8q; Mon, 21 Apr 2025 12:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u45-0007vK-7S
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u43-0003I0-EU
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2264aefc45dso68032855ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253130; x=1745857930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HXze5phW81QOl9x8fGNAdSteA5vpfVCVmxMuwczLAM=;
 b=ApFWjYke3HgNJH+3JcPqVhSfJRxRfz7q+51YZeEbOUHd1bPkknD9QMwLeYYlNfa93M
 mPxtetTuxETLDXcSCjOzva8pu4I7zoI8hGHD1eRL2XjY3q/obRy97yzdJHSacJZwvbdM
 /JnOSmkGwrQvIiuwnn4tglrItQ4hM6+dHmN9uRsoQdBLJyBElNE5K4Q0URu8UWV0QCqW
 63N8scI6PZJ6Xitzqov13tC3FANF/nXvo5pMR4EL1HEAAE5Ar/k+YdSJXTlZW8qe4/CV
 kNg+iq1B+UbUIiUkG6Ij7d10ciBQYDE9GoNmQfQ/4LltYGoi1w0zktEoha5tbmKRcLrC
 SGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253130; x=1745857930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HXze5phW81QOl9x8fGNAdSteA5vpfVCVmxMuwczLAM=;
 b=SsO+kvaX+wtGGUCeSwyyrqWIZbRCUHMp1mmlm+/V85VARz6uvHXcn9+ATJpxM0zOmR
 pfl6Aa0f2sUfArQLShzKhhcMTYWkhchzZfAABGnQ5AtvamGZ0Rmd9yDrP5xcxKo2Z0k0
 2m/3FwdnVfW3wZzcAECpdAEKoNDXaEO0HoK4J6Mr6mSgV6gq0M5HBYrYWm6+XZE//yMY
 fnUyER3GnJb4jirNIrr/NuTcjw+XRO1mWx5r6pDHWL8IsMxZOAcT073Ebom8K4S/ybFy
 m430NC9iyXt+SEpnP1MhL7z7LekOogQzXtFeVDanP9ZZ/IDiWLG+oop03JcDpWOC90wu
 zSfw==
X-Gm-Message-State: AOJu0Ywsy30alX65hxXWfLs4FWYnIcq/CCl5DfYaCwrTBRO2hvYlDGFo
 EiceEA3itnn7HhqQ3eMS27yxpQ1IAviC7HBljR581GQ/RSzh2zg=
X-Gm-Gg: ASbGncvwRi+Ham+emrRpwpcGrhxY5we35dbmO42wR+fI/LFr8zKQkItP90mmSHIz5ij
 ysgOgZTdNMtj/YMY3AOiIFx4WN9GEcsXbsLfyIrTY6luCZc4mB21mJmPjbXf1Cyf1Lju99Bavuk
 +JFF7IY5n8dERyOP37+T7uHylQRGJ88FiFrqyASbiC+G7dr2cpxVi8D+oV6B/ORaujdsKcj/zkq
 623Xd2hZu6oO95df7Gw3CKzzBOdBB8wcqfO4F3VcbiFaXq0Nq8y8qSCqvA8JqiQPDQV3znwJ0mq
 YaB0xKGTLHxzIGO41Zxbjq0k9rmnGVgVEqfbhQV79KL2Pg7d7IEk3A==
X-Google-Smtp-Source: AGHT+IHrIUvw5zKgpI1ltJvc5Y0bpuWcYo8OEwOVm585pQrDvZ2CblINB6ojDwq565NZp33Wgwn0YA==
X-Received: by 2002:a17:902:e743:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22c5356866cmr189206325ad.1.1745253130044; 
 Mon, 21 Apr 2025 09:32:10 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:09 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 03/11] vfio/igd: Detect IGD device by OpRegion
Date: Tue, 22 Apr 2025 00:31:03 +0800
Message-ID: <20250421163112.21316-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
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

There is currently no straightforward way to distinguish if a Intel
graphics device is IGD or discrete GPU. However, only IGD devices expose
OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
to identify IGD devices.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 36316e50ea..7a7c7735c1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -479,6 +479,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -486,16 +487,20 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
+                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+    if (ret) {
+        return true;
+    }
+    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
+
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -570,9 +575,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* Setup OpRegion access */
-    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
-        goto error;
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
+        if (vdev->pdev.qdev.hotplugged) {
+            error_setg(errp, "OpRegion is not supported on hotplugged device");
+            goto error;
+        }
+        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
+            goto error;
+        }
     }
 
     /* Setup LPC bridge / Host bridge PCI IDs */
-- 
2.47.2


