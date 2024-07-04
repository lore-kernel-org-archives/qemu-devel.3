Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6CBC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPDIb-0007uE-Hq; Wed, 03 Jul 2024 23:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sPDIW-0007qw-OU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sPDIS-0003AG-PB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:16 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxnuscGYZmFs0AAA--.2377S3;
 Thu, 04 Jul 2024 11:38:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsUaGYZmgJI6AA--.59898S6; 
 Thu, 04 Jul 2024 11:38:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] hw/intc/loongson_ipi: reconstruct driver inherit from
 common class
Date: Thu,  4 Jul 2024 11:38:02 +0800
Message-Id: <20240704033802.3838618-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240704033802.3838618-1-maobibo@loongson.cn>
References: <20240704033802.3838618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxlsUaGYZmgJI6AA--.59898S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Like loongarch ipi, reconstruct this driver by inheriting class
LoongsonIPICommonClass. Add extra function loongson_ipi_realize()
to implement mmio memory region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi.c         | 330 +++------------------------------
 hw/intc/meson.build            |   2 +-
 include/hw/intc/loongson_ipi.h |  54 ++----
 3 files changed, 41 insertions(+), 345 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480..42c3cff9ac 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -15,213 +15,16 @@
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
-                                           uint64_t *data,
-                                           unsigned size, MemTxAttrs attrs)
+static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-    IPICore *s = opaque;
-    uint64_t ret = 0;
-    int index = 0;
-
-    addr &= 0xff;
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        ret = s->status;
-        break;
-    case CORE_EN_OFF:
-        ret = s->en;
-        break;
-    case CORE_SET_OFF:
-        ret = 0;
-        break;
-    case CORE_CLEAR_OFF:
-        ret = 0;
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        ret = s->buf[index];
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
-        break;
-    }
-
-    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
-    *data = ret;
-    return MEMTX_OK;
-}
-
-static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
-                                            uint64_t *data,
-                                            unsigned size, MemTxAttrs attrs)
-{
-    LoongsonIPI *ipi = opaque;
-    IPICore *s;
-
-    if (attrs.requester_id >= ipi->num_cpu) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    s = &ipi->cpu[attrs.requester_id];
-    return loongson_ipi_core_readl(s, addr, data, size, attrs);
-}
-
-static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
-{
-#ifdef TARGET_LOONGARCH64
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-#endif
-#ifdef TARGET_MIPS
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
         return &MIPS_CPU(cpu)->env.iocsr.as;
     }
-#endif
-    return NULL;
-}
-
-static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
-                          MemTxAttrs attrs)
-{
-    int i, mask = 0, data = 0;
-    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
-
-    if (!iocsr_as) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /*
-     * bit 27-30 is mask for byte writing,
-     * if the mask is 0, we need not to do anything.
-     */
-    if ((val >> 27) & 0xf) {
-        data = address_space_ldl(iocsr_as, addr, attrs, NULL);
-        for (i = 0; i < 4; i++) {
-            /* get mask for byte writing */
-            if (val & (0x1 << (27 + i))) {
-                mask |= 0xff << (i * 8);
-            }
-        }
-    }
-
-    data &= mask;
-    data |= (val >> 32) & ~mask;
-    address_space_stl(iocsr_as, addr, data, attrs, NULL);
-
-    return MEMTX_OK;
-}
-
-static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
-    attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
-}
-
-static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = cpu_by_arch_id(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = val & 0xffff;
-    attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
-}
-
-static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
-                                            uint64_t val, unsigned size,
-                                            MemTxAttrs attrs)
-{
-    IPICore *s = opaque;
-    LoongsonIPI *ipi = s->ipi;
-    int index = 0;
-    uint32_t cpuid;
-    uint8_t vector;
-    CPUState *cs;
-
-    addr &= 0xff;
-    trace_loongson_ipi_write(size, (uint64_t)addr, val);
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
-        break;
-    case CORE_EN_OFF:
-        s->en = val;
-        break;
-    case CORE_SET_OFF:
-        s->status |= val;
-        if (s->status != 0 && (s->status & s->en) != 0) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-    case CORE_CLEAR_OFF:
-        s->status &= ~val;
-        if (s->status == 0 && s->en != 0) {
-            qemu_irq_lower(s->irq);
-        }
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        s->buf[index] = val;
-        break;
-    case IOCSR_IPI_SEND:
-        cpuid = extract32(val, 16, 10);
-        /* IPI status vector */
-        vector = extract8(val, 0, 5);
-        cs = cpu_by_arch_id(cpuid);
-        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
-            return MEMTX_DECODE_ERROR;
-        }
-        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
-                                 BIT(vector), 4, attrs);
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
-        break;
-    }
 
