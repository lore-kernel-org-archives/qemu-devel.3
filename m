Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E133AC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 09:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s65fw-0004xx-3s; Sun, 12 May 2024 05:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s65fv-0004xj-4J; Sun, 12 May 2024 05:39:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s65fs-0000Lj-GX; Sun, 12 May 2024 05:39:22 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44C9QEIc021578; Sun, 12 May 2024 09:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8NtxA+vgoWbTUG0IZlWw+GQ4WRD6m4m82wlmrTopK2M=;
 b=OfqD6iFxORIyi2Sm0SaoOe+4GSiCed3e0ZkMpHGqWtyPRUL/Ir23k63aJk7j0Ply3EsY
 0gl4agNpvGHLqTRlF9dmkjrZgvHeOXH3UmEP/NCBW00hJST9SUolWQ2TM4O4qsA/2yuH
 Nw3e/lE5bbqUjjRUh3mQFDFT743htDeG8dJICzuH0baxdJGr38zYXICdNOYGixk+4nLj
 5lHhvWlMhmOC30jzNp79BFVMubA5PtbG1e9nowdmQ4sMRiIxYoph+z5mfZb3UWSIqtJY
 2AroYD9Py5K+6pYjoQoNHmQsF1GANljdg2v3cMJvJUp47k3Xus6US75KfZDskd4dNITV RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2jqs0s2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:15 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44C9dEpH006227;
 Sun, 12 May 2024 09:39:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y2jqs0s28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44C8sf5H020165; Sun, 12 May 2024 09:39:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyhuke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 May 2024 09:39:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44C9dAEu51052900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 May 2024 09:39:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0403520043;
 Sun, 12 May 2024 09:39:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CA0620040;
 Sun, 12 May 2024 09:39:07 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.34.11])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 May 2024 09:39:07 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com,
 lucas.araujo@eldorado.org.br
Subject: [PATCH 1/1] target/ppc: Move VMX integer add/sub saturate insns to
 decodetree.
