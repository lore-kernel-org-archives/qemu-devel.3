Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E9BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEui-0006IQ-HY; Wed, 29 Apr 2026 20:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEue-0006Ao-Ng
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuc-0001ku-MR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso1056320b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507549; x=1778112349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/DtA0bTg/+qbb2xEBeyZd976Nwj4hvFStm5Q31fGd4=;
 b=EgCZU4FSWwcLYgT+oO9Vhqf16VO+gXKMlpsYPLYeF5NbzagBU2tfTZMEIdGFEJK+Ga
 k/zUpf4uZ4gp42KbbRKa6QH/wZ6XFKZNOWF10vq1R0QqYH1oQwHatJ3yhceh90QlJV+C
 uGtNP4+8lWPh0RHKJvnqVUZ3Qeip/nin6cC9q5JKyzAP46Q6r833/pp1ooHCL0j8R5LE
 IXT+nYSild7JRgM3kGxpq62MEg8xiV40xGA7PtWGW0RuV/cCr84eUr4Rn9hDQOWzJTfX
 HxOTxsjTz6fmG3hdFz6g0chEQuR/I/qCoF/GSynMldK4TvTULyfmHJRebnxF7XqraNgC
 gp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507549; x=1778112349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t/DtA0bTg/+qbb2xEBeyZd976Nwj4hvFStm5Q31fGd4=;
 b=CAB2wMHbafoJDG3zKv3m+1C7cW4eXh3fcZgQywnKIaKnsTlbmSQwye162UUQu8gtqp
 qgT7rsORALXvq+P8GDJNpPKo8mZMKs0fOt6fUOiX2bPsp1gOT2tK0AVGpme7IMA1vDqu
 6PBU3QgM0SqrkLceG2/DlfqCesgoAcrDDU7qRD3ZVgBe/TOO7Qvm/YAepmpMGZGtqvmY
 S1DkpvfIO3QYD87SW6RRuLNGIAMc6TBfG32g8TQruxktyfUnE2A6qPz6IxxkulF46Io3
 V8K81mqVNH8HU74V6CIInS3V/0Wonh7yhu9C72UYHMSmepqIhZpuAfSrOt2FEJH0E2Je
 Yszw==
X-Gm-Message-State: AOJu0Yy8kievVNhlKhhUTepL7mueysKPdLeey6K/qgQe84CARPgBqfAk
 5/2/6AUKBRl6eWosMsWbrsDk82DgYDVklUd2tqKZrvguw1Twyo+T5gKRK3O9GT6ivr03DWEy8Pz
 vuLyUus8=
X-Gm-Gg: AeBDieskDmcDV7DcGEVc0vtBK9xf3H0u1S2QdinK4ublOrblC6KKM27+omjdq2pNnty
 88T8UILwpc0M87lOl0kzkf2bBr9zFEqMjSkF0b4q88PnX8KkzaINyyuSQPtungtoPr8Zkb/Yqk/
 YWWK5cswZz3wPUCNcXL1+Y3hj8S3HhnLL0UFxZfgol6aT52Kbtp/QYCnpLgz4mJWu1R3ghMRuWd
 919h7nXqeqlVXvXtXxToY2prF+hQulDAxK9tO/tJtqiz4SdHuZYABGGk6/C86J6vLe61XApPru/
 njWyuKlVLMRSTpkEQvCVu2LZbutcs0Gry2IRlCwnsgVH5tF9BKhWriDZZXGeWyZWP8ODysL6jsV
 K3whfZ1r+kVIJ5oi/YijFK48I+Ado2LQmEu059GQpD7D5tC2ELME4Z59kRAPCbJ33F+uMvcrVpA
 rGiQweesCwOyah5LOnEFsUeiBfRpsTfaJ8JQMzoWAS
X-Received: by 2002:a05:6a00:893:b0:829:b08f:7353 with SMTP id
 d2e1a72fcca58-834fffb17d0mr262660b3a.7.1777507549208; 
 Wed, 29 Apr 2026 17:05:49 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 09/40] fpu: Split FloatParts{64,128} to softfloat-parts.h
Date: Thu, 30 Apr 2026 10:04:52 +1000
Message-ID: <20260430000524.56046-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Begin exposing the intermediate representation of softfloat.
Start with just the representation structures.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 88 +++++++++++++++++++++++++++++++++++
 fpu/softfloat.c               | 69 +--------------------------
 2 files changed, 90 insertions(+), 67 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
