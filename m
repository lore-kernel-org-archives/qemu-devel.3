Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C2FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMH-0002W7-PT; Wed, 29 Apr 2026 18:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDME-000228-LT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:14 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMB-0005EN-UG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35fb16e56efso133352a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501570; x=1778106370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWZQajC/tHGSK7fSPh9L60VVX/n9t/233b4QjeCHzU4=;
 b=cWyqMfJUGzwFAzmTWQQiJ5u8Gm3FKMyRushEXl49SyNBo4MFXVflr/9QNoH60DCoZJ
 uk3zEdtgFvHQiGSyqC38LfoTgJDb7sUE2Wi/m1hPNvlA0r7JrF0/MKcqn0zd9TpobgWS
 KMU5tPxruUeIUiOEeBH8dbY/I2xxague1L4ZR0k9jHc7Cvw8uS/t5k30DWiCzAqmluUt
 gAjBwrr8Ud+v+AkuThV81ibWc4B/SxIp6SUCrUTN/IzrxWj6GYPb9wiO71wKOuWo0tRZ
 i5GT49paIJwyFSSMzmWclHdHW3B4B2qXwxw3i9/eG9Mk934XBb7Fg72ynEWErgVap2Jq
 eBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501570; x=1778106370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWZQajC/tHGSK7fSPh9L60VVX/n9t/233b4QjeCHzU4=;
 b=MxkVgSgxEG6iFgZx+uGhKy/uqkNgW/N7RkOHKMimZuRYbkP3oepboCQknaGwT/hV+C
 ukhWydTPwT8ML4KUDM113pAkdv9esEeZr1LnmZMF3tIGfGnhazqAhSwSohX4yTAjWydB
 4Jm+50bJsfprqrB69R59CCisjtuOOLOa2DdgL2cGo6c41uooLTDDj1I+mYqRbFgbiAEo
 hWmxOM4ryYP4LbsFiJLe4Lc0BmXrEziu548/B0cUbbBoVIQDTZPEw7/gwyewZKswJKXS
 9AqKfuP2R3RlKoFL4Z57mixVU2KvUdy+0OR59UoOjojPY8k1O1LOH9VMuSeG+m1QXT+Z
 WlzA==
X-Gm-Message-State: AOJu0YxkPRaThOb3FLgWm5sqwmZWAG7guDfMv0wyPCd6Xjmi+ENxPr0n
 VmhoQsmkOQGqDM+O3B5q86KNpLnX2mc9/yT4TURK2FiBNMvmOMwvrUjlBEmphgkSHH+FCHsTE6m
 dngu1nGI=
X-Gm-Gg: AeBDieupqZurzwcIYRySccx7b+1giognfYapvB0xHxUbWvS08ONGE7QmFjFwr48prv+
 d9+/n4NZPuZx0RQi2ybUEiyrrMBrpnYkCrOEC36rPsV7kwrDvhlz7Rabc5RQ0VYr8xt+dQTwy4G
 /DcUzTlXbMr97Z2sF8JmmTqJAj90qbtxrbG4OJOBquFDzSDqZEz0ZhtXkThxR52BnJp968CnEEM
 0nBW9t6HmstAKwJXmy+o/Aerbpog2vuFAYFm9m7F5QcwkHKgS4NhB7CWdKSFsHaZYnEzkJ++M0r
 O7rxnyaE384mv3G9Kr6hDS+1lyE789NWPSfISW6GbVAfQyoQtq67qDcP0/2vPURt4K7GrLd3EaQ
 qlWn12JSb5m0dHqLBC7/K1fSrlslDgReayuPo5Npb5ioRQpL9GJHxiQbzUnuJZX8ccgmCYWIIUj
 0yFfipkMWP+gOaBuOAi8DcVLA+kBma6EsKprm6WWYj
X-Received: by 2002:a17:90b:270b:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-364c2d88673mr235815a91.0.1777501570359; 
 Wed, 29 Apr 2026 15:26:10 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/48] fpu: Constify frac{64,128,256}_* inputs
Date: Thu, 30 Apr 2026 08:24:28 +1000
Message-ID: <20260429222445.26301-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 fpu/softfloat.c | 53 +++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e462fb7d74..6cca31af30 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -774,12 +774,14 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
 
