Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB88C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54JY-0007SW-Ky; Fri, 11 Sep 2026 12:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JL-0007Gc-PU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JK-0007Ka-07
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVgRY8FyaQprluWH3eLEEY/EI8+otfrYvvNCkmcu2Fc=;
 b=GCeqa86GZwrQ8XwciHI9wumPhqRSc7RgQj4VjKXhFOO5It8+cTR2Lrw0MHb6TRJ6qeUZ0B
 hOWBs1pgSnMJxkVTUgMoWzcPCaqHrbj46oMxTuIdCtiEth+gucce3FL3P9yceom3LzopNI
 HDWKNxY6gCX8TswbOC4GGYmVK+nnDS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-_ix4OLAoMtG5NQpNmp0J3Q-1; Fri,
 11 Sep 2026 12:41:04 -0400
X-MC-Unique: _ix4OLAoMtG5NQpNmp0J3Q-1
X-Mimecast-MFC-AGG-ID: _ix4OLAoMtG5NQpNmp0J3Q_1789144863
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F50A1800878; Fri, 11 Sep 2026 16:41:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44A4B195608F; Fri, 11 Sep 2026 16:41:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:32 +0400
Subject: [PATCH v5 58/62] hw/i386: convert PCSouthBridgeOption to QAPI enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-58-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5406;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5rbqnyzNuiXenxsxKA8MfQROzgQKdBBd23brPgSs/+E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC28vXlJv2zre6b7UdoE76qkLrgft1D6noCGX
 fZVYHvt79OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvAAKCRDa6OEJdZac
 5VRfD/9Q0lgr/An4VKLgcVVFIGOPtQDlQeJc2LMJd/DmN4lAclKwc3Tm2FKPvpute0GRVqWIswM
 vWAoG825/wt9y7G4F/UCku3EmBGdbHCPheCRZRs7Fcb+Q2fTqOebuXdnAB2FtKWD1AUmPQMVour
 DCM/pi19X2Mny/6v3bZK2dbw/SbN0BO/DS0FR2LSeg9MLU1mGpQLINeGv5T3gZEBFwayi6tkYyr
 27HxeLMCdS4xxj4M4oGEb7hlJCb0sJZEGJGMzjjDF2S1AYt9u5P4iABhb3qMUqWxf2R9IFMhRYA
 dmYvr0P6sTPzti4nvjIGM4ADBWVzS7vN5nyCU+2T22kmRZKoltLr1O8M7lRt9m+86sR0kJd45kR
 1bLGYthtQdOdFGCRarQb8ZMz54NoeMRjVn3w9b8F3R5Oirjo8qTM7pg0zvVTcp70ete6inYcISB
 ysqfEp9bfzbEAGySqg43taxy2FBYbNVlcxoyIJjw0Ywmrsg/Y2e+rhwHfCNuNxHHhpjazlv8dn1
 RUBqq28YkgmnsrcmF7PEjK/63c2GWENozodwiQU0HoBqmCqu2kt+fifnKXe2aYkoKKWdWciNRoM
 5G7lgTAqLz3nz1+gS2/LHb43PJKXa+Hwa9g0xfu0eSWlmD/EbklfqT1Xp5K0zuZbVaqoQMoNej9
 mul7aKC9T5ViGBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move PCSouthBridgeOption from a hand-rolled C enum with a manually
constructed QAPITypeInfo to a proper QAPI enum in qapi/machine.json.

This gives the x-south-bridge property a generated type_info with a
valid masked_name, so it appears in query-qmp-schema introspection and
the qapi-type field of qom-list-properties output.

The south_bridge/default_south_bridge fields change from const char *
to PCSouthBridgeOption, with an explicit mapping table from enum value
to QOM device type name.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc_piix.c    | 53 +++++++++++-----------------------------------------
 include/hw/i386/pc.h |  4 ++--
 qapi/machine.json    | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 44 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dac2bee88a2e..02d0f2917705 100644
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
@@ -322,56 +329,18 @@ static void pc_init1(MachineState *machine, const char *pci_type)
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
-static const QAPITypeInfo PCSouthBridgeOption_type_info = {
-    .name = "PCSouthBridgeOption",
-    .lookup = &PCSouthBridgeOption_lookup,
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
@@ -408,7 +377,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     ObjectClass *oc = OBJECT_CLASS(m);
-    pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
+    pcmc->default_south_bridge = PC_SOUTH_BRIDGE_OPTION_PIIX3;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ac03da97b645..34806f16e6a6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -42,7 +42,7 @@ typedef struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     SmbiosEntryPointType smbios_entry_point_type;
-    const char *south_bridge;
+    PCSouthBridgeOption south_bridge;
 
     bool acpi_build_enabled;
     bool wdat_enabled;
@@ -89,7 +89,7 @@ struct PCMachineClass {
 
     /* Device configuration: */
     bool pci_enabled;
-    const char *default_south_bridge;
+    PCSouthBridgeOption default_south_bridge;
 
     /* Compat options: */
 
diff --git a/qapi/machine.json b/qapi/machine.json
index 0e0d85d0a76d..28ecb969bdb6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -475,6 +475,20 @@
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
 #

-- 
2.55.0.543.g5ebe2ebe4ea8


