Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD473C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoHe-0001X5-RO; Thu, 27 Jun 2024 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sMoHd-0001Wv-Qm
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:31:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sMoHR-0004VH-Ul
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:31:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxX+uOW31mg6YKAA--.42875S3;
 Thu, 27 Jun 2024 20:31:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx78eLW31mKjwzAA--.55672S4; 
 Thu, 27 Jun 2024 20:31:09 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn,
 chenhuacai@kernel.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com
Subject: [RESEND PATCH 2/2] hw/intc: Restore loongarch_ipi for LoongArch
Date: Thu, 27 Jun 2024 20:13:48 +0800
Message-Id: <20240627121348.3412568-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240627121348.3412568-1-gaosong@loongson.cn>
References: <20240627121348.3412568-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx78eLW31mKjwzAA--.55672S4
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

Currently LoongArch and MIPS architectures share loongson_ipi,
and modifications to loongson_ipi by the MIPS architecture may
lead to some unknown problems in the LoongArch architecture.
In order to minimize the impact of this inter-architectural
interaction, we believe that it is necessary to restore loongarch_ipi.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 MAINTAINERS                     |  2 --
 include/hw/intc/loongarch_ipi.h | 54 +++++++++++++++++++++++++++++++++
 include/hw/loongarch/virt.h     |  2 +-
 hw/loongarch/virt.c             |  4 +--
 hw/intc/Kconfig                 |  3 ++
 hw/intc/meson.build             |  1 +
 hw/intc/trace-events            |  3 ++
 hw/loongarch/Kconfig            |  2 +-
 8 files changed, 65 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 19f67dc5d2..9d7575a7f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1246,9 +1246,7 @@ F: configs/devices/loongarch64-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
-F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
-F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
new file mode 100644
index 0000000000..1c1e834849
--- /dev/null
+++ b/include/hw/intc/loongarch_ipi.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch ipi interrupt header files
+ *
+ * Copyright (C) 2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_IPI_H
+#define HW_LOONGARCH_IPI_H
+
+#include "hw/sysbus.h"
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
+#define TYPE_LOONGARCH_IPI "loongarch_ipi"
+OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
+
+typedef struct IPICore {
+    uint32_t status;
+    uint32_t en;
+    uint32_t set;
+    uint32_t clear;
+    /* 64bit buf divide into 2 32bit buf */
+    uint32_t buf[IPI_MBX_NUM * 2];
+    qemu_irq irq;
+} IPICore;
+
+struct LoongArchIPI {
+    SysBusDevice parent_obj;
+    MemoryRegion ipi_iocsr_mem;
+    MemoryRegion ipi64_iocsr_mem;
+    uint32_t num_cpu;
+    IPICore *cpu;
+};
+
+#endif
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8fdfacf268..fe92971de1 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -11,7 +11,7 @@
 #include "target/loongarch/cpu.h"
 #include "hw/boards.h"
 #include "qemu/queue.h"
-#include "hw/intc/loongson_ipi.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8be2d2ff6a..6bef2f1165 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -23,7 +23,7 @@
 #include "net/net.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/intc/loongson_ipi.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "hw/intc/loongarch_pch_msi.h"
@@ -788,7 +788,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
      */
 
     /* Create IPI device */
-    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 58b6d3a710..576c04e4e4 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -87,6 +87,9 @@ config GOLDFISH_PIC
 config M68K_IRQC
     bool
 
+config LOONGARCH_IPI
+    bool
+
 config LOONGSON_IPI
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index afd1aa51ee..19b719c336 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -70,6 +70,7 @@ specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 3dcf147198..4e42360a60 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -307,6 +307,9 @@ sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
 # loongson_ipi.c
 loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 loongson_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+# loongarch_ipi.c
+loongarch_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
+loongarch_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
 loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 90a0dba9d5..830cfef72d 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -11,7 +11,7 @@ config LOONGARCH_VIRT
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-    select LOONGSON_IPI
+    select LOONGARCH_IPI
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
-- 
2.34.1


