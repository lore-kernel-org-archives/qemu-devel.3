Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD949C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJp1A-0006fE-NP; Tue, 27 May 2025 03:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoyh-0001xr-2Q
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoyZ-0000Lu-3g
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynMjCFkKq4avL2xQUuTd4QN6DUjSo6c9gEotr/SPDLI=;
 b=IfYx3o6HsDn5/dGyfMeKr8SUZ17cIvwO3pBPzOVy1QsMMUQuy0yhTM2bfXS5SG+r7TacdI
 eLXrPsIAkYqpskriM+7j/F6XE98B8mXNLZAXLRE648j7LjQs500r8v/X9/ePeR6nMx6hkK
 K0AQEGk9vYb7r4ZSUtiaiq13bn53pXI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-SiwzEGkCPN28ABHyCD0f0A-1; Tue,
 27 May 2025 03:43:50 -0400
X-MC-Unique: SiwzEGkCPN28ABHyCD0f0A-1
X-Mimecast-MFC-AGG-ID: SiwzEGkCPN28ABHyCD0f0A_1748331829
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E168E1800373; Tue, 27 May 2025 07:43:48 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C1AA19560AA; Tue, 27 May 2025 07:43:44 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 15/25] hw/i386/acpi-build: Introduce and use
 acpi_get_pci_host
Date: Tue, 27 May 2025 09:40:17 +0200
Message-ID: <20250527074224.1197793-16-eric.auger@redhat.com>
In-Reply-To: <20250527074224.1197793-1-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

pcihp acpi_set_pci_info() generic code currently uses
acpi_get_i386_pci_host() to retrieve the pci host bridge.

Let's rename acpi_get_i386_pci_host into acpi_get_pci_host and
move it in pci generic code.

The helper is augmented with the support of ARM GPEX.

Also instead of using the machine child property to retrieve
the PCI host bridge, we search for the actual object type using
object_resolve_type_unambiguous().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

---

v1 -> v2
- described the fact we changed the implementation of
  acpi_get_pci_host() in the commit msg.
---
 include/hw/acpi/pci.h |  2 ++
 hw/acpi/pci.c         | 20 ++++++++++++++++++++
 hw/acpi/pcihp.c       |  3 ++-
 hw/i386/acpi-build.c  | 24 ++++--------------------
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 4dca22c0e2..310cbd02db 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -41,4 +41,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 
 void build_srat_generic_affinity_structures(GArray *table_data);
 
+Object *acpi_get_pci_host(void);
+
 #endif
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index d511a85029..4191886ebe 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
+#include "qom/object.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/acpi/aml-build.h"
@@ -33,6 +34,9 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/pci-host/i440fx.h"
+#include "hw/pci-host/q35.h"
+#include "hw/pci-host/gpex.h"
 
 /*
  * PCI Firmware Specification, Revision 3.0
@@ -301,3 +305,19 @@ void build_srat_generic_affinity_structures(GArray *table_data)
     object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
                                    table_data);
 }
+
+Object *acpi_get_pci_host(void)
+{
+    Object *host;
+
+    host = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE, NULL);
+    if (host) {
+        return host;
+    }
+    host = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
+    if (host) {
+        return host;
+    }
+    host = object_resolve_type_unambiguous(TYPE_GPEX_HOST, NULL);
+    return host;
+}
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 942669ea89..d800371ddc 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -36,6 +36,7 @@
 #include "hw/pci-bridge/xio3130_downstream.h"
 #include "hw/i386/acpi-build.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -102,7 +103,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 static void acpi_set_pci_info(bool has_bridge_hotplug)
 {
     static bool bsel_is_set;
-    Object *host = acpi_get_i386_pci_host();
+    Object *host = acpi_get_pci_host();
     PCIBus *bus;
     BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
                       .has_bridge_hotplug = has_bridge_hotplug };
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fe8bc62c03..6feb99e9eb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -269,27 +269,11 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
 #endif
 }
 
-/*
- * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
- * On i386 arch we only have two pci hosts, so we can look only for them.
- */
-Object *acpi_get_i386_pci_host(void)
-{
-    PCIHostState *host;
-
-    host = PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx", NULL));
-    if (!host) {
-        host = PCI_HOST_BRIDGE(object_resolve_path("/machine/q35", NULL));
-    }
-
-    return OBJECT(host);
-}
-
 static void acpi_get_pci_holes(Range *hole, Range *hole64)
 {
     Object *pci_host;
 
-    pci_host = acpi_get_i386_pci_host();
+    pci_host = acpi_get_pci_host();
 
     if (!pci_host) {
         return;
@@ -1245,7 +1229,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     sb_scope = aml_scope("\\_SB");
     {
-        Object *pci_host = acpi_get_i386_pci_host();
+        Object *pci_host = acpi_get_pci_host();
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
@@ -1306,7 +1290,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
         bool has_pcnt;
 
-        Object *pci_host = acpi_get_i386_pci_host();
+        Object *pci_host = acpi_get_pci_host();
         PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
 
         scope = aml_scope("\\_SB.PCI0");
@@ -1946,7 +1930,7 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
     Object *pci_host;
     QObject *o;
 
-    pci_host = acpi_get_i386_pci_host();
+    pci_host = acpi_get_pci_host();
     if (!pci_host) {
         return false;
     }
-- 
2.49.0


