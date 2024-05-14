Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67744C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 09:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6o8p-0007lj-SF; Tue, 14 May 2024 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s6o8l-0007kr-Uj
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:08:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s6o8j-0001Kn-4r
 for qemu-devel@nongnu.org; Tue, 14 May 2024 05:08:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxN+ntKUNm1p4MAA--.18551S3;
 Tue, 14 May 2024 17:07:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx0VXsKUNmNUAeAA--.37396S3; 
 Tue, 14 May 2024 17:07:57 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/intc/loongarch_extioi: Add extioi virt extension
 definition
Date: Tue, 14 May 2024 17:07:55 +0800
Message-Id: <20240514090756.988096-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240514090756.988096-1-gaosong@loongson.cn>
References: <20240514090756.988096-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx0VXsKUNmNUAeAA--.37396S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On LoongArch, IRQs can be routed to four vcpus with hardware extioi.
This patch adds the extioi virt extension definition so that the IRQ can
route to 256 vcpus.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongarch_extioi.h | 21 +++++++
 hw/intc/loongarch_extioi.c         | 92 ++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 410c6e1121..d4646fab9f 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -41,6 +41,24 @@
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
 #define EXTIOI_SIZE                  0x800
 
+#define EXTIOI_VIRT_BASE             (0x40000000)
+#define EXTIOI_VIRT_SIZE             (0x1000)
+#define EXTIOI_VIRT_FEATURES         (0x0)
+#define  EXTIOI_HAS_VIRT_EXTENSION     (0)
+#define  EXTIOI_HAS_ENABLE_OPTION      (1)
+#define  EXTIOI_HAS_INT_ENCODE         (2)
+#define  EXTIOI_HAS_CPU_ENCODE         (3)
+#define  EXTIOI_VIRT_HAS_FEATURES      (BIT(EXTIOI_HAS_VIRT_EXTENSION)  \
+                                        | BIT(EXTIOI_HAS_ENABLE_OPTION) \
+                                        | BIT(EXTIOI_HAS_INT_ENCODE)    \
+                                       | BIT(EXTIOI_HAS_CPU_ENCODE))
+#define EXTIOI_VIRT_CONFIG           (0x4)
+#define  EXTIOI_ENABLE                 (1)
+#define  EXTIOI_ENABLE_INT_ENCODE      (2)
+#define  EXTIOI_ENABLE_CPU_ENCODE      (3)
+#define EXTIOI_VIRT_COREMAP_START    (0x40)
+#define EXTIOI_VIRT_COREMAP_END      (0x240)
+
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
     DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
@@ -52,6 +70,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
 struct LoongArchExtIOI {
     SysBusDevice parent_obj;
     uint32_t num_cpu;
+    uint32_t features;
+    uint32_t status;
     /* hardware state */
     uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
     uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
@@ -65,5 +85,6 @@ struct LoongArchExtIOI {
     qemu_irq irq[EXTIOI_IRQS];
     ExtIOICore *cpu;
     MemoryRegion extioi_system_mem;
+    MemoryRegion virt_extend;
 };
 #endif /* LOONGARCH_EXTIOI_H */
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 0b358548eb..89afdb1c3c 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -143,10 +143,13 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
 
     for (i = 0; i < 4; i++) {
         cpu = val & 0xff;
-        cpu = ctz32(cpu);
-        cpu = (cpu >= 4) ? 0 : cpu;
         val = val >> 8;
 
+        if (!(s->status & BIT(EXTIOI_ENABLE_CPU_ENCODE))) {
+            cpu = ctz32(cpu);
+            cpu = (cpu >= 4) ? 0 : cpu;
+        }
+
         if (s->sw_coremap[irq + i] == cpu) {
             continue;
         }
@@ -265,6 +268,61 @@ static const MemoryRegionOps extioi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static MemTxResult extioi_virt_readw(void *opaque, hwaddr addr, uint64_t *data,
+                                     unsigned size, MemTxAttrs attrs)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+
+    switch (addr) {
+    case EXTIOI_VIRT_FEATURES:
+        *data = s->features;
+        break;
+    case EXTIOI_VIRT_CONFIG:
+        *data = s->status;
+        break;
+    default:
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult extioi_virt_writew(void *opaque, hwaddr addr,
+                          uint64_t val, unsigned size,
+                          MemTxAttrs attrs)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+
+    switch (addr) {
+    case EXTIOI_VIRT_FEATURES:
+        return MEMTX_ACCESS_ERROR;
+
+    case EXTIOI_VIRT_CONFIG:
+        /*
+         * extioi features can only be set at disabled status
+         */
+        if ((s->status & BIT(EXTIOI_ENABLE)) && val) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        s->status = val & s->features;
+        break;
+    default:
+        break;
+    }
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps extioi_virt_ops = {
+    .read_with_attrs = extioi_virt_readw,
+    .write_with_attrs = extioi_virt_writew,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(dev);
@@ -284,6 +342,16 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
                           s, "extioi_system_mem", 0x900);
     sysbus_init_mmio(sbd, &s->extioi_system_mem);
+
+    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
+        memory_region_init_io(&s->virt_extend, OBJECT(s), &extioi_virt_ops,
+                              s, "extioi_virt", EXTIOI_VIRT_SIZE);
+        sysbus_init_mmio(sbd, &s->virt_extend);
+        s->features |= EXTIOI_VIRT_HAS_FEATURES;
+    } else {
+        s->status |= BIT(EXTIOI_ENABLE);
+    }
+
     s->cpu = g_new0(ExtIOICore, s->num_cpu);
     if (s->cpu == NULL) {
         error_setg(errp, "Memory allocation for ExtIOICore faile");
@@ -304,6 +372,16 @@ static void loongarch_extioi_finalize(Object *obj)
     g_free(s->cpu);
 }
 
+static void loongarch_extioi_reset(DeviceState *d)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(d);
+
+    /* use legacy interrupt routing method by default */
+    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
+        s->status = 0;
+    }
+}
+
 static int vmstate_extioi_post_load(void *opaque, int version_id)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
@@ -333,8 +411,8 @@ static const VMStateDescription vmstate_extioi_core = {
 
 static const VMStateDescription vmstate_loongarch_extioi = {
     .name = TYPE_LOONGARCH_EXTIOI,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .post_load = vmstate_extioi_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
@@ -347,12 +425,17 @@ static const VMStateDescription vmstate_loongarch_extioi = {
 
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
                          vmstate_extioi_core, ExtIOICore),
+
+        VMSTATE_UINT32(features, LoongArchExtIOI),
+        VMSTATE_UINT32(status, LoongArchExtIOI),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static Property extioi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
+    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
+                    EXTIOI_HAS_VIRT_EXTENSION, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -361,6 +444,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_extioi_realize;
+    dc->reset   = loongarch_extioi_reset;
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
 }
-- 
2.25.1


