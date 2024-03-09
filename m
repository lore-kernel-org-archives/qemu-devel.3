Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750CC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riyhF-0001bm-WE; Sat, 09 Mar 2024 10:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaacwoods.home@gmail.com>)
 id 1riyax-0000oM-IA
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:26:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaacwoods.home@gmail.com>)
 id 1riyav-00080z-Uz
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:26:43 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e570ef661so1735644f8f.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709998000; x=1710602800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ROlM7I2/Q0FRFFC9PzXEvxysq3NaBgaLvX4fUXCMr7o=;
 b=liVD8YLXfiqlIUS9FGHWTuyQoJK9+aezcgEND5i5jHGSMaVMXE4Xnk2M+RN1uI+g62
 QonqXqXcl91nu1eaLrRa3wwfKhywu5gLxkx9OKhB2FDhoUT2+03lefjkrVYVLgnUo5SP
 Z5CzJsrY86JwF3wTTircb/25vCj3lVLsNaUJQ2A8Jcj+YdeQ1GZxEx9KPkU2Qx8RiT3m
 AVUP4guYycjybBs2260XWlyoEZremASEcudwdmU+v+Q8Jt4g7YscctKE85ZwM1ESXciy
 iedHFnLQAWHlJYI77FGovLhYc+krJoDZz2Ro1ExxsJu+5x3USDcjFbJf9Vazztgq1Dgc
 Of2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709998000; x=1710602800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROlM7I2/Q0FRFFC9PzXEvxysq3NaBgaLvX4fUXCMr7o=;
 b=sFVMaale1owoll4iUbGko1M+cwYy0tcCd6rXbByIfB3fqeW0BbUh/h7cnCCbKcKc6j
 NkcbLxR+Z9Z2G+GicvZoRTmynoc6OAXkslEFhus+qArSmCPAn0LeNQwjY7ZF1Sruud9f
 xcDOZSZUY6YBkmVUkdFrAj/9tpnAKoalczHtZ/lmwC7DTMFe9V8Aw0A5AFKwxprpohgp
 kRHcEoF+0nq24Xpcgy1aOd7kQqXXOw1Jwq4sRCAnzOLuVFaJemHvye5nO0kvqxYFgsWw
 2n7iWj8WUlt5kwK6I3vhxS1kFCa9/CZdcQJVqsB1EK7VxsFlLQT8krK6AlX/pGGX9zs+
 ZOkA==
X-Gm-Message-State: AOJu0YwhiVwosTT0mTQ2ThfYe0iXvaISs/sunedB21J3Ewyb+5J+MH9A
 xLVTPIFIUXp389MlmOfyl6zTKoLchALYtceW6fbYAEoGblPHphh9T0CZ+6gsFMI=
X-Google-Smtp-Source: AGHT+IECqvNfIT16bDadP3C2wDslIRHt0w0wN/8lvUs/sh2v4tUZq7qYHHuTvuJC4NNsuUBGRnCcPA==
X-Received: by 2002:a5d:628e:0:b0:33d:c5c7:417d with SMTP id
 k14-20020a5d628e000000b0033dc5c7417dmr1678869wru.43.1709998000039; 
 Sat, 09 Mar 2024 07:26:40 -0800 (PST)
Received: from localhost.localdomain (25.58.198.146.dyn.plus.net.
 [146.198.58.25]) by smtp.gmail.com with ESMTPSA id
 g5-20020a5d6985000000b0033d6c928a95sm2054647wru.63.2024.03.09.07.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 07:26:39 -0800 (PST)
From: Isaac Woods <isaacwoods.home@gmail.com>
To: qemu-devel@nongnu.org
Cc: isaacwoods.home@gmail.com
Subject: [PATCH] usb: add support for sending MSIs from EHCI PCI devices
Date: Sat,  9 Mar 2024 15:26:34 +0000
Message-ID: <20240309152634.30291-1-isaacwoods.home@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=isaacwoods.home@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 09 Mar 2024 10:33:12 -0500
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

