Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71046C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5w5-00056C-Uv; Wed, 26 Aug 2026 01:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5w4-00054l-5U; Wed, 26 Aug 2026 01:12:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5w2-0005Vp-B6; Wed, 26 Aug 2026 01:12:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VjAE1702347; Wed, 26 Aug 2026 05:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gIexR+xnyoYoA0V5m
 hH5GN6ewMi/q1g2V6PDqGSBsbY=; b=i/VqqBJt2F14KqXTFIzl/BoXsyyAfBak0
 j7UlO9/55hKB7HXO+/B8L7nyp4B06f9FcGVccBLZ51BiocIcnJL830lwFMZHskoO
 tsxjQKIu46l3shVl93YYyIUo8cSz+6d0TQE/LxvUMjKMz2lGbnLuVYsLgQBroKBI
 XLS/3qR82KKAkX7NDd3x7L42HQj/iTWygsP3Zy83WCLKQLbMeOaGI1tB9qQpG7Vo
 sHHAhI/ywkqbmMUfY3F3Ic4cm1hcA0q/YELjd7BT46akWKoBvCLfWgNh4cK5GLZZ
 0HM0F35eMOjirWco/IDrZNzmMaHxdih1cS8ytltWRfqdk9i5owYQw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emk59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BILV031846;
 Wed, 26 Aug 2026 05:12:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8b11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5CJEQ46137822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:12:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C15E20043;
 Wed, 26 Aug 2026 05:12:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7947620040;
 Wed, 26 Aug 2026 05:12:14 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:12:14 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 26/37] target/ppc: Move lmw, stmw instructions to decodetree
Date: Wed, 26 Aug 2026 10:38:52 +0530
Message-ID: <20260826050923.74756-27-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e75b8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EKBDPzd3v7EvMxvHOJ8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX2mC31YR0FfCS
 zWMPwbrtq//70rHE0vUNNXa2LUah97ORx1Af5T5szX4eqohyXfV9KHMRTgdfNaVaz3ijlgSb8hV
 7XDVA/Uv0p0bdk/ubQkeqczSevYQiKI=
X-Proofpoint-GUID: 5lKWJnusDI_AShFAUkdZuhHQpA7wRZ-t
X-Proofpoint-ORIG-GUID: gnjx4sA-JoQSqYQfGsCoa8xxdeitxE1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX3qR8WvR6fLVx
 tTxuhH0Vo1jVBnApE0/v9cz5HpI3VFq23kQsCC40dmemCA8LeDmsWo1uGPgj2s7MonxJRxA0TXQ
 bLaJQd1SP99P6rN2EkOMf0TDfiLEsZkHcvlgnNSJc/uCTYA/zTVuKfpeaKKT/TgrenTuJsFdbn6
 kKaPeX5zHDgJylx2Hd5B3566nz2FoftqP2e/2NBVzxC++ul82Twpk10MszqvZCgzga34zoOLkMY
 rtF/FBt0uKI5KdxtJlw0IMQBhC6kuu+YDnu/qGcx4aOsmUKYlIABP4fUm48KP9W0avq4PD9U2fh
 pVnxe7mYg/wsm7hcBEpRVYllnLoQKtRoB4Z5EL5Qva8gD1g/CYDLprcC7vx/1k1J7kV9uMiBcqN
 5sWhdSfCAOruzTbNvC9cxfnY9aBWm0rS3Bv3PZ0tfDg4Fu2NxsuiU3ReQ17ncCBI+gZtQhupcDb
 k/ayHZbUS1GxfXHxY8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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

From: Tanushree Shah <tshah@linux.ibm.com>

Moving the following instructions to decodetree specification:
 lmw  : D-form
 stmw : D-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the
"-d in_asm,op" flag.

