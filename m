Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3840C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4d-0000qt-UK; Fri, 04 Sep 2026 15:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4c-0000gi-GE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4a-0007yU-IW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqfpP6+T+mMqhutT80shj/MSxHjc1FnuwFPkDl4SbWs=;
 b=I9+vYnXsLU/QLq3QQN+p7kB5hth6W3gHyXIzyu3+aUYXEWbXW76RXJjymRgCELUpnk4eJ9
 fkbCK+BtnmdZS1xVVZpC9X5euBd1TYBGPe1G374vQvkyBAaM0oJ5m+lns+UCYQ/3VL1TbI
 +2hDMEyAskoH3hcpBauZHXovD+NeKgk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-JIu4yjkJMymrp4svugnFew-1; Fri,
 04 Sep 2026 15:59:35 -0400
X-MC-Unique: JIu4yjkJMymrp4svugnFew-1
X-Mimecast-MFC-AGG-ID: JIu4yjkJMymrp4svugnFew_1788551974
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF7D18417EC; Fri,  4 Sep 2026 19:59:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3C941800641; Fri,  4 Sep 2026 19:59:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:06 +0400
Subject: [PATCH v4 23/75] loongarch/virt: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-23-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5919;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nfckD088YpF8IH5Vqc/iq59Hc1wNBUsrHYJUB8Qf1+k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJ8T9hniZpQApVkllZEeIrLOQt5C7ofpB1Z
 lCzqYAR7gqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5S9aD/4p19jVcvCIQe4kIQkbvOcs/WlGqDgUQy6a+OwLZFHvYOU0mEwvUWQ9cQjuDNgHDE/9jJl
 plYhn8oybZXbwvFpgjSZPfAQkIXyWqdDGJgKuMhOnXpqFaIOAiiK9b1BII6QXRD+7acEjztUu9J
 /aJsnMrD3InEVO0/uROBFhkBDej05OQmjEfjKwWNxNMyc8RJYLrLSzAwzW8yYg5XTKeiBgeUL+3
 JGeGV6rIMyekzqVlqW8xukFVjkUjI1oQGqefSJDEfrZnAolkZUjwxKulB+qhJtbSgxhHNRzJ+96
 AWN/jzP/Duv3APRvbhFtcpguQzNsYs93y/Yzr0HxortYqIko6AR6qzA5Gyv09WZ+A6/vfpJ8p90
 +byDAXQtB6yjlbMhi1coxpZqG4XyU610lmlXOQvpemw93sg0Vqc4hPjIIG5OR988VKQUv/7F7A1
 QZolEBnI0ct6iUtrmJgYNiZH/4G8GLSw7J0T91K0cH2UwxAoBIBTUWkVAkCTUsR8Y5XDZhwjHji
 h5mvkOIwV+hBrOiv/PjZgOHbaJmvXKLndVcMEdCZzzenYVfMujdd3f0+41avKi17/yPmjmHDNC7
 JqL5PYXwFO6c5DPGVbOdUPgMti/j+Zr1u9mwaOYxONxUnfRVbGSvIB/IuFLe4PVXjv+zo/meE/Y
 cbk+V+x/JL2fLCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Convert the acpi, v-eiointc, and dmsi OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/loongarch/virt.c | 85 +++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9cc79929a8ab..750ce2dbe5fc 100644
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
2.55.0.543.g5ebe2ebe4ea8


