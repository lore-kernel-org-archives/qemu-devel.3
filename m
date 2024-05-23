Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A588AC25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA54M-00022Q-5O; Thu, 23 May 2024 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54K-00021t-TW; Thu, 23 May 2024 05:49:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sA54F-0001Vp-Nc; Thu, 23 May 2024 05:49:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N9klcf008251; Thu, 23 May 2024 09:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XH29/9XE0QCtRF7QxCS4oIwm5vjM4jRp7w4ld3zHy/o=;
 b=lXu/oKabEi0EtYN0GGjj/WPMz+SJefX4hNtt3FRCG7HU+1TsPSUKH5oOwQEcDR/X4UZo
 UwLyjb2aCh7/Eq0z0QyGADTiZT+W/GzcAWc5t+CumGEAhrPwGsMKJeZJek6W3HQl5rsQ
 Cv34jkGgzNwWk/I632p+0mMysdRckZfyeQjOgDWB44POOfjcOTzoB1eiNDa2TRfXrYEp
 YbumpzB+l6U3MnX8EQoEHTeS9hGGRKNGqISHno97aTZfNggJR5b5BTbFhL22TsfY7aFa
 JSQwYCuhhSDC/WIqzInCkimqPph0B2xsMRNQmCEp6hy4+1RcUjRe/5+MLKXSXV08HiFx KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya36682a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:57 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N9muHq014241;
 Thu, 23 May 2024 09:48:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya36682a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N8kct6007817; Thu, 23 May 2024 09:48:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vm8vrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 09:48:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N9mqGI41288042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 09:48:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 063F820040;
 Thu, 23 May 2024 09:48:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C91C220043;
 Thu, 23 May 2024 09:48:50 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 09:48:50 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 3/3] target/ppc: Move VSX logical instructions to decodetree.
Date: Thu, 23 May 2024 15:18:21 +0530
Message-Id: <20240523094821.124014-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523094821.124014-1-rathc@linux.ibm.com>
References: <20240523094821.124014-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aARZwok_ApHzGHzQNhDKHo0PXbG-1PQV
X-Proofpoint-ORIG-GUID: tGTQm2OZ5-8UlJ9OWXBzij7oB7-hakf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=759 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Moving the following instructions to decodetree specification :

	xxl{and, andc, or, orc, nor, xor, nand, eqv}	: XX3-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            | 11 ++++++++
 target/ppc/translate/vsx-impl.c.inc | 39 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 11 --------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 9ed8e33cc8..30d6f9f750 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -937,6 +937,17 @@ XXMFACC         011111 ... -- 00000 ----- 0010110001 -   @X_a
 XXMTACC         011111 ... -- 00001 ----- 0010110001 -   @X_a
 XXSETACCZ       011111 ... -- 00011 ----- 0010110001 -   @X_a
 
+## VSX Vector Logical instructions
+
+XXLAND          111100 ..... ..... ..... 10000010 ...   @XX3
+XXLANDC         111100 ..... ..... ..... 10001010 ...   @XX3
+XXLOR           111100 ..... ..... ..... 10010010 ...   @XX3
+XXLXOR          111100 ..... ..... ..... 10011010 ...   @XX3
+XXLNOR          111100 ..... ..... ..... 10100010 ...   @XX3
+XXLEQV          111100 ..... ..... ..... 10111010 ...   @XX3
+XXLNAND         111100 ..... ..... ..... 10110010 ...   @XX3
+XXLORC          111100 ..... ..... ..... 10101010 ...   @XX3
+
 ## VSX GER instruction
 
 XVI4GER8        111011 ... -- ..... ..... 00100011 ..-  @XX3_at xa=%xx_xa
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0d16e0f02b..a769f199ce 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -1573,26 +1573,24 @@ static void gen_xxbrw(DisasContext *ctx)
     set_cpu_vsr(xT(ctx->opcode), xtl, false);
 }
 
