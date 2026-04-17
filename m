Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1424EF4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgtK-00020b-OX; Fri, 17 Apr 2026 06:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgtE-0001Nu-9K
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:38 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgtC-0001bh-78
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:35 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2868620B7129;
 Fri, 17 Apr 2026 03:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2868620B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423443;
 bh=n7/23i78ePWRFCNhXvpu2aDZEvpadavS9yPcaXyN5rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jh8ThyFs/ODcR1xk4+8KIBEoaMRe8iwL0cLaJRiqYN3rE45XHIFYso3fkeTIGgf8o
 AHDZKir0CeUJdMf4VWKa7sA+W0qYNWWdtnwCyUo0TB5lElLHVJtiy9JOjaeB//YVDq
 XjvH394nRuh0skp4phxzIjGQx4zoYp4QfY9tnWBs=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
Date: Fri, 17 Apr 2026 12:56:00 +0200
Message-Id: <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This change implements loading and storing the hyperv lapic state as
part of the load/store routines for a vcpu.

The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
userland.

An opaque blob is added to the APICCommonState, guarded behind a flag,
hence it will be covered by a migration, as we declare VMSTATE_BUFFER
for the hv_lapic_state field.

In the future we might want to introduce a dedicated class for MSHV, that
would require us to wire up an IOAPIC delivery path to QEMU's userland
emulation.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hw/intc/apic_common.c           |  3 ++
 include/hw/i386/apic_internal.h |  5 +++
 target/i386/mshv/mshv-cpu.c     | 61 +++++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bf4abc21d7..a7df870f1a 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -380,6 +380,9 @@ static const VMStateDescription vmstate_apic_common = {
         VMSTATE_INT64(next_time, APICCommonState),
         VMSTATE_INT64(timer_expiry,
                       APICCommonState), /* open-coded timer state */
+#ifdef CONFIG_MSHV
+        VMSTATE_BUFFER(hv_lapic_state, APICCommonState),
+#endif
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 0cb06bbc76..6d4ccca4e8 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -23,6 +23,7 @@
 
 #include "cpu.h"
 #include "hw/i386/apic.h"
+#include "hw/hyperv/hvgdk_mini.h"
 #include "system/memory.h"
 #include "qemu/timer.h"
 #include "target/i386/cpu-qom.h"
@@ -188,6 +189,10 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     uint32_t extended_log_dest;
+
+#ifdef CONFIG_MSHV
+    uint8_t hv_lapic_state[sizeof(struct hv_local_interrupt_controller_state)];
+#endif
 };
 
 typedef struct VAPICState {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 12343acb01..22c962c5ac 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -112,6 +112,25 @@ static int get_generic_regs(CPUState *cpu,
                             struct hv_register_assoc *assocs,
                             size_t n_regs);
 
+static int get_lapic(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+
+    ret = mshv_get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        error_report("failed to get lapic state");
+        return -1;
+    }
+
+    memcpy(&apic->hv_lapic_state, &lapic_state, sizeof(lapic_state));
+
+    return 0;
+}
+
 static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
 {
     union hv_register_value value;
@@ -559,6 +578,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -926,9 +950,11 @@ static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
 
 static int init_lint(const CPUState *cpu)
 {
-    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
     uint32_t *lvt_lint0, *lvt_lint1;
     int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
     ret = mshv_get_lapic(cpu_fd, &lapic_state);
@@ -944,7 +970,32 @@ static int init_lint(const CPUState *cpu)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return mshv_set_lapic(cpu_fd, &lapic_state);
+    ret = mshv_set_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return -1;
+    }
+
+    memcpy(apic->hv_lapic_state, &lapic_state, sizeof(lapic_state));
+
+    return 0;
+}
+
+static int set_lapic(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    APICCommonState *apic = APIC_COMMON(x86cpu->apic_state);
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    memcpy(&lapic_state, &apic->hv_lapic_state, sizeof(lapic_state));
+    ret = mshv_set_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        error_report("failed to set lapic");
+        return -1;
+    }
+
+    return 0;
 }
 
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
@@ -971,6 +1022,12 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    /* INVARIANT: special regs (APIC_BASE) must be restored before LAPIC */
+    ret = set_lapic(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.34.1


