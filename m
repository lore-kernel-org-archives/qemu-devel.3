Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F1AE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZG-00037r-JE; Wed, 18 Dec 2024 17:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZB-00034t-O5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z9-0002qY-1O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216634dd574so1118745ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561040; x=1735165840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbjp0RN4WVBTHLzHs0l1pkCDARbcgb47+aZu1+7vjBY=;
 b=PE8iOl4fhvWDvywpPqFYfTpQOlz7XbJHt8heaKeuOetq9J7F59ffvhoM0D2MPQZ0zB
 HgQB7rP/2/72aY/IR2jO/1CqvYUsgdvxi+KS46HekBMZb7rNuwEyKJ/uWGYUgIjwiu/C
 2oRTRZgztkKV/o5x4TtCsZErSn1/QCfhPE1JxduKIAWyTx9A9sjjh3nKhhoezXSZsf7U
 5I1IIN8wr0hUokrlvX8fRTmt/MF4ONF+NMnT02jzcvAqf1vs1MfaC3o6gCGR7xTix0bn
 mpZ5n7g7NYipUqkp+bUhb5tENaf7AFycJOZutsx54dXOJjwcL8ZIdnXotLA/VNS2BdFX
 O3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561040; x=1735165840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbjp0RN4WVBTHLzHs0l1pkCDARbcgb47+aZu1+7vjBY=;
 b=rIHdkbPQ7qnwKtu9bqXkTTuPBGxo5qkR+QcB1gv78CpAkhilZUys9W89zHKJizg9kg
 RDDzcp2G1WagJI+OJWxYw1htrpkzTeH7h3MJOJtrJmu08s1R21EIOvfWkbe7l97YKA1b
 5gBZ7KzPh4WSKa6dY7LAqCzFKmi6R5QURtmRLkkvN+K+CXLs1jUkX1BXqpo/CW5vRw9j
 UlS77DX3SyDcxTRiPweFKHrLdTbI/wbwtcGFOEeWpDxtyeywCf2Cn0LDD3o4KaBtP1uW
 dQI68OnP9rnc+DJipqWGhl2MNsUhUMSxiLupxH9dD6/xu4CXBU/zfBFAnBApGmupXfht
 IpRA==
X-Gm-Message-State: AOJu0Yxkwqq86jXJDAP/KLUOFv2K4VH+Sy+m/5xrMBxUMC4n1nFPJjo6
 udx9K4D3d3FVU2JdvcGx7kTTG8+I1C6GV7rQHxMzegv929ELC5a56Gfyn4IF
X-Gm-Gg: ASbGncvLhzYdD627FYUY8uY0YtVw32c8h6wISMUxttzEeytufGx1HB4kAyIvS1ven74
 A+PsuSnwvq+3N1eDeM/9C6FVPtd7nlZH/8NcVkREjD9Zesri9Ui+lN9PHTweQjHidMzlbKb8Dej
 e1OLUR807cyKR7YxUt65x9lLQK4SYbSkiQr3qz5zwnigY7FT1tp1vMf0qxFB9rhfjLWRzi7mNim
 L/XHFGmgDtia08kEE0k3NEdgML7tdhSOkTzKXpHt8S7LAGgfDj4GbTSi/ssTog+HizvFu+fONCD
 YX2FgIRcF45Lx2tgpz/7rSJLHq2gfftkKTiPQbWZSqBq/UZWBENDJ74+YiSvxuE=
X-Google-Smtp-Source: AGHT+IEW1XHvP1iV0ZIjSTvDze2tkFvl1S2p2Qv19rlPhuI4niOW+Qaul6oSx6r4TwlXlJQiMWra7A==
X-Received: by 2002:a17:902:fc4e:b0:216:5268:9aab with SMTP id
 d9443c01a7336-219d97004f8mr19844395ad.46.1734561040590; 
 Wed, 18 Dec 2024 14:30:40 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/39] hw/riscv/riscv-iommu: implement reset protocol
Date: Thu, 19 Dec 2024 08:29:38 +1000
Message-ID: <20241218223010.1931245-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add a riscv_iommu_reset() helper in the base emulation code that
implements the expected reset behavior as defined by the riscv-iommu
spec.

Devices can then use this helper in their own reset callbacks.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h     |  1 +
 include/hw/riscv/iommu.h   |  6 ++++--
 hw/riscv/riscv-iommu-pci.c | 20 ++++++++++++++++++++
 hw/riscv/riscv-iommu-sys.c | 20 ++++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 35 +++++++++++++++++++++++++++++++++++
 hw/riscv/trace-events      |  2 ++
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index f9f2827808..9424989df4 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -89,6 +89,7 @@ struct RISCVIOMMUState {
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
          Error **errp);
 void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
