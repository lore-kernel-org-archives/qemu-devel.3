Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10340C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpUd-0005ew-GV; Tue, 02 Jul 2024 22:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOpUc-0005ea-1X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOpUM-0001lu-06
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:13:09 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvfCes4Rm1VwAAA--.1377S3;
 Wed, 03 Jul 2024 10:12:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMWds4RmPSQ5AA--.57057S3; 
 Wed, 03 Jul 2024 10:12:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/intc/loongson_ipi_common: Add loongson ipi common class
Date: Wed,  3 Jul 2024 10:12:43 +0800
Message-Id: <20240703021245.3752786-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703021245.3752786-1-maobibo@loongson.cn>
References: <20240703021245.3752786-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMWds4RmPSQ5AA--.57057S3
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

Loongson ipi common class and instance is created here, it comes
from file loongson_ipi mostly. For the new added loongson ipi
common class, there is four interfaces defined here:
 1. Interfaces pre_save/post_load are used for future kvm child class
 2. Interface get_iocsr_as can be used for different architectures,
now MIPS 3A4000 and LoongArch 3A5000 machine use this ip, can inherit
this common class.
 3. Interace cpu_by_arch_id is added, by default generic function
cpu_by_arch_id() is used to search vcpu from physical cpuid, it is
generic searching method. Different machine may define another search
method such binary searching method.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
 include/hw/intc/loongson_ipi_common.h |  71 +++++
 2 files changed, 465 insertions(+)
 create mode 100644 hw/intc/loongson_ipi_common.c
 create mode 100644 include/hw/intc/loongson_ipi_common.h

diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
new file mode 100644
index 0000000000..f462f24f32
--- /dev/null
+++ b/hw/intc/loongson_ipi_common.c
@@ -0,0 +1,394 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt support
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "hw/sysbus.h"
+#include "hw/intc/loongson_ipi_common.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
+                                           uint64_t *data,
+                                           unsigned size, MemTxAttrs attrs)
+{
+    IPICore *s = opaque;
+    uint64_t ret = 0;
+    int index = 0;
+
+    addr &= 0xff;
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        ret = s->status;
+        break;
+    case CORE_EN_OFF:
+        ret = s->en;
+        break;
+    case CORE_SET_OFF:
+        ret = 0;
+        break;
+    case CORE_CLEAR_OFF:
+        ret = 0;
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        ret = s->buf[index];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
+        break;
+    }
+
+    trace_loongson_ipi_read(size, (uint64_t)addr, ret);
+    *data = ret;
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
+                                            uint64_t *data,
+                                            unsigned size, MemTxAttrs attrs)
+{
+    LoongsonIPICommonState *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_readl(s, addr, data, size, attrs);
+}
+
+static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
+                                 uint64_t val,
+                                 hwaddr addr, MemTxAttrs attrs)
+{
+    int i, mask = 0, data = 0;
+    AddressSpace *iocsr_as;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+
+    iocsr_as = NULL;
+    if (licc->get_iocsr_as) {
+        iocsr_as = licc->get_iocsr_as(cpu);
+    }
+
+    if (!iocsr_as) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /*
+     * bit 27-30 is mask for byte writing,
+     * if the mask is 0, we need not to do anything.
+     */
+    if ((val >> 27) & 0xf) {
+        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
+        for (i = 0; i < 4; i++) {
+            /* get mask for byte writing */
+            if (val & (0x1 << (27 + i))) {
+                mask |= 0xff << (i * 8);
+            }
+        }
+    }
+
+    data &= mask;
+    data |= (val >> 32) & ~mask;
+    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
+
+    return MEMTX_OK;
+}
+
+static CPUState *get_cpu_by_arch_id(LoongsonIPICommonState *ipi, uint32_t cpuid)
+{
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(ipi);
+
+    if (licc->cpu_by_arch_id) {
+        return licc->cpu_by_arch_id(cpuid);
+    }
+
+    return cpu_by_arch_id(cpuid);
+}
+
+static MemTxResult mail_send(LoongsonIPICommonState *ipi, uint64_t val,
+                             MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = get_cpu_by_arch_id(ipi, cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
+    attrs.requester_id = cs->cpu_index;
+    return send_ipi_data(ipi, cs, val, addr, attrs);
+}
+
+static MemTxResult any_send(LoongsonIPICommonState *ipi, uint64_t val,
+                            MemTxAttrs attrs)
+{
+    uint32_t cpuid;
+    hwaddr addr;
+    CPUState *cs;
+
+    cpuid = extract32(val, 16, 10);
+    cs = get_cpu_by_arch_id(ipi, cpuid);
+    if (cs == NULL) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    /* override requester_id */
+    addr = val & 0xffff;
+    attrs.requester_id = cs->cpu_index;
+    return send_ipi_data(ipi, cs, val, addr, attrs);
+}
+
+static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
+                                            uint64_t val, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    IPICore *s = opaque;
+    LoongsonIPICommonState *ipi = s->ipi;
+    int index = 0;
+    uint32_t cpuid;
+    uint8_t vector;
+    CPUState *cs;
+
+    addr &= 0xff;
+    trace_loongson_ipi_write(size, (uint64_t)addr, val);
+    switch (addr) {
+    case CORE_STATUS_OFF:
+        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
+        break;
+    case CORE_EN_OFF:
+        s->en = val;
+        break;
+    case CORE_SET_OFF:
+        s->status |= val;
+        if (s->status != 0 && (s->status & s->en) != 0) {
+            qemu_irq_raise(s->irq);
+        }
+        break;
+    case CORE_CLEAR_OFF:
+        s->status &= ~val;
+        if (s->status == 0 && s->en != 0) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    case CORE_BUF_20 ... CORE_BUF_38 + 4:
+        index = (addr - CORE_BUF_20) >> 2;
+        s->buf[index] = val;
+        break;
+    case IOCSR_IPI_SEND:
+        cpuid = extract32(val, 16, 10);
+        /* IPI status vector */
+        vector = extract8(val, 0, 5);
+        cs = get_cpu_by_arch_id(ipi, cpuid);
+        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
+            return MEMTX_DECODE_ERROR;
+        }
+        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
+                                 BIT(vector), 4, attrs);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
+                                            uint64_t val, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    LoongsonIPICommonState *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_writel(s, addr, val, size, attrs);
+}
+
+static const MemoryRegionOps loongson_ipi_iocsr_ops = {
+    .read_with_attrs = loongson_ipi_iocsr_readl,
+    .write_with_attrs = loongson_ipi_iocsr_writel,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* mail send and any send only support writeq */
+static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
+{
+    MemTxResult ret = MEMTX_OK;
+    LoongsonIPICommonState *ipi = opaque;
+
+    addr &= 0xfff;
+    switch (addr) {
+    case MAIL_SEND_OFFSET:
+        ret = mail_send(ipi, val, attrs);
+        break;
+    case ANY_SEND_OFFSET:
+        ret = any_send(ipi, val, attrs);
+        break;
+    default:
+       break;
+    }
+
+    return ret;
+}
+
+static const MemoryRegionOps loongson_ipi64_ops = {
+    .write_with_attrs = loongson_ipi_writeq,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi_iocsr_ops,
+                          s, "loongson_ipi_iocsr", 0x48);
+
+    /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
+    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
+
+    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
+
+    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi64_ops,
+                          s, "loongson_ipi64_iocsr", 0x118);
+    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
+
+    s->cpu = g_new0(IPICore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for IPICore faile");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
+}
+
+static int loongson_ipi_pre_save(void *opaque)
+{
+    LoongsonIPICommonState *s = (LoongsonIPICommonState *)opaque;
+    LoongsonIPICommonClass *c = LOONGSON_IPI_COMMON_GET_CLASS(s);
+
+    if (c->pre_save) {
+        c->pre_save(s);
+    }
+
+    return 0;
+}
+
+static int loongson_ipi_post_load(void *opaque, int version_id)
+{
+    LoongsonIPICommonState *s = (LoongsonIPICommonState *)opaque;
+    LoongsonIPICommonClass *c = LOONGSON_IPI_COMMON_GET_CLASS(s);
+
+    if (c->post_load) {
+        c->post_load(s);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_ipi_core = {
+    .name = "ipi-single",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(status, IPICore),
+        VMSTATE_UINT32(en, IPICore),
+        VMSTATE_UINT32(set, IPICore),
+        VMSTATE_UINT32(clear, IPICore),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongson_ipi = {
+    /* Fixed name to keep compatible */
+    .name = "loongson_ipi",
+    .pre_save  = loongson_ipi_pre_save,
+    .post_load = loongson_ipi_post_load,
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongsonIPICommonState,
+                                       num_cpu, vmstate_ipi_core, IPICore),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void loongson_ipi_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = loongson_ipi_common_realize;
+    device_class_set_props(dc, ipi_properties);
+    dc->vmsd = &vmstate_loongson_ipi;
+}
+
+static void loongson_ipi_common_finalize(Object *obj)
+{
+    LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(obj);
+
+    g_free(s->cpu);
+}
+
+static const TypeInfo loongson_ipi_common_info = {
+    .name          = TYPE_LOONGSON_IPI_COMMON,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LoongsonIPICommonState),
+    .class_size    = sizeof(LoongsonIPICommonClass),
+    .class_init    = loongson_ipi_common_class_init,
+    .instance_finalize = loongson_ipi_common_finalize,
+    .abstract = true,
+};
+
+static void loongson_ipi_common_register_types(void)
+{
+    type_register_static(&loongson_ipi_common_info);
+}
+
+type_init(loongson_ipi_common_register_types)
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
new file mode 100644
index 0000000000..1f074863e6
--- /dev/null
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson ipi interrupt header files
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGSON_IPI_COMMON_H
+#define HW_LOONGSON_IPI_COMMON_H
+
+#include "hw/sysbus.h"
+#include "hw/core/cpu.h"
+#include "qom/object.h"
+
+/* Mainy used by iocsr read and write */
+#define SMP_IPI_MAILBOX      0x1000ULL
+#define CORE_STATUS_OFF       0x0
+#define CORE_EN_OFF           0x4
+#define CORE_SET_OFF          0x8
+#define CORE_CLEAR_OFF        0xc
+#define CORE_BUF_20           0x20
+#define CORE_BUF_28           0x28
+#define CORE_BUF_30           0x30
+#define CORE_BUF_38           0x38
+#define IOCSR_IPI_SEND        0x40
+#define IOCSR_MAIL_SEND       0x48
+#define IOCSR_ANY_SEND        0x158
+
+#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
+#define MAIL_SEND_OFFSET      0
+#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
+
+#define IPI_MBX_NUM           4
+
+#define TYPE_LOONGSON_IPI_COMMON "loongson_ipi_common"
+typedef struct LoongsonIPICommonClass LoongsonIPICommonClass;
+typedef struct LoongsonIPICommonState LoongsonIPICommonState;
+DECLARE_OBJ_CHECKERS(LoongsonIPICommonState, LoongsonIPICommonClass,
+                     LOONGSON_IPI_COMMON, TYPE_LOONGSON_IPI_COMMON)
+
+typedef struct IPICore {
+    LoongsonIPICommonState *ipi;
+    uint32_t status;
+    uint32_t en;
+    uint32_t set;
+    uint32_t clear;
+    /* 64bit buf divide into 2 32bit buf */
+    uint32_t buf[IPI_MBX_NUM * 2];
+    qemu_irq irq;
+} IPICore;
+
+struct LoongsonIPICommonState {
+    SysBusDevice parent_obj;
+    MemoryRegion ipi_iocsr_mem;
+    MemoryRegion ipi64_iocsr_mem;
+    uint32_t num_cpu;
+    IPICore *cpu;
+};
+
+struct LoongsonIPICommonClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+
+    void (*pre_save)(LoongsonIPICommonState *s);
+    void (*post_load)(LoongsonIPICommonState *s);
+    AddressSpace *(*get_iocsr_as)(CPUState *cpu);
+    CPUState *(*cpu_by_arch_id)(int64_t id);
+};
+
+#endif
-- 
2.39.3


