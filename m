Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6EFC369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiM-00043b-KB; Wed, 16 Apr 2025 20:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiH-00041a-BE
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:41 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiE-0006Oz-4B
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:41 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d4f832069cso37018fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848154; x=1745452954;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzXuptyfA7vE3ZbsycUlzR4fD6qnLS7kWEbUQxzoB+U=;
 b=gSzAK2dN/xfq4t6annjx2X7lOU1Mqb+XkvZ+ZBGWd94ZmFMUJ819xGJFa7D2rTw6Ri
 IC6SRb0uwEdF2Ocrhgu+3nTA963KklVX0WRlKnkd4bJ/YN4jlrUynnz2YjQ3vrNfj6dx
 rMdkadwlfhXaGtX3hw7lxGtzCxhne6bTK6/y0V/WhUiyCb+V8DC0Q6aubE3lfW71bTmD
 RgXkiKJCPkfVMKVU8ZiRVvyVMWB4OUgGfSYr0Hz5//sP55YyldA4t9ksVqloa1Wbw4ir
 PEKwrhMosOe5zAAac+gNXP9Key9D56Te5raCwk8KtJ1WD/ybBkyoxcdnGxNnI1LaG857
 b32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848154; x=1745452954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzXuptyfA7vE3ZbsycUlzR4fD6qnLS7kWEbUQxzoB+U=;
 b=XE8ZJCGPJSIUhGCMB4ZtlEfOZUXCapXOKf5wGOR0b99iB453fjzWAwTnngdaa9RSyc
 plQ39WLiOTXHIj9ET7Ddw2Im/tIflQmSnNywl0CktfkiDDoixn35vjAuUlDm/WqGGtPS
 vIv/RwnuerCsugGLVSNmVgxpM1rvxulK/O7mNDQNW66ISe6TmLe+SKTt75JMIf3+V37c
 WF8aliJL2Hog1czzNUfEBCX7Saag3lJ0jWYogB3yFgw3Zi1dmSbfCmAQ9kC7axJrSaa9
 6a3D7Y6ZWnPjrNffivcAzVqGnHAG0/X7kJ9fN1uhCzkfCtLrkaQv0zjJcFe2OJooCgER
 EE3g==
X-Gm-Message-State: AOJu0YwN5irT6T5pioYb2WMeo5Y5IHqQg9Xv7wk5GXA3O9ShdsAAiw2o
 BI6/fJ+VCSEeMwSuIuzNBEcjizH7eFBqS80jK6Fp1Sf9AETSJYTvQOMfQGsJGGY7Qb5SHkK0byZ
 E
X-Gm-Gg: ASbGncvQRWc1M0gz3WFHCts2lEkkQV/jbiwVqBfY62ymcjTQR0S0ftou4eAVWCCDYSH
 Ctfh7XdAQjP6h8csaQm0FY2qRMrE3xGPTRhOPa+k5r2KiVTzuWND3W0DIOV95ED8q2DNzvpyFZG
 Da2kEc+yUo7b8clwYl5fBE8Xc7UFBGoQD27DLJqJsrm1GBaosZ2lwudedGqDoQ81hE3ofWWeo8w
 zAEdVnK2EIto7k6ujprTtUvGbdbCt/+fXNTanWqfo1uvQMEcrjiZ9ljxl+yrla/c2zfV43fJ+Y/
 jfUgNNzFbRZkwT+vgDInshi5cbgfVpRp0r8=
X-Google-Smtp-Source: AGHT+IHHzpy7vlfoXR1mB9zg5dmFIRS8zc6I9ZcIbddgYQgmMDzYeBaDyut9ZbKYtlOp8mL5WJxmsg==
X-Received: by 2002:a05:6870:164f:b0:29e:5dfd:1e17 with SMTP id
 586e51a60fabf-2d4d2b9da6fmr2097251fac.23.1744848153562; 
 Wed, 16 Apr 2025 17:02:33 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-72e73e4d81dsm3040194a34.54.2025.04.16.17.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:33 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <corey@minyard.net>
