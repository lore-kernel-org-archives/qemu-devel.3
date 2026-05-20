Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E204FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjTk-0000RV-Qq; Wed, 20 May 2026 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTE-0008Lk-Ue; Wed, 20 May 2026 12:08:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTC-0002es-Ph; Wed, 20 May 2026 12:08:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KD4g0S3907161; Wed, 20 May 2026 16:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ShQ/S7JULeJkCW1ob
 AjmdShMREtavYkwN1VTNEN2Sf0=; b=gCGJ7iK0Yd9rkkIUHqd+wVK1ku30XM7n/
 Dee0hQ4XZ9tTrbKuulnhf8A28veH8N8NUL9DNJT3ab/7FUVdp2qUOHnG7le8aP4t
 DwGbwpvckAc262hJzMEZO/1kte0sEbWkm36vlPiq5iPiTETpWVLb26bcXkFYRK6a
 XhNjkXQpgj5RD4uAxtWudX4llDQBy83alBRBVFg4P2/OlJdPsVThcwO1Q5Bcxszn
 tr8IJJ9QZY8d6gwE+hi3QUGyVTNZ8Ul2jisSDUYAKSxH4FOVVrutKAJvC6uqnPTo
 4zEekTfSqWRlp6b1EPos4Xo/BPx8ASYepkeeOko41wZFllSWARsPA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hw77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFs6kX015346;
 Wed, 20 May 2026 16:08:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk83fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG8O7L52167118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:08:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1937420043;
 Wed, 20 May 2026 16:08:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF2E920040;
 Wed, 20 May 2026 16:08:18 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:08:18 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 06/28] target/ppc: Move st{b, h, w, d,
 q}cx instructions to decodetree
Date: Wed, 20 May 2026 21:37:06 +0530
Message-ID: <20260520160728.2283628-7-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX/XJNjymoovIl
 vnkQN7yrbZ4+g3uI6tugtg+mdz3oWOm9ZrknBW1Ngn+0KKha3/IfME3pMjXpVf2cKK4CwvUhSce
 4ZCH+NUHiEGFm/qCn2lpAwJsTwQmCtd3AbWajbATltU9V71KfZ9sH22o/zyW8M7AKIoQuRXPMej
 WeMEchvsb7Yoq0MWT/g9pV8rCWXeKOn9mu4KrvbMhtgjA2fp5D2W1Hg6nKdEyTmzC/H17EXWCut
 nwQ72IdZ3GPX05ICuk+wGbN3td2ym+KQO954gDu/PQFid5BNp1/20E+hhFz9EjQMHK+xZ6QUrbT
 kcslRCLGbmu/YZMvFxusBrRQHqKMVVehqiT4JRumQJVxO7GEg5YYkCjvldc40j9Gf/CrkkxxKJf
 AIC95wIKUuaF5ntqVIfmmbbc2p9408LDBDIiS9Byjd5pRT6Pf7DOSw2prPC7RkZ1ohvixJY1BuH
 RKRs76yj+Uf0poivjTQ==
X-Proofpoint-GUID: C-UmxnZhwLc3HZvWwIJqXB9jJJS1R6c2
X-Proofpoint-ORIG-GUID: ZfSot_PCIRiwCyza2n5pj0RA8dL4t26x
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ddc7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=G15nFMUEX_LYouYoQH8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Utkarsh Verma <uverma@linux.ibm.com>

Move the following store conditional instructions to decodetree
specification:

stbcx.	: X-form
sthcx.	: X-form
stwcx.	: X-form
stdcx.	: X-form
stqcx.	: X-form

The changes were verified by checking that the generated TCG ops remain
semantically identical to the legacy translation, using logs captured
with the -d in_asm,op flag.

Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |   8 ++
 target/ppc/translate.c                     | 103 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc |  84 +++++++++++++++++
 3 files changed, 92 insertions(+), 103 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 8c8eca5e46..1f363771ed 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -732,6 +732,14 @@ DSCLIQ          111111 ..... ..... ...... 001000010 .   @Z22_tap_sh_rc
 DSCRI           111011 ..... ..... ...... 001100010 .   @Z22_ta_sh_rc
 DSCRIQ          111111 ..... ..... ...... 001100010 .   @Z22_tap_sh_rc
 
+### Store Conditional Instructions
+
+STBCX           011111 ..... ..... ..... 1010110110 1   @X
+STHCX           011111 ..... ..... ..... 1011010110 1   @X
+STWCX           011111 ..... ..... ..... 0010010110 1   @X
+STDCX           011111 ..... ..... ..... 0011010110 1   @X
+STQCX           011111 ..... ..... ..... 0010110110 1   @X
+
 ## Vector Exclusive-OR-based Instructions
 
 VPMSUMD         000100 ..... ..... ..... 10011001000    @VX
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ba1774a539..aeecc06477 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3153,104 +3153,6 @@ static void gen_stdat(DisasContext *ctx)
 }
 #endif
 
