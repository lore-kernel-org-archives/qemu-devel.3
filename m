Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4C8C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5rS-00085l-4K; Fri, 27 Jun 2025 05:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5r1-0007TN-5x
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV5qz-0008DX-ED
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751018319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nflNhAirwnlCA2CZ1+V1ICyO5meFSFGs3GcoyBK2x7g=;
 b=TXuA/zkKPs7yb7j0+FkLTuhGXdHCQpIrRsi0RzxQqJn6I8KUu6AaHEOiOB+fZvRz4tEp5P
 Ylo9ZlAMFPlEf6W5NWsWF697y8V2uRZ5ToIurLwH0QWTlsgNasXzo7gZKCOvY4A5ROslat
 iSVGrqDUTxC7tz8czY6RGDGhYhD1Ny0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-YxOAU-gCNgKiezNM52njvw-1; Fri,
 27 Jun 2025 05:58:36 -0400
X-MC-Unique: YxOAU-gCNgKiezNM52njvw-1
X-Mimecast-MFC-AGG-ID: YxOAU-gCNgKiezNM52njvw_1751018314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FDC91808993; Fri, 27 Jun 2025 09:58:34 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10D2E19560A7; Fri, 27 Jun 2025 09:58:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v4 25/32] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
Date: Fri, 27 Jun 2025 11:55:14 +0200
Message-ID: <20250627095620.3300028-26-eric.auger@redhat.com>
In-Reply-To: <20250627095620.3300028-1-eric.auger@redhat.com>
References: <20250627095620.3300028-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
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

QEMU will notify the OS about PCI hotplug/hotunplug events through
GED interrupts. Let the GED device handle a new PCI hotplug event.
On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
mutex held.

The GED device uses a dedicated MMIO region that will be mapped
by the machine code.

At this point the GED still does not support PCI device hotplug in
its TYPE_HOTPLUG_HANDLER implementation. This will come in a
subsequent patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- add qbus_set_hotplug_handler
- root bus is not passed in acpi_pcihp_init arg

v2 -> v3:
- pcihp_init and reset are put in ged code instead of machine code
  (Igor)
- Add ACPI_GED_PCI_HOTPLUG_EVT event depending on use_acpi_hotplug_bridge
  (Igor)

v1 -> v2:
- Introduce ACPI_PCIHP_REGION_NAME
---
 include/hw/acpi/generic_event_device.h |  4 ++++
 hw/acpi/generic_event_device.c         | 31 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index f5ffa67a39..ec8e1abe0a 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -102,6 +102,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_PCI_HOTPLUG_EVT    0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -109,6 +110,8 @@ typedef struct GEDState {
     uint32_t     sel;
 } GEDState;
 
+#define ACPI_PCIHP_REGION_NAME "pcihp container"
+
 struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
@@ -116,6 +119,7 @@ struct AcpiGedState {
     CPUHotplugState cpuhp_state;
     MemoryRegion container_cpuhp;
     AcpiPciHpState pcihp_state;
+    MemoryRegion container_pcihp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 92b931758f..fc84bfb34e 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
@@ -28,6 +29,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_PCI_HOTPLUG_EVT,
 };
 
 /*
@@ -123,6 +125,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name("\\_SB.NVDR"),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_PCI_HOTPLUG_EVT:
+                aml_append(if_ctx,
+                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
+                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
+                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
+                break;
             default:
                 /*
                  * Please make sure all the events in ged_supported_events[]
@@ -316,6 +324,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
         sel = ACPI_GED_CPU_HOTPLUG_EVT;
+    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
+        sel = ACPI_GED_PCI_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
@@ -427,9 +437,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AcpiGedState *s = ACPI_GED(dev);
+    AcpiPciHpState *pcihp_state = &s->pcihp_state;
     uint32_t ged_events;
     int i;
 
+    if (pcihp_state->use_acpi_hotplug_bridge) {
+        s->ged_event_bitmap |= ACPI_GED_PCI_HOTPLUG_EVT;
+    }
     ged_events = ctpop32(s->ged_event_bitmap);
 
     for (i = 0; i < ARRAY_SIZE(ged_supported_events) && ged_events; i++) {
@@ -449,6 +463,13 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
             cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
                                 &s->cpuhp_state, 0);
             break;
+        case ACPI_GED_PCI_HOTPLUG_EVT:
+            memory_region_init(&s->container_pcihp, OBJECT(dev),
+                               ACPI_PCIHP_REGION_NAME, ACPI_PCIHP_SIZE);
+            sysbus_init_mmio(sbd, &s->container_pcihp);
+            acpi_pcihp_init(OBJECT(s), &s->pcihp_state,
+                            &s->container_pcihp, 0);
+            qbus_set_hotplug_handler(BUS(s->pcihp_state.root), OBJECT(dev));
         }
         ged_events--;
     }
@@ -490,6 +511,15 @@ static void acpi_ged_initfn(Object *obj)
     sysbus_init_mmio(sbd, &ged_st->regs);
 }
 
+static void ged_reset(DeviceState *dev)
+{
+    AcpiGedState *s = ACPI_GED(dev);
+
+    if (s->pcihp_state.use_acpi_hotplug_bridge) {
+        acpi_pcihp_reset(&s->pcihp_state);
+    }
+}
+
 static void acpi_ged_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -505,6 +535,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
     hc->plug = acpi_ged_device_plug_cb;
     hc->unplug_request = acpi_ged_unplug_request_cb;
     hc->unplug = acpi_ged_unplug_cb;
+    device_class_set_legacy_reset(dc, ged_reset);
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
-- 
2.49.0


