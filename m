Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C30C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGEI-0005vi-9g; Thu, 07 Mar 2024 11:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGEG-0005kR-Gw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:20 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGEE-0006S6-Ka
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:20 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dd3bdb6e9eso7686205ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827456; x=1710432256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHMZVEtvnnHB22u3wYO9ijDTPlEvnoumvWUlGS7sTog=;
 b=lVIEl45No1FSalpmtCRh/l8yTRFHGkOatHVVog6IdIm4x87g2qt1OsBMq7cJ2tLRYj
 fAwzjaOnQIV7Cfswwc4ACXvCi9qQ4Ss+XR1/FvduiDTlwVXHPkHBp0EdIzztFINn3Py9
 fN7qdVSEgoCQo6enNgQlspTnaebNBu0vMGHY3tvtYJhOB2gyCSxOG/+EPNpeBcGqUdub
 7kt7pVAhaVYJb5/xDsuoz9DCf9Js/2DS1YcQBM7bmD+Uz9LWxgUo1ZwilGugrIC3eiOG
 GhGhJm03JCs3dhWTuPEbWwJoVOoFisXEpKQk1/aMPHCGKVqOg8IRpnMXFmjmx0NLxXVM
 rZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827456; x=1710432256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHMZVEtvnnHB22u3wYO9ijDTPlEvnoumvWUlGS7sTog=;
 b=LIpLv2r3+Vjtzv7ABJLr00AgaOcocbvVnLirFcqxE5Z8+VRAB9TMEDikecYG5Lco+9
 pqAU4a4VY5fSAVkH4qI2DYAusx+/3sRGAtA8mk9qjpi3h/6CAVghltvSOVZakfZw/6On
 tJb+uTFcw9FQN2ZtG8EPy4nAagLAD7kV0QB3xG5bN9q4YJ3p3EuESdL/XHlovfJdF8j0
 cTRo/RrGi1WlMYDzeMa6CFTpNRUpW06zAe1XA7t5Bp0DTIgHwLu8UWqQj7HprunJKjN2
 dpzyZ/C5LowVmRYbbmiJso8hDXMmWoVogp07ChNnSOBh5g9KWboqadTk50Afe8pBlcMa
 q9gQ==
X-Gm-Message-State: AOJu0YzniH3nsmJ8f3OGQFb6Jtrdh9EZSgyAuQCyWfk0VtSr9wd+f2Lg
 vOXC5ocXMBgG2E19ewzSieNbyPdEN0chOqAsjGmc8DsUAl6I8uLymA3b18+VrT1gusOROU5JK5L
 B
X-Google-Smtp-Source: AGHT+IH3sacDa5WP/Fv5WL5BCxw9dQlYgN6QXUgcMp9f5MNNnX5VrayQIaVWQXaShMc37lIpQTWP8g==
X-Received: by 2002:a17:903:11c3:b0:1dc:fb5:6f36 with SMTP id
 q3-20020a17090311c300b001dc0fb56f36mr9994831plh.32.1709827456543; 
 Thu, 07 Mar 2024 08:04:16 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:04:16 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com
