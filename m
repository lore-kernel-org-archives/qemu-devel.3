Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F7C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplf-0007X0-4D; Fri, 28 Aug 2026 02:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpld-0007VX-De
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplb-0000yV-3N
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22Nbf597154
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dZI5gbPcSB5M8BK8/
 DAQ47TteGpOvS6jdOp98WjLcf0=; b=OwuTw9C3ZDDd91kj8YWOuQPbkxiaG4TwG
 Zc/8LvyT+9TMeFAfR4gok8w7dPVtvjRyC8KmY0uAMtrIXN13/2LXrDdIqnotBoEv
 B6uzbMD2Y+YSCZpb99qTGcYVv65i7aAydiGLsKLFWpSH1K4LN6AOYmL5y8QEylDa
 MQtvspKIinuTMnIL7uEzN6g2lamCibiIvkYKAMCli25o6vf6XmAkuMn/h93IOpXN
 a4HK4yoe80CxIzyLB+N6/LaiLv1w4NLYF4VEPvU0ExJJwod9chyhZpJQiJWNqa+o
 +3swMGLQMPihpNF90q7evSg+6mGU99uBecrzyXJFiSxF3GUmA4Yyw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uFRn007418
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsymc1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68aub39190978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4497C20043;
 Fri, 28 Aug 2026 06:08:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8B9520040;
 Fri, 28 Aug 2026 06:08:34 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 27/41] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
Date: Fri, 28 Aug 2026 11:37:02 +0530
Message-ID: <20260828060716.91672-28-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cv9IpZQWt4-B490A_zBOlLh33nvH2H8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX5Z/g1ASfL87E
 sYhgIB0nDjt6oGrA83LnxI/9Vao39BXdRS5o2LazlJPkAyVFo8o062s8X3NlwjRCwf3WDt6Jjnz
 OLXF5jJFid2zq4n6b/TkYTFuKuNVoPynmTgZhJuf6RxWJNw0ZbYqg5YTOlOBowUr8+ryA1P1z9i
 ft2id3Oc7aAf09OFLGzNhdzoXwKCl3AM65/EfxDXmBY/V0QPjMf7xRCuvsONU/QT96vH6GM+hzW
 yOn3WYgbxgEbV8TCmTTaQZ+p45vyC4k4/Cb38vPnrU+md+IjmLfNzkhFS6qvr0bTmrq4sxQrsXq
 H01E0TOlA8Sqz281oRrehD1Iz6g2zLKxTHC7+EdgoV1VfNJcBVzkMYiGgCC89+CVV3JZ50NWFzl
 PKw4EWBsEiEpMl8sTFbIL90jl2FB0eZwG4s0Un1jJgSTKpcAFSdVB7Qc7sK15Zn3yNgvP6qvK5w
 9Z/1TZU8J8MSL3RpQgg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125e9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaseaQdEDhcTiVZihRkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXz2xcN5IheSWr
 q9V6wy0OGO8ic3zgMfN+oWDIuEHvgzj16Dr7mAARcv3+cQfNtTBcUE90aNHdnubmuXM1dzHyy21
 9KMLIXxMkuhzbqjew9p6JsvIiMGZkWk=
X-Proofpoint-ORIG-GUID: Cv9IpZQWt4-B490A_zBOlLh33nvH2H8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Move below instructions to decodetree specification :

        lsw{i, x},
        stsw{i, x}                       : X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-24-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper.h                        |   6 +-
 target/ppc/insn32.decode                   |   7 ++
 target/ppc/mem_helper.c                    |   6 +-
 target/ppc/translate.c                     | 102 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 102 +++++++++++++++++++++
 5 files changed, 115 insertions(+), 108 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6e14f02598..18ef7786a4 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -45,9 +45,9 @@ DEF_HELPER_1(check_tlb_flush_global, void, env)
 
 DEF_HELPER_3(lmw, void, env, tl, i32)
 DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
-DEF_HELPER_4(lsw, void, env, tl, i32, i32)
-DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
-DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
+DEF_HELPER_4(LSW, void, env, tl, i32, i32)
+DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
 DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 5e5490b169..a88ba1fce1 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -527,6 +527,13 @@ CREQV           010011 ..... ..... ..... 0100100001 -  @X
 CRANDC          010011 ..... ..... ..... 0010000001 -  @X
 CRORC           010011 ..... ..... ..... 0110100001 -  @X
 
+# Fixed Point Move Assist Instructions
+
+LSWI            011111 ..... ..... ..... 1 001010101 -  @X
+LSWX            011111 ..... ..... ..... 1 000010101 -  @X
+STSWI           011111 ..... ..... ..... 1 011010101 -  @X
+STSWX           011111 ..... ..... ..... 1 010010101 -  @X
+
 # Fixed-Point Hash Instructions
 
 HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 8ad6945590..10c648cf06 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -190,7 +190,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
     env->gpr[reg] = val;
 }
 
