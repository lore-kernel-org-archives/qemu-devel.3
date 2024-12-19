Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78618E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 07:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBNQ-0003hf-76; Thu, 19 Dec 2024 02:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tOBNN-0003g1-Ql
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:55:17 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tOBNL-0004pd-1y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:55:17 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxieBe0WNnj3hYAA--.41723S3;
 Thu, 19 Dec 2024 15:55:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxQMZX0WNnSCkCAA--.12762S9;
 Thu, 19 Dec 2024 15:55:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 07/18] hw/intc/loongarch_pch: Add pre_save and post_load
 interfaces
Date: Thu, 19 Dec 2024 15:54:51 +0800
Message-Id: <20241219075502.3164644-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219075502.3164644-1-maobibo@loongson.cn>
References: <20241219075502.3164644-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxQMZX0WNnSCkCAA--.12762S9
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

Add vmstate pre_save and post_load interfaces, which can be used
by pic kvm driver in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pic_common.c         | 26 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pic_common.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index f97e38368d..bcb6b7b3fc 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -10,6 +10,30 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
+static int loongarch_pic_pre_save(void *opaque)
+{
+    LoongArchPICCommonState *s = (LoongArchPICCommonState *)opaque;
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_GET_CLASS(s);
+
+    if (lpcc->pre_save) {
+        return lpcc->pre_save(s);
+    }
+
+    return 0;
+}
+
+static int loongarch_pic_post_load(void *opaque, int version_id)
+{
+    LoongArchPICCommonState *s = (LoongArchPICCommonState *)opaque;
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_GET_CLASS(s);
+
+    if (lpcc->post_load) {
+        return lpcc->post_load(s, version_id);
+    }
+
+    return 0;
+}
+
 static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
@@ -29,6 +53,8 @@ static const VMStateDescription vmstate_loongarch_pic_common = {
     .name = "loongarch_pch_pic",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save  = loongarch_pic_pre_save,
+    .post_load = loongarch_pic_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(int_mask, LoongArchPICCommonState),
         VMSTATE_UINT64(htmsi_en, LoongArchPICCommonState),
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 0a1a28063c..43cce48978 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -76,5 +76,7 @@ struct LoongArchPICCommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    int (*pre_save)(LoongArchPICCommonState *s);
+    int (*post_load)(LoongArchPICCommonState *s, int version_id);
 };
 #endif  /* HW_LOONGARCH_PIC_COMMON_H */
-- 
2.43.5


