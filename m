Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C1AC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFn-0002l7-Jn; Fri, 31 Jul 2026 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM7-0005u3-T3; Thu, 30 Jul 2026 23:56:19 -0400
Received: from [115.124.30.133] (helo=out30-133.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002IQ-DO; Thu, 30 Jul 2026 23:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470165; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=zT65bYWPtx05OTO3AKdQnA1RvR6F8IODJEuPlw9LxxA=;
 b=Cr1naZdjlfc4iLTPAqJxPybu1NIXLJLjh0GUUuaJhNsXsD2XeVaRlRlMS+PGgg76tLt9UFZ6xwCT5lLQ38W8T+dKUENIMrWSUGVF3U50m6QJlWHxyNqSc7NHY9E59sERhJYYP7GHaEKwkVMLgW9AYyJ5upmFBq0H29YDZjyk4tc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwSN_1785469850; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwSN_1785469850 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:51 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 05/17] hw/riscv/boot: load and measure the images of a
 CoVE guest
Date: Fri, 31 Jul 2026 11:49:59 +0800
Message-Id: <20260731035011.4178103-6-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.133 (deferred)
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The kernel and the initrd of a CoVE guest are part of the initial
measurement of the TEE VM, which means they have to be written to guest
memory and measured before the guest is started.

Add riscv_cove_load_kernel(), which handles ELF, uImage and raw images,
and measure the initrd as well when one is given.  The host address of a
loaded image is derived from the RAM memory region because the memory
slots of a TVM cannot be used for that this early during machine
initialisation.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/riscv/boot.c       | 91 +++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-events |  4 ++
 2 files changed, 95 insertions(+)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5e2dfa091a..70c4009a66 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -27,11 +27,14 @@
 #include "hw/core/loader.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/boot_opensbi.h"
+#include "hw/riscv/cove.h"
+#include "kvm/kvm_riscv.h"
 #include "elf.h"
 #include "system/device_tree.h"
 #include "system/qtest.h"
 #include "system/kvm.h"
 #include "system/reset.h"
+#include "trace.h"
 
 #include <libfdt.h>
 
@@ -261,6 +264,86 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
         qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start);
         qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
     }
+
+    /* The initrd is part of the initial measurement of a CoVE guest. */
+    if (riscv_cove_vm_active()) {
+        void *initrd_host = kvm_gpa_to_userspace_addr(kvm_state, start);
+        uint64_t aligned_size = ROUND_UP(size, 4 * KiB);
+
+        trace_riscv_cove_measure_initrd(start, aligned_size);
+        kvm_riscv_cove_measure_region((uint64_t)(uintptr_t)initrd_host,
+                                      start, aligned_size);
+    }
+}
+
+/* Load address of a raw kernel image, relative to the base of the RAM. */
+#define RISCV_COVE_KERNEL_OFFSET 0x200000
+
+/*
+ * Load the kernel of a CoVE guest and add it to the initial measurement of
+ * the TVM. ELF, uImage and raw images are supported.
+ *
+ * Unlike riscv_load_kernel(), the host address of the loaded image has to be
+ * computed from the RAM memory region: the KVM memory slots of a TVM are not
+ * usable for that yet at this point of the machine initialisation.
+ *
+ * Returns the guest physical address to start the guest from.
+ */
+static uint64_t riscv_cove_load_kernel(MachineState *machine,
+                                       const char *kernel_filename,
+                                       uint64_t mem_size,
+                                       symbol_fn_t sym_cb)
+{
+    MemoryRegion *ram = machine->ram;
+    void *ram_base = memory_region_get_ram_ptr(ram);
+    uint64_t elf_entry, elf_low, elf_high;
+    hwaddr uimage_ep, uimage_loadaddr;
+    hwaddr kernel_gpa;
+    ssize_t size;
+
+    size = load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
+                            &elf_entry, &elf_low, &elf_high,
+                            NULL, 0, EM_RISCV, 1, 0,
+                            NULL, false, sym_cb);
+    if (size > 0) {
+        trace_riscv_cove_measure_kernel("ELF", elf_low, elf_high - elf_low);
+        kvm_riscv_cove_measure_region((uint64_t)(uintptr_t)ram_base +
+                                      (elf_low - ram->addr),
+                                      elf_low, elf_high - elf_low);
+        return elf_entry;
+    }
+
+    uimage_loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
+    size = load_uimage_as(kernel_filename, &uimage_ep, &uimage_loadaddr,
+                          NULL, NULL, NULL, NULL);
+    if (size > 0) {
+        trace_riscv_cove_measure_kernel("uImage", uimage_loadaddr, size);
+        kvm_riscv_cove_measure_region((uint64_t)(uintptr_t)ram_base +
+                                      (uimage_loadaddr - ram->addr),
+                                      uimage_loadaddr, size);
+        return uimage_ep;
+    }
+
+    /*
+     * Read the image straight into RAM: load_image_targphys_as() would
+     * register a ROM blob, whose contents are only written to guest memory
+     * when the machine is reset, long after the measurement has been taken.
+     */
+    kernel_gpa = ram->addr + RISCV_COVE_KERNEL_OFFSET;
+    size = load_image_size(kernel_filename,
+                           (char *)ram_base + RISCV_COVE_KERNEL_OFFSET,
+                           mem_size - RISCV_COVE_KERNEL_OFFSET);
+    if (size < 0) {
+        error_report("could not load kernel '%s': %s", kernel_filename,
+                     strerror(errno));
+        exit(1);
+    }
+
+    trace_riscv_cove_measure_kernel("raw", kernel_gpa, size);
+    kvm_riscv_cove_measure_region((uint64_t)(uintptr_t)ram_base +
+                                  RISCV_COVE_KERNEL_OFFSET,
+                                  kernel_gpa, size);
+    return kernel_gpa;
 }
 
 void riscv_load_kernel(MachineState *machine,
@@ -276,6 +359,14 @@ void riscv_load_kernel(MachineState *machine,
 
     g_assert(kernel_filename != NULL);
 
+    /* A CoVE guest is loaded and measured before the TVM is finalised. */
+    if (riscv_cove_vm_active()) {
+        info->image_low_addr = riscv_cove_load_kernel(machine, kernel_filename,
+                                                      mem_size, sym_cb);
+        info->image_high_addr = info->image_low_addr;
+        goto out;
+    }
+
     /*
      * NB: Use low address not ELF entry point to ensure that the fw_dynamic
      * behaviour when loading an ELF matches the fw_payload, fw_jump and BBL
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index b50b14a654..04f4b90efa 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -24,3 +24,7 @@ riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
 riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
 riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
 riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
+
+# boot.c
+riscv_cove_measure_kernel(const char *format, uint64_t gpa, uint64_t size) "%s kernel gpa 0x%"PRIx64" size 0x%"PRIx64
+riscv_cove_measure_initrd(uint64_t gpa, uint64_t size) "initrd gpa 0x%"PRIx64" size 0x%"PRIx64
-- 
2.34.1


