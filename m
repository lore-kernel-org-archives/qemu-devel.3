Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFN-0005J2-DY; Tue, 30 Sep 2025 21:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFH-0005IL-9z
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEq-00082a-D1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1513239f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280551; x=1759885351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaYYeBmAaJYjpweUU9UC+NfBTdgZDvDM0RYomvcmv9U=;
 b=I1LXizBYH49rCwF+PGkprUlMHRkBfSopZ3HgXUU2fswlYI7W0x8cYA8zH1K2yAOeqG
 35xmNUEUS5wBwALARleTq0m71w4lSszGd93NWmVp7fhrX0T0ZPHcUaqxOwJMOek4T6We
 blJexb3tSiwtNQB7Gl9m0X66Fu4JoY8ZGReD3QfkEtZP/9JMKxdGwfD86klWQzt8oQ7x
 Blv/ysJbX7qcr9WqMK86RY0TSv1UOJti6UjF2wOdFERokCPivXkaar2B+6jRE4jfw0Wk
 Die6ugtFZd5f+1wKvsO2nJDV91b6ytCP7tqxLhOUvnw+Oc4Y4vQmk4eQIPQbKKVb5j6K
 hd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280551; x=1759885351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaYYeBmAaJYjpweUU9UC+NfBTdgZDvDM0RYomvcmv9U=;
 b=dI5rSGOg4p983vBvahfLanSI3FboPP7KKGXgqNlo452ZpuMSglqOGxaEUjtObLBDgZ
 YQHTpn4KWp6Fa1BeU/vuIaP8HcTDTI2TWPP6XVYQGrzMtREBcQ5iJVLndPgBGHmL6rjd
 H9KYXK2q+SuSyccRRlGkddPSww9OCmJ2FiQL0s0pPo2ZJqytMTAx1jl5IEbKHccK+lgB
 ul5PHsXVhdoVYHY9Ku0ZtURal2/DkilXgzKgzFGXr0bahbGT33SA2iHvyoTsOIGi7ZK2
 IB4fMoqF/3uOkcAYfBpQf790Dp1EVzf+m/IjGwXLpV7KwTI4W7uthe9KRmDX77ZTRvyg
 aOuA==
X-Gm-Message-State: AOJu0Yzs/0gg8LGK6WWsVGwgyocszXLKJB2toMdKsjT2J6xp/azB7TtB
 Xl+PtKqxDs4XSY9ByScfoaYA9BFO/Chd+MNfTg/2S8R1OKRduj0wuFBd4SmefWcBNdZe2kRWsMD
 +E7EFcOOsEg==
X-Gm-Gg: ASbGncuhSMes76B6MkJTvAZiPbRySs/+pLEfmS1J1zsNZOoWqUgzQC2ia3D4fW8oCwB
 1ZDFgDfZJLoL+2wnc2C+6dSdBqRiXehzww5rRGSBozBNzlowi0gT8KHKVOJiS4wAi68uPCXyJHE
 xB00TCtL+/1fx4dfllTtXcJjr5BxW+4lm6zPDhYaxd4gLmynrlEuWo40KfXVQ/XLcxkn/WfENLI
 Wx/hj6n+yubpr4T+1EuaSxnTZnAM0crq/VAff28YVHtHCB1nl3C4t3V0Nj0f4UfOFWvz8A9Zosg
 ynCHyssCP9qKNRCgoQ9tKwDoWlaSBvPmDDl2p87Rp1LCHpvUb3WdsAvaHAgc/xebrRLDR6kAKWm
 clVRBwr66Z9dzXoLubqE+i1Hn4wmPDB2Y2xnMs4wffaf5Z6ADTCKtwqov3UuzOISgOPqpTycgLf
 7k7dELeBC7pxF4f7PYbbw7GY9Kf7W9xdw2p81iiy8wbi0F+JC/8cAGcQ==
X-Google-Smtp-Source: AGHT+IHPw2sry/eKwPyGgmP14A0iWV/z5t3/11TVgLFSjP3KX2o+Ub2UflZ+bY56rCT737vPKwa/sw==
X-Received: by 2002:a05:6000:3105:b0:40d:86c9:5c9e with SMTP id
 ffacd0b85a97d-42557805113mr1324053f8f.40.1759280550658; 
 Tue, 30 Sep 2025 18:02:30 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:30 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 08/24] arm/virt,
 gicv3: Guard CPU interface access for admin disabled vCPUs
Date: Wed,  1 Oct 2025 01:01:11 +0000
Message-Id: <20251001010127.3092631-9-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

