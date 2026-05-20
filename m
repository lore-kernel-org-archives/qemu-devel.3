Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39251CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZT-0001li-4t; Wed, 20 May 2026 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZB-0001Y5-SQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ5-0001zF-2l
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:45 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso2786073a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297518; x=1779902318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZFTPhW7lBRWobOEojdZOQ5DeeuW/EtkwycnvXNWaFs=;
 b=TPdn0fe+FWrPLieNJvZ4cUt+aHXE4vOWdjJKB97XwmxkRdILGkCFRi6t8El835b23i
 HXif/uDqJ4/O3la46iNo7Doa+Ho0vEYzjZvXUOL9RiSVswn2eZdrBxUEqZvl+i0QrcMt
 fBSrHaD8mHgbFJKSR+rquJjGlz3/4aWLHgMlf0bmIf9yeAr/M08DdTYzzblcIDHBD2QO
 tahxZF6aEp9PMDMuyiFGnkWq0A9D4ahfSmE3cxXBGlW7aCARq1vAGtOqYDiS9xNy5TIq
 BkDWdpuLU4qn7CRr6DYiSnQUQd7OXuii5ze4A/J2QnU1RW2Ll6u//u8jWIpDIOYIttt7
 T+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297518; x=1779902318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZFTPhW7lBRWobOEojdZOQ5DeeuW/EtkwycnvXNWaFs=;
 b=O6u5Vko5utrywZN300LpJVLa4ktuVcQcjxQdrEYpu5d28XoJ6aPXVqCYIDSveIPd1t
 W4rVvc0/GpRVqgYRDeQ+v0uM5s1XIfgpBJE1dwy6U5+21VZXvH4RFSoSdiardtBMGU+o
 qPfum1CH00OmWrVe2D3mdMoKnv3If15jB/oM28I4nilSuPUM0hpaJEzoOnG2qNSmghFK
 WAmyyzL4v2kWMZQJAh2Xv+gwrdLlzcA2ImEjFxMVZ3ydjiXNnhTFlv5QinfaaI0y82x/
 uqJHRgkss0HPgoYW9ewYr2TMfQq+tJBscIwEmChT/oK65GZxHf/+163l0aiYMHCxIkkX
 A1cQ==
X-Gm-Message-State: AOJu0YxFXZXwttT/FYCK2HWy6bIuFEhZlj8bz7+GClOramXJNCICCDDU
 C+ipkY7ApiUDx1vLuIeex18wqRoNR16mKAK9Vcnn6F5WFaRaIpgNHcBaYzDJ+rhxCf89rZktTg1
 JWxjgpTM=
X-Gm-Gg: Acq92OHkHNOosF+E1m6vaPwhMEhff2mXKd/wf/mj0sxlPNcT6c5k7UjneeD5DcRM4P3
 5WuFjJFtsNPI5Liz2qRZXdKlTmbywx/0M+iQ8LxG5FTLaXsHm49HDSkbNXcv8AAG1z4FqwFkymh
 n+rhm0fqOd31+iAKb2Zu5dj+OsAnH36wG03ifrYYZNyzBXBYMZl6tVQCFuUcrmbUpVbbJL1gDVe
 VGyKrAaswXv3SD6K0/h2dtEnduusj2C8JV0CTMb2biWBfjuAfKe0qWfnuQI6jhIVKLMQwrDyPE6
 18bsRtLODgbEPqVjHa4dFYOPz+reqMVLb+qaiOamVsKRf+YlVYVCG01AZtm4nNvWwNceyOsHpYD
 CVwl3fLcaIchlGyzeR6iRsOWFOsRbjE7CCSzM5TDTOJn4xZ6qn4RlYD1LQ0GY5EJDbNsmTnDtyL
 t6ZKJWeYvWD9+NUhllg+R7kIGhtKo0
X-Received: by 2002:a17:90b:4a03:b0:369:7003:4e30 with SMTP id
 98e67ed59e1d1-36970035860mr19588786a91.15.1779297517599; 
 Wed, 20 May 2026 10:18:37 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 22/30] fpu: Use accessors for ftz_before_rounding
Date: Wed, 20 May 2026 10:18:12 -0700
Message-ID: <20260520171820.848839-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Drop FloatFTZDetection and use #defines, like we do for
tininess_before_rounding.  Rename get_float_ftz_detection
to get_ftz_before_rounding and move to softfloat.c, as
there are no external users.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 10 ++--------
 include/fpu/softfloat-types.h   |  8 +++-----
 fpu/softfloat-parts.c.inc       |  5 ++---
 fpu/softfloat-specialize.c.inc  |  5 +++++
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 395ce67abf..d36e3a24b1 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -116,10 +116,9 @@ static inline void set_flush_inputs_to_zero(bool val, float_status *status)
     status->flush_inputs_to_zero = val;
 }
 
-static inline void set_float_ftz_detection(FloatFTZDetection d,
-                                           float_status *status)
+static inline void set_float_ftz_detection(bool val, float_status *status)
 {
-    status->ftz_detection = d;
+    status->ftz_before_rounding = val;
 }
 
 static inline void set_default_nan_mode(bool val, float_status *status)
@@ -198,9 +197,4 @@ static inline FloatSNaNRule get_snan_rule(float_status *status)
     return status->float_snan_rule;
 }
 
-static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
-{
-    return status->ftz_detection;
-}
-
 #endif /* SOFTFLOAT_HELPERS_H */
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index cf7093fa86..67b7f38aef 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -341,10 +341,8 @@ typedef enum __attribute__((__packed__)) {
  * configure it matches the default for tininess_before_rounding
  * (i.e. "after rounding").
  */
-typedef enum __attribute__((__packed__)) {
-    float_ftz_after_rounding = 0,
-    float_ftz_before_rounding = 1,
-} FloatFTZDetection;
+#define float_ftz_after_rounding   false
+#define float_ftz_before_rounding  true
 
 /*
  * floatx80 is primarily used by x86 and m68k, and there are
@@ -416,7 +414,7 @@ typedef struct float_status {
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
     /* do we detect and flush denormal results before or after rounding? */
-    FloatFTZDetection ftz_detection;
+    bool ftz_before_rounding;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 9e823a3ee9..0e5311b50f 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -411,8 +411,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         fracN(shr)(p, frac_shift);
-    } else if (get_flush_to_zero(s) &&
-               s->ftz_detection == float_ftz_before_rounding) {
+    } else if (get_flush_to_zero(s) && get_ftz_before_rounding(s)) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
@@ -463,7 +462,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 
         if (is_tiny) {
             if (get_flush_to_zero(s)) {
-                assert(s->ftz_detection == float_ftz_after_rounding);
+                assert(!get_ftz_before_rounding(s));
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
                 exp = 0;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 0b62b0e907..bd6984282f 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -84,6 +84,11 @@ static inline bool get_tininess_before_rounding(const float_status *status)
     return status->tininess_before_rounding;
 }
 
+static inline bool get_ftz_before_rounding(const float_status *status)
+{
+    return status->ftz_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


