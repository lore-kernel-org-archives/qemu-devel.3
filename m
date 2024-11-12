Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BADCD42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuL4-0007g4-Tw; Tue, 12 Nov 2024 12:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIo-0003nq-B6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIk-0001cZ-FJ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731431017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2axKaCW1Z2fkq8aW+kN1R6He+CoS5FSvi1e/Yf1gaQ=;
 b=exQ121wkadvIn8E/tFVcbw8orkzF1m3Hf+xyMeLW8LxvBmYDHYtpTTryh59YqJg1ITmuUO
 s2CjZpOCaYe8FU/wj9JxhxpGOXhrqKRc2HZYv8376mlMHqvLdJ/Pw9Lf5gGpVcamopoHcT
 EIJ4mqdaIzzlos8r/p0T56qEhqzK1LI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-B4s0NHw1MPekBbUsA14cpw-1; Tue,
 12 Nov 2024 12:03:31 -0500
X-MC-Unique: B4s0NHw1MPekBbUsA14cpw-1
X-Mimecast-MFC-AGG-ID: B4s0NHw1MPekBbUsA14cpw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7DE51954230; Tue, 12 Nov 2024 17:03:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCD4B1956089; Tue, 12 Nov 2024 17:03:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [RFC 7/7] DO NOT MERGE: acpi: cpuhp: preserve always present vCPUs on
 unplug
Date: Tue, 12 Nov 2024 18:02:58 +0100
Message-ID: <20241112170258.2996640-8-imammedo@redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

do not drop reference to always present vCPU and also
avoid destroying it (unparent) on unplug.

Based-on: 2d6cfbaf174 (hw/acpi: Make CPUs ACPI `presence` conditional during vCPU hot-unplug)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/cpu.h           |  4 +++-
 hw/acpi/acpi-cpu-hotplug-stub.c |  3 ++-
 hw/acpi/cpu.c                   | 10 ++++++++--
 hw/acpi/cpu_hotplug.c           |  2 +-
 hw/acpi/generic_event_device.c  |  2 +-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index e9e9c28359..f6708cafba 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -36,6 +36,7 @@ typedef struct CPUHotplugState {
     uint32_t selector;
     uint8_t command;
     uint32_t dev_count;
+    bool always_present_cpus;
     AcpiCpuStatus *devs;
 } CPUHotplugState;
 
@@ -50,7 +51,8 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
                         DeviceState *dev, Error **errp);
 
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
-                         CPUHotplugState *state, hwaddr base_addr);
+                         CPUHotplugState *state, hwaddr base_addr,
+                         bool always_present_cpus);
 
 typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index c6c61bb9cd..748fd04006 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -20,7 +20,8 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
 }
 
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
-                         CPUHotplugState *state, hwaddr base_addr)
+                         CPUHotplugState *state, hwaddr base_addr,
+                         bool always_present_cpus)
 {
     return;
 }
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 992ae5d233..d85d4add60 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -145,7 +145,6 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             dev = DEVICE(cdev->cpu);
             hotplug_ctrl = qdev_get_hotplug_handler(dev);
             hotplug_handler_unplug(hotplug_ctrl, dev, NULL);
-            object_unparent(OBJECT(dev));
             cdev->fw_remove = false;
         } else if (data & 16) {
             if (!cdev->cpu || cdev->cpu == first_cpu) {
@@ -215,7 +214,8 @@ static const MemoryRegionOps cpu_hotplug_ops = {
 };
 
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
-                         CPUHotplugState *state, hwaddr base_addr)
+                         CPUHotplugState *state, hwaddr base_addr,
+                         bool always_present_cpus)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -226,6 +226,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     id_list = mc->possible_cpu_arch_ids(machine);
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);
+    state->always_present_cpus = always_present_cpus;
     for (i = 0; i < id_list->len; i++) {
         state->devs[i].cpu =  CPU(id_list->cpus[i].cpu);
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
@@ -286,12 +287,17 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
 {
     AcpiCpuStatus *cdev;
 
+    if (cpu_st->always_present_cpus) {
+        return;
+    }
+
     cdev = get_cpu_status(cpu_st, dev);
     if (!cdev) {
         return;
     }
 
     cdev->cpu = NULL;
+    object_unparent(OBJECT(dev));
 }
 
 static const VMStateDescription vmstate_cpuhp_sts = {
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 83b8bc5deb..8c3618680f 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -115,7 +115,7 @@ void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
     MemoryRegion *parent = pci_address_space_io(PCI_DEVICE(gpe_cpu->device));
 
     memory_region_del_subregion(parent, &gpe_cpu->io);
-    cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
+    cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port, false);
 }
 
 void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 663d9cb093..9099b76f80 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -427,7 +427,7 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
                                 ACPI_CPU_HOTPLUG_REG_LEN);
             sysbus_init_mmio(sbd, &s->container_cpuhp);
             cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
-                                &s->cpuhp_state, 0);
+                                &s->cpuhp_state, 0, false);
             break;
         }
         ged_events--;
-- 
2.43.0


