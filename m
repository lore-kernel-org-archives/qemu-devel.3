Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA0C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBYZ-000630-Iy; Thu, 07 Mar 2024 06:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1riBXy-00062e-Qa; Thu, 07 Mar 2024 06:04:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1riBXv-0001bA-1i; Thu, 07 Mar 2024 06:04:22 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 427B0RvQ007327; Thu, 7 Mar 2024 11:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YivvBDjrGbNnp4N5hpyNrUbGUPwQc+nhicIT2BuSz4M=;
 b=CSvjY0JyIcpMQnAzleTs9EHJLtD55VHoZya2Uvx0V/+33rU7bdp04mj01oedTaAmkGag
 U0XlzgmkQr6l4YqVzWOPf1xoTXQveJLl8HP3Etr4jVWyLWEFOOa/Bqj9PYaEPNaNAuZo
 LMrh4reshayZxBzFEbHNlGZsyq10HMdPrum2GNfImjbcQsgwvC2EJUc17eMn0IRZpuSg
 vwP6R0DZjg4mTir0aQRG/srUsWYcwU8K6zFG6SSgd5UQ9Xg7JBYv/lYuSnZ7E1JiKFCh
 DQJOfJxHmz0F1DPAFNAK2sgvN/f2pqCht2eGoaD/1pvHVS842NH/CQ5K4V0AoX1X7AtM hA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqcawr2a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 11:03:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427B0u58009062;
 Thu, 7 Mar 2024 11:03:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqcawr27c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 11:03:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4279hNIQ006045; Thu, 7 Mar 2024 11:03:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetdc7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 11:03:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 427B3OQ126477090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Mar 2024 11:03:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E68912004B;
 Thu,  7 Mar 2024 11:03:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4AAC20043;
 Thu,  7 Mar 2024 11:03:21 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Mar 2024 11:03:21 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 richard.henderson@linaro.org, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com, rathc@linux.ibm.com
Subject: [PATCH] target/ppc: Move floating-point arithmetic instructions to
 decodetree.
Date: Thu,  7 Mar 2024 16:33:18 +0530
Message-Id: <20240307110318.170319-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9wWJF28ZF5afF39JiVNykbwk6T0eGzLu
X-Proofpoint-ORIG-GUID: yoAUcHaFjEA76v5sEzpPKsP8Xa8m02J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch moves the below instructions to decodetree specification :

    f{add, sub, mul, div, re, rsqrte, madd, msub, nmadd, nmsub}[s][.] : A-form
    ft{div, sqrt}                                                     : X-form

With this patch, all the floating-point arithmetic instructions have been
moved to decodetree.
The patch also merges the definitions of different sets of helper methods of
the above instructions, which are similar, using macros.
The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                |  44 ++---
 target/ppc/insn32.decode           |  42 +++++
 target/ppc/fpu_helper.c            | 265 +++++++++-----------------
 target/ppc/translate/fp-impl.c.inc | 288 +++++++++++------------------
 target/ppc/translate/fp-ops.c.inc  |  31 ----
 5 files changed, 262 insertions(+), 408 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..f177d5b906 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -110,32 +110,32 @@ DEF_HELPER_2(friz, i64, env, i64)
 DEF_HELPER_2(frip, i64, env, i64)
 DEF_HELPER_2(frim, i64, env, i64)
 
