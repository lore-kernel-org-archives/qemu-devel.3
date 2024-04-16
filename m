Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED69AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcV5-0004gH-3v; Tue, 16 Apr 2024 02:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcV4-0004g1-6Q; Tue, 16 Apr 2024 02:41:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rwcUw-0006kg-Sl; Tue, 16 Apr 2024 02:41:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G5hPVX014544; Tue, 16 Apr 2024 06:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FnPeQarKz9kxmDQrLnKrcg7DMfninh20EtRl8C1eqoQ=;
 b=E6o8Gg1fOAZsZw2MzCpvOu3I2Pb+f8kvCapXuEIynFeVgYw8BRrXGOa0PpCL6lpyuKBR
 3c+jT0xlqy5vNhtc4DElGAfDYbE8PwZdQURsl21f+IoKeGEB1iDaR4H+5Jg8laNR32BA
 BHeKWSLjVkujCyFMuFu72SYATTTCc//gjBc1ok/c5/+kt9VmtiWG7qzls17hU7HPD5vE
 fQOBqtykXGpNuuBn+97V0GqdmI8p77LOQwt4WHnZT8y+ayuF/Q7FQh6lZJVPexwF5LKi
 uFBOJMI4vsaR83IacNyXnjmteeuQI/NkssEukyUqUipGu14VXX5uDPfwZXiva7EWFVDI dA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhkds834p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43G6ep3u005413;
 Tue, 16 Apr 2024 06:40:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhkds834m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G5RJUU023681; Tue, 16 Apr 2024 06:40:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnvgp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 06:40:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43G6ekVa51839242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 06:40:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0695420040;
 Tue, 16 Apr 2024 06:40:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA4092004B;
 Tue, 16 Apr 2024 06:40:44 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 06:40:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 7/8] target/ppc: Move cmp{rb, eqb}, tw[i], td[i],
 isel instructions to decodetree.
Date: Tue, 16 Apr 2024 12:09:26 +0530
Message-Id: <20240416063927.99428-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240416063927.99428-1-rathc@linux.ibm.com>
References: <20240416063927.99428-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mweY0ecjt_1ItqWOKf2XXQXajotyJoo3
X-Proofpoint-ORIG-GUID: LWZsTZypnXIwRER5qwzyiHikYO1BGT1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

	cmp{rb, eqb}, t{w, d}	: X-form
	t{w, d}i		: D-form
	isel			: A-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |   6 +-
 target/ppc/insn32.decode                   |  16 +++
 target/ppc/excp_helper.c                   |   4 +-
 target/ppc/int_helper.c                    |   2 +-
 target/ppc/translate.c                     | 133 +--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 123 +++++++++++++++++++
 6 files changed, 148 insertions(+), 136 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e862bdceaf..05f7ab5f6e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,8 +1,8 @@
 DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, noreturn, env, i32, i32)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-DEF_HELPER_FLAGS_4(tw, TCG_CALL_NO_WG, void, env, tl, tl, i32)
