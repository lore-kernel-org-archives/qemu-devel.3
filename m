Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD57C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKeE-0006HO-BU; Fri, 09 May 2025 06:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKeA-0006BX-87
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKe5-00018w-Cy
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:02 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxIK_40x1oAmPbAA--.29327S3;
 Fri, 09 May 2025 18:07:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcX00x1oMCfAAA--.29037S9;
 Fri, 09 May 2025 18:07:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 07/15] hw/intc/loongarch_ipi: Add irqchip-in-kernel
 save/restore function
Date: Fri,  9 May 2025 18:07:39 +0800
Message-Id: <20250509100747.1070094-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509100747.1070094-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcX00x1oMCfAAA--.29037S9
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add save and store funtction if irqchip-in-kernel property is enabled,
it is to get/set IPI irqchip state from KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 24 ++++++++++++++
 hw/intc/loongarch_ipi_kvm.c     | 56 +++++++++++++++++++++++++++++++++
 include/hw/intc/loongarch_ipi.h |  2 ++
 3 files changed, 82 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 5e240382ad..bb28e602fc 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -177,6 +177,28 @@ static void loongarch_ipi_cpu_unplug(HotplugHandler *hotplug_dev,
     core->cpu = NULL;
 }
 
+static int loongarch_ipi_pre_save(void *opaque)
+{
+    LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
+
+    if (kvm_enabled() && lis->irqchip_in_kernel) {
+        return kvm_loongarch_ipi_pre_save(opaque);
+    }
+
+    return 0;
+}
+
+static int loongarch_ipi_post_load(void *opaque, int version_id)
+{
+    LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
+
+    if (kvm_enabled() && lis->irqchip_in_kernel) {
+        return kvm_loongarch_ipi_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const Property loongarch_ipi_properties[] = {
     DEFINE_PROP_BOOL("irqchip-in-kernel", LoongarchIPIState,
                      irqchip_in_kernel, false),
@@ -199,6 +221,8 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
     hc->plug = loongarch_ipi_cpu_plug;
     hc->unplug = loongarch_ipi_cpu_unplug;
+    licc->pre_save = loongarch_ipi_pre_save;
+    licc->post_load = loongarch_ipi_post_load;
 }
 
 static const TypeInfo loongarch_ipi_types[] = {
diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index e8fcd3bd2f..b5b2b22045 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -11,6 +11,62 @@
 #include "system/kvm.h"
 #include "target/loongarch/cpu.h"
 
+static void kvm_ipi_access_regs(int fd, uint64_t addr,
+                                uint32_t *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_IPI_GRP_REGS,
+                          addr, val, write, &error_abort);
+}
+
+static void kvm_loongarch_ipi_save_load_regs(void *opaque, bool write)
+{
+    LoongsonIPICommonState *ipi = (LoongsonIPICommonState *)opaque;
+    LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
+    IPICore *cpu;
+    uint64_t attr;
+    int cpu_id = 0;
+    int fd = lis->dev_fd;
+
+    for (cpu_id = 0; cpu_id < ipi->num_cpu; cpu_id++) {
+        cpu = &ipi->cpu[cpu_id];
+        attr = (cpu_id << 16) | CORE_STATUS_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->status, write);
+
+        attr = (cpu_id << 16) | CORE_EN_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->en, write);
+
+        attr = (cpu_id << 16) | CORE_SET_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->set, write);
+
+        attr = (cpu_id << 16) | CORE_CLEAR_OFF;
+        kvm_ipi_access_regs(fd, attr, &cpu->clear, write);
+
+        attr = (cpu_id << 16) | CORE_BUF_20;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[0], write);
+
+        attr = (cpu_id << 16) | CORE_BUF_28;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[2], write);
+
+        attr = (cpu_id << 16) | CORE_BUF_30;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[4], write);
+
+        attr = (cpu_id << 16) | CORE_BUF_38;
+        kvm_ipi_access_regs(fd, attr, &cpu->buf[6], write);
+    }
+}
+
+int kvm_loongarch_ipi_pre_save(void *opaque)
+{
+    kvm_loongarch_ipi_save_load_regs(opaque, false);
+    return 0;
+}
+
+int kvm_loongarch_ipi_post_load(void *opaque, int version_id)
+{
+    kvm_loongarch_ipi_save_load_regs(opaque, true);
+    return 0;
+}
+
 void kvm_loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
     LoongarchIPIState *lis = LOONGARCH_IPI(dev);
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 26076d8062..921cbb0fb5 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -27,5 +27,7 @@ struct LoongarchIPIClass {
 };
 
 void kvm_loongarch_ipi_realize(DeviceState *dev, Error **errp);
+int kvm_loongarch_ipi_pre_save(void *opaque);
+int kvm_loongarch_ipi_post_load(void *opaque, int version_id);
 
 #endif
-- 
2.39.3


