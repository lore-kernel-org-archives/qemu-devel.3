Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EBBCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyTH3-0002GF-QL; Tue, 16 Sep 2025 06:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1uyTH1-0002Fd-D9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:50:59 -0400
Received: from sg-1-31.ptr.blmpb.com ([118.26.132.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1uyTGt-000464-Cd
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1758019742;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+9vn+SKpf2HMKD44yBoekBv/fHaycbLcBaJxlmib6/w=;
 b=CrfG6Rw1sscFsut1IElxYXaQSRCLu5x9k8nf2ECSpBj4gsevYiWEzvnSbang3mfLURl/Wy
 JuQPenZ4bLrg/0aUkzMoigFbVL/s33xgAY60bOm/BWbcGstK77LeRdVRBNvfJN+vjE7fuk
 d6uwmtzv1SsIVt1UzSHFZ2gdu8ml+7ruv+GBqCsn27x7NF5nhf50etmXZtl1DgGqbwMF3y
 6a3P+GyncXr9eJPBDz3Qnop6wMLtO6ej2vzDza0PbeTmkqBu0C/29ALvF8/EfXI/BprFtJ
 B/CCOTHd/7QDKGbzmSxmaJiTRCmElbsDCwIyE1z3iH6nTOsvKRRd/EeEYxz6sg==
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.46.2.windows.1
Content-Transfer-Encoding: 7bit
Message-Id: <20250916104843.1953-1-xiangwencheng@lanxincomputing.com>
Received: from localhost.localdomain ([222.128.9.250]) by smtp.feishu.cn with
 ESMTP; Tue, 16 Sep 2025 18:48:59 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Subject: [PATCH] target/riscv/kvm: Sync vCPU mp_state for migration
Date: Tue, 16 Sep 2025 18:48:42 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268c9409c+113086+nongnu.org+xiangwencheng@lanxincomputing.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, <zhiwei_liu@linux.alibaba.com>, 
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, 
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>, 
 "BillXiang" <xiangwencheng@lanxincomputing.com>
Received-SPF: pass client-ip=118.26.132.31;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=sg-1-31.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix secondary vCPUs(id > 0) stall after migration.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 target/riscv/cpu.h           |  3 +++
 target/riscv/kvm/kvm-cpu.c   | 34 ++++++++++++++++++++++++++--------
 target/riscv/kvm/kvm_riscv.h |  3 ++-
 target/riscv/machine.c       | 30 ++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..4290229c56 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -20,6 +20,7 @@
 #ifndef RISCV_CPU_H
 #define RISCV_CPU_H
 
+#include <linux/kvm.h>
 #include "hw/core/cpu.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
@@ -546,6 +547,8 @@ struct ArchCPU {
     RISCVCPUConfig cfg;
     RISCVSATPModes satp_modes;
 
+    struct kvm_mp_state mp_state;
+
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5c19062c19..f0a97293f9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1348,17 +1348,16 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
         return ret;
     }
 
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    ret = kvm_riscv_sync_mpstate_to_qemu(cpu);
+
     return ret;
 }
 
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu)
 {
     if (cap_has_mp_state) {
-        struct kvm_mp_state mp_state = {
-            .mp_state = state
-        };
-
-        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &cpu->mp_state);
         if (ret) {
             fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
                     __func__, ret, strerror(-ret));
@@ -1369,6 +1368,17 @@ int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
     return 0;
 }
 
+int kvm_riscv_sync_mpstate_to_qemu(RISCVCPU *cpu)
+{
+    if (cap_has_mp_state) {
+        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &cpu->mp_state);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     int ret = 0;
@@ -1396,13 +1406,21 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
     if (KVM_PUT_RESET_STATE == level) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         if (cs->cpu_index == 0) {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
+            cpu->mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
         } else {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
+            cpu->mp_state.mp_state = KVM_MP_STATE_STOPPED;
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
         }
         if (ret) {
             return ret;
         }
+    } else if (KVM_PUT_FULL_STATE == level) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        ret = kvm_riscv_sync_mpstate_to_kvm(cpu);
+        if (ret) {
+            return ret;
+        }
     }
 
     return ret;
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index b2bcd1041f..770f58bf0a 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -28,7 +28,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
-int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu);
+int kvm_riscv_sync_mpstate_to_qemu(RISCVCPU *cpu);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1600ec44f0..178ae6a3a0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -251,6 +251,28 @@ static const VMStateDescription vmstate_debug = {
     }
 };
 
+static int get_mp_state(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field)
+{
+    RISCVCPU *cpu = opaque;
+    cpu->mp_state.mp_state = qemu_get_be32(f);
+    return 0;
+}
+
+static int put_mp_state(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, JSONWriter *vmdesc)
+{
+    RISCVCPU *cpu = opaque;
+    qemu_put_be32(f, cpu->mp_state.mp_state);
+    return 0;
+}
+
+static const VMStateInfo vmstate_mp_state = {
+    .name = "mp_state",
+    .get = get_mp_state,
+    .put = put_mp_state,
+};
+
 static int riscv_cpu_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
@@ -457,6 +479,14 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.sscratch, RISCVCPU),
         VMSTATE_UINTTL(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.stimecmp, RISCVCPU),
+        {
+            .name = "mp_state",
+            .version_id = 0,
+            .size = sizeof(bool),
+            .info = &vmstate_mp_state,
+            .flags = VMS_SINGLE,
+            .offset = 0,
+        },
 
         VMSTATE_END_OF_LIST()
     },
-- 
2.46.2.windows.1