-DEF_HELPER_3(fadd, f64, env, f64, f64)
-DEF_HELPER_3(fadds, f64, env, f64, f64)
-DEF_HELPER_3(fsub, f64, env, f64, f64)
-DEF_HELPER_3(fsubs, f64, env, f64, f64)
-DEF_HELPER_3(fmul, f64, env, f64, f64)
-DEF_HELPER_3(fmuls, f64, env, f64, f64)
-DEF_HELPER_3(fdiv, f64, env, f64, f64)
-DEF_HELPER_3(fdivs, f64, env, f64, f64)
-DEF_HELPER_4(fmadd, i64, env, i64, i64, i64)
-DEF_HELPER_4(fmsub, i64, env, i64, i64, i64)
-DEF_HELPER_4(fnmadd, i64, env, i64, i64, i64)
-DEF_HELPER_4(fnmsub, i64, env, i64, i64, i64)
-DEF_HELPER_4(fmadds, i64, env, i64, i64, i64)
-DEF_HELPER_4(fmsubs, i64, env, i64, i64, i64)
-DEF_HELPER_4(fnmadds, i64, env, i64, i64, i64)
-DEF_HELPER_4(fnmsubs, i64, env, i64, i64, i64)
+DEF_HELPER_3(FADD, f64, env, f64, f64)
+DEF_HELPER_3(FADDS, f64, env, f64, f64)
+DEF_HELPER_3(FSUB, f64, env, f64, f64)
+DEF_HELPER_3(FSUBS, f64, env, f64, f64)
+DEF_HELPER_3(FMUL, f64, env, f64, f64)
+DEF_HELPER_3(FMULS, f64, env, f64, f64)
+DEF_HELPER_3(FDIV, f64, env, f64, f64)
+DEF_HELPER_3(FDIVS, f64, env, f64, f64)
+DEF_HELPER_4(FMADD, i64, env, i64, i64, i64)
+DEF_HELPER_4(FMSUB, i64, env, i64, i64, i64)
+DEF_HELPER_4(FNMADD, i64, env, i64, i64, i64)
+DEF_HELPER_4(FNMSUB, i64, env, i64, i64, i64)
+DEF_HELPER_4(FMADDS, i64, env, i64, i64, i64)
+DEF_HELPER_4(FMSUBS, i64, env, i64, i64, i64)
+DEF_HELPER_4(FNMADDS, i64, env, i64, i64, i64)
+DEF_HELPER_4(FNMSUBS, i64, env, i64, i64, i64)
 DEF_HELPER_2(FSQRT, f64, env, f64)
 DEF_HELPER_2(FSQRTS, f64, env, f64)
-DEF_HELPER_2(fre, i64, env, i64)
-DEF_HELPER_2(fres, i64, env, i64)
-DEF_HELPER_2(frsqrte, i64, env, i64)
-DEF_HELPER_2(frsqrtes, i64, env, i64)
+DEF_HELPER_2(FRE, i64, env, i64)
+DEF_HELPER_2(FRES, i64, env, i64)
+DEF_HELPER_2(FRSQRTE, i64, env, i64)
+DEF_HELPER_2(FRSQRTES, i64, env, i64)
 DEF_HELPER_FLAGS_3(FSEL, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 
-DEF_HELPER_FLAGS_2(ftdiv, TCG_CALL_NO_RWG_SE, i32, i64, i64)
-DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, i64)
+DEF_HELPER_FLAGS_2(FTDIV, TCG_CALL_NO_RWG_SE, i32, i64, i64)
+DEF_HELPER_FLAGS_1(FTSQRT, TCG_CALL_NO_RWG_SE, i32, i64)
 
 #define dh_alias_avr ptr
 #define dh_ctype_avr ppc_avr_t *
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 4fcf3af8d0..a314172a2e 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -20,6 +20,12 @@
 &A              frt fra frb frc rc:bool
 @A              ...... frt:5 fra:5 frb:5 frc:5 ..... rc:1       &A
 
+&A_tab          frt fra frb rc:bool
+@A_tab          ...... frt:5 fra:5 frb:5 ..... ..... rc:1       &A_tab
+
+&A_tac          frt fra frc rc:bool
+@A_tac          ...... frt:5 fra:5 ..... frc:5 ..... rc:1       &A_tac
+
 &A_tb           frt frb rc:bool
 @A_tb           ...... frt:5 ..... frb:5 ..... ..... rc:1       &A_tb
 
@@ -124,6 +130,9 @@
 &X_bf           bf ra rb
 @X_bf           ...... bf:3 .. ra:5 rb:5 .......... .           &X_bf
 
+&X_bf_b         bf rb
+@X_bf_b         ...... bf:3 .. ..... rb:5 .......... .          &X_bf_b
+
 @X_bf_ap_bp     ...... bf:3 .. ....0 ....0 .......... .         &X_bf ra=%x_frap rb=%x_frbp
 
 @X_bf_a_bp      ...... bf:3 .. ra:5 ....0 .......... .          &X_bf rb=%x_frbp
@@ -374,9 +383,42 @@ STFDUX          011111 ..... ...... .... 1011110111 -   @X
 
 ### Floating-Point Arithmetic Instructions
 
+FADD            111111 ..... ..... ..... ----- 10101 .  @A_tab
+FADDS           111011 ..... ..... ..... ----- 10101 .  @A_tab
+
+FSUB            111111 ..... ..... ..... ----- 10100 .  @A_tab
+FSUBS           111011 ..... ..... ..... ----- 10100 .  @A_tab
+
+FMUL            111111 ..... ..... ----- ..... 11001 .  @A_tac
+FMULS           111011 ..... ..... ----- ..... 11001 .  @A_tac
+
+FDIV            111111 ..... ..... ..... ----- 10010 .  @A_tab
+FDIVS           111011 ..... ..... ..... ----- 10010 .  @A_tab
+
 FSQRT           111111 ..... ----- ..... ----- 10110 .  @A_tb
 FSQRTS          111011 ..... ----- ..... ----- 10110 .  @A_tb
 
