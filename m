Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24ADC71157
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 03:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5YQ-00073W-4p; Wed, 18 Jun 2025 23:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5YK-00072S-7n
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YG-00069D-Go
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:02:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxrOLafVNos44ZAQ--.17418S3;
 Thu, 19 Jun 2025 11:02:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S4;
 Thu, 19 Jun 2025 11:02:46 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 2/9] loongarch: add virt feature avecintc support
Date: Thu, 19 Jun 2025 10:39:37 +0800
Message-Id: <20250619023944.1278716-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S4
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

LoongArchVirtMachinState add  avecintc features, and
it use to check whether virt machine support advance interrupt controller
and default set avecintc = ON_OFF_AUTO_ON.
LoongArchVirtMachineState add misc_feature and misc_status for
misc fetures and status. and set default avec feture bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c         | 43 +++++++++++++++++++++++++++++++++----
 include/hw/loongarch/virt.h | 15 +++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 90d4643721..3ad165af36 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -47,6 +47,28 @@
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
+    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
+        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
+        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
+    }
+
+    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
+}
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -523,6 +545,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
         }
 
+        if (val & BIT(IOCSRM_AVEC_EN)) {
+            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
+        }
+
         address_space_stl(&lvms->as_iocsr,
                           EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
                           features, attrs, NULL);
@@ -548,8 +574,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
-        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
-        ret |= BIT(IOCSRF_AVEC);
+        if (virt_is_avecintc_enabled(lvms)) {
+            ret |= BIT(IOCSRF_AVEC);
+        }
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
@@ -575,8 +602,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
         }
-        /* enable avec default */
-        ret |= BIT_ULL(IOCSRM_AVEC_EN);
+        if (virt_is_avecintc_enabled(lvms) &&
+            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
+            ret |= BIT_ULL(IOCSRM_AVEC_EN);
+        }
         break;
     default:
         g_assert_not_reached();
@@ -820,6 +849,8 @@ static void virt_initfn(Object *obj)
     if (tcg_enabled()) {
         lvms->veiointc = ON_OFF_AUTO_OFF;
     }
+    lvms->misc_feature = BIT(IOCSRF_AVEC);
+    lvms->avecintc = ON_OFF_AUTO_ON;
     lvms->acpi = ON_OFF_AUTO_AUTO;
     lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1212,6 +1243,10 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
+    object_class_property_add(oc, "avecintc", "OnOffAuto",
+        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
+    object_class_property_set_description(oc, "avecintc",
+                            "Enable Advance Interrupt Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 671b47a986..c594421cd2 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -70,6 +70,7 @@ struct LoongArchVirtMachineState {
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
     OnOffAuto    veiointc;
+    OnOffAuto    avecintc;
     char         *oem_id;
     char         *oem_table_id;
     DeviceState  *acpi_ged;
@@ -83,6 +84,8 @@ struct LoongArchVirtMachineState {
     struct loongarch_boot_info bootinfo;
     DeviceState *ipi;
     DeviceState *extioi;
+    uint64_t misc_feature;
+    uint64_t misc_status;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
@@ -90,6 +93,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
+static inline bool virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
+{
+    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
+        return false;
+    }
+
+    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    return true;
+}
+
 static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->veiointc == ON_OFF_AUTO_OFF) {
-- 
2.34.1


