Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B636CC5B549
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJp1J-0007YI-JL; Tue, 27 May 2025 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJozG-0002kv-3g
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJozE-0000S1-6w
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdU5cY/SULLwyXpxxEZqK8ZNb0hepj4gkwMPt3FqJ10=;
 b=M4Jd7/+AV928nAWxLbFaKy/AmCxUXRZ7+2FKDEpS+G4NN+nFWDIbfvDCp9Cx0GLJyiu/PF
 3h9Uqszp2+56fOdtPAZr8sM4bA4ij/c1PdUGZzvZ28I4jQ3cqlgL6SIMqPLUuNGF6HaqEH
 0UYvU2cjI25l6473sLlcSoteZA+SZrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-otcXCW75Ntqxe4srdlj3OQ-1; Tue,
 27 May 2025 03:44:31 -0400
X-MC-Unique: otcXCW75Ntqxe4srdlj3OQ-1
X-Mimecast-MFC-AGG-ID: otcXCW75Ntqxe4srdlj3OQ_1748331870
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE2BA1956094; Tue, 27 May 2025 07:44:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 131CE19560AA; Tue, 27 May 2025 07:44:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 23/25] hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
Date: Tue, 27 May 2025 09:40:25 +0200
Message-ID: <20250527074224.1197793-24-eric.auger@redhat.com>
In-Reply-To: <20250527074224.1197793-1-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cdcff0a984..adb9422e14 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -87,6 +87,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "hw/acpi/pcihp.h"
 
 static GlobalProperty arm_virt_compat[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -2973,6 +2974,11 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         qlist_append_str(reserved_regions, resv_prop_str);
         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
         g_free(resv_prop_str);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        if (vms->acpi_pcihp) {
+            acpi_pcihp_device_pre_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                          dev, errp);
+        }
     }
 }
 
@@ -3002,6 +3008,14 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         vms->iommu = VIRT_IOMMU_VIRTIO;
         vms->virtio_iommu_bdf = pci_get_bdf(pdev);
         create_virtio_iommu_dt_bindings(vms);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
+        AcpiPciHpState *acpi_pci_hotplug = &acpi_ged_state->pcihp_state;
+
+        if (vms->acpi_pcihp) {
+            acpi_pcihp_device_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                      acpi_pci_hotplug, dev, errp);
+        }
     }
 }
 
@@ -3051,6 +3065,15 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
                                      errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
+        AcpiPciHpState *acpi_pci_hotplug = &acpi_ged_state->pcihp_state;
+
+        if (vms->acpi_pcihp) {
+            acpi_pcihp_device_unplug_request_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                                acpi_pci_hotplug, dev, errp);
+        }
     } else {
         error_setg(errp, "device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -3064,6 +3087,15 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         virt_dimm_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
+        AcpiPciHpState *acpi_pci_hotplug = &acpi_ged_state->pcihp_state;
+
+        if (vms->acpi_pcihp) {
+            acpi_pcihp_device_unplug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                        acpi_pci_hotplug, dev, errp);
+        }
     } else {
         error_setg(errp, "virt: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -3074,11 +3106,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    VirtMachineState *vms = VIRT_MACHINE(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
+        (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE) &&
+                             vms->acpi_pcihp)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
-- 
2.49.0


