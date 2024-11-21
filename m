Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3FD6E2A7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE40i-0004Ae-9i; Thu, 21 Nov 2024 05:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE40d-00040a-PC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:02:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE40c-000692-2F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:01:59 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso492136f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 02:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732183315; x=1732788115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pGj58m+Vwzu7KfW3YTaiVXOTXVXViIn2zLD/4MTPWG4=;
 b=HTS9zP5x8DoTlC3Bd1/fpfPBOMzno3FDn5pFSjAkhBywRt6YVzXfJ6x3jPF5+POgrm
 hyRcpfmfa5nQvamcYJxlPDvgcgI+V8Pnj2gR4wrUVaNTjR+yC50sbV24bXiPvsSuqrDO
 2gVza+WfYhTjKs+aIC8DaYVqY94oPKReRhBZhhxMAOtj2GJyKZkpv9/Qm+O3WJjRR2kc
 1FbG56H5Z8UKjj+kW2j1u+Auzb4PodOZIMEgrWywjGQ+7V60La02kcU287oa1QbVja0k
 cTYozFVTVARpPrBfvcH2NxHemZgmWz+rlBhAWQ2lkbPWOzkg4I7zV3M9DgOSBZVcZKg4
 QH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732183315; x=1732788115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pGj58m+Vwzu7KfW3YTaiVXOTXVXViIn2zLD/4MTPWG4=;
 b=pFvp94UbBpj50EZDYItq8XBDjHUpoaeLsKwAnrpnXIkOSUBZtUipZpOKAwXXuMnWcU
 niLBHeA6ZYhEWP/6KKA5D0qA5rwdl/q1AtePLv9DkvsWLxhcKdezFZJHjzQxtDZK7yNM
 XAuGRzmnxN+cNUUSUZIMpmeIV0xqHhWmWy6PwAELCAjtxUeHB5MZMsPu9F58obKv40P9
 WxAH21iQgZ483DnRuDjMv5UK6oXTZWFC5TxGbuNMfiaxFLPbFoG/n+891jm9d73xgyEI
 TqJBDWy91bLh4mQYB9gr/5xSGdZeHZyvYILENUWFZ9xS/EdY7LixXa9yg+KIdXEGek3d
 AhZA==
X-Gm-Message-State: AOJu0YwL+ivWM/myIMUkBbR7aSdtfpnw30lODY0FJZcVXdVg6x644Fe3
 PUYrYzqjWXwO73DkWPaxqWN+KNlp0sMySmPt3gF41vatHGkHxh3bF4gTMCiaTDWSAQyBNlRXnT3
 T
X-Google-Smtp-Source: AGHT+IFPilQe2Br1yRVqpLEPGKiW5g7LVOyhyqE73BeVj3EOmkiwA4gtqrPTXh7gOjduBsaqyrCWtA==
X-Received: by 2002:a05:6000:1543:b0:381:cffc:d40b with SMTP id
 ffacd0b85a97d-38254b15a5dmr4993596f8f.39.1732183315532; 
 Thu, 21 Nov 2024 02:01:55 -0800 (PST)
Received: from localhost.localdomain ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825494ca3fsm4486989f8f.111.2024.11.21.02.01.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Nov 2024 02:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH] hw/ide/ahci: Check for PCI device once in ahci_init()
Date: Thu, 21 Nov 2024 11:01:52 +0100
Message-ID: <20241121100152.65476-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

object_dynamic_cast() is expensive; IRQ helpers are certainly
a bad place to call it. Since the device type won't change at
runtime, resolve it once when the AHCI context is initialized
in ahci_init().

Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h |  2 +-
 hw/ide/ahci.c         | 17 +++++------------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index ba31e75ff9..f6d977610d 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -37,7 +37,7 @@ typedef struct AHCIControlRegs {
 } AHCIControlRegs;
 
 typedef struct AHCIState {
-    DeviceState *container;
+    PCIDevice *pci_dev;
 
     AHCIDevice *dev;
     AHCIControlRegs control_regs;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb24304ee..f2eb3b527b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -181,14 +181,10 @@ static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
 
 static void ahci_irq_raise(AHCIState *s)
 {
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
     trace_ahci_irq_raise(s);
 
-    if (pci_dev && msi_enabled(pci_dev)) {
-        msi_notify(pci_dev, 0);
+    if (s->pci_dev && msi_enabled(s->pci_dev)) {
+        msi_notify(s->pci_dev, 0);
     } else {
         qemu_irq_raise(s->irq);
     }
@@ -196,13 +192,9 @@ static void ahci_irq_raise(AHCIState *s)
 
 static void ahci_irq_lower(AHCIState *s)
 {
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
     trace_ahci_irq_lower(s);
 
-    if (!pci_dev || !msi_enabled(pci_dev)) {
+    if (!s->pci_dev || !msi_enabled(s->pci_dev)) {
         qemu_irq_lower(s->irq);
     }
 }
@@ -1608,7 +1600,8 @@ static const IDEDMAOps ahci_dma_ops = {
 
 void ahci_init(AHCIState *s, DeviceState *qdev)
 {
-    s->container = qdev;
+    s->pci_dev = (PCIDevice *)object_dynamic_cast(OBJECT(qdev), TYPE_PCI_DEVICE);
+
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for now */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
                           "ahci", AHCI_MEM_BAR_SIZE);
-- 
2.45.2


