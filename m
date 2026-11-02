Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60F60716E8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VU3lBWUu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDr-0003Xy-Iy; Mon, 02 Nov 2026 09:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDQ-0003K5-Lw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDC-00005E-Ro
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGTsBjtMHTNvAauBjjuihyYYodKSv/JbP/LnVjGiib4=;
 b=VU3lBWUu5DTXTwRNf6TtQHkrOtsSO6VmDCWrz6TOZNXSaCzxDkC2YPNlNTge6HFNtRuVPV
 xXlC0vpLY7V+Y4inAW2APNRxkP3ITSDaH2i0AwPIkAet5JvjaBLs9vzgaSzPWJnge1GlZw
 lG7OJyFhsrhm2T2Kp74LfPucAUQ6Oj4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-7CYNUzsCPsauD3860NbzoQ-1; Mon,
 02 Nov 2026 09:40:34 -0500
X-MC-Unique: 7CYNUzsCPsauD3860NbzoQ-1
X-Mimecast-MFC-AGG-ID: 7CYNUzsCPsauD3860NbzoQ_1793630434
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F9819539A6; Mon,  2 Nov 2026 14:40:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5702C26C; Mon,  2 Nov 2026 14:40:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28C9D21E65E7; Mon, 02 Nov 2026 15:40:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 71/74] hw/i386: convert PCSouthBridgeOption to QAPI enum
Date: Mon,  2 Nov 2026 15:40:15 +0100
Message-ID: <20261102144018.3212223-72-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move PCSouthBridgeOption from a hand-rolled C enum to a proper QAPI
enum in qapi/machine.json.

This gives the x-south-bridge property a generated type_info with a
valid masked_name, so it appears in query-qmp-schema introspection and
the qapi-type field of qom-list-properties output.

The south_bridge/default_south_bridge fields change from const char *
to PCSouthBridgeOption, with an explicit mapping table from enum value
to QOM device type name.

Enum values are changed: "PIIX3"->"ppix3", "piix4-isa"->"piix4", this
is under a x-property, so shouldn't be a breaking change.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-54-armbru@redhat.com>
---
 qapi/machine.json    | 13 +++++++++++
 include/hw/i386/pc.h |  4 ++--
 hw/i386/pc_piix.c    | 52 +++++++++++---------------------------------
 3 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2ee7055dcd..18d9dce849 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -416,6 +416,19 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
 
+##
+# @PCSouthBridgeOption:
+#     South bridge chipset option for PC i440FX machines.
+#
+# @piix3: Intel PIIX3 (default)
+#
+# @piix4: Intel PIIX4
+#
+# Since: 11.2
+##
+{ 'enum': 'PCSouthBridgeOption',
+  'data': ['piix3', 'piix4'] }
+
 ##
 # @inject-nmi:
 #     Injects a Non-Maskable Interrupt (machine specific: for example
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8edec62a1a..3afd376116 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -47,7 +47,7 @@ typedef struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     SmbiosEntryPointType smbios_entry_point_type;
-    const char *south_bridge;
+    PCSouthBridgeOption south_bridge;
 
     bool acpi_build_enabled;
     bool wdat_enabled;
@@ -94,7 +94,7 @@ struct PCMachineClass {
 
     /* Device configuration: */
     bool pci_enabled;
-    const char *default_south_bridge;
+    PCSouthBridgeOption default_south_bridge;
 
     /* Compat options: */
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ae07e6c56c..20bd4231c1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -47,6 +47,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/vfio/types.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qemu/error-report.h"
 #include "system/xen.h"
 #ifdef CONFIG_XEN
@@ -75,6 +76,11 @@ static GlobalProperty pc_piix_compat_defaults[] = {
 static const size_t pc_piix_compat_defaults_len =
     G_N_ELEMENTS(pc_piix_compat_defaults);
 
+static const char *pc_south_bridge_type[] = {
+    [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
+    [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
+};
+
 /*
  * Return the global irq number corresponding to a given device irq
  * pin. We could also use the bus number to have a more precise mapping.
@@ -236,7 +242,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
 
-    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    pci_dev = pci_new_multifunction(-1,
+                                    pc_south_bridge_type[pcms->south_bridge]);
     object_property_set_bool(OBJECT(pci_dev), "has-usb",
                              machine_usb(machine), &error_abort);
     object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -317,51 +324,18 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 }
 
-typedef enum PCSouthBridgeOption {
-    PC_SOUTH_BRIDGE_OPTION_PIIX3,
-    PC_SOUTH_BRIDGE_OPTION_PIIX4,
-    PC_SOUTH_BRIDGE_OPTION_MAX,
-} PCSouthBridgeOption;
-
-static const QEnumLookup PCSouthBridgeOption_lookup = {
-    .array = (const char *const[]) {
-        [PC_SOUTH_BRIDGE_OPTION_PIIX3] = TYPE_PIIX3_DEVICE,
-        [PC_SOUTH_BRIDGE_OPTION_PIIX4] = TYPE_PIIX4_PCI_DEVICE,
-    },
-    .size = PC_SOUTH_BRIDGE_OPTION_MAX
-};
-
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    int i;
 
-    for (i = 0; i < PCSouthBridgeOption_lookup.size; i++) {
-        if (g_strcmp0(PCSouthBridgeOption_lookup.array[i],
-                      pcms->south_bridge) == 0) {
-            return i;
-        }
-    }
-
-    error_setg(errp, "Invalid south bridge value set");
-    return 0;
+    return pcms->south_bridge;
 }
 
 static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    if (value < 0) {
-        error_setg(errp, "Value can't be negative");
-        return;
-    }
-
-    if (value >= PCSouthBridgeOption_lookup.size) {
-        error_setg(errp, "Value too big");
-        return;
-    }
-
-    pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
+    pcms->south_bridge = value;
 }
 
 #ifdef CONFIG_XEN
@@ -398,7 +372,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     ObjectClass *oc = OBJECT_CLASS(m);
-    pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
+    pcmc->default_south_bridge = PC_SOUTH_BRIDGE_OPTION_PIIX3;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -414,8 +388,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
     object_class_property_add_enum(oc, "x-south-bridge",
-                                   "PCSouthBridgeOption", NULL,
-                                   &PCSouthBridgeOption_lookup,
+                                   "PCSouthBridgeOption",
+                                   &PCSouthBridgeOption_type_info, NULL,
                                    pc_get_south_bridge,
                                    pc_set_south_bridge);
     object_class_property_set_description(oc, "x-south-bridge",
-- 
2.55.0


