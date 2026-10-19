Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E840CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoE3-0002c8-Ft; Mon, 19 Oct 2026 10:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDV-0002IM-Ny
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDQ-0005f0-Fo
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ87omd5qDWm4tQlac7JSaW7qn7N7ypnccf6z65OESc=;
 b=FidgNE6FTNVpiKM5OxHPvJMXi77W1OTWEODL24CK7QENnHKjYivyKOoo1ifyOpfR0FMgCb
 pH0KhZBfZ6ob31EBlgeQYTNqDsDnHmmD6GFXHvWInEvTBTatNZCvokWmCcx1WFOwek/qbe
 RCdkofJL7/5ohDHto7vVmGhuHGF/8TY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-6pTem5UfM8qrEW6Q_V4Uxg-1; Mon,
 19 Oct 2026 14:19:46 +0000
X-MC-Unique: 6pTem5UfM8qrEW6Q_V4Uxg-1
X-Mimecast-MFC-AGG-ID: 6pTem5UfM8qrEW6Q_V4Uxg_1792419584
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA421954ADD; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EDCB362; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D97521E662A; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 62/65] hw/i386: convert PCSouthBridgeOption to QAPI enum
Date: Mon, 19 Oct 2026 16:19:26 +0200
Message-ID: <20261019141929.1594337-63-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move PCSouthBridgeOption from a hand-rolled C enum to a proper QAPI
enum in qapi/machine.json.

This gives the x-south-bridge property a generated type_info with a
valid masked_name, so it appears in query-qmp-schema introspection and
the qapi-type field of qom-list-properties output.

The south_bridge/default_south_bridge fields change from const char *
to PCSouthBridgeOption, with an explicit mapping table from enum value
to QOM device type name.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json    | 14 ++++++++++
 include/hw/i386/pc.h |  4 +--
 hw/i386/pc_piix.c    | 61 +++++++++++++-------------------------------
 3 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 46b6935ab0..cc028e890a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -462,6 +462,20 @@
 { 'enum': 'Pca9554PinState',
   'data': ['low', 'high'] }
 
+##
+# @PCSouthBridgeOption:
+#
+# South bridge chipset option for PC i440FX machines.
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
index 63c4667ea3..5a94a34166 100644
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
 
@@ -413,12 +387,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
-    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
-                                   &PCSouthBridgeOption_lookup,
-                                   pc_get_south_bridge,
-                                   pc_set_south_bridge);
-    object_class_property_set_description(oc, "x-south-bridge",
-                                     "Use a different south bridge than PIIX3");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "x-south-bridge",
+        .description = "Use a different south bridge than PIIX3",
+        .qapi_type = &PCSouthBridgeOption_type_info,
+        .get = pc_get_south_bridge,
+        .set = pc_set_south_bridge,
+    ));
     compat_props_add(m->compat_props,
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
-- 
2.55.0