-static void gen_conditional_store(DisasContext *ctx, MemOp memop)
-{
-    TCGLabel *lfail;
-    TCGv EA;
-    TCGv cr0;
-    TCGv t0;
-    int rs = rS(ctx->opcode);
-
-    lfail = gen_new_label();
-    EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
-    t0 = tcg_temp_new();
-
-    tcg_gen_mov_tl(cr0, cpu_so);
-    gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, EA);
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
-
-    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[rs], ctx->mem_idx,
-                              DEF_MEMOP(memop) | MO_ALIGN);
-    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
-    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(cr0, cr0, t0);
-
-    gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
-    tcg_gen_movi_tl(cpu_reserve, -1);
-}
-
-#define STCX(name, memop)                  \
-static void gen_##name(DisasContext *ctx)  \
-{                                          \
-    gen_conditional_store(ctx, memop);     \
-}
-
-STCX(stbcx_, MO_UB)
-STCX(sthcx_, MO_UW)
-STCX(stwcx_, MO_UL)
-
-#if defined(TARGET_PPC64)
-/* stdcx. */
-STCX(stdcx_, MO_UQ)
-
-/* stqcx. */
-static void gen_stqcx_(DisasContext *ctx)
-{
-    TCGLabel *lfail;
-    TCGv EA, t0, t1;
-    TCGv cr0;
-    TCGv_i128 cmp, val;
-    int rs = rS(ctx->opcode);
-
-    if (unlikely(rs & 1)) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-        return;
-    }
-
-    lfail = gen_new_label();
-    EA = tcg_temp_new();
-    cr0 = tcg_temp_new();
-
-    tcg_gen_mov_tl(cr0, cpu_so);
-    gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, EA);
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
-
-    cmp = tcg_temp_new_i128();
-    val = tcg_temp_new_i128();
-
-    tcg_gen_concat_i64_i128(cmp, cpu_reserve_val2, cpu_reserve_val);
-
-    /* Note that the low part is always in RS+1, even in LE mode.  */
-    tcg_gen_concat_i64_i128(val, cpu_gpr[rs + 1], cpu_gpr[rs]);
-
-    tcg_gen_atomic_cmpxchg_i128(val, cpu_reserve, cmp, val, ctx->mem_idx,
-                                DEF_MEMOP(MO_128 | MO_ALIGN));
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    tcg_gen_extr_i128_i64(t1, t0, val);
-
-    tcg_gen_xor_tl(t1, t1, cpu_reserve_val2);
-    tcg_gen_xor_tl(t0, t0, cpu_reserve_val);
-    tcg_gen_or_tl(t0, t0, t1);
-
-    tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
-    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(cr0, cr0, t0);
-
-    gen_set_label(lfail);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
-    tcg_gen_movi_tl(cpu_reserve, -1);
-}
-#endif /* defined(TARGET_PPC64) */
-
 /* wait */
 static void gen_wait(DisasContext *ctx)
 {
@@ -5923,14 +5825,9 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
-GEN_HANDLER_E(sthcx_, 0x1F, 0x16, 0x16, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
-GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
-GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
 #endif
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index fa0191e866..91f9c6c391 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -204,6 +204,90 @@ TRANS64(PSTD, do_ldst_PLS_D, false, true, MO_UQ)
 TRANS64(STQ, do_ldst_quad, true, false);
 TRANS64(PSTQ, do_ldst_quad_PLS_D, true);
 
+/* Store Conditional Instructions */
+
+static bool do_store_cond(DisasContext *ctx, arg_X *a, MemOp mop)
+{
+    TCGLabel *lfail = gen_new_label();
+    TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    TCGv cr0 = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
+
+    tcg_gen_mov_tl(cr0, cpu_so);
+    gen_set_access_type(ctx, ACCESS_RES);
+
+    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(mop), lfail);
+
+    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
+                              cpu_gpr[a->rt], ctx->mem_idx,
+                              DEF_MEMOP(mop) | MO_ALIGN);
+    tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
+    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
+    tcg_gen_or_tl(cr0, cr0, t0);
+
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
+    tcg_gen_movi_tl(cpu_reserve, -1);
+    return true;
+}
+
+TRANS_FLAGS2(ATOMIC_ISA206, STBCX, do_store_cond, MO_UB);
+TRANS_FLAGS2(ATOMIC_ISA206, STHCX, do_store_cond, MO_UW);
+TRANS(STWCX, do_store_cond, MO_UL);
+TRANS64(STDCX, do_store_cond, MO_UQ);
+
+static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, LSQ_ISA207);
+#if defined(TARGET_PPC64)
+    TCGLabel *lfail = gen_new_label();
+    TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv cr0 = tcg_temp_new();
+    TCGv_i128 cmp = tcg_temp_new_i128();
+    TCGv_i128 val = tcg_temp_new_i128();
+
+    if (unlikely(a->rt & 1)) {
+        gen_invalid(ctx);
+        return true;
+    }
+
+    tcg_gen_mov_tl(cr0, cpu_so);
+    gen_set_access_type(ctx, ACCESS_RES);
+
+    tcg_gen_brcond_tl(TCG_COND_NE, ea, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
+
+    tcg_gen_concat_i64_i128(cmp, cpu_reserve_val2, cpu_reserve_val);
+
+    /* Note that the low part is always in RS+1, even in LE mode.  */
+    tcg_gen_concat_i64_i128(val, cpu_gpr[a->rt + 1], cpu_gpr[a->rt]);
+
+    tcg_gen_atomic_cmpxchg_i128(val, cpu_reserve, cmp, val, ctx->mem_idx,
+                                DEF_MEMOP(MO_128 | MO_ALIGN));
+
+    tcg_gen_extr_i128_i64(t1, t0, val);
+
+    tcg_gen_xor_tl(t1, t1, cpu_reserve_val2);
+    tcg_gen_xor_tl(t0, t0, cpu_reserve_val);
+    tcg_gen_or_tl(t0, t0, t1);
+
+    tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
+    tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
+    tcg_gen_or_tl(cr0, cr0, t0);
+
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
+    tcg_gen_movi_tl(cpu_reserve, -1);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 /*
  * Fixed-Point Compare Instructions
  */
-- 
2.53.0


