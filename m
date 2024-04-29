Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 05:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1JLP-00037P-4g; Mon, 29 Apr 2024 01:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKi-0002uV-73; Mon, 29 Apr 2024 01:13:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKe-0005iM-Tp; Mon, 29 Apr 2024 01:13:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T4wrlk029270; Mon, 29 Apr 2024 05:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XLF4bijiOIOWa07QxKbcpbnwTozlQcUcaMGf7HqF+Js=;
 b=Tig/SACTyh7cImLfovLD+2UeUM+MKva9DB7buERMrx86tyPfI4powimw4BwFHxcvH7Bb
 MOPlVcXl5LQv7YHpLppwYeI521teMfNyVXocMVBQLeJUPGOkp5tyQjEyNSj7eLnhz3qC
 J8MIWni9zOcJX3wqQAfA8OFTkBQaxZI4VhodJC+8aZTtRjtqxANauPB3H2FTEcpbMew5
 sgP1zLkz/jiTsnvFZnO0nYMeFZsLlqbaO7chkyspYRae6eBrYuYvQe+XOlg81WhUlXYN
 iA3zT933GnSTIZ/2W0DWcS67KWDU7HYbQGpCHM1A+Q6oImXaSHH9mgNm17HnowcdImXU 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt50b80my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:39 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T5Dcu3016669;
 Mon, 29 Apr 2024 05:13:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt50b80mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T4RFOj003000; Mon, 29 Apr 2024 05:13:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp5e2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43T5DXJE46203210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 05:13:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D103C2004B;
 Mon, 29 Apr 2024 05:13:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 572A320040;
 Mon, 29 Apr 2024 05:13:32 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.12.153])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Apr 2024 05:13:32 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 2/3] target/ppc: Move VMX integer logical instructions to
 decodetree.
Date: Mon, 29 Apr 2024 10:43:16 +0530
Message-Id: <20240429051317.289426-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240429051317.289426-1-rathc@linux.ibm.com>
References: <20240429051317.289426-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nvfltFaIotfpMMx58xbPNgfuLYKLjTnZ
X-Proofpoint-GUID: lQA4lAv9gwkXqG1Fyv1AhoHAXc9fPM85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_02,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404290033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Moving the following instructions to decodetree specification:

	v{and, andc, nand, or, orc, nor, xor, eqv}	: VX-form

The changes were verified by validating that the tcp ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode            | 11 +++++++++++
 target/ppc/translate/vmx-impl.c.inc | 22 ++++++++++------------
 target/ppc/translate/vmx-ops.c.inc  | 15 ---------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 27655f0d9e..e00bc05381 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -574,6 +574,17 @@ VCMPNEZW        000100 ..... ..... ..... . 0110000111   @VC
 VCMPSQ          000100 ... -- ..... ..... 00101000001   @VX_bf
 VCMPUQ          000100 ... -- ..... ..... 00100000001   @VX_bf
 
+## Vector Integer Logical Instructions
+
+VAND            000100 ..... ..... ..... 10000000100    @VX
+VANDC           000100 ..... ..... ..... 10001000100    @VX
+VNAND           000100 ..... ..... ..... 10110000100    @VX
+VOR             000100 ..... ..... ..... 10010000100    @VX
+VORC            000100 ..... ..... ..... 10101000100    @VX
+VNOR            000100 ..... ..... ..... 10100000100    @VX
+VXOR            000100 ..... ..... ..... 10011000100    @VX
+VEQV            000100 ..... ..... ..... 11010000100    @VX
+
 ## Vector Integer Average Instructions
 
 VAVGSB          000100 ..... ..... ..... 10100000010    @VX
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 4d5e743cfe..cefe04127c 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -205,16 +205,6 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
            16, 16);                                                     \
 }
 
-/* Logical operations */
-GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
-GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
-GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
-GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
-GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
-GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
-GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
-GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
-
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 static void glue(gen_, name)(DisasContext *ctx)                         \
 {                                                                       \
@@ -727,6 +717,16 @@ TRANS_FLAGS(ALTIVEC, VRLH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_rotlv)
 TRANS_FLAGS(ALTIVEC, VRLW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_rotlv)
 TRANS_FLAGS2(ALTIVEC_207, VRLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_rotlv)
 
+/* Logical operations */
+TRANS_FLAGS(ALTIVEC, VAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_and);
+TRANS_FLAGS(ALTIVEC, VANDC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_andc);
+TRANS_FLAGS(ALTIVEC, VOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_or);
+TRANS_FLAGS(ALTIVEC, VXOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_xor);
+TRANS_FLAGS(ALTIVEC, VNOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nor);
+TRANS_FLAGS2(ALTIVEC_207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
+TRANS_FLAGS2(ALTIVEC_207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
+TRANS_FLAGS2(ALTIVEC_207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
+
 static TCGv_vec do_vrl_mask_vec(unsigned vece, TCGv_vec vrb)
 {
     TCGv_vec t0 = tcg_temp_new_vec_matching(vrb),
@@ -3331,8 +3331,6 @@ TRANS_FLAGS2(ISA310, VMODUQ, do_vx_helper, gen_helper_VMODUQ)
 #undef DIVS64
 #undef DIVU64
 
-#undef GEN_VX_LOGICAL
-#undef GEN_VX_LOGICAL_207
 #undef GEN_VXFORM
 #undef GEN_VXFORM_207
 #undef GEN_VXFORM_DUAL
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 672fba3796..80c5217749 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -1,18 +1,3 @@
-#define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
-GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
-
-#define GEN_VX_LOGICAL_207(name, tcg_op, opc2, opc3) \
-GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ALTIVEC_207)
-
-GEN_VX_LOGICAL(vand, tcg_gen_and_i64, 2, 16),
-GEN_VX_LOGICAL(vandc, tcg_gen_andc_i64, 2, 17),
-GEN_VX_LOGICAL(vor, tcg_gen_or_i64, 2, 18),
-GEN_VX_LOGICAL(vxor, tcg_gen_xor_i64, 2, 19),
-GEN_VX_LOGICAL(vnor, tcg_gen_nor_i64, 2, 20),
-GEN_VX_LOGICAL_207(veqv, tcg_gen_eqv_i64, 2, 26),
-GEN_VX_LOGICAL_207(vnand, tcg_gen_nand_i64, 2, 22),
-GEN_VX_LOGICAL_207(vorc, tcg_gen_orc_i64, 2, 21),
-
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
 
-- 
2.39.3


