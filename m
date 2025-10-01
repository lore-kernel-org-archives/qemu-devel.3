Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9777ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFD-0005HS-FB; Tue, 30 Sep 2025 21:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lF6-0005Ga-7x
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEm-0007zo-Tf
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso45686645e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280544; x=1759885344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQKJ1SD5xckgEaV2WySv/XUYqgNyxKKJdcvcoJuQPMY=;
 b=YkmKU4OA7em/rLP/3WZuO3G56huL9f7Nyv8YS5T/R6MOpeyK5Q/GQB8Y3kZ8zJH5c7
 TP/WIVtpM/mrWSID34C7EwGsW7QzsesRs45kR4bD5t3YZVzVnGdyl5Y3p/0k7zI+nCjk
 PETLo2jc9tRp+pJM29vXztAfgC2RtqBfBTKKzQFKuDufVWuLXp7np+xvQNZ8sIey6pal
 FOlV3wDtdJLvknolI7kQKHu45gZAtMmsAt+Xd1FRScdWrRSGvcqDyOfQUoM4U6HS5pbj
 t626a9Ms3Zy+rjB632R8DeMJMtcpEcCZhkP2IZlO6YM3JAIXEaP0j1tDetGnLrWuJKvg
 Mrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280544; x=1759885344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQKJ1SD5xckgEaV2WySv/XUYqgNyxKKJdcvcoJuQPMY=;
 b=LPao+vmc490UBk8IfX/f6T7qhrfhBnT1D7GBovqlSvcPSq4EN7DiETVRbVuy13Lym5
 W9IhW+5SY5tlbbXHW81zcKuV9eaO6q8nfTd3kwMDH0gCzcM9p1qd1/2nAyqCuSUnbvJ+
 E2owH0sZrPo+KnwfR3TeAElPsGnH9O48DPG2GcjvcLLnO7HyneygZRqxKCj0ZxLh9lqv
 3YFpFAyz6mMadDf4Dht6NEAaCzilU6EicNs3bhpaMAImTDWoGOeH3Vgjgczsb3Pc4Jch
 DzAmcJAdzcLzCa2YXLpAta9vhbYwGKRwWkVSAHk0Ac3FREVN2F907Z7UYVOknSXu8i5/
 NA1A==
X-Gm-Message-State: AOJu0Yxu+H0xu+AipMRP9WeU+CdJHoUbxPV6BT45p6KBJqwgkd1Op1yg
 gB5vLseaSbU0aWcfbJxLraoapzMuIeCAmCsKJj2ZrX+qO5Qlv042adkVKoy8UkW22y1QPU+B09a
 1VYCKjbc20A==
X-Gm-Gg: ASbGncvd9PxF+Kr1swvxWjPWkSaYAzmuyY1e/UQU6pJBDRgr84Gp/VMJL7yYNXQ2Abb
 CfK+ciNd+YdQIKa2YZogtk3ZyYrcbdiZH5CCxmgCRw1P0JqynT++Aen4TI5IaIXLg/E/xtEW4xv
 LTdXBWk3A9A6OdPg/IShAS9pIcCbBbJg2lF9KWNuCTZ9HXmN5c6HkTfUzb5l443kboPiei8HaEy
 Wnf9eeIBsZCsMZJbsgbkF6fItyHj4j31Ils+dwXCrCfTbVitIij9v6SCVQV3Argna2rCHHPT3tT
 PfKDsZ1xjfmMSKaF5hC1tatS7/iT1WRYwBqDUlBh87nbeZLaf3CMJC2oeIf/8yRvzDGSzQvMLL/
 c1N4vmHBxzaIMugDiTrCBVSbQYa8ZmuH7/01AYz/WWaKKdP43Wg6beSo93xwmVuKL8B1bm1Rc9Q
 kq1+lwSsv8WPEDFPH2MYLKTNj15ng5hNnj4nHURyneHrA=
X-Google-Smtp-Source: AGHT+IFf7XYAckpJw8j1JA8eb8qMz4/K94d8qJkSnt184ST0tllV9oC3FK71HQ5ngVT+BL3XoDVweA==
X-Received: by 2002:a05:600c:8b65:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-46e6127cccfmr13217285e9.10.1759280543774; 
 Tue, 30 Sep 2025 18:02:23 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:23 -0700 (PDT)
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
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com,
 Keqian Zhu <zhuqian1@huawei.com>
Subject: [PATCH RFC V6 05/24] arm/virt,
 kvm: Pre-create KVM vCPUs for 'disabled' QOM vCPUs at machine init
Date: Wed,  1 Oct 2025 01:01:08 +0000
Message-Id: <20251001010127.3092631-6-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x335.google.com
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

