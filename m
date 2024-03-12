Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9123C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 02:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjrTA-0007FG-PP; Mon, 11 Mar 2024 22:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1rjrSe-0006iv-Ts; Mon, 11 Mar 2024 22:01:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1rjrSa-0004fA-W7; Mon, 11 Mar 2024 22:01:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ttxbv6kr4z6K9Pl;
 Tue, 12 Mar 2024 09:57:31 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id B7F9B1400C9;
 Tue, 12 Mar 2024 10:01:36 +0800 (CST)
Received: from A190218597.china.huawei.com (10.48.148.5) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 02:01:19 +0000
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <linuxarm@huawei.com>
Subject: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support vCPU
 Hotplug
Date: Tue, 12 Mar 2024 01:59:55 +0000
Message-ID: <20240312020000.12992-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20240312020000.12992-1-salil.mehta@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.148.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ACPI GED (as described in the ACPI 6.4 spec) uses an interrupt listed in the
_CRS object of GED to intimate OSPM about an event. Later then demultiplexes the
notified event by evaluating ACPI _EVT method to know the type of event. Use
ACPI GED to also notify the guest kernel about any CPU hot(un)plug events.

ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
stub to avoid compilation break.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++++++
 hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
 include/hw/acpi/generic_event_device.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 3fc4b14c26..c6c61bb9cd 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     return;
 }
 
+void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
+                         CPUHotplugState *state, hwaddr base_addr)
+{
+    return;
+}
+
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
     return;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 2d6e91b124..35a71505a5 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/cpu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
@@ -25,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
+    ACPI_GED_CPU_HOTPLUG_EVT,
 };
 
 /*
@@ -234,6 +236,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
         } else {
             acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
         }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "virt: device plug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -248,6 +252,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
     if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
                        !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
         acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -261,6 +267,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -272,6 +280,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     AcpiGedState *s = ACPI_GED(adev);
 
     acpi_memory_ospm_status(&s->memhp_state, list);
+    acpi_cpu_ospm_status(&s->cpuhp_state, list);
 }
 
 static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
@@ -286,6 +295,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_PWR_DOWN_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
+        sel = ACPI_GED_CPU_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
@@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
     sysbus_init_mmio(sbd, &ged_st->regs);
+
+    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
+                       ACPI_CPU_HOTPLUG_REG_LEN);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
+    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
+                        &s->cpuhp_state, 0);
 }
 
 static void acpi_ged_class_init(ObjectClass *class, void *data)
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index ba84ce0214..90fc41cbb8 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -60,6 +60,7 @@
 #define HW_ACPI_GENERIC_EVENT_DEVICE_H
 
 #include "hw/sysbus.h"
+#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
 #include "qom/object.h"
@@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
+#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -106,6 +108,8 @@ struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     MemoryRegion container_memhp;
+    CPUHotplugState cpuhp_state;
+    MemoryRegion container_cpuhp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
-- 
2.34.1


