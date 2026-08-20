Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B51BC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3MD-0007P7-Cd; Thu, 20 Aug 2026 10:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3MB-0007Lx-Uh; Thu, 20 Aug 2026 10:03:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3M9-0005hf-T0; Thu, 20 Aug 2026 10:02:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8q9e3362195; Thu, 20 Aug 2026 14:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1bvVgVgwt1l6dKSIy
 Ga9j0Do2cN1clldbEtLlQrIy/A=; b=IXpvMYk2ASmSzjiHJ8QBkdfTEzFfvVKEB
 5WaTjfpEOpAfaLcCdAxFYuAK9laoI4jdE9iVfkEZlSQfWSy4TM+tSGR6t63eq38H
 hiPbQdiZzEgizrKCkT9UhgH47XWpn4jBpOC8vdsjJailmHiym4yBuK1t7zr0qIJ+
 FEPcL4FybXP3wCTv7kKlRYavJad6ac6AnvwytQndoPImyZ59KwVvaLv6cgxMJGvl
 Uk6CGtSjheW1oZA/mhobXb6MjaV53SqOhwMg+hUO5OFKm2APJHNIvTBTe9xwWNRZ
 wGgLTZJnou8bv7ySQkP6UWvi5rcs3h7WYi832pB/i5XBE+k7ieqTQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4amxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:02:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuNWd032434;
 Thu, 20 Aug 2026 14:02:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twf0c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:02:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE2m5M46530922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:02:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96C9020043;
 Thu, 20 Aug 2026 14:02:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B0E520040;
 Thu, 20 Aug 2026 14:02:42 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:02:41 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 02/29] target/ppc: Migrate atomic loads to decodetree
Date: Thu, 20 Aug 2026 19:30:31 +0530
Message-ID: <20260820140114.327023-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX6Zh+SPUzboaJ
 QABlo9WR+0u4DT5DacFm3OcDJHAAm3bN+D/Z3SsvP8gZBvpcIB7786a1V31oNzqOE7JW4A1gQO4
 spjAz2WyYc8QHeCPVbUFfrTwm4ZwRmM=
X-Proofpoint-GUID: tLkWWcCL9aTavTMUNQQf3E2ryD6OQGyD
X-Proofpoint-ORIG-GUID: 0dP3rKI8kv-0-5KOLcYQCREAGtwkVJbd
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a87090f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-DTolxHDGJQozeEdauoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX8f9Tg57dfVPI
 T5YYZo7QZ+AI+0PRLqqVAZLW20mrDnV3mhkPDcnvziAmvAfh6uEYQeIbUHC5fapZpGUvEft/xju
 LrcvY5OWrF+/6hOByx1mVUXdbZbnmLShOEonH1KrZPp/FFSft+/MDLJLaUIFDjIHqAGxqDGUFDW
 me7GEzZCaw61yuM0iEmwv+Z/8SNoH4FljyRO2+e7rpDQ5pdgzdCc4+d1IrozYY7GXzUqGA88OyN
 gEPzrSd7ElrOU6RaQLX0xbiZrb+6piuMVqV2vUmiKLebBryU9aBSRGd3MX5U7lTQuWvarUgJeCU
 haQrJlBnKulCMT8gOl+uisKMpNyKFWUhacrEzI+nQK+d2taJG0spacMH4s08NyMrMAOE6LpxLmQ
 IdOOw6nqhTFRs8htXgZQs3HO4t73rEbFnn7SdC59exwxCd3UhYtYHf+C0suZvo5lm/K9zxzvcw0
 kSJe/U/B/OvP2aa5ZLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Migrate load-and-reserve instructions (lbarx, lharx, lwarx, ldarx,
lqarx) to decodetree using the X-form layout.

A shared helper (do_load_locked) is introduced for standard-width
variants, while LQARX is handled separately due to its 128-bit
semantics and register pairing constraints.

The implementation preserves legacy behavior, including:
  - Reservation granularity and overwrite semantics
  - Alignment requirements
  - Invalid instruction cases for LQARX

Testing:
  - Verified TCG equivalence with legacy implementation

Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode |   7 +++
 target/ppc/translate.c   | 124 +++++++++++++++++++--------------------
 2 files changed, 69 insertions(+), 62 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 342e65dadf..26948e08a7 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1309,6 +1309,13 @@ XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
 ##Extend Sign Word and Shift Left Immediate XS-form
 EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
 
