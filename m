Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC3C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 10:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC32-0008UW-JS; Thu, 19 Jun 2025 05:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2z-0008TF-Ap; Thu, 19 Jun 2025 05:59:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2w-0007r9-TI; Thu, 19 Jun 2025 05:59:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J6GwtN021030;
 Thu, 19 Jun 2025 09:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AbwTWfzaWb74KqPpU
 DT20MUesja7CCRYPmwDkdwZqfA=; b=QAOgd99qL/TxjAB+1RS52Cei3PbmwPWn4
 2lPXug+9Z7mD5ibdkzeMhuIAK1mg00tdRNx+mbdflVUM3dIYWNMFW3jX04BRNpiD
 J47sZCKHqPP6Q1gIuyvXcenNSIKSGmdko3J+8lDj4X4x2FllW3ixSmZSpWdjlIlQ
 gk+GTkTjnKOZ35cl7hkvAST+2L79nEmE8YXD51XQlUVxNaalC6PPMoEZleJfEtlP
 YeWiBkChwRnr/ss4i/8nKHyxuQobkAsTXMH534BCguMEH1lrAPhHAeH4p36ek8wB
 AUfADY3Yw9iH4ZTGoAHqoM9AEUcyerGXXBfqyJwt6ZDK2Oi5ymxMg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tecqpf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9wxYG006808;
 Thu, 19 Jun 2025 09:58:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tecqpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8jBFi005481;
 Thu, 19 Jun 2025 09:58:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwmdev3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9wurM43450844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:58:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D05D20040;
 Thu, 19 Jun 2025 09:58:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6447F20043;
 Thu, 19 Jun 2025 09:58:54 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:58:54 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 1/5] target/ppc: Move floating-point rounding and conversion
 instructions to decodetree.
Date: Thu, 19 Jun 2025 15:28:36 +0530
Message-ID: <20250619095840.369351-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
References: <20250619095840.369351-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3js9cdC5QsMW74EX5e-CwFOuzLOif4zN
X-Proofpoint-GUID: 8RyaIYBV3Nr-n7CmGRlc5FBJhrTjVNGi
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=6853df63 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=4GlWg5Je9PqTayHJxIkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3OCBTYWx0ZWRfXzDhR6xF041t0
 oD3u0nIYvelLz0/h6LA8ZvjyiU+6YLm4FTklYzQ/gpVFYdZpzYoJEciEIz7fc0UCcKcot5F1KxR
 cC+MUhH2fPWwmO2boFx9WuLhQLK412Ln4JNdrZN7IxN6kTa08QwVvxQjP+b7G04n4rbKRt/ZRUX
 G07C8bRCPINOOLmYxm9mQsJfe0BWvwtM9hH+35LERclyILQT/e167FF1OqcadsbfLJjjBlLii04
 gp2K/S1GHq52souMth53j9iwkzl5JgvJDqdrrzZrl5qezEzfNkc5dkNqbdb8e8fp/2TCie9e+iy
 rpPNC2eu+xI1e6vIQOGj6TqLEa2n9xjkAImLUvc0HVxs90kkVZ9+lj7UTdLTgKWUdi+g/XKp08b
 urUYaOjx5cfn4XsyNIVpdv5D4P4LLbG2bOHG/7hmU+tmoqqZd1/RnfVrI/qnoCuAPM5LgTsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=980 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move below instructions to decodetree specification :

	fr{sp, in, iz, im}[s][.],
	fcti{w, d}[u, z, uz][s][.],
	fcfid[s, u, us][s][.]           : X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/fpu_helper.c            | 34 +++++-----
 target/ppc/helper.h                | 34 +++++-----
 target/ppc/insn32.decode           | 24 ++++++++
 target/ppc/translate/fp-impl.c.inc | 99 ++++++++++++------------------
 target/ppc/translate/fp-ops.c.inc  | 21 -------
 5 files changed, 98 insertions(+), 114 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 07b782f971..503cbd98ad 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -562,14 +562,14 @@ uint64_t helper_##op(CPUPPCState *env, float64 arg)                    \
     return ret;                                                        \
 }
 
