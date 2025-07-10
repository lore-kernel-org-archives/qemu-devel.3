Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54434C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 09:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZneP-00054s-6p; Thu, 10 Jul 2025 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZneM-00052a-Oo
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:33:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZneB-0008Dx-R1
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:33:06 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxnmvDiG9opUUmAQ--.40470S3;
 Thu, 10 Jul 2025 17:32:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8O4iG9os1URAA--.33307S3;
 Thu, 10 Jul 2025 17:32:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/intc/loongarch_extioi: Move unrealize function to
 common code
Date: Thu, 10 Jul 2025 17:32:35 +0800
Message-Id: <20250710093238.453962-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250710093238.453962-1-maobibo@loongson.cn>
References: <20250710093238.453962-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8O4iG9os1URAA--.33307S3
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Memory about LoongArchExtIOICommonState::cpu is allocated in common
code, it had better be freed in common code also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c                | 9 ---------
 hw/intc/loongarch_extioi_common.c         | 9 +++++++++
 include/hw/intc/loongarch_extioi.h        | 1 -
 include/hw/intc/loongarch_extioi_common.h | 1 +
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 8b8ac6b187..3e9c88d1d9 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -377,13 +377,6 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void loongarch_extioi_unrealize(DeviceState *dev)
-{
-    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
-
-    g_free(s->cpu);
-}
-
 static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
 {
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(obj);
@@ -436,8 +429,6 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_parent_realize(dc, loongarch_extioi_realize,
                                     &lec->parent_realize);
-    device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
-                                      &lec->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
                                        NULL, &lec->parent_phases);
     lecc->pre_save  = vmstate_extioi_pre_save;
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index 4a904b3bc1..ba03383ed1 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -108,6 +108,13 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_extioi_common_unrealize(DeviceState *dev)
+{
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
+
+    g_free(s->cpu);
+}
+
 static void loongarch_extioi_common_reset_hold(Object *obj, ResetType type)
 {
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(obj);
@@ -221,6 +228,8 @@ static void loongarch_extioi_common_class_init(ObjectClass *klass,
 
     device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
                                     &lecc->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_extioi_common_unrealize,
+                                      &lecc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL,
                                        loongarch_extioi_common_reset_hold,
                                        NULL, &lecc->parent_phases);
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 9be1d736ea..4795bdc15f 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -22,7 +22,6 @@ struct LoongArchExtIOIClass {
     LoongArchExtIOICommonClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index dca25ff893..c021ccee0f 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -94,6 +94,7 @@ struct LoongArchExtIOICommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     int (*pre_save)(void *s);
     int (*post_load)(void *s, int version_id);
-- 
2.43.5


