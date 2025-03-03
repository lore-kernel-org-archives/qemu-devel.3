Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB62C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9yn-0001rB-0O; Mon, 03 Mar 2025 12:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y7-0001Yw-Ml
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:45 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y5-0000Je-IA
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:43 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-219f8263ae0so88091815ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024360; x=1741629160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFnj8MBzKLQ8mFbTFO8nM18EwA6rKViM/nHJPBpmhqc=;
 b=HuEeNi1ZSZ9Faz2M+RD74ZdW6TPZngZEA7uoKEvwk9mModyA80jKkzRSPOxo5Wm44S
 iKDr78kFCP1vylrOnHEIXXLCemhnRntXbbAA3T262Qkm1uAwjcVi+axmUlO9Qr/TACP+
 tQMGz1+qT6azM7CBSjuhHizC/tC2SAwVzxOcLT2B5qkU9cygBTzcAXVfv83BusQ0ZSHg
 Otc2byusev7IG6H2DBIxfdjge3vhScp1dxlqwoc+ZN+e26u8PkhWzCZjtOcCYXa2FG/w
 AI56DTLH91BgQoFUwoK97fvxz0p7YyoP88iwqJ+iXG2AvtJvdkYGqAwazdqNR9O1Qk/5
 9sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024360; x=1741629160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFnj8MBzKLQ8mFbTFO8nM18EwA6rKViM/nHJPBpmhqc=;
 b=UJjmlyUsFPpkzbrLcAwqtJBes5lA/vcF9qJXWJ9LOu8rfbsg97kSFUvJiRMFiea60A
 4BqEiDUr0cdDOKkwv1ge0l7cxCzhkvk+3tJ3m42O5WGAUlORfu6yumCvjhUJJa0usveB
 Of9P7VOd+6KNpGi+n7VVkjtUbAtDaQRAy1QBMDkSlAuBPxZ8qFdRtCooxjs9vMO0vtjK
 miW24APE4xXlMFhWQyJdHG38yKENC6udW72kYx4nRTfv9Ofzaz9DC1kFzFqS2xlsISUl
 gGkh5BMWAdz2vx0xfC8/qkuBJ2g+jINSonRSAYoVlyW1U0ZEtU/wBkr5D0eWPSB0S/Nl
 EOIw==
X-Gm-Message-State: AOJu0Yy1MOkiSF4kISNLoYI2u1ueMQCa6VI1h00U++Ih8Om9V3ZSgVjK
 Qm9yX1mkIxvYt1d6HmN2b9vmG6MJqTezw9u3dI/D82VzJgMZm78j16RSmUdHXg==
X-Gm-Gg: ASbGnctEO5xj8cX2OhpyeZMVWwzg3X1ExMTo5+3OhPhYVAgvlntFwh+N/vdN+GnZvRs
 BSydpNjyGEsvJ85tizzAQNrahZ39+Gx545J7NNLfG4yx/CAmdzzDzXfgHvrf6CRTxS9Xt4AMb2a
 GjLuj89sgsYkTJwAje8M8Ct2Y1sIEGyG6TgHva8nXZ/DNyVJv6MuTsZFBo1EfitUrpg8u5trSkD
 ofdCboAFPOC5dKc391MeeNERrJ9nLDPx3e0nSrFdy4j7M5zjLCZFP9eP0Qy6n23ZP72yhPFsSvt
 lxIvvZoPOk9HnGJUNWXb7Jbc22yd+jxZfjLmHJslryWOejvxEAeOhaZ5UQ==
X-Google-Smtp-Source: AGHT+IEq3+gQX8xDaHuG0rjLnBsDZnZW99VU+sJe2NR5Jl85DurYY+iQxfdUaOT/uUkQds+sHHjXiA==
X-Received: by 2002:a17:902:ecd0:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22368f95a5cmr242810205ad.22.1741024359871; 
 Mon, 03 Mar 2025 09:52:39 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:39 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 6/9] vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci
 config quirk
Date: Tue,  4 Mar 2025 01:52:16 +0800
Message-ID: <20250303175220.74917-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk was removed
in previous change, leaving the function not matching its name, so move
it into the newly introduced vfio_config_quirk_setup. There is no
functional change in this commit.

For now, to align with current legacy mode behavior, it returns and
proceeds on error. Later it will fail on error after decoupling the
quirks from legacy mode.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 21 ++++++++++++---------
 hw/vfio/pci-quirks.c |  6 +++++-
 hw/vfio/pci.h        |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 9d2b761d1d..f5e19f1241 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -482,7 +482,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
+                                 Error **errp G_GNUC_UNUSED)
 {
     g_autofree struct vfio_region_info *rom = NULL;
     int ret, gen;
@@ -497,10 +498,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -512,7 +513,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -525,7 +526,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -536,7 +537,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        return;
+        return true;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -550,21 +551,21 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     /* Setup LPC bridge / Host bridge PCI IDs */
     if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     /*
@@ -624,4 +625,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
+
+    return true;
 }
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 8a81c60400..f2b37910f0 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1119,6 +1119,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
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
 
@@ -1170,7 +1175,6 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
 #ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-    vfio_probe_igd_bar4_quirk(vdev, nr);
 #endif
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d54e43764b..2e81f9eb19 100644
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
2.47.2


