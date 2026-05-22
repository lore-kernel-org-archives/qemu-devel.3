Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F29CD5BB6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUay-0004lX-Iq; Fri, 22 May 2026 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUax-0004kr-E2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUau-0005Ok-FX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso53378755ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474455; x=1780079255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmkEFB6oOfB6a2ylH8LqqZtIcmvXziHGDfc7NRPoi8s=;
 b=ItfxGpCwtbsoRNIYi4NiAYeFG7z0GjG3XSO62Q8mJXSvGyxTZ/b8+tsMauG2nTGUCn
 qZ6XdG9MRlry5MaddOf2LZbuvCpbBnYSx6z5o5ct4R92k4M3KTnkti2zZquYp16Qq/kr
 zmHLHy9ZDIx3oLdmb6ueXiTz9Xk3SeYiJmzJfuS0sjZx6AV21KyAruy1l+9JQNtV92GF
 4yvOMTtXoJ65a32oZz0fqSCUvVimTZ/RIVApnJ1e4rxUjj9iMV5C3h9Jry2acjElfL/w
 J+1z6u4r3LUgEgVYuls8o2v44QKyBDLv7GNF4DX1iz1fSQjZNaAgB6A5CZO6iOuFQPHO
 jbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474455; x=1780079255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmkEFB6oOfB6a2ylH8LqqZtIcmvXziHGDfc7NRPoi8s=;
 b=Bf7nP9hblULX4A2fdpTTyCDd7kSAiOB2Nt7ZK4NMeB1Cm+D48rqTS30Eqnpy7jh556
 gJVHPqF8kw7X3T5fyMvVLUb0cUQD++W3tw7jKAzTrmIcSLY3/+ee1v196TVnQ8t7Hl4m
 NhLa6/hPrT/wXL3z1bfTxLSXDwX9PNBswKGCaKQtfKmuIYKzxwV4JHZgf+SIqJYqlChr
 03xdq+ecMggCpgNon5f2EowJgk6NyU2SxXjuTtk8nY/K+9JUOCGAPlFkqz0HumPf7rNi
 0x5hQurrzUDSSW1ASyQd+rQNcWtUVRo+XzSJ+E2sJq7ctrzQpyYB+JFSCV5JisFLF4Ck
 kmcA==
X-Gm-Message-State: AOJu0YyuytN58DucIOOYqCakNn02uijsEJhNPsUEMgEBwmGCaREILoeH
 ajEAjSWHadwZISuVoOrI7gZNpUn9vTxiRLf6T7nPVwcXBZ4uR4eUqHXOsfzLIvwMswuXhmW9vlI
 QaH7H
X-Gm-Gg: Acq92OGJ9SrHaKfdjbqEcJsG11L6MomXJxlAaX69bRjyj+agSX71TA5jehJwJxQ5koz
 dQsrCcL0taMLIeaFhBwxCb6RtaQRppCDpiB25hTz0olPNIaK6bqbszbX+99peML39KDJ+Ki73ae
 We2wtyTdZqZgIzY10+RqJ0QZl0zcop3cHQA0fGSLoGUepWa5O7SUfV1d3q59SD4mQDVUEAoMz0N
 UjdYx5MpcEbTZp/zdAu80xW2SCcAhMa/hQCCEHzlMZG8mkxQK7oGfudmVORP3dJKNt66vkGy/gP
 kgdTsAA3iA1eMdvy4ijd8l0SaIuc0+luk3vidUatri3Pjq/ieN/pDRj6YX5+1h899PzMLP3znl7
 pFOGymFtmWPENdV+YXxLkvzbQ13tls1UiY6P6/4isTFEStDzj2yeH9bCNnr0O1FLLOHokPX8dGt
 64Cvsp5FNZBvJNSdsQvlLHeOO10kpc+1PI3bAfdvk=
X-Received: by 2002:a17:903:2bcc:b0:2bd:e5d4:dc63 with SMTP id
 d9443c01a7336-2beb070343emr52771985ad.26.1779474455049; 
 Fri, 22 May 2026 11:27:35 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/30] fpu: Introduce exp_scalbn
Date: Fri, 22 May 2026 11:26:36 -0700
Message-ID: <20260522182658.184604-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Avoid exponent overflow as well as checking that we don't lose information with
opposing scaling.  Use it in partsN(scalbn) and partsN(round_to_int_normal).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 29 +++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc |  5 ++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a762f4b43a..df94f299e1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -461,6 +461,15 @@ typedef struct {
     uint64_t frac_lo;
 } FloatParts256;
 
+/*
+ * Minimum and maximum exponent for scalbn.
+ * These are chosen to be much larger than the true exponent for any input format,
+ * but also not at the bounds of INT32_{MIN,MAX} so that we can perform other
+ * arithmetic on the exponent without overflowing, particularly during uncanon.
+ */
+#define SCALBN_EXP_MAX  0x0fffffff
+#define SCALBN_EXP_MIN  (-SCALBN_EXP_MAX)
+
 /* These apply to the most significant word of each FloatPartsN. */
 #define DECOMPOSED_BINARY_POINT    63
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
@@ -601,6 +610,26 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
+static int32_t exp_scalbn(int32_t exp, int32_t scale)
+{
+    /*
+     * Catch chains of scaling which lose information.
+     * In particular, if the exponent has been saturated,
+     * do not allow it to become unsaturated.
+     */
+    if (exp >= SCALBN_EXP_MAX) {
+        assert(scale >= 0);
+    } else if (exp <= SCALBN_EXP_MIN) {
+        assert(scale <= 0);
+    }
+    if (sadd32_overflow(exp, scale, &exp)) {
+        exp = scale < 0 ? SCALBN_EXP_MIN : SCALBN_EXP_MAX;
+    } else {
+        exp = MIN(MAX(exp, SCALBN_EXP_MIN), SCALBN_EXP_MAX);
+    }
+    return exp;
+}
+
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 45606f8402..4715187017 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1098,8 +1098,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     uint64_t frac_lsb, frac_lsbm1, rnd_even_mask, rnd_mask, inc;
     int shift_adj;
 
-    scale = MIN(MAX(scale, -0x10000), 0x10000);
-    a->exp += scale;
+    a->exp = exp_scalbn(a->exp, scale);
 
     if (a->exp < 0) {
         bool one;
@@ -1623,7 +1622,7 @@ FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
     case float_class_normal:
         {
             FloatPartsN r = *a;
-            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            r.exp = exp_scalbn(r.exp, n);
             return r;
         }
     default:
-- 
2.43.0


