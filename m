Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487F0C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRue-0000KW-Li; Fri, 07 Mar 2025 02:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tqRuB-00008a-2H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tqRu6-0004ti-Va
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:58 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLGuunMpn7VWNAA--.45013S3;
 Fri, 07 Mar 2025 15:13:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMSqnMpnozE7AA--.21350S6;
 Fri, 07 Mar 2025 15:13:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/intc/loongarch_pch: Add reset support
Date: Fri,  7 Mar 2025 15:13:45 +0800
Message-Id: <20250307071346.2260062-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250307071346.2260062-1-maobibo@loongson.cn>
References: <20250307071346.2260062-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMSqnMpnozE7AA--.21350S6
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

Add reset support with LoongArch pci irqchip, and register reset
callback support with new API resettable_class_set_parent_phases().
Clear internal HW registers and SW state when virt machine resets.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pic_common.c         | 25 +++++++++++++++++++++++++
 include/hw/intc/loongarch_pic_common.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index e7f541db4b..08ef97fcc4 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -44,6 +44,27 @@ static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_pic_common_reset_hold(Object *obj, ResetType type)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
+    int i;
+
+    s->int_mask = -1;
+    s->htmsi_en = 0x0;
+    s->intedge  = 0x0;
+    s->intclr   = 0x0;
+    s->auto_crtl0 = 0x0;
+    s->auto_crtl1 = 0x0;
+    for (i = 0; i < 64; i++) {
+        s->route_entry[i] = 0x1;
+        s->htmsi_vector[i] = 0x0;
+    }
+    s->intirr = 0x0;
+    s->intisr = 0x0;
+    s->last_intirr = 0x0;
+    s->int_polarity = 0x0;
+}
+
 static const Property loongarch_pic_common_properties[] = {
     DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
 };
@@ -75,9 +96,13 @@ static void loongarch_pic_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_pic_common_realize,
                                     &lpcc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL,
+                                       loongarch_pic_common_reset_hold,
+                                       NULL, &lpcc->parent_phases);
     device_class_set_props(dc, loongarch_pic_common_properties);
     dc->vmsd = &vmstate_loongarch_pic_common;
 }
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 43cce48978..d301377cd7 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -76,6 +76,7 @@ struct LoongArchPICCommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
     int (*pre_save)(LoongArchPICCommonState *s);
     int (*post_load)(LoongArchPICCommonState *s, int version_id);
 };
-- 
2.39.3


