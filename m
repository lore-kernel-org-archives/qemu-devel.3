Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE21CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtB5-0006z7-84; Tue, 09 Jun 2026 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAk-0006lM-Ku
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAg-0004ts-JV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxEvDq4idqeTUSAA--.48628S3;
 Tue, 09 Jun 2026 17:54:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S5;
 Tue, 09 Jun 2026 17:54:50 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 03/14] target/loongarch: Use sys_state in cpu_helper.c when
 accessing CSR registers
Date: Tue,  9 Jun 2026 17:28:13 +0800
Message-Id: <20260609092824.227250-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

When accessing CSR register in file cpu_helper.c, use sys_state rather
than env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605082552.175336-4-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu_helper.c | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index eb9684a4a1..7f0e64a873 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -20,27 +20,29 @@
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level)
 {
+    CPUSysState *sys = env_sys(env);
+
     switch (level) {
     case 1:
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
+        *dir_base = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, DIR1_BASE);
+        *dir_width = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
         break;
     case 2:
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
+        *dir_base = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, DIR2_BASE);
+        *dir_width = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
         break;
     case 3:
-        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
+        *dir_base = FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, DIR3_BASE);
+        *dir_width = FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
         break;
     case 4:
-        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
+        *dir_base = FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, DIR4_BASE);
+        *dir_width = FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
         break;
     default:
         /* level may be zero for ldpte */
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+        *dir_base = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTBASE);
+        *dir_width = FIELD_EX64(sys->CSR_PWCL, CSR_PWCL, PTWIDTH);
         break;
     }
 }
@@ -156,13 +158,13 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     vaddr address;
     TLBRet ret;
     MemTxResult ret1;
-
+    CPUSysState *sys = env_sys(env);
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
-        base = env->CSR_PGDH;
+        base = sys->CSR_PGDH;
     } else {
-        base = env->CSR_PGDL;
+        base = sys->CSR_PGDL;
     }
     base &= palen_mask;
 
@@ -315,8 +317,9 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
-    uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
-    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
+    CPUSysState *sys = env_sys(env);
+    uint8_t da = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, DA);
+    uint8_t pg = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG);
     vaddr address;
 
     /* Check PG and DA */
@@ -337,12 +340,12 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
         if (is_la64(env)) {
-            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
+            base_c = FIELD_EX64(sys->CSR_DMW[i], CSR_DMW_64, VSEG);
         } else {
-            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
+            base_c = FIELD_EX64(sys->CSR_DMW[i], CSR_DMW_32, VSEG);
         }
-        if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
-            context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
+        if ((plv & sys->CSR_DMW[i]) && (base_c == base_v)) {
+            context->physical = dmw_va2pa(env, address, sys->CSR_DMW[i]);
             context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
             context->mmu_index = MMU_DA_IDX;
             return TLBRET_MATCH;
-- 
2.54.0


