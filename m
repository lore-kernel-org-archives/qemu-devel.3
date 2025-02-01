Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C92C02194
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYA-0006IN-Ce; Sat, 01 Feb 2025 11:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY6-0006Ed-Pj
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY5-00019m-2M
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4368a293339so34933865e9.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428048; x=1739032848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aUwB3iaeV7D5kJkSCDikB8cZuPi9S68tuUXP2SbKJ6Q=;
 b=I1ive0tUroQfnJkMcjDwBNM3G6miGqjpC9waOrHwYOC69Nz3LfDp15duprQnMQBJtx
 F+x1+id8/Ak/NEFv6xCjxz+KHA6sySOW7fYR4fVpPqoxNsYgckvXj5ducfqSE7pPSSQo
 75NpjOoZ8y3Kg/WU1TnWDuNjhHVn/PV7DlRmAd6yEERAulnTBGvicJdUPvQeiae5O1iA
 JZ5JCia0K59eHrLXl8A0kj8n7Mr0LhaIC2KAgEXfD6fcjp7DxgpIs+2KkT0R6CK+m4T/
 ExEkPdIQhpRy10AXS9SJjO6mihJS3bLc/Oc997swPCgtwZ3toDkcKUQ0Vcn0stEk2yaM
 qLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428048; x=1739032848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUwB3iaeV7D5kJkSCDikB8cZuPi9S68tuUXP2SbKJ6Q=;
 b=eQEatBf5MdQVugw+HutCC7+amlOq9GFNPJG/l+B8P8ABmH7++pYAyeJ2L6gUITCrn6
 9VsIcqr1OW8eZyHqfZtHa/rnXhwBa8KRzEYw8U/Nb9FPmzUVC2t5PTWZdgRf4NXkQl5+
 Po5OCqNsYhnbGW7XLK5uluKrDDIJKGvMT/xGIVR6gBpiXGqQh8VDmQJ8GhnytSpA+pCa
 dbovlEDAybjFyW417uPezIEgkEc8zx/FmSSFEWZGnQYJm8p0YynmK8qX6WEM4mmf++Ao
 SYKV8h0bx12gZdgR4jCjlGaeQBSr21FzpfzIl0rCN2FQkvPwWAFoA4IZHKK22X0fhsE3
 hzDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwqW37gaHm1UdRG6eCTVHSYS0VvEovLpiSMWWkmFaD7knqxrN8ixGNB/scBD3jQju1KqLK72RRfaS6@nongnu.org
X-Gm-Message-State: AOJu0Yy0/XNHFQGHNemDbxYl185E1PXEIuxzKzSoKmq0mQ+oWW8KJt+2
 IZAomhhaCtG7bHnXLhzkpEbF/J4EEyP4/SUaSTuPoEUohHBtuHqsOb8hLg41jkOeVWjm1PL5KdD
 /
X-Gm-Gg: ASbGncuG6Z+eVkByHyoIe5nAdnHd2ocsF3F6xTVaQ0VDo4jb/pjMLiwsLx9zXYVF7ah
 eoy2gBbY71s1utjroNO0tNFkG31IvybHX+qFWBPgJEGWYEB70CXnfSJEkuk0F2iuSMGvlpSmR66
 rxk6U0ykQMEj4FnYlpODOmlIZcfa5j70tRESVDW5GVVhLwQ1y0sQVIIs19gx7viE7YOD/h+79FJ
 z9a0zh3kTlv8bFwitQJ0S4TxSLRYVUaptaDlXpK0FjJUWMg7MpUu//ENvW+Xu4l7jnT98N9GLVk
 FSpDtUVsXQd/YSqpvYrA
X-Google-Smtp-Source: AGHT+IFeQUkPE1Y6QjUsG7KjgwcPkB/vRPhLg/ag6zM3yLRBn/OZlJMf2ZkMHFqfV8ptDE366cw3Ow==
X-Received: by 2002:a05:600c:ccc:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-438e07cd868mr104456305e9.21.1738428047668; 
 Sat, 01 Feb 2025 08:40:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 24/69] target/arm: Implement FPCR.AH semantics for scalar
 FMIN/FMAX
Date: Sat,  1 Feb 2025 16:39:27 +0000
Message-Id: <20250201164012.1660228-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When FPCR.AH == 1, floating point FMIN and FMAX have some odd special
cases:

 * comparing two zeroes (even of different sign) or comparing a NaN
   with anything always returns the second argument (possibly
   squashed to zero)
 * denormal outputs are not squashed to zero regardless of FZ or FZ16

Implement these semantics in new helper functions and select them at
translate time if FPCR.AH is 1 for the scalar FMAX and FMIN insns.
(We will convert the other FMAX and FMIN insns in subsequent
commits.)

