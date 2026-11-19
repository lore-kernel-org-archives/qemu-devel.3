Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D8606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LNUSaMd+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9p-0003D0-OT; Thu, 19 Nov 2026 16:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9l-0003A1-JA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9h-0006Zf-7x
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:01 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUY1b3367508
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CL3ZNiB9dQU
 JQPHN6Kej7TfgEMRuSV1vdZyCqiGofIE=; b=LNUSaMd+ASSldz8DaS/JHQ2aD/7
 zO6T5KjBzLpw0XHZ0Vt+NMUltd+ku5AOdkcyPLtgyENVWNVrTMuD5WO7fFEvopkW
 HnVH6nUKQLzrbsX4cERZY5K4tywqRqiWllb9/7NAGV79+Lpk37NeGcsxSTjiMHZ4
 C+44Po9BynAf9LLoLH+ST7yAQ0VS1pxcwz0cYdVedWI1yJs26jOghJgGNHvC//S3
 RTFsF53DJeQpDSmcRsoRoseUKelNTV2VkKdjOSCRbyd+GV3jpT9FcTIRE8evM8+5
 pSHyC3kmy/SpUU7iluENQ/V1BMEfI7BbP7Vl5wxGQ3vHfg68s9WKSYqjYbg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rnbe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwrvv1783830; Thu, 19 Nov 2026 21:58:53 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJLwr1v1783802
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 4225825379; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 03/15] target/hexagon: suppress LR writes from a losing call
Date: Thu, 19 Nov 2026 13:58:41 -0800
Message-ID: <20261119215853.987158-4-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX5SOhgtmRPZ/j
 UKB4J8of6VerXnvQ/kFs3BlvYh3mWvY4ujC+i1SKeVM2xaPY9ZXqGqjHJfR46LoKicPQ2Zj1dh7
 YMWWVdyo+BwSO7aTux4AdQFCw0lINjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXzUskv7ZPWMjW
 NXyd8gTC6NrC2O3kmHHsjsodK2yVlk1EXMK7GoOBlD9eyvzyrd4xaE+WstxCP8FWVvIvUKQ75Bg
 XkjJOj9FoRWfXMbYV1bnh60LxnWUQ120pbyK80cX8APvD7SYKDY9V2ribMZrust6VZlmNt15kJm
 msT9ckxDZhTLdbJUeEz4VxmrKgRYgwnN5w2x+BPc29dVnM0xauqJW0dPriZaqkm49h00jvo7MJC
 l0xwgwSAjM3dXwvdfsv1f7l9VyKVH05yNQoK3IVqMiVmW9rv8E728OCt5JJTolZJCJNVld8MaTN
 5KEaoj2rwMzcJMHglPPzvNeYLFqDYu9lJitEhef6+NAAafUyH/k7A84JdzWw6IBt17iLlZ693xk
 13mkkWxexElXrCLBzvr44gqGu7Rzps4XaiE299DpEGbxishj8VwmUOPdoaR/fFzVqoym7HMtcsp
 HKED72p76XnTmrnsFpA==
X-Proofpoint-GUID: aIz21IneoR_iKerfaW-Esjlv3iyZZb61
X-Proofpoint-ORIG-GUID: aIz21IneoR_iKerfaW-Esjlv3iyZZb61
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=-Ps3b4u8n0j1yV-_ekcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A call after a taken branch must not update LR. Guard direct and
indirect calls with the packet branch state, and preserve LR when a
multi-branch packet uses deferred register commit.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/genptr.c         | 14 +++++++++++---
 target/hexagon/translate.c      |  4 ++++
 tests/tcg/hexagon/packet_user.c | 26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index d226cc4ebb..954dea6622 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1058,27 +1058,35 @@ static void gen_jumpr(DisasContext *ctx, TCGv new_pc)
 static void gen_call(DisasContext *ctx, int pc_off)
 {
     TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
+    TCGLabel *skip = gen_new_label();
+    if (ctx->pkt.pkt_has_multi_cof) {
+        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, skip);
+    }
     tcg_gen_movi_tl(lr, ctx->next_PC);
     gen_write_new_pc_pcrel(ctx, pc_off, TCG_COND_ALWAYS, NULL);
+    gen_set_label(skip);
 }
 
 static void gen_callr(DisasContext *ctx, TCGv new_pc)
 {
     TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
+    TCGLabel *skip = gen_new_label();
 
     new_pc = gen_unalias_gpr_src(new_pc, lr);
+    if (ctx->pkt.pkt_has_multi_cof) {
+        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, skip);
+    }
     tcg_gen_movi_tl(lr, ctx->next_PC);
     gen_write_new_pc_addr(ctx, new_pc, TCG_COND_ALWAYS, NULL);
+    gen_set_label(skip);
 }
 
 static void gen_cond_call(DisasContext *ctx, TCGv pred,
                           TCGCond cond, int pc_off)
 {
-    TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
     TCGLabel *skip = gen_new_label();
-    gen_write_new_pc_pcrel(ctx, pc_off, cond, pred);
     tcg_gen_brcondi_tl(cond, pred, 1, skip);
-    tcg_gen_movi_tl(lr, ctx->next_PC);
+    gen_call(ctx, pc_off);
     gen_set_label(skip);
 }
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index ec1d79e31f..10ed73590c 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -495,6 +495,10 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
     if (GET_ATTRIB(opcode, attrib)) {
         bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC);
 
+        if (rnum == HEX_REG_LR && ctx->pkt.pkt_has_multi_cof) {
+            is_predicated = true;
+        }
+
         /* LC0/LC1 is conditionally written by endloop instructions */
         if ((rnum == HEX_REG_LC0 || rnum == HEX_REG_LC1) &&
             (opcode == J2_endloop0 ||
diff --git a/tests/tcg/hexagon/packet_user.c b/tests/tcg/hexagon/packet_user.c
index 1343a0287a..4b23a02a79 100644
--- a/tests/tcg/hexagon/packet_user.c
+++ b/tests/tcg/hexagon/packet_user.c
@@ -47,10 +47,36 @@ static void test_usr_mask(void)
     check32(value, 0x3fffff7f);
 }
 
+static void test_call_priority(void)
+{
+    unsigned lr;
+
+    asm volatile(
+        "r12 = r31\n"
+        "r31 = ##0x12345678\n"
+        "r0 = #0\n"
+        "p0 = cmp.eq(r0,r0)\n"
+        "{\n"
+        "    if (p0) jump 1f\n"
+        "    call 2f\n"
+        "}\n"
+        "2:\n"
+        "r31 = #0\n"
+        "1:\n"
+        "%[lr] = r31\n"
+        "r31 = r12\n"
+        : [lr] "=&r"(lr)
+        : : "r0", "r12", "r31", "p0"
+    );
+    /* Losing call preserves LR. */
+    check32(lr, 0x12345678);
+}
+
 int main(void)
 {
     test_predicate_read();
     test_usr_mask();
+    test_call_priority();
     puts(err ? "FAIL" : "PASS");
     return err != 0;
 }
-- 
2.43.0


