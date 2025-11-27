Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B51CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqd-0002d9-Ch; Thu, 27 Nov 2025 08:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqP-0002YP-Ck
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqM-0001Bv-NV
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6ft6BELKhg3auDZcZUkYwIAm8CvB7eyb0vGAtNjiuo=;
 b=HeTlAf3uy0A3SsB8P3pHZFGxKHBeefJPv1YDrRuNzJz+X4FhKub2u7LjuO3mWDzUh4jR0U
 olvhB9+9sfuB4grNiQlYkvP3PFrC+hTyt55anHsmaXVwnzLz8pB3qZ79AhljI5pj3PJYAC
 n1bKPMZutV1jKHA2SxrgcYU9IXAk0qY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-xAmk1x-cO9ShRtCGTWgvHA-1; Thu, 27 Nov 2025 08:15:28 -0500
X-MC-Unique: xAmk1x-cO9ShRtCGTWgvHA-1
X-Mimecast-MFC-AGG-ID: xAmk1x-cO9ShRtCGTWgvHA_1764249327
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b7336ad128cso83581866b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249326; x=1764854126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6ft6BELKhg3auDZcZUkYwIAm8CvB7eyb0vGAtNjiuo=;
 b=jfSg4DiDFKNwJ+HcZcfjesHk4SPRzV8DC89aLPz+zrBGCXlNqbm8rJLPCcQlsBGu/V
 5f+RFatiUWMMYkfq5HKJ2wrcu9muxtoFi2y/pzQQ7KOUY5KRK0eYX5H/39/vqNb9snqD
 upBYefY8Wq0BzeL7iXwnlAUL0jubxWF3dTJkL4o75m4/g2gyS2ZAr+Ih1FuKHZBeBaWN
 oCzBWVuGP5UIrlDheDHWCG7IFGKA+XT0fAYNqs1N4x/bdgDQ1pzlRmd72tCrkOId2DRF
 RrEW2CxilE4eByW27lta2t12cM4AqYV6bCrrqb4a1Z9x5ljZvVU0BCo8vjPpZm87XzDf
 qK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249326; x=1764854126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A6ft6BELKhg3auDZcZUkYwIAm8CvB7eyb0vGAtNjiuo=;
 b=wN7gfG1L/vNOiMu5TJXsm/o+DagLdD/1C2A5LlyDlJzZhT1nCOH1Pd64lRDYzJvYG0
 zRKyp2dyfkIbe0eM8YslE1S5XmTkQXpbhbwM2lg7xfpxFFtsLxzVW0gVbPbrpduI3cir
 MMAMTgjygsOy5yJtDNkcY+LEgdc4h2H61lQAqj4xd2XbBgPqxsp0IcEC8KG7aoGkmRWF
 s3zv7w6mi8gS3X2goSyuK+LRVLlAHZjOGYy54iZUaQLlgdi8wFI6u8wxKF1yczZSSAzU
 iCOce4kdQpK1pkEP3k5BTlyUCGRxe7FbWv8TvNXYlvsiELfbzFNQZbHZkxCie8cVmiiS
 T68Q==
X-Gm-Message-State: AOJu0YwJCE2OD+luLc8aozKSsesKw8p2ac0sgbTrxn8ihnIK4G6PtGpu
 LzojPej7NRE+j9q1zzFWaM5yg42BmCDcK6IFcF1fWhk5Sb4TyevficpsTTNpn+HE4EXmxzEwpIH
 nliTHfnRrt9fmr5VcHTMrJMY0YlOX4DZUONR2mmofmd4fPNZc7htooOvCyPGPye+UqsxBcIOY/H
 sFwRHqJVFT2ESYzCT0VVJQ9fGCR91DpYn5MaEix9Jl
