Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A292D44D5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gBR-0001ob-PC; Wed, 06 Nov 2024 08:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gBI-0001kA-Ra
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:45 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8gBF-0001c3-Jk
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:34:44 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso6140584b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730900079; x=1731504879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWu4P2SNKyMxaSD2TWANA06+/Q0GELUCulyrPEKTgP0=;
 b=L+EcCCHzSowSR91ONqNe8CL4MPfo2yuonfKDkTQ8I2oE/6+QJHsO88cHe+0BKy5Rfb
 HTBevYSkFSeN8QaNd7rp2Ni05EdC7iJblP40c3vS6zoonghne36QFWeLEKAuWt0rL8/V
 5T4UQ2jPleOiYHpUdsir/W8sBg2y7zjBbFhq2uYE96XJqEEvNIuwLZeQbHKneRhfC4vj
 kGqjLbVvQhr9SBXfhG8enIOnJwYemG4XDOd9ivztxDQ7EfQdOz55l8lYRaok/I4X7IAz
 h0zZrkB988NKCpL6aaNAF9oY4/Y164NCszFbu2IOX2kG0m893TQPzeIjBSkh2ZUTxApX
 MIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900079; x=1731504879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWu4P2SNKyMxaSD2TWANA06+/Q0GELUCulyrPEKTgP0=;
 b=kTSRr8PD/5zBrggaPMYRST828SouyKasiToN/pj6nvGFLWbba3d87/YbBhOUlp1EnV
 HFN94RM7sV4X/+T8obYgkAb3LplIvjIYcODjrZty1KYlJJeuJ78N1Sw3SRi5IJQKKGlB
 GaXizrqURe1b5djr760R4GlfkSHlVd+1YozSkkzHb4UADsUJU7jeKrNAzMQ7Sggqfsmk
 4bAve3cf14Jcad9pv79qFGvnyKXt6z7tfmEub9yAidlZWecOuUswhSkmbkmYmBfi+xr6
 DFLslATAyPTIcuP7RFPqdxDbhTuP5+sXzubGoHYr0TbVFbim1u2dzpFZY8F4vAKza8O9
 3rfQ==
X-Gm-Message-State: AOJu0YyXXhs119wsIyXFfCMe+LsGLKHbjZPBRtmlnFgGQ4RE0EruNdNB
 4m4SgOqm2rU57rsUJWYl0AO4d46K7aNQlTjzgf+Yzlwyr1PdGLKpWNhJ+1NIkTDC5Jn0a0ZSonH
 f
X-Google-Smtp-Source: AGHT+IHeTr8149TqVjveSBpqIrsxmVQAy/lQNfnA9SXVcoPeBQ4fzsD4R9IfLfrOKt9cPxbe0IOsjQ==
X-Received: by 2002:a05:6a20:7290:b0:1db:ed44:ba68 with SMTP id
 adf61e73a8af0-1dbed44baecmr10027917637.17.1730900079507; 
 Wed, 06 Nov 2024 05:34:39 -0800 (PST)
Received: from grind.. ([189.79.22.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb64esm11749765b3a.168.2024.11.06.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:34:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 6/7] hw/riscv/riscv-iommu: implement reset protocol
Date: Wed,  6 Nov 2024 10:34:06 -0300
Message-ID: <20241106133407.604587-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a riscv_iommu_reset() helper in the base emulation code that
implements the expected reset behavior as defined by the riscv-iommu
spec.

Devices can then use this helper in their own reset callbacks.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-pci.c | 20 ++++++++++++++++++++
 hw/riscv/riscv-iommu-sys.c | 20 ++++++++++++++++++++
 hw/riscv/riscv-iommu.c     | 35 +++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h     |  1 +
 hw/riscv/trace-events      |  2 ++
 include/hw/riscv/iommu.h   |  6 ++++--
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 4ce9bf6b78..51226c4877 100644
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
@@ -167,10 +174,23 @@ static Property riscv_iommu_pci_properties[] = {
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
index 239f83f5bd..cf2019d6aa 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2228,6 +2228,41 @@ static void riscv_iommu_unrealize(DeviceState *dev)
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
 static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
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
 
-- 
2.45.2


