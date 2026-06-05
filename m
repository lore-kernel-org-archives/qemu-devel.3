Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6897BCD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPqz-0006Sr-Fx; Fri, 05 Jun 2026 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqx-0006Qt-8F
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqt-0004h4-8w
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:30 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxT+q2hyJqnuMQAA--.45781S3;
 Fri, 05 Jun 2026 16:24:22 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S5;
 Fri, 05 Jun 2026 16:24:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 03/14] target/loongarch: Use sys_state in cpu_helper.c when
 accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:41 +0800
Message-ID: <20260605082552.175336-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw43ZrWkCr45Ar48CrWDKFX_yoWrXry7pF
 W8KrWSvr1UGFZ7Aay3K398t3W3XF4Yyws7W3ZIkw1Fvr1DW39agrW8WrnrCr17A345Ca1U
 AFnrArWF9F17GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8XyCJUUUUU==
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

When accessing CSR register in file cpu_helper.c, use sys_state rather
than env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
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