+FRE             111111 ..... ----- ..... ----- 11000 .  @A_tb
+FRES            111011 ..... ----- ..... ----- 11000 .  @A_tb
+
+FRSQRTE         111111 ..... ----- ..... ----- 11010 .  @A_tb
+FRSQRTES        111011 ..... ----- ..... ----- 11010 .  @A_tb
+
+FTDIV           111111 ... -- ..... ..... 0010000000 -  @X_bf
+FTSQRT          111111 ... -- ----- ..... 0010100000 -  @X_bf_b
+
+FMADD           111111 ..... ..... ..... ..... 11101 .  @A
+FMADDS          111011 ..... ..... ..... ..... 11101 .  @A
+
+FMSUB           111111 ..... ..... ..... ..... 11100 .  @A
+FMSUBS          111011 ..... ..... ..... ..... 11100 .  @A
+
+FNMADD          111111 ..... ..... ..... ..... 11111 .  @A
+FNMADDS         111011 ..... ..... ..... ..... 11111 .  @A
+
+FNMSUB          111111 ..... ..... ..... ..... 11110 .  @A
+FNMSUBS         111011 ..... ..... ..... ..... 11110 .  @A
+
 ### Floating-Point Select Instruction
 
 FSEL            111111 ..... ..... ..... ..... 10111 .  @A
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b3dcad5d1..a3fcfb3907 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -490,54 +490,16 @@ static void float_invalid_op_addsub(CPUPPCState *env, int flags,
     }
 }
 
-/* fadd - fadd. */
-float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_add(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-
-    return ret;
-}
-
-/* fadds - fadds. */
-float64 helper_fadds(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_add(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-    return ret;
-}
-
-/* fsub - fsub. */
-float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_sub(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-
-    return ret;
-}
-
-/* fsubs - fsubs. */
-float64 helper_fsubs(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_sub(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-    return ret;
+#define FPU_ADD_SUB(name, op)                                                 \
+float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+{                                                                             \
+    float64 ret = op(arg1, arg2, &env->fp_status);                            \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid)) {                               \
+        float_invalid_op_addsub(env, flags, 1, GETPC());                      \
+    }                                                                         \
+    return ret;                                                               \
 }
 
 static void float_invalid_op_mul(CPUPPCState *env, int flags,
@@ -550,29 +512,17 @@ static void float_invalid_op_mul(CPUPPCState *env, int flags,
     }
 }
 
-/* fmul - fmul. */
-float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_mul(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_mul(env, flags, 1, GETPC());
-    }
-
-    return ret;
-}
-
-/* fmuls - fmuls. */
-float64 helper_fmuls(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_mul(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_mul(env, flags, 1, GETPC());
-    }
-    return ret;
+#define FPU_MUL(name, op)                                                     \
+float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+{                                                                             \
+    float64 ret = op(arg1, arg2, &env->fp_status);                            \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid)) {                               \
+        float_invalid_op_mul(env, flags, 1, GETPC());                         \
+    }                                                                         \
+                                                                              \
+    return ret;                                                               \
 }
 
 static void float_invalid_op_div(CPUPPCState *env, int flags,
@@ -587,37 +537,31 @@ static void float_invalid_op_div(CPUPPCState *env, int flags,
     }
 }
 
-/* fdiv - fdiv. */
-float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_div(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_div(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return ret;
+#define FPU_DIV(name, op)                                                     \
+float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+{                                                                             \
+    float64 ret = op(arg1, arg2, &env->fp_status);                            \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid)) {                               \
+        float_invalid_op_div(env, flags, 1, GETPC());                         \
+    }                                                                         \
+    if (unlikely(flags & float_flag_divbyzero)) {                             \
+        float_zero_divide_excp(env, GETPC());                                 \
+    }                                                                         \
+                                                                              \
+    return ret;                                                               \
 }
 