Subject: [PULL 2/6] ipmi/pci-ipmi-bt: Rename copy-paste variables
Date: Wed, 16 Apr 2025 18:59:06 -0500
Message-ID: <20250417000224.3830705-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=corey@minyard.net; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

IPMI drivers use p/k suffix in variable names depending on bt or kcs.
The pci bt driver must have come from the kcs driver because it's
still using k suffixes in some cases. Rename.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250401140153.685523-2-npiggin@gmail.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/pci_ipmi_bt.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index afeea6f303..a3b742d22c 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -38,49 +38,49 @@ struct PCIIPMIBTDevice {
     uint32_t uuid;
 };
 
-static void pci_ipmi_raise_irq(IPMIBT *ik)
+static void pci_ipmi_raise_irq(IPMIBT *ib)
 {
-    PCIIPMIBTDevice *pik = ik->opaque;
+    PCIIPMIBTDevice *pib = ib->opaque;
 
-    pci_set_irq(&pik->dev, true);
+    pci_set_irq(&pib->dev, true);
 }
 
-static void pci_ipmi_lower_irq(IPMIBT *ik)
+static void pci_ipmi_lower_irq(IPMIBT *ib)
 {
-    PCIIPMIBTDevice *pik = ik->opaque;
+    PCIIPMIBTDevice *pib = ib->opaque;
 
-    pci_set_irq(&pik->dev, false);
+    pci_set_irq(&pib->dev, false);
 }
 
 static void pci_ipmi_bt_realize(PCIDevice *pd, Error **errp)
 {
     Error *err = NULL;
-    PCIIPMIBTDevice *pik = PCI_IPMI_BT(pd);
+    PCIIPMIBTDevice *pib = PCI_IPMI_BT(pd);
     IPMIInterface *ii = IPMI_INTERFACE(pd);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
 
-    if (!pik->bt.bmc) {
+    if (!pib->bt.bmc) {
         error_setg(errp, "IPMI device requires a bmc attribute to be set");
         return;
     }
 
-    pik->uuid = ipmi_next_uuid();
+    pib->uuid = ipmi_next_uuid();
 
-    pik->bt.bmc->intf = ii;
-    pik->bt.opaque = pik;
+    pib->bt.bmc->intf = ii;
+    pib->bt.opaque = pib;
 
     pci_config_set_prog_interface(pd->config, 0x02); /* BT */
     pci_config_set_interrupt_pin(pd->config, 0x01);
-    pik->bt.use_irq = 1;
-    pik->bt.raise_irq = pci_ipmi_raise_irq;
-    pik->bt.lower_irq = pci_ipmi_lower_irq;
+    pib->bt.use_irq = 1;
+    pib->bt.raise_irq = pci_ipmi_raise_irq;
+    pib->bt.lower_irq = pci_ipmi_lower_irq;
 
     iic->init(ii, 8, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pik->bt.io);
+    pci_register_bar(pd, 0, PCI_BASE_ADDRESS_SPACE_IO, &pib->bt.io);
 }
 
 const VMStateDescription vmstate_PCIIPMIBTDevice = {
@@ -96,16 +96,16 @@ const VMStateDescription vmstate_PCIIPMIBTDevice = {
 
 static void pci_ipmi_bt_instance_init(Object *obj)
 {
-    PCIIPMIBTDevice *pik = PCI_IPMI_BT(obj);
+    PCIIPMIBTDevice *pib = PCI_IPMI_BT(obj);
 
-    ipmi_bmc_find_and_link(obj, (Object **) &pik->bt.bmc);
+    ipmi_bmc_find_and_link(obj, (Object **) &pib->bt.bmc);
 }
 
 static void *pci_ipmi_bt_get_backend_data(IPMIInterface *ii)
 {
-    PCIIPMIBTDevice *pik = PCI_IPMI_BT(ii);
+    PCIIPMIBTDevice *pib = PCI_IPMI_BT(ii);
 
-    return &pik->bt;
+    return &pib->bt;
 }
 
 static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
-- 
2.43.0


