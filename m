Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D5ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RQy-0000ur-Je; Mon, 29 Sep 2025 23:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RQw-0000uS-Cn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RQq-0001pc-Vt
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:45 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxHvA+VNtoumsQAA--.34595S3;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S3;
 Tue, 30 Sep 2025 11:53:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 01/13] target/loongarch: Use auto method with PTW feature
Date: Tue, 30 Sep 2025 11:53:20 +0800
Message-Id: <20250930035332.2609520-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S3
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

PTW is short for page table walker, it is hardware page table walker
function. With PTW supported, hardware MMU will parse page table
table and update TLB entries automatically.

This patch adds type OnOffAuto for PTW feature setting.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 25 +++++++++++++++++++++++++
 target/loongarch/cpu.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 993602fb8c..c71e879791 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -514,6 +514,24 @@ static void loongarch_set_msgint(Object *obj, bool value, Error **errp)
      cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, value);
 }
 
+static bool loongarch_get_ptw(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->ptw != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    if (kvm_enabled()) {
+        /* PTW feature is only support in TCG mode now */
+        return;
+    }
+
+    cpu->ptw = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
+}
+
 static void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -528,7 +546,10 @@ static void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_lasx);
     object_property_add_bool(obj, "msgint", loongarch_get_msgint,
                              loongarch_set_msgint);
+    object_property_add_bool(obj, "ptw", loongarch_get_ptw,
+                             loongarch_set_ptw);
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
+
     if (kvm_enabled()) {
         kvm_loongarch_cpu_post_init(cpu);
     }
@@ -636,6 +657,7 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
     cpu->msgint = ON_OFF_AUTO_OFF;
+    cpu->ptw = ON_OFF_AUTO_OFF;
     loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
@@ -667,6 +689,7 @@ static void loongarch_la132_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, CRC, 1);
     env->cpucfg[1] = data;
     cpu->msgint = ON_OFF_AUTO_OFF;
+    cpu->ptw = ON_OFF_AUTO_OFF;
 }
 
 static void loongarch_max_initfn(Object *obj)
@@ -678,6 +701,8 @@ static void loongarch_max_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->env.cpucfg[1] = FIELD_DP32(cpu->env.cpucfg[1], CPUCFG1, MSG_INT, 1);
         cpu->msgint = ON_OFF_AUTO_AUTO;
+        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, 1);
+        cpu->ptw = ON_OFF_AUTO_AUTO;
     }
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b8e3b46c3a..b1d6799222 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -137,6 +137,7 @@ FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
+FIELD(CPUCFG2, HPTW, 24, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
@@ -402,6 +403,7 @@ struct ArchCPU {
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
+    OnOffAuto ptw;
     OnOffAuto lsx;
     OnOffAuto lasx;
     OnOffAuto msgint;
-- 
2.39.3