+void riscv_iommu_reset(RISCVIOMMUState *s);
 
 /* private helpers */
 
diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
index 8a8acfc3f0..b03339d75c 100644
--- a/include/hw/riscv/iommu.h
+++ b/include/hw/riscv/iommu.h
@@ -30,12 +30,14 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
 typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
 
 #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
+OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_PCI)
 typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
+typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
 
 #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
-OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
+OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_SYS)
 typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
+typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
 
 #define FDT_IRQ_TYPE_EDGE_LOW 1
 
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index a95d0f74c8..2c1ae72461 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -31,6 +31,7 @@
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
 #include "riscv-iommu-bits.h"
+#include "trace.h"
 
 /* RISC-V IOMMU PCI Device Emulation */
 #define RISCV_PCI_CLASS_SYSTEM_IOMMU     0x0806
@@ -66,6 +67,12 @@ typedef struct RISCVIOMMUStatePci {
     RISCVIOMMUState  iommu;   /* common IOMMU state */
 } RISCVIOMMUStatePci;
 
+struct RISCVIOMMUPciClass {
+    /*< public >*/
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
 /* interrupt delivery callback */
 static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
 {
@@ -167,10 +174,23 @@ static const Property riscv_iommu_pci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void riscv_iommu_pci_reset_hold(Object *obj, ResetType type)
+{
+    RISCVIOMMUStatePci *pci = RISCV_IOMMU_PCI(obj);
+    RISCVIOMMUState *iommu = &pci->iommu;
+
+    riscv_iommu_reset(iommu);
+
+    trace_riscv_iommu_pci_reset_hold(type);
+}
+
 static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = riscv_iommu_pci_reset_hold;
 
     k->realize = riscv_iommu_pci_realize;
     k->exit = riscv_iommu_pci_exit;
diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index a0ef67a20b..605979a0ac 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -54,6 +54,12 @@ struct RISCVIOMMUStateSys {
     uint8_t *msix_pba;
 };
 
+struct RISCVIOMMUSysClass {
+    /*< public >*/
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
 static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
                                      unsigned size)
 {
@@ -212,9 +218,23 @@ static Property riscv_iommu_sys_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
+{
+    RISCVIOMMUStateSys *sys = RISCV_IOMMU_SYS(obj);
+    RISCVIOMMUState *iommu = &sys->iommu;
+
+    riscv_iommu_reset(iommu);
+
+    trace_riscv_iommu_sys_reset_hold(type);
+}
+
 static void riscv_iommu_sys_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = riscv_iommu_sys_reset_hold;
+
     dc->realize = riscv_iommu_sys_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     device_class_set_props(dc, riscv_iommu_sys_properties);
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 9137217cb7..72e607c9eb 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2262,6 +2262,41 @@ static void riscv_iommu_unrealize(DeviceState *dev)
     g_hash_table_unref(s->ctx_cache);
 }
 
+void riscv_iommu_reset(RISCVIOMMUState *s)
+{
+    uint32_t reg_clr;
+    int ddtp_mode;
+
+    /*
+     * Clear DDTP while setting DDTP_mode back to user
+     * initial setting.
+     */
+    ddtp_mode = s->enable_off ?
+                RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE;
+    s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, ddtp_mode);
+    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, s->ddtp);
+
+    reg_clr = RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
+              RISCV_IOMMU_CQCSR_CQON | RISCV_IOMMU_CQCSR_BUSY;
+    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, 0, reg_clr);
+
+    reg_clr = RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FIE |
+              RISCV_IOMMU_FQCSR_FQON | RISCV_IOMMU_FQCSR_BUSY;
+    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, 0, reg_clr);
+
+    reg_clr = RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PIE |
+              RISCV_IOMMU_PQCSR_PQON | RISCV_IOMMU_PQCSR_BUSY;
+    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, 0, reg_clr);
+
+    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
+                          RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
+
+    riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
+
+    g_hash_table_remove_all(s->ctx_cache);
+    g_hash_table_remove_all(s->iot_cache);
+}
+
 static const Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 94facbb8b1..aaa2c0eb94 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -17,3 +17,5 @@ riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
 riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
 riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
 riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_data 0x%x result %u"
+riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
+riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
-- 
2.47.1


