Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C906D34088
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl8i-0002LI-Ss; Tue, 27 Jan 2026 10:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8c-0002B0-Rm; Tue, 27 Jan 2026 10:37:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8X-00025E-3H; Tue, 27 Jan 2026 10:37:52 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R5UbwO013638;
 Tue, 27 Jan 2026 15:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=O6iq86z4FYI8j9C94
 x+gjNjhZo0GA7dIeJkLwsK/UZk=; b=LBBhCIDGnjgOUoygHVoqEmYmEZMyq6uuC
 m1T6kYv18RnAeN8AYXLcPsjpdrUlySgeBzIWCkVkD+KoZ6Au2NHKr0b0XG1uRmsR
 Y8sVN/UjSjb14StpPZ5y6Vn1K88dyyR8+Eqkj8AuYFldsQXKBNDiyi+LvfyH3Z/6
 WPtIHItY7cTa2Z545+UNxQpsKSt0USJfbhqSIHa6OgiE8vwAGwjdSijeevqzY2fp
 2vKGXEam58O1OM5ziQpsOGVE0yBOztgxRGVovdf7VGIp9QjHIp6Ophrnv0Jfildy
 mEjIaroEUi6fRmGLDH12d/hEFVXNakYXf9PFiMkntZWByYOBBwo3A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x8cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE1qf7026340;
 Tue, 27 Jan 2026 15:37:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk9521-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RFbdGi42795468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 15:37:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2306D20049;
 Tue, 27 Jan 2026 15:37:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB6EC20040;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.80.246])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
Date: Tue, 27 Jan 2026 16:31:44 +0100
Message-ID: <20260127153736.62730-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127153736.62730-1-iii@linux.ibm.com>
References: <20260127153736.62730-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H0EDxHdc81JUqx4NAJI-iQbvt45gX6i1
X-Proofpoint-ORIG-GUID: H0EDxHdc81JUqx4NAJI-iQbvt45gX6i1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXzy3wbeVk5xSt
 YTZo9ngND7J4Is2P/97Q55IOtAjvNUU+Dp+r0ovkl5GvYHsi/grxLVwuJutEtiGhuKz2e7S9E/b
 fUs/+8BlHUGQVhort6SK+F3BB9WBnL3YVJIfciDZVy7bs/hHgHN932MS4cv9QrEnWqakBjAjiQP
 1tf/AZ+0AlXajwATvzCYClzYJoaEPRQuH08qCrqsgz9Q6olSSYleKRS1EECwF887IiIm4RwNlac
 +VMLcTAFSBvXQm5dkvd1ogXyATUtY6tPI26SQbo9AqsWjIa6LjwY6InJdJyZ0nEcRhk7piKAqhj
 u5+r5bMloO9mvQtDqq/CzzXfcMbSqCCjLEo77q//5tw/GR/HOI6vfPO+TsG2ksLHXKiWB1Pp0v1
 UCiujaCvASS7IokIig8lSRKpTe9mb+xkHMR0TgmjZ7PPzlrwwLZkDJyIBij+ZPfLV7GP7Qoyor4
 9Eo+sv3U0i0bW0Bt6ew==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978dbc6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ul57gJKvJHJ9WjOxzWQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
 fpu/softfloat.c                  | 158 +++++++++++++++++++++++++++++++
 include/fpu/softfloat.h          |  11 +++
 target/s390x/helper.h            |   1 +
 target/s390x/tcg/fpu_helper.c    |  56 +++++++++++
 target/s390x/tcg/insn-data.h.inc |   5 +-
 target/s390x/tcg/translate.c     |  26 +++++
 6 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8094358c2e4..178ea262057 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5361,6 +5361,164 @@ floatx80 floatx80_round(floatx80 a, float_status *status)
     return floatx80_round_pack_canonical(&p, status);
 }
 
