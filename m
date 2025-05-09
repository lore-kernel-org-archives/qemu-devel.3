Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43C8C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKir-0002MQ-4k; Fri, 09 May 2025 06:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKip-0002KP-AY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKim-0001gC-Ga
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXWse1R1oImXbAA--.32042S3;
 Fri, 09 May 2025 18:12:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXsUd1R1oACrAAA--.30666S3;
 Fri, 09 May 2025 18:12:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 12/15] hw/intc/loongarch_pch: Add irqchip-in-kernel
 save/restore function
Date: Fri,  9 May 2025 18:12:42 +0800
Message-Id: <20250509101245.1070255-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509101245.1070255-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509101245.1070255-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsUd1R1oACrAAA--.30666S3
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
it is to get/set PCH PCI irqchip state from KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
`
---
 hw/intc/loongarch_pch_pic.c            | 26 ++++++++++++
 hw/intc/loongarch_pic_kvm.c            | 58 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pch_pic.h    |  2 +
 include/hw/intc/loongarch_pic_common.h |  1 +
 4 files changed, 87 insertions(+)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 481a303cc1..e8dfd0ed75 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -293,6 +293,29 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static int loongarch_pic_pre_save(LoongArchPICCommonState *opaque)
+{
+    LoongarchPICState *lps = LOONGARCH_PIC(opaque);
+
+    if (kvm_enabled() && lps->irqchip_in_kernel) {
+        return kvm_loongarch_pic_pre_save(opaque);
+    }
+
+    return 0;
+}
+
+static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
+                                   int version_id)
+{
+    LoongarchPICState *lps = LOONGARCH_PIC(opaque);
+
+    if (kvm_enabled() && lps->irqchip_in_kernel) {
+        return kvm_loongarch_pic_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const Property loongarch_pic_properties[] = {
     DEFINE_PROP_BOOL("irqchip-in-kernel", LoongarchPICState,
                      irqchip_in_kernel, false),
@@ -302,6 +325,7 @@ static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
@@ -309,6 +333,8 @@ static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
     device_class_set_parent_realize(dc, loongarch_pic_realize,
                                     &lpc->parent_realize);
     device_class_set_props(dc, loongarch_pic_properties);
+    lpcc->pre_save = loongarch_pic_pre_save;
+    lpcc->post_load = loongarch_pic_post_load;
 }
 
 static const TypeInfo loongarch_pic_types[] = {
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index 696dabb0b2..84942a86cd 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -13,6 +13,64 @@
 #include "hw/pci-host/ls7a.h"
 #include "system/kvm.h"
 
+static void kvm_pch_pic_access_regs(int fd, uint64_t addr,
+                                       void *val, bool write)
+{
+    kvm_device_access(fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS,
+                      addr, val, write, &error_abort);
+}
+
+static void kvm_loongarch_pch_pic_save_load(void *opaque, bool write)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
+    LoongarchPICState *lps = LOONGARCH_PIC(opaque);
+    int fd = lps->dev_fd;
+    int addr, offset;
+
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_MASK,
+                            &s->int_mask, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_HTMSI_EN,
+                            &s->htmsi_en, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_EDGE,
+                            &s->intedge, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_AUTO_CTRL0,
+                            &s->auto_crtl0, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_AUTO_CTRL1,
+                            &s->auto_crtl1, write);
+
+    for (addr = PCH_PIC_ROUTE_ENTRY;
+        addr < PCH_PIC_ROUTE_ENTRY_END; addr++) {
+        offset = addr - PCH_PIC_ROUTE_ENTRY;
+        kvm_pch_pic_access_regs(fd, addr + VIRT_PCH_REG_BASE,
+                                &s->route_entry[offset], write);
+    }
+
+    for (addr = PCH_PIC_HTMSI_VEC; addr < PCH_PIC_HTMSI_VEC_END; addr++) {
+        offset = addr - PCH_PIC_HTMSI_VEC;
+        kvm_pch_pic_access_regs(fd, addr + VIRT_PCH_REG_BASE,
+                                &s->htmsi_vector[offset], write);
+    }
+
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_REQUEST,
+                            &s->intirr, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_STATUS,
+                            &s->intisr, write);
+    kvm_pch_pic_access_regs(fd, VIRT_PCH_REG_BASE + PCH_PIC_INT_POL,
+                            &s->int_polarity, write);
+}
+
+int kvm_loongarch_pic_pre_save(void *opaque)
+{
+    kvm_loongarch_pch_pic_save_load(opaque, false);
+    return 0;
+}
+
+int kvm_loongarch_pic_post_load(void *opaque, int version_id)
+{
+    kvm_loongarch_pch_pic_save_load(opaque, true);
+    return 0;
+}
+
 void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongarchPICState *lps = LOONGARCH_PIC(dev);
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 91a20dd624..822d9d3544 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -28,5 +28,7 @@ struct LoongarchPICClass {
 };
 
 void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp);
+int kvm_loongarch_pic_pre_save(void *opaque);
+int kvm_loongarch_pic_post_load(void *opaque, int version_id);
 
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
2.39.3