This is a small patch that aims to add support for sending
message-signalled interrupts from EHCI controllers on PCI busses.
This was desirable for guests (in my case a hobbyist OS) that do not
have support for legacy PCI interrupt routing but still want to / have to
interface with EHCI controllers. I would guess most real EHCI
controllers would not bother to support MSI, but it doesn't seem
unreasonable to me for the QEMU one to when connected to a PCIe bus.

This is my first contribution to QEMU, and so was modelled entirely off
the XHCI controller's MSI support. I have tested it on RISC-V using the
PLIC, which correctly receives the traditionally-wired interrupt, and
using MSI, where the device is able to successfully dispatch an MSI
to a IMSIC.

This is also my first experience of `git send-mail` so please forgive
any errors with the patch email.

Signed-off-by: Isaac Woods <isaacwoods.home@gmail.com>
---
 hw/usb/hcd-ehci-pci.c    | 27 +++++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c |  7 +++++++
 hw/usb/hcd-ehci.c        |  2 +-
 hw/usb/hcd-ehci.h        |  2 ++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 3ff54edf62..8a714b6733 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -21,6 +21,8 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
+#include "hw/pci/msi.h"
+#include "qapi/error.h"
 
 typedef struct EHCIPCIInfo {
     const char *name;
@@ -30,11 +32,27 @@ typedef struct EHCIPCIInfo {
     bool companion;
 } EHCIPCIInfo;
 
+static void ehci_pci_intr_update(EHCIState *ehci, bool enable)
+{
+    EHCIPCIState *s = container_of(ehci, EHCIPCIState, ehci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    if (msi_enabled(pci_dev)) {
+        if (enable) {
+            msi_notify(pci_dev, 0);
+        }
+    } else {
+        pci_set_irq(pci_dev, enable);
+    }
+}
+
 static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
 {
     EHCIPCIState *i = PCI_EHCI(dev);
     EHCIState *s = &i->ehci;
     uint8_t *pci_conf = dev->config;
+    Error *err = NULL;
+    int ret;
 
     pci_set_byte(&pci_conf[PCI_CLASS_PROG], 0x20);
 
@@ -68,8 +86,17 @@ static void usb_ehci_pci_realize(PCIDevice *dev, Error **errp)
     s->irq = pci_allocate_irq(dev);
     s->as = pci_get_address_space(dev);
 
+    s->intr_update = ehci_pci_intr_update;
+
     usb_ehci_realize(s, DEVICE(dev), NULL);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mem);
+
+    ret = msi_init(dev, 0x70, 1, true, false, &err);
+    if (ret) {
+        error_propagate(errp, err);
+    } else {
+        error_free(err);
+    }
 }
 
 static void usb_ehci_pci_init(Object *obj)
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index fe1dabd0bb..e08c856e2b 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -38,6 +38,11 @@ static Property ehci_sysbus_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void usb_ehci_sysbus_intr_update(EHCIState *ehci, bool level)
+{
+    qemu_set_irq(s->irq, level);
+}
+
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(dev);
@@ -70,6 +75,8 @@ static void ehci_sysbus_init(Object *obj)
     s->portnr = sec->portnr;
     s->as = &address_space_memory;
 
+    s->intr_update = usb_ehci_sysbus_intr_update;
+
     usb_ehci_init(s, DEVICE(obj));
     sysbus_init_mmio(d, &s->mem);
 }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 01864d4649..e1f71dc445 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -209,7 +209,7 @@ static inline void ehci_update_irq(EHCIState *s)
     }
 
     trace_usb_ehci_irq(level, s->frindex, s->usbsts, s->usbintr);
-    qemu_set_irq(s->irq, level);
+    (s->intr_update)(s, level);
 }
 
 /* flag interrupt condition */
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 56a1c09d1f..bc017aec79 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -305,6 +305,8 @@ struct EHCIState {
     EHCIQueueHead aqueues;
     EHCIQueueHead pqueues;
 
+    void (*intr_update)(EHCIState *s, bool enable);
+
     /* which address to look at next */
     uint32_t a_fetch_addr;
     uint32_t p_fetch_addr;
-- 
2.44.0


