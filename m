Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF717C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 15:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIqqU-0006Dc-DL; Sat, 24 May 2025 11:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uIqqS-0006DR-HI
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:31:32 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uIqqQ-0004Z2-7k
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:31:32 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so1020227b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748100688; x=1748705488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XctzVmapaOOwlomlmp0+d4Z1ULbbNIuiVVGqo0/AbTk=;
 b=hrY94RFsI9XgSNzFrcDFdrLWjN5aHI+dBPXfWqd0PrV/p+TDAld9KWzIdow9fCTBUm
 3AFN+PX0yexZO3Mah77xwSDeIfmtfaya3WiWUWLQBlKuU5CvidhYExZGIvwq5LhxU3WP
 j7htzW6VBpc+hdoyrrgVXXCiYzkiy4ewnxrrGiP24tDnNzyx8RPFpk7KNE8BBpxapCbF
 /sUpJrhP6fNuDADup6rghe8meafanwj2IvpGGcWxdX+Iq0I40XGK2NhvBBA+nG8/bzaZ
 G9QQOBfhJI0gCmt1OrzMp54MTCHicWBv9IAbN5+9GA7YISrA153tlHM+8evZq/ZEQhV0
 YESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748100688; x=1748705488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XctzVmapaOOwlomlmp0+d4Z1ULbbNIuiVVGqo0/AbTk=;
 b=jun8FgmVE0aWlOv12KODGcyVks1ze/ibvlU9rEIbUSIoAOkhK4P6vfIhN34ZOR6Ejb
 RhMaaF+hTLVguIvo+5+O4lzKKGn1o48GR7zPC6cwDGpYvmTlFDRWUvcnjxDkg/7GXG8c
 YoMgJPgk83EVbLLNw1nEmj7QJN/NV7n7AfuBCpLQZnmYdptDWnJFsiwNBjaZqm1HY/HU
 M4N3fup1BSNIEwCMpYHxWaP64dFOOg16WuuQjso0Ei34br2sURg+GhwBNGxBleMlFk0v
 hnMWWrk2ENFQdNe9FHkKTUST/sid3dfiAOTPNrXt1px8xngpAHulq59lnH9lBe9dSHeQ
 w/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNianZd4dtKvJ+aJ/5BFHWltPCePNR5hpR7Oq8bRhi63Ia0s4JsJsQ5SandQvz3itRo7/l/nCElDub@nongnu.org
X-Gm-Message-State: AOJu0YyddNwk0Y+4k5W4qeez4zW3A8W7Kn/NmhTIf6kqyFuFlH/+vFYK
 Nm5Ig3Uda+pRTbVSVFPdfoa8CH3P21UiWC8RbGng2WEzupuXLnirGAo=
X-Gm-Gg: ASbGncvkfnHcctZQI8nqYQ5G84ZC0FHipY65RlBOupMFE5ShOHAXVA7pkMakPQEGPUu
 O/VKYUMcHInDOhTKZVfoIaVvvVTcY08GRSHfCl+1hS8xiAofQbwSoAaKGXNjFVbkQiU2Ct/DsSe
 YpBs4PK7oLEyleOc2JWuVSMZ7NYsAVMuMOthbz6ZnlWEkeWs2QTZ7e/3eoYmLJBdDyt3Q675paH
 EaIp4Q9/hEtnFgvT5Pjfo2nl3xkCMRxtd/LsqyrlHyjvYUKJwbG5dz2hrpgeyVDd5HSUL7TSRko
 NkpEJmWjutSsyXaf2na7DJTk7Hex6LYtKXQEOMjQw/DwuqTtyLPYKUp5BC83fUwnUoU=
X-Google-Smtp-Source: AGHT+IH6EDNeYNTl6qrkrr+4Z0F1dKGmtgsYtQgBykPK6A6xnW7IrBlpAvb65qwdFK7HyEqk4AFsvQ==
X-Received: by 2002:a05:6a00:1386:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-745fde95dacmr5404397b3a.2.1748100687659; 
 Sat, 24 May 2025 08:31:27 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9876d39sm14836788b3a.146.2025.05.24.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:31:27 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] vfio/pci: Introduce x-pci-class-code option
Date: Sat, 24 May 2025 23:31:02 +0800
Message-ID: <20250524153102.19747-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
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

Introduce x-pci-class-code option to allow users to override PCI class
code of a device, similar to the existing x-pci-vendor-id option. Only
the lower 24 bits of this option are used, though a uint32 is used here
for determining whether the value is valid and set by user.

This is mainly intended for IGD devices that expose themselves either
as VGA controller (primary display) or Display controller (non-primary
display). The UEFI GOP driver depends on the device reporting a VGA
controller class code (0x030000).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci.c        | 17 +++++++++++++++++
 hw/vfio/pci.h        |  1 +
 hw/vfio/trace-events |  1 +
 3 files changed, 19 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe375..879347a54e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3062,6 +3062,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
                                               vdev->sub_device_id);
     }
 
+    /*
+     * Class code is a 24-bit value at config space 0x09. Allow overriding it
+     * with any 24-bit value.
+     */
+    if (vdev->class_code != PCI_ANY_ID) {
+        if (vdev->class_code > 0xffffff) {
+            error_setg(errp, "invalid PCI class code provided");
+            return false;
+        }
+        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
+        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
+                               vdev->class_code << 8, ~0xff);
+        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
+    }
+
     /* QEMU can change multi-function devices to single function, or reverse */
     vdev->emulated_config_bits[PCI_HEADER_TYPE] =
                                               PCI_HEADER_TYPE_MULTI_FUNCTION;
@@ -3482,6 +3497,8 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
+                       class_code, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb916f..587eb8cc9a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -156,6 +156,7 @@ struct VFIOPCIDevice {
     uint32_t device_id;
     uint32_t sub_vendor_id;
     uint32_t sub_device_id;
+    uint32_t class_code;
     uint32_t features;
 #define VFIO_FEATURE_ENABLE_VGA_BIT 0
 #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e90ec9bff8..d0b006aa29 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_class_code(const char *name, uint16_t val) "%s 0x%06x"
 
 # pci-quirks.c
 vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-- 
2.47.2