-#define VSX_LOGICAL(name, vece, tcg_op)                              \
-static void glue(gen_, name)(DisasContext *ctx)                      \
-    {                                                                \
-        if (unlikely(!ctx->vsx_enabled)) {                           \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
-            return;                                                  \
-        }                                                            \
-        tcg_op(vece, vsr_full_offset(xT(ctx->opcode)),               \
-               vsr_full_offset(xA(ctx->opcode)),                     \
-               vsr_full_offset(xB(ctx->opcode)), 16, 16);            \
-    }
-
-VSX_LOGICAL(xxland, MO_64, tcg_gen_gvec_and)
-VSX_LOGICAL(xxlandc, MO_64, tcg_gen_gvec_andc)
-VSX_LOGICAL(xxlor, MO_64, tcg_gen_gvec_or)
-VSX_LOGICAL(xxlxor, MO_64, tcg_gen_gvec_xor)
-VSX_LOGICAL(xxlnor, MO_64, tcg_gen_gvec_nor)
-VSX_LOGICAL(xxleqv, MO_64, tcg_gen_gvec_eqv)
-VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
-VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
+static bool do_logical_op(DisasContext *ctx, arg_XX3 *a, unsigned vece,
+    void (*helper)(unsigned, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t))
+{
+    REQUIRE_VSX(ctx);
+    helper(vece, vsr_full_offset(a->xt),
+            vsr_full_offset(a->xa),
+            vsr_full_offset(a->xb), 16, 16);
+    return true;
+}
+
+TRANS_FLAGS2(VSX, XXLAND, do_logical_op, MO_64, tcg_gen_gvec_and);
+TRANS_FLAGS2(VSX, XXLANDC, do_logical_op, MO_64, tcg_gen_gvec_andc);
+TRANS_FLAGS2(VSX, XXLOR, do_logical_op, MO_64, tcg_gen_gvec_or);
+TRANS_FLAGS2(VSX, XXLXOR, do_logical_op, MO_64, tcg_gen_gvec_xor);
+TRANS_FLAGS2(VSX, XXLNOR, do_logical_op, MO_64, tcg_gen_gvec_nor);
+TRANS_FLAGS2(VSX207, XXLEQV, do_logical_op, MO_64, tcg_gen_gvec_eqv);
+TRANS_FLAGS2(VSX207, XXLNAND, do_logical_op, MO_64, tcg_gen_gvec_nand);
+TRANS_FLAGS2(VSX207, XXLORC, do_logical_op, MO_64, tcg_gen_gvec_orc);
 
 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext *ctx)             \
@@ -2899,4 +2897,3 @@ TRANS64(PMXVF64GERNN, do_ger, gen_helper_XVF64GERNN)
 #undef GEN_XX2IFORM
 #undef GEN_XX3_RC_FORM
 #undef GEN_XX3FORM_DM
-#undef VSX_LOGICAL
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 18510d757d..3c0a70cb7c 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -263,17 +263,6 @@ GEN_XX2FORM_EO(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300),
 GEN_XX2FORM_EO(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300),
 GEN_XX2FORM_EO(xxbrq, 0x16, 0x1D, 0x1F, PPC2_ISA300),
 
-#define VSX_LOGICAL(name, opc2, opc3, fl2) \
-GEN_XX3FORM(name, opc2, opc3, fl2)
-
-VSX_LOGICAL(xxland, 0x8, 0x10, PPC2_VSX),
-VSX_LOGICAL(xxlandc, 0x8, 0x11, PPC2_VSX),
-VSX_LOGICAL(xxlor, 0x8, 0x12, PPC2_VSX),
-VSX_LOGICAL(xxlxor, 0x8, 0x13, PPC2_VSX),
-VSX_LOGICAL(xxlnor, 0x8, 0x14, PPC2_VSX),
-VSX_LOGICAL(xxleqv, 0x8, 0x17, PPC2_VSX207),
-VSX_LOGICAL(xxlnand, 0x8, 0x16, PPC2_VSX207),
-VSX_LOGICAL(xxlorc, 0x8, 0x15, PPC2_VSX207),
 GEN_XX3FORM(xxmrghw, 0x08, 0x02, PPC2_VSX),
 GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
 GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
-- 
2.39.3


