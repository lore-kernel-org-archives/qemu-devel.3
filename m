Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E2CF58F1
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZZt-0006jo-8W; Fri, 20 Sep 2024 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1srZZp-0006en-Oq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1srZZm-0003xe-8R
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:21 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxB+nIOu1mU+8LAA--.26289S3;
 Fri, 20 Sep 2024 17:05:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TDOu1mdmoKAA--.59343S8;
 Fri, 20 Sep 2024 17:05:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] hw/intc/loongarch_extioi: Add unrealize interface
Date: Fri, 20 Sep 2024 17:05:03 +0800
Message-Id: <20240920090507.2692125-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240920090507.2692125-1-maobibo@loongson.cn>
References: <20240920090507.2692125-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TDOu1mdmoKAA--.59343S8
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

For loongarch extioi emulation driver, add unrealize interface and
remove instance_finalize interface and move the code to unrealize
interface.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 8ac246c2e6..f17ff39254 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -378,9 +378,9 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void loongarch_extioi_finalize(Object *obj)
+static void loongarch_extioi_unrealize(DeviceState *dev)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI(dev);
 
     g_free(s->cpu);
 }
@@ -462,6 +462,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_extioi_realize;
+    dc->unrealize = loongarch_extioi_unrealize;
     device_class_set_legacy_reset(dc, loongarch_extioi_reset);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
@@ -472,7 +473,6 @@ static const TypeInfo loongarch_extioi_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(struct LoongArchExtIOI),
     .class_init    = loongarch_extioi_class_init,
-    .instance_finalize = loongarch_extioi_finalize,
 };
 
 static void loongarch_extioi_register_types(void)
-- 
2.39.3


