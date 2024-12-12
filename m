Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCAFE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh4o-0003Fh-EW; Thu, 12 Dec 2024 06:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4j-0003AZ-CK; Thu, 12 Dec 2024 06:09:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tLh4h-0004Lh-7W; Thu, 12 Dec 2024 06:09:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283dedso4317795e9.3; 
 Thu, 12 Dec 2024 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734001780; x=1734606580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZSWKFnfIAMN5iE7wug+uPaKwVBjU2AVQdzRPCzB0xc=;
 b=Es5vIgUa3PMYC+9ouBUP/BlAy2d+fMDkvC+vvPO9UGHL4i+Tm1zNa5iYUlvab4MpGE
 NG7hhsXrQWZwMnYu5vLO74f9RFjyAb6xeiC8ceJvS6TaE23ZDS3gR8A+1nilhbLuf3gd
 GoSrP4tZU9gsZtnGCuBzd4ZNM7ay0fa5g7gSIyLDOG2SuAWCYNGNb3IT405WgIbR7Yru
 NUSW4MHV28ZAa8wCyq/quGOeRYNQxdA8DkZVq7Eh9hSoh11WBN74tdpNYp7fEzSAN8ku
 +OB0XHNAVHRYLjSX1Xh9dw/Rjw5MH0XisqBg7bEDvp2CleaVoSAHwt4fhps9/x2SXx0P
 mRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734001780; x=1734606580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZSWKFnfIAMN5iE7wug+uPaKwVBjU2AVQdzRPCzB0xc=;
 b=bD9vyRFrjoHDQSID/nytnaF5/7at8NxasV6mw9hCWetB0eKo+jNScO/OEFWYRFjLFT
 yUovuqyIoGCwY2rg3XtT9/NToT4IOxmZssIwWsyFJFI+E/Km9rKM0KJOtZ2f+AsDTCVl
 KyeU64NP0HrQLnj8sgpw2yFun5FSAtnLFUO5uH0l782NuMzszm9Ex5Uwewyssc55+Vdd
 wTA8FINAOgJ1r3KXOIlPe83cfV5oFttOl0opzx7hnlxruG3zlnThlJt6WgNCmfjA4330
 YLkuuZZqsmfGWI7q5qWjYFvwmiyzZajLqY5zgzuC6S9Al58tc15eIotbpOYmRDRW2hlU
 SrTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3gPsNeCKJBYNrpF0qedhxI6kSQ6aousZWz7rRjyov+esituhNpj9vXhXNlMfw3TtgYwNQsriYq6m7qw==@nongnu.org,
 AJvYcCXDteWzCUtDwZtpThupLx7XdXUTwTxA1Z2CJIiZRN7WQkrHugQsxGhAkWDDGez1+B11xhO65N+gHg==@nongnu.org
X-Gm-Message-State: AOJu0YyUY4HcuLqdxvKlQUZv7cP/uZDx5VWzgVfFZldkGuL7f4JPxAcF
 WxAkFwo+yK8ZvQOMCNCJYxcg8tS02F7T9BC5M1c2N3EpjTqKr7BIbViAPA==
X-Gm-Gg: ASbGncvwGGdidyNS6gcU863sgWk+fPnS89llbCeNSJjoZlPh/eNotdSYSnlyC6PrSe1
 isssU9YS7IjkyhPHLmTNIXbGB7TeGW66edeCw+vpY9WAz8ABI136LAvhD6bjPQhCoauLLDMCXmS
 8M0V8xPSUdbExc6HlUZ4q6c1rDUjy1SQ/YFLEGHEZAP7ltvBUtljzW9Dx7yLsNqF9H8v5mC6iUL
 xkuyMIzASQ008w05GZFxWq9JKg1ftz03pGeWuSzLk3k+doqEGMY6+TU/+VITIE0JMOSbBg6qulT
 HAR6llajMYrsAzQ9tNfxe9eOWv+WuxMy7cl3EXlJ+d0=
X-Google-Smtp-Source: AGHT+IGm7OtnhT3biPP7dRk7Wl1TJ00c7Ekb4C9zRTMXsVUae5CRr6NLq1VWEQmoyMrwYFb2n6/bAQ==
X-Received: by 2002:a05:600c:4450:b0:434:fdbc:5cd1 with SMTP id
 5b1f17b1804b1-4362287f2c2mr24310405e9.33.1734001780120; 
 Thu, 12 Dec 2024 03:09:40 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-242-029.77.11.pool.telefonica.de. [77.11.242.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ebe1sm13200725e9.19.2024.12.12.03.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 03:09:39 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 1/2] hw/ide/ahci: Decouple from PCI
Date: Thu, 12 Dec 2024 12:09:25 +0100
Message-ID: <20241212110926.23548-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212110926.23548-1-shentey@gmail.com>
References: <20241212110926.23548-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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
---
 hw/ide/ahci-internal.h    |  1 -
 include/hw/ide/ahci-pci.h |  2 ++
 include/hw/ide/ahci.h     |  2 --
 hw/ide/ahci.c             | 39 ++++-----------------------------------
 hw/ide/ich.c              | 19 +++++++++++++++----
 5 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/hw/ide/ahci-internal.h b/hw/ide/ahci-internal.h
index 7e63ea2310..a318f36811 100644
--- a/hw/ide/ahci-internal.h
+++ b/hw/ide/ahci-internal.h
@@ -25,7 +25,6 @@
 #define HW_IDE_AHCI_INTERNAL_H
 
 #include "hw/ide/ahci.h"
-#include "hw/pci/pci_device.h"
 #include "ide-internal.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
diff --git a/include/hw/ide/ahci-pci.h b/include/hw/ide/ahci-pci.h
index c2ee616962..face1a9a4a 100644
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
index ba31e75ff9..ac0292c634 100644
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
index 0eb24304ee..5836aa924b 100644
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
index b311450c12..c99a44df8e 100644
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
2.47.1


