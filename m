Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A5CCF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNL5-0007Pr-SA; Tue, 08 Oct 2024 23:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNL3-0007KP-97; Tue, 08 Oct 2024 23:26:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNL1-0004yT-8N; Tue, 08 Oct 2024 23:26:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdTp3Kb6z6LD7Q;
 Wed,  9 Oct 2024 11:21:50 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E3CE140B3C;
 Wed,  9 Oct 2024 11:26:09 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:25:50 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 20/33] arm/virt: Add/update basic hot-(un)plug framework
Date: Wed, 9 Oct 2024 04:18:02 +0100
Message-ID: <20241009031815.250096-21-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add CPU hot-unplug hooks and update hotplug hooks with additional sanity checks
for use in hotplug paths.

Note: The functional contents of the hooks (currently left with TODO comments)
will be gradually filled in subsequent patches in an incremental approach to
patch and logic building, which would roughly include the following:

1. (Un)wiring of interrupts between vCPU<->GIC.
2. Sending events to the guest for hot-(un)plug so that the guest can take
   appropriate actions.
3. Notifying the GIC about the hot-(un)plug action so that the vCPU can be
   (un)stitched to the GIC CPU interface.
4. Updating the guest with next boot information for this vCPU in the firmware.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d8cae70ab2..6da71b0068 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,6 +85,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "qapi/qmp/qdict.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -3016,11 +3017,23 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
 static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     ARMCPU *cpu = ARM_CPU(dev);
     CPUState *cs = CPU(dev);
     CPUArchId *cpu_slot;
 
+    if (dev->hotplugged && !vms->acpi_dev) {
+        error_setg(errp, "GED acpi device does not exists");
+        return;
+    }
+
+    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
+        error_setg(errp, "CPU hotplug not supported on this machine");
+        return;
+    }
+
     /* sanity check the cpu */
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -3062,11 +3075,30 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
     virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
+
+    /*
+     * Fix the GIC for the newly plugged vCPU. The QOM CPU object for this new
+     * vCPU needs to be updated in the corresponding QOM `GICv3CPUState` object.
+     * Additionally, the IRQs for this new CPU object must be re-wired. This
+     * update is confined to the QOM layer and does not affect KVM, as KVM was
+     * already pre-sized with possible CPUs during VM initialization. This
+     * serves as a workaround to the constraints posed by the ARM architecture
+     * in supporting CPU hotplug, for which no formal specification exists.
+     *
+     * This GIC IRQ patch-up is necessary for both cold- and hot-plugged vCPUs.
+     * Cold-initialized vCPUs have their GIC state initialized earlier during
+     * `machvirt_init()`.
+     */
+    if (vms->acpi_dev) {
+        /* TODO: update GIC about this hotplug change here */
+        /* TODO: wire the GIC<->CPU irqs */
+    }
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                           Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     CPUState *cs = CPU(dev);
     CPUArchId *cpu_slot;
 
@@ -3083,7 +3115,80 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         cpu_slot->arch_id = arm_cpu_mp_affinity(ARM_CPU(cs));
     }
 
+    if (vms->acpi_dev) {
+        /* TODO: register cpu for reset & update F/W info for the next boot */
+    }
+
+    /*
+     * `Enable` the QOM vCPU before updating its ACPI `AcpiCpuStatus` and
+     * notifying the guest kernel about the availability of the new vCPU.
+     */
     cs->disabled = false;
+
+    /*
+     * Update the ACPI hotplug state for vCPUs being both hot- and cold-plugged.
+     * vCPUs can be cold-plugged using the `-device` option. For vCPUs that are
+     * hot-plugged, the guest is also notified.
+     */
+    if (vms->acpi_dev) {
+        /* TODO: update acpi hotplug state. Send cpu hotplug event to guest */
+    }
+}
+
+static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (!vms->acpi_dev) {
+        error_setg(errp, "GED does not exists or device is not realized!");
+        return;
+    }
+
+    if (!mc->has_hotpluggable_cpus) {
+        error_setg(errp, "CPU hot(un)plug not supported on this machine");
+        return;
+    }
+
+    if (cs->cpu_index == first_cpu->cpu_index) {
+        error_setg(errp, "Boot CPU(id%d=%d:%d:%d:%d) hot-unplug not supported",
+                   first_cpu->cpu_index, cpu->socket_id, cpu->cluster_id,
+                   cpu->core_id, cpu->thread_id);
+        return;
+    }
+
+    /* TODO: request cpu hotplug from guest */
+}
+
+static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                            Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+
+    if (!vms->acpi_dev) {
+        error_setg(errp, "GED does not exists or device is not realized!");
+        return;
+    }
+
+    cpu_slot = virt_find_cpu_slot(cs);
+
+    /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
+
+    /* TODO: unwire the gic-cpu irqs here */
+    /* TODO: update the GIC about this hot unplug change */
+
+    /* TODO: unregister cpu for reset & update F/W info for the next boot */
+
+    qobject_unref(dev->opts);
+    dev->opts = NULL;
+
+    cpu_slot->cpu = NULL;
+    cs->disabled = true;
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
@@ -3210,6 +3315,8 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
                                      errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_unplug_request(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -3223,6 +3330,8 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         virt_dimm_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        virt_cpu_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "virt: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
-- 
2.34.1


