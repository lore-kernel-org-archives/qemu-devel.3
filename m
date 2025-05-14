Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41F1C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFZ6-0003yR-2c; Wed, 14 May 2025 13:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFYr-0003Le-4B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFYp-0007t4-4E
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q83CkXF8NEiBj3QV+2hl2ecjW+MQWvpfAJhE5AVyMh4=;
 b=Bhl6jtG0tvouPKxGwBh3vgGhsawfQaVwG9o+7Bfy6Z+PW9nG636MXxvCu4R1DrYHVIPPSM
 QA3J5wR2kozfUwc1EURGywDgNsYJOw8iK5AXa8u+87+C+dlLMEZ8IXlES9ebSmnLAdNZbU
 BGn0TGSzVqHudgGtZFEbalhLu8YzOnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-k9-PRzm1MjCITfZ5d5l8kA-1; Wed,
 14 May 2025 13:06:22 -0400
X-MC-Unique: k9-PRzm1MjCITfZ5d5l8kA-1
X-Mimecast-MFC-AGG-ID: k9-PRzm1MjCITfZ5d5l8kA_1747242380
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2C471800876; Wed, 14 May 2025 17:06:20 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85D1D30001B1; Wed, 14 May 2025 17:06:16 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com,
	philmd@linaro.org
Subject: [PATCH 20/22] hw/arm/virt: Let virt support pci hotplug/unplug GED
 event
Date: Wed, 14 May 2025 19:01:07 +0200
Message-ID: <20250514170431.2786231-21-eric.auger@redhat.com>
In-Reply-To: <20250514170431.2786231-1-eric.auger@redhat.com>
References: <20250514170431.2786231-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Set up the IO registers used to communicate between QEMU
and ACPI.

Move the create_pcie() call after the creation of the acpi
ged device since hotplug callbacks will soon be called on gpex
realize and will require the acpi pcihp state to be initialized.

The hacky thing is the root bus has not yet been created on
acpi_pcihp_init() call so it is set later after the gpex realize.

How to fix this chicken & egg issue?

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 42 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 1b2e2e1284..a4c4e3a67a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/block/flash.h"
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2b642e2426..05a754d368 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -44,6 +44,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4aa40c8e8b..526c4c44be 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -682,6 +682,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
+    SysBusDevice *sbdev;
+
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
@@ -693,12 +695,28 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
         event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
     }
 
+    if (vms->acpi_pcihp) {
+        event |= ACPI_GED_PCI_HOTPLUG_EVT;
+    }
+
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sbdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbdev, &error_fatal);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
+    if (vms->acpi_pcihp) {
+        AcpiGedState *acpi_ged_state = ACPI_GED(dev);
+        int i;
+
+        i = sysbus_mmio_map_name(sbdev, "pcihp container",
+                                 vms->memmap[VIRT_ACPI_PCIHP].base);
+        assert(i >= 0);
+        acpi_pcihp_init(OBJECT(dev), &acpi_ged_state->pcihp_state,
+                        vms->bus, sysbus_mmio_get_region(sbdev, i), 0);
+        acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
+    }
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
     return dev;
@@ -1758,6 +1776,13 @@ void virt_machine_done(Notifier *notifier, void *data)
     pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
                                        &error_abort);
 
+
+    if (vms->acpi_pcihp) {
+        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
+
+        acpi_pcihp_reset(&acpi_ged_state->pcihp_state);
+    }
+
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
 }
@@ -2395,8 +2420,6 @@ static void machvirt_init(MachineState *machine)
 
     create_rtc(vms);
 
-    create_pcie(vms);
-
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
         vms->acpi_dev = create_acpi_ged(vms);
@@ -2405,6 +2428,15 @@ static void machvirt_init(MachineState *machine)
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
 
+    create_pcie(vms);
+
+    if (vms->acpi_dev) {
+        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
+
+        acpi_ged_state = ACPI_GED(vms->acpi_dev);
+        acpi_ged_state->pcihp_state.root = vms->bus;
+    }
+
     if (vms->secure && !vmc->no_secure_gpio) {
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
     }
-- 
2.49.0


