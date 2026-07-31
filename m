Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0796C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFn-0002kq-AS; Fri, 31 Jul 2026 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM8-0005u8-TL; Thu, 30 Jul 2026 23:56:20 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM0-0002Hz-7n; Thu, 30 Jul 2026 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470160; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=ZI+3bdJq7tVDDsPgbwtKOM++Fn1hHx+vxSYYlZlVEQg=;
 b=cFnjnZXyEq5OFc/dPDHWkkAZFWoxgOYbgLDYxFBWuuLfqvJJLHNPjcOwY2Yq5peCRqnzgoBte4K1fASIZp7EfZNmNwsc/yUfDAbNFGZxWPEYHro+ZjtLjPrh/K5Ldhhgsvn9K65Su+L0kRUWmdXkhdmsUlU5n27zPdIERaS+qUU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwRP_1785469846; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwRP_1785469846 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:48 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 03/17] target/riscv/kvm: create and measure a CoVE TEE
 VM
Date: Fri, 31 Jul 2026 11:49:57 +0800
Message-Id: <20260731035011.4178103-4-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

Ask KVM for a TEE VM (TVM) instead of a regular guest when the machine
runs in CoVE mode, and add kvm_riscv_cove_measure_region() to add a
memory region to the initial measurement of that TVM.

The measurement is what allows a CoVE guest to be attested later on, so
failing to add a region to it is fatal.

The KVM ABI this relies on is not part of an upstream Linux release yet, so
KVM_VM_TYPE_RISCV_COVE and KVM_RISCV_COVE_MEASURE_REGION are defined here
rather than imported into linux-headers/.  They have to be replaced by a
regular scripts/update-linux-headers.sh run once the kernel side has been
merged.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 target/riscv/kvm/kvm-cpu.c   | 46 ++++++++++++++++++++++++++++++++++++
 target/riscv/kvm/kvm_riscv.h | 10 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 495cb42dc8..67c99d68ce 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -48,10 +48,27 @@
 #include "migration/misc.h"
 #include "system/runstate.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/cove.h"
 
 #define PR_RISCV_V_SET_CONTROL            69
 #define PR_RISCV_V_VSTATE_CTRL_ON          2
 
+/*
+ * CoVE KVM ABI.  These definitions are not part of an upstream Linux release
+ * yet, so they cannot be imported into linux-headers/ and are kept here until
+ * the kernel side has been merged.
+ */
+#define KVM_VM_TYPE_RISCV_COVE          (1UL << 9)
+
+struct kvm_riscv_cove_measure_region {
+    uint64_t user_addr;
+    uint64_t gpa;
+    uint64_t size;
+};
+
+#define KVM_RISCV_COVE_MEASURE_REGION \
+    _IOR(KVMIO, 0xb5, struct kvm_riscv_cove_measure_region)
+
 void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 {
     kvm_set_irq(kvm_state, irq, !!level);
@@ -1549,6 +1566,9 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 
 int kvm_arch_get_default_type(MachineState *ms)
 {
+    if (riscv_cove_vm_active()) {
+        return KVM_VM_TYPE_RISCV_COVE;
+    }
     return 0;
 }
 
@@ -1829,6 +1849,32 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                     "auto");
 }
 
+/*
+ * Add the contents of a memory region to the initial measurement of the TVM.
+ * Nothing is measured for a guest that is not confidential.
+ */
+void kvm_riscv_cove_measure_region(uint64_t user_addr, uint64_t gpa,
+                                   uint64_t size)
+{
+    struct kvm_riscv_cove_measure_region mr;
+    int ret;
+
+    if (!riscv_cove_vm_active()) {
+        return;
+    }
+
+    mr.user_addr = user_addr;
+    mr.gpa = gpa;
+    mr.size = size;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_RISCV_COVE_MEASURE_REGION, &mr);
+    if (ret < 0) {
+        error_report("Unable to measure CoVE region at 0x%" PRIx64 ": %s",
+                     gpa, strerror(-ret));
+        exit(EXIT_FAILURE);
+    }
+}
+
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index b2bcd1041f..cd45f1266b 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -23,6 +23,16 @@
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+#ifdef CONFIG_KVM
+void kvm_riscv_cove_measure_region(uint64_t user_addr, uint64_t gpa,
+                                   uint64_t size);
+#else
+static inline void kvm_riscv_cove_measure_region(uint64_t user_addr,
+                                                 uint64_t gpa, uint64_t size)
+{
+    /* A CoVE guest cannot be created without KVM, nothing to measure. */
+}
+#endif
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
-- 
2.34.1


