Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F7DCF58F1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZa1-0007JR-7b; Fri, 20 Sep 2024 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1srZZp-0006eo-QK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1srZZm-0003yc-9J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:21 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxSOnKOu1mXO8LAA--.26460S3;
 Fri, 20 Sep 2024 17:05:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TDOu1mdmoKAA--.59343S11;
 Fri, 20 Sep 2024 17:05:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 09/10] hw/intc/loongarch_extioi: Add pre_save interface
Date: Fri, 20 Sep 2024 17:05:06 +0800
Message-Id: <20240920090507.2692125-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240920090507.2692125-1-maobibo@loongson.cn>
References: <20240920090507.2692125-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TDOu1mdmoKAA--.59343S11
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

Add vmstate pre_save interface, which can be used extioi kvm driver
in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi_common.c         | 13 +++++++++++++
 include/hw/intc/loongarch_extioi_common.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index af15ec3531..b3cbba81e1 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -20,6 +20,18 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static int loongarch_extioi_common_pre_save(void *opaque)
+{
+    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)opaque;
+    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(s);
+
+    if (lecc->pre_save) {
+        return lecc->pre_save(s);
+    }
+
+    return 0;
+}
+
 static int loongarch_extioi_common_post_load(void *opaque, int version_id)
 {
     LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)opaque;
@@ -46,6 +58,7 @@ static const VMStateDescription vmstate_loongarch_extioi = {
     .name = "loongarch.extioi",
     .version_id = 3,
     .minimum_version_id = 3,
+    .pre_save  = loongarch_extioi_common_pre_save,
     .post_load = loongarch_extioi_common_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 91947c81db..c926efaca3 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -93,6 +93,7 @@ struct LoongArchExtIOICommonClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
+    int (*pre_save)(void *s);
     int (*post_load)(void *s, int version_id);
 };
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.39.3


