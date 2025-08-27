Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F336CA0FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBEE-0000jc-KH; Wed, 27 Aug 2025 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urBE1-0000ar-Vl
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urBDy-0004BL-Gt
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:09:45 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxM9A6va5ocbADAA--.7195S3;
 Wed, 27 Aug 2025 16:09:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxXME4va5oWKVrAA--.18662S7;
 Wed, 27 Aug 2025 16:09:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] target/loongarch: Add common function
 get_tlb_random_index()
Date: Wed, 27 Aug 2025 16:09:20 +0800
Message-Id: <20250827080927.1644016-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250827080927.1644016-1-maobibo@loongson.cn>
References: <20250827080927.1644016-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXME4va5oWKVrAA--.18662S7
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

With software PTW system, tlb index is calculated randomly when new
TLB entry is added. For hardware PTW, it is the same logic to add
new TLB entry.

Here common function get_tlb_random_index() is added to get random
tlb index when adding new TLB entry.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 39 +++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index fa216b92fd..67b8f95849 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -390,31 +390,21 @@ void helper_tlbwr(CPULoongArchState *env)
     old->tlb_entry1 = new.tlb_entry1;
 }
 
-void helper_tlbfill(CPULoongArchState *env)
+static int get_tlb_random_index(CPULoongArchState *env, vaddr addr, int ps)
 {
-    uint64_t address, entryhi;
+    vaddr address;
     int index, set, i, stlb_idx;
-    uint16_t pagesize, stlb_ps;
+    uint16_t stlb_ps;
     uint16_t asid, tlb_asid;
     LoongArchTLB *tlb;
     uint8_t tlb_e;
 
-    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
-        entryhi = env->CSR_TLBREHI;
-        /* Validity of pagesize is checked in helper_ldpte() */
-        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
-    } else {
-        entryhi = env->CSR_TLBEHI;
-        /* Validity of pagesize is checked in helper_tlbrd() */
-        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
-    }
-
     /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
     asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-    if (pagesize == stlb_ps) {
+    if (ps == stlb_ps) {
         /* Only write into STLB bits [47:13] */
-        address = entryhi & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
+        address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
         set = -1;
         stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
         for (i = 0; i < 8; ++i) {
@@ -459,6 +449,25 @@ void helper_tlbfill(CPULoongArchState *env)
         }
     }
 
+    return index;
+}
+
+void helper_tlbfill(CPULoongArchState *env)
+{
+    uint64_t entryhi;
+    int index, pagesize;
+
+    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
+        entryhi = env->CSR_TLBREHI;
+        /* Validity of pagesize is checked in helper_ldpte() */
+        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
+    } else {
+        entryhi = env->CSR_TLBEHI;
+        /* Validity of pagesize is checked in helper_tlbrd() */
+        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
+    }
+
+    index = get_tlb_random_index(env, entryhi, pagesize);
     invalidate_tlb(env, index);
     fill_tlb_entry(env, env->tlb + index);
 }
-- 
2.39.3