-FPU_FCTI(fctiw, int32, 0x80000000U)
-FPU_FCTI(fctiwz, int32_round_to_zero, 0x80000000U)
-FPU_FCTI(fctiwu, uint32, 0x00000000U)
-FPU_FCTI(fctiwuz, uint32_round_to_zero, 0x00000000U)
-FPU_FCTI(fctid, int64, 0x8000000000000000ULL)
-FPU_FCTI(fctidz, int64_round_to_zero, 0x8000000000000000ULL)
-FPU_FCTI(fctidu, uint64, 0x0000000000000000ULL)
-FPU_FCTI(fctiduz, uint64_round_to_zero, 0x0000000000000000ULL)
+FPU_FCTI(FCTIW, int32, 0x80000000U)
+FPU_FCTI(FCTIWZ, int32_round_to_zero, 0x80000000U)
+FPU_FCTI(FCTIWU, uint32, 0x00000000U)
+FPU_FCTI(FCTIWUZ, uint32_round_to_zero, 0x00000000U)
+FPU_FCTI(FCTID, int64, 0x8000000000000000ULL)
+FPU_FCTI(FCTIDZ, int64_round_to_zero, 0x8000000000000000ULL)
+FPU_FCTI(FCTIDU, uint64, 0x0000000000000000ULL)
+FPU_FCTI(FCTIDUZ, uint64_round_to_zero, 0x0000000000000000ULL)
 
 #define FPU_FCFI(op, cvtr, is_single)                      \
 uint64_t helper_##op(CPUPPCState *env, uint64_t arg)       \
@@ -586,10 +586,10 @@ uint64_t helper_##op(CPUPPCState *env, uint64_t arg)       \
     return farg.ll;                                        \
 }
 
-FPU_FCFI(fcfid, int64_to_float64, 0)
-FPU_FCFI(fcfids, int64_to_float32, 1)
-FPU_FCFI(fcfidu, uint64_to_float64, 0)
-FPU_FCFI(fcfidus, uint64_to_float32, 1)
+FPU_FCFI(FCFID, int64_to_float64, 0)
+FPU_FCFI(FCFIDS, int64_to_float32, 1)
+FPU_FCFI(FCFIDU, uint64_to_float64, 0)
+FPU_FCFI(FCFIDUS, uint64_to_float32, 1)
 
 static uint64_t do_fri(CPUPPCState *env, uint64_t arg,
                        FloatRoundMode rounding_mode)
@@ -613,22 +613,22 @@ static uint64_t do_fri(CPUPPCState *env, uint64_t arg,
     return arg;
 }
 
-uint64_t helper_frin(CPUPPCState *env, uint64_t arg)
+uint64_t helper_FRIN(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_ties_away);
 }
 
-uint64_t helper_friz(CPUPPCState *env, uint64_t arg)
+uint64_t helper_FRIZ(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_to_zero);
 }
 
-uint64_t helper_frip(CPUPPCState *env, uint64_t arg)
+uint64_t helper_FRIP(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_up);
 }
 
-uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
+uint64_t helper_FRIM(CPUPPCState *env, uint64_t arg)
 {
     return do_fri(env, arg, float_round_down);
 }
@@ -697,7 +697,7 @@ static uint64_t do_frsp(CPUPPCState *env, uint64_t arg, uintptr_t retaddr)
     return helper_todouble(f32);
 }
 
-uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
+uint64_t helper_FRSP(CPUPPCState *env, uint64_t arg)
 {
     return do_frsp(env, arg, GETPC());
 }
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ca414f2f43..96000f4f0d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -97,23 +97,23 @@ DEF_HELPER_FLAGS_1(tosingle, TCG_CALL_NO_RWG_SE, i32, i64)
 DEF_HELPER_4(fcmpo, void, env, i64, i64, i32)
 DEF_HELPER_4(fcmpu, void, env, i64, i64, i32)
 
