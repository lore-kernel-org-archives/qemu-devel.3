Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225C6CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJ2-0001d1-EP; Mon, 08 Jun 2026 09:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaIz-0001cE-Vz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:18 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaIy-0001mQ-Ef
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:17 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1363e78746eso4604216c88.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926375; x=1781531175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDzzbFb0YuuJuUhAbDva2aKW7NQ6P8hnFa3Zvvz7W6Y=;
 b=MZ/46JNe3QQP7ibcdck1ffi+LjJr0n+NEzWWXwiCvvKVUZ8A8/fZbD5LtOxeX+xY8l
 RdzZaMZZJQMAJO9fro0ObLcKXaI1OtwPWKtwohc6s4Q0TUHUq3p3xLK3lbJNCi/Z8KeQ
 +HaY6ymtfsSPyT+wGBcglbea0CPPg9TGiLqPKGG2PtUOcr26sFeB4CluK7zw9aF6XWpf
 sm6E8DN4ewa2+QCTnftWSWuGWEoR6GltzyK8I6NvloRZ5sEzxTVgpv1XgvLiitozgzjG
 vCqoYHbORQ2tFn88v5+p9bRVmep2PphPauiNCH0z0ZFEryKMgi6i2lyVfrAe5bPlA8s2
 GNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926375; x=1781531175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eDzzbFb0YuuJuUhAbDva2aKW7NQ6P8hnFa3Zvvz7W6Y=;
 b=VxYvaoBzPfG79p5SoLOwHPufsCdybMY1CkwtRDn0KsxcHA+4/7aZG+sesWVM9zNa+9
 B/Tc1/dfphN69HumOJ77CYSIIpo5sjpDR3i2UD4U1q6FXzjDgmeRkhDZUofa0dBetqp+
 6sUnLJlw7bGbnVOHO0tmdxasdcFkRaLNtGZOrMly5zxJYHCkTCzhzsSZu/SP06PCB8+t
 QvMyOaJ4n1KUdaBnNHPXJDi8j0fPWU10FGEiV0A9HGOSec3r/YjL7Zgu0krxzjpDu5s2
 tN2zFyJysN7wyDnyZanKqJYt7nJS6AFD5fq2v8+eZerwflDYiHocgCh6KoO9tsTbhM23
 a3oQ==
X-Gm-Message-State: AOJu0YwZBJWq1zNrLKp+OMK8slQVU2lTKdh9ZlVkJJIS1ef2Kzk2CQjm
 k0AHm/Qs9jZnWZ6G7MBZil0x618Sr2aaweSl9qFaal0+KIWfEmSMO9nVzM1cOdPhXQ==
X-Gm-Gg: Acq92OFOvZhdOblcQ61DawVP+VfvUk3kZfverff9MUrFvsykUgvIUygp0naD1cJRcGJ
 Q1YYPrQM6e1yCapyaNds4lV9ZlzCpqxdJ7ehP3JpuYpORHJD350Js7JiK5Oc2oSFy2oCeAEzaGa
 QXoU6C3EP01FEDvYGw6MfGisYJ7Q3tS4oiOac1EWQyWkp8Ju//9KbfnGtPIbauFOF7FOrzIg6Wg
 wi+kJDvv8aGr+LtQ92XeRdGfBsmZTKfTaL9NWUyWEsJCvF3Fuj/lFqbRO+yiAG7Z6m1ZTiDAwZg
 WgU3H5TFGRLALg/i/u5VXg5scTmms9/qBNwj27oAAu/Qr+rvk/H0+bDvuJ5Ye6zXGGxoYJy79iu
 St7V8tGVSpZ+znpgtf2IMuerEccNuwpeAbrb8L4sxlhUV+C/G0ESgKs89khdD9APsjqnlcI2qzg
 Xy2S99exib2dNpIWSVRAtuTEtfS0QS9kXM3u0T6rI5ow==
X-Received: by 2002:a05:7022:6ba1:b0:136:d237:b42f with SMTP id
 a92af1059eb24-1380671e4f7mr7603799c88.32.1780926374787; 
 Mon, 08 Jun 2026 06:46:14 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:13 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
Date: Mon,  8 Jun 2026 21:45:52 +0800
Message-ID: <20260608134559.23971-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1242.google.com
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

pci_patch_ids() only adjusts checksum based on the new IDs. For an
option ROM with invalid checksum, the patched one will still have
an invalid checksum. Always calculate the checksum and patch it if
necessary to ensure the option ROM is valid.

This is intended for fixing the romfile used in IGD passthrough as
multiple IGD devices share the same rom with possible non-matching
device ID, and its checksum is known to be bogus [1].

A helper function pci_rom_calculate_checksum() is added and exported
for reusing in IGD-specific quirk later.

[1] hw/vfio/pci.c:1090

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c         | 35 ++++++++++++++++++++++++++---------
 include/hw/pci/pci.h |  2 ++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cec065d108..742917f79d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2479,6 +2479,21 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
     return found;
 }
 
+uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
+{
+    uint8_t checksum = 0;
+    uint32_t i;
+
+    for (i = 0; i < size; i++) {
+        if (i == 6) {
+            continue;
+        }
+        checksum += ptr[i];
+    }
+
+    return checksum;
+}
+
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
 static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
@@ -2514,25 +2529,27 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
                               rom_vendor_id, rom_device_id);
 
-    checksum = ptr[6];
+    /* In case the checksum is bogus */
+    checksum = pci_rom_calculate_checksum(ptr, size);
 
     if (vendor_id != rom_vendor_id) {
         /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
-        checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
-        checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
-        trace_pci_rom_checksum_change(ptr[6], checksum);
-        ptr[6] = checksum;
+        checksum += (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
+        checksum -= (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
         pci_set_word(ptr + pcir_offset + 4, vendor_id);
     }
 
     if (device_id != rom_device_id) {
         /* Patch device id and checksum (at offset 6 for etherboot roms). */
-        checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
-        checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
-        trace_pci_rom_checksum_change(ptr[6], checksum);
-        ptr[6] = checksum;
+        checksum += (uint8_t)device_id + (uint8_t)(device_id >> 8);
+        checksum -= (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
         pci_set_word(ptr + pcir_offset + 6, device_id);
     }
+
+    if (ptr[6] != (uint8_t)-checksum) {
+        trace_pci_rom_checksum_change(ptr[6], (uint8_t)-checksum);
+        ptr[6] = (uint8_t)-checksum;
+    }
 }
 
 /* Add an option rom for the device */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..2d8a4ad0eb 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1103,4 +1103,6 @@ void pci_set_enabled(PCIDevice *pci_dev, bool state);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
+uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
+
 #endif
-- 
2.53.0


