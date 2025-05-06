Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE89C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 01:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC7Xg-0000F6-Lw; Mon, 05 May 2025 21:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uC7Xa-00005i-2K
 for qemu-devel@nongnu.org; Mon, 05 May 2025 21:56:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uC7XV-0001f1-Sv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 21:56:13 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxTWswbBlo8DjWAA--.23005S3;
 Tue, 06 May 2025 09:56:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHcUpbBloEoa1AA--.64914S3;
 Tue, 06 May 2025 09:55:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 1/8] hw/intc/loongarch_ipi: Add reset support
Date: Tue,  6 May 2025 09:55:46 +0800
Message-Id: <20250506015553.1669363-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250506015553.1669363-1-maobibo@loongson.cn>
References: <20250506015553.1669363-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcUpbBloEoa1AA--.64914S3
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

Add reset support with ipi object, register reset callback and clear
internal registers when virt machine resets.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 29 +++++++++++++++++++++++++++++
 include/hw/intc/loongarch_ipi.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 2f8bb57828..74372a2039 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -93,6 +93,32 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_ipi_reset_hold(Object *obj, ResetType type)
+{
+    int i;
+    LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(obj);
+    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(obj);
+    IPICore *core;
+
+    if (lic->parent_phases.hold) {
+        lic->parent_phases.hold(obj, type);
+    }
+
+    for (i = 0; i < lics->num_cpu; i++) {
+        core = lics->cpu + i;
+        /* IPI with targeted CPU available however not present */
+        if (!core->cpu) {
+            continue;
+        }
+
+        core->status = 0;
+        core->en = 0;
+        core->set = 0;
+        core->clear = 0;
+        memset(core->buf, 0, sizeof(core->buf));
+    }
+}
+
 static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
@@ -145,10 +171,13 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_ipi_realize,
                                     &lic->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL, loongarch_ipi_reset_hold,
+                                       NULL, &lic->parent_phases);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
     hc->plug = loongarch_ipi_cpu_plug;
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 923bf21ecb..a7c6bf85d3 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -21,6 +21,7 @@ struct LoongarchIPIState {
 struct LoongarchIPIClass {
     LoongsonIPICommonClass parent_class;
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
 };
 
 #endif
-- 
2.43.5


