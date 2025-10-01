Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC84CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGQ-0005iv-MG; Tue, 30 Sep 2025 21:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lG0-0005VB-PY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFD-0008AE-5H
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-414f48bd5a7so4359823f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280573; x=1759885373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riMmSmFMW9DU05Ls6u53RzcUxCDMOS/nOG/ia4hBxSM=;
 b=fSdVlBkHwuIfLyB9mzyq8Npdm5k7CFChluDY5nwfo46RF2fJxMnzQdDjuwVqcTb0J5
 UexUe0gB7H9odjvd+CnpFOFZAMXJUgRK4h1rvNfqi6CblRNnXX5CTVjaZZKZvxntewkB
 0VldUVPYndC+xeEUw0z/Edl8F5r9GwmHNfiZLFNQfeBS02vPfCIu++Q9tY3WYbZmXvXj
 63Y0DISlZA67EuyPCirY4NBmn/Xt+eBM13Vk3ARMzkGay6+HJyiAg89eVX8awFtt8VmN
 sOvkUFv9eDgT1vG8b1EEbdmC4Da++HovGMA7drQX5oho7+uyajAWPNAM9I+vPwdxoGi4
 7ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280573; x=1759885373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riMmSmFMW9DU05Ls6u53RzcUxCDMOS/nOG/ia4hBxSM=;
 b=gAz05tAlawOwSis4lL8Xc26oavwIZQBqZtkpCL7PF/B8RrJTaCeshriwF4FBMBs7NR
 M2qydFewSVeXzF5vNdiCcgwTfdaoG4gECFdeTbEvGFgzL++nXK9wajDwAMEe7+dEJhND
 IWY4pTzPm6bZohFaJw82zKR2Ml1HlcznFzwpqr3tSRl8he1V/cUCA8AsXoLQKOE30nXC
 WAvKD6PZliPsW6XcGQGmoHbkXc2k30JecPIBWQ4+kiJ/wvVxWE2SXUyupoN7f8bWZQhw
 URM74e2xzkZ8Kozt0bzFekWwnaNFSFibZBUCy6cj9YjTgdZeKli0ralMtFxSyjQkjF+D
 3/1A==
X-Gm-Message-State: AOJu0YzA1IJ+zdoyR68mGzXaXyd92UGJjO36efBVv4DdfV1INHWh9mi8
 JDlW+xV9ZdpZRvyehXSB8ni5lJ39GRXwyOLqFR4H2kpfIpqAksFy22HmukkLzAxHp9imluI7g69
 d4hJO0iya2A==
X-Gm-Gg: ASbGncuuTm+CLVHVM905WvpPo3S0g6MXHEGkixtlinoiGrPqz+lswH20grYgBaVgb81
 QUdx5BOPyLWHdWIKRZ2MSVeOQNzl4lKWPoqsYZmRy1I5FZ8Tpp2eOZC82zfW7RDUuFZ6nc/AQkX
 DclyMkjU1tFU9Uiwu3h99NeV2/SORp/HKzYue8U0O3DbEwQITJYqQEFBXYQROjGAqNaUlWFLWVX
 uXhz1+4vFlrP2/UJYZ6IG+3VwJoMVxKjqbx3GGNjLFdJsvvbi/MslI2DPSCaxFYxmIOEK2DHXOb
 AMc3IPPU3zYFCPe8Agewj48bS8kx18qif03mCeywbX6RakysnuPcww2DXXKeZpvrRVXspm1aNGW
 38BbVGoWgBWRjwS/KDd9FT9/9PfZDWXEMVbbSZKDhtUkUbC2dSCWerxWqySpacbWj1I/xxgrXR6
 2alCBn8pi9HjuWmbRnF6e0Z99d43vguOtPjwVA2JVCZ+k=
