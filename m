Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DDBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENqr-0000i8-3G; Thu, 30 Oct 2025 04:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vENqp-0000hD-F1
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vENqe-0003BB-Tx
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:42 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxudEWHwNpjIgcAA--.62769S3;
 Thu, 30 Oct 2025 16:17:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxicAVHwNpKnMcAQ--.9832S5;
 Thu, 30 Oct 2025 16:17:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] target/loongarch: Add PMU register dump support in KVM
Date: Thu, 30 Oct 2025 16:17:24 +0800
Message-Id: <20251030081724.3921563-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251030081724.3921563-1-maobibo@loongson.cn>
References: <20251030081724.3921563-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxicAVHwNpKnMcAQ--.9832S5
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

PMU is supported in KVM mode. With info registers command, PMU CSR
registers should be dumped also. And it is not necessary in TCG mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c |  5 +++++
 target/loongarch/csr.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7daf290851..401ae75bd0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -129,6 +129,11 @@ static void loongarch_la464_init_csr(DeviceState *dev)
         set_csr_flag(LOONGARCH_CSR_MERRERA, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_MERRSAVE, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
+
+        for (i = env->perf_event_num; i < MAX_PERF_EVENTS; i++) {
+            set_csr_flag(LOONGARCH_CSR_PERFCTRL(i), CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCNTR(i), CSRFL_UNUSED);
+        }
     }
 #endif
 }
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index f973780bba..332a1396cc 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -94,6 +94,38 @@ static CSRInfo csr_info[] = {
     CSR_OFF_ARRAY(DMW, 1),
     CSR_OFF_ARRAY(DMW, 2),
     CSR_OFF_ARRAY(DMW, 3),
+    CSR_OFF_ARRAY(PERFCTRL, 0),
+    CSR_OFF_ARRAY(PERFCNTR, 0),
+    CSR_OFF_ARRAY(PERFCTRL, 1),
+    CSR_OFF_ARRAY(PERFCNTR, 1),
+    CSR_OFF_ARRAY(PERFCTRL, 2),
+    CSR_OFF_ARRAY(PERFCNTR, 2),
+    CSR_OFF_ARRAY(PERFCTRL, 3),
+    CSR_OFF_ARRAY(PERFCNTR, 3),
+    CSR_OFF_ARRAY(PERFCTRL, 4),
+    CSR_OFF_ARRAY(PERFCNTR, 4),
+    CSR_OFF_ARRAY(PERFCTRL, 5),
+    CSR_OFF_ARRAY(PERFCNTR, 5),
+    CSR_OFF_ARRAY(PERFCTRL, 6),
+    CSR_OFF_ARRAY(PERFCNTR, 6),
+    CSR_OFF_ARRAY(PERFCTRL, 7),
+    CSR_OFF_ARRAY(PERFCNTR, 7),
+    CSR_OFF_ARRAY(PERFCTRL, 8),
+    CSR_OFF_ARRAY(PERFCNTR, 8),
+    CSR_OFF_ARRAY(PERFCTRL, 9),
+    CSR_OFF_ARRAY(PERFCNTR, 9),
+    CSR_OFF_ARRAY(PERFCTRL, 10),
+    CSR_OFF_ARRAY(PERFCNTR, 10),
+    CSR_OFF_ARRAY(PERFCTRL, 11),
+    CSR_OFF_ARRAY(PERFCNTR, 11),
+    CSR_OFF_ARRAY(PERFCTRL, 12),
+    CSR_OFF_ARRAY(PERFCNTR, 12),
+    CSR_OFF_ARRAY(PERFCTRL, 13),
+    CSR_OFF_ARRAY(PERFCNTR, 13),
+    CSR_OFF_ARRAY(PERFCTRL, 14),
+    CSR_OFF_ARRAY(PERFCNTR, 14),
+    CSR_OFF_ARRAY(PERFCTRL, 15),
+    CSR_OFF_ARRAY(PERFCNTR, 15),
     CSR_OFF(DBG),
     CSR_OFF(DERA),
     CSR_OFF(DSAVE),
-- 
2.39.3


