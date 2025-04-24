Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC4AC369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 02:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7mkT-0000ai-CO; Wed, 23 Apr 2025 22:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7mkN-0000ZV-S6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7mkK-00005A-FI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTWseqAlomwbFAA--.63560S3;
 Thu, 24 Apr 2025 10:55:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhsVqAlogNaSAA--.53120S6;
 Thu, 24 Apr 2025 10:55:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/13] target/loongarch: Move function get_dir_base_width to
 common directory
Date: Thu, 24 Apr 2025 10:33:08 +0800
Message-Id: <20250424023317.3980755-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424023317.3980755-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhsVqAlogNaSAA--.53120S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Function get_dir_base_width() is used by loongarch_page_table_walker(),
so it is used by KVM mode also, here move this function from directory
tcg to common directory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250423080417.3739809-4-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu_helper.c     | 28 ++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 28 ----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index a326859000..8ae9a448b4 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -157,6 +157,34 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                        uint64_t *dir_width, target_ulong level)
+{
+    switch (level) {
+    case 1:
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
+        break;
+    case 2:
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
+        break;
+    case 3:
+        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
+        break;
+    case 4:
+        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
+        break;
+    default:
+        /* level may be zero for ldpte */
+        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
+        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+        break;
+    }
+}
+
 static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
                                  int *prot, target_ulong address)
 {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 70d1b5cf99..e6cfcc55c8 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -27,34 +27,6 @@ bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
 }
 
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                               uint64_t *dir_width, target_ulong level)
-{
-    switch (level) {
-    case 1:
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
-        break;
-    case 2:
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
-        break;
-    case 3:
-        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
-        break;
-    case 4:
-        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
-        break;
-    default:
-        /* level may be zero for ldpte */
-        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
-        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
-        break;
-    }
-}
-
 static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
                                 MMUAccessType access_type, int tlb_error)
 {
-- 
2.34.1


