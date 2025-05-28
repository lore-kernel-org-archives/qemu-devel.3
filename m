Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJ8d-0005vR-Vf; Wed, 28 May 2025 11:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uKJ8c-0005v3-Ns
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:56:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uKJ8a-0000uW-UE
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:56:18 -0400
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-31118251071so2952852a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748447773; x=1749052573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NyTwWlT35h762q2znPKQtKWn5WvVU53R3yV7crEc5XY=;
 b=YzsZ//pCoEZXPbfXlmCOuOalglSMEiASqjhjo29LWBkQ7qtsW1DHlaoXe+bCIFXCss
 ShDhMIhmeMk9TWHBwrEe1+J/2UCFj1uuj6+24XFnK+rVoGx/Q/n7v5ZWTRXHfMJHE38s
 vdOSEfgE8VcbUJpgmj2pkXjb8rl1Xlmiwai5PuPkOm0HSCUZyCtrQv6ayqYJEu1W4Aa+
 5T1A0TBHewXa39/vDwI54kvUWajPXPRrucEIqUie0Et1JiURNzGnu47eRxQYp4lTZW6F
 28N8iVF35jJhNboHAK0XkO0+obnbaxVrcJjgjwaYoUoMOjM5xFA8LNBRkppFRICnDG1a
 OmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748447773; x=1749052573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyTwWlT35h762q2znPKQtKWn5WvVU53R3yV7crEc5XY=;
 b=aARbMF1cFnWJ+RLSUa65u/P0NhE65j69IAXlFxDqpStMS8QnE+zXLwu4KUkoqBacVI
 ms0dhPSGndO9bivO1e65QC3P20XcEOcXR/wHEMsRLIwHH9twbp4emTl+FsLUxIutcl4/
 4C/QVKR1kJNBvv0kpoaJapV5KXGshrZo1Y+KYLBHoBa5oI2zSMxA5R858lqHRIYQBh3x
 yqrJI2bOAMgn82sQUgHbIdugSD+Bf72/32HTFFccR1oWxN/t9HSJwQ8feRlmXl22wNSY
 q+uXr5/66MfREYUOpyrLEmWIZy1foDGLA4BEf5RYeWAVIf2mroBnFc1+3AeCm/G8RfVi
 w2Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBYNCfJNTYQKKjHP0G+FTrtAZEdSAW8omTbEyH7R7PL+f8SVh7XkZnzQxnSFG3suoUFA0hwCB1BItB@nongnu.org
X-Gm-Message-State: AOJu0Yz9UTcaqc3kj1iT9hHLH5qR6X+hNSlXsVObmWm5fCwiUuajvIqv
 9+1Gil58PWay5jyID4BkFHSE2202CHM+sYvjLDM0wCXEz2tV8o3Jqwg=
X-Gm-Gg: ASbGncs1FPRQkdB8BPn2b1K9c+Wv4WqbDDzZKMHdj7Z3PsZdWUdAp7ansLSsBuVohqj
 3GNk6YhqpEB3TzCSB6YMMIgTJK0rFcgAarVJmifDiSeOzPTX5hbV927aB1JdNBfSI14MzkW8DQu
 v4LbIKgrgHDrzPgNcbpERvKHGh4mJZ+l8xorreLj4zGucKLdBwJR+lLOObZ0lN85OyYMxXWHQMu
 sHu6KZc6FWqzbCDvugM+9lKmvyBHWzPKmjcFTALmePvpKT1i3y73SgnQeiQlldSvHWdu+DKNxiu
 LmIfBmNFzwRNzec5UtmPWLqs48KHqo7spXYJQxORhVZlJ8u90bEsd1WtUqEzG5Hb
X-Google-Smtp-Source: AGHT+IEU4Lnn1KXzqOv9DhKN/pYO7xqOm/UTAGs2zALh747qwGK6hN2QSmyWMX4wIFuDLXWxhENHog==
X-Received: by 2002:a17:90b:1997:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-311a314c453mr11729096a91.14.1748447772580; 
 Wed, 28 May 2025 08:56:12 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.74])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-311e9b45d8dsm1322079a91.1.2025.05.28.08.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:56:12 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] vfio/pci: Introduce x-pci-class-code option
Date: Wed, 28 May 2025 23:55:48 +0800
Message-ID: <20250528155548.29344-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
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

Additionally, to prevent exposing VGA ranges on non-VGA devices, the
x-vga=on option requires x-pci-class-code is either unset or set to
VGA controller class.

This is mainly intended for IGD devices that expose themselves either
as VGA controller (primary display) or Display controller (non-primary
display). The UEFI GOP driver depends on the device reporting a VGA
controller class code (0x030000).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
v2:
* Add vdev class code check in vfio_populate_vga().
* Fix type in trace-events.
Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/

 hw/vfio/pci.c        | 25 +++++++++++++++++++++++++
 hw/vfio/pci.h        |  1 +
 hw/vfio/trace-events |  1 +
 3 files changed, 27 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b1250d85bf..d57cb7356e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2726,6 +2726,14 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
+    /* vdev class should be either unmodified (PCI_ANY_ID), or VGA controller */
+    if ((vdev->class_code != PCI_ANY_ID) &&
+        (vdev->class_code != (PCI_CLASS_DISPLAY_VGA << 8)) &&
+        (vdev->class_code != (PCI_CLASS_NOT_DEFINED_VGA << 8))) {
+        error_setg(errp, "vdev is not a VGA device");
+        return false;
+    }
+
     if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
         !(reg_info->flags & VFIO_REGION_INFO_FLAG_WRITE) ||
         reg_info->size < 0xbffff + 1) {
@@ -3092,6 +3100,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
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
@@ -3489,6 +3512,8 @@ static const Property vfio_pci_dev_properties[] = {
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
index e90ec9bff8..e8d585b49a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
 vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_class_code(const char *name, uint32_t val) "%s 0x%06x"
 
 # pci-quirks.c
 vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
-- 
2.47.2


