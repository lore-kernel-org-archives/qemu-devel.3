Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE18C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRue-0000KV-LU; Fri, 07 Mar 2025 02:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tqRuA-00007B-AG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tqRu6-0004to-ES
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:57 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxmnGvnMpn71WNAA--.44723S3;
 Fri, 07 Mar 2025 15:13:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMSqnMpnozE7AA--.21350S7;
 Fri, 07 Mar 2025 15:13:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/intc/loongarch_pch: Replace legacy reset callback with
 new api
Date: Fri,  7 Mar 2025 15:13:46 +0800
Message-Id: <20250307071346.2260062-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250307071346.2260062-1-maobibo@loongson.cn>
References: <20250307071346.2260062-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMSqnMpnozE7AA--.21350S7
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

Replace legacy reset callback register device_class_set_legacy_reset()
with new function resettable_class_set_parent_phases(). With new API,
it will call reset callback of parent object.

The internal state has been cleared in parent object
LOONGARCH_PIC_COMMON, here parent_phases.hold() is directly called.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         | 26 ++++++++------------------
 include/hw/intc/loongarch_pch_pic.h |  1 +
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index acd75ccb0c..32b7275996 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -354,25 +354,13 @@ static const MemoryRegionOps loongarch_pch_pic_reg8_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongarch_pch_pic_reset(DeviceState *d)
+static void loongarch_pic_reset_hold(Object *obj, ResetType type)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(d);
-    int i;
-
-    s->int_mask = -1;
-    s->htmsi_en = 0x0;
-    s->intedge  = 0x0;
-    s->intclr   = 0x0;
-    s->auto_crtl0 = 0x0;
-    s->auto_crtl1 = 0x0;
-    for (i = 0; i < 64; i++) {
-        s->route_entry[i] = 0x1;
-        s->htmsi_vector[i] = 0x0;
+    LoongarchPICClass *lpc = LOONGARCH_PIC_GET_CLASS(obj);
+
+    if (lpc->parent_phases.hold) {
+        lpc->parent_phases.hold(obj, type);
     }
-    s->intirr = 0x0;
-    s->intisr = 0x0;
-    s->last_intirr = 0x0;
-    s->int_polarity = 0x0;
 }
 
 static void loongarch_pic_realize(DeviceState *dev, Error **errp)
@@ -408,8 +396,10 @@ static void loongarch_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongarchPICClass *lpc = LOONGARCH_PIC_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    device_class_set_legacy_reset(dc, loongarch_pch_pic_reset);
+    resettable_class_set_parent_phases(rc, NULL, loongarch_pic_reset_hold,
+                                       NULL, &lpc->parent_phases);
     device_class_set_parent_realize(dc, loongarch_pic_realize,
                                     &lpc->parent_realize);
 }
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 481cc58aed..839a59a43b 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -22,6 +22,7 @@ struct LoongarchPICClass {
     LoongArchPICCommonClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.39.3


