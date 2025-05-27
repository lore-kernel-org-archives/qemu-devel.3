Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D77DC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpva-0003Cn-BW; Tue, 27 May 2025 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJpvY-0003Bt-4g
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJpvV-0000bD-0L
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxSWp9ezVoPBj+AA--.46540S3;
 Tue, 27 May 2025 16:44:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3xtyezVolPn0AA--.53554S6;
 Tue, 27 May 2025 16:44:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 04/12] hw/intc/loongson_ipi: Add load and save interface
 with ipi_common class
Date: Tue, 27 May 2025 16:44:22 +0800
Message-Id: <20250527084430.3468174-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250527084430.3468174-1-maobibo@loongson.cn>
References: <20250527084430.3468174-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3xtyezVolPn0AA--.53554S6
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

Add pre_save and post_load interfaces with ipi_common class, here only
framework ipi_common adds these interfaces. The defailed implementation
is LoongArchIPI child device in later.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi_common.c         | 28 +++++++++++++++++++++++++++
 include/hw/intc/loongson_ipi_common.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index ff2cc8bc91..8cd78d4858 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -282,10 +282,38 @@ static void loongson_ipi_common_unrealize(DeviceState *dev)
     g_free(s->cpu);
 }
 
+static int loongson_ipi_common_pre_save(void *opaque)
+{
+    IPICore *ipicore = (IPICore *)opaque;
+    LoongsonIPICommonState *s = ipicore->ipi;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(s);
+
+    if (licc->pre_save) {
+        return licc->pre_save(s);
+    }
+
+    return 0;
+}
+
+static int loongson_ipi_common_post_load(void *opaque, int version_id)
+{
+    IPICore *ipicore = (IPICore *)opaque;
+    LoongsonIPICommonState *s = ipicore->ipi;
+    LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_GET_CLASS(s);
+
+    if (licc->post_load) {
+        return licc->post_load(s, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
     .version_id = 2,
     .minimum_version_id = 2,
+    .pre_save  = loongson_ipi_common_pre_save,
+    .post_load = loongson_ipi_common_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(status, IPICore),
         VMSTATE_UINT32(en, IPICore),
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index b587f9c571..e58ce2aa1c 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -48,6 +48,8 @@ struct LoongsonIPICommonClass {
     AddressSpace *(*get_iocsr_as)(CPUState *cpu);
     int (*cpu_by_arch_id)(LoongsonIPICommonState *lics, int64_t id,
                           int *index, CPUState **pcs);
+    int (*pre_save)(void *opaque);
+    int (*post_load)(void *opaque, int version_id);
 };
 
 MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
-- 
2.39.3


