Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EBCC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFY-0002bl-8B; Fri, 31 Jul 2026 01:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM5-0005qr-6J; Thu, 30 Jul 2026 23:56:18 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002Hn-78; Thu, 30 Jul 2026 23:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470157; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=VJWkJluchzKSNULaL74QEFDHFaTH5ibDQItbZKM6t28=;
 b=MAQhj9yWOj6ZlEWDXIavJfXKGwWWBXnZnMnuJziKsy5KletC3dXh7s/aSi6ZV3bF7FaAN89cKLtDrnz6r/2RSspzkkSbozBDKvDgGJ654sClyBMC2P+40E+LLlLNZP3keIA76weHP73aNeoEOy64+3eizfRGTYM9tBecMSyPPaA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwOS_1785469837; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwOS_1785469837 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:45 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 02/17] hw/riscv/virt: add the cove-vm machine property
Date: Fri, 31 Jul 2026 11:49:56 +0800
Message-Id: <20260731035011.4178103-3-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:31 -0400
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

A RISC-V CoVE guest is a TEE VM (TVM) whose memory and vCPU state are
owned by the TEE Security Manager (TSM) rather than by the host.  Add a
'cove-vm' property to the virt machine to ask for one.

Subsystems outside of hw/riscv/, such as the KVM accelerator and the
virtio code, have to know whether the guest is a TVM.  The state is
therefore mirrored into target independent code and queried through
riscv_cove_vm_active(); keeping the implementation in hw/core/machine.c
avoids a link time dependency on target/riscv.

Nothing looks at the property yet.  Add a MAINTAINERS entry for the new
header.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 MAINTAINERS             |  6 ++++++
 hw/core/machine.c       | 18 ++++++++++++++++++
 hw/riscv/virt.c         | 26 ++++++++++++++++++++++++++
 include/hw/riscv/cove.h | 24 ++++++++++++++++++++++++
 include/hw/riscv/virt.h |  1 +
 5 files changed, 75 insertions(+)
 create mode 100644 include/hw/riscv/cove.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..dab130a45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -391,6 +391,12 @@ F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
+RISC-V CoVE
+M: Baolong Duan <blduan@linux.alibaba.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: include/hw/riscv/cove.h
+
 RENESAS RX CPUs
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73b4d82b4a..578a5cdde5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -16,6 +16,7 @@
 #include "system/replay.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
+#include "hw/riscv/cove.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
@@ -1335,6 +1336,23 @@ bool machine_require_guest_memfd(MachineState *machine)
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
 
+/*
+ * Whether the machine runs as a RISC-V CoVE guest. This lives here, and not
+ * in hw/riscv/, because target independent code has to query it and must not
+ * depend on the RISC-V machine being linked in.
+ */
+static bool riscv_cove_vm;
+
+bool riscv_cove_vm_active(void)
+{
+    return riscv_cove_vm;
+}
+
+void riscv_cove_vm_set_active(bool active)
+{
+    riscv_cove_vm = active;
+}
+
 static char *cpu_slot_to_string(const CPUArchId *cpu)
 {
     GString *s = g_string_new(NULL);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91..a76587d362 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -35,6 +35,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/cove.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
@@ -1321,6 +1322,11 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+    if (s->cove_vm && !kvm_enabled()) {
+        error_report("'cove-vm' is only available with KVM acceleration");
+        exit(1);
+    }
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1652,6 +1658,21 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
+static bool virt_get_cove_vm(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->cove_vm;
+}
+
+static void virt_set_cove_vm(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->cove_vm = value;
+    riscv_cove_vm_set_active(value);
+}
+
 bool virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
@@ -1780,6 +1801,11 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "iommu-sys",
                                           "Enable IOMMU platform device");
+
+    object_class_property_add_bool(oc, "cove-vm", virt_get_cove_vm,
+                                   virt_set_cove_vm);
+    object_class_property_set_description(oc, "cove-vm",
+                                          "Enable CoVE confidential VM");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/cove.h b/include/hw/riscv/cove.h
new file mode 100644
index 0000000000..0b29a00786
--- /dev/null
+++ b/include/hw/riscv/cove.h
@@ -0,0 +1,24 @@
+/*
+ * RISC-V Confidential VM Extension (CoVE)
+ *
+ * Copyright (c) 2026 Alibaba Group
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_COVE_H
+#define HW_RISCV_COVE_H
+
+/*
+ * A CoVE guest is a TEE VM (TVM) whose memory and vCPU state are owned by
+ * the TEE Security Manager (TSM) instead of the host. Subsystems outside of
+ * hw/riscv/ have to behave differently for such a guest, so the state is
+ * kept in target independent code.
+ *
+ * riscv_cove_vm_set_active() is called by the machine that implements CoVE
+ * while its properties are parsed, before any device is created.
+ */
+bool riscv_cove_vm_active(void);
+void riscv_cove_vm_set_active(bool active);
+
+#endif /* HW_RISCV_COVE_H */
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 36a2def410..99e073ef9a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -60,6 +60,7 @@ struct RISCVVirtState {
     char *oem_id;
     char *oem_table_id;
     OnOffAuto acpi;
+    bool cove_vm;
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
-- 
2.34.1


