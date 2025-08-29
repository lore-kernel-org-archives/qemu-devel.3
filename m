Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904EFCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3a-0001i4-Pf; Sat, 30 Aug 2025 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpH8-0008Q0-94
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpH5-0007AT-P5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjr+XFrFouG4EAA--.7879S3;
 Fri, 29 Aug 2025 10:55:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S13;
 Fri, 29 Aug 2025 10:55:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/14] target/loongarch: Use MMUContext in
 loongarch_get_addr_from_tlb
Date: Fri, 29 Aug 2025 10:55:04 +0800
Message-Id: <20250829025507.2315073-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S13
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

With function loongarch_get_addr_from_tlb(), parameter MMUContext
is added and remove parameter physical, prot and address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu_helper.c        |  7 +++++--
 target/loongarch/tcg/tcg_loongarch.h |  4 ++--
 target/loongarch/tcg/tlb_helper.c    | 18 +++++-------------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index cd61b33ef9..0cc01a0ca4 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -173,9 +173,12 @@ static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
 
     context.addr = address;
     if (tcg_enabled()) {
-        ret = loongarch_get_addr_from_tlb(env, physical, prot, address,
-                                          access_type, mmu_idx);
+        ret = loongarch_get_addr_from_tlb(env, &context, access_type, mmu_idx);
         if (ret != TLBRET_NOMATCH) {
+            if (ret == TLBRET_MATCH) {
+                *physical = context.physical;
+                *prot = context.prot;
+            }
             return ret;
         }
     }
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 488700c3c3..47702893e3 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -15,8 +15,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
 
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
+                                   MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx);
 
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 703ab9c8ca..64a4e82dec 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -663,24 +663,16 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, vaddr address,
+TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
+                                   MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
-    MMUContext context;
-    TLBRet ret;
 
-    context.addr = address;
-    match = loongarch_tlb_search(env, address, &index);
+    match = loongarch_tlb_search(env, context->addr, &index);
     if (match) {
-        ret = loongarch_map_tlb_entry(env, &context, access_type, index,
-                                      mmu_idx);
-        if (ret == TLBRET_MATCH) {
-            *physical = context.physical;
-            *prot = context.prot;
-        }
-        return ret;
+        return loongarch_map_tlb_entry(env, context, access_type, index,
+                                       mmu_idx);
     }
 
     return TLBRET_NOMATCH;
-- 
2.43.5