-static bool frac64_add(FloatParts64 *r, FloatParts64 *a, FloatParts64 *b)
+static bool frac64_add(FloatParts64 *r,
+                       const FloatParts64 *a, const FloatParts64 *b)
 {
     return uadd64_overflow(a->frac, b->frac, &r->frac);
 }
 
-static bool frac128_add(FloatParts128 *r, FloatParts128 *a, FloatParts128 *b)
+static bool frac128_add(FloatParts128 *r,
+                        const FloatParts128 *a, const FloatParts128 *b)
 {
     bool c = 0;
     r->frac_lo = uadd64_carry(a->frac_lo, b->frac_lo, &c);
@@ -787,7 +789,8 @@ static bool frac128_add(FloatParts128 *r, FloatParts128 *a, FloatParts128 *b)
     return c;
 }
 
-static bool frac256_add(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
+static bool frac256_add(FloatParts256 *r,
+                        const FloatParts256 *a, const FloatParts256 *b)
 {
     bool c = 0;
     r->frac_lo = uadd64_carry(a->frac_lo, b->frac_lo, &c);
@@ -797,12 +800,12 @@ static bool frac256_add(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
     return c;
 }
 
-static bool frac64_addi(FloatParts64 *r, FloatParts64 *a, uint64_t c)
+static bool frac64_addi(FloatParts64 *r, const FloatParts64 *a, uint64_t c)
 {
     return uadd64_overflow(a->frac, c, &r->frac);
 }
 
-static bool frac128_addi(FloatParts128 *r, FloatParts128 *a, uint64_t c)
+static bool frac128_addi(FloatParts128 *r, const FloatParts128 *a, uint64_t c)
 {
     c = uadd64_overflow(a->frac_lo, c, &r->frac_lo);
     return uadd64_overflow(a->frac_hi, c, &r->frac_hi);
@@ -818,14 +821,14 @@ static void frac128_allones(FloatParts128 *a)
     a->frac_hi = a->frac_lo = -1;
 }
 
-static FloatRelation frac64_cmp(FloatParts64 *a, FloatParts64 *b)
+static FloatRelation frac64_cmp(const FloatParts64 *a, const FloatParts64 *b)
 {
     return (a->frac == b->frac ? float_relation_equal
             : a->frac < b->frac ? float_relation_less
             : float_relation_greater);
 }
 
-static FloatRelation frac128_cmp(FloatParts128 *a, FloatParts128 *b)
+static FloatRelation frac128_cmp(const FloatParts128 *a, const FloatParts128 *b)
 {
     uint64_t ta = a->frac_hi, tb = b->frac_hi;
     if (ta == tb) {
@@ -847,7 +850,7 @@ static void frac128_clear(FloatParts128 *a)
     a->frac_hi = a->frac_lo = 0;
 }
 
-static bool frac64_div(FloatParts64 *a, FloatParts64 *b)
+static bool frac64_div(FloatParts64 *a, const FloatParts64 *b)
 {
     uint64_t n1, n0, r, q;
     bool ret;
@@ -879,7 +882,7 @@ static bool frac64_div(FloatParts64 *a, FloatParts64 *b)
     return ret;
 }
 
-static bool frac128_div(FloatParts128 *a, FloatParts128 *b)
+static bool frac128_div(FloatParts128 *a, const FloatParts128 *b)
 {
     uint64_t q0, q1, a0, a1, b0, b1;
     uint64_t r0, r1, r2, r3, t0, t1, t2, t3;
@@ -926,22 +929,24 @@ static bool frac128_div(FloatParts128 *a, FloatParts128 *b)
     return ret;
 }
 
-static bool frac64_eqz(FloatParts64 *a)
+static bool frac64_eqz(const FloatParts64 *a)
 {
     return a->frac == 0;
 }
 
-static bool frac128_eqz(FloatParts128 *a)
+static bool frac128_eqz(const FloatParts128 *a)
 {
     return (a->frac_hi | a->frac_lo) == 0;
 }
 
-static void frac64_mulw(FloatParts128 *r, FloatParts64 *a, FloatParts64 *b)
+static void frac64_mulw(FloatParts128 *r,
+                        const FloatParts64 *a, const FloatParts64 *b)
 {
     mulu64(&r->frac_lo, &r->frac_hi, a->frac, b->frac);
 }
 
-static void frac128_mulw(FloatParts256 *r, FloatParts128 *a, FloatParts128 *b)
+static void frac128_mulw(FloatParts256 *r,
+                         const FloatParts128 *a, const FloatParts128 *b)
 {
     mul128To256(a->frac_hi, a->frac_lo, b->frac_hi, b->frac_lo,
                 &r->frac_hi, &r->frac_hm, &r->frac_lm, &r->frac_lo);
@@ -1041,7 +1046,8 @@ static int frac256_normalize(FloatParts256 *a)
     return ret;
 }
 
-static void frac64_modrem(FloatParts64 *a, FloatParts64 *b, uint64_t *mod_quot)
+static void frac64_modrem(FloatParts64 *a, const FloatParts64 *b,
+                          uint64_t *mod_quot)
 {
     uint64_t a0, a1, b0, t0, t1, q, quot;
     int exp_diff = a->exp - b->exp;
@@ -1124,7 +1130,7 @@ static void frac64_modrem(FloatParts64 *a, FloatParts64 *b, uint64_t *mod_quot)
     a->frac = a0 | (a1 != 0);
 }
 
-static void frac128_modrem(FloatParts128 *a, FloatParts128 *b,
+static void frac128_modrem(FloatParts128 *a, const FloatParts128 *b,
                            uint64_t *mod_quot)
 {
     uint64_t a0, a1, a2, b0, b1, t0, t1, t2, q, quot;
@@ -1353,12 +1359,14 @@ static void frac256_shrjam(FloatParts256 *a, int c)
     a->frac_hi = a0;
 }
 
-static bool frac64_sub(FloatParts64 *r, FloatParts64 *a, FloatParts64 *b)
+static bool frac64_sub(FloatParts64 *r,
+                       const FloatParts64 *a, const FloatParts64 *b)
 {
     return usub64_overflow(a->frac, b->frac, &r->frac);
 }
 
-static bool frac128_sub(FloatParts128 *r, FloatParts128 *a, FloatParts128 *b)
+static bool frac128_sub(FloatParts128 *r,
+                        const FloatParts128 *a, const FloatParts128 *b)
 {
     bool c = 0;
     r->frac_lo = usub64_borrow(a->frac_lo, b->frac_lo, &c);
@@ -1366,7 +1374,8 @@ static bool frac128_sub(FloatParts128 *r, FloatParts128 *a, FloatParts128 *b)
     return c;
 }
 
-static bool frac256_sub(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
+static bool frac256_sub(FloatParts256 *r,
+                        const FloatParts256 *a, const FloatParts256 *b)
 {
     bool c = 0;
     r->frac_lo = usub64_borrow(a->frac_lo, b->frac_lo, &c);
@@ -1376,24 +1385,24 @@ static bool frac256_sub(FloatParts256 *r, FloatParts256 *a, FloatParts256 *b)
     return c;
 }
 
-static void frac64_truncjam(FloatParts64 *r, FloatParts128 *a)
+static void frac64_truncjam(FloatParts64 *r, const FloatParts128 *a)
 {
     r->frac = a->frac_hi | (a->frac_lo != 0);
 }
 
-static void frac128_truncjam(FloatParts128 *r, FloatParts256 *a)
+static void frac128_truncjam(FloatParts128 *r, const FloatParts256 *a)
 {
     r->frac_hi = a->frac_hi;
     r->frac_lo = a->frac_hm | ((a->frac_lm | a->frac_lo) != 0);
 }
 
-static void frac64_widen(FloatParts128 *r, FloatParts64 *a)
+static void frac64_widen(FloatParts128 *r, const FloatParts64 *a)
 {
     r->frac_hi = a->frac;
     r->frac_lo = 0;
 }
 
-static void frac128_widen(FloatParts256 *r, FloatParts128 *a)
+static void frac128_widen(FloatParts256 *r, const FloatParts128 *a)
 {
     r->frac_hi = a->frac_hi;
     r->frac_hm = a->frac_lo;
-- 
2.43.0


