Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79187C02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ2xc-0003Gd-9H; Sat, 18 Jan 2025 02:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xa-0003GJ-Mo
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tZ2xY-0007qy-Sn
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:09:34 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso45360905ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184171; x=1737788971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNO5lCbo8e/XtcQXdeEOm1z3tzxTfEs5Ck6HtIwTvS8=;
 b=ASi6HtQxLUyjt4LBGnqEzwueVSlJ+WcBWk7vWwMG6pCvAVIxdWUa8LFBwiArYJdNoT
 AGzS0hi9Nr1q7hjtfMPZiFY9fWObIhVvzWKEKQc9bG+ssrNRGkOhwX8Wlcm0hiVqlcdZ
 YUucBcfDOAuLU6mtpcn+syS7HrrjTp2t3Zf/1fQcmZKoS2PY0gkq2xCsaZNGv/fpWwxW
 8p1qDYYiy1deuTXOYwgcxl+/0Gt4m3K2ub6ntp2YN1RqmO8SviRDld8C0+2DjPVbp4IL
 RSSNSIviRbPYfjHWTWYs7pqK18Avgp2YEssKHigLvxgHGHXDVytcS7RP0BQqRvMFlng1
 dU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184171; x=1737788971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNO5lCbo8e/XtcQXdeEOm1z3tzxTfEs5Ck6HtIwTvS8=;
 b=sHAoDC++ibafHdX1U++RZRXMQYQee0gzDyaP7im/6O6Lu5hh3qbmRYSF8PSEezeI82
 vy/Iq8OyYzxRC1oGgl6kTyJ0Az6OrbhIr5lQQ/nV/6O738SCR4M2FAuHejedqd4E78CL
 LGceejkSGOlY0plrKXhgFNycW4BluVGR47qrPMXNXpgIbCsg1YES58cxeUvbBg+0P1Vb
 p0MNmM8H9JVkaOgrKE5ssu+DxNDOdGj+dI+hV/TjibsWhOvVG12LL+nSOOPdVj3LByY2
 fxguxUbFevPHGQ+7yWnig25FiYRSenquJh1MeWfDy3unv2Kl9klSZLNHa1BhNQQY9K5G
 jSHA==
X-Gm-Message-State: AOJu0YwgcIeD+nFRHnNeqR74vM20jjsZFkrS5nj/r6DJg4JwSL318zo0
 DFcBPnb1HHXp6DIIYu1oZAhWLkvhsPNa5qPALwPPy/7qW9eelVaEQzoEtg==
X-Gm-Gg: ASbGncuxlCif+WUEvdMq0ZFPx6xXoq9Vi3uZULm8e7cwbKJS2aQt1k/NBbU1FVBvxsk
 RccMVZ5ej3H9YUykkeEmoIduego+B9kt95EfCbgMGVu6uR/3+R/G4v2DhivIphouXHhqZSdOBCt
 YDrX+g5r6CikABbICAuMbt2KG1/Q/VS8VWHSxb6qcUzTCuyUGrCXMkHIqipW9U1ogtxPJPfgemB
 3VULnWMRCiapilZ5vo7+P3QFp4+/YdhaHBQTqQ5t0R61mv+TWEDCIl9maBluDRJybN/nEg1Ylb7
 KU6kDGxS2nuxfoWxV4BwXgUOP0XE
X-Google-Smtp-Source: AGHT+IHTIyDz59+ao77xTX8w8z7Xcv6QgYRVD0mUOErdh75QSiXfyu86OuXYqFjDtKiPIGgnqlt0dg==
X-Received: by 2002:a05:6a00:9082:b0:725:cfa3:bc6b with SMTP id
 d2e1a72fcca58-72daf931c0dmr9001992b3a.3.1737184171026; 
 Fri, 17 Jan 2025 23:09:31 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c95adsm3192880b3a.107.2025.01.17.23.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:09:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 7/8] hw/usb/hcd-xhci-pci: Make PCI device more configurable
Date: Sat, 18 Jan 2025 17:08:52 +1000
Message-ID: <20250118070853.653778-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250118070853.653778-1-npiggin@gmail.com>
References: <20250118070853.653778-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

