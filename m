Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BB8CA1016
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9IW-0004yD-D2; Thu, 04 Sep 2025 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uu9IS-0004wF-4X
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uu9IC-0007ux-5Z
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxB9Efiblo76kGAA--.13877S3;
 Thu, 04 Sep 2025 20:42:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOQbiblo4QJ+AA--.6028S4;
 Thu, 04 Sep 2025 20:42:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v6 02/11] hw/loongarch: add virt feature avecintc support
Date: Thu,  4 Sep 2025 20:18:31 +0800
Message-Id: <20250904121840.2023683-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250904121840.2023683-1-gaosong@loongson.cn>
References: <20250904121840.2023683-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOQbiblo4QJ+AA--.6028S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Avecintc feature is added in LoongArchVirtMachinState, and it is used
to check whether virt machine supports the advanced interrupt controller
and by default set avecintc with ON_OFF_AUTO_ON.
LoongArchVirtMachineState adds misc_feature and misc_status for misc
features and status. and set the default avec feature bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/loongarch/virt.h | 14 ++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b15ada2078..1a2aa92c25 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -47,6 +47,27 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
 
+static void virt_get_avecintc(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    OnOffAuto avecintc = lvms->avecintc;
+
+    visit_type_OnOffAuto(v, name, &avecintc, errp);
+
+}
+static void virt_set_avecintc(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
+    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
+        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
+        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
+    }
+}
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -846,6 +867,9 @@ static void virt_initfn(Object *obj)
     if (tcg_enabled()) {
         lvms->veiointc = ON_OFF_AUTO_OFF;
     }
+
+    lvms->misc_feature = BIT(IOCSRF_AVEC);
+    lvms->avecintc = ON_OFF_AUTO_ON;
     lvms->acpi = ON_OFF_AUTO_AUTO;
     lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1238,6 +1262,12 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
+    if (tcg_enabled()) {
+        object_class_property_add(oc, "avecintc", "OnOffAuto",
+            virt_get_avecintc, virt_set_avecintc, NULL, NULL);
+        object_class_property_set_description(oc, "avecintc",
+                                "Enable Advance Interrupt Controller.");
+    }
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 7120b46714..68b8e92e99 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -23,6 +23,7 @@
 #define IOCSRF_DVFSV1           7
 #define IOCSRF_GMOD             9
 #define IOCSRF_VM               11
+#define IOCSRF_AVEC             15
 
 #define VERSION_REG             0x0
 #define FEATURE_REG             0x8
@@ -31,6 +32,7 @@
 #define MISC_FUNC_REG           0x420
 #define IOCSRM_EXTIOI_EN        48
 #define IOCSRM_EXTIOI_INT_ENCODE 49
+#define IOCSRM_AVEC_EN          51
 
 #define LOONGARCH_MAX_CPUS      256
 
@@ -69,6 +71,7 @@ struct LoongArchVirtMachineState {
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
     OnOffAuto    veiointc;
+    OnOffAuto    avecintc;
     char         *oem_id;
     char         *oem_table_id;
     DeviceState  *acpi_ged;
@@ -84,6 +87,8 @@ struct LoongArchVirtMachineState {
     DeviceState *extioi;
     struct memmap_entry *memmap_table;
     unsigned int memmap_entries;
+    uint64_t misc_feature;
+    uint64_t misc_status;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
@@ -91,6 +96,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
+static inline bool virt_has_avecintc(LoongArchVirtMachineState *lvms)
+{
+    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
+        return false;
+    }
+
+    return true;
+}
+
 static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->veiointc == ON_OFF_AUTO_OFF) {
-- 
2.41.0