ARM CPU architecture does not allow CPUs to be plugged after system has
initialized. This is a constraint. Hence, the Kernel must know all the CPUs
being booted during its initialization. This applies to the Guest Kernel as
well and therefore, the number of KVM vCPU descriptors in the host must be
fixed at VM initialization time.

Also, the GIC must know all the CPUs it is connected to during its
initialization, and this cannot change afterward. This must also be ensured
during the initialization of the VGIC in KVM. This is necessary because:

1. The association between GICR and MPIDR must be fixed at VM initialization
   time. This is represented by the register
   `GICR_TYPER(mp_affinity, proc_num)`.
2. Memory regions associated with GICR, etc., cannot be changed (added,
   deleted, or modified) after the VM has been initialized. This is not an
   ARM architectural constraint but rather invites a difficult and messy
   change in VGIC data structures.

To enable a hot-add–like model while preserving these constraints, the virt
machine may enumerate more CPUs than are enabled at boot using
`-smp disabledcpus=N`. Such CPUs are present but start offline (i.e.,
administratively disabled at init). The topology remains fixed at VM
creation time; only the online/offline status may change later.

Administratively disabled vCPUs are not realized in QOM until first enabled,
avoiding creation of unnecessary vCPU threads at boot. On large systems, this
reduces startup time proportionally to the number of disabled vCPUs. Once a
QOM vCPU is realized and its thread created, subsequent enable/disable actions
do not unrealize it. This behaviour was adopted following review feedback and
differs from earlier RFC versions.

Co-developed-by: Keqian Zhu <zhuqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhuqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 accel/kvm/kvm-all.c    |  2 +-
 hw/arm/virt.c          | 77 ++++++++++++++++++++++++++++++++++++++----
 hw/core/qdev.c         | 17 ++++++++++
 include/hw/qdev-core.h | 19 +++++++++++
 include/system/kvm.h   |  8 +++++
 target/arm/cpu.c       |  2 ++
 target/arm/kvm.c       | 40 +++++++++++++++++++++-
 target/arm/kvm_arm.h   | 11 ++++++
 8 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f8..0e7d9d5c3d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -460,7 +460,7 @@ static void kvm_reset_parked_vcpus(KVMState *s)
  *
  * @returns: 0 when success, errno (<0) when failed.
  */
-static int kvm_create_vcpu(CPUState *cpu)
+int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
     KVMState *s = kvm_state;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4ded19dc69..f4eeeacf6c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2152,6 +2152,49 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
     }
 }
 
+static void
+virt_setup_lazy_vcpu_realization(Object *cpuobj, VirtMachineState *vms)
+{
+    /*
+     * Present & administratively disabled vCPUs:
+     *
+     * These CPUs are marked offline at init via '-smp disabledcpus=N'. We
+     * intentionally do not realize them during the first boot, since it is
+     * not known if or when they will ever be enabled. The decision to enable
+     * such CPUs depends on policy (e.g. guided by SLAs or other deployment
+     * requirements).
+     *
+     * Realizing all disabled vCPUs up front would make boot time proportional
+     * to 'maxcpus', even if policy permits only a small subset to be enabled.
+     * This can lead to unacceptable boot delays in some scenarios.
+     *
+     * Instead, these CPUs remain administratively disabled and unrealized at
+     * boot, to be instantiated and brought online only if policy later allows
+     * it.
+     */
+
+    /* set this vCPU to be administratively 'disabled' in QOM */
+    qdev_disable(DEVICE(cpuobj), NULL, &error_fatal);
+
+    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+        object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
+                                NULL);
+    }
+
+    /*
+     * [!] Constraint: The ARM CPU architecture does not permit new CPUs
+     * to be added after system initialization.
+     *
+     * Workaround: Pre-create KVM vCPUs even for those that are not yet
+     * online i.e. powered-off, keeping them `parked` and in an
+     * `unrealized (at-least during boot time)` state within QEMU until
+     * they are powered-on and made online.
+     */
+    if (kvm_enabled()) {
+        kvm_arm_create_host_vcpu(ARM_CPU(cpuobj));
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -2319,10 +2362,6 @@ static void machvirt_init(MachineState *machine)
         Object *cpuobj;
         CPUState *cs;
 
-        if (n >= smp_cpus) {
-            break;
-        }
-
         cpuobj = object_new(possible_cpus->cpus[n].type);
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);
@@ -2427,8 +2466,34 @@ static void machvirt_init(MachineState *machine)
             }
         }
 
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
+        /* start secondary vCPUs in a powered-down state */
+        if(n && mc->has_online_capable_cpus) {
+            object_property_set_bool(cpuobj, "start-powered-off", true, NULL);
+        }
+
+        if (n < smp_cpus) {
+            /* 'Present' & 'Enabled' vCPUs */
+            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+            object_unref(cpuobj);
+        } else {
+            /* 'Present' & 'Disabled' vCPUs */
+            virt_setup_lazy_vcpu_realization(cpuobj, vms);
+        }
+
+        /*
+         * All possible vCPUs should have QOM vCPU Object pointer & arch-id.
+         * 'cpus_queue' (accessed via qemu_get_cpu()) contains only realized and
+         * enabled vCPUs. Hence, we must now populate the 'possible_cpus' list.
+         */
+        if (kvm_enabled()) {
+            /*
+             * Override the default architecture ID with the one retrieved
+             * from KVM, as they currently differ.
+             */
+            machine->possible_cpus->cpus[n].arch_id =
+                arm_cpu_mp_affinity(ARM_CPU(cs));
+        }
+        machine->possible_cpus->cpus[n].cpu = cs;
     }
 
     /* Now we've created the CPUs we can see if they have the hypvirt timer */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8502d6216f..5816abae39 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -309,6 +309,23 @@ void qdev_assert_realized_properly(void)
                                    qdev_assert_realized_properly_cb, NULL);
 }
 
+bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp)
+{
+    g_assert(dev);
+
+    if (bus) {
+        error_setg(errp, "Device %s 'disable' operation not supported",
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
+    /* devices like cpu don't have bus */
+    g_assert(!DEVICE_GET_CLASS(dev)->bus_type);
+
+    return object_property_set_str(OBJECT(dev), "admin_power_state", "disabled",
+                                   errp);
+}
+
 bool qdev_machine_modified(void)
 {
     return qdev_hot_added || qdev_hot_removed;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 3bc212ab3a..2c22b32a3f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -570,6 +570,25 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
  */
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 
+/**
+ * qdev_disable - Initiate administrative disablement and power-off of device
+ * @dev:   The device to be administratively powered off
+ * @bus:   The bus on which the device resides (may be NULL for CPUs)
+ * @errp:  Pointer to a location where an error can be reported
+ *
+ * This function initiates an administrative transition of the device into a
+ * DISABLED state. This may trigger a graceful shutdown process depending on
+ * platform capabilities. For ACPI platforms, this typically involves notifying
+ * the guest via events such as Notify(..., 0x03) and executing _EJx.
+ *
+ * Once completed, the device's operational power is turned off and it is
+ * marked as administratively DISABLED. Further guest usage is blocked until
+ * re-enabled by host-side policy.
+ *
+ * Returns true on success; false if an error occurs, with @errp populated.
+ */
+bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp);
+
 /**
  * qdev_unrealize: Unrealize a device
  * @dev: device to unrealize
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 3c7d314736..4896a3c9c5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -317,6 +317,14 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+int kvm_create_vcpu(CPUState *cpu);
+
 /**
  * kvm_park_vcpu - Park QEMU KVM vCPU context
  * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e0d5b2ed8..a5906d1672 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1500,6 +1500,8 @@ static void arm_cpu_initfn(Object *obj)
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
+
+    CPU(obj)->thread_id = 0;
 }
 
 /*
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6672344855..1962eb29b2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -991,6 +991,38 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     write_list_to_cpustate(cpu);
 }
 
+void kvm_arm_create_host_vcpu(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    unsigned long vcpu_id = cs->cpu_index;
+    int ret;
+
+    ret = kvm_create_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to create host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * Initialize the vCPU in the host. This will reset the sys regs
+     * for this vCPU and related registers like MPIDR_EL1 etc. also
+     * get programmed during this call to host. These are referenced
+     * later while setting device attributes of the GICR during GICv3
+     * reset.
+     */
+    ret = kvm_arch_init_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to initialize host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * park the created vCPU. shall be used during kvm_get_vcpu() when
+     * threads are created during realization of ARM vCPUs.
+     */
+    kvm_park_vcpu(cs);
+}
+
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
@@ -1876,7 +1908,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+    /*
+     * Install VM change handler only when vCPU thread has been spawned
+     * i.e. vCPU is being realized
+     */
+    if (cs->thread_id) {
+        qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
+    }
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6a9b6374a6..ec9dc95ee8 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -98,6 +98,17 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu);
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
 struct kvm_vcpu_init;
+
+/**
+ * kvm_arm_create_host_vcpu:
+ * @cpu: ARMCPU
+ *
+ * Called to pre-create possible KVM vCPU within the host during the
+ * `virt_machine` initialization phase. This pre-created vCPU will be parked and
+ * will be reused when ARM QOM vCPU is actually hotplugged.
+ */
+void kvm_arm_create_host_vcpu(ARMCPU *cpu);
+
 /**
  * kvm_arm_create_scratch_host_vcpu:
  * @fdarray: filled in with kvmfd, vmfd, cpufd file descriptors in that order
-- 
2.34.1


