Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDF0C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJI3-0007x4-QG; Thu, 03 Jul 2025 08:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXJF5-0004AO-Hc
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXJEt-0001TC-G4
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751546428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOo0M/gBODBY/l4vKN4I8WgeRJue6j7oGCUoicYhs58=;
 b=A6ac9a1b/TxBBy6+fO63hIfcdoOTk4Q1qF25mMN7XM8PX3kUKm5kt8uzsVvkg9CzZ6wztx
 ZhP+ympsBb9eUxEfI20KLGYR06V8+6B4ZnGtve2Xw5ddAqrIcXdjZr+9+nm67OLXr/R1W/
 8wjYba7bfQsXBdgUAPV1dbYMNAG1HPg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-YacpWBbyMqKWyBI4UfuuqA-1; Thu,
 03 Jul 2025 08:40:25 -0400
X-MC-Unique: YacpWBbyMqKWyBI4UfuuqA-1
X-Mimecast-MFC-AGG-ID: YacpWBbyMqKWyBI4UfuuqA_1751546424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47F6A19560A2; Thu,  3 Jul 2025 12:40:24 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C73EE180045C; Thu,  3 Jul 2025 12:40:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v5 32/36] hw/arm/virt: Let virt support pci hotplug/unplug GED
 event
Date: Thu,  3 Jul 2025 14:35:32 +0200
Message-ID: <20250703123728.414386-33-eric.auger@redhat.com>
In-Reply-To: <20250703123728.414386-1-eric.auger@redhat.com>
References: <20250703123728.414386-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v2 -> v3:
- remove acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
- use sysbus_mmio_map_name for all regs (Igor)
- create_pcie left at its original place

v1 -> v2:
- use ACPI_PCIHP_REGION_NAME
---
 hw/arm/virt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7b247ad30c..4f6fe16675 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -686,6 +686,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    bool acpi_pcihp;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -704,6 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
                          vms->memmap[VIRT_PCDIMM_ACPI].base);
+
+    acpi_pcihp = object_property_get_bool(OBJECT(dev),
+                                          ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, NULL);
+
+    if (acpi_pcihp) {
+        int pcihp_region_index;
+
+        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
+                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
+        assert(pcihp_region_index >= 0);
+    }
+
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
 
     return dev;
-- 
2.49.0