X-Google-Smtp-Source: AGHT+IEeV6YRYEjIM1tPPHAaCG+k1453yOkfUWb6kpDdBDoPwpEYmXNOWuISxfXZE6pxJiI/dnNzaw==
X-Received: by 2002:a05:6000:18a3:b0:3ec:dfe5:17d0 with SMTP id
 ffacd0b85a97d-425577edd2dmr869712f8f.9.1759280572888; 
 Tue, 30 Sep 2025 18:02:52 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:52 -0700 (PDT)
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
Subject: [PATCH RFC V6 17/24] hw/arm/virt,
 acpi/ged: Add PowerStateHandler hooks for runtime CPU state changes
Date: Wed,  1 Oct 2025 01:01:20 +0000
Message-Id: <20251001010127.3092631-18-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Administrative power state property has been recently introduced as part of this
patch-set, and QEMU currently lacks a way for platforms to react to such control
(e.g. 'device_set ... admin-state=disable'). These host-driven changes must
drive corresponding operational transitions and involve OSPM where appropriate.

Summary of Handling:
===================

Since vCPUs are always enumerated as present, administrative enable must ensure
they also become operationally usable. This requires realizing the vCPU (if
enabled for the first time) or unparking it otherwise, re-registering it with
the VMState handler, adding it back to the active vCPU list, and kicking its
sleeping thread into KVM so it can transition to the guest runnable state once
the kernel issues CPU_ON. The GICC interface must also be marked accessible, and
OSPM must be notified through a Device Check event so that _EVT/_STA evaluation
can identify the CPU, register it with the Linux device model, enable it in the
guest kernel, and make it available to the scheduler.

When a CPU is administratively disabled, the virt machine invokes its
PowerStateHandler callbacks to request powering off the vCPU. As a consequence,
GED raises an Eject Request event so OSPM can invoke _EJ0 to offload tasks and
shut down state before removal. The vCPU is then quiesced, unregistered from
VMState, removed from the active vCPU list, its sleeping vCPU thread is kicked
from KVM, re-blocked inside QEMU, and the vCPU is parked in userspace. This
helps reduce locking contention inside the kernel.

The callbacks introduced as part of this patch-set handle the above flows and
avoid forceful removal without kernel coordination, keep firmware and GIC access
in sync, and integrate with existing ACPI GED-based signaling.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpu-common.c                       |   4 +-
 hw/arm/virt.c                      | 233 ++++++++++++++++++++++++++++-
 include/hw/arm/virt.h              |   1 +
 include/hw/core/cpu.h              |   2 +
 include/hw/intc/arm_gicv3_common.h |  30 ++++
 system/cpus.c                      |   4 +-
 target/arm/cpu.c                   |   1 +
 7 files changed, 271 insertions(+), 4 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index ef5757d23b..7eced58434 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -103,7 +103,9 @@ void cpu_list_remove(CPUState *cpu)
     }
 
     QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
-    cpu->cpu_index = UNASSIGNED_CPU_INDEX;
+    if (!cpu->preserve_assigned_cpu_index) {
+        cpu->cpu_index = UNASSIGNED_CPU_INDEX;
+    }
     cpu_list_generation_id++;
 }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8d498708ab..9a41a0682b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -45,6 +45,7 @@
 #include "system/device_tree.h"
 #include "system/numa.h"
 #include "system/runstate.h"
+#include "system/reset.h"
 #include "system/tpm.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
