Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DC8E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9d-0005ZH-Mv; Fri, 13 Dec 2024 18:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8x-0003nm-K8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8v-00037E-P1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso24207425e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132739; x=1734737539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFgo5/cFMtDhVHAmYBsAsdqAE3yRetip0LB681CLyVs=;
 b=KVoMYy1kmwVrqX5U5YZ9wf7x3yd6CTzBxgeSFBkuzrTwyazuz9gKqK1zhZ/BX+zUGW
 LX0OoWmh5+2MF+/MgHwEWcgBKKSAhnQPQKIAvo+ANBZTIBexBu8zWnh6lRlP9bbMIM3W
 qetOnXGAbBEx8bE+TqGX84CvQz/6b79KUFOfDVkcfHAccOoorbKZqpkyTD482JxJNcfg
 yPWNxNE6egHUl3kofADRCa9d1qPdTPzwF87KEmH8RYqV4NMRdJx+MT7BBq3tTSj/1ir2
 YJkyCFhpUtPYOEdFauPsS7M43/+quRNvDYq3xAGipDFeEHmg9Y+N3BB7Bc4lkyrdOJ58
 Q2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132739; x=1734737539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFgo5/cFMtDhVHAmYBsAsdqAE3yRetip0LB681CLyVs=;
 b=d/Pp5u/q3kSRyAfpWhyKvD16tSuJTK0jyfqy39YDEwTWnHBTzQ+vfMsVZ2Fmt4jgJa
 BRav0xdW4E9NV1C8QncuX4tdf6VrfXwy1RC8dNs5bQBuUWKKpZcJIWgl/+RmJEFa8sPx
 EcxIbQ/PEhcYGiCwaqqIhmfmvSbZ7a+YH6z7oUmRLqflmJJba2LAuHGSalOuhfjbU4Tc
 qsXrnd07FyG7MDydV7yVPz4y8yI0GbNqA5lgPRmVVPCDQbYBuHPCeq1UowpLnMkmZ/VY
 gLad+dsLOb815GK1Ugd0BDUGc5YJpoVyhTwOgRSadHJLT8CvTU+eQtpn1hy0Q1mqPAjs
 6t9Q==
X-Gm-Message-State: AOJu0YxBy0Zkx3ScE+76UutJyeiv2RtBTy0Xr2FrJlHBYcW/03vRxgKm
 OTyMi7jHnH3o3+FNK2U5KOQB6jyYwDYkk5MJEE85eQDX4F7Gvn6wn2O5pdpvfhwxVzth6mrckBl
 fFcY=
X-Gm-Gg: ASbGncu9wLLS7GPRhR+eUuOs4jDlt1z2rrTV13/wpuRxUhOky0kbykngOFC7Jhe7g5H
 gOluVfBzQ+msQogKWt3i5jrni/Ndb4pDE668o87e0IvESKmhGgn27hF69O6sTU4byqNEGTYJrQq
 liJ07SzN6LhF40em4uCbPJqv9v9/Cq2qu/S8CVI5bZP6vi9uUCdpwotxW4BHDntAxcv40vdXIks
 CeaJSqvveA0TOZQBigBC4F6U5Jl339ZlFmHrzQhUwQtuOUrYqcgS/6QwRVkoiKArglbUvKSQ2h4
 En+XWg==
X-Google-Smtp-Source: AGHT+IF2K5W+YYWu/0e67Th7Crz0XrJobf95gjSCqdpQAQj4NETpewvUX+QBwSt/LxaMMI5d/ySCXg==
X-Received: by 2002:a05:600c:1da6:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-4362aa27ef1mr36088575e9.11.1734132739181; 
 Fri, 13 Dec 2024 15:32:19 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e322328sm81348935e9.0.2024.12.13.15.32.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/20] hw/ide/ahci: Decouple from PCI
Date: Sat, 14 Dec 2024 00:30:51 +0100
Message-ID: <20241213233055.39574-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

In some adhoc profiling booting Linux VMs, it's observed that ahci_irq_lower()
can be a hot path (10000+ triggers until login prompt appears). Even though the
parent device never changes, this method re-determines whether the parent device
is a PCI device or not using the rather expensive object_dynamic_cast()
function. Avoid this overhead by pushing the interrupt handling to the parent
device, essentially turning AHCIState into an "IP block".

Note that this change also frees AHCIState from the PCI dependency which wasn't
reflected in Kconfig.

Reported-by: Peter Xu <peterx@redhat.com>
Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241212110926.23548-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci-internal.h    |  1 -
 include/hw/ide/ahci-pci.h |  2 ++
 include/hw/ide/ahci.h     |  2 --
 hw/ide/ahci.c             | 39 ++++-----------------------------------
 hw/ide/ich.c              | 19 +++++++++++++++----
 5 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/hw/ide/ahci-internal.h b/hw/ide/ahci-internal.h