-DEF_HELPER_2(fctiw, i64, env, i64)
-DEF_HELPER_2(fctiwu, i64, env, i64)
-DEF_HELPER_2(fctiwz, i64, env, i64)
-DEF_HELPER_2(fctiwuz, i64, env, i64)
-DEF_HELPER_2(fcfid, i64, env, i64)
-DEF_HELPER_2(fcfidu, i64, env, i64)
-DEF_HELPER_2(fcfids, i64, env, i64)
-DEF_HELPER_2(fcfidus, i64, env, i64)
-DEF_HELPER_2(fctid, i64, env, i64)
-DEF_HELPER_2(fctidu, i64, env, i64)
-DEF_HELPER_2(fctidz, i64, env, i64)
-DEF_HELPER_2(fctiduz, i64, env, i64)
-DEF_HELPER_2(frsp, i64, env, i64)
-DEF_HELPER_2(frin, i64, env, i64)
-DEF_HELPER_2(friz, i64, env, i64)
-DEF_HELPER_2(frip, i64, env, i64)
-DEF_HELPER_2(frim, i64, env, i64)
+DEF_HELPER_2(FCTIW, i64, env, i64)
+DEF_HELPER_2(FCTIWU, i64, env, i64)
+DEF_HELPER_2(FCTIWZ, i64, env, i64)
+DEF_HELPER_2(FCTIWUZ, i64, env, i64)
+DEF_HELPER_2(FCFID, i64, env, i64)
+DEF_HELPER_2(FCFIDU, i64, env, i64)
+DEF_HELPER_2(FCFIDS, i64, env, i64)
+DEF_HELPER_2(FCFIDUS, i64, env, i64)
+DEF_HELPER_2(FCTID, i64, env, i64)
+DEF_HELPER_2(FCTIDU, i64, env, i64)
+DEF_HELPER_2(FCTIDZ, i64, env, i64)
+DEF_HELPER_2(FCTIDUZ, i64, env, i64)
+DEF_HELPER_2(FRSP, i64, env, i64)
+DEF_HELPER_2(FRIN, i64, env, i64)
+DEF_HELPER_2(FRIZ, i64, env, i64)
+DEF_HELPER_2(FRIP, i64, env, i64)
+DEF_HELPER_2(FRIM, i64, env, i64)
 
 DEF_HELPER_3(FADD, f64, env, f64, f64)
 DEF_HELPER_3(FADDS, f64, env, f64, f64)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e53fd2840d..15dec702b9 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -541,6 +541,30 @@ FNMADDS         111011 ..... ..... ..... ..... 11111 .  @A
 FNMSUB          111111 ..... ..... ..... ..... 11110 .  @A
 FNMSUBS         111011 ..... ..... ..... ..... 11110 .  @A
 
+### Floating-Point Rounding and Conversion Instructions
+
+FRSP            111111 ..... ----- ..... 0000001100 .   @X_tb_rc
+
+FRIN            111111 ..... ----- ..... 0110001000 .   @X_tb_rc
+FRIZ            111111 ..... ----- ..... 0110101000 .   @X_tb_rc
+FRIP            111111 ..... ----- ..... 0111001000 .   @X_tb_rc
+FRIM            111111 ..... ----- ..... 0111101000 .   @X_tb_rc
+
+FCTIW           111111 ..... ----- ..... 0000001110 .   @X_tb_rc
+FCTIWU          111111 ..... ----- ..... 0010001110 .   @X_tb_rc
+FCTIWZ          111111 ..... ----- ..... 0000001111 .   @X_tb_rc
+FCTIWUZ         111111 ..... ----- ..... 0010001111 .   @X_tb_rc
+
+FCTID           111111 ..... ----- ..... 1100101110 .   @X_tb_rc
+FCTIDU          111111 ..... ----- ..... 1110101110 .   @X_tb_rc
+FCTIDZ          111111 ..... ----- ..... 1100101111 .   @X_tb_rc
+FCTIDUZ         111111 ..... ----- ..... 1110101111 .   @X_tb_rc
+
+FCFID           111111 ..... ----- ..... 1101001110 .   @X_tb_rc
+FCFIDS          111011 ..... ----- ..... 1101001110 .   @X_tb_rc
+FCFIDU          111111 ..... ----- ..... 1111001110 .   @X_tb_rc
+FCFIDUS         111011 ..... ----- ..... 1111001110 .   @X_tb_rc
+
 ### Floating-Point Select Instruction
 
 FSEL            111111 ..... ..... ..... ..... 10111 .  @A
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index a66b83398b..f296cfcdb0 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -98,28 +98,26 @@ static bool do_helper_ac(DisasContext *ctx, arg_A_tac *a,
     return true;
 }
 
