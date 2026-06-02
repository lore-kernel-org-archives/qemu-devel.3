Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A38CD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFN3-0005lC-16; Mon, 01 Jun 2026 23:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wUFMz-0005jr-BG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:00:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wUFMw-0002In-83
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:00:45 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxBOlYRx5qnZUPAA--.37609S3;
 Tue, 02 Jun 2026 11:00:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxzsJWRx5q7dqYAA--.27658S5;
 Tue, 02 Jun 2026 11:00:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 09/13] target/loongarch: Use sys_state in op_helper.c when
 accessing CSR registers
Date: Tue,  2 Jun 2026 11:00:25 +0800
Message-Id: <20260602030029.1476299-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260602030029.1476299-1-maobibo@loongson.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxzsJWRx5q7dqYAA--.27658S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

When accessing CSR registers in file op_helper.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/op_helper.c | 45 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 16ac0d43bc..e63ac66daa 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -46,16 +46,20 @@ target_ulong helper_bitswap(target_ulong v)
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
+    CPUSysState *sys = env_sys(env);
+
     if (rj > rk) {
-        env->CSR_BADV = rj;
+        sys->CSR_BADV = rj;
         do_raise_exception(env, EXCCODE_BCE, GETPC());
     }
 }
 
 void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
+    CPUSysState *sys = env_sys(env);
+
     if (rj <= rk) {
-        env->CSR_BADV = rj;
+        sys->CSR_BADV = rj;
         do_raise_exception(env, EXCCODE_BCE, GETPC());
     }
 }
@@ -91,9 +95,10 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
 #else
     uint64_t plv;
     LoongArchCPU *cpu = env_archcpu(env);
+    CPUSysState *sys = env_sys(env);
 
-    plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (extract64(env->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
+    plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
+    if (extract64(sys->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
         do_raise_exception(env, EXCCODE_IPE, GETPC());
     }
 
@@ -105,26 +110,28 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
 void helper_ertn(CPULoongArchState *env)
 {
     uint64_t csr_pplv, csr_pie;
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        csr_pplv = FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
-        csr_pie = FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE);
-
-        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 0);
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 1);
-        set_pc(env, env->CSR_TLBRERA);
+    CPUSysState *sys = env_sys(env);
+
+    if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        csr_pplv = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
+        csr_pie = FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE);
+
+        sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
+        sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 0);
+        sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 1);
+        set_pc(env, sys->CSR_TLBRERA);
         qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n",
-                      __func__, env->CSR_TLBRERA);
+                      __func__, sys->CSR_TLBRERA);
     } else {
-        csr_pplv = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PPLV);
-        csr_pie = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PIE);
+        csr_pplv = FIELD_EX64(sys->CSR_PRMD, CSR_PRMD, PPLV);
+        csr_pie = FIELD_EX64(sys->CSR_PRMD, CSR_PRMD, PIE);
 
-        set_pc(env, env->CSR_ERA);
+        set_pc(env, sys->CSR_ERA);
         qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n",
-                      __func__, env->CSR_ERA);
+                      __func__, sys->CSR_ERA);
     }
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, csr_pplv);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, csr_pie);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, csr_pplv);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, csr_pie);
 
     env->lladdr = 1;
 }
-- 
2.39.3