new file mode 100644
index 0000000000..13c1f3d2d6
--- /dev/null
+++ b/include/fpu/softfloat-parts.h
@@ -0,0 +1,88 @@
+/*
+ * Floating point intermediate representation
+ *
+ * The code in this source file is derived from release 2a of the SoftFloat
+ * IEC/IEEE Floating-point Arithmetic Package. Those parts of the code (and
+ * some later contributions) are provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file after December 1st 2014 will be
+ * taken to be licensed under the Softfloat-2a license unless specifically
+ * indicated otherwise.
+ */
+
+#ifndef SOFTFLOAT_PARTS_H
+#define SOFTFLOAT_PARTS_H
+
+/*
+ * Classify a floating point number. Everything above float_class_qnan
+ * is a NaN so cls >= float_class_qnan is any NaN.
+ *
+ * Note that we canonicalize denormals, so most code should treat
+ * class_normal and class_denormal identically.
+ */
+
+typedef enum __attribute__ ((__packed__)) {
+    float_class_unclassified,
+    float_class_zero,
+    float_class_normal,
+    float_class_denormal, /* input was a non-squashed denormal */
+    float_class_inf,
+    float_class_qnan,  /* all NaNs from here */
+    float_class_snan,
+} FloatClass;
+
+#define float_cmask(bit)  (1u << (bit))
+
+enum {
+    float_cmask_zero    = float_cmask(float_class_zero),
+    float_cmask_normal  = float_cmask(float_class_normal),
+    float_cmask_denormal = float_cmask(float_class_denormal),
+    float_cmask_inf     = float_cmask(float_class_inf),
+    float_cmask_qnan    = float_cmask(float_class_qnan),
+    float_cmask_snan    = float_cmask(float_class_snan),
+
+    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
+    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
+    float_cmask_anynorm = float_cmask_normal | float_cmask_denormal,
+};
+
+/*
+ * Structure holding all of the decomposed parts of a float.
+ * The exponent is unbiased and the fraction is normalized.
+ *
+ * The fraction words are stored in big-endian word ordering,
+ * so that truncation from a larger format to a smaller format
+ * can be done simply by ignoring subsequent elements.
+ */
+
+typedef struct {
+    FloatClass cls;
+    bool sign;
+    int32_t exp;
+    union {
+        /* Routines that know the structure may reference the singular name. */
+        uint64_t frac;
+        /*
+         * Routines expanded with multiple structures reference "hi" and "lo"
+         * depending on the operation.  In FloatParts64, "hi" and "lo" are
+         * both the same word and aliased here.
+         */
+        uint64_t frac_hi;
+        uint64_t frac_lo;
+    };
+} FloatParts64;
+
+typedef struct {
+    FloatClass cls;
+    bool sign;
+    int32_t exp;
+    uint64_t frac_hi;
+    uint64_t frac_lo;
+} FloatParts128;
+
+#endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8c4263bfe6..cd75df3160 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -83,6 +83,7 @@ this code that are retained.
 #include <math.h>
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 
 /* We only need stdlib for abort() */
 
@@ -396,39 +397,6 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
-/*
- * Classify a floating point number. Everything above float_class_qnan
- * is a NaN so cls >= float_class_qnan is any NaN.
- *
- * Note that we canonicalize denormals, so most code should treat
- * class_normal and class_denormal identically.
- */
-
-typedef enum __attribute__ ((__packed__)) {
-    float_class_unclassified,
-    float_class_zero,
-    float_class_normal,
-    float_class_denormal, /* input was a non-squashed denormal */
-    float_class_inf,
-    float_class_qnan,  /* all NaNs from here */
-    float_class_snan,
-} FloatClass;
-
-#define float_cmask(bit)  (1u << (bit))
-
-enum {
-    float_cmask_zero    = float_cmask(float_class_zero),
-    float_cmask_normal  = float_cmask(float_class_normal),
-    float_cmask_denormal = float_cmask(float_class_denormal),
-    float_cmask_inf     = float_cmask(float_class_inf),
-    float_cmask_qnan    = float_cmask(float_class_qnan),
-    float_cmask_snan    = float_cmask(float_class_snan),
-
-    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
-    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
-    float_cmask_anynorm = float_cmask_normal | float_cmask_denormal,
-};
-
 /* Flags for parts_minmax. */
 enum {
     /* Set for minimum; clear for maximum. */
@@ -474,40 +442,7 @@ static inline bool is_anynorm(FloatClass c)
     return float_cmask(c) & float_cmask_anynorm;
 }
 
-/*
- * Structure holding all of the decomposed parts of a float.
- * The exponent is unbiased and the fraction is normalized.
- *
- * The fraction words are stored in big-endian word ordering,
- * so that truncation from a larger format to a smaller format
- * can be done simply by ignoring subsequent elements.
- */
-
-typedef struct {
-    FloatClass cls;
-    bool sign;
-    int32_t exp;
-    union {
-        /* Routines that know the structure may reference the singular name. */
-        uint64_t frac;
-        /*
-         * Routines expanded with multiple structures reference "hi" and "lo"
-         * depending on the operation.  In FloatParts64, "hi" and "lo" are
-         * both the same word and aliased here.
-         */
-        uint64_t frac_hi;
-        uint64_t frac_lo;
-    };
-} FloatParts64;
-
-typedef struct {
-    FloatClass cls;
-    bool sign;
-    int32_t exp;
-    uint64_t frac_hi;
-    uint64_t frac_lo;
-} FloatParts128;
-
+/* FloatParts256 is entirely internal, for parts128_mul* */
 typedef struct {
     FloatClass cls;
     bool sign;
-- 
2.43.0