Subject: [PATCH v2 14/15] hw/misc: EDU: added PASID support
Date: Thu,  7 Mar 2024 13:03:17 -0300
Message-ID: <20240307160319.675044-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extension to support DMA with PASID identifier and reporting PASID
extended PCIe capabilities.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 hw/misc/edu.c | 57 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 2a976ca2b1..522cec85b3 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
@@ -53,6 +54,8 @@ struct EduState {
     QemuCond thr_cond;
     bool stopping;
 
+    bool enable_pasid;
+
     uint32_t addr4;
     uint32_t fact;
 #define EDU_STATUS_COMPUTING    0x01
@@ -66,6 +69,9 @@ struct EduState {
 # define EDU_DMA_FROM_PCI       0
 # define EDU_DMA_TO_PCI         1
 #define EDU_DMA_IRQ             0x4
+#define EDU_DMA_PV              0x8
+#define EDU_DMA_PASID(cmd)      (((cmd) >> 8) & ((1U << 20) - 1))
+
     struct dma_state {
         dma_addr_t src;
         dma_addr_t dst;
@@ -126,12 +132,7 @@ static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
 
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
 {
-    dma_addr_t res = addr & edu->dma_mask;
-
-    if (addr != res) {
-        printf("EDU: clamping DMA %#.16"PRIx64" to %#.16"PRIx64"!\n", addr, res);
-    }
-
+    dma_addr_t res = addr;
     return res;
 }
 
@@ -139,23 +140,33 @@ static void edu_dma_timer(void *opaque)
 {
     EduState *edu = opaque;
     bool raise_irq = false;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
 
     if (!(edu->dma.cmd & EDU_DMA_RUN)) {
         return;
     }
 
+    if (edu->enable_pasid && (edu->dma.cmd & EDU_DMA_PV)) {
+        attrs.unspecified = 0;
+        attrs.pasid = EDU_DMA_PASID(edu->dma.cmd);
+        attrs.requester_id = pci_requester_id(&edu->pdev);
+        attrs.secure = 0;
+    }
+
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
         uint64_t dst = edu->dma.dst;
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
-        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
-                edu->dma_buf + dst, edu->dma.cnt);
+        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
+                edu->dma_buf + dst, edu->dma.cnt,
+                DMA_DIRECTION_TO_DEVICE, attrs);
     } else {
         uint64_t src = edu->dma.src;
         edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
         src -= DMA_START;
-        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-                edu->dma_buf + src, edu->dma.cnt);
+        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
+                edu->dma_buf + src, edu->dma.cnt,
+                DMA_DIRECTION_FROM_DEVICE, attrs);
     }
 
     edu->dma.cmd &= ~EDU_DMA_RUN;
@@ -255,7 +266,8 @@ static void edu_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         if (qatomic_read(&edu->status) & EDU_STATUS_COMPUTING) {
             break;
         }
-        /* EDU_STATUS_COMPUTING cannot go 0->1 concurrently, because it is only
+        /*
+         * EDU_STATUS_COMPUTING cannot go 0->1 concurrently, because it is only
          * set in this function and it is under the iothread mutex.
          */
         qemu_mutex_lock(&edu->thr_mutex);
@@ -368,9 +380,21 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
     EduState *edu = EDU(pdev);
     uint8_t *pci_conf = pdev->config;
+    int pos;
 
     pci_config_set_interrupt_pin(pci_conf, 1);
 
+    pcie_endpoint_cap_init(pdev, 0);
+
+    /* PCIe extended capability for PASID */
+    pos = PCI_CONFIG_SPACE_SIZE;
+    if (edu->enable_pasid) {
+        /* PCIe Spec 7.8.9 PASID Extended Capability Structure */
+        pcie_add_capability(pdev, 0x1b, 1, pos, 8);
+        pci_set_long(pdev->config + pos + 4, 0x00001400);
+        pci_set_long(pdev->wmask + pos + 4,  0xfff0ffff);
+    }
+
     if (msi_init(pdev, 0, 1, true, false, errp)) {
         return;
     }
@@ -404,20 +428,27 @@ static void pci_edu_uninit(PCIDevice *pdev)
     msi_uninit(pdev);
 }
 
+
 static void edu_instance_init(Object *obj)
 {
     EduState *edu = EDU(obj);
 
-    edu->dma_mask = (1UL << 28) - 1;
+    edu->dma_mask = ~0ULL;
     object_property_add_uint64_ptr(obj, "dma_mask",
                                    &edu->dma_mask, OBJ_PROP_FLAG_READWRITE);
 }
 
+static Property edu_properties[] = {
+    DEFINE_PROP_BOOL("pasid", EduState, enable_pasid, TRUE),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void edu_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
 
+    device_class_set_props(dc, edu_properties);
     k->realize = pci_edu_realize;
     k->exit = pci_edu_uninit;
     k->vendor_id = PCI_VENDOR_ID_QEMU;
@@ -430,7 +461,7 @@ static void edu_class_init(ObjectClass *class, void *data)
 static void pci_edu_register_types(void)
 {
     static InterfaceInfo interfaces[] = {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
         { },
     };
     static const TypeInfo edu_info = {
-- 
2.43.2


