Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4244CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb8-00057S-Kr; Fri, 22 May 2026 14:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb6-0004yj-HX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb4-0005Rj-GA
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so62412295ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474465; x=1780079265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CkGcitbVj7Tw/zFQo/cJKaPLwAnxuxCUWUlpY6Me2M=;
 b=o5HuY0rVUvqyZWUHHAK8tubZ8TFhTs8J8FsrMzsGXXrebajHKlfkqI3GzrWfhd2XhY
 PDiXzNwCXFZHI2U5xf7GUbUKUCcYJgmBlNlp8w3tQpt4e0KEIQWCv1qaaU3FK2kgwfIN
 ngOYpWCUWuOsvbz8tXWAitOK2wwYzuUoeuQlKmZjVjZhER93CJ0v3J3ked5FkLTuT4Ph
 P3d0H+oByRqt3vNST0UnNciezTNdfvp47a/Y8w56D+dEShL689VPH59FKe7dw/hZDhlj
 ANhTsn0kQVGis82EtQXQJyg8MiVqeXsZOsYI3hBSDjTHUFHi4duh45iofNY/anLB6tKg
 YgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474465; x=1780079265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CkGcitbVj7Tw/zFQo/cJKaPLwAnxuxCUWUlpY6Me2M=;
 b=j53cZctmuobz6+3VQoYA1MKViTiw2n0NpX+TYJN/ylpBa3fjIanSVj0aFfgIEDRRHN
 lsoCcFQ2Uj2/LmUFC07mN0aHmlG/4smRlWxrWV499t9W5/qNwVbtjEnNfNckI94fneGW
 UGhUvMLZFagNYBUQ5rKw6jyb/Y5QDpFhurijmI680WN2xEDTo9/6eo14VOakl8JTYMfk
 WDbg5r+U9dvJuVU0valSVQ/etDUryB7rfbWPBkswrJ2OhWFvK9yH/SzAXIGDUDQO1GdZ
 KMWo5tb/mCquU1yYYvJa1mrG7n0P3/3+qfkZfuYZl6g/aSu2aISNpxq8qSZbWJGgHQXe
 ui2g==
X-Gm-Message-State: AOJu0YwVvRGZ/J5RoxOjgeMmGlMW2iMIhRkFqI5gW11WrsHziKuZQQ8F
 3REUeJ74wXvDTGdFZG2VS6vpTmGHh4/7sHbIErqaQ+zmz/YbLdZSKPr3tuthMsXHXZLp1E6QjvL
 sjqTm
X-Gm-Gg: Acq92OHePxNaANu3HEajyfgF14GxpIfK9L3sq/nWRewT5r2SYUx4tVp2lkfYUwXv8Xo
 NzbF0btbRVHA3SFYkj/ONO/rw+hqfX324xZkMPT6tM2Naz/A/TIVnbVqdqT2BDJZok7ez1QPRAj
 mRMbTeUBnIWYIoaIzHvWmQxF3lrZORPEltZ6btivJt3gBZyf2T2XBacvJTLZXLo239SmPo7T0w8
 hJP5cv75HlDDOZ6guQI6hRt/+D5fit6F6S5Uzd4ji9VUG3Ee0TSBAcgg51xExcF50iMwezgmfGp
 IHOPicio+WwdteriTtHz8EtL1FzdFc03MtzMbn53hqhKyn7/+G/bFEZuRZJyWooZ1m40Id9Wvm+
 oFyMkUkGel3GHMIUwxD/cPd+Yz2hZBfxmfr6BfYNErt8A47aEOw5cEFdt0E1UMA8qHSGV5HeVSo
 +zuJL8gMcWBhpYp3xAcOz/3oG+zLoTGL/2w7/lddU=
X-Received: by 2002:a17:902:da92:b0:2bc:db02:d1ed with SMTP id
 d9443c01a7336-2beb06738acmr46619125ad.38.1779474464882; 
 Fri, 22 May 2026 11:27:44 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/30] fpu: Use accessors for tininess_before_rounding
Date: Fri, 22 May 2026 11:26:48 -0700
Message-ID: <20260522182658.184604-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Rename get_float_detect_tininess to get_tininess_before_rounding
and move to softfloat.c, as there are no external users.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 fpu/softfloat.c                 | 4 ++--
 tests/fp/fp-test.c              | 2 +-
 fpu/softfloat-parts.c.inc       | 2 +-
 fpu/softfloat-specialize.c.inc  | 5 +++++
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 95edd22842..395ce67abf 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -132,11 +132,6 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
-static inline bool get_float_detect_tininess(const float_status *status)
-{
-    return status->tininess_before_rounding;
-}
-
 static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f774ff278c..c7c750f284 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4923,7 +4923,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
                 float_raise(float_flag_output_denormal_flushed, status);
                 return packFloatx80(zSign, 0, 0);
             }
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0 )
                   || (zSig0 <= zSig0 + roundIncrement);
             shift64RightJamming( zSig0, 1 - zExp, &zSig0 );
@@ -4997,7 +4997,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
             return floatx80_default_inf(zSign, status);
         }
         if ( zExp <= 0 ) {
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0)
                   || !increment
                   || (zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF));
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 326a1201f3..16ffd36e6f 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -1011,7 +1011,7 @@ void run_test(void)
 
                     verCases_tininessCode = 0;
                     slowfloat_detectTininess = tmode;
-                    qsf.tininess_before_rounding = sf_tininess_to_qemu(tmode);
+                    set_float_detect_tininess(sf_tininess_to_qemu(tmode), &qsf);
 
                     if (attrs & FUNC_EFF_TININESSMODE ||
                         ((attrs & FUNC_EFF_TININESSMODE_REDUCEDPREC) &&
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1e92251761..1c726cb86e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -418,7 +418,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         exp = 0;
         fracN(clear)(p);
     } else {
-        bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool is_tiny = get_tininess_before_rounding(s) || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
             (get_floatx80_behaviour(s) & floatx80_pseudo_denormal_valid);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4b6c17e433..0b62b0e907 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,6 +79,11 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+static inline bool get_tininess_before_rounding(const float_status *status)
+{
+    return status->tininess_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


