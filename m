Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695ECEB271B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpvTp-00064v-8q; Tue, 10 Feb 2026 16:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTc-0005zH-Qx; Tue, 10 Feb 2026 16:40:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpvTa-0000Pe-PS; Tue, 10 Feb 2026 16:40:56 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AH8Wbw3040588; Tue, 10 Feb 2026 21:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8z04RsCuKhoHOLFMt
 BkPViPY7uVjfcbuyKVzTFWN/is=; b=jjqONq6MV2jJTEprD3QZcHdNXfvJM44/l
 woq6JEFJWhWAAoJFx6K7ceUGeHQ0jiZ4Gvcjc8Hsu802GN8QSsZ0UeMcCsrkpZ+s
 ZOUFvP4oefBRiII64PvOJQJf/imzB/EQ3vRl2BIARuUGU25E1X/uGFx1cwqDxDiJ
 rRO/u/vGX1Iotr6r/qv26SQkCE4HzInFHT+/RFOdRPsnSprDNEkaBNqsUY0NTUqM
 YpC75K/HsNxeSl5k6aG+BZ9NzsiysoEQfy5vjpSY52/loe8gMtUuYZf/OkdWGFj4
 lUJs9Y3QFyQud3TqKRmHO1rdMkGE21D3Los3D9KzsTFZhqyvbH4jg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wv7jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AIsvik012611;
 Tue, 10 Feb 2026 21:40:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kb521-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 21:40:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ALelp044237162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 21:40:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C017820043;
 Tue, 10 Feb 2026 21:40:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 626E220040;
 Tue, 10 Feb 2026 21:40:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.60.229])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 21:40:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 4/5] target/s390x: Implement DIVIDE TO INTEGER
Date: Tue, 10 Feb 2026 22:39:03 +0100
Message-ID: <20260210214044.1174699-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210214044.1174699-1-iii@linux.ibm.com>
References: <20260210214044.1174699-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698ba5e2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=gfqx3tZHngwHFgT-_TgA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: St2P_VB87CkSnkWJgbPFSsrrr-8ZDTFJ
X-Proofpoint-ORIG-GUID: St2P_VB87CkSnkWJgbPFSsrrr-8ZDTFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NiBTYWx0ZWRfX8CW+JD00iqSP
 LONvQ56zy5Ddu+5eEx+qtjiWV2myS1lQBzGkopR9e4P+Blr/tFGsHKlMThprZtmphvDQbl/4sWr
 e01g5gO5I0M4MkXt5VMYc1E/4dTFpExSCO906P/TuMuB6Tojb2qrcmfYJHRO/oNebVzxVa6rcLl
 f9OXFAdETdB6Dbc8UEk3mAqHeOKJ63YlWu3lWEeon7PMIV7wPeYYfpWQVRTiJU1xukFENnxO/F3
 xp/Hq3diglbZ0BBLP0pkCtpaMDJwUpb6a4miivPWYI9kqD6koLot6s3ON0bLvTeLZxhU4RFAf93
 +IGCHT6PNXxJtlxLk4X4bT16FMBxeh5HxD1Oyh0fbE/vU96mTPO/YkJc8R7W/z8kZrc1WTGxnR1
 wvglM8CRZsg9Sl1JzEwUpjCgyhP++S16h7wg8ZoHsFjdsJ11Ezg8aJpsOgr1FargB5DAx+u4C+u
 lZHLtfpC5ZseirYscHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100176
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Put the main logic into fpu/, because it is way more convenient to
operate on FloatParts than to convert floats back-and-forth.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fpu/softfloat.c                  | 142 +++++++++++++++++++++++++++++++
 include/fpu/softfloat.h          |  11 +++
 target/s390x/helper.h            |   1 +
 target/s390x/tcg/fpu_helper.c    |  56 ++++++++++++
 target/s390x/tcg/insn-data.h.inc |   5 +-
 target/s390x/tcg/translate.c     |  26 ++++++
 6 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8094358c2e4..87409753483 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5361,6 +5361,148 @@ floatx80 floatx80_round(floatx80 a, float_status *status)
     return floatx80_round_pack_canonical(&p, status);
 }
 
