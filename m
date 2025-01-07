Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA39AE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBgL-0001fM-0I; Tue, 07 Jan 2025 10:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBg8-0001bH-H4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVBg6-0005lN-Fr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736264371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oms5RWxiSjkIU9AQhaOd854sk01PnwCnlIaXt2N+Kh0=;
 b=NcB8pvhXUtlqHRTUrgEqYwiY51HbW4QVj1xx2/JrypwZMnx9VpJ6hdmgwjxByHG5CQoK5o
 FZ4fT/t2oGhT/Mii36h852t/zebs8Uz2SpPpAGQ30UYKaD0bnxnThe9cnCwythwIM0rFve
 UnIbIEepmje/uUDheN+yBwwODAWAB8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-5k7VL-GXMnemsZ6KCOKRCw-1; Tue,
 07 Jan 2025 10:39:28 -0500
X-MC-Unique: 5k7VL-GXMnemsZ6KCOKRCw-1
X-Mimecast-MFC-AGG-ID: 5k7VL-GXMnemsZ6KCOKRCw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B82181954B24; Tue,  7 Jan 2025 15:39:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 728DA1956053; Tue,  7 Jan 2025 15:39:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BFD741800605; Tue, 07 Jan 2025 16:33:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, graf@amazon.com,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 19/21] hw/arm: add uefi variable support to virt machine
 type
Date: Tue,  7 Jan 2025 16:33:46 +0100
Message-ID: <20250107153353.1144978-20-kraxel@redhat.com>
In-Reply-To: <20250107153353.1144978-1-kraxel@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add -machine virt,x-uefi-vars={on,off} property.  Default is off.
When enabled wire up the uefi-vars-sysbus device.

TODO: wire up jsonfile property.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/arm/virt.h |  2 ++
 hw/arm/virt.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aedc9..393ea2cbec78 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -79,6 +79,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_UEFI_VARS,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -156,6 +157,7 @@ struct VirtMachineState {
     bool mte;
     bool dtb_randomness;
     bool second_ns_uart_present;
+    bool uefi_vars;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c55..6856ecb4dcf2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -65,6 +65,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/irq.h"
+#include "hw/uefi/var-service-api.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
 #include "hw/firmware/smbios.h"
@@ -181,6 +182,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
+    [VIRT_UEFI_VARS] =          { 0x090c0000, 0x00000010 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1369,6 +1371,24 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     return fw_cfg;
 }
 
+static void create_uefi_vars(const VirtMachineState *vms)
+{
+    hwaddr base = vms->memmap[VIRT_UEFI_VARS].base;
+    hwaddr size = vms->memmap[VIRT_UEFI_VARS].size;
+    MachineState *ms = MACHINE(vms);
+    char *nodename;
+
+    sysbus_create_simple("uefi-vars-sysbus", base, NULL);
+
+    nodename = g_strdup_printf("/%s@%" PRIx64, UEFI_VARS_FDT_NODE, base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
+                            "compatible", UEFI_VARS_FDT_COMPAT);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, base, 2, size);
+    g_free(nodename);
+}
+
 static void create_pcie_irq_map(const MachineState *ms,
                                 uint32_t gic_phandle,
                                 int first_irq, const char *nodename)
@@ -2425,6 +2445,10 @@ static void machvirt_init(MachineState *machine)
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
 
+    if (vms->uefi_vars) {
+        create_uefi_vars(vms);
+    }
+
     create_platform_bus(vms);
 
     if (machine->nvdimms_state->is_enabled) {
@@ -2621,6 +2645,20 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
     strncpy(vms->oem_table_id, value, 8);
 }
 
+static bool virt_get_uefi_vars(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->uefi_vars;
+}
+
+static void virt_set_uefi_vars(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->uefi_vars = value;
+}
+
 
 bool virt_is_acpi_enabled(VirtMachineState *vms)
 {
@@ -3273,6 +3311,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
+    object_class_property_add_bool(oc, "x-uefi-vars",
+                                   virt_get_uefi_vars,
+                                   virt_set_uefi_vars);
 }
 
 static void virt_instance_init(Object *obj)
-- 
2.47.1


