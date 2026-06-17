Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48383CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAy-0003tD-HD; Wed, 17 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAv-0003qv-11
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:14 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAt-0008Qs-Gj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:12 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30bcf74e617so1368741eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690830; x=1782295630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89ekN/hJz/+HQ5oxlZwhes3IcxtRF+lWDbUwT5lFOzs=;
 b=VHwwpLh9V/rLvPI7Y71Fho3VHhx0INO5FekVGdW4QRYSbHn/1QwwgbIpI3L/5v8iO+
 v43DR8srzBx0OTrWWBVNyGVaLoSLTMb1D3riyauTJjXPUpeu5GQD9WlBIoamTK8WS4Ve
 skQdceCFTg4buz38Pus2eDjEdZbr9RpubOq64dktud4XPSiX8Re4U53FZ0o9AiHaSYAO
 qutBFqxB5tzqqS9RhDOc9Vb6xH+5tQEUSFLAR92cKP5BBCilleQNIporJVqEaVEySpbO
 FSP55Tte5jiIgGsD5iMJ7T3bqqagzBEbZMzMQ8GIWb/7GN4TDCMrooSNBu9k4CI/R2kB
 XFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690830; x=1782295630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=89ekN/hJz/+HQ5oxlZwhes3IcxtRF+lWDbUwT5lFOzs=;
 b=Wv0XbuJK96IqXx/9RoB46jc451BtHZ/+6EPYdHwbB/L0GzbfIf2a71myca2Z8T7TGM
 m7ZONgIFSGg/QdBHl3V0IKMcBQvIxzRwXNFL7tT0Zo7OO4YEgKH/HJtvdexus3I7JTAE
 Qa5B4ffv1Vr5HbNdizi2usuttOB1UQVm4JvsFDdppso9K3dm14+DRQBNdmleDNmpuynl
 8hDKFs0BkM+eFRU/iXkyeI/Ph/60bRK3dWMq3wdoK+V53Ol4oI4zBE7DOuEPHmTOK3ZN
 6dIP2LdJtuJDl+jIg4eEVAqBi/Rd7IFoGf/VIhdQDvEkuRaNQ2fAxiX0SeDxsFX1biKm
 3dLw==
X-Gm-Message-State: AOJu0Yw+O+nt1mGe5BTioGkadqXjJqiVXiVRnm+1nneaxQcbnkv7M+If
 tA58TwjMv3SVDDDWjt3iA1R2bxtWTtkaqYfWrHU8Qx1TIqty3ylXBd3+JeA6Vz0vkQ==
X-Gm-Gg: AfdE7clcVJhxE/n7ThIeCGRtjiAGZ1VVmkZx5ELXoWE1QG74kaE9PukkloFPP3QcvjI
 5/om2CDjtwDc7PBO6E3j2aMGXODMkl0vyQtxNJZkG7soTWyJSyq9LnpK1QGenIoqYhRypcKG40p
 s4ZZ0JVaUmfMxTgr025OxhbCsMx+duZra09DGyPd+LymrLYJFzzXMSxazZC/RJUq/isISA8Mgza
 gJZ8scP/fqNZVstLc/BWXZYXiCJtl19p0eIhWoHRDgstJ4dr7Q9di6+9oIdxzsD9UBWSzVES7cp
 9E1hk2wrbk8RmWg5eUc/Y8HLBaSYZ0pB1fnyxYVZ7ymn5Tnqvack4Gq+60t1xA6Oocei1dMauH4
 qP5cwZDd0fIW+KEK91kGzwP7C4dxvXR2dHCTgHI0S/GJQxjlxMJGaiepb7V8Q/BNBNYSQMY0q/z
 CUC6oetdSRP7HAVwv8Xs3rGzwxCRok0Uk=
X-Received: by 2002:a05:693c:20cb:10b0:30b:dd58:e134 with SMTP id
 5a478bee46e88-30bdd58e697mr275747eec.21.1781690830076; 
 Wed, 17 Jun 2026 03:07:10 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:09 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 5/7] vfio/igd: Toggle rom_need_patch_id flag on IGD devices
Date: Wed, 17 Jun 2026 18:06:42 +0800
Message-ID: <20260617100646.28326-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1342.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

IGD ROMs are known to have wrong device IDs and bogus checksums.
Toggle the rom_need_patch_id flag when the IGD has ROM BAR or custom
romfile so that pci_rom_patch_ids() will correct the vendor/device IDs
and checksum.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..834539affb 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -512,12 +512,14 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *rom = NULL;
     PCIDevice *pdev = PCI_DEVICE(vdev);
-    int ret, gen;
+    int gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
     uint32_t gmch;
     bool legacy_mode_enabled = false;
+    bool has_rombar = false;
     Error *err = NULL;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
@@ -534,6 +536,10 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     gen = igd_gen(vdev);
     gmch = vfio_pci_read_config(pdev, IGD_GMCH, 4);
 
+    has_rombar = !vfio_device_get_region_info(&vdev->vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              &rom) && rom->size;
+
     /*
      * For backward compatibility, enable legacy mode when
      * - Device geneation is 6 to 9 (including both)
@@ -556,8 +562,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        struct vfio_region_info *rom = NULL;
-
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
                     "use x-igd-legacy-mode=off to disable it if unwanted.");
@@ -567,9 +571,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * there's no ROM, there's no point in setting up this quirk.
          * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
          */
-        ret = vfio_device_get_region_info(&vdev->vbasedev,
-                                          VFIO_PCI_ROM_REGION_INDEX, &rom);
-        if ((ret || !rom->size) && !pdev->romfile) {
+        if (!has_rombar && !pdev->romfile) {
             error_setg(&err, "Device has no ROM");
             goto error;
         }
@@ -610,6 +612,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    /*
+     * IGD are known to have bad checksums and wrong device ID in its rom,
+     * request to patch it.
+     */
+    if (has_rombar || pdev->romfile) {
+        pdev->rom_need_patch_id = true;
+    }
+
     /*
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
-- 
2.53.0


