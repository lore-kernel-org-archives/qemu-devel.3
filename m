Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC7CC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2o-0002HW-QW; Tue, 01 Apr 2025 07:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2c-0002Eq-IM
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2a-0003gq-L8
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227aaa82fafso103660275ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507863; x=1744112663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abqmG11qmy0obbVwbtOGTx26xYrlI7gTbGbsVaL0y1o=;
 b=DOqCuaBLwqAA7sUb8M/PiZKZLkKMr9m/V8gR7j412pLqNX/tM7pRSH6josdL/5pwRk
 1aE0xyJt8ZUxQkDKZbi5zFKqlA3QrOGQsJ2W0Rqwb345aCrPr7boXySb/x4hEpx/kV6W
 FIPxTSN9INUVjLYeqJ5DmaousZmdN1dnTC/15P73SzuE71VoJi9roZ4Wso41GoKZP7N4
 pJesRGuoQyUSBbSg9WCemdk1OcllXad1i8mHtvPF8mlAFw3ZXuhXE+KsDbh2pmUrXWDB
 upHTdoSl8pK8WKeYjHcK/KPqXMhLrhs6SoZ262Zut+PunfLH/4LCrNu9F0/XF8UvBSpZ
 TheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507863; x=1744112663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abqmG11qmy0obbVwbtOGTx26xYrlI7gTbGbsVaL0y1o=;
 b=qobsJEUDweB9Nxc0nauAkjx16np+n958wzXZm0pgFyY+T3xEQElA8iXaz5M17iashe
 6bhaem6m6c1zFtA/uxnFwrDoqdwO8IqfON3aHwC4aWLS+3QTeLg8aa+bEtvPOIZNLMH1
 jqqdC7bO5vSxqZqf1j62mBD64CTTYQUNp6Aavkww+KvqpkAuDdo7EbIqi3mlTUODzgm4
 Vu+8v2xfKkrM1Pto8oS4SBPpSGckj00phkJXMJHu5YSvAaoyazHb7+FUOikBFC0JdDuh
 tihpxPrquhjtR1XEi8f4YXAdAAPuFo7RgsOffbYUdDLnmKCehhUJAjxMlHrkr+ofa+SB
 paQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpXwudL3Ii/a8YIZQLYOXLmgmSPifACwM7o5+tGAQs25tKgjkB8kfjnOL1CUZlv6Jqry8shNmQ6Ijg@nongnu.org
X-Gm-Message-State: AOJu0YyQYxtK66jPzWFWHKC77HQODRfpyzBa8pmjyNqUO7mnhDByRoIO
 a4hP0N3mm/6TxoHoMuqR4L1t9Ylzrtdrx+EJm3z8QsyKJ9pyqS5OXMt/rQ==
X-Gm-Gg: ASbGnctdHZF+LaDTvZOD8uBy6EkS7Qotw7SLo/boR/wwd8oQt7fTICOAKMXNwxRqpbf
 jq6hU6SywSIjJzV2NbFpVgMpVPNuxCeVDxaTFpLC8dPNLqZ95P4Eno3ow2svEQv9ololP3yhuA7
 3AeaZ9Fm9fKVz5ekiUfVX6Z7PhXpP2MtKNsEUuzYAwbFDWSFfHl85WTs4zTSbJ3dD+BcxpRiKQA
 S1c9InLu+U2m8vAvN+PU28DZOgDCGNgzQfkvrxxDUmo3WrPuBd2OaJsiBSM2j+zYQtMzlQt625B
 b13mPzm4nQ8Cm94l1N9d6auirsCdvj8VCZcIm+/vLNKO/3hAgA==
X-Google-Smtp-Source: AGHT+IGdWXcxpWODOJ2PeLcuKR/yKK2AzOx+BgpEzsnCaQKOoGfp6gPmGGLi3QbBYhVBkA9tMGgtaA==
X-Received: by 2002:a17:902:e786:b0:223:64bb:f657 with SMTP id
 d9443c01a7336-2292f9eb871mr193860735ad.46.1743507863254; 
 Tue, 01 Apr 2025 04:44:23 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
Date: Tue,  1 Apr 2025 21:44:09 +1000
Message-ID: <20250401114412.676636-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401114412.676636-1-npiggin@gmail.com>
References: <20250401114412.676636-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