@@ -91,6 +92,8 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/powerstate.h"
+#include "arm-powerctl.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -1400,7 +1403,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     char *nodename;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -1821,6 +1824,179 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
+static void virt_park_cpu_in_userspace(CPUState *cs)
+{
+    /* we don't want to migrate 'disabled' vCPU state(even if realized) */
+    cpu_vmstate_unregister(cs);
+    /* remove from 'present' and 'enabled' list of active vCPUs */
+    cpu_list_remove(cs);
+    /* ensure that other context do not kick us out of the parked state */
+    cs->parked = true;
+    /* this will kick the sleeping KVM vCPUs to Qemu; releasing vCPU mutex */
+    cpu_pause(cs);
+}
+
+static void virt_unpark_cpu_in_userspace(CPUState *cs)
+{
+    /* disabled vCPUs lack a VMStateDescription; re-register */
+    cpu_vmstate_register(cs);
+    /* add back to 'present' and 'enabled' list of active vCPUs */
+    cpu_list_add(cs);
+    /*
+     * kick back the vCPU into action; operational power-on will happen in
+     * context to PSCI CPU_ON executed by the Guest. We are just enabling the
+     * infrastructre here and making it available to the Guest.
+     */
+    cs->parked = false;
+    cpu_resume(cs);
+}
+
+static void
+virt_cpu_pre_poweron(PowerStateHandler *handler, DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(handler);
+    PowerStateHandlerClass *pshc;
+    CPUState *cs = CPU(dev);
+
+    /*
+     * Lazy realization path: bring the CPU to a realized state the first time
+     * it is powered on. Saves boot time; later power-ons skips this.
+     */
+    if (!dev->realized) {
+        qdev_realize(dev, NULL, errp);
+    } else {
+        /* Realized but parked 'disabled' vCPUs */
+        virt_unpark_cpu_in_userspace(cs);
+    }
+
+    gicv3_mark_gicc_accessible(OBJECT(vms->gic), cs->cpu_index, errp);
+    if (*errp) {
+        error_setg(errp, "couldn't mark GICC accessibile for CPU %d",
+                   cs->cpu_index);
+        return;
+    }
+
+    /* update the firmware information for the next boot. */
+    vms->boot_cpus++;
+    if (vms->fw_cfg) {
+        fw_cfg_modify_i16(vms->fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
+    }
+
+    /*
+     * Notify the guest that a CPU is powered-on(_STA.Ena = 1), triggering a
+     * Device Check (Notify(..., 0x80)) via GED. This prompts OSPM to
+     * re-evaluate ACPI _STA method.
+     *
+     * Only notify after the VM is ready i.e., the guest kernel is initialized.
+     * For example, during boot-time '-deviceset' usage, the kernel isn't ready,
+     * so sending a notification is pointless.
+     */
+    if (phase_check(PHASE_MACHINE_READY) &&
+        !runstate_check(RUN_STATE_INMIGRATE)) {
+        pshc = POWERSTATE_HANDLER_GET_CLASS(vms->acpi_dev);
+        pshc->pre_poweron(POWERSTATE_HANDLER(vms->acpi_dev), dev, errp);
+        if (*errp) {
+            error_setg(errp, "failed to notify OSPM about CPU %d power-on",
+                       cs->cpu_index);
+            return;
+        }
+    }
+
+    /*
+     * Guest Kernel/OSPM will issue PSCI CPU_ON, which performs the cold start
+     * (reset + entry state) for this CPU
+     */
+}
+
+static void
+virt_cpu_request_poweroff(PowerStateHandler *handler, DeviceState *dev,
+                          Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(handler);
+    PowerStateHandlerClass *pshc;
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (cs->cpu_index == first_cpu->cpu_index) {
+        error_setg(errp, "can't power-off  boot CPU (id=%d [%d:%d:%d:%d])",
+                   first_cpu->cpu_index, cpu->socket_id, cpu->cluster_id,
+                   cpu->core_id, cpu->thread_id);
+        return;
+    }
+
+    /*
+     * Check that we are not tearing down too early when no live state exists.
+     * This can happen in:
+     *  1. Lazy device realization
+     *  2. Use of '-device-set' at qemu prompt
+     *  3. Post-migration on the destination VM
+     */
+    if (!dev->realized) {
+        return;
+    }
+
+    if (!phase_check(PHASE_MACHINE_READY) ||
+        runstate_check(RUN_STATE_INMIGRATE)) {
+        virt_park_cpu_in_userspace(cs);
+        return;
+    }
+
+    /*
+     * powering-off a CPU triggers an Eject Request (Notify(..., 0x03))
+     * via GED, prompting the OSPM to invoke _EJ0 for device removal handling.
+     */
+    pshc = POWERSTATE_HANDLER_GET_CLASS(vms->acpi_dev);
+    pshc->request_poweroff(POWERSTATE_HANDLER(vms->acpi_dev), dev, errp);
+    if (*errp) {
+        error_setg(errp, "request failed to power-off CPU %d", cs->cpu_index);
+        return;
+    }
+}
+
+static void
+virt_cpu_post_poweroff(PowerStateHandler *handler, DeviceState *dev,
+                       Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(handler);
+    PowerStateHandlerClass *pshc;
+    CPUState *cs = CPU(dev);
+
+    /*
+     * Just in case we are here too early. Ignore admin power-off before
+     * realize; no live state to tear down.
+     */
+    if (!dev->realized) {
+        return;
+    }
+
+    /* we are here because OSPM has already offline'd CPU and issued EJ0 */
+    pshc = POWERSTATE_HANDLER_GET_CLASS(vms->acpi_dev);
+    pshc->post_poweroff(POWERSTATE_HANDLER(vms->acpi_dev), dev, errp);
+    if (*errp) {
+        error_setg(errp, "failed to complete CPU %d power-off", cs->cpu_index);
+        return;
+    }
+
+    vms->boot_cpus--;
+    if (vms->fw_cfg) {
+        fw_cfg_modify_i16(vms->fw_cfg, FW_CFG_NB_CPUS, vms->boot_cpus);
+    }
+
+    gicv3_mark_gicc_inaccessible(OBJECT(vms->gic), cs->cpu_index, errp);
+    if (*errp) {
+        error_setg(errp, "couldn't mark GICC inaccessibile for CPU %d",
+                   cs->cpu_index);
+        return;
+    }
+
+    /*
+     * A 'disabled' vCPU is quiesced; now park it in userspace. For KVM,
+     * this unblocks the sleeping vCPU thread and re-blocks it inside QEMU,
+     * reducing KVM vCPU lock contention.
+     */
+    virt_park_cpu_in_userspace(cs);
+}
+
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
     uint8_t clustersz;
@@ -3218,6 +3394,53 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void
+virt_machine_device_request_poweroff(PowerStateHandler *handler,
+                                     DeviceState *dev,
+                                     Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_request_poweroff(handler, dev, errp);
+    } else {
+        error_setg(errp, "power-off request for unsupported device-type: %s",
+                   object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void
+virt_machine_device_post_poweroff(PowerStateHandler *handler, DeviceState *dev,
+                                  Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_post_poweroff(handler, dev, errp);
+    } else {
+        error_setg(errp, "can't complete power-off, unsupported device-type %s",
+                   object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void
+virt_machine_device_pre_poweron(PowerStateHandler *handler, DeviceState *dev,
+                                Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_pre_poweron(handler, dev, errp);
+    } else {
+        error_setg(errp, "can't prepare power-on, unsupported device-type %s",
+                   object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void *
+virt_machine_powerstate_handler(MachineState *machine, DeviceState *dev)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        return (void *)POWERSTATE_HANDLER(machine);
+    }
+
+    return NULL;
+}
+
 /*
  * for arm64 kvm_type [7-0] encodes the requested number of bits
  * in the IPA address space
@@ -3294,6 +3517,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
+    PowerStateHandlerClass *pshc = POWERSTATE_HANDLER_CLASS(oc);
     static const char * const valid_cpu_types[] = {
 #ifdef CONFIG_TCG
         ARM_CPU_TYPE_NAME("cortex-a7"),
@@ -3358,7 +3582,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     hc->unplug = virt_machine_device_unplug_cb;
 
+    /* virt machine device powerstate handlers & callbacks */
+    assert(!mc->get_powerstate_handler);
     mc->has_online_capable_cpus = true;
+    mc->get_powerstate_handler = virt_machine_powerstate_handler;
+    pshc->request_poweroff = virt_machine_device_request_poweroff;
+    pshc->post_poweroff = virt_machine_device_post_poweroff;
+    pshc->pre_poweron = virt_machine_device_pre_poweron;
 
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
@@ -3560,6 +3790,7 @@ static const TypeInfo virt_machine_info = {
     .instance_init = virt_instance_init,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_POWERSTATE_HANDLER },
          { }
     },
 };
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 68081b79bb..0898e8eed3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -166,6 +166,7 @@ struct VirtMachineState {
     MemMapEntry *memmap;
     char *pciehb_nodename;
     const int *irqmap;
+    uint16_t boot_cpus;
     int fdt_size;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2ee202a8a5..ccf5588011 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -485,6 +485,7 @@ struct CPUState {
     bool created;
     bool stop;
     bool stopped;
+    bool parked;
 
     /* Should CPU start in powered-off state? */
     bool start_powered_off;
@@ -549,6 +550,7 @@ struct CPUState {
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
+    bool preserve_assigned_cpu_index;
     int cluster_index;
     uint32_t tcg_cflags;
     uint32_t halted;
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bbf899184e..a8a84c4687 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -353,4 +353,34 @@ static inline bool gicv3_gicc_accessible(Object *obj, int cpu)
 
     return value;
 }
+
+/**
+ * gicv3_mark_gicc_accessible:
+ * @obj: QOM object implementing the GICv3 device
+ * @cpu: Index of the vCPU to mark as GICC-accessible
+ * @errp: Pointer to an Error* for reporting failures
+ *
+ * Marks GICv3CPUState::gicc_accessible as accessible and available for use.
+ */
+static inline void
+gicv3_mark_gicc_accessible(Object *obj, int cpu, Error **errp)
+{
+    g_autofree gchar *propname = g_strdup_printf("gicc-accessible[%d]", cpu);
+    object_property_set_bool(obj, propname, true, errp);
+}
+
+/**
+ * gicv3_mark_gicc_inaccessible:
+ * @obj: QOM object implementing the GICv3 device
+ * @cpu: Index of the vCPU to mark as GICC-inaccessible
+ * @errp: Pointer to an Error* for reporting failures
+ *
+ * Marks GICv3CPUState::gicc_accessible as inaccessible and unavailable for use.
+ */
+static inline void
+gicv3_mark_gicc_inaccessible(Object *obj, int cpu, Error **errp)
+{
+    g_autofree gchar *propname = g_strdup_printf("gicc-accessible[%d]", cpu);
+    object_property_set_bool(obj, propname, false, errp);
+}
 #endif
diff --git a/system/cpus.c b/system/cpus.c
index 256723558d..0545aaaa0f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -89,7 +89,7 @@ bool cpu_thread_is_idle(CPUState *cpu)
     if (cpu->stop || !cpu_work_list_empty(cpu)) {
         return false;
     }
-    if (cpu_is_stopped(cpu)) {
+    if (cpu_is_stopped(cpu) || cpu->parked) {
         return true;
     }
     if (!cpu->halted || cpu_has_work(cpu)) {
@@ -327,7 +327,7 @@ bool cpu_can_run(CPUState *cpu)
     if (cpu->stop) {
         return false;
     }
-    if (cpu_is_stopped(cpu)) {
+    if (cpu_is_stopped(cpu) || cpu->parked) {
         return false;
     }
     return true;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a5906d1672..0ceaf69092 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1502,6 +1502,7 @@ static void arm_cpu_initfn(Object *obj)
     }
 
     CPU(obj)->thread_id = 0;
+    CPU(obj)->preserve_assigned_cpu_index = true;
 }
 
 /*
-- 
2.34.1


