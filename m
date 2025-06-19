Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6EDC7115E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAzj-0004Uj-P5; Thu, 19 Jun 2025 04:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSAzX-0004TS-HY
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSAzV-0002yY-0s
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxOGqKz1NojbUZAQ--.62338S3;
 Thu, 19 Jun 2025 16:51:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxDcVtz1NohtwgAQ--.30176S10;
 Thu, 19 Jun 2025 16:51:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 08/14] hw/intc/loongarch_pch: Add kernel irqchip save and
 restore function
Date: Thu, 19 Jun 2025 16:28:11 +0800
Message-Id: <20250619082817.1517996-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619082817.1517996-1-gaosong@loongson.cn>
References: <20250619082817.1517996-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcVtz1NohtwgAQ--.30176S10
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

From: Bibo Mao <maobibo@loongson.cn>

Add save and store funtction if kvm_irqchip_in_kernel() return true,
it is to get and set PCH PCI irqchip state from KVM kernel.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250606063033.2557365-9-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 22 ++++++++++++
 hw/intc/loongarch_pic_kvm.c            | 47 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pch_pic.h    |  2 ++
 include/hw/intc/loongarch_pic_common.h |  1 +
 4 files changed, 72 insertions(+)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 6ac3a72c31..13b5766444 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -287,16 +287,38 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static int loongarch_pic_pre_save(LoongArchPICCommonState *opaque)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_pic_get(opaque);
+    }
+
+    return 0;
+}
+
+static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
+                                   int version_id)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return kvm_pic_put(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
                                        NULL, &lpc->parent_phases);
     device_class_set_parent_realize(dc, loongarch_pic_realize,
                                     &lpc->parent_realize);
+    lpcc->pre_save = loongarch_pic_pre_save;
+    lpcc->post_load = loongarch_pic_post_load;
 }
 
 static const TypeInfo loongarch_pic_types[] = {
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index ee77f04a13..3eef81a9bb 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -13,6 +13,53 @@
 #include "hw/pci-host/ls7a.h"
 #include "system/kvm.h"
 
+static void kvm_pch_pic_access_reg(int fd, uint64_t addr, void *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_pch_pic_access(void *opaque, bool write)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
+    LoongarchPICState *lps = LOONGARCH_PIC(opaque);
+    int fd = lps->dev_fd;
+    int addr, offset;
+
+    kvm_pch_pic_access_reg(fd, PCH_PIC_INT_MASK, &s->int_mask, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_HTMSI_EN, &s->htmsi_en, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_INT_EDGE, &s->intedge, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_AUTO_CTRL0, &s->auto_crtl0, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_AUTO_CTRL1, &s->auto_crtl1, write);
+
+    for (addr = PCH_PIC_ROUTE_ENTRY;
+        addr < PCH_PIC_ROUTE_ENTRY_END; addr++) {
+        offset = addr - PCH_PIC_ROUTE_ENTRY;
+        kvm_pch_pic_access_reg(fd, addr, &s->route_entry[offset], write);
+    }
+
+    for (addr = PCH_PIC_HTMSI_VEC; addr < PCH_PIC_HTMSI_VEC_END; addr++) {
+        offset = addr - PCH_PIC_HTMSI_VEC;
+        kvm_pch_pic_access_reg(fd, addr, &s->htmsi_vector[offset], write);
+    }
+
+    kvm_pch_pic_access_reg(fd, PCH_PIC_INT_REQUEST, &s->intirr, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_INT_STATUS, &s->intisr, write);
+    kvm_pch_pic_access_reg(fd, PCH_PIC_INT_POL, &s->int_polarity, write);
+}
+
+int kvm_pic_get(void *opaque)
+{
+    kvm_pch_pic_access(opaque, false);
+    return 0;
+}
+
+int kvm_pic_put(void *opaque, int version_id)
+{
+    kvm_pch_pic_access(opaque, true);
+    return 0;
+}
+
 void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongarchPICState *lps = LOONGARCH_PIC(dev);
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 4b52f1165f..a46b6f8985 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -27,5 +27,7 @@ struct LoongarchPICClass {
 };
 
 void kvm_pic_realize(DeviceState *dev, Error **errp);
+int kvm_pic_get(void *opaque);
+int kvm_pic_put(void *opaque, int version_id);
 
 #endif /* HW_LOONGARCH_PCH_PIC_H */
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 9349a055d0..f774c975d4 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -23,6 +23,7 @@
 #define PCH_PIC_ROUTE_ENTRY_END         0x13f
 #define PCH_PIC_HTMSI_VEC               0x200
 #define PCH_PIC_HTMSI_VEC_END           0x23f
+#define PCH_PIC_INT_REQUEST             0x380
 #define PCH_PIC_INT_STATUS              0x3a0
 #define PCH_PIC_INT_POL                 0x3e0
 
-- 
2.47.0