+DEF_HELPER_FLAGS_4(TW, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #if defined(TARGET_PPC64)
-DEF_HELPER_FLAGS_4(td, TCG_CALL_NO_WG, void, env, tl, tl, i32)
+DEF_HELPER_FLAGS_4(TD, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #endif
 DEF_HELPER_4(HASHST, void, env, tl, tl, tl)
 DEF_HELPER_4(HASHCHK, void, env, tl, tl, tl)
@@ -67,7 +67,7 @@ DEF_HELPER_FLAGS_2(PEXTD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(CDTBCD, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
+DEF_HELPER_FLAGS_2(CMPEQB, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 509961023b..80a7bb1872 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -23,6 +23,9 @@
 &A_tb           frt frb rc:bool
 @A_tb           ...... frt:5 ..... frb:5 ..... ..... rc:1       &A_tb
 
+&A_tab_bc       rt ra rb bc
+@A_tab_bc       ...... rt:5 ra:5 rb:5 bc:5 ..... .              &A_tab_bc
+
 &D              rt ra si:int64_t
 @D              ...... rt:5 ra:5 si:s16                         &D
 
@@ -331,6 +334,19 @@ CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
 CMPL            011111 ... - . ..... ..... 0000100000 - @X_bfl
 CMPI            001011 ... - . ..... ................   @D_bfs
 CMPLI           001010 ... - . ..... ................   @D_bfu
+CMPRB           011111 ... - . ..... ..... 0011000000 - @X_bfl
+CMPEQB          011111 ... -- ..... ..... 0011100000 -  @X_bf
+
+### Fixed-Point Trap Instructions
+
+TW              011111 ..... ..... ..... 0000000100 -   @X
+TD              011111 ..... ..... ..... 0001000100 -   @X
+TWI             000011 ..... ..... ................     @D
+TDI             000010 ..... ..... ................     @D
+
+### Fixed-Point Select Instruction
+
+ISEL            011111 ..... ..... ..... ..... 01111 -  @A_tab_bc
 
 ### Fixed-Point Arithmetic Instructions
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 674c05a2ce..79dd9b82cf 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2750,7 +2750,7 @@ void helper_rfmci(CPUPPCState *env)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
@@ -2764,7 +2764,7 @@ void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
 }
 
 #ifdef TARGET_PPC64
-void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 585c2b65d3..d12dcc28e1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -159,7 +159,7 @@ uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 /* When you XOR the pattern and there is a match, that byte will be zero */
 #define hasvalue(x, n)  (haszero((x) ^ pattern(n)))
 
-uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
+uint32_t helper_CMPEQB(target_ulong ra, target_ulong rb)
 {
     return hasvalue(rb, ra) ? CRF_GT : 0;
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8900da85e5..98e642b19a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1564,66 +1564,6 @@ static inline void gen_set_Rc0(DisasContext *ctx, TCGv reg)
     }
 }
 
-/* cmprb - range comparison: isupper, isaplha, islower*/
-static void gen_cmprb(DisasContext *ctx)
-{
-    TCGv_i32 src1 = tcg_temp_new_i32();
-    TCGv_i32 src2 = tcg_temp_new_i32();
-    TCGv_i32 src2lo = tcg_temp_new_i32();
-    TCGv_i32 src2hi = tcg_temp_new_i32();
-    TCGv_i32 crf = cpu_crf[crfD(ctx->opcode)];
-
-    tcg_gen_trunc_tl_i32(src1, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(src2, cpu_gpr[rB(ctx->opcode)]);
-
-    tcg_gen_andi_i32(src1, src1, 0xFF);
-    tcg_gen_ext8u_i32(src2lo, src2);
-    tcg_gen_shri_i32(src2, src2, 8);
-    tcg_gen_ext8u_i32(src2hi, src2);
-
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-    tcg_gen_and_i32(crf, src2lo, src2hi);
-
-    if (ctx->opcode & 0x00200000) {
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2lo, src2);
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2hi, src2);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-        tcg_gen_and_i32(src2lo, src2lo, src2hi);
-        tcg_gen_or_i32(crf, crf, src2lo);
-    }
-    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
-}
-
-#if defined(TARGET_PPC64)
-/* cmpeqb */
-static void gen_cmpeqb(DisasContext *ctx)
-{
-    gen_helper_cmpeqb(cpu_crf[crfD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      cpu_gpr[rB(ctx->opcode)]);
-}
-#endif
-
-/* isel (PowerPC 2.03 specification) */
-static void gen_isel(DisasContext *ctx)
-{
-    uint32_t bi = rC(ctx->opcode);
-    uint32_t mask = 0x08 >> (bi & 0x03);
-    TCGv t0 = tcg_temp_new();
-    TCGv zr;
-
-    tcg_gen_extu_i32_tl(t0, cpu_crf[bi >> 2]);
-    tcg_gen_andi_tl(t0, t0, mask);
-
-    zr = tcg_constant_tl(0);
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[rD(ctx->opcode)], t0, zr,
-                       rA(ctx->opcode) ? cpu_gpr[rA(ctx->opcode)] : zr,
-                       cpu_gpr[rB(ctx->opcode)]);
-}
-
 /* cmpb: PowerPC 2.05 specification */
 static void gen_cmpb(DisasContext *ctx)
 {
@@ -4259,76 +4199,20 @@ static void gen_scv(DisasContext *ctx)
 /***                                Trap                                   ***/
 
 /* Check for unconditional traps (always or never) */
-static bool check_unconditional_trap(DisasContext *ctx)
+static bool check_unconditional_trap(DisasContext *ctx, int to)
 {
     /* Trap never */
-    if (TO(ctx->opcode) == 0) {
+    if (to == 0) {
         return true;
     }
     /* Trap always */
-    if (TO(ctx->opcode) == 31) {
+    if (to == 31) {
         gen_exception_err(ctx, POWERPC_EXCP_PROGRAM, POWERPC_EXCP_TRAP);
         return true;
     }
     return false;
 }
 
-/* tw */
-static void gen_tw(DisasContext *ctx)
-{
-    TCGv_i32 t0;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_tw(tcg_env, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],
-                  t0);
-}
-
-/* twi */
-static void gen_twi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_tl(SIMM(ctx->opcode));
-    t1 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_tw(tcg_env, cpu_gpr[rA(ctx->opcode)], t0, t1);
-}
-
-#if defined(TARGET_PPC64)
-/* td */
-static void gen_td(DisasContext *ctx)
-{
-    TCGv_i32 t0;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_td(tcg_env, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],
-                  t0);
-}
-
-/* tdi */
-static void gen_tdi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_tl(SIMM(ctx->opcode));
-    t1 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_td(tcg_env, cpu_gpr[rA(ctx->opcode)], t0, t1);
-}
-#endif
-
 /***                          Processor control                            ***/
 
 /* mcrxr */
@@ -6145,12 +6029,7 @@ GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
 #endif
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
-#endif
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6249,12 +6128,6 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 /* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
 GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
-GEN_HANDLER(tw, 0x1F, 0x04, 0x00, 0x00000001, PPC_FLOW),
-GEN_HANDLER(twi, 0x03, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(td, 0x1F, 0x04, 0x02, 0x00000001, PPC_64B),
-GEN_HANDLER(tdi, 0x02, 0xFF, 0xFF, 0x00000000, PPC_64B),
-#endif
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
 GEN_HANDLER(mfcr, 0x1F, 0x13, 0x00, 0x00000801, PPC_MISC),
 GEN_HANDLER(mfmsr, 0x1F, 0x13, 0x02, 0x001FF801, PPC_MISC),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index d8a0a21ebe..b3f071e669 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -289,6 +289,49 @@ TRANS(CMPL, do_cmp_X, false);
 TRANS(CMPI, do_cmp_D, true);
 TRANS(CMPLI, do_cmp_D, false);
 
+static bool trans_CMPRB(DisasContext *ctx, arg_CMPRB *a)
+{
+    TCGv_i32 src1 = tcg_temp_new_i32();
+    TCGv_i32 src2 = tcg_temp_new_i32();
+    TCGv_i32 src2lo = tcg_temp_new_i32();
+    TCGv_i32 src2hi = tcg_temp_new_i32();
+    TCGv_i32 crf = cpu_crf[a->bf];
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    tcg_gen_trunc_tl_i32(src1, cpu_gpr[a->ra]);
+    tcg_gen_trunc_tl_i32(src2, cpu_gpr[a->rb]);
+
+    tcg_gen_andi_i32(src1, src1, 0xFF);
+    tcg_gen_ext8u_i32(src2lo, src2);
+    tcg_gen_shri_i32(src2, src2, 8);
+    tcg_gen_ext8u_i32(src2hi, src2);
+
+    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
+    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
+    tcg_gen_and_i32(crf, src2lo, src2hi);
+
+    if (a->l) {
+        tcg_gen_shri_i32(src2, src2, 8);
+        tcg_gen_ext8u_i32(src2lo, src2);
+        tcg_gen_shri_i32(src2, src2, 8);
+        tcg_gen_ext8u_i32(src2hi, src2);
+        tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
+        tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
+        tcg_gen_and_i32(src2lo, src2lo, src2hi);
+        tcg_gen_or_i32(crf, crf, src2lo);
+    }
+    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
+    return true;
+}
+
+static bool trans_CMPEQB(DisasContext *ctx, arg_CMPEQB *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    gen_helper_CMPEQB(cpu_crf[a->bf], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+    return true;
+}
+
 /*
  * Fixed-Point Arithmetic Instructions
  */
@@ -642,6 +685,86 @@ TRANS64(DIVDEU, do_dive, gen_helper_DIVDEU);
 TRANS64(MODSD, do_modd, true);
 TRANS64(MODUD, do_modd, false);
 
+/*
+ * Fixed-Point Select Instructions
+ */
+
+static bool trans_ISEL(DisasContext *ctx, arg_ISEL *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, ISEL);
+    uint32_t bi = a->bc;
+    uint32_t mask = 0x08 >> (bi & 0x03);
+    TCGv t0 = tcg_temp_new();
+    TCGv zr;
+
+    tcg_gen_extu_i32_tl(t0, cpu_crf[bi >> 2]);
+    tcg_gen_andi_tl(t0, t0, mask);
+
+    zr = tcg_constant_tl(0);
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rt], t0, zr,
+                       a->ra ? cpu_gpr[a->ra] : zr,
+                       cpu_gpr[a->rb]);
+    return true;
+}
+
+/*
+ * Fixed-Point Trap Instructions
+ */
+
+static bool trans_TW(DisasContext *ctx, arg_TW *a)
+{
+    TCGv_i32 t0;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_i32(a->rt);
+    gen_helper_TW(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
+    return true;
+}
+
+static bool trans_TWI(DisasContext *ctx, arg_TWI *a)
+{
+    TCGv t0;
+    TCGv_i32 t1;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_tl(a->si);
+    t1 = tcg_constant_i32(a->rt);
+    gen_helper_TW(tcg_env, cpu_gpr[a->ra], t0, t1);
+    return true;
+}
+
+static bool trans_TD(DisasContext *ctx, arg_TD *a)
+{
+    TCGv_i32 t0;
+
+    REQUIRE_64BIT(ctx);
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_i32(a->rt);
+    gen_helper_TD(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
+    return true;
+}
+
+static bool trans_TDI(DisasContext *ctx, arg_TDI *a)
+{
+    TCGv t0;
+    TCGv_i32 t1;
+
+    REQUIRE_64BIT(ctx);
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_tl(a->si);
+    t1 = tcg_constant_i32(a->rt);
+    gen_helper_TD(tcg_env, cpu_gpr[a->ra], t0, t1);
+    return true;
+}
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.39.3


