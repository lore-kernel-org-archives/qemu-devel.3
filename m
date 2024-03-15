Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5081C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl1JL-0003qy-BO; Fri, 15 Mar 2024 02:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rl1JK-0003qY-44; Fri, 15 Mar 2024 02:44:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rl1JI-0005Yf-6a; Fri, 15 Mar 2024 02:44:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42F5bf2A009575; Fri, 15 Mar 2024 06:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k8D7OlHZnZoT8xoBDAq5ShwpIGtO88BwavlxfvX90tc=;
 b=cKYpvY8BOz/BGt/F2ldh/38hoAp3zd6wpLLtxbO2BvPxWDrQcOP1zP8FUMCoIh0DhhiW
 ft7GUw9ZL9FkHW5OR4azErVecfwvZNgaxM11Ev/+GXc9HILY45X/ROiYmwbksIkF+KzN
 MVHZc9IAhRUG3fF92CxhQsgjFwUi/FhF1ovCRFo+hCqFGWQCHhqrAMdtVwT4EV3V/1tJ
 5ngLcKFU5mznZoAYkoprbFeFkC/byPD5ZkLGz/AIVdAkuM0NzlCqPMfYCxolH2P8ZI2g
 L2cAFCN94k5rEAd8ZkzvD4YgY3Bdfa1JTTIMf1UKzP6jsQp+dF4C6yX4D+CXVvth1XEP nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvgbegq3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42F6iqhh031419;
 Fri, 15 Mar 2024 06:44:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvgbegq3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42F3jBZV014861; Fri, 15 Mar 2024 06:44:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33pa72m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42F6ikgi39059964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 06:44:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A91D20040;
 Fri, 15 Mar 2024 06:44:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 492422004D;
 Fri, 15 Mar 2024 06:44:44 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Mar 2024 06:44:44 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 clg@kaod.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v2 1/2] target/ppc: Merge various fpu helpers
Date: Fri, 15 Mar 2024 12:14:21 +0530
Message-Id: <20240315064422.737812-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315064422.737812-1-rathc@linux.ibm.com>
References: <20240315064422.737812-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qMzER5K2Yjs6AnSdFprHcBQJn2lnjb21
X-Proofpoint-GUID: 14vUiMRyD5IphpOIejJeMx_PNK5LgUpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=418 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150053
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

This patch merges the definitions of the following set of fpu helper methods,
which are similar, using macros :

1. f{add, sub, mul, div}(s)
2. fre(s)
3. frsqrte(s)

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/fpu_helper.c | 221 +++++++++++-----------------------------
 1 file changed, 62 insertions(+), 159 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b3dcad5d1..8d0cbe27e7 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -490,54 +490,12 @@ static void float_invalid_op_addsub(CPUPPCState *env, int flags,
     }
 }
 
-/* fadd - fadd. */
-float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
+static inline void addsub_flags_handler(CPUPPCState *env, int flags,
+                                        uintptr_t ra)
 {
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
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
+        float_invalid_op_addsub(env, flags, 1, ra);
     }
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
 }
 
 static void float_invalid_op_mul(CPUPPCState *env, int flags,
@@ -550,29 +508,11 @@ static void float_invalid_op_mul(CPUPPCState *env, int flags,
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
+static inline void mul_flags_handler(CPUPPCState *env, int flags, uintptr_t ra)
 {
-    float64 ret = float64r32_mul(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_mul(env, flags, 1, GETPC());
+        float_invalid_op_mul(env, flags, 1, ra);
     }
-    return ret;
 }
 
 static void float_invalid_op_div(CPUPPCState *env, int flags,
@@ -587,36 +527,14 @@ static void float_invalid_op_div(CPUPPCState *env, int flags,
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
-}
-
-/* fdivs - fdivs. */
-float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
+static inline void div_flags_handler(CPUPPCState *env, int flags, uintptr_t ra)
 {
-    float64 ret = float64r32_div(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_div(env, flags, 1, GETPC());
+        float_invalid_op_div(env, flags, 1, ra);
     }
     if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
+        float_zero_divide_excp(env, ra);
     }
-
-    return ret;
 }
 
 static uint64_t float_invalid_cvt(CPUPPCState *env, int flags,
@@ -812,81 +730,66 @@ float64 helper_##name(CPUPPCState *env, float64 arg)                          \
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
+#define FPU_HELPER(name, op, flags_handler)                                   \
+float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+{                                                                             \
+    float64 ret = op(arg1, arg2, &env->fp_status);                            \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+    uintptr_t ra = GETPC();                                                   \
+    flags_handler(env, flags, ra);                                            \
+    return ret;                                                               \
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
+FPU_FRE(fre, float64_div)
+FPU_FRE(fres, float64r32_div)
+FPU_FRSQRTE(frsqrte, float64_div)
+FPU_FRSQRTE(frsqrtes, float64r32_div)
+FPU_HELPER(fadd, float64_add, addsub_flags_handler)
+FPU_HELPER(fadds, float64r32_add, addsub_flags_handler)
+FPU_HELPER(fsub, float64_sub, addsub_flags_handler)
+FPU_HELPER(fsubs, float64r32_sub, addsub_flags_handler)
+FPU_HELPER(fmul, float64_mul, mul_flags_handler)
+FPU_HELPER(fmuls, float64r32_mul, mul_flags_handler)
+FPU_HELPER(fdiv, float64_div, div_flags_handler)
+FPU_HELPER(fdivs, float64r32_div, div_flags_handler)
 
 /* fsel - fsel. */
 uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
-- 
2.39.3