+## Load and Reserve Instructions
+LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
+LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
+LWARX           011111 ..... ..... ..... 0000010100 .   @X_rc
+LDARX           011111 ..... ..... ..... 0001010100 .   @X_rc
+LQARX           011111 ..... ..... ..... 0100010100 .   @X_rc
+
 ## Vector Division Instructions
 
 VDIVSW          000100 ..... ..... ..... 00110001011    @VX
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e627f48f9e..cc9287dcc5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2947,30 +2947,6 @@ static void gen_isync(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-static void gen_load_locked(DisasContext *ctx, MemOp memop)
-{
-    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
-    TCGv t0 = tcg_temp_new();
-
-    gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
-    tcg_gen_mov_tl(cpu_reserve, t0);
-    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
-    tcg_gen_mov_tl(cpu_reserve_val, gpr);
-}
-
-#define LARX(name, memop)                  \
-static void gen_##name(DisasContext *ctx)  \
-{                                          \
-    gen_load_locked(ctx, memop);           \
-}
-
-/* lwarx */
-LARX(lbarx, MO_UB)
-LARX(lharx, MO_UW)
-LARX(lwarx, MO_UL)
-
 static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                       TCGv EA, TCGCond cond, int addend)
 {
@@ -3219,42 +3195,9 @@ STCX(sthcx_, MO_UW)
 STCX(stwcx_, MO_UL)
 
 #if defined(TARGET_PPC64)
-/* ldarx */
-LARX(ldarx, MO_UQ)
 /* stdcx. */
 STCX(stdcx_, MO_UQ)
 
-/* lqarx */
-static void gen_lqarx(DisasContext *ctx)
-{
-    int rd = rD(ctx->opcode);
-    TCGv EA, hi, lo;
-    TCGv_i128 t16;
-
-    if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
-                 (rd == rB(ctx->opcode)))) {
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-        return;
-    }
-
-    gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-
-    /* Note that the low part is always in RD+1, even in LE mode.  */
-    lo = cpu_gpr[rd + 1];
-    hi = cpu_gpr[rd];
-
-    t16 = tcg_temp_new_i128();
-    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
-    tcg_gen_extr_i128_i64(lo, hi, t16);
-
-    tcg_gen_mov_tl(cpu_reserve, EA);
-    tcg_gen_movi_tl(cpu_reserve_length, 16);
-    tcg_gen_st_tl(hi, tcg_env, offsetof(CPUPPCState, reserve_val));
-    tcg_gen_st_tl(lo, tcg_env, offsetof(CPUPPCState, reserve_val2));
-}
-
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
@@ -5741,6 +5684,68 @@ static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
     return true;
 }
 
+/*
+ * Load-and-reserve core
+ */
+static bool do_load_locked(DisasContext *ctx, arg_X_rc *a, MemOp memop)
+{
+    TCGv EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    TCGv gpr = cpu_gpr[a->rt];
+
+    gen_set_access_type(ctx, ACCESS_RES);
+
+    tcg_gen_qemu_ld_tl(gpr, EA, ctx->mem_idx, memop | MO_ALIGN);
+
+    tcg_gen_mov_tl(cpu_reserve, EA);
+    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
+
+    tcg_gen_mov_tl(cpu_reserve_val, gpr);
+
+    return true;
+}
+
+TRANS_FLAGS2(ATOMIC_ISA206, LBARX, do_load_locked, DEF_MEMOP(MO_UB))
+TRANS_FLAGS2(ATOMIC_ISA206, LHARX, do_load_locked, DEF_MEMOP(MO_UW))
+TRANS(LWARX, do_load_locked, DEF_MEMOP(MO_UL))
+TRANS64(LDARX, do_load_locked, DEF_MEMOP(MO_UQ))
+
+static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+#if defined(TARGET_PPC64)
+    TCGv EA;
+    TCGv_i128 t16;
+    /* Must use even register and avoid overlap */
+    if (unlikely((a->rt & 1) || (a->rt == a->ra) || (a->rt == a->rb))) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+        return true;
+    }
+
+    gen_set_access_type(ctx, ACCESS_RES);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    t16 = tcg_temp_new_i128();
+
+    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx,
+                         DEF_MEMOP(MO_128 | MO_ALIGN));
+
+    tcg_gen_extr_i128_i64(cpu_gpr[a->rt + 1],
+                         cpu_gpr[a->rt],
+                         t16);
+
+    tcg_gen_mov_tl(cpu_reserve, EA);
+    tcg_gen_movi_tl(cpu_reserve_length, 16);
+
+    tcg_gen_st_i64(cpu_gpr[a->rt],
+                   tcg_env, offsetof(CPUPPCState, reserve_val));
+    tcg_gen_st_i64(cpu_gpr[a->rt + 1],
+                   tcg_env, offsetof(CPUPPCState, reserve_val2));
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 #include "translate/fixedpoint-impl.c.inc"
 
 #include "translate/fp-impl.c.inc"
@@ -5853,9 +5858,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
-GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
-GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
-GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
 GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
@@ -5864,8 +5866,6 @@ GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
-GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
 GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
 GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
 #endif
-- 
2.55.0


