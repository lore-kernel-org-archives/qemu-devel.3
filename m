Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D82C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 03:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTve3-0006RR-JL; Tue, 16 Jul 2024 23:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sTvdx-0006H2-0a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sTvdp-00047f-JE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxPOvZPpdm01oFAA--.13478S3;
 Wed, 17 Jul 2024 11:47:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08TYPpdmIgdMAA--.29770S3; 
 Wed, 17 Jul 2024 11:47:37 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>
Subject: [RFC 1/4] hw/loongarch: Add KVM IPI device support
Date: Wed, 17 Jul 2024 11:29:53 +0800
Message-Id: <df3ccc6529aa131ab120637e402066ff91751f3b.1721186636.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1721186636.git.lixianglai@loongson.cn>
References: <cover.1721186636.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx08TYPpdmIgdMAA--.29770S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

Added ipi interrupt controller for kvm emulation.
The main process is to send the command word for
creating an ipi device to the kernel.
When the VM is saved, the ioctl obtains the ipi
interrupt controller data in the kernel and saves it.
When the VM is recovered, the saved data is sent to the kernel.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Huacai Chen <chenhuacai@kernel.org> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Cornelia Huck <cohuck@redhat.com> 
Cc: kvm@vger.kernel.org 
Cc: Bibo Mao <maobibo@loongson.cn> 

 hw/intc/Kconfig                   |   4 +
 hw/intc/loongarch_ipi_kvm.c       | 207 ++++++++++++++++++++++++++++++
 hw/intc/meson.build               |   1 +
 hw/loongarch/virt.c               |  40 ++++--
 include/hw/intc/loongson_ipi.h    |  22 ++++
 linux-headers/asm-loongarch/kvm.h |   1 +
 linux-headers/linux/kvm.h         |   2 +
 target/loongarch/kvm/kvm.c        |   1 +
 8 files changed, 265 insertions(+), 13 deletions(-)
 create mode 100644 hw/intc/loongarch_ipi_kvm.c

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 58b6d3a710..19d6809129 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -90,6 +90,10 @@ config M68K_IRQC
 config LOONGSON_IPI
     bool
 
+config LOONGARCH_IPI_KVM
+    bool
+    default y
+
 config LOONGARCH_PCH_PIC
     bool
     select UNIMP
diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
new file mode 100644
index 0000000000..5dc78847e6
--- /dev/null
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch kvm ipi interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "qemu/typedefs.h"
+#include "hw/intc/loongson_ipi.h"
+#include "hw/sysbus.h"
+#include "linux/kvm.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "sysemu/kvm.h"
+
+#define IPI_DEV_FD_UNDEF        -1
+
+static void kvm_ipi_access_regs(int fd, uint64_t addr,
+                                uint32_t *val, int is_write)
+{
+        kvm_device_access(fd, KVM_DEV_LOONGARCH_IPI_GRP_REGS,
+                          addr, val, is_write, &error_abort);
+}
+
+static int kvm_loongarch_ipi_pre_save(void *opaque)
+{
+    KVMLoongArchIPI *ipi = (KVMLoongArchIPI *)opaque;
+    KVMLoongArchIPIClass *ipi_class = KVM_LOONGARCH_IPI_GET_CLASS(ipi);
+    IPICore *cpu;
+    uint64_t attr;
+    int cpu_id = 0;
+    int fd = ipi_class->dev_fd;
+
+    for (cpu_id = 0; cpu_id < ipi->num_cpu; cpu_id++) {
+        cpu = &ipi->cpu[cpu_id];
+        attr = (cpu_id << 16) | CORE_STATUS_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->status, false);
+
+        attr = (cpu_id << 16) | CORE_EN_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->en, false);
+
+        attr = (cpu_id << 16) | CORE_SET_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->set, false);
+
+        attr = (cpu_id << 16) | CORE_CLEAR_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->clear, false);
+
+        attr = (cpu_id << 16) | CORE_BUF_20;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[0], false);
+
+        attr = (cpu_id << 16) | CORE_BUF_28;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[2], false);
+
+        attr = (cpu_id << 16) | CORE_BUF_30;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[4], false);
+
+        attr = (cpu_id << 16) | CORE_BUF_38;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[6], false);
+    }
+
+    return 0;
+}
+
+static int kvm_loongarch_ipi_post_load(void *opaque, int version_id)
+{
+    KVMLoongArchIPI *ipi = (KVMLoongArchIPI *)opaque;
+    KVMLoongArchIPIClass *ipi_class = KVM_LOONGARCH_IPI_GET_CLASS(ipi);
+    IPICore *cpu;
+    uint64_t attr;
+    int cpu_id = 0;
+    int fd = ipi_class->dev_fd;
+
+    for (cpu_id = 0; cpu_id < ipi->num_cpu; cpu_id++) {
+        cpu = &ipi->cpu[cpu_id];
+        attr = (cpu_id << 16) | CORE_STATUS_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->status, true);
+
+        attr = (cpu_id << 16) | CORE_EN_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->en, true);
+
+        attr = (cpu_id << 16) | CORE_SET_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->set, true);
+
+        attr = (cpu_id << 16) | CORE_CLEAR_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->clear, true);
+
+        attr = (cpu_id << 16) | CORE_BUF_20;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[0], true);
+
+        attr = (cpu_id << 16) | CORE_BUF_28;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[2], true);
+
+        attr = (cpu_id << 16) | CORE_BUF_30;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[4], true);
+
+        attr = (cpu_id << 16) | CORE_BUF_38;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[6], true);
+    }
+
+    return 0;
+}
+
+static void kvm_loongarch_ipi_realize(DeviceState *dev, Error **errp)
+{
+    KVMLoongArchIPI *ipi = KVM_LOONGARCH_IPI(dev);
+    KVMLoongArchIPIClass *ipi_class = KVM_LOONGARCH_IPI_GET_CLASS(dev);
+    struct kvm_create_device cd = {0};
+    Error *err = NULL;
+    int ret;
+
+    if (ipi->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    ipi_class->parent_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    ipi->cpu = g_new0(IPICore, ipi->num_cpu);
+    if (ipi->cpu == NULL) {
+        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        return;
+    }
+
+    if (!ipi_class->is_created) {
+        cd.type = KVM_DEV_TYPE_LA_IPI;
+        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "Creating the KVM device failed");
+            return;
+        }
+        ipi_class->is_created = true;
+        ipi_class->dev_fd = cd.fd;
+        fprintf(stdout, "Create LoongArch IPI irqchip in KVM done!\n");
+    }
+
+    assert(ipi_class->dev_fd != IPI_DEV_FD_UNDEF);
+}
+
+static Property kvm_loongarch_ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", KVMLoongArchIPI, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static const VMStateDescription vmstate_kvm_ipi_core = {
+    .name = "kvm-ipi-single",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(status, IPICore),
+        VMSTATE_UINT32(en, IPICore),
+        VMSTATE_UINT32(set, IPICore),
+        VMSTATE_UINT32(clear, IPICore),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, 8),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_kvm_loongarch_ipi = {
+    .name = TYPE_KVM_LOONGARCH_IPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = kvm_loongarch_ipi_pre_save,
+    .post_load = kvm_loongarch_ipi_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, KVMLoongArchIPI, num_cpu,
+                         vmstate_kvm_ipi_core, IPICore),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kvm_loongarch_ipi_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    KVMLoongArchIPIClass *ipi_class = KVM_LOONGARCH_IPI_CLASS(oc);
+
+    ipi_class->parent_realize = dc->realize;
+    dc->realize = kvm_loongarch_ipi_realize;
+
+    ipi_class->is_created = false;
+    ipi_class->dev_fd = IPI_DEV_FD_UNDEF;
+
+    device_class_set_props(dc, kvm_loongarch_ipi_properties);
+
+    dc->vmsd = &vmstate_kvm_loongarch_ipi;
+}
+
+static const TypeInfo kvm_loongarch_ipi_info = {
+    .name = TYPE_KVM_LOONGARCH_IPI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(KVMLoongArchIPI),
+    .class_size = sizeof(KVMLoongArchIPIClass),
+    .class_init = kvm_loongarch_ipi_class_init,
+};
+
+static void kvm_loongarch_ipi_register_types(void)
+{
+    type_register_static(&kvm_loongarch_ipi_info);
+}
+
+type_init(kvm_loongarch_ipi_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..354d43b4f0 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -70,6 +70,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_IPI_KVM', if_true: files('loongarch_ipi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e592b1b6b7..2ae5298b62 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -48,6 +48,7 @@
 #include "hw/block/flash.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
+#include "sysemu/kvm.h"
 
 static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
@@ -788,15 +789,32 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
-    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
-
-    /* IPI iocsr memory region */
-    memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
-                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
-    memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
-                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+    if (kvm_kernel_irqchip_allowed()) {
+        ipi = qdev_new(TYPE_KVM_LOONGARCH_IPI);
+        qdev_prop_set_int32(ipi, "num-cpu", ms->smp.cpus);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    } else {
+        ipi = qdev_new(TYPE_LOONGSON_IPI);
+        qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+
+        /* IPI iocsr memory region */
+        memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
+                       sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+        memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
+                       sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+
+        for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
+            cpu_state = qemu_get_cpu(cpu);
+            cpudev = DEVICE(cpu_state);
+            lacpu = LOONGARCH_CPU(cpu_state);
+            env = &(lacpu->env);
+
+            /* connect ipi irq to cpu irq */
+            qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
+            env->ipistate = ipi;
+        }
+    }
 
     /* Add cpu interrupt-controller */
     fdt_add_cpuic_node(lvms, &cpuintc_phandle);
