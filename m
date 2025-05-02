Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7A3C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7w-0004TT-Ry; Thu, 01 May 2025 23:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7s-0004Ob-Q9
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7q-0001IC-SG
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so2263225b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156705; x=1746761505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeR84shn1uCIwX+MVAuYfPQUwyqvqMWtDUSdpiM/Vf0=;
 b=Yx8ZgMq34MkA1SM/rlXpxDwRX7zQzHEmC09AGqbagWb2rkf+Nzv2B7/W6OKoZxsRCS
 /whsiRmhgd15xEkFYPeH/huLwg3e/Sf65y7qkws/91NDgqfSSzJUStJzlNVkkAgrHr/5
 s6yK6mAY2x6E2tiRaAwqcy5kiGTiwDKv8XFPyVibjWnqfh2D7vZjr75sSnDnU2185VSn
 Ek/EqTUIOAssh0G9Zwo6oJYYMnVlkG7XdKK3G3pJ9w7eDuDVNVJOn+G2lTyFs49pGFof
 qUJdWJbQjaDV7C4voYpFhQbIz66qaHdKm6oBKxNYdwXfYX/n7j4oPuZrsl5WYd/vUw0B
 alxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156705; x=1746761505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeR84shn1uCIwX+MVAuYfPQUwyqvqMWtDUSdpiM/Vf0=;
 b=mkYFarbdI+oBgZMqcgYC7swtHbSKg1lhkIM6QGNqAtD4H5M/1l/emSc5sZIqd31UdV
 fcdejD6HBbUyhT9t8/lc0ZRq7HBI82whsPH4y/CK3aDCemIKIYb3uVMnJkdgfnWJUjPj
 rlhsO3V8fFZ3zpRqecGKo+zK4ofz4FH91ApusoZgqzy6eNfKJvpZR/DauX001CSLb0Mq
 zb32xXhjxcAkiUPH+86BXp0civAxs24+72thf3lGbgXkgocN0JGky7bYq5LLumsh4EEV
 i5khf9cVN6oX+hNhRXWHI2kQabuOjEXqDB2s7mglPvPRu1gSxn0/aTLVW2JHZakrlExf
 wB2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGntsEWOLuLJGCDnXbVOqskySQYh8XCUCCFikd4uvN0h2XLmB9ZiyBHR7LW7dO7fxRswGpYQun/0jK@nongnu.org
X-Gm-Message-State: AOJu0YwQyYw4CAkdGiYXQKvcjUmCNK6PbwOocIwREt1W0HWgk/AaemVY
 UzlLF+mcMhXcrbQUnNoLY0hXtDte7pMSibLtjbXc5HvpitKNTuio
X-Gm-Gg: ASbGncvSEpF9g49vOYTN11enF81VXcq3Hb2k6IOaXMWJbYAThWrCq89VpG03UfR9QtX
 XR6GRLdi76UciAdaBY8DXMJjmYc+ZL10QQDWPB0wDEaVkTk3w7IZVz3r1IQtTrL67TdeHRg/clx
 JguTlzgImv6MSiMHHXO9de7Hi0OwBx14S66HM/u1YGSJXI/+diEYXKQGdtX5SZYbNVnB4JPHR4l
 iQ5un5KUW7ymX/SSkC1VpO+DvQIIklkD4xnXpMcG9W5ShvrX+rGmhGL50FqZbXw7iXqFu25rYax
 YDxNeSnnghITYjqJqRLOHKVfCWB2ZMKZxgTczyK9JK7X
X-Google-Smtp-Source: AGHT+IFsoaqa8a+O0tlV+R8CFEkKBC9rnE5eKSdU7jYSs9xg/eDrN8FqkdfzrN+TWgg0WDGCC8f+hg==
X-Received: by 2002:a05:6a00:2992:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-74058a55711mr1749434b3a.14.1746156705382; 
 Thu, 01 May 2025 20:31:45 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 09/22] hw/usb/hcd-xhci-pci: Make PCI device more
 configurable
Date: Fri,  2 May 2025 13:30:33 +1000
Message-ID: <20250502033047.102465-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
 hw/usb/hcd-xhci-pci.h |   9 ++++
 hw/usb/hcd-xhci-pci.c | 118 +++++++++++++++++++++++++++++++++---------
 2 files changed, 103 insertions(+), 24 deletions(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 5b61ae84555..09aabae6e01 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -41,6 +41,15 @@ typedef struct XHCIPciState {
     OnOffAuto msi;
     OnOffAuto msix;
     bool conditional_intr_mapping;
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
index b93c80b09d8..911daf7e51f 100644
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
@@ -120,6 +117,31 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
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
@@ -128,7 +150,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
 
     dev->config[PCI_CLASS_PROG] = 0x30;    /* xHCI */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin 1 */
-    dev->config[PCI_CACHE_LINE_SIZE] = 0x10;
+    dev->config[PCI_CACHE_LINE_SIZE] = s->cache_line_size;
     dev->config[0x60] = 0x30; /* release number */
 
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
@@ -144,40 +166,78 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
         s->xhci.nec_quirks = true;
     }
 
-    if (s->msi != ON_OFF_AUTO_OFF) {
-        ret = msi_init(dev, 0x70, s->xhci.numintrs, true, false, &err);
-        /*
-         * Any error other than -ENOTSUP(board's MSI support is broken)
-         * is a programming error
-         */
-        assert(!ret || ret == -ENOTSUP);
-        if (ret && s->msi == ON_OFF_AUTO_ON) {
-            /* Can't satisfy user's explicit msi=on request, fail */
-            error_append_hint(&err, "You have to use msi=auto (default) or "
-                    "msi=off with this machine type.\n");
+    if (s->pm_cap_off) {
+        if (xhci_pci_add_pm_capability(dev, s->pm_cap_off, &err)) {
             error_propagate(errp, err);
             return;
         }
-        assert(!err || s->msi == ON_OFF_AUTO_AUTO);
-        /* With msi=auto, we fall back to MSI off silently */
-        error_free(err);
     }
+
+    if (s->msi != ON_OFF_AUTO_OFF) {
+        ret = msi_init(dev, s->msi_cap_off, s->xhci.numintrs,
+                       true, false, &err);
+        if (ret) {
+            if (ret != -ENOTSUP) {
+                /* Programming error */
+                error_propagate(errp, err);
+                return;
+            }
+            if (s->msi == ON_OFF_AUTO_ON) {
+                /* Can't satisfy user's explicit msi=on request, fail */
+                error_append_hint(&err, "You have to use msi=auto (default) "
+                                  "or msi=off with this machine type.\n");
+                error_propagate(errp, err);
+                return;
+            }
+            error_free(err);
+            err = NULL; /* With msi=auto, we fall back to MSI off silently */
+        }
+    }
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
+        if (ret) {
+            if (ret != -ENOTSUP) {
+                /* Programming error */
+                error_propagate(errp, err);
+                return;
+            }
+            if (s->msix == ON_OFF_AUTO_ON) {
+                /* Can't satisfy user's explicit msix=on request, fail */
+                error_append_hint(&err, "You have to use msix=auto (default) "
+                                  "or msix=off with this machine type.\n");
+                error_propagate(errp, err);
+                return;
+            }
+            error_free(err);
+            err = NULL; /* With msix=auto, we fall back to MSI-X off silently */
+            /* Should we unregister BAR and memory region here? */
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
@@ -214,6 +274,16 @@ static void xhci_instance_init(Object *obj)
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
2.47.1