-    return MEMTX_OK;
-}
-
-static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
-                                            uint64_t val, unsigned size,
-                                            MemTxAttrs attrs)
-{
-    LoongsonIPI *ipi = opaque;
-    IPICore *s;
-
-    if (attrs.requester_id >= ipi->num_cpu) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    s = &ipi->cpu[attrs.requester_id];
-    return loongson_ipi_core_writel(s, addr, val, size, attrs);
+    return NULL;
 }
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
@@ -234,139 +37,54 @@ static const MemoryRegionOps loongson_ipi_core_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps loongson_ipi_iocsr_ops = {
-    .read_with_attrs = loongson_ipi_iocsr_readl,
-    .write_with_attrs = loongson_ipi_iocsr_writel,
-    .impl.min_access_size = 4,
-    .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-/* mail send and any send only support writeq */
-static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    MemTxResult ret = MEMTX_OK;
-
-    addr &= 0xfff;
-    switch (addr) {
-    case MAIL_SEND_OFFSET:
-        ret = mail_send(val, attrs);
-        break;
-    case ANY_SEND_OFFSET:
-        ret = any_send(val, attrs);
-        break;
-    default:
-       break;
-    }
-
-    return ret;
-}
-
-static const MemoryRegionOps loongson_ipi64_ops = {
-    .write_with_attrs = loongson_ipi_writeq,
-    .impl.min_access_size = 8,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 8,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
 
 static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 {
-    LoongsonIPI *s = LOONGSON_IPI(dev);
+    LoongsonIPIState *s = LOONGSON_IPI(dev);
+    LoongsonIPIClass *lic = LOONGSON_IPI_GET_CLASS(s);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
     int i;
 
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
-                          &loongson_ipi_iocsr_ops,
-                          s, "loongson_ipi_iocsr", 0x48);
-
-    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
-    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
-
-    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
-
-    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
-                          &loongson_ipi64_ops,
-                          s, "loongson_ipi64_iocsr", 0x118);
-    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for IPICore faile");
+    lic->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
-        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+    s->ipi_mmio_mem = g_new0(MemoryRegion, s->parent_obj.num_cpu);
+    for (i = 0; i < s->parent_obj.num_cpu; i++) {
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
-        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
-                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
-        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+        memory_region_init_io(s->ipi_mmio_mem + i, OBJECT(dev),
+                              &loongson_ipi_core_ops, &s->parent_obj.cpu[i],
+                              name, 0x48);
+        sysbus_init_mmio(sbd, s->ipi_mmio_mem + i);
     }
 }
 
-static const VMStateDescription vmstate_ipi_core = {
-    .name = "ipi-single",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(status, IPICore),
-        VMSTATE_UINT32(en, IPICore),
-        VMSTATE_UINT32(set, IPICore),
-        VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongson_ipi = {
-    .name = TYPE_LOONGSON_IPI,
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPI, num_cpu,
-                         vmstate_ipi_core, IPICore),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPI, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void loongson_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+    LoongsonIPIClass *lic = LOONGSON_IPI_CLASS(klass);
 
-    dc->realize = loongson_ipi_realize;
-    device_class_set_props(dc, ipi_properties);
-    dc->vmsd = &vmstate_loongson_ipi;
+    device_class_set_parent_realize(dc, loongson_ipi_realize,
+                                    &lic->parent_realize);
+    licc->get_iocsr_as = get_iocsr_as;
 }
 
 static void loongson_ipi_finalize(Object *obj)
 {
-    LoongsonIPI *s = LOONGSON_IPI(obj);
+    LoongsonIPIState *s = LOONGSON_IPI(obj);
 
-    g_free(s->cpu);
+    g_free(s->ipi_mmio_mem);
 }
 
 static const TypeInfo loongson_ipi_info = {
     .name          = TYPE_LOONGSON_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPI),
+    .parent        = TYPE_LOONGSON_IPI_COMMON,
+    .instance_size = sizeof(LoongsonIPIState),
+    .class_size    = sizeof(LoongsonIPIClass),
     .class_init    = loongson_ipi_class_init,
     .instance_finalize = loongson_ipi_finalize,
 };
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index b7fce2f375..81b72d57bc 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -69,7 +69,7 @@ specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
-specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c', 'loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c', 'loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3..acf2b9d9a6 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -8,49 +8,27 @@
 #ifndef HW_LOONGSON_IPI_H
 #define HW_LOONGSON_IPI_H
 
+#include "qom/object.h"
+#include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
-/* Mainy used by iocsr read and write */
-#define SMP_IPI_MAILBOX      0x1000ULL
-#define CORE_STATUS_OFF       0x0
-#define CORE_EN_OFF           0x4
-#define CORE_SET_OFF          0x8
-#define CORE_CLEAR_OFF        0xc
-#define CORE_BUF_20           0x20
-#define CORE_BUF_28           0x28
-#define CORE_BUF_30           0x30
-#define CORE_BUF_38           0x38
-#define IOCSR_IPI_SEND        0x40
-#define IOCSR_MAIL_SEND       0x48
-#define IOCSR_ANY_SEND        0x158
+#define TYPE_LOONGSON_IPI   "loongson_ipi"
+typedef struct LoongsonIPIClass LoongsonIPIClass;
+typedef struct LoongsonIPIState LoongsonIPIState;
+DECLARE_OBJ_CHECKERS(LoongsonIPIState, LoongsonIPIClass,
+                     LOONGSON_IPI, TYPE_LOONGSON_IPI)
 
-#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
-#define MAIL_SEND_OFFSET      0
-#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
-
-#define IPI_MBX_NUM           4
-
-#define TYPE_LOONGSON_IPI "loongson_ipi"
-OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
-
-typedef struct IPICore {
-    LoongsonIPI *ipi;
+struct LoongsonIPIState {
+    LoongsonIPICommonState parent_obj;
     MemoryRegion *ipi_mmio_mem;
-    uint32_t status;
-    uint32_t en;
-    uint32_t set;
-    uint32_t clear;
-    /* 64bit buf divide into 2 32bit buf */
-    uint32_t buf[IPI_MBX_NUM * 2];
-    qemu_irq irq;
-} IPICore;
+};
+
+struct LoongsonIPIClass {
+    /*< private >*/
+    LoongsonIPICommonClass parent_class;
+    /*< public >*/
 
-struct LoongsonIPI {
-    SysBusDevice parent_obj;
-    MemoryRegion ipi_iocsr_mem;
-    MemoryRegion ipi64_iocsr_mem;
-    uint32_t num_cpu;
-    IPICore *cpu;
+    DeviceRealize parent_realize;
 };
 
 #endif
-- 
2.39.3