-/* fdivs - fdivs. */
-float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_div(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_div(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-    }
 
-    return ret;
-}
+FPU_ADD_SUB(FADD, float64_add)
+FPU_ADD_SUB(FADDS, float64r32_add)
+FPU_ADD_SUB(FSUB, float64_sub)
+FPU_ADD_SUB(FSUBS, float64r32_sub)
+FPU_MUL(FMUL, float64_mul)
+FPU_MUL(FMULS, float64r32_mul)
+FPU_DIV(FDIV, float64_div)
+FPU_DIV(FDIVS, float64r32_div)
 
 static uint64_t float_invalid_cvt(CPUPPCState *env, int flags,
                                   uint64_t ret, uint64_t ret_nan,
@@ -755,7 +699,7 @@ static uint64_t do_fmadds(CPUPPCState *env, float64 a, float64 b,
     uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,            \
                          uint64_t arg2, uint64_t arg3)               \
     { return do_fmadd(env, arg1, arg2, arg3, madd_flags, GETPC()); } \
-    uint64_t helper_##op##s(CPUPPCState *env, uint64_t arg1,         \
+    uint64_t helper_##op##S(CPUPPCState *env, uint64_t arg1,         \
                          uint64_t arg2, uint64_t arg3)               \
     { return do_fmadds(env, arg1, arg2, arg3, madd_flags, GETPC()); }
 
@@ -764,10 +708,10 @@ static uint64_t do_fmadds(CPUPPCState *env, float64 a, float64 b,
 #define NMADD_FLGS float_muladd_negate_result
 #define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
 
-FPU_FMADD(fmadd, MADD_FLGS)
-FPU_FMADD(fnmadd, NMADD_FLGS)
-FPU_FMADD(fmsub, MSUB_FLGS)
-FPU_FMADD(fnmsub, NMSUB_FLGS)
+FPU_FMADD(FMADD, MADD_FLGS)
+FPU_FMADD(FNMADD, NMADD_FLGS)
+FPU_FMADD(FMSUB, MSUB_FLGS)
+FPU_FMADD(FNMSUB, NMSUB_FLGS)
 
 /* frsp - frsp. */
 static uint64_t do_frsp(CPUPPCState *env, uint64_t arg, uintptr_t retaddr)
@@ -812,81 +756,48 @@ float64 helper_##name(CPUPPCState *env, float64 arg)                          \
 FPU_FSQRT(FSQRT, float64_sqrt)
 FPU_FSQRT(FSQRTS, float64r32_sqrt)
 
-/* fre - fre. */
-float64 helper_fre(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 ret = float64_div(float64_one, arg, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid_snan)) {
-        float_invalid_op_vxsnan(env, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-        /* For FPSCR.ZE == 0, the result is 1/2.  */
-        ret = float64_set_sign(float64_half, float64_is_neg(arg));
-    }
-
-    return ret;
-}
-
-/* fres - fres. */
-uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 ret = float64r32_div(float64_one, arg, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid_snan)) {
-        float_invalid_op_vxsnan(env, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-        /* For FPSCR.ZE == 0, the result is 1/2.  */
-        ret = float64_set_sign(float64_half, float64_is_neg(arg));
-    }
-
-    return ret;
+#define FPU_FRE(name, op)                                                     \
+float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+{                                                                             \
+    /* "Estimate" the reciprocal with actual division.  */                    \
+    float64 ret = op(float64_one, arg, &env->fp_status);                      \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid_snan)) {                          \
+        float_invalid_op_vxsnan(env, GETPC());                                \
+    }                                                                         \
+    if (unlikely(flags & float_flag_divbyzero)) {                             \
+        float_zero_divide_excp(env, GETPC());                                 \
+        /* For FPSCR.ZE == 0, the result is 1/2.  */                          \
+        ret = float64_set_sign(float64_half, float64_is_neg(arg));            \
+    }                                                                         \
+                                                                              \
+    return ret;                                                               \
 }
 
