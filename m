Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA29C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 04:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Fmi-0004wr-Aa; Mon, 28 Apr 2025 00:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9FiL-0004Ck-E1
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9FiG-0003fC-Gl
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:28 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxmnEK_g5oJf3HAA--.3345S3;
 Mon, 28 Apr 2025 12:03:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxvhsC_g5o63OaAA--.7484S10;
 Mon, 28 Apr 2025 12:03:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 8/8] hw/loongarch/virt: Allow user to customize OEM ID and OEM
 table ID
Date: Mon, 28 Apr 2025 12:03:13 +0800
Message-Id: <20250428040313.413822-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250428040313.413822-1-maobibo@loongson.cn>
References: <20250428040313.413822-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhsC_g5o63OaAA--.7484S10
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

On LoongArch virt machine, the default OEM ID and OEM table ID is
"BOCHS " and "BXPC    ". Here property x-oem-id and x-oem-table-id
is added on virt machine to set customized OEM ID and OEM table ID.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index aaaea64c4c..287d9e6f8c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -773,6 +773,48 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
 }
 
+static char *virt_get_oem_id(Object *obj, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    return g_strdup(lvms->oem_id);
+}
+
+static void virt_set_oem_id(Object *obj, const char *value, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    size_t len = strlen(value);
+
+    if (len > 6) {
+        error_setg(errp,
+                   "User specified oem-id value is bigger than 6 bytes in size");
+        return;
+    }
+
+    strncpy(lvms->oem_id, value, 6);
+}
+
+static char *virt_get_oem_table_id(Object *obj, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    return g_strdup(lvms->oem_table_id);
+}
+
+static void virt_set_oem_table_id(Object *obj, const char *value,
+                                  Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    size_t len = strlen(value);
+
+    if (len > 8) {
+        error_setg(errp,
+                   "User specified oem-table-id value is bigger than 8 bytes in size");
+        return;
+    }
+    strncpy(lvms->oem_table_id, value, 8);
+}
+
 static void virt_initfn(Object *obj)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
@@ -1177,6 +1219,22 @@ static void virt_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
+    object_class_property_add_str(oc, "x-oem-id",
+                                  virt_get_oem_id,
+                                  virt_set_oem_id);
+    object_class_property_set_description(oc, "x-oem-id",
+                                          "Override the default value of field OEMID "
+                                          "in ACPI table header."
+                                          "The string may be up to 6 bytes in size");
+
+
+    object_class_property_add_str(oc, "x-oem-table-id",
+                                  virt_get_oem_table_id,
+                                  virt_set_oem_table_id);
+    object_class_property_set_description(oc, "x-oem-table-id",
+                                          "Override the default value of field OEM Table ID "
+                                          "in ACPI table header."
+                                          "The string may be up to 8 bytes in size");
 }
 
 static const TypeInfo virt_machine_types[] = {
-- 
2.43.5