This requires some adjustments to callers to avoid possible behaviour
changes for PCI devices.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ipmi/ipmi.h     |  5 +++++
 hw/acpi/ipmi.c             |  2 +-
 hw/ipmi/isa_ipmi_bt.c      |  1 +
 hw/ipmi/isa_ipmi_kcs.c     |  1 +
 hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
 hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
 hw/smbios/smbios_type_38.c |  6 +++++-
 7 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 77a7213ed93..71c4efac8cd 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
     } memspace;
 
     int interrupt_number;
+    enum {
+        IPMI_NO_IRQ = 0,
+        IPMI_ISA_IRQ,
+        IPMI_PCI_IRQ,
+    } irq;
     enum {
         IPMI_LEVEL_IRQ,
         IPMI_EDGE_IRQ
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index a20e57d465c..c81cbd2f158 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -55,7 +55,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
         abort();
     }
 
-    if (info->interrupt_number) {
+    if (info->irq == IPMI_ISA_IRQ && info->interrupt_number) {
         aml_append(crs, aml_irq_no_flags(info->interrupt_number));
     }
 
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a1b66d5ee82..b5556436b82 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
     ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
 
     ipmi_bt_get_fwinfo(&iib->bt, info);
+    info->irq = IPMI_ISA_IRQ;
     info->interrupt_number = iib->isairq;
     info->i2c_slave_address = iib->bt.bmc->slave_addr;
     info->uuid = iib->uuid;
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d9ebdd5371f..326115f51bb 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
 
     ipmi_kcs_get_fwinfo(&iik->kcs, info);
+    info->irq = IPMI_ISA_IRQ;
     info->interrupt_number = iik->isairq;
     info->uuid = iik->uuid;
 }
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index a3b742d22c9..33ff7190ee8 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -38,6 +38,17 @@ struct PCIIPMIBTDevice {
     uint32_t uuid;
 };
 
+static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
+{
+    PCIIPMIBTDevice *pib = PCI_IPMI_BT(ii);
+
+    ipmi_bt_get_fwinfo(&pib->bt, info);
+    info->irq = IPMI_PCI_IRQ;
+    info->interrupt_number = pci_intx(&pib->dev);
+    info->i2c_slave_address = pib->bt.bmc->slave_addr;
+    info->uuid = pib->uuid;
+}
+
 static void pci_ipmi_raise_irq(IPMIBT *ib)
 {
     PCIIPMIBTDevice *pib = ib->opaque;
@@ -125,6 +136,7 @@ static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
 
     iic->get_backend_data = pci_ipmi_bt_get_backend_data;
     ipmi_bt_class_init(iic);
+    iic->get_fwinfo = pci_ipmi_bt_get_fwinfo;
 }
 
 static const TypeInfo pci_ipmi_bt_info = {
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index 05ba97ec58f..6673b2088ef 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
     uint32_t uuid;
 };
 
+static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
+{
+    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(ii);
+
+    ipmi_kcs_get_fwinfo(&pik->kcs, info);
+    info->irq = IPMI_PCI_IRQ;
+    info->interrupt_number = pci_intx(&pik->dev);
+    info->uuid = pik->uuid;
+}
+
 static void pci_ipmi_raise_irq(IPMIKCS *ik)
 {
     PCIIPMIKCSDevice *pik = ik->opaque;
@@ -125,6 +135,7 @@ static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
 
     iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
     ipmi_kcs_class_init(iic);
+    iic->get_fwinfo = pci_ipmi_kcs_get_fwinfo;
 }
 
 static const TypeInfo pci_ipmi_kcs_info = {
diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index 168b886647d..2823929c258 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -72,7 +72,11 @@ static void smbios_build_one_type_38(IPMIFwInfo *info)
                      " SMBIOS, ignoring this entry.", info->register_spacing);
         return;
     }
-    t->interrupt_number = info->interrupt_number;
+    if (info->irq == IPMI_ISA_IRQ) {
+        t->interrupt_number = info->interrupt_number;
+    } else {
+        t->interrupt_number = 0;
+    }
 
     SMBIOS_BUILD_TABLE_POST;
 }
-- 
2.47.1


