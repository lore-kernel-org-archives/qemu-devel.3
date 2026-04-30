Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F6FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvu-0000O1-Px; Wed, 29 Apr 2026 20:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvA-0007jg-FM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv8-0001rQ-Mr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso184885b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507581; x=1778112381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mb4L+qTw3Kb38d/DWLTFfTE67HLYWjknIpD/4FiKS+s=;
 b=EWVT3mH31MNU69NkuQFwgkQ29z0O8KKTyO/6UtFJsvK643mvDC+4ouOQDAIAcsp5er
 CeZAoNUQ20EfE17QRmdblgEt3M5oyDAuSAYJq3VhtD5ULFmFjrfwsKb9YsHN6KV2SURU
 sTVE5hj/P4SJWArrVAvRBlgze+aMgpazwJglPiKmAsNSJ7LJZ/jziCsjQCXYuVb20WkN
 PIV4BhCYOqXKQsNTVVQmgaCEIaYi3jUSVYOTRKhMGt5YlmtuBeNA1MrfGuEauntCwJXM
 exCX2K3aCL5X74ptYLoTfwDrhFPSnd9/WNxbWoMLZ3TCMizgZCTI+rK2njDdrz4CZ9Qi
 gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507581; x=1778112381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mb4L+qTw3Kb38d/DWLTFfTE67HLYWjknIpD/4FiKS+s=;
 b=MRpifJ3S19xABy0r9YSGT4dWkFeNqt//05o5jI8lJyOV15q0NipRBrVmDh/GXc7DID
 YWqNef6JjphWXJUP4CcTi1yMCKFz8/x8g785cPfXV3xSzNOXHvbwPzXb5qNbp5ut4n2k
 /lz6hVvw4nijxetYngX/wFWcJSD91OvyfDQtNHkIgFhr23zlafQGfWQd69pwKUO4ZBOM
 zmKncpeffjot18GTJOxmAvmjxmjX3tMVuV7tAypjW5OfSUooc8sFFERdhl4f5rgJs7gn
 ye+1sGAhTYLqRdYxUXKO6ulMMaPmJBL6kWnJMpsQeUf4KOqyyQ3cb77B0DEcN2wu5MXD
 GFUA==
X-Gm-Message-State: AOJu0YxOcA6SZU8CSlSDts6y2tsImw3HGb+yUPB5pHBsznUiwPRl6Ao3
 Ab0jh0f/BKhqo1rNTlvjyke+vhlkHd/axTRrcCVcOYVDy+u5Gy0b95SOQRg9i26ws4WmNnFFGhr
 MvKvhvQs=
X-Gm-Gg: AeBDieviizhkR16zDojFm2Z/ROX7ZixS1HYG+7P78AL5DXv6F2uu1zIjXZ+ZgMSnwMu
 Ti25mn999uO5oO8sOQnHwUX9i055ucOzQswb7LUAb1yNFzIvj9QxfSY+1+UIMYe4YI8MjnYN/a0
 TAnw2QkUSq95XVtvzWC80qyOJZ5xofK5Qv2sPRO8nx3+EwhwpdAbTPnKpS2CeD1GexOa5SQJ/HW
 Yj5JGwLTwhXfkxYa/pfpPix8oxbeuFG7sGRPyLWCX73XIAqZ5f5wVdaBqC5wKkau7/pfXe7HqZP
 o7UJ9MD60XEpG4ctg0x3r75oVuJH1TRh4oKlVjfYtBZKZ98yjj3bQSnakXrwYRR8BRScFNGL0pN
 Isqhepz6yxQm/pNn2wTgEK5Iqt+nO92+En9NzW177V6yUEv5iLXvLFEx/5owf6Ra47CfkbrWWdP
 TfhPb6LujI1xV7iIoGMWwKdQ1gngQlJ0QXMFFD9hBRY2PYYNw72RE=
X-Received: by 2002:a05:6a00:8704:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-834fdb07cd3mr590548b3a.6.1777507580955; 
 Wed, 29 Apr 2026 17:06:20 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 23/40] fpu: Introduce record_denormals_used
Date: Thu, 30 Apr 2026 10:05:06 +1000
Message-ID: <20260430000524.56046-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  8 +++++++
 fpu/softfloat-parts.c.inc | 49 +++++++++++----------------------------
 2 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4efafbf05a..168181858f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -442,6 +442,14 @@ static inline bool is_anynorm(FloatClass c)
     return float_cmask(c) & float_cmask_anynorm;
 }
 
+/* Record when denormals have been used. */
+static void record_denormals_used(int mask, float_status *s)
+{
+    if (unlikely(mask & float_cmask_denormal)) {
+        float_raise(float_flag_input_denormal_used, s);
+    }
+}
+
 /* FloatParts256 is entirely internal, for parts128_mul* */
 typedef struct {
     FloatClass cls;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 211ecdf114..028c2daa27 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -534,9 +534,8 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if ((ab_mask & (float_cmask_denormal | float_cmask_anynan)) ==
-        float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
+    if (!(ab_mask & float_cmask_anynan)) {
+        record_denormals_used(ab_mask, s);
     }
 
     if (a->sign != b_sign) {
@@ -623,9 +622,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
 
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
 
         fracN(mulw)(&tmp, a, b);
         fracN(truncjam)(a, &tmp);
@@ -653,9 +650,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     /* Multiply by 0 or Inf */
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_inf) {
         a->cls = float_class_inf;
@@ -784,9 +779,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * this matches the set of cases where we consumed a
      * denormal input.
      */
-    if (abc_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(abc_mask, s);
     return a;
 
  return_sub_zero:
@@ -819,9 +812,7 @@ FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
     r.exp -= b->exp;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
         r.exp -= fracN(div)(&r, b);
         return r;
     }
@@ -841,8 +832,8 @@ FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
         return partsN(pick_nan)(a, b, s);
     }
 
-    if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
-        float_raise(float_flag_input_denormal_used, s);
+    if (b->cls != float_class_zero) {
+        record_denormals_used(ab_mask, s);
     }
 
     /* Inf / X */
@@ -877,9 +868,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
     if (likely(cmask_is_only_normals(ab_mask))) {
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
         fracN(modrem)(a, b, mod_quot);
         return a;
     }
@@ -901,9 +890,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     /* N % Inf; 0 % N */
     g_assert(b->cls == float_class_inf || a->cls == float_class_zero);
@@ -1493,9 +1480,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         if ((flags & (minmax_isnum | minmax_isnumber))
             && !(ab_mask & float_cmask_snan)
             && (ab_mask & ~float_cmask_qnan)) {
-            if (ab_mask & float_cmask_denormal) {
-                float_raise(float_flag_input_denormal_used, s);
-            }
+            record_denormals_used(ab_mask, s);
             return is_nan(a->cls) ? b : a;
         }
 
@@ -1521,9 +1506,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     a_exp = a->exp;
     b_exp = b->exp;
@@ -1594,9 +1577,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatRelation cmp;
 
-        if (ab_mask & float_cmask_denormal) {
-            float_raise(float_flag_input_denormal_used, s);
-        }
+        record_denormals_used(ab_mask, s);
 
         if (a->sign != b->sign) {
             goto a_sign;
@@ -1623,9 +1604,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
         return float_relation_unordered;
     }
 
-    if (ab_mask & float_cmask_denormal) {
-        float_raise(float_flag_input_denormal_used, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_zero) {
         if (ab_mask == float_cmask_zero) {
-- 
2.43.0


