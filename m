Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E35C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2h-0002Eo-Md; Tue, 01 Apr 2025 07:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2a-0002CU-0c
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2Y-0003gO-8w
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22403cbb47fso112603525ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507861; x=1744112661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugeKs6g/oa3KlXrLQxSFvqiVP+uJ1JdglOF1rGtI7eo=;
 b=RtfP1AxieG3IT4CPcG7ehSCmRglC03IrEPLVDYWTpfxb5RSDGgRzT3SHHzdgIz3LuT
 oglh1a5BB2grZ3Xs3NvNVPEZQU7NLit4PRSMa0WREQ0GRJjP2Pg5Chl+l6ZC+1yb/3RK
 ReFemNxPAOfS5qEAIphK+4mbjqu38pDp0o3ms+zl7/izkenqZSlucB+Dv9KzC5+/Pbaq
 OVwlG8+6nQl4zipiHytjPHdbWsofNT0VAwlSG1usKmRImDSgsMiwRsD61iYglOMuO4DI
 0n7d2lpOWzrSVGdqIAz4vdLslyWwe96GNHa+spJqtic887cfeLBXa8F7a2BQs4IOFoxf
 06qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507861; x=1744112661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugeKs6g/oa3KlXrLQxSFvqiVP+uJ1JdglOF1rGtI7eo=;
 b=BRTICasGnQQYxpK98abH8Jm6nfWFkvrpfZqQFgdsyWjXh1DBwnr8OLlF8B81Hn9QdT
 bttNj6E+qd2DAV/n50EhZnKwO4iNtj0eZedMSdS+HEICwgmDd8ZKNepV2hnSGYz9ntsY
 O09X9/0I+St7ETVQGB+28H6JEtdR0QaX6xyGK6OjC37rhTDhbSvTlEV71eTKbg4HjJM+
 jeXi96S8kQhCNBvXD2Bcpmic68kyulAWW4ZDie9xf6MFqSQ3S2lsgFp5Pz/s+tAJ1Abg
 ztwbG0lBwbeQFJS0hTeYANox01eAJjJHbkvcQsf9+18hZuwB/VoOqK1XQwIel7K+ugkm
 jkzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFAeew/uLeb6DER0S0W0gS/hw+BejyzbII+CVZQzLEfxQ4SIgco1/d0enchOe9P5SjYsSUXo5EIV9d@nongnu.org
X-Gm-Message-State: AOJu0Yyvu62T0SLMLvQHVquHPsmt97GEf4LaIjo0/hcJZuEA7Uis+3f+
 HUprcT2clAQk9HRZYMFdHLRe9RI/Pz9FsyKP/qtKSaYbMDM5zwtR
X-Gm-Gg: ASbGncvxmTYrsF5zITuttU9XlvHwA2OoKgR0cOe4KyX/HLV0f3keBorDubR/EEmCTtD
 3roJ06CGWztKc9f8S/7Fq3lqn69X1S/RZDBDdpV9Hket1/tuyPnfXVZ2BaPjcSGbTIkaqbkSpcw
 ugKNOIvE38dKC0oGQwRoHVZI1ng69SxiAJL8ZxoiJUonpJN01mb/BVDj7eUnBbDYIN35t8jIYw8
 R3lPdaNfRpVmpndTCeGD855+1jQfPUBrFhD4yvcKmXaZLuevFH1Xm4Za75WFXnNPatx2Cxquzpv
 Fu+2HnBdspg5L0biEFhafIFpWLuHQCdPINw/vJbkooYf7j0+Bg==
X-Google-Smtp-Source: AGHT+IGPvWpmCXwyG3dfnlADjf2grBr8OkW9krRGUFFWw8VDMLop9+jj4kAZAMKX06uAb3kQuTYM1w==
X-Received: by 2002:a17:903:1b27:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-2292f9f0a70mr184383315ad.39.1743507860799; 
 Tue, 01 Apr 2025 04:44:20 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] ipmi/pci-ipmi-bt: Rename copy-paste variables
Date: Tue,  1 Apr 2025 21:44:08 +1000
Message-ID: <20250401114412.676636-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401114412.676636-1-npiggin@gmail.com>
References: <20250401114412.676636-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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


