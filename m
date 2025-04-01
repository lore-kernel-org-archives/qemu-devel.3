Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CFEC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcC9-0000FH-37; Tue, 01 Apr 2025 10:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBv-00080Z-3x
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBp-0000OS-39
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227b828de00so96340205ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516122; x=1744120922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+ABrKfm/rYFZh07EREo75/DEQTswgSkd0DOb9POvlE=;
 b=RIPMp09vQlGnvvfXco+TZSAfoQ/gPOTOsyduZUoGogUPFelikBwWJycD0Q+KNQIAFP
 HFO1okNlPc/cIm2WtnUQrj76hk2DDWmzBIr7urlAfbm5jbrgd3JqU+8ZRyudhoU4b/2l
 EoECersGKimTZDCG6big7q3WIE45on3LPDUywX9xykcozQcxxyT3Wflz9ojBXjGou1JQ
 xbYuu0xyg8Z+8g2/V2Yiq3O9Coqxm3jH5uaOAKv6usoTQjyBfcywRVL1x/+pL37EKPF7
 A5vwb1eueICUeGioc78O6SKfkqGpRh/N8WexuB0OkCu+6c7tDnMktXXVF1s7xvh+03kT
 xPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516122; x=1744120922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+ABrKfm/rYFZh07EREo75/DEQTswgSkd0DOb9POvlE=;
 b=rR74wHB5ipmfN2vcbGqH4RGVB04yfajfqrbhvMdzXiI2fenBta3SNwU+9IGek9oKFo
 t+foHH1HuqkRcJZ4A5+vsz+Vq3IzFeLBC9OhR7r502mF0SMhYwf5OH25cOy/2CK3PaWB
 1gBzn7H/cIzHX5737LITrZU05YrehYAEeVezq8ivU5GGUNjlxkFy5QAiDludpoI79NG5
 Yq4sxM+hMhlGyqMfEQ9V/1NOBgyDSqPw4AEefe9T+OdEK4IIlqMPBka3HXRj+2zZFspB
 uHFFFXdwMItPYIFC0iek5dVZJYPGTbbiJ1AeOBba8/ifkEdKvSb929fFbaf1u9goMaEN
 VJ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMJmtx60GbDQ96eM8Q3EqpQamiZXicdPAnns6da8FhoVeUmQs7N+mDsJT21JLkd4RY7ApRGiUkaCmz@nongnu.org
X-Gm-Message-State: AOJu0YyqUYQLjTV0p9ib/sVIoH+OvVQ7bF8FUi5YQxraKfZ4DPaaacvQ
 RdWeCkZmlMgLg5r7gZ0LSLdjkiScB3eenkoNwILw9/6SvtyOW8XK
X-Gm-Gg: ASbGncu2hxo4E1fQLaFdYdofBKPlu0HPIfd1+NX9mJPEJMx6T7zV/stSpdeK3qNRefy
 oLyeu+libt3DDPaaRDkYeA85Ysf62EV3wlIq+/RhMTdi1H8mhpErL4z5s6HpsXC7W07QCIkqIk/
 qUYc36WXzFa7gRztaRXKrCtlLb7oMrZlfSvAF08xl0u2hZmHIvVB+6+KFxY2m7Ws6IR7tHJ2olC
 DoNTSpaNaKQFrFOuh2NUlv25mEBporUy+8AtsAZ8R/JRcSFEn3ZCatd2fMTYE4WCUXlUOp7QVjf
 Pfe1uiWauvzZ6kUboO8GJ0MFU0a1CYGZWa+UzRiZPlFmSV5SQA==
X-Google-Smtp-Source: AGHT+IEiixtcvUdMi1HkfFhjN04uuYA1SULV7plH8XQ3+lFWSjAUalOKxyt2f9Imh9mYYit4HNIz+g==
X-Received: by 2002:a17:902:ce0b:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-2292f9e62d6mr243273175ad.38.1743516122524; 
 Tue, 01 Apr 2025 07:02:02 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:02:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] ipmi/pci-ipmi-bt: Rename copy-paste variables
Date: Wed,  2 Apr 2025 00:01:48 +1000
Message-ID: <20250401140153.685523-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
References: <20250401140153.685523-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

IPMI drivers use p/k suffix in variable names depending on bt or kcs.
The pci bt driver must have come from the kcs driver because it's
still using k suffixes in some cases. Rename.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/pci_ipmi_bt.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index afeea6f3031..a3b742d22c9 100644
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
2.47.1