Note that FMINNM and FMAXNM are not affected.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  7 +++++++
 target/arm/tcg/helper-a64.c    | 36 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 23 ++++++++++++++++++++--
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index bac12fbe55b..ae0424f6de9 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -67,6 +67,13 @@ DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, fpst)
 DEF_HELPER_2(advsimd_rinth_exact, f16, f16, fpst)
 DEF_HELPER_2(advsimd_rinth, f16, f16, fpst)
 
+DEF_HELPER_3(vfp_ah_minh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_ah_mins, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_ah_mind, f64, f64, f64, fpst)
+DEF_HELPER_3(vfp_ah_maxh, f16, f16, f16, fpst)
+DEF_HELPER_3(vfp_ah_maxs, f32, f32, f32, fpst)
+DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
+
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 05036089dd7..ed5e4a45997 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -399,6 +399,42 @@ float32 HELPER(fcvtx_f64_to_f32)(float64 a, float_status *fpst)
     return r;
 }
 
+/*
+ * AH=1 min/max have some odd special cases:
+ * comparing two zeroes (regardless of sign), (NaN, anything),
+ * or (anything, NaN) should return the second argument (possibly
+ * squashed to zero).
+ * Also, denormal outputs are not squashed to zero regardless of FZ or FZ16.
+ */
+#define AH_MINMAX_HELPER(NAME, CTYPE, FLOATTYPE, MINMAX)                \
+    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
+    {                                                                   \
+        bool save;                                                      \
+        CTYPE r;                                                        \
+        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
+        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
+        if (FLOATTYPE ## _is_zero(a) && FLOATTYPE ## _is_zero(b)) {     \
+            return b;                                                   \
+        }                                                               \
+        if (FLOATTYPE ## _is_any_nan(a) ||                              \
+            FLOATTYPE ## _is_any_nan(b)) {                              \
+            float_raise(float_flag_invalid, fpst);                      \
+            return b;                                                   \
+        }                                                               \
+        save = get_flush_to_zero(fpst);                                 \
+        set_flush_to_zero(false, fpst);                                 \
+        r = FLOATTYPE ## _ ## MINMAX(a, b, fpst);                       \
+        set_flush_to_zero(save, fpst);                                  \
+        return r;                                                       \
+    }
+
+AH_MINMAX_HELPER(vfp_ah_minh, dh_ctype_f16, float16, min)
+AH_MINMAX_HELPER(vfp_ah_mins, float32, float32, min)
+AH_MINMAX_HELPER(vfp_ah_mind, float64, float64, min)
+AH_MINMAX_HELPER(vfp_ah_maxh, dh_ctype_f16, float16, max)
+AH_MINMAX_HELPER(vfp_ah_maxs, float32, float32, max)
+AH_MINMAX_HELPER(vfp_ah_maxd, float64, float64, max)
+
 /* 64-bit versions of the CRC helpers. Note that although the operation
  * (and the prototypes of crc32c() and crc32() mean that only the bottom
  * 32 bits of the accumulator and result are used, we pass and return
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 334aff42753..ae3f3d32f45 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5152,6 +5152,15 @@ static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
                                        select_ah_fpst(s, a->esz));
 }
 
+/* Some insns need to call different helpers when FPCR.AH == 1 */
+static bool do_fp3_scalar_2fn(DisasContext *s, arg_rrr_e *a,
+                              const FPScalar *fnormal,
+                              const FPScalar *fah,
+                              int mergereg)
+{
+    return do_fp3_scalar(s, a, s->fpcr_ah ? fah : fnormal, mergereg);
+}
+
 static const FPScalar f_scalar_fadd = {
     gen_helper_vfp_addh,
     gen_helper_vfp_adds,
@@ -5185,14 +5194,24 @@ static const FPScalar f_scalar_fmax = {
     gen_helper_vfp_maxs,
     gen_helper_vfp_maxd,
 };
-TRANS(FMAX_s, do_fp3_scalar, a, &f_scalar_fmax, a->rn)
+static const FPScalar f_scalar_fmax_ah = {
+    gen_helper_vfp_ah_maxh,
+    gen_helper_vfp_ah_maxs,
+    gen_helper_vfp_ah_maxd,
+};
+TRANS(FMAX_s, do_fp3_scalar_2fn, a, &f_scalar_fmax, &f_scalar_fmax_ah, a->rn)
 
 static const FPScalar f_scalar_fmin = {
     gen_helper_vfp_minh,
     gen_helper_vfp_mins,
     gen_helper_vfp_mind,
 };
-TRANS(FMIN_s, do_fp3_scalar, a, &f_scalar_fmin, a->rn)
+static const FPScalar f_scalar_fmin_ah = {
+    gen_helper_vfp_ah_minh,
+    gen_helper_vfp_ah_mins,
+    gen_helper_vfp_ah_mind,
+};
+TRANS(FMIN_s, do_fp3_scalar_2fn, a, &f_scalar_fmin, &f_scalar_fmin_ah, a->rn)
 
 static const FPScalar f_scalar_fmaxnm = {
     gen_helper_vfp_maxnumh,
-- 
2.34.1


