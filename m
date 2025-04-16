Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEAFC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiI-00042P-QB; Wed, 16 Apr 2025 20:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiH-00041j-Hz
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:41 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiF-0006PT-6I
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:41 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2c873231e7bso87434fac.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848157; x=1745452957;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIdhZ2B/3rXlZaDDyS0TejvZV6gKym2suKu1qn0P8JA=;
 b=DO8BhJqznondnC4X6ZJ5FiU5Yc5XakvIl4JFoN944Ke7wMyY3kEVA8XJQzSr5CJbuT
 8lY06wUa9JnQ3ELANJUZ+SqYNMgS50rFAq1FDHI/L1c4B5pTcm3x1qUBLdXVAm7cAPoH
 P+/DJZXSQULudzEiyDwkay7TYY2z+p4nQpwnDZh8zhrkktrSpq7tg/g0GsZahWVuGeMA
 TCq/s1xmw4GppXROBlC0Bmbkpft9p9DqQN0zgSEXehbvv4KdMv8im1IO3/8MSUYq7EBL
 9gGkMCad+9W4vgVRk4p9RtPq4EV9hXNChF4efP40P67bkpQ2zT5X34S9GD+HrzP6cjjd
 c32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848157; x=1745452957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIdhZ2B/3rXlZaDDyS0TejvZV6gKym2suKu1qn0P8JA=;
 b=j51bjMK/HgciUAqzB+5PK8UNzFWgVBo/oo+2ICzGPRusZhV+D7gRsIfgvHDMFXhV16
 ySEBh3U/3rL+wpWIv803i5NmQ+Q9/nwdExFEgvSbrgAzg6S30lQB5fsMf1GdqGthio7z
 /gxsIB87p/rZp9OaMFJnWJp9KIUuyDimjRorUspm3MXCzoECL7p0HxgJHyWXL7hV6ZhX
 bsE5R5MM+aXGAhyAYj/VcbpGtcP8urnqnntBj/sx9DQamnKrbSThwqwXSfv6V28JZ5kf
 SyStR4Leh8CHhJFylXQM7V6QT07ZYIpQvLLnqr+55Le/YUUCFDuJql1UF481qoW9I/dv
 JmZg==
X-Gm-Message-State: AOJu0YxET8V+2lMXWEz1yh+omXFKlEc3v0j8GKs1CzjytHcsmp7a/60H
 v4L53x4/7k2uCux4WbY97VLCSfMfSfXzxIbgXtIC1NKvK2HyIJ61sb8pxUs9a0Tv1TAgbu325GA
 g
X-Gm-Gg: ASbGnct6j5SoPsiU3elBJ5qE5/MHdK2A7vdO6FkcAXHtuB/vk95y0r+Fa3Ohf4B48d6
 BL70C2Zn8YeOKtF/XE7KO1V1iCPzIS3WbAxBGETz/C2V3JCKFNGamVURrZm7s5FCxIWbePQ8k6u
 WP8sVE/mOjfEJL6osqSN0734eFeId+OILsahi6AOKwBhNoCHri6lGQzKZvJkHyP0AuOZW6U1ONZ
 q9NWMJXOnEyzkOsl2LECuLm7IUWjnlG0RH7QJwdBWQSs4xcRCaKZi6EnJgM21I6EEThKN1Lhbvf
 3VPnVlPx1nU5wqbnChKZLoXzIhIt5Yv4J+U=
X-Google-Smtp-Source: AGHT+IG2cMd/BU3tAfNVeKS09RJKPMhdcxjeyIM847yQJD8CKw7fokY9PKdtm4U5oGGF+LcHezpckg==
X-Received: by 2002:a05:6870:a691:b0:296:e491:b244 with SMTP id
 586e51a60fabf-2d4d2d4cf78mr2309004fac.32.1744848156715; 
 Wed, 16 Apr 2025 17:02:36 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-2d0969589c5sm3561396fac.17.2025.04.16.17.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:35 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Corey Minyard <corey@minyard.net>
Subject: [PULL 3/6] ipmi: add fwinfo to pci ipmi devices
Date: Wed, 16 Apr 2025 18:59:07 -0500
Message-ID: <20250417000224.3830705-4-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=corey@minyard.net; helo=mail-oa1-x36.google.com
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

This requires some adjustments to callers to avoid possible behaviour
changes for PCI devices.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250401140153.685523-3-npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[Rename pci_ipmi_bt_get_fwinfo to pci_ipmi_kcs_get_fwinfo in the
 pci_ipmi_kcs.c file.]
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/acpi/ipmi.c             |  3 ++-
 hw/ipmi/isa_ipmi_bt.c      |  1 +
 hw/ipmi/isa_ipmi_kcs.c     |  1 +
 hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
 hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
 hw/smbios/smbios_type_38.c |  7 ++++++-
 include/hw/ipmi/ipmi.h     |  5 +++++
 7 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index a20e57d465..39f8f2f6d6 100644
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
index 474a792c9a..76585e786e 100644
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
index 94bbe45d35..ba3ae208b2 100644
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
index a3b742d22c..7ba8b3ab96 100644
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
index 05ba97ec58..0aa35143e9 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
     uint32_t uuid;
 };
 
+static void pci_ipmi_kcs_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
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
index 168b886647..e9b856fcd9 100644
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
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 77a7213ed9..c8ef04856e 100644
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
-- 
2.43.0