Per Arm GIC Architecture Specification (IHI0069H_b, §11.1), the CPU interface
and its Processing Element (PE) share a power domain. If the PE is powered down
or administratively disabled, the CPU interface must be quiescent or off, and
any access is architecturally UNPREDICTABLE. Without explicit checks, QEMU may
issue GICC register operations for vCPUs that are offline, removed, or
otherwise unavailable—risking inconsistent state or undefined behavior in both
TCG and KVM accelerators.

To address this, introduce a per-vCPU gicc_accessible flag that reflects the
administrative enablement of the corresponding QOM vCPU in accordance with the
policy. This is permissible when the GICC (GIC CPU Interface) is online-capable,
meaning vCPUs can be brought online in the guest kernel after boot. The flag is
set during GIC realization and used to skip VGIC register reads/writes, SGI
generation, and CPU interface updates when the GICC is not accessible. This
prevents unsafe operations and ensures compliance when managing administratively
disabled but present vCPUs.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/core/qdev.c                     | 26 +++++++++++++++++
 hw/intc/arm_gicv3_common.c         | 23 +++++++++++++++
 hw/intc/arm_gicv3_cpuif.c          |  8 +++++
 hw/intc/arm_gicv3_cpuif_common.c   | 47 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 18 ++++++++++++
 include/hw/intc/arm_gicv3_common.h | 24 +++++++++++++++
 include/hw/qdev-core.h             | 24 +++++++++++++++
 7 files changed, 170 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5816abae39..8e9a4da6b5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -326,6 +326,32 @@ bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp)
                                    errp);
 }
 