index 7e63ea23102..a318f36811c 100644
--- a/hw/ide/ahci-internal.h
+++ b/hw/ide/ahci-internal.h
@@ -25,7 +25,6 @@
 #define HW_IDE_AHCI_INTERNAL_H
 
 #include "hw/ide/ahci.h"
-#include "hw/pci/pci_device.h"
 #include "ide-internal.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
diff --git a/include/hw/ide/ahci-pci.h b/include/hw/ide/ahci-pci.h
index c2ee6169625..face1a9a4a4 100644
--- a/include/hw/ide/ahci-pci.h
+++ b/include/hw/ide/ahci-pci.h
@@ -9,6 +9,7 @@
 #include "qom/object.h"
 #include "hw/ide/ahci.h"
 #include "hw/pci/pci_device.h"
+#include "hw/irq.h"
 
 #define TYPE_ICH9_AHCI "ich9-ahci"
 OBJECT_DECLARE_SIMPLE_TYPE(AHCIPCIState, ICH9_AHCI)
@@ -17,6 +18,7 @@ struct AHCIPCIState {
     PCIDevice parent_obj;
 
     AHCIState ahci;
+    IRQState irq;
 };
 
 #endif
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index ba31e75ff9b..ac0292c634f 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -37,8 +37,6 @@ typedef struct AHCIControlRegs {
 } AHCIControlRegs;
 
 typedef struct AHCIState {
-    DeviceState *container;
-
     AHCIDevice *dev;
     AHCIControlRegs control_regs;
     MemoryRegion mem;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb24304eef..5836aa924bb 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -23,8 +23,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/pci/msi.h"
-#include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
@@ -34,8 +32,6 @@
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "hw/ide/pci.h"
-#include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "ahci-internal.h"
 #include "ide-internal.h"
@@ -179,34 +175,6 @@ static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
     return val;
 }
 
-static void ahci_irq_raise(AHCIState *s)
-{
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
-    trace_ahci_irq_raise(s);
-
-    if (pci_dev && msi_enabled(pci_dev)) {
-        msi_notify(pci_dev, 0);
-    } else {
-        qemu_irq_raise(s->irq);
-    }
-}
-
-static void ahci_irq_lower(AHCIState *s)
-{
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
-    trace_ahci_irq_lower(s);
-
-    if (!pci_dev || !msi_enabled(pci_dev)) {
-        qemu_irq_lower(s->irq);
-    }
-}
-
 static void ahci_check_irq(AHCIState *s)
 {
     int i;
@@ -222,9 +190,11 @@ static void ahci_check_irq(AHCIState *s)
     trace_ahci_check_irq(s, old_irq, s->control_regs.irqstatus);
     if (s->control_regs.irqstatus &&
         (s->control_regs.ghc & HOST_CTL_IRQ_EN)) {
-            ahci_irq_raise(s);
+        trace_ahci_irq_raise(s);
+        qemu_irq_raise(s->irq);
     } else {
-        ahci_irq_lower(s);
+        trace_ahci_irq_lower(s);
+        qemu_irq_lower(s->irq);
     }
 }
 
@@ -1608,7 +1578,6 @@ static const IDEDMAOps ahci_dma_ops = {
 
 void ahci_init(AHCIState *s, DeviceState *qdev)
 {
-    s->container = qdev;
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for now */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
                           "ahci", AHCI_MEM_BAR_SIZE);
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b311450c12d..c99a44df8e1 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -61,7 +61,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
@@ -91,6 +90,19 @@ static const VMStateDescription vmstate_ich9_ahci = {
     },
 };
 
+static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int level)
+{
+    PCIDevice *pci_dev = opaque;
+
+    if (msi_enabled(pci_dev)) {
+        if (level) {
+            msi_notify(pci_dev, 0);
+        }
+    } else {
+        pci_set_irq(pci_dev, level);
+    }
+}
+
 static void pci_ich9_reset(DeviceState *dev)
 {
     AHCIPCIState *d = ICH9_AHCI(dev);
@@ -102,7 +114,9 @@ static void pci_ich9_ahci_init(Object *obj)
 {
     AHCIPCIState *d = ICH9_AHCI(obj);
 
+    qemu_init_irq(&d->irq, pci_ich9_ahci_update_irq, d, 0);
     ahci_init(&d->ahci, DEVICE(obj));
+    d->ahci.irq = &d->irq;
 }
 
 static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
@@ -125,8 +139,6 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     /* XXX Software should program this register */
     dev->config[0x90]   = 1 << 6; /* Address Map Register - AHCI mode */
 
-    d->ahci.irq = pci_allocate_irq(dev);
-
     pci_register_bar(dev, ICH9_IDP_BAR, PCI_BASE_ADDRESS_SPACE_IO,
                      &d->ahci.idp);
     pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
@@ -161,7 +173,6 @@ static void pci_ich9_uninit(PCIDevice *dev)
 
     msi_uninit(dev);
     ahci_uninit(&d->ahci);
-    qemu_free_irq(d->ahci.irq);
 }
 
 static void ich_ahci_class_init(ObjectClass *klass, void *data)
-- 
2.45.2