+static void parts_s390_precision_round_normal(FloatParts128 *p,
+                                              const FloatFmt *fmt)
+{
+    /* Use precision of the target format, but unbounded exponent range */
+    p->frac_hi &= ((1ULL << (fmt->frac_size + 1)) - 1) <<
+                  (63 - fmt->frac_size);
+    p->frac_lo = 0;
+}
+
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
+        FloatParts128 a128, b128, *m128, m128_buf, n128, *q128, q128_buf,
+                      r128, *r128_precise;
+        int float_exception_flags = 0;
+        bool is_q128_smallish;
+        uint32_t r_flags;
+        int saved_flags;
+
+        /* Compute precise quotient */
+        parts_float_to_float_widen(&a128, a, status);
+        parts_float_to_float_widen(&b128, b, status);
+        q128_buf = a128;
+        q128 = parts_div(&q128_buf, &b128, status);
+
+        /* Final or partial case? */
+        is_q128_smallish = q128->exp < (fmt->frac_size + 1);
+
+        /*
+         * Final quotient is rounded using final-quotient-rounding method, and
+         * partial quotient is rounded toward zero.
+         *
+         * Rounding of partial quotient may be inexact. This is the whole point
+         * of distinguishing partial quotients, so ignore the exception.
+         */
+        n128 = *q128;
+        saved_flags = status->float_exception_flags;
+        parts_round_to_int(&n128,
+                           is_q128_smallish ? final_quotient_rounding_mode :
+                                              float_round_to_zero,
+                           0, status, &float128_params);
+        float_exception_flags = saved_flags;
+        parts_s390_precision_round_normal(&n128, fmt);
+
+        /* Compute precise remainder */
+        m128_buf = b128;
+        m128 = parts_mul(&m128_buf, &n128, status);
+        m128->sign = !m128->sign;
+        status->float_exception_flags = 0;
+        r128_precise = parts_addsub(m128, &a128, status, false);
+
+        /* Round remainder to the target format */
+        parts_float_to_float_narrow(r, r128_precise, status);
+        parts_uncanon(r, status, fmt);
+        r->frac &= (1ULL << fmt->frac_size) - 1;
+        parts_canonicalize(r, status, fmt);
+        parts_float_to_float_widen(&r128, r, status);
+        r_flags = status->float_exception_flags;
+
+        /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
+        if (is_q128_smallish) {
+            if (r128.cls != float_class_zero) {
+                if (r128.exp < 2 - (1 << (fmt->exp_size - 1))) {
+                    if (mask_underflow) {
+                        float_exception_flags |= float_flag_underflow;
+                        *dxc = 0x10;
+                        r128.exp += fmt->exp_re_bias;
+                    }
+                } else if (r_flags & float_flag_inexact) {
+                    float_exception_flags |= float_flag_inexact;
+                    if (mask_inexact) {
+                        bool saved_r128_sign, saved_r128_precise_sign;
+
+                        /*
+                         * Check whether remainder was truncated (rounded
+                         * toward zero) or incremented.
+                         */
+                        saved_r128_sign = r128.sign;
+                        saved_r128_precise_sign = r128_precise->sign;
+                        r128.sign = false;
+                        r128_precise->sign = false;
+                        if (parts_compare(&r128, r128_precise, status, true) <
+                            float_relation_equal) {
+                            *dxc = 0x8;
+                        } else {
+                            *dxc = 0xc;
+                        }
+                        r128.sign = saved_r128_sign;
+                        r128_precise->sign = saved_r128_precise_sign;
+                    }
+                }
+            }
+            *cc = 0;
+        } else if (n128.exp > (1 << (fmt->exp_size - 1)) - 1) {
+            n128.exp -= fmt->exp_re_bias;
+            *cc = r128.cls == float_class_zero ? 1 : 3;
+        } else {
+            *cc = r128.cls == float_class_zero ? 0 : 2;
+        }
+
+        /* Adjust signs of zero results */
+        parts_float_to_float_narrow(r, &r128, status);
+        if (r->cls == float_class_zero) {
+            r->sign = a->sign;
+        }
+        parts_float_to_float_narrow(n, &n128, status);
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
index 540c5a569c0..dee0e710f39 100644
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


