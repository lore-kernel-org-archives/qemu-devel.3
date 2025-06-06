Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E47C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQbq-00077e-8D; Fri, 06 Jun 2025 02:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uNQbP-00071I-Gw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:30:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uNQbN-0007QF-CE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:30:55 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHHIbi0JoKb8NAQ--.38592S3;
 Fri, 06 Jun 2025 14:30:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxu8QNi0JoJcYMAQ--.37752S7;
 Fri, 06 Jun 2025 14:30:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 05/13] hw/intc/loongarch_ipi: Add kernel irqchip save and
 restore function
Date: Fri,  6 Jun 2025 14:30:25 +0800
Message-Id: <20250606063033.2557365-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250606063033.2557365-1-maobibo@loongson.cn>
References: <20250606063033.2557365-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8QNi0JoJcYMAQ--.37752S7
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

Add save and store funtction if kvm_irqchip_in_kernel() return true,
it is to get and set IPI irqchip state from KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 20 ++++++++++++
 hw/intc/loongarch_ipi_kvm.c     | 54 +++++++++++++++++++++++++++++++++
 include/hw/intc/loongarch_ipi.h |  2 ++
 3 files changed, 76 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 159ba91fb6..0ea91ea054 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -171,6 +171,24 @@ static void loongarch_ipi_cpu_unplug(HotplugHandler *hotplug_dev,
     core->cpu = NULL;
 }
 
+static int loongarch_ipi_pre_save(void *opaque)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_ipi_get(opaque);
+    }
+
+    return 0;
+}
+
+static int loongarch_ipi_post_load(void *opaque, int version_id)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_ipi_put(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
@@ -187,6 +205,8 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
     hc->plug = loongarch_ipi_cpu_plug;
     hc->unplug = loongarch_ipi_cpu_unplug;
+    licc->pre_save = loongarch_ipi_pre_save;
+    licc->post_load = loongarch_ipi_post_load;
 }
 
 static const TypeInfo loongarch_ipi_types[] = {
diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index 51e9c7ed1e..b615060d83 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -11,6 +11,60 @@
 #include "system/kvm.h"
 #include "target/loongarch/cpu.h"
 
+static void kvm_ipi_access_reg(int fd, uint64_t addr, uint32_t *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_IPI_GRP_REGS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_ipi_access_regs(void *opaque, bool write)
+{
+    LoongsonIPICommonState *ipi = (LoongsonIPICommonState *)opaque;
+    LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
+    IPICore *core;
+    uint64_t attr;
+    int cpu, fd = lis->dev_fd;
+
+    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
+        core = &ipi->cpu[cpu];
+        attr = (cpu << 16) | CORE_STATUS_OFF;
+        kvm_ipi_access_reg(fd, attr, &core->status, write);
+
+        attr = (cpu << 16) | CORE_EN_OFF;
+        kvm_ipi_access_reg(fd, attr, &core->en, write);
+
+        attr = (cpu << 16) | CORE_SET_OFF;
+        kvm_ipi_access_reg(fd, attr, &core->set, write);
+
+        attr = (cpu << 16) | CORE_CLEAR_OFF;
+        kvm_ipi_access_reg(fd, attr, &core->clear, write);
+
+        attr = (cpu << 16) | CORE_BUF_20;
+        kvm_ipi_access_reg(fd, attr, &core->buf[0], write);
+
+        attr = (cpu << 16) | CORE_BUF_28;
+        kvm_ipi_access_reg(fd, attr, &core->buf[2], write);
+
+        attr = (cpu << 16) | CORE_BUF_30;
+        kvm_ipi_access_reg(fd, attr, &core->buf[4], write);
+
+        attr = (cpu << 16) | CORE_BUF_38;
+        kvm_ipi_access_reg(fd, attr, &core->buf[6], write);
+    }
+}
+
+int kvm_ipi_get(void *opaque)
+{
+    kvm_ipi_access_regs(opaque, false);
+    return 0;
+}
+
+int kvm_ipi_put(void *opaque, int version_id)
+{
+    kvm_ipi_access_regs(opaque, true);
+    return 0;
+}
+
 void kvm_ipi_realize(DeviceState *dev, Error **errp)
 {
     LoongarchIPIState *lis = LOONGARCH_IPI(dev);
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 608cd09a78..5175a6b004 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -26,5 +26,7 @@ struct LoongarchIPIClass {
 };
 
 void kvm_ipi_realize(DeviceState *dev, Error **errp);
+int kvm_ipi_get(void *opaque);
+int kvm_ipi_put(void *opaque, int version_id);
 
 #endif
-- 
2.39.3


