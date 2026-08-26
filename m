Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E655BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5ut-0000EO-0D; Wed, 26 Aug 2026 01:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uq-00008m-Pa; Wed, 26 Aug 2026 01:11:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5up-0005LG-2G; Wed, 26 Aug 2026 01:11:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3WJhF956437; Wed, 26 Aug 2026 05:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UrGEWzy6RCMc+akbt
 WBemgYytxCu7xo456RSOqwZebs=; b=tQAgEU1U8XcywhmAIs2b+Qn9OFXAIYwOk
 Z+M9lfd7HaX09U8ont35e6PmkoQiqxpfjIwSKkSMjGuudqt87e/pLcIWqSd72kGI
 /c4xBIJbBSY/xlAlKxYcRcNNUhEkN5w5U77gpY7CZDOAXmnrdFdNeA4tPsuLnNOz
 dz7q/hNBxrcXsNlgZ0BXtRI8Q+cjJWF01AkEo1vPTjAxRIPUQ0uXJ50eaoMAbhoL
 JISTVaVpI1ehE3bFGALrbhBEb8oDvf1IszPgzI3lBwAjrnGeNrPpcsW3zdxdny3S
 0UzUT35vBi5at8Z04dXuvZ+FUm8huGIHYFB1jGtycT4tvHTxw3j1Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqvkts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4uH5V011616;
 Wed, 26 Aug 2026 05:11:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8asm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5B2bf45875700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F5F520040;
 Wed, 26 Aug 2026 05:11:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3B9020043;
 Wed, 26 Aug 2026 05:10:56 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:10:56 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 13/37] target/ppc: Move isync instruction to decodetree.
Date: Wed, 26 Aug 2026 10:38:39 +0530
Message-ID: <20260826050923.74756-14-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LUtQBMr8kjCSMSUiCEir1Zb4lQHPzcm2
X-Proofpoint-ORIG-GUID: 144rXFXgbf0mmWhIbAX3gmZmjed-5uyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX9vF1YyZhCM8i
 KHGDH0oaFqgSjp0SRUvDSEvPLQiA47jzrJH+/B5xAh/Kde6TG4jYHnEGfRKJuxIs7lom/DQnjug
 11SkjR8t3h2Dl0vwjBoEVMT/jZ4mQl+ilpUwmLfTZ2UyHDBeoHOa3YJ9kqy/WzhOEJY/Zy7Jtvm
 y4iA/DT48TTbwUY1JWSg91p20Vk30b4CHeUIiSwBOi+vQ+97IBG66Ni0S1cpX3c5vvc59rh60w2
 A7sm2LTpujPzWTICXS4+6M+9bA7FRdxg3Stq5aTTzYKFFoPAOvcq+Hy1Q0KmRn+YKmLIvVpPiTX
 s3vJP7mBtTleBxScfqyfmXjWOGxhOeoTurkZJc0so/1bZqvpZosJYV9E+p5+gCS8oADzDZMfW3C
 ZF/cuFA82NQ6zxj2b7W97dO4BFHGAIrTSvjJdUDuUlc4DIjAXoBxzoXe4Dmk68NlSf7QCVsbUu1
 bNWiDZwLy09hL1cG1Dw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8e756c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3RUvYVtxcIq7NUn8s_cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX0datzeBx+sOU
 VfdO+hESOnqZwH4+gDfR0ThCYj3d6sjIhqRxJg/DS6+E5nD3DZFLaKQa+oqjTyt4PDDEjhqLCzu
 ZqY9ZTxk1YxOSlQ+FevgEiTJvZsl4V0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Moving the following instructions to decodetree specification :
isync

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                     |  1 +
 target/ppc/translate.c                       | 15 ---------------
 target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index a1c2f549bd..91ece88a70 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1472,6 +1472,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
+ISYNC           010011 ----- ----- ----- 0010010110 -
 
 # Condition Register Field Instruction
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 179cb69dc5..a31cda4490 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2727,20 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
 #endif
 
-/* isync */
-static void gen_isync(DisasContext *ctx)
-{
-    /*
-     * We need to check for a pending TLB flush. This can only happen in
-     * kernel mode however so check MSR_PR
-     */
-    if (!ctx->pr) {
-        gen_check_tlb_flush(ctx, false);
-    }
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-}
-
 /* wait */
 static void gen_wait(DisasContext *ctx)
 {
@@ -5377,7 +5363,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index b8b4454663..943229c438 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -155,6 +155,23 @@ static bool trans_SLBFEE(DisasContext *ctx, arg_SLBFEE *a)
     return true;
 }
 
+static bool trans_ISYNC(DisasContext *ctx, arg_ISYNC *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, MEM);
+
+    /*
+     * We need to check for a pending TLB flush. This can only happen in
+     * kernel mode however so check MSR_PR
+     */
+    if (!ctx->pr) {
+        gen_check_tlb_flush(ctx, false);
+    }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+
+    return true;
+}
+
 static bool trans_SLBSYNC(DisasContext *ctx, arg_SLBSYNC *a)
 {
     REQUIRE_64BIT(ctx);
-- 
2.55.0