@@ -807,10 +825,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         lacpu = LOONGARCH_CPU(cpu_state);
         env = &(lacpu->env);
         env->address_space_iocsr = &lvms->as_iocsr;
-
-        /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        env->ipistate = ipi;
     }
 
     /* Create EXTIOI device */
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 3f795edbf3..55d7435cfd 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -32,6 +32,7 @@
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
+#define TYPE_KVM_LOONGARCH_IPI "loongarch-ipi-kvm"
 
 typedef struct IPICore {
     LoongsonIPI *ipi;
@@ -53,4 +54,25 @@ struct LoongsonIPI {
     IPICore *cpu;
 };
 
+struct KVMLoongArchIPI {
+    SysBusDevice parent_obj;
+    uint32_t num_cpu;
+    IPICore *cpu;
+};
+typedef struct KVMLoongArchIPI KVMLoongArchIPI;
+DECLARE_INSTANCE_CHECKER(KVMLoongArchIPI, KVM_LOONGARCH_IPI,
+                         TYPE_KVM_LOONGARCH_IPI)
+
+struct KVMLoongArchIPIClass {
+    SysBusDeviceClass parent_class;
+    DeviceRealize parent_realize;
+
+    bool is_created;
+    int dev_fd;
+
+};
+typedef struct KVMLoongArchIPIClass KVMLoongArchIPIClass;
+DECLARE_CLASS_CHECKERS(KVMLoongArchIPIClass, KVM_LOONGARCH_IPI,
+                       TYPE_KVM_LOONGARCH_IPI)
+
 #endif
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index f9abef3823..91c6f591fb 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -108,4 +108,5 @@ struct kvm_iocsr_entry {
 #define KVM_IRQCHIP_NUM_PINS	64
 #define KVM_MAX_CORES		256
 
+#define KVM_DEV_LOONGARCH_IPI_GRP_REGS		1
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c93876ca0b..3714ff1a94 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1138,6 +1138,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_RISCV_AIA,
 #define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
+	KVM_DEV_TYPE_LA_IPI,
+#define KVM_DEV_TYPE_LA_IPI		KVM_DEV_TYPE_LA_IPI
 	KVM_DEV_TYPE_MAX,
 };
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index e1be6a6959..c07dcfd85f 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -719,6 +719,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    s->kernel_irqchip_allowed = false;
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
-- 
2.39.1