-/* frsqrte  - frsqrte. */
-float64 helper_frsqrte(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 rets = float64_sqrt(arg, &env->fp_status);
-    float64 retd = float64_div(float64_one, rets, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_sqrt(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        /* Reciprocal of (square root of) zero.  */
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return retd;
+#define FPU_FRSQRTE(name, op)                                                 \
+float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+{                                                                             \
+    /* "Estimate" the reciprocal with actual division.  */                    \
+    float64 rets = float64_sqrt(arg, &env->fp_status);                        \
+    float64 retd = op(float64_one, rets, &env->fp_status);                    \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid)) {                               \
+        float_invalid_op_sqrt(env, flags, 1, GETPC());                        \
+    }                                                                         \
+    if (unlikely(flags & float_flag_divbyzero)) {                             \
+        /* Reciprocal of (square root of) zero.  */                           \
+        float_zero_divide_excp(env, GETPC());                                 \
+    }                                                                         \
+                                                                              \
+    return retd;                                                              \
 }
 
-/* frsqrtes  - frsqrtes. */
-float64 helper_frsqrtes(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 rets = float64_sqrt(arg, &env->fp_status);
-    float64 retd = float64r32_div(float64_one, rets, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_sqrt(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        /* Reciprocal of (square root of) zero.  */
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return retd;
-}
+FPU_FRE(FRE, float64_div)
+FPU_FRE(FRES, float64r32_div)
+FPU_FRSQRTE(FRSQRTE, float64_div)
+FPU_FRSQRTE(FRSQRTES, float64r32_div)
 
 /* fsel - fsel. */
 uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
@@ -903,7 +814,7 @@ uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
     }
 }
 
-uint32_t helper_ftdiv(uint64_t fra, uint64_t frb)
+uint32_t helper_FTDIV(uint64_t fra, uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
@@ -939,7 +850,7 @@ uint32_t helper_ftdiv(uint64_t fra, uint64_t frb)
     return 0x8 | (fg_flag ? 4 : 0) | (fe_flag ? 2 : 0);
 }
 
-uint32_t helper_ftsqrt(uint64_t frb)
+uint32_t helper_FTSQRT(uint64_t frb)
 {
     int fe_flag = 0;
     int fg_flag = 0;
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 189cd8c979..03b84ba79b 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -30,96 +30,73 @@ static void gen_set_cr1_from_fpscr(DisasContext *ctx)
 #endif
 
 /***                       Floating-Point arithmetic                       ***/
-#define _GEN_FLOAT_ACB(name, op1, op2, set_fprf, type)                        \
-static void gen_f##name(DisasContext *ctx)                                    \
-{                                                                             \
-    TCGv_i64 t0;                                                              \
-    TCGv_i64 t1;                                                              \
-    TCGv_i64 t2;                                                              \
-    TCGv_i64 t3;                                                              \
-    if (unlikely(!ctx->fpu_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i64();                                                  \
-    t1 = tcg_temp_new_i64();                                                  \
-    t2 = tcg_temp_new_i64();                                                  \
-    t3 = tcg_temp_new_i64();                                                  \
-    gen_reset_fpstatus();                                                     \
-    get_fpr(t0, rA(ctx->opcode));                                             \
-    get_fpr(t1, rC(ctx->opcode));                                             \
-    get_fpr(t2, rB(ctx->opcode));                                             \
-    gen_helper_f##name(t3, tcg_env, t0, t1, t2);                              \
-    set_fpr(rD(ctx->opcode), t3);                                             \
-    if (set_fprf) {                                                           \
-        gen_compute_fprf_float64(t3);                                         \
-    }                                                                         \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_cr1_from_fpscr(ctx);                                          \
-    }                                                                         \
+static bool do_helper_acb(DisasContext *ctx, arg_A *a,
+                          void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
+                                         TCGv_i64, TCGv_i64))
+{
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0, t1, t2, t3;
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    t3 = tcg_temp_new_i64();
+    gen_reset_fpstatus();
+    get_fpr(t0, a->fra);
+    get_fpr(t1, a->frc);
+    get_fpr(t2, a->frb);
+    helper(t3, tcg_env, t0, t1, t2);
+    set_fpr(a->frt, t3);
+    gen_compute_fprf_float64(t3);
+    if (unlikely(a->rc != false)) {
+        gen_set_cr1_from_fpscr(ctx);
+    }
+    return true;
 }
 
-#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                              \
-_GEN_FLOAT_ACB(name, 0x3F, op2, set_fprf, type);                              \
-_GEN_FLOAT_ACB(name##s, 0x3B, op2, set_fprf, type);
-
-#define _GEN_FLOAT_AB(name, op1, op2, inval, set_fprf, type)                  \
-static void gen_f##name(DisasContext *ctx)                                    \
-{                                                                             \
-    TCGv_i64 t0;                                                              \
-    TCGv_i64 t1;                                                              \
-    TCGv_i64 t2;                                                              \
-    if (unlikely(!ctx->fpu_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i64();                                                  \
-    t1 = tcg_temp_new_i64();                                                  \
-    t2 = tcg_temp_new_i64();                                                  \
-    gen_reset_fpstatus();                                                     \
-    get_fpr(t0, rA(ctx->opcode));                                             \
-    get_fpr(t1, rB(ctx->opcode));                                             \
-    gen_helper_f##name(t2, tcg_env, t0, t1);                                  \
-    set_fpr(rD(ctx->opcode), t2);                                             \
-    if (set_fprf) {                                                           \
-        gen_compute_fprf_float64(t2);                                         \
-    }                                                                         \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_cr1_from_fpscr(ctx);                                          \
-    }                                                                         \
+static bool do_helper_ab(DisasContext *ctx, arg_A_tab *a,
+                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
+                                        TCGv_i64))
+{
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0, t1, t2;
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    gen_reset_fpstatus();
+    get_fpr(t0, a->fra);
+    get_fpr(t1, a->frb);
+    helper(t2, tcg_env, t0, t1);
+    set_fpr(a->frt, t2);
+    gen_compute_fprf_float64(t2);
+    if (unlikely(a->rc) != false) {
+        gen_set_cr1_from_fpscr(ctx);
+    }
+    return true;
 }
-#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                        \
-_GEN_FLOAT_AB(name, 0x3F, op2, inval, set_fprf, type);                        \
-_GEN_FLOAT_AB(name##s, 0x3B, op2, inval, set_fprf, type);
 
-#define _GEN_FLOAT_AC(name, op1, op2, inval, set_fprf, type)                  \
-static void gen_f##name(DisasContext *ctx)                                    \
-{                                                                             \
-    TCGv_i64 t0;                                                              \
-    TCGv_i64 t1;                                                              \
-    TCGv_i64 t2;                                                              \
-    if (unlikely(!ctx->fpu_enabled)) {                                        \
-        gen_exception(ctx, POWERPC_EXCP_FPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    t0 = tcg_temp_new_i64();                                                  \
-    t1 = tcg_temp_new_i64();                                                  \
-    t2 = tcg_temp_new_i64();                                                  \
-    gen_reset_fpstatus();                                                     \
-    get_fpr(t0, rA(ctx->opcode));                                             \
-    get_fpr(t1, rC(ctx->opcode));                                             \
-    gen_helper_f##name(t2, tcg_env, t0, t1);                                  \
-    set_fpr(rD(ctx->opcode), t2);                                             \
-    if (set_fprf) {                                                           \
-        gen_compute_fprf_float64(t2);                                         \
-    }                                                                         \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_cr1_from_fpscr(ctx);                                          \
-    }                                                                         \
+static bool do_helper_ac(DisasContext *ctx, arg_A_tac *a,
+                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64,
+                                        TCGv_i64))
+{
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0, t1, t2;
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    gen_reset_fpstatus();
+    get_fpr(t0, a->fra);
+    get_fpr(t1, a->frc);
+    helper(t2, tcg_env, t0, t1);
+    set_fpr(a->frt, t2);
+    gen_compute_fprf_float64(t2);
+    if (unlikely(a->rc) != false) {
+        gen_set_cr1_from_fpscr(ctx);
+    }
+    return true;
 }
-#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                        \
-_GEN_FLOAT_AC(name, 0x3F, op2, inval, set_fprf, type);                        \
-_GEN_FLOAT_AC(name##s, 0x3B, op2, inval, set_fprf, type);
 
 #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
 static void gen_f##name(DisasContext *ctx)                                    \
@@ -145,64 +122,22 @@ static void gen_f##name(DisasContext *ctx)                                    \
     }                                                                         \
 }
 
-#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                          \
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
-        gen_compute_fprf_float64(t1);                                         \
-    }                                                                         \
-    if (unlikely(Rc(ctx->opcode) != 0)) {                                     \
-        gen_set_cr1_from_fpscr(ctx);                                          \
-    }                                                                         \
-}
-
-/* fadd - fadds */
-GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
-/* fdiv - fdivs */
-GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
-/* fmul - fmuls */
-GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
-
-/* fre */
-GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT);
-
-/* fres */
-GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES);
-
-/* frsqrte */
-GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE);
-
-/* frsqrtes */
-static void gen_frsqrtes(DisasContext *ctx)
+static bool do_helper_bs(DisasContext *ctx, arg_A_tb *a,
+                         void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64))
 {
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0, t1;
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_reset_fpstatus();
-    get_fpr(t0, rB(ctx->opcode));
-    gen_helper_frsqrtes(t1, tcg_env, t0);
-    set_fpr(rD(ctx->opcode), t1);
+    get_fpr(t0, a->frb);
+    helper(t1, tcg_env, t0);
+    set_fpr(a->frt, t1);
     gen_compute_fprf_float64(t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(a->rc != false)) {
         gen_set_cr1_from_fpscr(ctx);
     }
+    return true;
 }
 
 static bool trans_FSEL(DisasContext *ctx, arg_A *a)
