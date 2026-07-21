Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB31C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6WX-00022a-OD; Tue, 21 Jul 2026 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wm6WV-000220-QZ; Tue, 21 Jul 2026 05:12:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wm6WR-0000Ft-NR; Tue, 21 Jul 2026 05:12:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNDiNi3461481; Tue, 21 Jul 2026 09:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q/QPxQ1P6hdE3aweR
 sNnY7R7JRrrJUFrUJRqyzrRmJ0=; b=Vny3aDi2zK9b/J0AhimSN7C988nOKQk9b
 VwsoOQJgcddilGHM7APo94OuUH9UZfJl5pRkIEBmDSzHQAqGDuWpozX2GfOKo8uQ
 RVfa0lVwsDnN5yU7d8I7qEaRKM4d81hfZkK/HWzpOXQTGiTziDsiSKcMJDQBLovI
 j7F+fq+lJOx2qPNVjrVOl/GCXhdd4bCMCgHd5StPspQiHUTBlvR0vsD1KlFQEk6f
 J4X7JfT6R13cFiA9ZhJSpkNg4hkL1XswJLOv2OEBH/kMZn9TMPjhlgCYmRr87m1j
 H7Vv8Snf5n+UZqppj6uTjSXNJnwILgy39bw74NmYOTHnX35n3qVDQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g3cxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 09:12:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L94h8E027527;
 Tue, 21 Jul 2026 09:12:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g9cvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 09:12:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66L9CAQS51118566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2026 09:12:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12D372004B;
 Tue, 21 Jul 2026 09:12:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9688620043;
 Tue, 21 Jul 2026 09:12:07 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2026 09:12:07 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: rathc@linux.ibm.com
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, nikhilks@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 shivangu@linux.ibm.com, stefanha@redhat.com
Subject: [PATCH v2] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
Date: Tue, 21 Jul 2026 14:42:05 +0530
Message-ID: <20260721091205.51518-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520160728.2283628-23-rathc@linux.ibm.com>
References: <20260520160728.2283628-23-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX6SMFWuTVMuNi
 WmhlRIzNqsjQTwTnsOmL812pKhH59oBoPAuotcEjA9ZS+z1NQsVJPaNFnFn0lWsiC+L/WbGXktM
 pbzo+wH2kaItOsMcDSH7vsaBhZecc+nGGWA+0cPCMka7OLN0F4IeP9alybHkheUNFldqq81twq3
 w/oyKlf4YTT+acBRXlc4HBIEQDYa4gmoPFAO4b1/scjfTf3Nv/OjYxXKMAgHGDp0KqedZeYvKLX
 GfHJ8UFAi2/kRyuMzMT0m6nqOIYc+mQ0z9xDikbIGN1q91/IovRtbklYoJk35zD54biXUwniM37
 BPrsK9GBse7IBSW+tQCTyUpxF56CL1bkzgd69F68IC84ZTu7h25Q/kxczFXT/4gVEpw50YNNWVr
 C1yZJDfNDt3DX+w0fh67SSzJEVpQpWogfcSnPJUgIO6k3tvf9EwVmrn+zTPQEMQ1XmYmoNlZz6A
 aBpw4DPofsLTswAWQqA==
X-Proofpoint-GUID: h9sGpYtczwKZMWX95GXWHqj_1o-NV_DX
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5f37ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qaseaQdEDhcTiVZihRkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX/9PChgPpLdDX
 ARMq188/vRVGgTDdr0uTvQoh0Bnipp5SZ9ZF7LfDEBJk1j7KR6i4b8CTXGHBELbnTCtt00cqgSI
 EcfOphv453HR/U0/8bMeRNioZKgk6+8=
X-Proofpoint-ORIG-GUID: isxFegIHriOlZ4A4-hKQ8OIimVhOST1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210096
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Move below instructions to decodetree specification :

        lsw{i, x},
        stsw{i, x}                       : X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---

Changes:
since v1:
 - Added PPC_STRING flag requirement
 - moved gen_addr_register/gen_addr_reg_index to do_ea_calc/do_ea_calc_ra

---
 target/ppc/helper.h                        |   6 +-
 target/ppc/insn32.decode                   |   7 ++
 target/ppc/mem_helper.c                    |   6 +-
 target/ppc/translate.c                     | 102 --------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 103 +++++++++++++++++++++
 5 files changed, 116 insertions(+), 108 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index dacc4e223e..50493a72a5 100644
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
 DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
 #ifdef TARGET_PPC64
 DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f3a1f7970e..0ec9a4d5de 100644
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
index 5d3d377261..303eec4ee5 100644
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
index c701ddc2a7..9ede7ee287 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2597,104 +2597,6 @@ static void gen_stmw(DisasContext *ctx)
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
@@ -4940,10 +4842,6 @@ GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
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
index 26b308e435..82fb645279 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -585,6 +585,109 @@ TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
 TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
 TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
 
+
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
+    t0 = do_ea_calc_ra(ctx, a->ra);
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
2.54.0


