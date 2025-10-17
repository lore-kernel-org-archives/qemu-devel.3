Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E8DCCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eDp-00068F-2O; Fri, 17 Oct 2025 02:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v9eDf-000605-6o
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v9eDU-0003uV-Vp
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:45:42 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxb_AH5vFoRToXAA--.50516S3;
 Fri, 17 Oct 2025 14:45:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+QD5vFoHDntAA--.1225S7;
 Fri, 17 Oct 2025 14:45:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] hw/loongarch/virt: Add property highmem_mmio with virt
 machine
Date: Fri, 17 Oct 2025 14:45:21 +0800
Message-Id: <20251017064523.2065993-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251017064523.2065993-1-maobibo@loongson.cn>
References: <20251017064523.2065993-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+QD5vFoHDntAA--.1225S7
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

On LoongArch Virt Machine, MMIO region with GPEX host bridge is
0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough
for emulated virtio devices basically.

However on some conditions such as hostmem is added with virtio-gpu
device, the command line is -device virtio-gpu-gl,hostmem=4G. The
PCIE MMIO region is not enough, 64-bit high MMIO region is required.

Here add property highmem_mmio with virt machine, however it brings
out incompatible issue. Here the default value is false.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 21 +++++++++++++++++++++
 include/hw/loongarch/virt.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 01bd21dbab..b068f63d3f 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -89,6 +89,20 @@ static void virt_set_veiointc(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &lvms->veiointc, errp);
 }
 
+static bool virt_get_highmem_mmio(Object *obj, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    return lvms->highmem_mmio;
+}
+
+static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    lvms->highmem_mmio = value;
+}
+
 static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
@@ -1380,6 +1394,13 @@ static void virt_class_init(ObjectClass *oc, const void *data)
                                           "Override the default value of field OEM Table ID "
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
+
+    object_class_property_add_bool(oc, "highmem-mmio",
+                                   virt_get_highmem_mmio,
+                                   virt_set_highmem_mmio);
+    object_class_property_set_description(oc, "highmem-mmio",
+                                          "Set on/off to enable/disable high "
+                                          "memory region for PCI MMIO");
 }
 
 static const TypeInfo virt_machine_types[] = {
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8f0538a72d..5d40546c78 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -127,6 +127,7 @@ struct LoongArchVirtMachineState {
     DeviceState *dintc;
     hwaddr ram_end;
     struct GPEXConfig gpex;
+    bool highmem_mmio;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.3