@@ -228,10 +163,6 @@ static bool trans_FSEL(DisasContext *ctx, arg_A *a)
     return true;
 }
 
-/* fsub - fsubs */
-GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT);
-/* Optional: */
-
 static bool do_helper_fsqrt(DisasContext *ctx, arg_A_tb *a,
                             void (*helper)(TCGv_i64, TCGv_ptr, TCGv_i64))
 {
@@ -254,19 +185,33 @@ static bool do_helper_fsqrt(DisasContext *ctx, arg_A_tb *a,
     return true;
 }
 
+TRANS(FADD, do_helper_ab, gen_helper_FADD);
+TRANS(FADDS, do_helper_ab, gen_helper_FADDS);
+TRANS(FSUB, do_helper_ab, gen_helper_FSUB);
+TRANS(FSUBS, do_helper_ab, gen_helper_FSUBS);
+TRANS(FDIV, do_helper_ab, gen_helper_FDIV);
+TRANS(FDIVS, do_helper_ab, gen_helper_FDIVS);
+TRANS(FMUL, do_helper_ac, gen_helper_FMUL);
+TRANS(FMULS, do_helper_ac, gen_helper_FMULS);
+
+TRANS(FMADD, do_helper_acb, gen_helper_FMADD);
+TRANS(FMADDS, do_helper_acb, gen_helper_FMADDS);
+TRANS(FMSUB, do_helper_acb, gen_helper_FMSUB);
+TRANS(FMSUBS, do_helper_acb, gen_helper_FMSUBS);
+
+TRANS(FNMADD, do_helper_acb, gen_helper_FNMADD);
+TRANS(FNMADDS, do_helper_acb, gen_helper_FNMADDS);
+TRANS(FNMSUB, do_helper_acb, gen_helper_FNMSUB);
+TRANS(FNMSUBS, do_helper_acb, gen_helper_FNMSUBS);
+
+TRANS_FLAGS(FLOAT_EXT, FRE, do_helper_bs, gen_helper_FRE);
+TRANS_FLAGS(FLOAT_FRES, FRES, do_helper_bs, gen_helper_FRES);
+TRANS_FLAGS(FLOAT_FRSQRTE, FRSQRTE, do_helper_bs, gen_helper_FRSQRTE);
+TRANS_FLAGS(FLOAT_FRSQRTES, FRSQRTES, do_helper_bs, gen_helper_FRSQRTES);
+
 TRANS(FSQRT, do_helper_fsqrt, gen_helper_FSQRT);
 TRANS(FSQRTS, do_helper_fsqrt, gen_helper_FSQRTS);
 
-/***                     Floating-Point multiply-and-add                   ***/
-/* fmadd - fmadds */
-GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT);
-/* fmsub - fmsubs */
-GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT);
-/* fnmadd - fnmadds */
-GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT);
-/* fnmsub - fnmsubs */
-GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT);
-
 /***                     Floating-Point round & convert                    ***/
 /* fctiw */
 GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT);