-void helper_lsw(CPUPPCState *env, target_ulong addr,
+void helper_LSW(CPUPPCState *env, target_ulong addr,
                 uint32_t nb, uint32_t reg)
 {
     do_lsw(env, addr, nb, reg, GETPC());
@@ -202,7 +202,7 @@ void helper_lsw(CPUPPCState *env, target_ulong addr,
  * this is valid, but rA won't be loaded.  For now, I'll follow the
  * spec...
  */
-void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
+void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
                  uint32_t ra, uint32_t rb)
 {
     if (likely(xer_bc != 0)) {
@@ -218,7 +218,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
     }
 }
 
-void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
+void helper_STSW(CPUPPCState *env, target_ulong addr, uint32_t nb,
                  uint32_t reg)
 {
     uintptr_t raddr = GETPC();
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c45883ac30..d17d77a9d9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2595,104 +2595,6 @@ static void gen_stmw(DisasContext *ctx)
     gen_helper_stmw(tcg_env, t0, t1);
 }
 
-/***                    Integer load and store strings                     ***/
-
-/* lswi */
-/*
- * PowerPC32 specification says we must generate an exception if rA is
- * in the range of registers to be loaded.  In an other hand, IBM says
- * this is valid, but rA won't be loaded.  For now, I'll follow the
- * spec...
- */
-static void gen_lswi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1, t2;
-    int nb = NB(ctx->opcode);
-    int start = rD(ctx->opcode);
-    int ra = rA(ctx->opcode);
-    int nr;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    if (nb == 0) {
-        nb = 32;
-    }
-    nr = DIV_ROUND_UP(nb, 4);
-    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    gen_addr_register(ctx, t0);
-    t1 = tcg_constant_i32(nb);
-    t2 = tcg_constant_i32(start);
-    gen_helper_lsw(tcg_env, t0, t1, t2);
-}
-
-/* lswx */
-static void gen_lswx(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1, t2, t3;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    t1 = tcg_constant_i32(rD(ctx->opcode));
-    t2 = tcg_constant_i32(rA(ctx->opcode));
-    t3 = tcg_constant_i32(rB(ctx->opcode));
-    gen_helper_lswx(tcg_env, t0, t1, t2, t3);
-}
-
-/* stswi */
-static void gen_stswi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1, t2;
-    int nb = NB(ctx->opcode);
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    gen_addr_register(ctx, t0);
-    if (nb == 0) {
-        nb = 32;
-    }
-    t1 = tcg_constant_i32(nb);
-    t2 = tcg_constant_i32(rS(ctx->opcode));
-    gen_helper_stsw(tcg_env, t0, t1, t2);
-}
-
-/* stswx */
-static void gen_stswx(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1, t2;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    t1 = tcg_temp_new_i32();
-    tcg_gen_trunc_tl_i32(t1, cpu_xer);
-    tcg_gen_andi_i32(t1, t1, 0x7F);
-    t2 = tcg_constant_i32(rS(ctx->opcode));
-    gen_helper_stsw(tcg_env, t0, t1, t2);
-}
 
 #if !defined(CONFIG_USER_ONLY)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
@@ -4901,10 +4803,6 @@ GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
-GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
-GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
-GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index d0b3bda97f..4b79e24f6f 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -584,6 +584,108 @@ TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
 TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
 TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
 
+/***                    Integer load and store strings                     ***/
+
+/* lswi */
+static bool trans_LSWI(DisasContext *ctx, arg_LSWI *a)
+{
+    TCGv t0;
+    TCGv_i32 t1, t2;
+    int nb = a->rb;
+    int start = a->rt;
+    int ra = a->ra;
+    int nr;
+
+    REQUIRE_INSNS_FLAGS(ctx, STRING);
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+    if (nb == 0) {
+        nb = 32;
+    }
+    nr = DIV_ROUND_UP(nb, 4);
+    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
+        return true;
+    }
+    gen_set_access_type(ctx, ACCESS_INT);
+    t0 = do_ea_calc_ra(ctx, ra);
+    t1 = tcg_constant_i32(nb);
+    t2 = tcg_constant_i32(start);
+    gen_helper_LSW(tcg_env, t0, t1, t2);
+
+    return true;
+}
+
+/* lswx */
+static bool trans_LSWX(DisasContext *ctx, arg_LSWX *a)
+{
+    TCGv t0;
+    TCGv_i32 t1, t2, t3;
+
+    REQUIRE_INSNS_FLAGS(ctx, STRING);
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+    t0 = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    t1 = tcg_constant_i32(a->rt);
+    t2 = tcg_constant_i32(a->ra);
+    t3 = tcg_constant_i32(a->rb);
+    gen_helper_LSWX(tcg_env, t0, t1, t2, t3);
+
+    return true;
+}
+
+/* stswi */
+static bool trans_STSWI(DisasContext *ctx, arg_STSWI *a)
+{
+    TCGv t0;
+    TCGv_i32 t1, t2;
+    int nb = a->rb;
+
+    REQUIRE_INSNS_FLAGS(ctx, STRING);
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+    gen_set_access_type(ctx, ACCESS_INT);
+    t0 = do_ea_calc_ra(ctx, a->ra);
+    if (nb == 0) {
+        nb = 32;
+    }
+    t1 = tcg_constant_i32(nb);
+    t2 = tcg_constant_i32(a->rt);
+    gen_helper_STSW(tcg_env, t0, t1, t2);
+
+    return true;
+}
+
+/* stswx */
+static bool trans_STSWX(DisasContext *ctx, arg_STSWX *a)
+{
+    TCGv t0;
+    TCGv_i32 t1, t2;
+
+    REQUIRE_INSNS_FLAGS(ctx, STRING);
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+    gen_set_access_type(ctx, ACCESS_INT);
+    t0 = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    t1 = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(t1, cpu_xer);
+    tcg_gen_andi_i32(t1, t1, 0x7F);
+    t2 = tcg_constant_i32(a->rt);
+    gen_helper_STSW(tcg_env, t0, t1, t2);
+
+    return true;
+}
+
 static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
                      bool compute_ov, bool compute_rc0)
 {
-- 
2.52.0