X-Gm-Gg: ASbGnctMeWdSlGe1aEBnz+RvlGp1Dcn1kTAj+Ox8PvhF6cl6FaR0JhDHFGJ3c7Ik3oj
 2jIwTH+9d8cUlcV+aqKRkkb5ifMgLNBMpjFZ2RDt7hRrf8/2036QGhAjz8Eac8lKx6hVUNIPfMk
 InUJThwiUENhWKz/4vlp14mgkt0Vs2YrUSG60xsb6ntGqbtiTWjvELYpO06+bzOjJ6NnGd5P3ei
 xkCTCzleKwXU8V7MntPmqmdYhSxBDuRcwSdVtMpgFGC1B2U13LkNdo3SipXWPk5gQK0btGO86Nm
 0bLQtgKmzFSWQFPdcE9ELBbrnL5D3TnOBitWIZDk6JumrPq5LNHK4Acp7T+aSx0MPVoWGFVuJqz
 oRiJUfCUMVtqgTMO9hS20OAUJMED534ih3PcLf7pGQUlC5V/U/bBLkHfRU9CQiEtRntndm0L8TZ
 JowDOW/G7aLqaxXYM=
X-Received: by 2002:a17:907:26cd:b0:b76:4d0d:f2f8 with SMTP id
 a640c23a62f3a-b76c566bfc9mr1238727666b.57.1764249325973; 
 Thu, 27 Nov 2025 05:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN4aDFNOnVAPyIxTeAvLzVy182s0wfD1X5ToJjDjRhzjsc7OVcRU4Ec+PuP8V1iN2ZleGP+A==
X-Received: by 2002:a17:907:26cd:b0:b76:4d0d:f2f8 with SMTP id
 a640c23a62f3a-b76c566bfc9mr1238719166b.57.1764249325150; 
 Thu, 27 Nov 2025 05:15:25 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59a6a74sm161135666b.45.2025.11.27.05.15.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/28] include: move hw/usb.h to hw/usb/
Date: Thu, 27 Nov 2025 14:14:51 +0100
Message-ID: <20251127131516.80807-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                   | 2 +-
 hw/usb/hcd-dwc2.h             | 2 +-
 hw/usb/hcd-ehci.h             | 2 +-
 hw/usb/hcd-ohci.h             | 2 +-
 hw/usb/hcd-uhci.h             | 2 +-
 hw/usb/hcd-xhci-pci.h         | 2 +-
 hw/usb/hcd-xhci-sysbus.h      | 2 +-
 hw/usb/hcd-xhci.h             | 2 +-
 include/hw/usb/msd.h          | 2 +-
 include/hw/{ => usb}/usb.h    | 0
 chardev/baum.c                | 2 +-
 hw/arm/sbsa-ref.c             | 2 +-
 hw/hppa/machine.c             | 2 +-
 hw/i386/pc.c                  | 2 +-
 hw/i386/pc_piix.c             | 2 +-
 hw/i386/pc_q35.c              | 2 +-
 hw/mips/loongson3_virt.c      | 2 +-
 hw/ppc/mac_newworld.c         | 2 +-
 hw/ppc/spapr.c                | 2 +-
 hw/sh4/r2d.c                  | 2 +-
 hw/usb/bus-stub.c             | 2 +-
 hw/usb/bus.c                  | 2 +-
 hw/usb/canokey.c              | 2 +-
 hw/usb/combined-packet.c      | 2 +-
 hw/usb/core.c                 | 2 +-
 hw/usb/desc-msos.c            | 2 +-
 hw/usb/desc.c                 | 2 +-
 hw/usb/dev-audio.c            | 2 +-
 hw/usb/dev-hid.c              | 2 +-
 hw/usb/dev-hub.c              | 2 +-
 hw/usb/dev-mtp.c              | 2 +-
 hw/usb/dev-network.c          | 2 +-
 hw/usb/dev-serial.c           | 2 +-
 hw/usb/dev-smartcard-reader.c | 2 +-
 hw/usb/dev-storage-bot.c      | 2 +-
 hw/usb/dev-storage-classic.c  | 2 +-
 hw/usb/dev-storage.c          | 2 +-
 hw/usb/dev-uas.c              | 2 +-
 hw/usb/dev-wacom.c            | 2 +-
 hw/usb/hcd-ohci-pci.c         | 2 +-
 hw/usb/hcd-ohci-sysbus.c      | 2 +-
 hw/usb/hcd-ohci.c             | 2 +-
 hw/usb/hcd-uhci.c             | 2 +-
 hw/usb/hcd-xhci-nec.c         | 2 +-
 hw/usb/host-libusb.c          | 2 +-
 hw/usb/libhw.c                | 2 +-
 hw/usb/pcap.c                 | 2 +-
 hw/usb/quirks.c               | 2 +-
 hw/usb/redirect.c             | 2 +-
 hw/usb/u2f-emulated.c         | 2 +-
 hw/usb/u2f-passthru.c         | 2 +-
 hw/usb/u2f.c                  | 2 +-
 hw/usb/xen-usb.c              | 2 +-
 hw/vmapple/vmapple.c          | 2 +-
 system/vl.c                   | 2 +-
 55 files changed, 54 insertions(+), 54 deletions(-)
 rename include/hw/{ => usb}/usb.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d007584b476..10f74e97fa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2285,7 +2285,7 @@ S: Orphan
 F: hw/usb/*
 F: tests/qtest/usb-*-test.c
 F: docs/system/devices/usb.rst
-F: include/hw/usb.h
+F: include/hw/usb/usb.h
 F: include/hw/usb/
 
 USB (serial adapter)
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index 2d5a5690fc2..0c02392ade0 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "system/dma.h"
 #include "qom/object.h"
 
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index ffd6c5108eb..c16717294d3 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -19,7 +19,7 @@
 #define HW_USB_HCD_EHCI_H
 
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "system/dma.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 3cc35a5cdc5..75e266de90b 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -23,7 +23,7 @@
 
 #include "hw/sysbus.h"
 #include "system/dma.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qom/object.h"
 
 /* Number of Downstream Ports on the root hub: */
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h
index e0a6525505c..3154837f1d1 100644
--- a/hw/usb/hcd-uhci.h
+++ b/hw/usb/hcd-uhci.h
@@ -31,7 +31,7 @@
 #include "system/memory.h"
 #include "qemu/timer.h"
 #include "hw/pci/pci_device.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 
 typedef struct UHCIQueue UHCIQueue;
 
diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 5b61ae84555..c9359f1bd90 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -25,7 +25,7 @@
 #define HW_USB_HCD_XHCI_PCI_H
 
 #include "hw/pci/pci_device.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hcd-xhci.h"
 
 #define TYPE_XHCI_PCI "pci-xhci"
diff --git a/hw/usb/hcd-xhci-sysbus.h b/hw/usb/hcd-xhci-sysbus.h
index fdfcbbee3bf..f8175470bab 100644
--- a/hw/usb/hcd-xhci-sysbus.h
+++ b/hw/usb/hcd-xhci-sysbus.h
@@ -11,7 +11,7 @@
 #ifndef HW_USB_HCD_XHCI_SYSBUS_H
 #define HW_USB_HCD_XHCI_SYSBUS_H
 
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hcd-xhci.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 9c3974f1489..5cb9e06d1d6 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -23,7 +23,7 @@
 #define HW_USB_HCD_XHCI_H
 #include "qom/object.h"
 
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/xhci.h"
 #include "system/dma.h"
 
diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index f9fd862b529..125d2c218f6 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -7,7 +7,7 @@
  * This code is licensed under the LGPL.
  */
 
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/scsi/scsi.h"
 
 enum USBMSDMode {
diff --git a/include/hw/usb.h b/include/hw/usb/usb.h
similarity index 100%
rename from include/hw/usb.h
rename to include/hw/usb/usb.h
diff --git a/chardev/baum.c b/chardev/baum.c
index ad683215041..157f8b95195 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "ui/console.h"
 #include <brlapi.h>
 #include <brlapi_constants.h>
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2205500a8da..3ba69d37d79 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -45,7 +45,7 @@
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/xhci.h"
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8c66eed5a26..acd1c3f005b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -24,7 +24,7 @@
 #include "hw/input/lasips2.h"
 #include "hw/net/lasi_82596.h"
 #include "hw/nmi.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci-host/astro.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8b919cb6c4..0f2a5889022 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -52,7 +52,7 @@
 #include "acpi-build.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl_host.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "hw/virtio/virtio-iommu.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7b3611e973c..f6b9a1bc406 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -35,7 +35,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "net/net.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6015e639d7b..02de7453baa 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -52,7 +52,7 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 77dc895648f..4df6cf13b36 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -43,7 +43,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "net/net.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 951de4bae4b..739f1af3e18 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -72,7 +72,7 @@
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 99b843ba2fa..6f2d10330d6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -78,7 +78,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "system/confidential-guest-support.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 010be6d5394..c29ee690690 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -41,7 +41,7 @@
 #include "hw/ide/mmio.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/block/flash.h"
 #include "exec/tswap.h"
 
diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
index cd0c317b718..a7c3909e967 100644
--- a/hw/usb/bus-stub.c
+++ b/hw/usb/bus-stub.c
@@ -12,7 +12,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "system/system.h"
 #include "monitor/monitor.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 
 USBDevice *usbdevice_create(const char *driver)
 {
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 8dd2ce415eb..887a4a2e487 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index cbefbb5daf8..acd4ea30d98 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -12,7 +12,7 @@
 
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "desc.h"
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index e56802f89a3..f18e53b7885 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -21,7 +21,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qemu/iov.h"
 #include "trace.h"
 
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 975f76250a1..b3f811c513b 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -24,7 +24,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qemu/iov.h"
 #include "trace.h"
 
diff --git a/hw/usb/desc-msos.c b/hw/usb/desc-msos.c
index c72c65b650c..3f53d4943d2 100644
--- a/hw/usb/desc-msos.c
+++ b/hw/usb/desc-msos.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "desc.h"
 
 /*
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index f2bdc05a953..268eaf06994 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "desc.h"
 #include "trace.h"
 
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 8dd9d265996..988824ea750 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "qemu/audio.h"
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 96623aa3223..296e9d0d856 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "qapi/error.h"
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index a19350d9c42..f418da14094 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -27,7 +27,7 @@
 #include "qemu/timer.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index afd7944b737..04e8eedbf61 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -23,7 +23,7 @@
 #include "qemu/filemonitor.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "qemu/units.h"
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 1df24541814..34cd906d6cc 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "net/net.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 2eb52b2e01e..17bdff9e820 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "chardev/char-serial.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 6ce7154feed..a1081e545aa 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -41,7 +41,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index df6ab7f656b..a7f8d80c17a 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/desc.h"
 #include "hw/usb/msd.h"
 
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index dabe1563593..977151c4a08 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/desc.h"
 #include "hw/usb/msd.h"
 #include "system/system.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b13fe345c45..bbd97406f00 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -13,7 +13,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/msd.h"
 #include "desc.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 18ebe15d0c4..75f01c74038 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -18,7 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index f4b71a21472..14d07e81281 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/hid.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 94d1077eb9e..e180e96b5f1 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 3fc6cce44b0..2d3c770b117 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 72a9f9f4749..c48f07f7e39 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index e207d0587a1..124ac4faec0 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/uhci-regs.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 9e0fea26f40..5fc853eb330 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b74670ae256..38893b5e680 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -56,7 +56,7 @@
 #include "trace.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 
 /* ------------------------------------------------------------------------ */
 
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index 4f03ef4ba9a..e108be054c9 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -20,7 +20,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "system/dma.h"
 
 int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
diff --git a/hw/usb/pcap.c b/hw/usb/pcap.c
index dbff00be252..bb74d046a59 100644
--- a/hw/usb/pcap.c
+++ b/hw/usb/pcap.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 
 #define PCAP_MAGIC                   0xa1b2c3d4
 #define PCAP_MAJOR                   2
diff --git a/hw/usb/quirks.c b/hw/usb/quirks.c
index 23ea7a23ea1..44007f8de7a 100644
--- a/hw/usb/quirks.c
+++ b/hw/usb/quirks.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "quirks.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 
 static bool usb_id_match(const struct usb_device_id *ids,
                          uint16_t vendor_id, uint16_t product_id,
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index d603a4a6f96..1a73db68f26 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -43,7 +43,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index ace5eceadd9..783e7f1af0b 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -28,7 +28,7 @@
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/qdev-properties.h"
 
 #include <u2f-emu/u2f-emu.h>
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index fa8d9cdda89..b3206fb7fe4 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 
 #include "u2f.h"
diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index b051a999d3a..d6291852f63 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/usb/hid.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index fa46a7da01c..caf9efbb77c 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -26,7 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index f3cff329244..62d33525bab 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -30,7 +30,7 @@
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/char/pl011.h"
diff --git a/system/vl.c b/system/vl.c
index 5091fe52d92..cdf32c119b2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -54,7 +54,7 @@
 #include "qemu/accel.h"
 #include "qemu/async-teardown.h"
 #include "qemu/exit-with-parent.h"
-#include "hw/usb.h"
+#include "hw/usb/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
 #include "hw/sd/sd.h"
-- 
2.51.1


