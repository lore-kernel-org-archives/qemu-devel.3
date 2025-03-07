Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD73C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNeN-0007T0-U4; Thu, 06 Mar 2025 21:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tqNeL-0007Sh-F6
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tqNeI-0006il-RC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:21 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxmnHJXMpnUgaNAA--.44282S3;
 Fri, 07 Mar 2025 10:41:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxLsfAXMpnQro6AA--.23941S3;
 Fri, 07 Mar 2025 10:41:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 1/2] target/loongarch: fix 'make check-functional' failed
Date: Fri,  7 Mar 2025 10:19:33 +0800
Message-Id: <20250307021934.1080115-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250307021934.1080115-1-gaosong@loongson.cn>
References: <20250307021934.1080115-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfAXMpnQro6AA--.23941S3
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

 some tlb instructions get  the tlb_ps from tlb->misc but the
 value may has been initialized to 0,just check the tlb_ps skip
 the function and write a log.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250305063311.830674-2-gaosong@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a323606e5a..27c729b5b5 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -123,7 +123,11 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
     uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
+    uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+    if (!tlb_e) {
+        return;
+    }
     if (index >= LOONGARCH_STLB) {
         tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
     } else {
@@ -427,7 +431,11 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+        uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+        if (!tlb_e) {
+            continue;
+        }
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         } else {
@@ -456,7 +464,11 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
         uint64_t vpn, tlb_vppn;
         uint8_t tlb_ps, compare_shift;
+        uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
 
+        if (!tlb_e) {
+            continue;
+        }
         if (i >= LOONGARCH_STLB) {
             tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
         } else {
-- 
2.34.1


