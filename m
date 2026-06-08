Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B6CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJJ-0001tK-Kd; Mon, 08 Jun 2026 09:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJF-0001h7-H0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:35 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJD-0001nu-Ct
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:32 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1382533d428so30908c88.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926390; x=1781531190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89ekN/hJz/+HQ5oxlZwhes3IcxtRF+lWDbUwT5lFOzs=;
 b=kpXwD6G5xqyKZMyXnTj6CPJa8kIAbVWDoHqoj8W0XrX7xW3Kbd3W4oNh3ol2Qag5k8
 KmBYC5Al5d1ThSYWHj2Lzr0Xrtp0Xbqp8eTFqB3LLJKiFdZYWDbVq9djw0412cOqix0s
 O8LSNpJXSm/uml7Pi3D18VFKLhyqSOWnWm4DhkWlZ2LBfdTYFDucKoAHN0VaSO31NPO4
 IAz1eykqXjxsPTwbEbcgIUnRbna5PRcyXdiPAO+6KHZ5fkJhgEDzvkSphTf7qI7sz2jB
 PzbRBGYmrr8f2tmjVbLNp+2CKQcQkwLmyTL00wFYUJnm593vURuMCY8onMkXa+GjWRig
 mS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926390; x=1781531190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=89ekN/hJz/+HQ5oxlZwhes3IcxtRF+lWDbUwT5lFOzs=;
 b=dXtZAo3GiJ3FlLmP3AQVerPtXXBw27M2ASmJ2YEQf7xQY0oarOyshcvkrXZHGDJVFZ
 PDicbbBrDmFxfLLQvzZUir2eg63YpSxIIcWiAuV7zyoSLNhJc1b7f6/FWzYMx23URCKs
 7HFdtxsPlY784cH0lSFN/l93gN1cZM/+QRyEk4XQS4i54Pk1DULO7ZoGHmrwgoMeVjJh
 +HqlgVUe9t/h2PVFyEHoJk9MeSae6yWX8Gd99tqUJPkQ/oBkR3LruixwNK7qf0Z+6SDt
 xw6vRNxxPFC6lxbZ9wWJsmLF2zebX9mT/pviKnkYxYYAm/66oZr3tOZA+qviFOs6nrZM
 F82g==
X-Gm-Message-State: AOJu0YyDppv6fC1fLaqb7ojhJD16WQPGH5sqzKU9IWOYnAZXcaOAqu+F
 SswcTpC0nq625JG5FpqYuphx0tkVv6kqWo9UhtINgQfKph762ZbRy3FWUiG/IL8r7w==
X-Gm-Gg: Acq92OFn5T5pUKPoOVbifnVEXj+nN1doTUTUzgKdKYznPtnthMbrAPLTt5AM65U9SeI
 7ssieUs06qy0SU1C5lvFmp5R56EtJBT9uaYvSL3rJiMw8zKsyQY+6GXrz4rGttkwjvVaBSlV9kO
 +icn59M39b8EPLWsMFGlkEOW3xWyaI7wq2Gl6wixoFkgHYGCu1iL0yfbGxRHW6y+dpHN2vJcP7G
 rDZ7MZUnGfDBuknadr70S1UCQ/CHxRiYjT4y3toHk8bPeZpIf+UrBLtcdvFVF9PMSqbPZB7OqNK
 YZ/n8oSw7TXb6JFqXBxsMn0AGdgL+jq2mAPn8SuJBSxpUvnDMF2sqO0dNTr7EnOpU+0+4SNp+BW
 CDaeRtmbnT9GD2isMkLkkKPnjfewr7vZ6erB+kAYwKIO3ArO4YSeGgB5J6JFXLpdard/j/w/MzO
 OWAOnC/v6BjankYT6mGsSsMkA0AIO4ImwLI2AHZ0iHyQ==
X-Received: by 2002:a05:7022:6081:b0:137:f764:85f5 with SMTP id
 a92af1059eb24-1380672a5e2mr8665213c88.32.1780926389677; 
 Mon, 08 Jun 2026 06:46:29 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:29 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 5/7] vfio/igd: Toggle rom_need_patch_id flag on IGD devices
Date: Mon,  8 Jun 2026 21:45:56 +0800
Message-ID: <20260608134559.23971-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1241.google.com
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