To prepare to support another USB PCI Host Controller, make some PCI
configuration dynamic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci-pci.h |  9 +++++
 hw/usb/hcd-xhci-pci.c | 87 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 08f70ce97cc..213076aabf6 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -40,6 +40,15 @@ typedef struct XHCIPciState {
     XHCIState xhci;
     OnOffAuto msi;
     OnOffAuto msix;
+    uint8_t cache_line_size;
+    uint8_t pm_cap_off;
+    uint8_t pcie_cap_off;
+    uint8_t msi_cap_off;
+    uint8_t msix_cap_off;
+    int msix_bar_nr;
+    uint64_t msix_bar_size;
+    uint32_t msix_table_off;
+    uint32_t msix_pba_off;
 } XHCIPciState;
 
 #endif
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 49642aab58e..525537c2b7e 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -32,9 +32,6 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define OFF_MSIX_TABLE  0x3000
-#define OFF_MSIX_PBA    0x3800
-
 static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
 {
     XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
@@ -105,6 +102,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
    return 0;
 }
 
+static int xhci_pci_add_pm_capability(PCIDevice *pci_dev, uint8_t offset,
+                                      Error **errp)
+{
+    int err;
+
+    err = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
+                             PCI_PM_SIZEOF, errp);
+    if (err < 0) {
+        return err;
+    }
+
+    pci_set_word(pci_dev->config + offset + PCI_PM_PMC,
+                 PCI_PM_CAP_VER_1_2 |
+                 PCI_PM_CAP_D1 | PCI_PM_CAP_D2 |
+                 PCI_PM_CAP_PME_D0 | PCI_PM_CAP_PME_D1 |
+                 PCI_PM_CAP_PME_D2 | PCI_PM_CAP_PME_D3hot);
+    pci_set_word(pci_dev->wmask + offset + PCI_PM_PMC, 0);
+    pci_set_word(pci_dev->config + offset + PCI_PM_CTRL,
+                 PCI_PM_CTRL_NO_SOFT_RESET);
+    pci_set_word(pci_dev->wmask + offset + PCI_PM_CTRL,
+                 PCI_PM_CTRL_STATE_MASK);
+
+    return 0;
+}
+
 static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 {
     int ret;
@@ -113,7 +135,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 
     dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
-    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
+    dev->config[PCI_CACHE_LINE_SIZE] = s->cache_line_size;
     dev->config[0x60] = 0x30; /* release number */
 
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
@@ -126,8 +148,16 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
         s->xhci.nec_quirks = true;
     }
 
+    if (s->pm_cap_off) {
+        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
     if (s->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, s->xhci.numintrs, true, false, &err);
+        ret = msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
+                       true, false, &err);
         /*
          * Any error other than -ENOTSUP(board's MSI support is broken)
          * is a programming error
@@ -144,22 +174,47 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
         /* With msi=auto, we fall back to MSI off silently */
         error_free(err);
     }
+
     pci_register_bar(dev, 0,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &s->xhci.mem);
 
     if (pci_bus_is_express(pci_get_bus(dev))) {
-        ret = pcie_endpoint_cap_init(dev, 0xa0);
+        ret = pcie_endpoint_cap_init(dev, s->pcie_cap_off);
         assert(ret > 0);
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        MemoryRegion *msix_bar = &s->xhci.mem;
+
+        if (s->msix_bar_nr != 0) {
+            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
+                               "xhci-msix", s->msix_bar_size);
+            msix_bar = &dev->msix_exclusive_bar;
+            pci_register_bar(dev, s->msix_bar_nr,
+                             PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_TYPE_64,
+                             msix_bar);
+        }
+
+        ret = msix_init(dev, s->xhci.numintrs,
+                        msix_bar, s->msix_bar_nr, s->msix_table_off,
+                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
+                        s->msix_cap_off, &err);
+        if (ret == -ENOTSUP && s->msi == ON_OFF_AUTO_AUTO) {
+            /* report that msix is not supported, but do not error out */
+            warn_report_err(err);
+        } else if (ret == -ENOTSUP) {
+            /* Can't satisfy user's explicit msix=on request, fail */
+            error_append_hint(&err, "You have to use msix=auto (default) or "
+                    "msix=off with this machine type.\n");
+            error_propagate(errp, err);
+            return;
+        } else if (ret < 0) {
+            error_propagate(errp, err);
+            return;
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
@@ -196,6 +251,16 @@ static void xhci_instance_init(Object *obj)
     PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
     object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
+
+    s->cache_line_size = 0x10;
+    s->pm_cap_off = 0;
+    s->pcie_cap_off = 0xa0;
+    s->msi_cap_off = 0x70;
+    s->msix_cap_off = 0x90;
+    s->msix_bar_nr = 0;
+    s->msix_bar_size = 0;
+    s->msix_table_off = 0x3000;
+    s->msix_pba_off = 0x3800;
 }
 
 static const Property xhci_pci_properties[] = {
-- 
2.45.2


