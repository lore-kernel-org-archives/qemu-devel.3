Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AD8E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEf-0006Cd-0H; Thu, 19 Dec 2024 20:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEb-0006BM-RY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:22 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEa-0004QH-1X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:21 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728f28744c5so1424132b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659718; x=1735264518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfFoOJd9Kg+qJnKuQUnSgKDQ30ARBalkJ/bo73xPJYs=;
 b=frT9+O+PKzn63MSuKx+112dlfdD93Q3CWpzp0OJCb7xSDSJfgnZ8iDp/CwKV8wG8MG
 jRKM79k/4ZziF1uDmLPvJ1AgVTQecZ2W3d04QHwltAyn5olOhwSX9Yojp9HDSjP3Jxai
 QfFdwaZ0Q6n4aPbrxDjuPFcuGAihiovR0+AtKsAcHuD6uwZgipFWFRMxcDn5lJgBn+KW
 W0pLX2Px7L7SXHR/uixucvH1Lq9XksAIOmes4VLd8olPrOMs3PkkgrXVGKX0d5My85Sr
 0moyoQt+TU6DtawIEx0lPfJVxqnSkP9x6SSQjNcjiDdTjzA3lDXzQUOx28uEn5XR69UU
 gbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659718; x=1735264518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfFoOJd9Kg+qJnKuQUnSgKDQ30ARBalkJ/bo73xPJYs=;
 b=CXXHGjy6gpyt4IGwnGmuaD7tz0EpIb+W9lKeDzszEdfV6t3BtD8dlclfqMFiGG0ZYR
 X+NjSwz3GHpYO15cz/m5eHaiLPS0T89gHlSy96gl1sis0iwWiqx9ExQ9Kqcw2TdBykmO
 Y3Qfz/3e7Fc3uyHFTzaz2v0ENCOxwiA/XPgh1/9Oa7FkBbXwc/vUl8AZpLd5mRyy6RxG
 wfE+DvOZh5iXKw7zY5lNb82cvm5/UbFAlqmZIMCN2Y3kUzQnl0TQeBXiQfKW/w8+0VwE
 5/8S3ncQHGyUW9urqWxSKb5eFPnEHXZpPKXq8e52cP9LgCFWfD3GwmPN+11P11g+RrFO
 IJVg==
X-Gm-Message-State: AOJu0YxvJpMZY7Va0XS5u+br5TMEFXpElwdRU89oXBo4nzwuaHvswjvs
 ARxetPmsLM7wGfqET1H9w3vS6JjovcelF1uZRVRyDQo19b2TInFL3wL7EQYg
X-Gm-Gg: ASbGncsCg6ry3JiWUiOEpTpp9wvqvwiYPJbAOpO18lh8nWEhwTBGV8N0ciKWeYK/V3j
 kISuW9rVZwYTWtTlqALoTfR+YSJ8cNuxuMFFs6cX3iTpmaR/UkFpFMoDTZxp7xHX38ltMuYnJtB
 F6oczMIj/5VZ87UiLqwTmDb+A2IWAGexndD57trWdFrxargFPMAzcsT4Fq26JavSIc30pgFLzPj
 5AjECLIw7qJZhnOEj8/FsdE7pn7x0t8qRrweVHLTY5uQoBY+5MeTzSRjs2yoie74c00ouFqRdpQ
 8xTNfhqSzlrpzeNNC0v8PVbgDb/2deS5A3JtS/z7oX0vWgXikk1glrwb1yHKBxg=
X-Google-Smtp-Source: AGHT+IFwxzRI8uy5O3SE8g1518QKlA6d1J7965dJyTbdleikiZL7PFkEfMZoIQt8QT43Jvbi82rzkQ==
X-Received: by 2002:a05:6a20:c70b:b0:1e1:c054:4c58 with SMTP id
 adf61e73a8af0-1e5e0450020mr2052533637.2.1734659718161; 
 Thu, 19 Dec 2024 17:55:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/39] hw/riscv/riscv-iommu: implement reset protocol
Date: Fri, 20 Dec 2024 11:54:08 +1000
Message-ID: <20241220015441.317236-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
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
index 525fd5b730..7bcbb03d08 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -17,3 +17,5 @@ riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
 riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
 riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
 riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%"PRIx64" msi_data 0x%x result %u"
+riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
+riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
-- 
2.47.1