@@ -304,35 +249,29 @@ GEN_FLOAT_B(rip, 0x08, 0x0E, 1, PPC_FLOAT_EXT);
 /* frim */
 GEN_FLOAT_B(rim, 0x08, 0x0F, 1, PPC_FLOAT_EXT);
 
-static void gen_ftdiv(DisasContext *ctx)
+static bool trans_FTDIV(DisasContext *ctx, arg_X_bf *a)
 {
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0, t1;
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
-    get_fpr(t0, rA(ctx->opcode));
-    get_fpr(t1, rB(ctx->opcode));
-    gen_helper_ftdiv(cpu_crf[crfD(ctx->opcode)], t0, t1);
+    get_fpr(t0, a->ra);
+    get_fpr(t1, a->rb);
+    gen_helper_FTDIV(cpu_crf[a->bf], t0, t1);
+    return true;
 }
 
-static void gen_ftsqrt(DisasContext *ctx)
+static bool trans_FTSQRT(DisasContext *ctx, arg_X_bf_b *a)
 {
-    TCGv_i64 t0;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
-    t0 = tcg_temp_new_i64();
-    get_fpr(t0, rB(ctx->opcode));
-    gen_helper_ftsqrt(cpu_crf[crfD(ctx->opcode)], t0);
+    REQUIRE_INSNS_FLAGS2(ctx, FP_TST_ISA206);
+    REQUIRE_FPU(ctx);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    get_fpr(t0, a->rb);
+    gen_helper_FTSQRT(cpu_crf[a->bf], t0);
+    return true;
 }
 
-
-
 /***                         Floating-Point compare                        ***/
 
 /* fcmpo */
