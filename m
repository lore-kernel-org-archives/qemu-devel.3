Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E220EB48E8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSP4-0002AZ-T1; Thu, 12 Feb 2026 03:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOs-0001m0-3m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqSOo-0001aC-2i
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770886207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6nhZJMvOwkIA1E1Hj872OWt8/3KLzl3rw16ie6S3h8=;
 b=ieZ409V2E/IwmVTHAyC24gGFPi3wbKa+uYqA39h58OahJVVJl673kyGKjIG432d4Cf/NrI
 s24gKV/Io6X+p+smHsIElY/VCxLAdWUV4Xi2uSM2HhA9KQLYRmQM8zwU66ZSjRYZkRXqCH
 oXuOcNBUz9daNhOr7SMFpifF8tV0DzU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-AFfrGZomNXGBgR6Trv9yEQ-1; Thu,
 12 Feb 2026 03:50:05 -0500
X-MC-Unique: AFfrGZomNXGBgR6Trv9yEQ-1
X-Mimecast-MFC-AGG-ID: AFfrGZomNXGBgR6Trv9yEQ_1770886204
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F0B318003F5; Thu, 12 Feb 2026 08:50:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8526430001B9; Thu, 12 Feb 2026 08:50:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/14] target/s390x: Implement DIVIDE TO INTEGER
Date: Thu, 12 Feb 2026 09:49:23 +0100
Message-ID: <20260212084927.258642-11-thuth@redhat.com>
In-Reply-To: <20260212084927.258642-1-thuth@redhat.com>
References: <20260212084927.258642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

DIVIDE TO INTEGER computes floating point remainder and is used by
LuaJIT, so add it to QEMU.

Put the main logic into fpu/, because it is way more convenient to
operate on FloatParts than to convert floats back-and-forth.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20260210214044.1174699-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/fpu/softfloat.h          |  11 +++
 target/s390x/helper.h            |   1 +
 target/s390x/tcg/insn-data.h.inc |   5 +-
 fpu/softfloat.c                  | 142 +++++++++++++++++++++++++++++++
 target/s390x/tcg/fpu_helper.c    |  56 ++++++++++++
 target/s390x/tcg/translate.c     |  26 ++++++
 6 files changed, 240 insertions(+), 1 deletion(-)

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
2.53.0


