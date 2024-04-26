Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B160C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 18:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Q78-00076A-3d; Fri, 26 Apr 2024 14:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s0Q76-00075h-6X
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 14:16:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s0Q74-0007Ru-A7
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 14:15:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDxCTC016246;
 Fri, 26 Apr 2024 18:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=XQPphpO
 Co3g5rcWhbUyCw6rQ1ie5pNKKdOz2b3S3l0w=; b=AvW9B/ftgUebUxP5nXheG/k
 xMXdYmGXrtf0c648s/iBxYKiZsS2kLD99YcprtstR+DXVsWV8whVsLvoq/cLOOb9
 +NYGoUsF6QNldWXQiqUyZnqVGqyfAb6e0oA45a7kba3kcTFu8YRoHfCk6bDxoIjn
 GbPfEgkyVcU7wRT9RYbPYDxuR1PwbqHihj+//dRixQjFpfp2tkRufMNuB/TrISUK
 726ialSDpBvAn8YE6fCDXEIWLytJoP4S7e/XcYbmf4SN0tHb4BEZ5Q1g1n4z9cyD
 un8GJ1KWqTe447Yqk93q6mjzHLvhvTFfDvV1iBkGmdOq6ZCWXk48EIT3cbYIC4Q=
 =
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrdmr0k5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 18:15:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QIFr9h007840
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 18:15:53 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 11:15:53 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <ltaylorsimpson@gmail.com>
Subject: [PATCH] Hexagon: add PC alignment check and exception
Date: Fri, 26 Apr 2024 15:15:39 -0300
Message-ID: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: PRQFDC3JzU_iSrsIyLsi_BY3_G-oJN2w
X-Proofpoint-GUID: PRQFDC3JzU_iSrsIyLsi_BY3_G-oJN2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_15,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Hexagon Programmer's Reference Manual says that the exception 0x1e
should be raised upon an unaligned program counter. Let's implement that
and also add tests for both the most common case as well as packets with
multiple change-of-flow instructions.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/cpu_bits.h                  |  1 +
 target/hexagon/translate.h                 |  2 ++
 target/hexagon/genptr.c                    | 21 ++++++++++++++++-----
 target/hexagon/translate.c                 |  2 +-
 tests/tcg/hexagon/Makefile.target          | 13 +++++++++++++
 tests/tcg/hexagon/unaligned_pc.S           | 10 ++++++++++
 tests/tcg/hexagon/unaligned_pc_multi_cof.S | 13 +++++++++++++
 7 files changed, 56 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/hexagon/unaligned_pc.S
 create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 96fef71729..d6900c8bda 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -23,6 +23,7 @@
 #define HEX_EXCP_FETCH_NO_UPAGE  0x012
 #define HEX_EXCP_INVALID_PACKET  0x015
 #define HEX_EXCP_INVALID_OPCODE  0x015
+#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
 #define HEX_EXCP_PRIV_NO_UREAD   0x024
 #define HEX_EXCP_PRIV_NO_UWRITE  0x025
 
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 4dd59c6726..daf11eb584 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -75,6 +75,8 @@ typedef struct DisasContext {
     TCGv dczero_addr;
 } DisasContext;
 
+void gen_exception_end_tb(DisasContext *ctx, int excp);
+
 static inline void ctx_log_pred_write(DisasContext *ctx, int pnum)
 {
     if (!test_bit(pnum, ctx->pregs_written)) {
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index dbae6c570a..c96edd9379 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
                                   TCGCond cond, TCGv pred)
 {
     TCGLabel *pred_false = NULL;
+    TCGLabel *branch_taken = NULL;
     if (cond != TCG_COND_ALWAYS) {
         pred_false = gen_new_label();
         tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
@@ -480,12 +481,22 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
 
     if (ctx->pkt->pkt_has_multi_cof) {
         /* If there are multiple branches in a packet, ignore the second one */
-        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
-                           ctx->branch_taken, tcg_constant_tl(0),
-                           hex_gpr[HEX_REG_PC], addr);
+        branch_taken = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_NE, ctx->branch_taken, 0, branch_taken);
         tcg_gen_movi_tl(ctx->branch_taken, 1);
-    } else {
-        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
+    }
+
+    TCGLabel *pc_aligned = gen_new_label();
+    TCGv pc_remainder = tcg_temp_new();
+    tcg_gen_andi_tl(pc_remainder, addr, PCALIGN_MASK);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, pc_remainder, 0, pc_aligned);
+    gen_exception_end_tb(ctx, HEX_EXCP_PC_NOT_ALIGNED);
+    gen_set_label(pc_aligned);
+
+    tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
+
+    if (ctx->pkt->pkt_has_multi_cof) {
+        gen_set_label(branch_taken);
     }
 
     if (cond != TCG_COND_ALWAYS) {
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index f163eefe97..e6ee63a53e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -185,7 +185,7 @@ static void gen_end_tb(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_end_tb(DisasContext *ctx, int excp)
+void gen_exception_end_tb(DisasContext *ctx, int excp)
 {
     gen_exec_counters(ctx);
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f839b2c0d5..02d7fff34c 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,19 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += unaligned_pc
+HEX_TESTS += unaligned_pc_multi_cof
+
+run-unaligned_pc: unaligned_pc
+run-unaligned_pc_multi_cof: unaligned_pc_multi_cof
+run-unaligned_pc run-unaligned_pc_multi_cof:
+	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on $(TARGET_NAME)"); \
+	if [ $$? -ne 1 ] ; then \
+		return 1; \
+	fi
+	$(call quiet-command, \
+		grep -q "exception 0x1e" $<.stderr, \
+		"GREP", "exception 0x1e");
 
 run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
 	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
diff --git a/tests/tcg/hexagon/unaligned_pc.S b/tests/tcg/hexagon/unaligned_pc.S
new file mode 100644
index 0000000000..39d6b2060b
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc.S
@@ -0,0 +1,10 @@
+test:
+	allocframe(#0x8)
+	r0 = #0xffffffff
+	framekey = r0
+	dealloc_return
+
+.global _start
+_start:
+	call test
+	jump pass
diff --git a/tests/tcg/hexagon/unaligned_pc_multi_cof.S b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
new file mode 100644
index 0000000000..a83e248ece
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
@@ -0,0 +1,13 @@
+.org 0x3
+test:
+	nop
+	jumpr r31
+
+.global _start
+_start:
+	p0 = cmp.eq(r0, r0)
+	{
+		if (p0) jump test
+		jump pass
+	}
+	jump pass
-- 
2.37.2