+int qdev_get_admin_power_state(DeviceState *dev)
+{
+    DeviceClass *dc;
+
+    if (!dev) {
+        return DEVICE_ADMIN_POWER_STATE_REMOVED;
+    }
+
+    dc = DEVICE_GET_CLASS(dev);
+    if (dc->admin_power_state_supported) {
+        return object_property_get_enum(OBJECT(dev), "admin_power_state",
+                                        "DeviceAdminPowerState", NULL);
+    }
+
+    return DEVICE_ADMIN_POWER_STATE_ENABLED;
+}
+
+bool qdev_check_enabled(DeviceState *dev)
+{
+   /*
+    * if device supports power state transitions, check if it is not in
+    * 'disabled' state.
+    */
+    return qdev_get_admin_power_state(dev) == DEVICE_ADMIN_POWER_STATE_ENABLED;
+}
+
 bool qdev_machine_modified(void)
 {
     return qdev_hot_added || qdev_hot_removed;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f6a9f1c68b..f4428ad165 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -439,6 +439,29 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
         CPUState *cpu = machine_get_possible_cpu(i);
         uint64_t cpu_affid;
 
+        /*
+         * Ref: Arm Generic Interrupt Controller Architecture Specification
+         * (GIC Architecture version 3 and version 4), IHI0069H_b,
+         * Section 11.1: Power Management
+         * https://developer.arm.com/documentation/ihi0069
+         *
+         * According to this specification, the CPU interface and the
+         * Processing Element (PE) must reside in the same power domain.
+         * Therefore, when a CPU/PE is powered off, its corresponding CPU
+         * interface must also be in the off state or in a quiescent state—
+         * depending on the state of the associated Redistributor.
+         *
+         * The Redistributor may reside in a separate power domain and may
+         * remain powered even when the associated PE is turned off.
+         *
+         * Accessing the GIC CPU interface while the PE is powered down can
+         * lead to UNPREDICTABLE behavior.
+         *
+         * Accordingly, the QOM object `GICv3CPUState` should be marked as
+         * either accessible or inaccessible based on the power state of the
+         * associated `CPUState` vCPU.
+         */
+        s->cpu[i].gicc_accessible = qdev_check_enabled(DEVICE(cpu));
         s->cpu[i].cpu = cpu;
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index a7904237ac..6430b2c649 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1052,6 +1052,10 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    if (!gicv3_gicc_accessible(OBJECT(cs->gic), CPU(cpu)->cpu_index)) {
+        return;
+    }
+
     g_assert(bql_locked());
 
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
@@ -2036,6 +2040,10 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
     for (i = 0; i < s->num_cpu; i++) {
         GICv3CPUState *ocs = &s->cpu[i];
 
+        if (!gicv3_gicc_accessible(OBJECT(s), i)) {
+            continue;
+        }
+
         if (irm) {
             /* IRM == 1 : route to all CPUs except self */
             if (cs == ocs) {
diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index f9a9b2d8a3..8f9a5b6fa2 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -12,6 +12,9 @@
 #include "qemu/osdep.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
+#include "qemu/log.h"
+#include "monitor/monitor.h"
+#include "qapi/visitor.h"
 
 void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 {
@@ -21,6 +24,41 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
     env->gicv3state = (void *)s;
 };
 
+static void
+gicv3_get_gicc_accessibility(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    GICv3CPUState *cs = (GICv3CPUState *)opaque;
+    bool value = cs->gicc_accessible;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void
+gicv3_set_gicc_accessibility(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    GICv3CPUState *gcs = opaque;
+    CPUState *cs = gcs->cpu;
+    bool value;
+
+    visit_type_bool(v, name, &value, errp);
+
+    /* Block external attempts to set */
+    if (monitor_cur_is_qmp()) {
+        error_setg(errp, "Property 'gicc-accessible' is read-only externally");
+        return;
+    }
+
+    if (gcs->gicc_accessible != value) {
+        gcs->gicc_accessible = value;
+
+        qemu_log_mask(LOG_UNIMP,
+                      "GICC accessibility changed: vCPU %d = %s\n",
+                      cs->cpu_index, value ? "accessible" : "inaccessible");
+    }
+}
+
 void gicv3_init_cpuif(GICv3State *s)
 {
     ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(s);
@@ -28,6 +66,15 @@ void gicv3_init_cpuif(GICv3State *s)
 
     /* define and register `system registers` with the vCPU  */
     for (i = 0; i < s->num_cpu; i++) {
+        g_autofree char *propname = g_strdup_printf("gicc-accessible[%d]", i);
+        object_property_add(OBJECT(s), propname, "bool",
+                            gicv3_get_gicc_accessibility,
+                            gicv3_set_gicc_accessibility,
+                            NULL, &s->cpu[i]);
+
+        object_property_set_description(OBJECT(s), propname,
+            "Per-vCPU GICC interface accessibility (internal set only)");
+
         agcc->init_cpu_reginfo(s->cpu[i].cpu);
     }
 }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 4ca889da45..e97578f59a 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -457,6 +457,16 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * We must ensure that we do not attempt to access or update KVM GICC
+         * registers if their corresponding QOM `GICv3CPUState` is marked as
+         * 'inaccessible', because their corresponding QOM vCPU objects
+         * are in administratively 'disabled' state.
+         */
+        if (!gicv3_gicc_accessible(OBJECT(s), ncpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
@@ -615,6 +625,14 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * don't attempt to access KVM VGIC for the disabled vCPUs where
+         * GICv3CPUState is inaccessible.
+         */
+        if (!gicv3_gicc_accessible(OBJECT(s), ncpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], false);
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 3720728227..bbf899184e 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 /*
  * Maximum number of possible interrupts, determined by the GIC architecture.
@@ -164,6 +165,7 @@ struct GICv3CPUState {
     uint64_t icc_apr[3][4];
     uint64_t icc_igrpen[3];
     uint64_t icc_ctlr_el3;
+    bool gicc_accessible;
 
     /* Virtualization control interface */
     uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
@@ -329,4 +331,26 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
  */
 const char *gicv3_class_name(void);
 
+/**
+ * gicv3_gicc_accessible:
+ * @obj: QOM object implementing the GICv3 device
+ * @cpu: Index of the vCPU whose GICC accessibility is being queried
+ *
+ * Returns: true if the GICC interface for vCPU @cpu is accessible.
+ * Uses QOM property lookup for "gicc-accessible[%d]".
+ */
+static inline bool gicv3_gicc_accessible(Object *obj, int cpu)
+{
+    g_autofree gchar *propname = g_strdup_printf("gicc-accessible[%d]", cpu);
+    Error *local_err = NULL;
+    bool value;
+
+    value = object_property_get_bool(obj, propname, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return false;
+    }
+
+    return value;
+}
 #endif
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2c22b32a3f..b1d3fa4a25 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -589,6 +589,30 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
  */
 bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp);
 
+/**
+ * qdev_check_enabled - Check if a device is administratively enabled
+ * @dev:  The device to check
+ *
+ * This function returns whether the device is currently in administrative
+ * ENABLED state. It does not reflect runtime operational power state, but
+ * rather the host policy on whether the guest may interact with the device.
+ *
+ * Returns true if the device is administratively enabled; false otherwise.
+ */
+bool qdev_check_enabled(DeviceState *dev);
+
+/**
+ * qdev_get_admin_power_state - Query administrative power state of a device
+ * @dev:  The device whose state is being queried
+ *
+ * Returns the current administrative power state (ENABLED or DISABLED),
+ * as stored in the device's internal admin state field. This reflects
+ * host-level policy—not the operational runtime state seen by the guest.
+ *
+ * Returns an integer from the DeviceAdminPowerState enum.
+ */
+int qdev_get_admin_power_state(DeviceState *dev);
+
 /**
  * qdev_unrealize: Unrealize a device
  * @dev: device to unrealize
-- 
2.34.1