-#define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
-static void gen_f##name(DisasContext *ctx)                                    \
-{                                                                             \
-    TCGv_i64 t0;                                                              \
-    TCGv_i64 t1;                                                              \
-    if (unlikely(!ctx->fpu_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i64();                                                  \
-    t1 = tcg_temp_new_i64();                                                  \
-    gen_reset_fpstatus();                                                     \
-    get_fpr(t0, rB(ctx->opcode));                                             \
-    gen_helper_f##name(t1, tcg_env, t0);                                      \
-    set_fpr(rD(ctx->opcode), t1);                                             \
-    if (set_fprf) {                                                           \
-        gen_helper_compute_fprf_float64(tcg_env, t1);                         \
-    }                                                                         \
-    gen_helper_float_check_status(tcg_env);                                   \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_cr1_from_fpscr(ctx);                                          \
-    }                                                                         \
+static bool do_round_convert(DisasContext *ctx, arg_X_tb_rc *a,
+                             void (*helper)(TCGv_i64, TCGv_env, TCGv_i64),
+                             bool set_fprf)
+{
+    TCGv_i64 t0, t1;
+    REQUIRE_FPU(ctx);
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    gen_reset_fpstatus();
+    get_fpr(t0, a->rb);
+    helper(t1, tcg_env, t0);
+    set_fpr(a->rt, t1);
+    if (set_fprf) {
+        gen_helper_compute_fprf_float64(tcg_env, t1);
+    }
+    gen_helper_float_check_status(tcg_env);
+    if (unlikely(a->rc)) {
+        gen_set_cr1_from_fpscr(ctx);
+    }
+    return true;
 }
 
 static bool do_helper_bs(DisasContext *ctx, arg_A_tb *a,
@@ -213,41 +211,26 @@ TRANS(FSQRT, do_helper_fsqrt, gen_helper_FSQRT);
 TRANS(FSQRTS, do_helper_fsqrt, gen_helper_FSQRTS);
 
 /***                     Floating-Point round & convert                    ***/
-/* fctiw */
-GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT);
-/* fctiwu */
-GEN_FLOAT_B(ctiwu, 0x0E, 0x04, 0, PPC2_FP_CVT_ISA206);
-/* fctiwz */
-GEN_FLOAT_B(ctiwz, 0x0F, 0x00, 0, PPC_FLOAT);
-/* fctiwuz */
-GEN_FLOAT_B(ctiwuz, 0x0F, 0x04, 0, PPC2_FP_CVT_ISA206);
-/* frsp */
-GEN_FLOAT_B(rsp, 0x0C, 0x00, 1, PPC_FLOAT);
-/* fcfid */
-GEN_FLOAT_B(cfid, 0x0E, 0x1A, 1, PPC2_FP_CVT_S64);
-/* fcfids */
-GEN_FLOAT_B(cfids, 0x0E, 0x1A, 0, PPC2_FP_CVT_ISA206);
-/* fcfidu */
-GEN_FLOAT_B(cfidu, 0x0E, 0x1E, 0, PPC2_FP_CVT_ISA206);
-/* fcfidus */
-GEN_FLOAT_B(cfidus, 0x0E, 0x1E, 0, PPC2_FP_CVT_ISA206);
-/* fctid */
-GEN_FLOAT_B(ctid, 0x0E, 0x19, 0, PPC2_FP_CVT_S64);
-/* fctidu */
-GEN_FLOAT_B(ctidu, 0x0E, 0x1D, 0, PPC2_FP_CVT_ISA206);
-/* fctidz */
-GEN_FLOAT_B(ctidz, 0x0F, 0x19, 0, PPC2_FP_CVT_S64);
-/* fctidu */
-GEN_FLOAT_B(ctiduz, 0x0F, 0x1D, 0, PPC2_FP_CVT_ISA206);
-
-/* frin */
-GEN_FLOAT_B(rin, 0x08, 0x0C, 1, PPC_FLOAT_EXT);
-/* friz */
-GEN_FLOAT_B(riz, 0x08, 0x0D, 1, PPC_FLOAT_EXT);
-/* frip */
-GEN_FLOAT_B(rip, 0x08, 0x0E, 1, PPC_FLOAT_EXT);
-/* frim */
-GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT);
+TRANS_FLAGS(FLOAT, FRSP, do_round_convert, gen_helper_FRSP, true);
+TRANS_FLAGS(FLOAT_EXT, FRIN, do_round_convert, gen_helper_FRIN, true);
+TRANS_FLAGS(FLOAT_EXT, FRIZ, do_round_convert, gen_helper_FRIZ, true);
+TRANS_FLAGS(FLOAT_EXT, FRIP, do_round_convert, gen_helper_FRIP, true);
+TRANS_FLAGS(FLOAT_EXT, FRIM, do_round_convert, gen_helper_FRIM, true);
+
+TRANS_FLAGS(FLOAT, FCTIW, do_round_convert, gen_helper_FCTIW, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCTIWU, do_round_convert, gen_helper_FCTIWU, false);
+TRANS_FLAGS(FLOAT, FCTIWZ, do_round_convert, gen_helper_FCTIWZ, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCTIWUZ, do_round_convert, gen_helper_FCTIWUZ, false);
+
+TRANS_FLAGS2(FP_CVT_S64, FCTID, do_round_convert, gen_helper_FCTID, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCTIDU, do_round_convert, gen_helper_FCTIDU, false);
+TRANS_FLAGS2(FP_CVT_S64, FCTIDZ, do_round_convert, gen_helper_FCTIDZ, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCTIDUZ, do_round_convert, gen_helper_FCTIDUZ, false);
+
+TRANS_FLAGS2(FP_CVT_S64, FCFID, do_round_convert, gen_helper_FCFID, true);
+TRANS_FLAGS2(FP_CVT_ISA206, FCFIDS, do_round_convert, gen_helper_FCFIDS, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCFIDU, do_round_convert, gen_helper_FCFIDU, false);
+TRANS_FLAGS2(FP_CVT_ISA206, FCFIDUS, do_round_convert, gen_helper_FCFIDUS, false);
 
 static bool trans_FTDIV(DisasContext *ctx, arg_X_bf *a)
 {
@@ -1051,8 +1034,6 @@ TRANS(STFDX, do_lsfp_X, false, true, false)
 TRANS(STFDUX, do_lsfp_X, true, true, false)
 TRANS(PSTFD, do_lsfp_PLS_D, false, true, false)
 
-#undef GEN_FLOAT_B
-
 #undef GEN_LDF
 #undef GEN_LDUF
 #undef GEN_LDUXF
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index cef4b5dfcb..acb8ac32da 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -1,24 +1,3 @@
-#define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
-GEN_HANDLER(f##name, 0x3F, op2, op3, 0x001F0000, type)
-
-GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT),
-GEN_HANDLER_E(fctiwu, 0x3F, 0x0E, 0x04, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_FLOAT_B(ctiwz, 0x0F, 0x00, 0, PPC_FLOAT),
-GEN_HANDLER_E(fctiwuz, 0x3F, 0x0F, 0x04, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_FLOAT_B(rsp, 0x0C, 0x00, 1, PPC_FLOAT),
-GEN_HANDLER_E(fcfid, 0x3F, 0x0E, 0x1A, 0x001F0000, PPC_NONE, PPC2_FP_CVT_S64),
-GEN_HANDLER_E(fcfids, 0x3B, 0x0E, 0x1A, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(fcfidu, 0x3F, 0x0E, 0x1E, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(fcfidus, 0x3B, 0x0E, 0x1E, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(fctid, 0x3F, 0x0E, 0x19, 0x001F0000, PPC_NONE, PPC2_FP_CVT_S64),
-GEN_HANDLER_E(fctidu, 0x3F, 0x0E, 0x1D, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(fctidz, 0x3F, 0x0F, 0x19, 0x001F0000, PPC_NONE, PPC2_FP_CVT_S64),
-GEN_HANDLER_E(fctiduz, 0x3F, 0x0F, 0x1D, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_FLOAT_B(rin, 0x08, 0x0C, 1, PPC_FLOAT_EXT),
-GEN_FLOAT_B(riz, 0x08, 0x0D, 1, PPC_FLOAT_EXT),
-GEN_FLOAT_B(rip, 0x08, 0x0E, 1, PPC_FLOAT_EXT),
-GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT),
-
 GEN_HANDLER_E(lfdepx, 0x1F, 0x1F, 0x12, 0x00000001, PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA205),
 GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA206),
-- 
2.49.0


