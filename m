Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98338CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDc-0002Mo-Es; Mon, 19 Oct 2026 10:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0002Cb-OF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDG-0005ZA-Qt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlqeAsA8FoWKhgIqpk5bwLZhp8HNRhIN4kCaE3cqN0k=;
 b=TP1dhRfura5D8uYs1h51NpzVzddyYarCrMTyMmQZVHuv04e9z8Tj/RCP5pmBbWoiDNMlv6
 h/7nwy7tYf21adhvdI4DDCf8ri4ascn8Jk48mK3p2pN2HFB8jP4MhdGhfYEy5TTrsFKXDo
 0E1WOqTlqHszDKfL3+8H1NSHqDQSFQw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-G2GXbc9LMtuewHLcVgUrVw-1; Mon,
 19 Oct 2026 14:19:40 +0000
X-MC-Unique: G2GXbc9LMtuewHLcVgUrVw-1
X-Mimecast-MFC-AGG-ID: G2GXbc9LMtuewHLcVgUrVw_1792419579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90B3E1954206; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF40195607F; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2F0721E689E; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com, Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v6 26/65] loongarch/virt: convert OnOffAuto properties to
 QAPI-aware registration
Date: Mon, 19 Oct 2026 16:18:50 +0200
Message-ID: <20261019141929.1594337-27-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Convert the acpi, v-eiointc, and dmsi OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/loongarch/virt.c | 85 +++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9d..db8ea76f11 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -36,7 +36,8 @@
 #include "target/loongarch/cpu.h"
 #include "target/loongarch/cpu-mmu.h"
 #include "hw/firmware/smbios.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/core/platform-bus.h"
@@ -51,26 +52,21 @@
 #include "qemu/log.h"
 #include "kvm/kvm_loongarch.h"
 
-static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
+static int virt_get_dmsi(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto dmsi = lvms->dmsi;
-
-    visit_type_OnOffAuto(v, name, &dmsi, errp);
-
+    return lvms->dmsi;
 }
-static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+
+static void virt_set_dmsi(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    lvms->dmsi = value;
 
-    visit_type_OnOffAuto(v, name, &lvms->dmsi, errp);
-
-    if (lvms->dmsi == ON_OFF_AUTO_OFF) {
+    if (value == ON_OFF_AUTO_OFF) {
         lvms->misc_feature &= ~BIT(IOCSRF_DMSI);
         lvms->misc_status &= ~BIT_ULL(IOCSRM_DMSI_EN);
-    } else if (lvms->dmsi == ON_OFF_AUTO_ON) {
+    } else if (value == ON_OFF_AUTO_ON) {
         lvms->misc_feature = BIT(IOCSRF_DMSI);
     }
 }
@@ -78,21 +74,16 @@ static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 64
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
 
-static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+static int virt_get_veiointc(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto veiointc = lvms->veiointc;
-
-    visit_type_OnOffAuto(v, name, &veiointc, errp);
+    return lvms->veiointc;
 }
 
-static void virt_set_veiointc(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+static void virt_set_veiointc(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &lvms->veiointc, errp);
+    lvms->veiointc = value;
 }
 
 static bool virt_get_highmem_mmio(Object *obj, Error **errp)
@@ -1025,21 +1016,16 @@ static void virt_init(MachineState *machine)
     loongarch_load_kernel(machine, &lvms->bootinfo, phys_addr_mask);
 }
 
-static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static int virt_get_acpi(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto acpi = lvms->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return lvms->acpi;
 }
 
-static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void virt_set_acpi(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
+    lvms->acpi = value;
 }
 
 static char *virt_get_oem_id(Object *obj, Error **errp)
@@ -1483,20 +1469,29 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = virt_device_unplug_request;
     hc->unplug = virt_device_unplug;
 
-    object_class_property_add(oc, "acpi", "OnOffAuto",
-        virt_get_acpi, virt_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, "acpi",
-        "Enable ACPI");
-    object_class_property_add(oc, "v-eiointc", "OnOffAuto",
-        virt_get_veiointc, virt_set_veiointc,
-        NULL, NULL);
-    object_class_property_set_description(oc, "v-eiointc",
-                            "Enable Virt Extend I/O Interrupt Controller.");
-    object_class_property_add(oc, "dmsi", "OnOffAuto",
-        virt_get_dmsi, virt_set_dmsi, NULL, NULL);
-    object_class_property_set_description(oc, "dmsi",
-                            "Enable direct Message-interrupts Controller.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "acpi",
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_acpi,
+        .set = virt_set_acpi,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "v-eiointc",
+        .description = "Enable Virt Extend I/O Interrupt Controller.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_veiointc,
+        .set = virt_set_veiointc,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "dmsi",
+        .description = "Enable direct Message-interrupts Controller.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_dmsi,
+        .set = virt_set_dmsi,
+    ));
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
-- 
2.55.0


