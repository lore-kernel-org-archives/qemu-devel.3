Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8E4CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umDyq-0003Hy-Mx; Wed, 13 Aug 2025 12:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1umDym-0003HZ-8s
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 12:05:32 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1umDyj-0002KF-Ng
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 12:05:31 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-76e2eb6d07bso63611b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755101124; x=1755705924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9t1oRq+SXOT3f3RHyYT8hdlEbqhnbm0bWNtPjxBUx3k=;
 b=X9JkiT08gq7eVe3GvILv8Pn2BKvn3n5jR+YJ2bqpUJ9E9tb33jnPNgP6HmzPmF/LNc
 2kjNmtpQwhiskbeuSG9ObpVNElpAgM2s7uJa0naNgMv4Xb8QowHBHL140P2D9wN7152t
 0HPQrib0eMp5XSi6zIQnh9IRVpk+AkejVD7reOrMMiQ94547/IRv0Nswv4LmKVAmpttg
 +/PSSHZUfuom2KAcvUi0+n76MkVFKgDm5Iy4SAsrSyE8QtCRvwckLPIIxPuTLvH4umE/
 oRpV/zX2DTv+LtzQ47B5vrq52lqBlmYA7Y3nVMIWD2lg9H+geiuc7o5Doy/bFS7fcX68
 WkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755101124; x=1755705924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9t1oRq+SXOT3f3RHyYT8hdlEbqhnbm0bWNtPjxBUx3k=;
 b=gf5Or3pPmPZ2WUw3zihyOMvGu2OMBwmZCr22vi6RrtMG+u3nx4OqfLz9b7MzeC5tJ3
 bOGs1bDOit8D7J3CLFgm2Q3y8g1Y6/IcVd66SaIOJVECWyuYNuZP5ZPmwqqiPg16d0lc
 sTgGpnrVcMKJby411BlFTazOLAQoYT4szRR+86fuJL000zz0mYqX7J8uCqRhaHTcxwkg
 g0A9nlvWKijRJSUHZq7G9pYk5s181pNqZhKKkIDZMHlzJ6iMS0Hf5Jnj9rzfJN74RqQK
 wK4qH03DtXjTorLvc0g/85riqc+UrzKzZQuehMSFrb+a3Lkj7AmxAWhE3zf/xa7Xbufl
 DhEA==
X-Gm-Message-State: AOJu0YzCzbBTPnLOH3twhNLybBc2jpeFmbip4F/GKObmCep7avV3KHYX
 ajOO/GRM2a62wpsVKlUNTUD25Bk63K8OVYK5aAwCdosedCbReJ79WlxvngW/nKFZKQ==
X-Gm-Gg: ASbGncuFIXJJaMJpAvQgQJkGptpXs3KazUw0aH93XpFgJ3PTnz1NsttdJ1Z3gG086xH
 2T8WAa5YFYwkah7b74U/XaO0VnBZvuQz+w89b/1vZcE4NVHOCNjfhNEs9esJjjSYKQmgdmI1QJZ
 OmVzE0dJQFqoZ11kXpZELs6O3jPTY0lHT4dhuiZDFYfTUrZ8enqe6c0rZK8zIFhDgQw1JA19nmJ
 RGFjxI+7/DQ3OQR81cIjkSdhl48AWFyRtIc3iyMO3DzAzmPGOFZlMyEG437GdpiZJjT3rXUCbW3
 wOENlsza17BGN+quM+eMo3SGukjyjwXl5R4hQDleZWZhv4DwhLkq2WTSNtzRE85PqK67ws57zaK
 149pvOy5orXmve4wHZpyEtXrwHjZ66aEZ9zd6QQ==
X-Google-Smtp-Source: AGHT+IEBzlkJne3GbD02fpiJfbcO/Jola+fVbZCa1VigrRcD2e2aXSC4b/Dk87C9VVZ41dPQ0vu4Mg==
X-Received: by 2002:a05:6a00:a0b:b0:76b:fe65:71d2 with SMTP id
 d2e1a72fcca58-76e20d06586mr4970988b3a.10.1755101123768; 
 Wed, 13 Aug 2025 09:05:23 -0700 (PDT)
Received: from kotori-desktop ([139.227.17.249])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c5f493178sm11779459b3a.49.2025.08.13.09.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 09:05:23 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] vfio/igd: Enable quirks when IGD is not the primary display
Date: Thu, 14 Aug 2025 00:05:10 +0800
Message-ID: <20250813160510.23553-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x444.google.com
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

Since linux 6.15, commit 41112160ca87 ("vfio/pci: match IGD devices in
display controller class"), IGD related regions are also exposed when
IGD is not primary display (device class is Display controller).

Allow IGD quirks to be enabled in this configuration so that guests can
have display output on IGD when it is not the primary display.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 7 ++++---
 hw/vfio/pci.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ee0767b0b8..f116c40ccd 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -460,7 +460,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0) {
+        !vfio_is_base_display(vdev) || nr != 0) {
         return;
     }
 
@@ -518,7 +518,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     Error *err = NULL;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev)) {
+        !vfio_is_base_display(vdev)) {
         return true;
     }
 
@@ -534,12 +534,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     /*
      * For backward compatibility, enable legacy mode when
      * - Device geneation is 6 to 9 (including both)
-     * - IGD claims VGA cycles on host
+     * - IGD exposes itself as VGA controller and claims VGA cycles on host
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        vfio_is_vga(vdev) &&
         (gen >= 6 && gen <= 9) &&
         !(gmch & IGD_GMCH_VGA_DISABLE) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 810a842f4a..923cf9c2f7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -203,6 +203,11 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
     return (vdev->class_code >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+static inline bool vfio_is_base_display(VFIOPCIDevice *vdev)
+{
+    return (vdev->class_code >> 16) == PCI_BASE_CLASS_DISPLAY;
+}
+
 /* MSI/MSI-X/INTx */
 void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
 void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-- 
2.50.1


