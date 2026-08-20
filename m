Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD14C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3OF-0003QV-Gx; Thu, 20 Aug 2026 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3O6-0003Ky-D0; Thu, 20 Aug 2026 10:04:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3O4-0006Gy-Lv; Thu, 20 Aug 2026 10:04:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8Z7iW3543497; Thu, 20 Aug 2026 14:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/DI9D/iO+8rzrHQA4
 7wtxYUTNNp6nnhIJpU8qRIvUic=; b=VqyNkKjOnol1FLxdcSq/Pf3i9qgZq308p
 7Rk5eQGB6fey1UqXSIWONGFTi5dy6t4ewvioN1LmnMFSbzE+IEK+iN1QUX0ViZ8p
 cRVhyoAcuRCWpCZLPfLV/Zjnhmt5Ubq4iNFEU3XxDGeMnSlK4KZwgOCcos1t6Q15
 0eT7uUOL9F4fD83N9ZfQitEMBMoJuH0QZ7P/yjrkv/6/Gi4qPSibAAv2DpwUIcQx
 4SSreCzyqexr2Q04DYn7PcMqGOAQkwmDdNBJJeSKqxiAbUx51Ca9ZE/p2Xa1ZdOt
 v9GLz8LvnGXGoSCdjHDPZ0D81XVwXuG393GXpexY2kXTtgmkXlorA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2an7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuLid014910;
 Thu, 20 Aug 2026 14:04:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngpqa5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE4lx446530870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:04:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E91452004D;
 Thu, 20 Aug 2026 14:04:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51DC20040;
 Thu, 20 Aug 2026 14:04:37 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:04:36 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 13/29] target/ppc: Move isync instruction to decodetree.
Date: Thu, 20 Aug 2026 19:30:42 +0530
Message-ID: <20260820140114.327023-14-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a870986 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=3RUvYVtxcIq7NUn8s_cA:9
X-Proofpoint-GUID: 21m2ZHslwMVCAMwOC6ddNsrkZf0TTXSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/KrAimEUoaL+
 39adSL6s3MrEyhx4uwQF6w+hsWK89/BfpkVd/EGMO8v3kPc7ivrXt+19eS1RYEXsYh8Zj82WB9s
 uRzNRvyVNji5pMq81E/ytuI+gQweszwYdqgu2SE6uIf4WyigSZuGJsAZxowkNV5/7ToFtHnxCwM
 nPB2600q7KlaaCr7tTM6gHK8yWBRWCLBJqmQgOr+cuPeGirj3uq5FZhnP8hPbbJLFzUUBiD1J0w
 C4g0EkfYie0xkmfEGMgSixrxPpkG8im6Sbm5Zxbr6W0XfqG31x6fzsiYtvNvnVeDDL2k9UL5isp
 Y3RZeh79bSAm6LAetvTwQhk0q5xGJmhjjFma7cV8I//MgBR8xanww9oBnGAP2MSplh2mm6tYHnZ
 CTtn/qtYdB8sSphk5BwA6kMU5RsKaF0weBahm9iFgOp/nhIijtcUbc4QBvWywYwbBRdbEYeWuKV
 +JaUkFerXrNlV4NClQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX5BE0mICjI+tq
 GyeIrLxfOvnQBscHgleF3LsbO8/F/TzShYxDJPoN0/VBzVyCrA5XjgbBCpBonrUjIXX/VIR0Jtm
 xW1UCZIL2CpwO8Kqe45D7vr6bWN0I40=
X-Proofpoint-ORIG-GUID: qlPym5NUt7DP1S3QYCPHwSl2zyjKQ5X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


