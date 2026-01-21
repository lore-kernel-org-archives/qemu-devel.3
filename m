Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89EC44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigZz-0007SV-QX; Wed, 21 Jan 2026 17:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZy-0007Qd-GB; Wed, 21 Jan 2026 17:21:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vigZv-0003hl-3n; Wed, 21 Jan 2026 17:21:34 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LCdm0d019631;
 Wed, 21 Jan 2026 22:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/QiS7fEyyL3lNfsji
 ei8Qnqv5vP7FDrLEVE5c+9OZgc=; b=LZxEgNjE+KbJG4gKG3q2Q8TeTfu7QAxiG
 bAgCTpIojZFPQQ0/KZk+MmnXOQvPQXlrZvibC1w0jmNzE6feiabEt2kJi6XNMbkV
 ScYZfKgjm2nOuxV+vZU1CNOuo3wXIqmXxubLSfVLPpYW4NUSTZwPWI2+gzfK4UIt
 z9aYZ+f0Q/KhPX4tU41SfbsuTqV5VavLTV+JQMhgtl4FIQ5AIgJAg4e6Bya1fiY4
 ppehu33x8SfAecPTcy+PGUzj+wxTAEax0s4qTYOILCpD4O01NWTZaGqUvOr8nyQg
 HtiGEJKhpIGjDyjajbcurPAg/vHfDwtdQ5CTpasGDSs21pMbCMahw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2566p9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LJfZgQ001441;
 Wed, 21 Jan 2026 22:21:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjxkxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 22:21:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LMLNws34734562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 22:21:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A931A20043;
 Wed, 21 Jan 2026 22:21:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3155020040;
 Wed, 21 Jan 2026 22:21:23 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.153.49])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 22:21:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] target/s390x: Implement DIVIDE TO INTEGER
Date: Wed, 21 Jan 2026 23:12:32 +0100
Message-ID: <20260121222116.713325-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121222116.713325-1-iii@linux.ibm.com>
References: <20260121222116.713325-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE4NyBTYWx0ZWRfX9OzcxlMZtRo3
 IQvcIh/7h1VrA8eMpQaJmwOqQfgJAu+zrykucaFEKw+rT8nlVCc76Zf/t+vSXOdTsFDplsd62TJ
 KCPIOhHo9vWVis2f+Zs64N5iFkWY/W1pbLRcstJewyTFHoHX1lqgYPf3QU351i9SFDWbpg7q1Jy
 sVRZc4IsrfCbx8iF21y5UEV9gGNd5dvlMRQpwBlALlDNqu1prHFIPr5vd/FZFB6w66vrM/B67FN
 oMhDH+wWz8DYdjcUVTDcDdEtO8PCvibX3YHtvCJ5VbhqdiPvSWKPJ2kQdbkzGB2qx5Z9wUkx65D
 gvvgr+CVMs9B56iiO3H6iY4DeYOPgEhurbCowq2hCex18aFKtL9d8N+hH+UUe8AVVMdLOIni7o2
 ARkKP+FpIloQAl99F6otjHLCmwIUJ/w47VjHdaARlwG1zcuAILtefkdF+bAW6nvCY+jiN9g1otO
 +XYTqCshd6xd8/oZCPg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69715166 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ESPI3Zjt4XITjxTb9SAA:9
X-Proofpoint-GUID: wcefDrj4KM1U7knWyCtktPhTS8LdZX6g
X-Proofpoint-ORIG-GUID: wcefDrj4KM1U7knWyCtktPhTS8LdZX6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601210187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

DIVIDE TO INTEGER computes floating point remainder and is used by
LuaJIT, so add it to QEMU.