+static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
+                                         int final_quotient_rounding_mode,
+                                         bool mask_underflow, bool mask_inexact,
+                                         const FloatFmt *fmt,
+                                         FloatParts64 *r, FloatParts64 *n,
+                                         uint32_t *cc, int *dxc,
+                                         float_status *status)
+{
+    /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
+    if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
+        *r = *parts_pick_nan(a, b, status);
+        *n = *r;
+        *cc = 1;
+    } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
+        parts_default_nan(r, status);
+        *n = *r;
+        *cc = 1;
+        status->float_exception_flags |= float_flag_invalid;
+    } else if (b->cls == float_class_inf) {
+        *r = *a;
+        n->cls = float_class_zero;
+        n->sign = a->sign ^ b->sign;
+        *cc = 0;
+    } else {
+        FloatParts64 *q, q_buf, *r_precise, r_precise_buf;
+        int float_exception_flags = 0;
+        bool is_q_smallish;
+        uint32_t r_flags;
+
+        /* Compute precise quotient */
+        q_buf = *a;
+        q = parts_div(&q_buf, b, status);
+
+        /*
+         * Check whether two closest integers can be precisely represented,
+         * i.e., all their bits fit into the fractional part.
+         */
+        is_q_smallish = q->exp < (fmt->frac_size + 1);
+
+        /*
+         * Final quotient is rounded using final-quotient-rounding method, and
+         * partial quotient is rounded toward zero.
+         *
+         * Rounding of partial quotient may be inexact. This is the whole point
+         * of distinguishing partial quotients, so ignore the exception.
+         */
+        *n = *q;
+        parts_round_to_int_normal(n,
+                                  is_q_smallish ?
+                                      final_quotient_rounding_mode :
+                                      float_round_to_zero,
+                                  0, fmt->frac_size);
+
+        /* Compute precise remainder */
+        r_precise_buf = *b;
+        r_precise = parts_muladd_scalbn(&r_precise_buf, n, a, 0,
+                                        float_muladd_negate_product, status);
+
+        /* Round remainder to the target format */
+        *r = *r_precise;
+        status->float_exception_flags = 0;
+        parts_uncanon(r, status, fmt);
+        r_flags = status->float_exception_flags;
+        r->frac &= (1ULL << fmt->frac_size) - 1;
+        parts_canonicalize(r, status, fmt);
+
+        /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
+        if (is_q_smallish) {
+            if (r->cls != float_class_zero) {
+                if (r->exp < 2 - (1 << (fmt->exp_size - 1))) {
+                    if (mask_underflow) {
+                        float_exception_flags |= float_flag_underflow;
+                        *dxc = 0x10;
+                        r->exp += fmt->exp_re_bias;
+                    }
+                } else if (r_flags & float_flag_inexact) {
+                    float_exception_flags |= float_flag_inexact;
+                    if (mask_inexact) {
+                        bool saved_r_sign, saved_r_precise_sign;
+
+                        /*
+                         * Check whether remainder was truncated (rounded
+                         * toward zero) or incremented.
+                         */
+                        saved_r_sign = r->sign;
+                        saved_r_precise_sign = r_precise->sign;
+                        r->sign = false;
+                        r_precise->sign = false;
+                        if (parts_compare(r, r_precise, status, true) <
+                            float_relation_equal) {
+                            *dxc = 0x8;
+                        } else {
+                            *dxc = 0xc;
+                        }
+                        r->sign = saved_r_sign;
+                        r_precise->sign = saved_r_precise_sign;
+                    }
+                }
+            }
+            *cc = 0;
+        } else if (n->exp > (1 << (fmt->exp_size - 1)) - 1) {
+            n->exp -= fmt->exp_re_bias;
+            *cc = r->cls == float_class_zero ? 1 : 3;
+        } else {
+            *cc = r->cls == float_class_zero ? 0 : 2;
+        }
+
+        /* Adjust signs of zero results */
+        if (r->cls == float_class_zero) {
+            r->sign = a->sign;
+        }
+        if (n->cls == float_class_zero) {
+            n->sign = a->sign ^ b->sign;
+        }
+
+        status->float_exception_flags = float_exception_flags;
+    }
+}
+
+#define DEFINE_S390_DIVIDE_TO_INTEGER(floatN)                                  \
+void floatN ## _s390_divide_to_integer(floatN a, floatN b,                     \
+                                       int final_quotient_rounding_mode,       \
+                                       bool mask_underflow, bool mask_inexact, \
+                                       floatN *r, floatN *n,                   \
+                                       uint32_t *cc, int *dxc,                 \
+                                       float_status *status)                   \
+{                                                                              \
+    FloatParts64 pa, pb, pr, pn;                                               \
+                                                                               \
+    floatN ## _unpack_canonical(&pa, a, status);                               \
+    floatN ## _unpack_canonical(&pb, b, status);                               \
+    parts_s390_divide_to_integer(&pa, &pb, final_quotient_rounding_mode,       \
+                                 mask_underflow, mask_inexact,                 \
+                                 &floatN ## _params,                           \
+                                 &pr, &pn, cc, dxc, status);                   \
+    *r = floatN ## _round_pack_canonical(&pr, status);                         \
+    *n = floatN ## _round_pack_canonical(&pn, status);                         \
+}
+
+DEFINE_S390_DIVIDE_TO_INTEGER(float32)
+DEFINE_S390_DIVIDE_TO_INTEGER(float64)
+
 static void __attribute__((constructor)) softfloat_init(void)
 {
     union_float64 ua, ub, uc, ur;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index c18ab2cb609..66b0c47b5eb 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1372,4 +1372,15 @@ static inline bool float128_unordered_quiet(float128 a, float128 b,
 *----------------------------------------------------------------------------*/
 float128 float128_default_nan(float_status *status);
 
+#define DECLARE_S390_DIVIDE_TO_INTEGER(floatN)                                 \
+void floatN ## _s390_divide_to_integer(floatN a, floatN b,                     \
+                                       int final_quotient_rounding_mode,       \
+                                       bool mask_underflow, bool mask_inexact, \
+                                       floatN *r, floatN *n,                   \
+                                       uint32_t *cc, int *dxc,                 \
+                                       float_status *status)
+DECLARE_S390_DIVIDE_TO_INTEGER(float32);
+DECLARE_S390_DIVIDE_TO_INTEGER(float64);
+
+
 #endif /* SOFTFLOAT_H */
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 1a8a76abb98..6a7426fdac7 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -46,6 +46,7 @@ DEF_HELPER_FLAGS_3(sxb, TCG_CALL_NO_WG, i128, env, i128, i128)
 DEF_HELPER_FLAGS_3(deb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(ddb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(dxb, TCG_CALL_NO_WG, i128, env, i128, i128)
+DEF_HELPER_6(dib, void, env, i32, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(meeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(mdb, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 7a3ff501a46..122994960a6 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -315,6 +315,62 @@ Int128 HELPER(dxb)(CPUS390XState *env, Int128 a, Int128 b)
     return RET128(ret);
 }
 
+void HELPER(dib)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
+                 uint32_t m4, uint32_t bits)
+{
+    int final_quotient_rounding_mode = s390_get_bfp_rounding_mode(env, m4);
+    bool mask_underflow = (env->fpc >> 24) & S390_IEEE_MASK_UNDERFLOW;
+    bool mask_inexact = (env->fpc >> 24) & S390_IEEE_MASK_INEXACT;
+    float32 a32, b32, n32, r32;
+    float64 a64, b64, n64, r64;
+    int dxc = -1;
+    uint32_t cc;
+
+    if (bits == 32) {
+        a32 = env->vregs[r1][0] >> 32;
+        b32 = env->vregs[r2][0] >> 32;
+
+        float32_s390_divide_to_integer(
+            a32, b32,
+            final_quotient_rounding_mode,
+            mask_underflow, mask_inexact,
+            &r32, &n32, &cc, &dxc, &env->fpu_status);
+    } else {
+        a64 = env->vregs[r1][0];
+        b64 = env->vregs[r2][0];
+
+        float64_s390_divide_to_integer(
+            a64, b64,
+            final_quotient_rounding_mode,
+            mask_underflow, mask_inexact,
+            &r64, &n64, &cc, &dxc, &env->fpu_status);
+    }
+
+    /* Flush the results if needed */
+    if ((env->fpu_status.float_exception_flags & float_flag_invalid) &&
+        ((env->fpc >> 24) & S390_IEEE_MASK_INVALID)) {
+        /* The action for invalid operation is "Suppress" */
+    } else {
+        /* The action for other exceptions is "Complete" */
+        if (bits == 32) {
+            env->vregs[r1][0] = deposit64(env->vregs[r1][0], 32, 32, r32);
+            env->vregs[r3][0] = deposit64(env->vregs[r3][0], 32, 32, n32);
+        } else {
+            env->vregs[r1][0] = r64;
+            env->vregs[r3][0] = n64;
+        }
+        env->cc_op = cc;
+    }
+
+    /* Raise an exception if needed */
+    if (dxc == -1) {
+        handle_exceptions(env, false, GETPC());
+    } else {
+        env->fpu_status.float_exception_flags = 0;
+        tcg_s390_data_exception(env, dxc, GETPC());
+    }
+}
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
index 203afe265bc..92344441878 100644
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
+    gen_helper_dib(tcg_env, tcg_constant_i32(get_field(s, r1)),
+                   tcg_constant_i32(get_field(s, r2)),
+                   tcg_constant_i32(get_field(s, r3)), tcg_constant_i32(m4),
+                   tcg_constant_i32(s->insn->data));
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