Additionally, validated using small assembly tests confirming the
the correct register store/load behavior. Also, confirmed the
register values are same before and after the change.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                        |  4 +--
 target/ppc/insn32.decode                   |  3 ++
 target/ppc/mem_helper.c                    |  4 +--
 target/ppc/translate.c                     | 39 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 32 ++++++++++++++++++
 5 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 8425eceeb3..3659408c46 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -43,8 +43,8 @@ DEF_HELPER_1(check_tlb_flush_local, void, env)
 DEF_HELPER_1(check_tlb_flush_global, void, env)
 #endif
 
-DEF_HELPER_3(lmw, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_3(LMW, void, env, tl, i32)
+DEF_HELPER_FLAGS_3(STMW, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(LSW, void, env, tl, i32, i32)
 DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 8f027e7ff5..b0fa85b93e 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -354,6 +354,7 @@ LVDX            011111 ..... ..... ..... 0000010001 -   @X
 LSKU            111010 ..... ..... ............. 0 11   @DD
 LCXU            111010 ..... ..... ............. 1 11   @DD
 
+LMW             101110 ..... ..... ................     @D
 
 ### Fixed-Point Atomic Load/Store Instructions
 
@@ -399,6 +400,8 @@ STBCIX          011111 ..... ..... ..... 1111010101 -   @X
 STHBRX          011111 ..... ..... ..... 1110010110 -   @X
 STWBRX          011111 ..... ..... ..... 1010010110 -   @X
 
+STMW            101111 ..... ..... ................     @D
+
 ### Fixed-Point Compare Instructions
 
 CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 582180cf88..7517b3954b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -73,7 +73,7 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
     return NULL;
 }
 
-void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void helper_LMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
@@ -98,7 +98,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
     }
 }
 
-void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
+void helper_STMW(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
     int mmu_idx = ppc_env_mmu_index(env, false);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d2c51b4d59..9db9d1e070 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2455,43 +2455,6 @@ GEN_LDX(lwbr, ld32ur, 0x16, 0x10, PPC_INTEGER);
 GEN_LDX_E(ldbr, ld64ur_i64, 0x14, 0x10, PPC_NONE, PPC2_DBRX, CHK_NONE);
 #endif  /* TARGET_PPC64 */
 
-/***                    Integer load and store multiple                    ***/
-
-/* lmw */
-static void gen_lmw(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    t1 = tcg_constant_i32(rD(ctx->opcode));
-    gen_addr_imm_index(ctx, t0, 0);
-    gen_helper_lmw(tcg_env, t0, t1);
-}
-
-/* stmw */
-static void gen_stmw(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (ctx->le_mode) {
-        gen_align_no_le(ctx);
-        return;
-    }
-    gen_set_access_type(ctx, ACCESS_INT);
-    t0 = tcg_temp_new();
-    t1 = tcg_constant_i32(rS(ctx->opcode));
-    gen_addr_imm_index(ctx, t0, 0);
-    gen_helper_stmw(tcg_env, t0, t1);
-}
-
-
 #if !defined(CONFIG_USER_ONLY)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 {
@@ -4708,8 +4671,6 @@ GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
 /* handles stfdp, stxsd, stxssp */
 GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 8fcee7a89d..a75279022c 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -288,6 +288,38 @@ static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
     return true;
 }
 
+/* Load/Store Multiple Word */
+static bool do_ldst_multiple(DisasContext *ctx, arg_D *a, bool store)
+{
+    TCGv ea;
+    TCGv_i32 reg;
+
+    REQUIRE_INSNS_FLAGS(ctx, INTEGER);
+
+    /* Little-endian mode is not supported for multiple word operations */
+    if (ctx->le_mode) {
+        gen_align_no_le(ctx);
+        return true;
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+
+    reg = tcg_constant_i32(a->rt);
+    ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
+
+    /* Call the appropriate helper function */
+    if (store) {
+        gen_helper_STMW(tcg_env, ea, reg);
+    } else {
+        gen_helper_LMW(tcg_env, ea, reg);
+    }
+
+    return true;
+}
+
+TRANS(LMW, do_ldst_multiple, false)
+TRANS(STMW, do_ldst_multiple, true)
+
 /*
  * Fixed-Point Compare Instructions
  */
-- 
2.55.0


