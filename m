Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9958ECD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 07:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSrHh-0000sF-5C; Fri, 29 May 2026 03:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1wSrHc-0000oB-6v
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:05:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1wSrHW-0008Tp-Hp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:05:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxRXilOhlqL3UOAA--.16579S3;
 Fri, 29 May 2026 15:05:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxTMKkOhlqMLyUAA--.17345S2;
 Fri, 29 May 2026 15:05:08 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH] target/loongarch: clear the registers when cpu is reset
Date: Fri, 29 May 2026 14:38:58 +0800
Message-Id: <20260529063858.3437928-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTMKkOhlqMLyUAA--.17345S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Set the CSR_CRMD, CSR_ESTAT, CSR_MSGIS and CSR_PERFCTRL registers to the
reset state when the CPU is reset.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>

 target/loongarch/cpu-csr.h |  7 +++++++
 target/loongarch/cpu.c     | 19 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..d936af8e57 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -211,6 +211,13 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
 #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
 #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
 
+FIELD(CSR_PERFCTRL, EV, 0, 10)
+FIELD(CSR_PERFCTRL, PLV0, 16, 1)
+FIELD(CSR_PERFCTRL, PLV1, 17, 1)
+FIELD(CSR_PERFCTRL, PLV2, 18, 1)
+FIELD(CSR_PERFCTRL, PLV3, 19, 1)
+FIELD(CSR_PERFCTRL, PMIE, 20, 1)
+
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
 FIELD(CSR_DBG, DST, 0, 1)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8f277f7696..7f82c4c46c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -622,6 +622,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 0);
+    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, WE, 0);
 
     env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, FPE, 0);
     env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, SXE, 0);
@@ -633,7 +634,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, VS, 0);
     env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, LIE, 0);
 
-    env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
+    env->CSR_ESTAT = 0;
     env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
     env->CSR_CPUID = cs->cpu_index;
     env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
@@ -641,6 +642,22 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
     env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
     env->CSR_TID = cs->cpu_index;
+
+    memset(env->CSR_MSGIS, 0, sizeof(env->CSR_MSGIS));
+    env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 0);
+    for (n = 0; n < MAX_PERF_EVENTS; n++) {
+        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV0, 0);
+        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV1, 0);
+        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV2, 0);
+        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PLV3, 0);
+        env->CSR_PERFCTRL[n] = FIELD_DP64(env->CSR_PERFCTRL[n], CSR_PERFCTRL,
+                                          PMIE, 0);
+    }
+
     /*
      * Workaround for edk2-stable202408, CSR PGD register is set only if
      * its value is equal to zero for boot cpu, it causes reboot issue.
-- 
2.39.1


