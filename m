Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C04CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2n4l-0007Wq-Lm; Sun, 28 Sep 2025 04:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v2n4R-0007LX-6E
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v2n4G-00027M-LE
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxVNAo9thoS8sPAA--.32976S3;
 Sun, 28 Sep 2025 16:47:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8Eg9tho32y5AA--.23975S10;
 Sun, 28 Sep 2025 16:47:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 08/13] target/loongarch: Change return value type with
 loongarch_tlb_search_cb()
Date: Sun, 28 Sep 2025 16:47:23 +0800
Message-Id: <20250928084728.1972177-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250928084728.1972177-1-maobibo@loongson.cn>
References: <20250928084728.1972177-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8Eg9tho32y5AA--.23975S10
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

With function loongarch_tlb_search_cb(), change return value type from
bool type to pointer LoongArchTLB *, the pointer type can be use directly
in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 5b78146769..c7f30eaf15 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -203,8 +203,9 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
-                                    int *index, int csr_asid, tlb_match func)
+static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
+                                             vaddr vaddr, int csr_asid,
+                                             tlb_match func)
 {
     LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
@@ -229,8 +230,7 @@ static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
 
             if (func(tlb_g, csr_asid, tlb_asid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i * 256 + stlb_idx;
-                return true;
+                return tlb;
             }
         }
     }
@@ -248,12 +248,11 @@ static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
             vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
             if (func(tlb_g, csr_asid, tlb_asid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
-                *index = i;
-                return true;
+                return tlb;
             }
         }
     }
-    return false;
+    return NULL;
 }
 
 static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
@@ -261,10 +260,17 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 {
     int csr_asid;
     tlb_match func;
+    LoongArchTLB *tlb;
 
     func = tlb_match_any;
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    return loongarch_tlb_search_cb(env, vaddr, index, csr_asid, func);
+    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
+    if (tlb) {
+        *index = tlb - env->tlb;
+        return true;
+    }
+
+    return false;
 }
 
 void helper_tlbsrch(CPULoongArchState *env)
-- 
2.43.5


