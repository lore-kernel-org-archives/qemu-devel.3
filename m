Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F327C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEWm-0003uA-MK; Mon, 14 Jul 2025 04:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEFM-0000I9-66
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEFK-0003a5-93
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JihmFsxw3YriVGhTrx7l+dAmY3uhQ90SKFGU3WE1/Jw=;
 b=eVIXMtY0CcdI7EKxP6En5qRl/LfAqv4ngSEc0HBo36b5nHVQNEjKRpEzb7IB/ZInICIxoC
 R13QmQTY8dSdAiIs3EEY5bSuwTQ8WrfInS4CcDTgYn6ISGBpNGtY+lsgvZarRRNZIy43ps
 NLhOmnyUBnlUSIsisMAV8R/tTFCcBo4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-6fC7nFyEMy2mQJiX-KyC7Q-1; Mon,
 14 Jul 2025 04:09:05 -0400
X-MC-Unique: 6fC7nFyEMy2mQJiX-KyC7Q-1
X-Mimecast-MFC-AGG-ID: 6fC7nFyEMy2mQJiX-KyC7Q_1752480544
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 630F618089B7; Mon, 14 Jul 2025 08:09:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 158B11977000; Mon, 14 Jul 2025 08:08:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 27/36] hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
Date: Mon, 14 Jul 2025 10:05:11 +0200
Message-ID: <20250714080639.2525563-28-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Let pass the root bus to ich9 and piix4 through a property link
instead of through an argument passed to acpi_pcihp_init().

Also make sure the root bus is set at the entry of acpi_pcihp_init().

The rationale of that change is to be consistent with the forecoming ARM
implementation where the machine passes the root bus (steming from GPEX)
to the GED device through a link property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/pcihp.h         | 2 +-
 hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
 hw/acpi/ich9.c                  | 7 ++++++-
 hw/acpi/pcihp.c                 | 4 ++--
 hw/acpi/piix4.c                 | 5 ++++-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 9ff548650b..ca6a258825 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -62,7 +62,7 @@ typedef struct AcpiPciHpState {
     bool use_acpi_root_pci_hotplug;
 } AcpiPciHpState;
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *,
                      MemoryRegion *io, uint16_t io_base);
 
 bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index b7bc6e40a1..d58ea726a8 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -4,7 +4,7 @@
 
 const VMStateDescription vmstate_acpi_pcihp_pci_status;
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
                      MemoryRegion *address_space_io, uint16_t io_base)
 {
 }
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 967b67485e..2b3b493c01 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -322,9 +322,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     }
 
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
+        object_property_set_link(OBJECT(lpc_pci), "bus",
+                                 OBJECT(pci_get_bus(lpc_pci)), &error_abort);
         acpi_pcihp_init(OBJECT(lpc_pci),
                         &pm->acpi_pci_hotplug,
-                        pci_get_bus(lpc_pci),
                         pci_address_space_io(lpc_pci),
                         ACPI_PCIHP_ADDR_ICH9);
 
@@ -428,6 +429,10 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
+    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
+                             (Object **)&pm->acpi_pci_hotplug.root,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, pm);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index f1594e664a..4922bbc778 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -493,13 +493,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
     },
 };
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
                      MemoryRegion *io, uint16_t io_base)
 {
     s->io_len = ACPI_PCIHP_SIZE;
     s->io_base = io_base;
 
-    s->root = root_bus;
+    assert(s->root);
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index d98b80df6d..7a18f18dda 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -567,7 +567,8 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
 
     if (s->acpi_pci_hotplug.use_acpi_hotplug_bridge ||
         s->acpi_pci_hotplug.use_acpi_root_pci_hotplug) {
-        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+        object_property_set_link(OBJECT(s), "bus", OBJECT(bus), &error_abort);
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, parent,
                         ACPI_PCIHP_ADDR_PIIX4);
         qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
     }
@@ -611,6 +612,8 @@ static const Property piix4_pm_properties[] = {
                      acpi_pci_hotplug.use_acpi_hotplug_bridge, true),
     DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCI_ROOTHP, PIIX4PMState,
                      acpi_pci_hotplug.use_acpi_root_pci_hotplug, true),
+    DEFINE_PROP_LINK("bus", PIIX4PMState, acpi_pci_hotplug.root,
+                     TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_BOOL("smm-compat", PIIX4PMState, smm_compat, false),
-- 
2.49.0


