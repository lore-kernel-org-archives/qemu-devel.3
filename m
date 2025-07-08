Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F529C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEO8-0008PE-Ay; Tue, 08 Jul 2025 15:54:00 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBQ3-00010S-5S
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZBPp-0005zQ-72
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751992887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxwfYEvRpYO+ysfGn4l7Ic5LE5Wsaju89hTYULgExAg=;
 b=b50xpQ2lF05PCw8pcRxccnwIjHIQl3Kf/9gT0+lJw4XL+LZp3XKX7q+NRV6QPiLWi36+eX
 CiJ3JDtZDbRmisJJg40gWqmOzfrkjhi5amFrtbxOPAvDuarNVYc+pjq3Jn9kdDm5z9Agli
 ssn1bw6Xbca/3RUh+6atUc9DtB9Nz5s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-IrR8yYlJPQ-QlBvGFkhJOg-1; Tue,
 08 Jul 2025 10:28:11 -0400
X-MC-Unique: IrR8yYlJPQ-QlBvGFkhJOg-1
X-Mimecast-MFC-AGG-ID: IrR8yYlJPQ-QlBvGFkhJOg_1751984887
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5618B180136B; Tue,  8 Jul 2025 14:28:07 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDF3830001B9; Tue,  8 Jul 2025 14:28:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v6 31/36] hw/arm/virt: Minor code reshuffling in
 create_acpi_ged
Date: Tue,  8 Jul 2025 16:23:13 +0200
Message-ID: <20250708142437.1344644-32-eric.auger@redhat.com>
In-Reply-To: <20250708142437.1344644-1-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use a local SysBusDevice handle. Also use the newly introduced
sysbus_mmio_map_name which brings better readability about the region
being mapped. GED device has regions which exist depending on some
external properties and it becomes difficult to guess the index of
a region. Better refer to a region by its name.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 include/hw/acpi/generic_event_device.h |  1 +
 hw/arm/virt.c                          | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d56adaa626..2c5b055327 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -111,6 +111,7 @@ typedef struct GEDState {
 } GEDState;
 
 #define ACPI_PCIHP_REGION_NAME "pcihp container"
+#define ACPI_MEMHP_REGION_NAME "memhp container"
 
 struct AcpiGedState {
     SysBusDevice parent_obj;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 34a3831530..7b247ad30c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -683,6 +683,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
+    SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
@@ -697,11 +698,13 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sbdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbdev, &error_fatal);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
+                         vms->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
 
     return dev;
 }
-- 
2.49.0