@@ -1111,14 +1050,7 @@ TRANS(STFDX, do_lsfp_X, false, true, false)
 TRANS(STFDUX, do_lsfp_X, true, true, false)
 TRANS(PSTFD, do_lsfp_PLS_D, false, true, false)
 
-#undef _GEN_FLOAT_ACB
-#undef GEN_FLOAT_ACB
-#undef _GEN_FLOAT_AB
-#undef GEN_FLOAT_AB
-#undef _GEN_FLOAT_AC
-#undef GEN_FLOAT_AC
 #undef GEN_FLOAT_B
-#undef GEN_FLOAT_BS
 
 #undef GEN_LDF
 #undef GEN_LDUF
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index d4c6c4bed1..cef4b5dfcb 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -1,36 +1,6 @@
-#define _GEN_FLOAT_ACB(name, op, op1, op2, isfloat, set_fprf, type)           \
-GEN_HANDLER(f##name, op1, op2, 0xFF, 0x00000000, type)
-#define GEN_FLOAT_ACB(name, op2, set_fprf, type)                              \
-_GEN_FLOAT_ACB(name, name, 0x3F, op2, 0, set_fprf, type),                     \
-_GEN_FLOAT_ACB(name##s, name, 0x3B, op2, 1, set_fprf, type)
-#define _GEN_FLOAT_AB(name, op, op1, op2, inval, isfloat, set_fprf, type)     \
-GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
-#define GEN_FLOAT_AB(name, op2, inval, set_fprf, type)                        \
-_GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type),               \
-_GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
-#define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type)     \
-GEN_HANDLER(f##name, op1, op2, 0xFF, inval, type)
-#define GEN_FLOAT_AC(name, op2, inval, set_fprf, type)                        \
-_GEN_FLOAT_AC(name, name, 0x3F, op2, inval, 0, set_fprf, type),               \
-_GEN_FLOAT_AC(name##s, name, 0x3B, op2, inval, 1, set_fprf, type)
 #define GEN_FLOAT_B(name, op2, op3, set_fprf, type)                           \
 GEN_HANDLER(f##name, 0x3F, op2, op3, 0x001F0000, type)
-#define GEN_FLOAT_BS(name, op1, op2, set_fprf, type)                          \
-GEN_HANDLER(f##name, op1, op2, 0xFF, 0x001F07C0, type)
 
-GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT),
-GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT),
-GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT),
-GEN_FLOAT_BS(re, 0x3F, 0x18, 1, PPC_FLOAT_EXT),
-GEN_FLOAT_BS(res, 0x3B, 0x18, 1, PPC_FLOAT_FRES),
-GEN_FLOAT_BS(rsqrte, 0x3F, 0x1A, 1, PPC_FLOAT_FRSQRTE),
-GEN_FLOAT_AB(sub, 0x14, 0x000007C0, 1, PPC_FLOAT),
-GEN_FLOAT_ACB(madd, 0x1D, 1, PPC_FLOAT),
-GEN_FLOAT_ACB(msub, 0x1C, 1, PPC_FLOAT),
-GEN_FLOAT_ACB(nmadd, 0x1F, 1, PPC_FLOAT),
-GEN_FLOAT_ACB(nmsub, 0x1E, 1, PPC_FLOAT),
-GEN_HANDLER_E(ftdiv, 0x3F, 0x00, 0x04, 1, PPC_NONE, PPC2_FP_TST_ISA206),
-GEN_HANDLER_E(ftsqrt, 0x3F, 0x00, 0x05, 1, PPC_NONE, PPC2_FP_TST_ISA206),
 GEN_FLOAT_B(ctiw, 0x0E, 0x00, 0, PPC_FLOAT),
 GEN_HANDLER_E(fctiwu, 0x3F, 0x0E, 0x04, 0, PPC_NONE, PPC2_FP_CVT_ISA206),
 GEN_FLOAT_B(ctiwz, 0x0F, 0x00, 0, PPC_FLOAT),
@@ -61,7 +31,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
 
-GEN_HANDLER(frsqrtes, 0x3B, 0x1A, 0xFF, 0x001F07C0, PPC_FLOAT_FRSQRTES),
 GEN_HANDLER(fcmpo, 0x3F, 0x00, 0x01, 0x00600001, PPC_FLOAT),
 GEN_HANDLER(fcmpu, 0x3F, 0x00, 0x00, 0x00600001, PPC_FLOAT),
 GEN_HANDLER(fabs, 0x3F, 0x08, 0x08, 0x001F0000, PPC_FLOAT),
-- 
2.39.3


