Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D488CC7115C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6VA-0004Jx-FH; Mon, 16 Jun 2025 05:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uR6V8-00049m-Fx
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uR6V6-0002NU-Jh
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750067494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgusPM07kBAeHWD5Y+8x0seUuXzRUdXP54zjL+CPYiQ=;
 b=YpetrK8v2cqavw6iBTHYncaBebh70n4OTEYnTv8VSz46jm/IGNxGSymTxDSr30GYfMtVfi
 kgphxFLY68kLm1TZFRta93NpnYlzmA7CyVaTss5qGlm88gInsx8PFssIBGPW34FgbBJ3ST
 xWyodtJUWDswLqYQ4G5uY1QQBXKSURU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-FPMA6zpvO2q2B5DDV8wauA-1; Mon,
 16 Jun 2025 05:51:31 -0400
X-MC-Unique: FPMA6zpvO2q2B5DDV8wauA-1
X-Mimecast-MFC-AGG-ID: FPMA6zpvO2q2B5DDV8wauA_1750067490
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEACD1809C81; Mon, 16 Jun 2025 09:51:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9852B19560A7; Mon, 16 Jun 2025 09:51:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 26/29] hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
Date: Mon, 16 Jun 2025 11:46:55 +0200
Message-ID: <20250616094903.885753-27-eric.auger@redhat.com>
In-Reply-To: <20250616094903.885753-1-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v2 -> v3:
- fix cohabitation with virtio-mem-pci device and tested
  hotplug/unplug of this latter (Igor)
---
 hw/arm/virt.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8c882e0794..06b87e1050 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1747,6 +1747,22 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+static AcpiPciHpState *get_acpi_pcihp_state(VirtMachineState *vms)
+{
+    AcpiGedState *acpi_ged_state;
+    AcpiPciHpState *pcihp_state;
+
+    if (!vms->acpi_dev) {
+        return NULL;
+    }
+    acpi_ged_state = ACPI_GED(vms->acpi_dev);
+    pcihp_state = &acpi_ged_state->pcihp_state;
+    if (pcihp_state->use_acpi_hotplug_bridge) {
+        return pcihp_state;
+    }
+    return NULL;
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -2907,6 +2923,13 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        if (get_acpi_pcihp_state(vms)) {
+            acpi_pcihp_device_pre_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                          dev, errp);
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -2961,6 +2984,15 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
+
+        if (pcihp_state) {
+            acpi_pcihp_device_plug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                      pcihp_state, dev, errp);
+        }
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -3017,12 +3049,27 @@ out:
 static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    bool supported = false;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug_request(hotplug_dev, dev, errp);
+        supported = true;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
                                      errp);
-    } else {
+        supported = true;
+    }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
+
+        if (pcihp_state) {
+            acpi_pcihp_device_unplug_request_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                                pcihp_state, dev, errp);
+            supported = true;
+        }
+    }
+    if (!supported) {
         error_setg(errp, "device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
@@ -3031,11 +3078,27 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
+    bool supported = false;
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug(hotplug_dev, dev, errp);
+        supported = true;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
-    } else {
+        supported = true;
+    }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+
+        AcpiPciHpState *pcihp_state = get_acpi_pcihp_state(vms);
+
+        if (pcihp_state) {
+            acpi_pcihp_device_unplug_cb(HOTPLUG_HANDLER(vms->acpi_dev),
+                                        pcihp_state, dev, errp);
+            supported = true;
+        }
+    }
+    if (!supported) {
         error_setg(errp, "virt: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
     }
@@ -3045,11 +3108,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
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
+                             get_acpi_pcihp_state(vms))) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
-- 
2.49.0


