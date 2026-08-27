Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A3AC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaD9-0002ta-W7; Thu, 27 Aug 2026 09:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaD8-0002l2-4u; Thu, 27 Aug 2026 09:32:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaD6-0001ef-5f; Thu, 27 Aug 2026 09:32:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVUeY3001423; Thu, 27 Aug 2026 13:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Btc9obUmYoHV1fn3j
 iZTDp00c1uIZZxA7He4Beox9tM=; b=HbHoVCqdfPBsUbZLbNEh31jEzJwT3FQvZ
 321UnM+pxBrbO01qo90+axTUpiuW6YnTYo/a2Anlam8Waa/R0JnM9LFv2FfzCjh/
 jLd6cd4MoeIv0rM9X7tFkbuxlkXxUS6ht8HJDykfSygm2o3Curr4o9VioYtJa4SN
 OdS0K5qqA/KgOq0EunXR9iI1NObLUJNYi2uV5JWg+UzCQwHyRVvHpp9X3alkxLv+
 Rj6ap72fG9ACuhwSLqDMk0Q0X5If3RS4D9cxIDOAeFJk8a9hHTbTy8qvu6ebeJJC
 kMqSRIp3cjYFlvPZxIdUtIAR0tdIKIcZXaF2hluB6vjX3bOqJOMKw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g55pd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQGHR003834;
 Thu, 27 Aug 2026 13:31:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwgcsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDVtru33095950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:31:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B123420043;
 Thu, 27 Aug 2026 13:31:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A50A820040;
 Thu, 27 Aug 2026 13:31:49 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:31:49 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 13/37] target/ppc: Move isync instruction to decodetree
Date: Thu, 27 Aug 2026 18:59:28 +0530
Message-ID: <20260827133010.278889-14-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NWx_l8Vub2wSgaIjntVhoPbvITuhxfe7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX/RUgjrQqkb4E
 ylZswZMDbTnVcUbtRPZ/n2Q74heV9VtIXdLdhSqRVCp++0Whv/YvkTOTZhSfP4vu/jnykrazSHy
 MaBoikcs5efED5CHrrHee3rt0xHhyqw=
X-Proofpoint-GUID: y7GIIarVejc0Bud_rd0Gh1kfNT-mmyDS
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a903c51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3RUvYVtxcIq7NUn8s_cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXyMDwwrx9lvaU
 sK3uiAelYkZ7mW5ihjf/W9iLxRQC2IhdyTv9TL+WCaTGxnTAjRh1rF0Or9qKY+C81/D//N5ehgI
 XyDgEB6SUOmdVRv+Tnwat+a97/MzrqXSfiY5MG9v97rceOn6rc/ubdbchfx4C6FeX634oGekx4d
 WKkRhNbqHcT44F24PHNUFkEm/i4whUUhx0hW0fb+rQrJ8ap+qAOPgl6BSsgAR3PMHCx2U5TVE3d
 Px0Z2rH7Q8VtpGgw7hYft4VaUhi/D2gQWiiDcyBPCCSUO4CVB8jgvW+fOhQayEZtR71UuYXGa66
 0Y7PuOTsdnwVd84+mMYjK1eX+rbpbHRv29F9ymB1BwBxHrhvYbLw9QnahXbexB8qaV9jg++zjvA
 rrouzyDfDQgOpZdCY5N7VoBS5KKZhs1MVGQGHXl3ycKUdY7l2XbQ444isrBVBcBtKmBQj3EBYun
 Hd/YaJ9Z8cXLWLsSyjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
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
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                     |  1 +
 target/ppc/translate.c                       | 15 ---------------
 target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e8326a9d0b..6fb7754566 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1470,6 +1470,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
+ISYNC           010011 ----- ----- ----- 0010010110 -
 
 # Condition Register Field Instruction
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c44cffb5e8..84589716b3 100644
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
@@ -5364,7 +5350,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
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


