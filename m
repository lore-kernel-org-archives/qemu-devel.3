Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88957C369AE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48ad-0004Hb-A8; Sun, 13 Apr 2025 21:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u48aD-000430-DG
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:26:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u48a9-000368-Rt
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 21:25:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxbeINZPxnnXO8AA--.12168S3;
 Mon, 14 Apr 2025 09:25:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzxsJZPxnTz6AAA--.562S5;
 Mon, 14 Apr 2025 09:25:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/loongarch: Move function get_dir_base_width to
 common directory
Date: Mon, 14 Apr 2025 09:25:26 +0800
Message-Id: <20250414012528.4075447-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250414012528.4075447-1-maobibo@loongson.cn>
References: <20250414012528.4075447-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxsJZPxnTz6AAA--.562S5
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

Function get_dir_base_width() is used by loongarch_page_table_walker(),
so it is used by KVM mode also, here move this function from directory
tcg to common directory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu_helper.c     | 28 ++++++++++++++++++++++++++++
 target/loongarch/tcg/tlb_helper.c | 28 ----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 386a3f33ef..6736a9a330 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -156,6 +156,34 @@ static int loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
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
2.39.3


