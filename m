Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A284FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLj-0000NH-MH; Wed, 29 Apr 2026 18:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLe-0000H9-7y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:39 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLc-0004tb-Ff
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3614826eca4so214730a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501535; x=1778106335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SukI7zVxjc9k6VHBdSxDOg9roiR/Riy2IZzjexvh+xM=;
 b=N3mJvLoaM3LanqmDawDQuABwia8lN+wwI7oYg04z/6oneeqQ2uKsICHPwJTza+IEO0
 cWO9vprzNuRJUH3vomMAqp8965y/RNpe6h8G4YAVXsvDDtYv+pZ/Z6H1AxNbnL/Ui0Ir
 EShMxcOF9fdzticvnXV8F0ttRr34Zz3n5JrqXUaTxD8ZfBWDnBqaNOb/mWcBHt/M8xKl
 AuppYaE1wcJ6dDAC26TCXuPrq8DahZkx0QoU27i6Nu7j0JGbggcYmKHmp3IYDRAyVwKT
 /n2S6YtP8F9FTsGOS4h/VO8DoR8w666jECH7JT/WP+hOlrDu08SZ/dBviDJFn/Dz+Q53
 Lqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501535; x=1778106335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SukI7zVxjc9k6VHBdSxDOg9roiR/Riy2IZzjexvh+xM=;
 b=A6f0tVMP2FWJSylYIaANKfon1F/DZvAF1H8eHQ/+xUWne20QeEMBqwS9f13hmUiFSj
 aCBF3VYaQYUoNNVl6zvu62rZQh87bg2nkQoX4XcDkDvqIBStf/vj2bFjd6kJhWcWdjSn
 tw3ePKZKzbXE/bcuyO6xQ+BPsDr5PhKasXqy6NZkmdlAjzH2EjV7JPfZozxtRYfAuCDB
 D9CTHJvXTSf4rRjXv09GVTPwFxJ4UGI4pX4eEQyo/lAbJRH/YHBbz2ddMHQYGmLtvDuT
 gAa6ZfP5lxcq8yUWAteIVByR6pjQvGf4TGeIyVtOc2zbw6nWkXDlRezp1WLm3VzGEfVM
 GYIg==
X-Gm-Message-State: AOJu0YxS4SZxng4byeFhzLPyUJ8aj/IveZRGqwNm9ZSxyb3aFl1H8+1F
 AYLsgHxvdSCqK/cM5sW/NOkSG4Q8mRDMVjdvcunU4qifWJsFb6p19AKJOkgmUF7E5NX/9o/KkwN
 EIzDdpjE=
X-Gm-Gg: AeBDietE1IFrme36HMs/299xyK6lJ9pv3az7zNjQ+uwG8zcL+/arkCf7LVavqIuR0sA
 0UXjI/hb26i2n/Sj+NdIaZZ7ajIhVfJDNw99nY4y3sRKYgnD4azQ/rX9AVM0AdIP3/TZeU+0U/Q
 70jmEbSjafE5DSwT/iuxmWKeeaQOZKqqzaonGvbmVPhnYpmH9rK9xN1r5bd8n3GnFG380XFEo50
 C5mACv9XdsVTZPqCdnFeYclrOLZcjZKaEeovnQU6ePWpV3qB9JaaGkDgmw7mZLMJ1vGGYhmlalZ
 U91DcCCt8Eh51Bl4QmOAFJ8luX0N3fd8t40nSksuERCLOHjnjJ6+y/LbmuVdhPC9dj3bGE+GWtx
 g2tG6oy2rP2l4Sa8L3QCyZI0a5vv3j2ktqHV/sh3B4bPh/6IgJRaJgnPJSPpjZv9Ti83gelgMt8
 tX+PC9m861R1d08cjuH6tSLTLj6o4ft+mVL8OJFdWD
X-Received: by 2002:a17:90b:180a:b0:35f:bb33:d728 with SMTP id
 98e67ed59e1d1-364c3065d51mr174771a91.11.1777501534963; 
 Wed, 29 Apr 2026 15:25:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/48] fpu: Drop parts_round_to_int_normal
Date: Thu, 30 Apr 2026 08:24:14 +1000
Message-ID: <20260429222445.26301-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 22 +++++++---------------
 fpu/softfloat-parts.c.inc | 10 +++++-----
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0a6bc6d580..1f03fcf687 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static bool parts64_round_to_int_normal(FloatParts64 *a, FloatRoundMode rm,
-                                        int scale, int frac_size);
-static bool parts128_round_to_int_normal(FloatParts128 *a, FloatRoundMode r,
-                                         int scale, int frac_size);
-
-#define parts_round_to_int_normal(A, R, C, F) \
-    PARTS_GENERIC_64_128(round_to_int_normal, A)(A, R, C, F)
-
 static void parts64_round_to_int(FloatParts64 *a, FloatRoundMode rm,
                                  int scale, float_status *s,
                                  const FloatFmt *fmt);
@@ -3365,7 +3357,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
 
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
+        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
         }
 
@@ -3793,7 +3785,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
 
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
+        if (parts128_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
             if (p.cls == float_class_zero) {
                 r = int128_zero();
@@ -5482,11 +5474,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
          * of distinguishing partial quotients, so ignore the exception.
          */
         *n = *q;
-        parts_round_to_int_normal(n,
-                                  is_q_smallish ?
-                                      final_quotient_rounding_mode :
-                                      float_round_to_zero,
-                                  0, fmt->frac_size);
+        parts64_round_to_int_normal(n,
+                                    is_q_smallish
+                                    ? final_quotient_rounding_mode
+                                    : float_round_to_zero,
+                                    0, fmt->frac_size);
 
         /* Compute precise remainder */
         r_precise_buf = *b;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6e1800b117..9b719ac5cf 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1127,7 +1127,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
  * according to the IEC/IEEE Standard for Binary Floating-Point
  * Arithmetic.
  *
- * parts_round_to_int_normal is an internal helper function for
+ * partsN(round_to_int_normal) is an internal helper function for
  * normal numbers only, returning true for inexact but not directly
  * raising float_flag_inexact.
  */
@@ -1270,7 +1270,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
         break;
     case float_class_normal:
     case float_class_denormal:
-        if (parts_round_to_int_normal(a, rmode, scale, fmt->frac_size)) {
+        if (partsN(round_to_int_normal)(a, rmode, scale, fmt->frac_size)) {
             float_raise(float_flag_inexact, s);
         }
         break;
@@ -1316,7 +1316,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
         }
 
@@ -1384,7 +1384,7 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
             if (p->cls == float_class_zero) {
                 r = 0;
@@ -1448,7 +1448,7 @@ static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
     case float_class_normal:
     case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
+        if (partsN(round_to_int_normal)(p, rmode, 0, N - 2)) {
             flags = float_flag_inexact;
         }
 
-- 
2.43.0


