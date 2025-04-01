Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D60C3601C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcC7-00009M-TX; Tue, 01 Apr 2025 10:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBt-000801-QO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBq-0000Op-Sv
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2260c915749so77006985ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516125; x=1744120925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVKM3029lMeTcWku9SWqhpQOq5EOsKo0n1lE7JWTaOQ=;
 b=G8jwHpQkG6dUS+Kr3ryUtBPJv8ml2dM+DzFyaWM65PRPCBca5mZu9VuTsru4YSdvIX
 PJatv02ZTCHqckpHBk/UnfIjWHIKBZuMlJNpaUtPq+sP/cypzpE/VZ1bTHO5kJ3mUlXu
 O+Yw5uNWhUjtm1vxx9SFAzysJyL2UoQTRJQalZLrzMkyeYtiGzj7BaWvoznQWcIKa0sV
 U+8Sxu9fcV5wHnSwJ/EXuFBEFwCHxshPSQbJRNiQBlwoZpj4zH0qZDv+ONEIO9cvQjqG
 Ne6171cNBfUddfRWcVUY7vfG4XhX9q6gcQ1SYf1upcGQAY2jOOUMjEoWrIY2CtPKv58d
 JuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516125; x=1744120925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVKM3029lMeTcWku9SWqhpQOq5EOsKo0n1lE7JWTaOQ=;
 b=QsWzqAwWYv+8r2OINENUiZqCty8kqo3+B0G3ci5Ba9aq2tWVjX/UzoYoOF7I2b+iIf
 8+v/0ioxcI2pwQrgD7aBTvnm/Nd3mrlL3GY8VWE92ElpS8LdUyM3hkDpCSNiyLpwxmZV
 KUloOKIxvx/61Ec3jKPTNDQbbp1J3x8kJRpjAfDlQ4io4nC0wDJ1NU26bvwAEhhnbRYU
 Qd/ng+PGbWoKueadATB3EICYTP2ARgCLD8ITOrBSQKqB+HmauViDYJDYPZN9au8lPh0v
 1H2p2iqzKaMtOmeWPKZVZx932q7JhoDIgl3gdtZNCkKrth66C1ysammTbb3ocvM+DwDW
 +m7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEH6vbLch1F1QUwLc3JcX0HXCNoknrFZBulXsYcfLJHV2O0ynanosv7BhnP2DXmTp7jT0wNe5qmi9U@nongnu.org
X-Gm-Message-State: AOJu0YyVtAuK7vljla4qHaIc0UTbstgcJfo+fbDp4wJJyBB8sm45gppX
 xLIJWMe6zXDd0iOHbSq93j8t7Piqn4sZQ9vbT4jjikRgZnoFgHXS2La0zw==
X-Gm-Gg: ASbGncvv8RYbKy6lGQyrMeG0D3VUGqHBvaG8iLdi1hXIpQsmN3M8xYfvSux8PMBQ4dr
 JHvY9ab99AkZAOEYqWyO7ctnIX25t9bDIkGnFSFTS0tf5X9FU9RPPw1GZSwnQMD7k4zrWhqTD0w
 A+J6FN3N5FdGMBMqEk3VF0Fp9oRMkrPWOMircDNjpgb04tJfkAyMeb3p1lt3ou/pqo+9akizNa5
 8Bs79SnPMdlEdNnaGxtPxp/Y1hZr+teTN2grcEjxr7BRO4O5JHhvbfsyeNNjh6baHIhCzFyBGh8
 2rPuGdiHUU6ICzGb0Er30CSSh9Aq6Fqy8CFdl9oK2+dYh7xB5g==
X-Google-Smtp-Source: AGHT+IFYlCwYRaT6oTo903I6HHFJBFZ9/Dp4yHbL8L5s3Dn0GiHFu/NgLGr6VQrUhtQLb8+GkBsGlw==
X-Received: by 2002:a17:903:1b27:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-2292f9f0a70mr190854285ad.39.1743516125554; 
 Tue, 01 Apr 2025 07:02:05 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:02:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] ipmi: add fwinfo to pci ipmi devices
Date: Wed,  2 Apr 2025 00:01:49 +1000
Message-ID: <20250401140153.685523-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
References: <20250401140153.685523-1-npiggin@gmail.com>
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

This requires some adjustments to callers to avoid possible behaviour
changes for PCI devices.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ipmi/ipmi.h     |  5 +++++
 hw/acpi/ipmi.c             |  3 ++-
 hw/ipmi/isa_ipmi_bt.c      |  1 +
 hw/ipmi/isa_ipmi_kcs.c     |  1 +
 hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
 hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
 hw/smbios/smbios_type_38.c |  7 ++++++-
 7 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 77a7213ed93..c8ef04856e1 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
     } memspace;
 
     int interrupt_number;
+    enum {
+        IPMI_NO_IRQ = 0,
+        IPMI_ISA_IRQ,
+        IPMI_PCI_IRQ,
+    } irq_source;
     enum {
         IPMI_LEVEL_IRQ,
         IPMI_EDGE_IRQ
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index a20e57d465c..39f8f2f6d68 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -55,7 +55,8 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
         abort();
     }
 
-    if (info->interrupt_number) {
+    /* Should PCI interrupts also be appended? */
+    if (info->irq_source == IPMI_ISA_IRQ && info->interrupt_number) {
         aml_append(crs, aml_irq_no_flags(info->interrupt_number));
     }
 
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a1b66d5ee82..4a6496b5980 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
     ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
 
     ipmi_bt_get_fwinfo(&iib->bt, info);
+    info->irq_source = IPMI_ISA_IRQ;
     info->interrupt_number = iib->isairq;
     info->i2c_slave_address = iib->bt.bmc->slave_addr;
     info->uuid = iib->uuid;
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d9ebdd5371f..31d16aba74e 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
 
     ipmi_kcs_get_fwinfo(&iik->kcs, info);
+    info->irq_source = IPMI_ISA_IRQ;
     info->interrupt_number = iik->isairq;
     info->uuid = iik->uuid;
 }
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index a3b742d22c9..7ba8b3ab965 100644
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
+    info->irq_source = IPMI_PCI_IRQ;
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
index 05ba97ec58f..c817f1e8808 100644
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
+    info->irq_source = IPMI_PCI_IRQ;
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
index 168b886647d..e9b856fcd96 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -72,7 +72,12 @@ static void smbios_build_one_type_38(IPMIFwInfo *info)
                      " SMBIOS, ignoring this entry.", info->register_spacing);
         return;
     }
-    t->interrupt_number = info->interrupt_number;
+    if (info->irq_source == IPMI_ISA_IRQ) {
+        t->interrupt_number = info->interrupt_number;
+    } else {
+        /* TODO: How to handle PCI? */
+        t->interrupt_number = 0;
+    }
 
     SMBIOS_BUILD_TABLE_POST;
 }
-- 
2.47.1


