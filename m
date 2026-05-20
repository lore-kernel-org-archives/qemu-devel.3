Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF65CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZX-0001me-18; Wed, 20 May 2026 13:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZF-0001aW-7v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ9-00021F-0I
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367c2a39fcfso2420363a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297522; x=1779902322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzAkNYIqBiG4Wda0W3Zwd2nFVh/tHZDJYFGGvFPNoqQ=;
 b=U7MuupXA4CIB0D2mYCxaDgc1ZpyDtd1gg01KVrErPLaSrHg9LiXMmJv+NWzgjLnOHc
 gPjJp6nsOjx0hDtqbojKwn+k7BQtk+kcHQ59xQdTlUiH+/pBb7L55A66Yd4rUcqnv6ad
 YJXlkWuZJ4QcfVy7SAPNWdJcd0sGRkhdJ4VM1023AmFraZrZkqQsN7OlwAUh8V5fX+k5
 CH434JIrdoYiTlQQZ/p+QnvHKBO2i4TK3x5APxhOxzgI4/V12dYscpn6PqUbgW+d3RaI
 3ZlLkI34nRunCBEQiN/q1Sw3Gx9ckmBz7qaC/vPxrHQ9HDoYGhoqpu4faFQx+oD6/Eyl
 UbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297522; x=1779902322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EzAkNYIqBiG4Wda0W3Zwd2nFVh/tHZDJYFGGvFPNoqQ=;
 b=nMCQ9ZG1Feyo0FyyBXW43WGZnVuPpJUVW+MSZfQKWIWiGPrX4osvWfUyAYCCfsKO3M
 fpPi6IpAdd+KCzZKx+4W8LX6w6FPFlHkuMX9YZm+hlATBo2AC6YMhZ1oSVugb4QR+jEj
 4C5Og6L9K8ySBlo6ypyV6+vl+HYoLCUKQEJIZecnfNb8og2bDCjH+DSu7GGQWAIdVFdT
 GWDsNhYlFcwWygx2+2AKte4eRHfVPlGM0/nLhT5mOKJVpUcGJmXg3mJ6oOSBDneQuouH
 KeHUZ3OrCjWlAtg1ETZOAhDdQQUbuq3deOnGW+3dYvSGJygwkS+yvhKB8t3pFKUQQp5y
 VkDw==
X-Gm-Message-State: AOJu0Yzr7BaZXKaOSuyMe7QDbHLL5fmfoqgBpfMjOxet2fUW1b+hiiDc
 /zJul8PJSYwz8SVF9qfqq5fxea4GtROcHpcbidjxbOoBQGrDgw6b3Qiws8CTZlwat6K4QUsrNpT
 dIDxOUp4=
X-Gm-Gg: Acq92OG+XwIY36Ir6u8JaEG5GFULXatb194GqwQTQWJS4NgiUBWqe+b/MsFerXObwya
 lyAaWK86Ize6TA3HtPqHnkhaeC77hNraz0yx/30Ku30C903NSS+anYbww0p8ooUZUb1w5PoVlsy
 hgstgmmRvC+zf2fy+YJ7saCrZkuctVaYamPwuXzDh8ux9Yu+8Cp2SLSiDO52lWf+FJFdNYY0ft3
 8dI1N99AYgzFZZScbGgoEXw3jGT8iZ1az6AmNdEUhEkLAXrQhAH1L/m7P0fmra70QppZeq//YcM
 oR9utb+qHG85Nt+gUNGei8Z6OIaJ217GAR4j9IObfLtQi/HN4f3iaLaF7HFWZUJpKV8ATqzPH/B
 smc9tc5S5h47dDqZb8HJsKrTTGoLWXjL8hhVWJJ2+YsPxcmwpiCCpDrMHVIIMLX86bsjamp2viQ
 EPVzp/p0C9DgRbZjcIzKYtVISIsk8G
X-Received: by 2002:a17:90a:c2c3:b0:36a:b34:17e5 with SMTP id
 98e67ed59e1d1-36a0b3418f9mr7373258a91.14.1779297521462; 
 Wed, 20 May 2026 10:18:41 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 28/30] fpu: Introduce float_status.e4m3_nan_is_snan
Date: Wed, 20 May 2026 10:18:18 -0700
Message-ID: <20260520171820.848839-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Introduce a separate control from float_snan_rule
that applies only to the OCP E4M3 format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 +++++
 include/fpu/softfloat-types.h   | 5 +++++
 fpu/softfloat-parts.c.inc       | 2 +-
 fpu/softfloat-specialize.c.inc  | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 4791a7fc87..8df0273132 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -131,6 +131,11 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
+static inline void set_float_e4m3_nan_is_snan(bool val, float_status *status)
+{
+    status->e4m3_nan_is_snan = val;
+}
+
 static inline void set_float_rebias_overflow(bool val, float_status *status)
 {
     status->rebias_overflow = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index c5a6684763..d7f5303a6b 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -431,6 +431,11 @@ typedef struct float_status {
     /* do we detect and flush denormal results before or after rounding? */
     bool ftz_before_rounding : 1;
     FloatSNaNRule float_snan_rule : 2;
+    /*
+     * Overriding float_snan_rule, is the single NaN representation for
+     * the OCP E4M3 format an SNaN or QNaN?
+     */
+    bool e4m3_nan_is_snan : 1;
     Float2NaNPropRule float_2nan_prop_rule : 3;
     Float3NaNPropRule float_3nan_prop_rule : 7;
     FloatInfZeroNaNRule float_infzeronan_rule: 3;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 184614ea47..559e40d196 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -246,7 +246,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         case float_expmax_e4m3:
             if (p->frac_hi == 0b111) {
                 fracN(shl)(p, fmt->frac_shift);
-                p->cls = (parts_is_snan_frac(p->frac_hi, status)
+                p->cls = (get_float_e4m3_nan_is_snan(status)
                           ? float_class_snan : float_class_qnan);
                 return;
             }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b97c971ae6..8b765ef623 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -104,6 +104,11 @@ static inline bool get_float_rebias_underflow(const float_status *status)
     return status->rebias_underflow;
 }
 
+static inline bool get_float_e4m3_nan_is_snan(const float_status *status)
+{
+    return status->e4m3_nan_is_snan;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


