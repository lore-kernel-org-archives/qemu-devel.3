Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9728E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLevq-0002NP-Ph; Thu, 12 Dec 2024 03:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevo-0002Mv-AW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:25 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLevm-0002lt-Ju
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:52:24 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166360285dso3157715ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733993541; x=1734598341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqMgDyS/l8eCxN3HBlrmLCvVeUlDr9ZsDvWkPHsCIbQ=;
 b=mJc5Ua3fNHQGb8v2m4Y/6Zlej7V1yWLOxwVfDc36sJh6BdA4bkdYCh+5ts38QAsCPg
 mJhEt7AP09Pzsm41qliccY3Tc9mwwM7ibD3LZueeb7hoQspLhcrAYyDDUxM8YGTSJcWn
 i66ovNwLAGAyCEVLjfB3fLG2sp4fsAu1F8FAJltLLHDstPzvuIYiY4a89zC5UPZ1d2mO
 Cu9mCb5tedEWvzaDS336SUUUBwR/vhyOyJDVIrfDJt1CQ+RpZDtf78GtlB8t20GnMJkI
 GSfW74uQAQxrtjl0kQBAoJ8ioTzfNSAqM+1Z40Z5Zanubuabm3qemDiMV2w8xWwRvbrl
 a8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733993541; x=1734598341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqMgDyS/l8eCxN3HBlrmLCvVeUlDr9ZsDvWkPHsCIbQ=;
 b=D8UzXTQspM2VK7QZhqcwPT5GkwcOGM7dWQd/gt+SAH3DeN2A4jmiRrcfACJm97LBXg
 r7DDfBghju2kVTHNxUQtJBWcP7jz2rX3F1tquXJpTOTm6y8gnlhekzOIy4aMbKTPZrrO
 x1XrVcubegMRMJiqEIotqczCFN2posjx0ks6gvEHYaNMj3+w/a7IfoKzgdeVfGQXxO5e
 L1bk51nNx22iCWvQfD3EhpoioetkfNqoT4SXUOv9tO5LW656rx+iP5mbSXEei/d6K53A
 l109j7J+jpCo+RNEsNDKfJsrYin2Gz78s6yNZMpSdGPlNTCiOokY7XlA1wZEHSKJ3rH7
 mPHw==
X-Gm-Message-State: AOJu0YwiP9q96AaJxwr6LcMAM8Fes9nkraMOLVBmQiVdpyROHR2tasHa
 gZyu/DaCMg4nZs5x5QI78eIrGx6/CaFymKaRXIesI26S7pLbE/FCq5HDdQ==
X-Gm-Gg: ASbGnctT95+vFtaPilH1sPSCx+Cx5pMhCTn+YJddDQnetukWZrdICPw+VLf0KKbDZs7
 V8dx9e47hUzimx7yWbdhocgH0yRq0Qv5jDaJ8fbaGu04CnbKxWMKAC+k4SGCbzU+54F8baM4Nuw
 NkxtnINAhManZYfi8A/icGJELmecDE0IHs2y6HwvPc7em7lgg26tiF/Ghh8e+9cZYHPRGwwba8f
 Xq7b8OMP0VibV6X12EaMT1C2W4nSxn2vUN5Jroi9Q8FRQKmEV8LbiyvJh4=
X-Google-Smtp-Source: AGHT+IEJPucrZdleTJABo4X1yPpi/WcCRglTJDEBoNyODlvDLrbPFFDuoKY27hEf13Fk4InPV/eObA==
X-Received: by 2002:a17:902:ce0d:b0:216:501e:e321 with SMTP id
 d9443c01a7336-2178af064ebmr46508605ad.56.1733993540687; 
 Thu, 12 Dec 2024 00:52:20 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0a736sm118402375ad.217.2024.12.12.00.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:52:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/usb/hcd-xhci-pci: Make PCI device more configurable
Date: Thu, 12 Dec 2024 18:52:06 +1000
Message-ID: <20241212085207.1439501-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212085207.1439501-1-npiggin@gmail.com>
References: <20241212085207.1439501-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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
 hw/usb/hcd-xhci-pci.h |  9 ++++++
 hw/usb/hcd-xhci-nec.c | 10 +++++++
 hw/usb/hcd-xhci-pci.c | 69 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 10 deletions(-)

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
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 0e61c6c4f06..6ac1dc7764c 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -52,6 +52,16 @@ static void nec_xhci_instance_init(Object *obj)
 
     pci->xhci.numintrs = nec->intrs;
     pci->xhci.numslots = nec->slots;
+
+    pci->cache_line_size = 0x10;
+    pci->pm_cap_off = 0;
+    pci->pcie_cap_off = 0xa0;
+    pci->msi_cap_off = 0x70;
+    pci->msix_cap_off = 0x90;
+    pci->msix_bar_nr = 0;
+    pci->msix_bar_size = 0;
+    pci->msix_table_off = 0x3000;
+    pci->msix_pba_off = 0x3800;
 }
 
 static void nec_xhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a6..948d75b7379 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -32,8 +32,9 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define OFF_MSIX_TABLE  0x3000
-#define OFF_MSIX_PBA    0x3800
+#define MSIX_BAR_SIZE   0x800000
+#define OFF_MSIX_TABLE  0x0000
+#define OFF_MSIX_PBA    0x1000
 
 static void xhci_pci_intr_update(XHCIState *xhci, int n, bool enable)
 {
@@ -104,6 +105,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
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
@@ -112,7 +138,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 
     dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
-    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
+    dev->config[PCI_CACHE_LINE_SIZE] = s->cache_line_size;
     dev->config[0x60] = 0x30; /* release number */
 
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
@@ -125,8 +151,16 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
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
@@ -143,22 +177,37 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
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
+        if (s->msix_bar_nr != 0) {
+            memory_region_init(&dev->msix_exclusive_bar, OBJECT(dev),
+                               "xhci-msix", s->msix_bar_size);
+            msix_bar = &dev->msix_exclusive_bar;
+        }
+
+        ret = msix_init(dev, s->xhci.numintrs,
+                        msix_bar, s->msix_bar_nr, s->msix_table_off,
+                        msix_bar, s->msix_bar_nr, s->msix_pba_off,
+                        s->msix_cap_off, errp);
+        if (ret) {
+            return;
+        }
+
+        pci_register_bar(dev, s->msix_bar_nr,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         msix_bar);
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.45.2


