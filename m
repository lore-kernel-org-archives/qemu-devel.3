Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C143C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJCv-0008Ma-Lt; Thu, 03 Jul 2025 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXJCq-0008IE-0c
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uXJCn-0000GO-Qe
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751546300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLaMDFzZjY+u32IAfNjad79BEhlHi5t75wvKla/0++E=;
 b=MI3H2VIDNeZGmNMNy2MQOKxwo3Se+Poj5brFi8MVZb13CJ9L2kyzZriEovivoQwouT7DTu
 cVXei5J68mu0Zhl7kMiqafb/o++rVgT9ETDphxR5DjFJu5dXQmNljF7AeqCHY39bmik7ri
 ETswqzEGxdQCXs5gkyPjVE5MPN6pBOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-ply-y_rsNhOiy-YRWybOWQ-1; Thu,
 03 Jul 2025 08:38:15 -0400
X-MC-Unique: ply-y_rsNhOiy-YRWybOWQ-1
X-Mimecast-MFC-AGG-ID: ply-y_rsNhOiy-YRWybOWQ_1751546294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517BC18002E4; Thu,  3 Jul 2025 12:38:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59159180045C; Thu,  3 Jul 2025 12:38:09 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v5 07/36] hw/pci-host/gpex-acpi: Use GED acpi pcihp property
Date: Thu,  3 Jul 2025 14:35:07 +0200
Message-ID: <20250703123728.414386-8-eric.auger@redhat.com>
In-Reply-To: <20250703123728.414386-1-eric.auger@redhat.com>
References: <20250703123728.414386-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Retrieve the acpi pcihp property value from the ged. In case this latter
is not set, PCI native hotplug is used on pci0. For expander bridges we
keep pci native hotplug, as done on x86 q35.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---
v4 -> v5:
- check vms->acpi_dev

v3 -> v4:
- Use object_property_get_bool (Igor)
- rework the commit description (Igor)

v2 -> v3:
- don'use the virt arm machine option anymore.
---
 include/hw/pci-host/gpex.h | 1 +
 hw/arm/virt-acpi-build.c   | 9 +++++++++
 hw/pci-host/gpex-acpi.c    | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 84471533af..feaf827474 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -45,6 +45,7 @@ struct GPEXConfig {
     MemMapEntry pio;
     int         irq;
     PCIBus      *bus;
+    bool        pci_native_hotplug;
 };
 
 typedef struct GPEXIrq GPEXIrq;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cd90c47976..a2f31be9ec 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -123,12 +123,21 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
+    bool acpi_pcihp = false;
+
+    if (vms->acpi_dev) {
+        acpi_pcihp = object_property_get_bool(OBJECT(vms->acpi_dev),
+                                              ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                                              NULL);
+    }
+
     struct GPEXConfig cfg = {
         .mmio32 = memmap[VIRT_PCIE_MMIO],
         .pio    = memmap[VIRT_PCIE_PIO],
         .ecam   = memmap[ecam_id],
         .irq    = irq,
         .bus    = vms->bus,
+        .pci_native_hotplug = !acpi_pcihp,
     };
 
     if (vms->highmem_mmio) {
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 80fc2bf032..44737a8d81 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -203,6 +203,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             if (is_cxl) {
                 build_cxl_osc_method(dev);
             } else {
+                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
                 acpi_dsdt_add_host_bridge_methods(dev, true);
             }
 
@@ -278,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_host_bridge_methods(dev, true);
+    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
2.49.0


