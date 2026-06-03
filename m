Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD1CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpTo-0003mu-BZ; Wed, 03 Jun 2026 13:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTm-0003me-GD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:10 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTk-0003GJ-Qf
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:10 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-137dd51129bso98362c88.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508046; x=1781112846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DGOmpfUA+A9Y3gDGAaNhpfDu5+a0J7SrWtiweDYqsA=;
 b=W8Yft3w9GELx93cfutKys39DZ5t/933XtvE/9I7csLjfp1a49Wz6CIvAMVA4+V7Ai0
 NshGxoxc84OVehsQPq3VmSDhcm9BLrnlwy3dMB8Vc4bkIZyhSSk2un7eBpm/b0HZuHWp
 TcJjejcP3gyKNG03yA8LEvqybEhn6+6o4lo8YnUdvLK8cAxVRjTvzIsL2bhSsaJ5ShJM
 RViDhlIzN/mjzwRVM5wHwHtIbZYiorFm2wzKBqa9G1VVz8LYVYP1lfnOBEae/0ZmBRZ7
 sE02lPi03w1IXUokbp/Y8Ge/zh0oktpkljOnTwNSHtSZAYCg2OHsP06Z/zhRGX4/8GNx
 /E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508046; x=1781112846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DGOmpfUA+A9Y3gDGAaNhpfDu5+a0J7SrWtiweDYqsA=;
 b=BflUIXEB5PSNhg5XWXnLoBo80WgyIQ3noTFOEVXUUfEXDAVqmzIKMmH4bA+NhyYHb4
 S6orLDDmMhNcPOCUGhNh6x5jeX0vb0jZc2M1ov49DFVpSfV5xqUPcOWNeJ7tNQxV0Ozy
 VGSFo8d7FhPMkSMJUFVx4Zu/K1MyScxQfLlw1LTktV913ozJIdhihqU6mcSCgwmkAnyK
 oYWZaVEHZobvsX1hiyDo+MNSTuls8wQelCejta1Q3Miw4kIHFCX50hQojtmwf8lj+xvC
 0mQuf3NSlCRbStSyGx8af4CMWbcZU84gOk3H1IsaoO3zZz+ICL8glq2PMExLsaSHM5ds
 gr0Q==
X-Gm-Message-State: AOJu0YykiBMUrqsRmY8W0zfJgG1O7N6ChZGDXJa6DGB1FGRw9qDLxn+A
 Ouch3KM/p0/n25TANonvrAC6uJCd2AL4q1rR6i2gBB5l75JeJKKQhhwzCdmhqW829Q==
X-Gm-Gg: Acq92OGhGaxEiH407lKtQNa8AdlQCBHLZCC+idt7OmHXZCyE0XQQTFlgwRW65F46/Hw
 2G85W2zGCNYnazqMxQIW2uA6pPlywXndpqUmN4n+ADbmp/Ahm+F5GBrii5rcRQoz6TdMrbAKKmI
 0DkGHrIknCG4UuIBdweey0rWLeqJSkhVGxxG8PTtQ69DQmRfakB9XnBD14A+KJQxMlN3QY0c6jL
 Ch+/eqqOww0sdFzgtDLhEKchlbdwICyyW0b4bjCUYxh394sFFOSPGrzSYbxMwwqnzynjm+27Kbc
 T6L4p+9jufV85XFQTan+I0xSOwt6dT/uXiCxZO27t+WbJrZ9gAhzoGGbhr92D9RUKerW27rOP6K
 ggQZ4lR6IWNA51C152iEDQcyGDAX/u2CoR7KG6PWugW2qtHC2Eyi1qLoSOOH3bw6gCiFWViO416
 U7lnrEAHw2EuCjv8UGkQrL/f+JD75/u/YNek3rsq1Fsw==
X-Received: by 2002:a05:693c:3b02:b0:304:c01e:1cfa with SMTP id
 5a478bee46e88-3074fb8261bmr2618403eec.16.1780508046454; 
 Wed, 03 Jun 2026 10:34:06 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:06 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 1/6] hw/pci: Recalculate option ROM checksum before patching ID
Date: Thu,  4 Jun 2026 01:33:49 +0800
Message-ID: <20260603173355.36121-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
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
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/pci/pci.c         | 22 +++++++++++++++++++++-
 include/hw/pci/pci.h |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4298adf5a0..043fef1954 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2472,6 +2472,21 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
     return found;
 }
 
+uint8_t pci_rom_calculate_checksum(uint8_t *ptr, uint32_t size)
+{
+    uint8_t checksum = 0;
+    uint8_t orig_checksum = ptr[6];
+    uint32_t i;
+
+    ptr[6] = 0;
+    for (i = 0; i < size; i++) {
+        checksum += ptr[i];
+    }
+    ptr[6] = orig_checksum;
+
+    return -checksum;
+}
+
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
 static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
@@ -2507,7 +2522,12 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
                               rom_vendor_id, rom_device_id);
 
-    checksum = ptr[6];
+    /* In case the checksum is bogus */
+    checksum = pci_rom_calculate_checksum(ptr, size);
+    if (ptr[6] != checksum) {
+        trace_pci_rom_checksum_change(ptr[6], checksum);
+        ptr[6] = checksum;
+    }
 
     if (vendor_id != rom_vendor_id) {
         /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..551ab16139 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1103,4 +1103,6 @@ void pci_set_enabled(PCIDevice *pci_dev, bool state);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
+uint8_t pci_rom_calculate_checksum(uint8_t *ptr, uint32_t size);
+
 #endif
-- 
2.53.0