The instruction comes in two flavors: for floats and doubles, which are
very similar. Since it's also quite complex, copy-pasting the
implementation would result in barely maintainable code. Mitigate that
using macros. An alternative would be an .inc file, but this looks like
an overkill.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/helper.h            |   2 +
 target/s390x/tcg/fpu_helper.c    | 199 +++++++++++++++++++++++++++++++
 target/s390x/tcg/insn-data.h.inc |   5 +-
 target/s390x/tcg/translate.c     |  26 ++++
 4 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1a8a76abb98..f2b24c65a88 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -46,6 +46,8 @@ DEF_HELPER_FLAGS_3(sxb, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(deb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(ddb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(dxb, TCG_CALL_NO_WG, i128, env, i128, i128)
+DEF_HELPER_5(didb, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(dieb, void, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(meeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdb, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 1ba43715ac1..f524c4257fb 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -286,6 +286,205 @@ Int128 HELPER(dxb)(CPUS390XState *env, Int128 a, Int128 b)
     return RET128(ret);
 }
 
+static float128 float128_precision_round_to_float32(float128 x)
+{
+    x.low = 0;
+    x.high = deposit64(x.high, 0, 25, 0);
+    return x;
+}
+
+static float128 float128_precision_round_to_float64(float128 x)
+{
+    x.low = deposit64(x.low, 0, 60, 0);
+    return x;
+}
+
+static int float128_get_exp(float128 x)
+{
+    return extract64(x.high, 48, 15) - 16383;
+}
+
+static float128 float128_set_exp(float128 x, int exp)
+{
+    x.high = deposit64(x.high, 48, 15, exp + 16383);
+    return x;
+}
+
+static float128 float128_adjust_exp(float128 x, int delta)
+{
+    return float128_set_exp(x, float128_get_exp(x) + delta);
+}
+
+static bool float128_is_int(float128 x)
+{
+    return extract64(x.high, 0, 48) == 0 && x.low == 0;
+}
+
+static float32 extract_float32(CPUS390XState *env, uint32_t r)
+{
+    return env->vregs[r][0] >> 32;
+}
+
+static void deposit_float32(CPUS390XState *env, uint32_t r, float32 x)
+{
+    env->vregs[r][0] = deposit64(env->vregs[r][0], 32, 32, x);
+}
+
+static float64 extract_float64(CPUS390XState *env, uint32_t r)
+{
+    return env->vregs[r][0];
+}
+
+static void deposit_float64(CPUS390XState *env, uint32_t r, float64 x)
+{
+    env->vregs[r][0] = x;
+}
+
+#define DIVIDE_TO_INTEGER(name, floatN, p, exp_max, exp_bias)                  \
+void HELPER(name)(CPUS390XState *env, uint32_t r1, uint32_t r2,                \
+                  uint32_t r3, uint32_t m4)                                    \
+{                                                                              \
+    int float_exception_flags = 0;                                             \
+    floatN a, b, n, r;                                                         \
+    int dxc = -1;                                                              \
+    uint32_t cc;                                                               \
+                                                                               \
+    a = extract_ ## floatN(env, r1);                                           \
+    b = extract_ ## floatN(env, r2);                                           \
+                                                                               \
+    /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */                 \
+    if (floatN ## _is_signaling_nan(a, &env->fpu_status)) {                    \
+        r = n = floatN ## _silence_nan(a, &env->fpu_status);                   \
+        cc = 1;                                                                \
+        float_exception_flags |= float_flag_invalid;                           \
+    } else if (floatN ## _is_signaling_nan(b, &env->fpu_status)) {             \
+        r = n = floatN ## _silence_nan(b, &env->fpu_status);                   \
+        cc = 1;                                                                \
+        float_exception_flags |= float_flag_invalid;                           \
+    } else if (floatN ## _is_quiet_nan(a, &env->fpu_status)) {                 \
+        r = n = a;                                                             \
+        cc = 1;                                                                \
+    } else if (floatN ## _is_quiet_nan(b, &env->fpu_status)) {                 \
+        r = n = b;                                                             \
+        cc = 1;                                                                \
+    } else if (floatN ## _is_infinity(a) || floatN ## _is_zero(b)) {           \
+        r = n = floatN ## _default_nan(&env->fpu_status);                      \
+        cc = 1;                                                                \
+        float_exception_flags |= float_flag_invalid;                           \
+    } else if (floatN ## _is_infinity(b))  {                                   \
+        r = a;                                                                 \
+        n = floatN ## _set_sign(floatN ## _zero,                               \
+                                floatN ## _is_neg(a) != floatN ## _is_neg(b)); \
+        cc = 0;                                                                \
+    } else {                                                                   \
+        float128 a128, b128, m128, n128, q128, r128;                           \
+        bool is_final, is_q128_smallish;                                       \
+        int old_mode, r128_exp;                                                \
+        uint32_t r_flags;                                                      \
+                                                                               \
+        /* Compute precise quotient */                                         \
+        a128 = floatN ## _to_float128(a, &env->fpu_status);                    \
+        b128 = floatN ## _to_float128(b, &env->fpu_status);                    \
+        q128 = float128_div(a128, b128, &env->fpu_status);                     \
+                                                                               \
+        /* Final or partial case? */                                           \
+        is_q128_smallish = float128_get_exp(q128) < p;                         \
+        is_final = is_q128_smallish || float128_is_int(q128);                  \
+                                                                               \
+        /*                                                                     \
+         * Final quotient is rounded using M4,                                 \
+         * partial quotient is rounded toward zero.                            \
+         */                                                                    \
+        old_mode = s390_swap_bfp_rounding_mode(env, is_final ? m4 : 5);        \
+        n128 = float128_round_to_int(q128, &env->fpu_status);                  \
+        s390_restore_bfp_rounding_mode(env, old_mode);                         \
+                                                                               \
+        /*                                                                     \
+         * Intermediate values are precision-rounded,                          \
+         * see "Intermediate Values" in POp.                                   \
+         */                                                                    \
+        n128 = float128_precision_round_to_ ## floatN(n128);                   \
+                                                                               \
+        /* Compute remainder */                                                \
+        m128 = float128_mul(b128, n128, &env->fpu_status);                     \
+        env->fpu_status.float_exception_flags = 0;                             \
+        r128 = float128_sub(a128, m128, &env->fpu_status);                     \
+        r128_exp = float128_get_exp(r128);                                     \
+        r = float128_to_## floatN(r128, &env->fpu_status);                     \
+        r_flags = env->fpu_status.float_exception_flags;                       \
+                                                                               \
+        /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */             \
+        if (is_q128_smallish) {                                                \
+            cc = 0;                                                            \
+            if (!floatN ## _is_zero(r)) {                                      \
+                if (r128_exp < -(exp_max - 1)) {                               \
+                    if ((env->fpc >> 24) & S390_IEEE_MASK_UNDERFLOW) {         \
+                        float_exception_flags |= float_flag_underflow;         \
+                        dxc = 0x10;                                            \
+                        r128 = float128_adjust_exp(r128, exp_bias);            \
+                        r = float128_to_## floatN(r128, &env->fpu_status);     \
+                    }                                                          \
+                } else if (r_flags & float_flag_inexact) {                     \
+                    float_exception_flags |= float_flag_inexact;               \
+                    if ((env->fpc >> 24) & S390_IEEE_MASK_INEXACT) {           \
+                        /*                                                     \
+                         * Check whether remainder was truncated (rounded      \
+                         * toward zero) or incremented.                        \
+                         */                                                    \
+                        if (float128_lt(                                       \
+                                floatN ## _to_float128(floatN ## _abs(r),      \
+                                                       &env->fpu_status),      \
+                                float128_abs(r128), &env->fpu_status)) {       \
+                           dxc = 0x8;                                          \
+                        } else {                                               \
+                           dxc = 0xc;                                          \
+                        }                                                      \
+                    }                                                          \
+                }                                                              \
+            }                                                                  \
+        } else if (float128_get_exp(n128) > exp_max) {                         \
+            n128 = float128_adjust_exp(n128, -exp_bias);                       \
+            cc = floatN ## _is_zero(r) ? 1 : 3;                                \
+        } else {                                                               \
+            cc = floatN ## _is_zero(r) ? 0 : 2;                                \
+        }                                                                      \
+                                                                               \
+        /* Adjust sign of zero */                                              \
+        if (floatN ## _is_zero(r)) {                                           \
+            r = floatN ## _set_sign(r, float128_is_neg(a128));                 \
+        }                                                                      \
+        n = float128_to_ ## floatN(n128, &env->fpu_status);                    \
+        if (floatN ## _is_zero(n)) {                                           \
+            n = floatN ## _set_sign(n,                                         \
+                                    float128_is_neg(a128) !=                   \
+                                        float128_is_neg(b128));                \
+        }                                                                      \
+    }                                                                          \
+                                                                               \
+    /* Flush the results if needed */                                          \
+    if ((float_exception_flags & float_flag_invalid) &&                        \
+        ((env->fpc >> 24) & S390_IEEE_MASK_INVALID)) {                         \
+        /* The action for invalid operation is "Suppress" */                   \
+    } else {                                                                   \
+        /* The action for other exceptions is "Complete" */                    \
+        deposit_ ## floatN(env, r1, r);                                        \
+        deposit_ ## floatN(env, r3, n);                                        \
+        env->cc_op = cc;                                                       \
+    }                                                                          \
+                                                                               \
+    /* Raise an exception if needed */                                         \
+    if (dxc == -1) {                                                           \
+        env->fpu_status.float_exception_flags = float_exception_flags;         \
+        handle_exceptions(env, false, GETPC());                                \
+    } else {                                                                   \
+        env->fpu_status.float_exception_flags = 0;                             \
+        tcg_s390_data_exception(env, dxc, GETPC());                            \
+    }                                                                          \
+}
+
+DIVIDE_TO_INTEGER(dieb, float32, 24, 127, 192)
+DIVIDE_TO_INTEGER(didb, float64, 53, 1023, 1536)
+
 /* 32-bit FP multiplication */
 uint64_t HELPER(meeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index baaafe922e9..0d5392eac54 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -9,7 +9,7 @@
  *  OPC  = (op << 8) | op2 where op is the major, op2 the minor opcode
  *  NAME = name of the opcode, used internally
  *  FMT  = format of the opcode (defined in insn-format.h.inc)
- *  FAC  = facility the opcode is available in (defined in DisasFacility)
+ *  FAC  = facility the opcode is available in (define in translate.c)
  *  I1   = func in1_xx fills o->in1
  *  I2   = func in2_xx fills o->in2
  *  P    = func prep_xx initializes o->*out*
@@ -361,6 +361,9 @@
     C(0xb91d, DSGFR,   RRE,   Z,   r1p1, r2_32s, r1_P, 0, divs64, 0)
     C(0xe30d, DSG,     RXY_a, Z,   r1p1, m2_64, r1_P, 0, divs64, 0)
     C(0xe31d, DSGF,    RXY_a, Z,   r1p1, m2_32s, r1_P, 0, divs64, 0)
+/* DIVIDE TO INTEGER */
+    D(0xb35b, DIDBR,   RRF_b, Z,   0, 0, 0, 0, dib, 0, 64)
+    D(0xb353, DIEBR,   RRF_b, Z,   0, 0, 0, 0, dib, 0, 32)
 
 /* EXCLUSIVE OR */
     C(0x1700, XR,      RR_a,  Z,   r1, r2, new, r1_32, xor, nz32)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 540c5a569c0..a3b753bc829 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2283,6 +2283,32 @@ static DisasJumpType op_dxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_dib(DisasContext *s, DisasOps *o)
+{
+    const bool fpe = s390_has_feat(S390_FEAT_FLOATING_POINT_EXT);
+    uint8_t m4 = get_field(s, m4);
+
+    if (get_field(s, r1) == get_field(s, r2) ||
+        get_field(s, r1) == get_field(s, r3) ||
+        get_field(s, r2) == get_field(s, r3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (m4 == 2 || (!fpe && m4 == 3) || m4 > 7) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    (s->insn->data == 32 ? gen_helper_dieb : gen_helper_didb)(
+        tcg_env, tcg_constant_i32(get_field(s, r1)),
+        tcg_constant_i32(get_field(s, r2)),
+        tcg_constant_i32(get_field(s, r3)), tcg_constant_i32(m4));
+    set_cc_static(s);
+
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_ear(DisasContext *s, DisasOps *o)
 {
     int r2 = get_field(s, r2);
-- 
2.52.0