Date: Sun, 12 May 2024 15:08:47 +0530
Message-Id: <20240512093847.18099-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240512093847.18099-1-rathc@linux.ibm.com>
References: <20240512093847.18099-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dCgU6CRaHZJFFmcIsqNOtsmimVOKLTcK
X-Proofpoint-ORIG-GUID: rij28o3ngLH3kKmByLxubgAPZQ0at5Cg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405120071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Moving the following instructions to decodetree specification :

	v{add,sub}{u,s}{b,h,w}s		: VX-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                 |  24 +--
 target/ppc/insn32.decode            |  16 ++
 target/ppc/int_helper.c             |  22 +--
 target/ppc/translate/vmx-impl.c.inc | 242 ++++++++++++++++++++--------
 target/ppc/translate/vmx-ops.c.inc  |  19 +--
 5 files changed, 224 insertions(+), 99 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f397ef459a..2963e48fdc 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -200,18 +200,18 @@ DEF_HELPER_FLAGS_3(vsro, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(vsrv, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(vslv, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(VPRTYBQ, TCG_CALL_NO_RWG, void, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubsbs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubshs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubsws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vaddubs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vadduhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vadduws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsububs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubuhs, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
-DEF_HELPER_FLAGS_5(vsubuws, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDSWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBSWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VADDUWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUBS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUHS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
+DEF_HELPER_FLAGS_5(VSUBUWS, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_3(VADDUQM, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VADDECUQ, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VADDEUQM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 847a2f4356..d7d77eaa99 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -697,6 +697,14 @@ VADDCUW         000100 ..... ..... ..... 00110000000    @VX
 VADDCUQ         000100 ..... ..... ..... 00101000000    @VX
 VADDUQM         000100 ..... ..... ..... 00100000000    @VX
 
+VADDSBS         000100 ..... ..... ..... 01100000000    @VX
+VADDSHS         000100 ..... ..... ..... 01101000000    @VX
+VADDSWS         000100 ..... ..... ..... 01110000000    @VX
+
+VADDUBS         000100 ..... ..... ..... 01000000000    @VX
+VADDUHS         000100 ..... ..... ..... 01001000000    @VX
+VADDUWS         000100 ..... ..... ..... 01010000000    @VX
+
 VADDEUQM        000100 ..... ..... ..... ..... 111100   @VA
 VADDECUQ        000100 ..... ..... ..... ..... 111101   @VA
 
@@ -704,6 +712,14 @@ VSUBCUW         000100 ..... ..... ..... 10110000000    @VX
 VSUBCUQ         000100 ..... ..... ..... 10101000000    @VX
 VSUBUQM         000100 ..... ..... ..... 10100000000    @VX
 
+VSUBSBS         000100 ..... ..... ..... 11100000000    @VX
+VSUBSHS         000100 ..... ..... ..... 11101000000    @VX
+VSUBSWS         000100 ..... ..... ..... 11110000000    @VX
+
+VSUBUBS         000100 ..... ..... ..... 11000000000    @VX
+VSUBUHS         000100 ..... ..... ..... 11001000000    @VX
+VSUBUWS         000100 ..... ..... ..... 11010000000    @VX
+
 VSUBECUQ        000100 ..... ..... ..... ..... 111111   @VA
 VSUBEUQM        000100 ..... ..... ..... ..... 111110   @VA
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 0a5c3e78a4..aec2d3d4ec 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -541,7 +541,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
     }
 
 #define VARITHSAT_DO(name, op, optype, cvt, element)                    \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
+    void helper_V##name(ppc_avr_t *r, ppc_avr_t *vscr_sat,              \
                         ppc_avr_t *a, ppc_avr_t *b, uint32_t desc)      \
     {                                                                   \
         int sat = 0;                                                    \
@@ -555,17 +555,17 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | float_muladd_negate_c);
         }                                                               \
     }
 #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
-    VARITHSAT_DO(adds##suffix##s, +, optype, cvt, element)      \
-    VARITHSAT_DO(subs##suffix##s, -, optype, cvt, element)
+    VARITHSAT_DO(ADDS##suffix##S, +, optype, cvt, element)      \
+    VARITHSAT_DO(SUBS##suffix##S, -, optype, cvt, element)
 #define VARITHSAT_UNSIGNED(suffix, element, optype, cvt)        \
-    VARITHSAT_DO(addu##suffix##s, +, optype, cvt, element)      \
-    VARITHSAT_DO(subu##suffix##s, -, optype, cvt, element)
-VARITHSAT_SIGNED(b, s8, int16_t, cvtshsb)
-VARITHSAT_SIGNED(h, s16, int32_t, cvtswsh)
-VARITHSAT_SIGNED(w, s32, int64_t, cvtsdsw)
-VARITHSAT_UNSIGNED(b, u8, uint16_t, cvtshub)
-VARITHSAT_UNSIGNED(h, u16, uint32_t, cvtswuh)
-VARITHSAT_UNSIGNED(w, u32, uint64_t, cvtsduw)
+    VARITHSAT_DO(ADDU##suffix##S, +, optype, cvt, element)      \
+    VARITHSAT_DO(SUBU##suffix##S, -, optype, cvt, element)
+VARITHSAT_SIGNED(B, s8, int16_t, cvtshsb)
+VARITHSAT_SIGNED(H, s16, int32_t, cvtswsh)
+VARITHSAT_SIGNED(W, s32, int64_t, cvtsdsw)
+VARITHSAT_UNSIGNED(B, u8, uint16_t, cvtshub)
+VARITHSAT_UNSIGNED(H, u16, uint32_t, cvtswuh)
+VARITHSAT_UNSIGNED(W, u32, uint64_t, cvtsduw)
 #undef VARITHSAT_CASE
 #undef VARITHSAT_DO
 #undef VARITHSAT_SIGNED
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 8084af75cc..686ab3b125 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1047,58 +1047,6 @@ TRANS(VRLQ, do_vector_rotl_quad, false, false)
 TRANS(VRLQNM, do_vector_rotl_quad, true, false)
 TRANS(VRLQMI, do_vector_rotl_quad, false, true)
 
-#define GEN_VXFORM_SAT(NAME, VECE, NORM, SAT, OPC2, OPC3)               \
-static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
-                                         TCGv_vec sat, TCGv_vec a,      \
-                                         TCGv_vec b)                    \
-{                                                                       \
-    TCGv_vec x = tcg_temp_new_vec_matching(t);                          \
-    glue(glue(tcg_gen_, NORM), _vec)(VECE, x, a, b);                    \
-    glue(glue(tcg_gen_, SAT), _vec)(VECE, t, a, b);                     \
-    tcg_gen_cmp_vec(TCG_COND_NE, VECE, x, x, t);                        \
-    tcg_gen_or_vec(VECE, sat, sat, x);                                  \
-}                                                                       \
-static void glue(gen_, NAME)(DisasContext *ctx)                         \
-{                                                                       \
-    static const TCGOpcode vecop_list[] = {                             \
-        glue(glue(INDEX_op_, NORM), _vec),                              \
-        glue(glue(INDEX_op_, SAT), _vec),                               \
-        INDEX_op_cmp_vec, 0                                             \
-    };                                                                  \
-    static const GVecGen4 g = {                                         \
-        .fniv = glue(glue(gen_, NAME), _vec),                           \
-        .fno = glue(gen_helper_, NAME),                                 \
-        .opt_opc = vecop_list,                                          \
-        .write_aofs = true,                                             \
-        .vece = VECE,                                                   \
-    };                                                                  \
-    if (unlikely(!ctx->altivec_enabled)) {                              \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
-        return;                                                         \
-    }                                                                   \
-    tcg_gen_gvec_4(avr_full_offset(rD(ctx->opcode)),                    \
-                   offsetof(CPUPPCState, vscr_sat),                     \
-                   avr_full_offset(rA(ctx->opcode)),                    \
-                   avr_full_offset(rB(ctx->opcode)),                    \
-                   16, 16, &g);                                         \
-}
-
-GEN_VXFORM_SAT(vaddubs, MO_8, add, usadd, 0, 8);
-GEN_VXFORM_DUAL_EXT(vaddubs, PPC_ALTIVEC, PPC_NONE, 0,       \
-                    vmul10uq, PPC_NONE, PPC2_ISA300, 0x0000F800)
-GEN_VXFORM_SAT(vadduhs, MO_16, add, usadd, 0, 9);
-GEN_VXFORM_DUAL(vadduhs, PPC_ALTIVEC, PPC_NONE, \
-                vmul10euq, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_SAT(vadduws, MO_32, add, usadd, 0, 10);
-GEN_VXFORM_SAT(vaddsbs, MO_8, add, ssadd, 0, 12);
-GEN_VXFORM_SAT(vaddshs, MO_16, add, ssadd, 0, 13);
-GEN_VXFORM_SAT(vaddsws, MO_32, add, ssadd, 0, 14);
-GEN_VXFORM_SAT(vsububs, MO_8, sub, ussub, 0, 24);
-GEN_VXFORM_SAT(vsubuhs, MO_16, sub, ussub, 0, 25);
-GEN_VXFORM_SAT(vsubuws, MO_32, sub, ussub, 0, 26);
-GEN_VXFORM_SAT(vsubsbs, MO_8, sub, sssub, 0, 28);
-GEN_VXFORM_SAT(vsubshs, MO_16, sub, sssub, 0, 29);
-GEN_VXFORM_SAT(vsubsws, MO_32, sub, sssub, 0, 30);
 GEN_VXFORM_TRANS(vsl, 2, 7);
 GEN_VXFORM_TRANS(vsr, 2, 11);
 GEN_VXFORM_ENV(vpkuhum, 7, 0);
@@ -2641,26 +2589,14 @@ static void gen_xpnd04_2(DisasContext *ctx)
     }
 }
 
-
-GEN_VXFORM_DUAL(vsubsws, PPC_ALTIVEC, PPC_NONE, \
-                xpnd04_2, PPC_NONE, PPC2_ISA300)
-
 GEN_VXFORM_DUAL(vsububm, PPC_ALTIVEC, PPC_NONE, \
                 bcdadd, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vsububs, PPC_ALTIVEC, PPC_NONE, \
-                bcdadd, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM_DUAL(vsubuhm, PPC_ALTIVEC, PPC_NONE, \
                 bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vsubuhs, PPC_ALTIVEC, PPC_NONE, \
-                bcdsub, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM_DUAL(vaddshs, PPC_ALTIVEC, PPC_NONE, \
-                bcdcpsgn, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
                 bcds, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
                 bcdus, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
-                bcdtrunc, PPC_NONE, PPC2_ISA300)
 
 static void gen_vsbox(DisasContext *ctx)
 {
@@ -2934,6 +2870,184 @@ static bool do_vx_vaddsubcuw(DisasContext *ctx, arg_VX *a, int add)
     return true;
 }
 
+static inline void do_vadd_vsub_sat
+(
+    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
+    void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
+    void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    norm_op(vece, x, a, b);
+    sat_op(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+}
+
+static void gen_vadd_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_add_vec, tcg_gen_usadd_vec);
+}
+
+static void gen_vadd_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_add_vec, tcg_gen_ssadd_vec);
+}
+
+static void gen_vsub_sat_u(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_sub_vec, tcg_gen_ussub_vec);
+}
+
+static void gen_vsub_sat_s(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                           TCGv_vec a, TCGv_vec b)
+{
+    do_vadd_vsub_sat(vece, t, sat, a, b, tcg_gen_sub_vec, tcg_gen_sssub_vec);
+}
+
+static bool do_vx_vadd_vsub_sat(DisasContext *ctx, arg_VX *a,
+                                int sign, int vece, int add)
+{
+    static const TCGOpcode vecop_list_sub_u[] = {
+        INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
+    };
+    static const TCGOpcode vecop_list_sub_s[] = {
+        INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
+    };
+    static const TCGOpcode vecop_list_add_u[] = {
+        INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
+    };
+    static const TCGOpcode vecop_list_add_s[] = {
+        INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
+    };
+
+    static const GVecGen4 op[2][3][2] = {
+        {
+            {
+                {
+                    .fniv = gen_vsub_sat_u,
+                    .fno = gen_helper_VSUBUBS,
+                    .opt_opc = vecop_list_sub_u,
+                    .write_aofs = true,
+                    .vece = MO_8
+                },
+                {
+                    .fniv = gen_vadd_sat_u,
+                    .fno = gen_helper_VADDUBS,
+                    .opt_opc = vecop_list_add_u,
+                    .write_aofs = true,
+                    .vece = MO_8
+                },
+            },
+            {
+                {
+                    .fniv = gen_vsub_sat_u,
+                    .fno = gen_helper_VSUBUHS,
+                    .opt_opc = vecop_list_sub_u,
+                    .write_aofs = true,
+                    .vece = MO_16
+                },
+                {
+                    .fniv = gen_vadd_sat_u,
+                    .fno = gen_helper_VADDUHS,
+                    .opt_opc = vecop_list_add_u,
+                    .write_aofs = true,
+                    .vece = MO_16
+                },
+            },
+            {
+                {
+                    .fniv = gen_vsub_sat_u,
+                    .fno = gen_helper_VSUBUWS,
+                    .opt_opc = vecop_list_sub_u,
+                    .write_aofs = true,
+                    .vece = MO_32
+                },
+                {
+                    .fniv = gen_vadd_sat_u,
+                    .fno = gen_helper_VADDUWS,
+                    .opt_opc = vecop_list_add_u,
+                    .write_aofs = true,
+                    .vece = MO_32
+                },
+            },
+        },
+        {
+            {
+                {
+                    .fniv = gen_vsub_sat_s,
+                    .fno = gen_helper_VSUBSBS,
+                    .opt_opc = vecop_list_sub_s,
+                    .write_aofs = true,
+                    .vece = MO_8
+                },
+                {
+                    .fniv = gen_vadd_sat_s,
+                    .fno = gen_helper_VADDSBS,
+                    .opt_opc = vecop_list_add_s,
+                    .write_aofs = true,
+                    .vece = MO_8
+                },
+            },
+            {
+                {
+                    .fniv = gen_vsub_sat_s,
+                    .fno = gen_helper_VSUBSHS,
+                    .opt_opc = vecop_list_sub_s,
+                    .write_aofs = true,
+                    .vece = MO_16
+                },
+                {
+                    .fniv = gen_vadd_sat_s,
+                    .fno = gen_helper_VADDSHS,
+                    .opt_opc = vecop_list_add_s,
+                    .write_aofs = true,
+                    .vece = MO_16
+                },
+            },
+            {
+                {
+                    .fniv = gen_vsub_sat_s,
+                    .fno = gen_helper_VSUBSWS,
+                    .opt_opc = vecop_list_sub_s,
+                    .write_aofs = true,
+                    .vece = MO_32
+                },
+                {
+                    .fniv = gen_vadd_sat_s,
+                    .fno = gen_helper_VADDSWS,
+                    .opt_opc = vecop_list_add_s,
+                    .write_aofs = true,
+                    .vece = MO_32
+                },
+            },
+        },
+    };
+
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+
+    tcg_gen_gvec_4(avr_full_offset(a->vrt), offsetof(CPUPPCState, vscr_sat),
+                   avr_full_offset(a->vra), avr_full_offset(a->vrb), 16, 16,
+                   &op[sign][vece][add]);
+
+    return true;
+}
+
+TRANS(VSUBUBS, do_vx_vadd_vsub_sat, 0, MO_8, 0)
+TRANS(VSUBUHS, do_vx_vadd_vsub_sat, 0, MO_16, 0)
+TRANS(VSUBUWS, do_vx_vadd_vsub_sat, 0, MO_32, 0)
+TRANS(VSUBSBS, do_vx_vadd_vsub_sat, 1, MO_8, 0)
+TRANS(VSUBSHS, do_vx_vadd_vsub_sat, 1, MO_16, 0)
+TRANS(VSUBSWS, do_vx_vadd_vsub_sat, 1, MO_32, 0)
+TRANS(VADDUBS, do_vx_vadd_vsub_sat, 0, MO_8, 1)
+TRANS(VADDUHS, do_vx_vadd_vsub_sat, 0, MO_16, 1)
+TRANS(VADDUWS, do_vx_vadd_vsub_sat, 0, MO_32, 1)
+TRANS(VADDSBS, do_vx_vadd_vsub_sat, 1, MO_8, 1)
+TRANS(VADDSHS, do_vx_vadd_vsub_sat, 1, MO_16, 1)
+TRANS(VADDSWS, do_vx_vadd_vsub_sat, 1, MO_32, 1)
 TRANS(VSUBCUW, do_vx_vaddsubcuw, 0)
 TRANS(VADDCUW, do_vx_vaddsubcuw, 1)
 
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 7bb11b0549..d890dcb0b4 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -54,18 +54,13 @@ GEN_VXFORM(vsro, 6, 17),
 GEN_VXFORM(xpnd04_1, 0, 22),
 GEN_VXFORM_300(bcdsr, 0, 23),
 GEN_VXFORM_300(bcdsr, 0, 31),
-GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM_DUAL(vadduhs, vmul10euq, 0, 9, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vadduws, 0, 10),
-GEN_VXFORM(vaddsbs, 0, 12),
-GEN_VXFORM_DUAL(vaddshs, bcdcpsgn, 0, 13, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vaddsws, 0, 14),
-GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
-GEN_VXFORM(vsubuws, 0, 26),
-GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_ALTIVEC, PPC2_ISA300),
-GEN_VXFORM(vsubshs, 0, 29),
-GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
+GEN_HANDLER(vmul10uq, 0x04, 0, 8, 0x0000F800, PPC_ALTIVEC),
+GEN_VXFORM(vmul10euq, 0, 9),
+GEN_VXFORM(bcdcpsgn, 0, 13),
+GEN_VXFORM(bcdadd, 0, 24),
+GEN_VXFORM(bcdsub, 0, 25),
+GEN_VXFORM_300(bcdtrunc, 0, 28),
+GEN_VXFORM(xpnd04_2, 0, 30),
 GEN_VXFORM_300(bcdtrunc, 0, 20),
 GEN_VXFORM_300(bcdutrunc, 0, 21),
 GEN_VXFORM(vsl, 2, 7),
-- 
2.39.3


