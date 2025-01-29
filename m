Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B572C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx33-0000w2-BW; Tue, 28 Jan 2025 20:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2z-0000tP-Is
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:17 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2x-0003Yr-8R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:17 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21644aca3a0so147261225ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114754; x=1738719554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJTNbmpjm1t2F0hdmChz/KqvE/wI6eg6xILc2dV+/BY=;
 b=jxyN8QYiqwFkmpiUmH9xAE8FHa746e73uhOpeTOZ3xvgDJ7dA2SP6vmwHPw379LLyj
 JLCtSU7ddiYVF8nij57Xc8As5uSFONLcGf2avpCbl48kCV9U0Bw5hDyrKkfClrXa2wqJ
 jJoCUzOwbomImiox3nGQGF1MW3o83Tm0ydaGYeVFlgOjKZbkxjUAB6Tg17jkR5iPzyMR
 j1+NI29Y7ahMowN5PmTFo6qrw1DSrgKKF2aYJuFki8JMUmrc0I3AnaVidSpxiAdJ5LEf
 KuVfeURE+/ke0AFcp48vuo2e2muiijHS6Qln7UK9kV3izI5CB2AsqqoJqgwIJ1Pv6Yfy
 iAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114754; x=1738719554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJTNbmpjm1t2F0hdmChz/KqvE/wI6eg6xILc2dV+/BY=;
 b=U67uPK5tYt4gMx6VlBkJIgTlUQtW5DyYaic4h0b5FdT6Xp9lp8TOQ8modbmVtBdYJt
 ww75PK1BmHrWR0dNEtYfKpZs5x7pRJfl7rKmTTmxT5i0XOkCcGNLzqIrA7HnfNnLTsQZ
 uS1Hdt9K8MQ84DJSuFmI8xaPUyS/0L1MIVrjQPxLMWGbmvDmMUBrI6FTJdnoByXcPRkT
 IiZRbrQ9iEmcA4pznPxPhoVATg4WpVjcCIMdS5xag1MmJhJo9R5336H+sqWBZAy49Sin
 kgsiFd+D6ME1Mbg5373adXqR4E0U8lHFXjw4D+Xey2BoJ9trpg9fgyEIAX0MFI66z3ho
 w97A==
X-Gm-Message-State: AOJu0Yztr9ZrTv0JArRjY3WO56VQRmk3NLZ9XiC7VPfEJgxZEBmovUvd
 rJoe5xAQliHEidNTA+KKWG3/oDOPDdqFajvxoMBDZz3Y8JedR/UNZqUN8Ul3Ny0EUDsI+Yvkvqj
 h
X-Gm-Gg: ASbGnctdIiwdPWBmy27i+QRlh4NBD1lHOyVJyY468qS/16l7hdjTfnwJ7f1nIUAG7E2
 LwoiyZtytLNUcscDxnbZA8X1yclvALNUc9KFi09gBF56y3zynOkgR23Bx5lh4PwzVL4GbCVd9FX
 P8j4hcoGbL+Ue6QgYaYuWeZcX/hjA3/i5hVB7rMLwFyd1Czg2Hd0xe43fqWg1bR5ui9SA637Hh2
 lK2BAK6jduJ0SVJ3W83EFfgwoRQA4w1+ZDI7Q9BwpbvmUqM10BiBtmQ+Y9LSyq2GK8TKZpRZBqK
 ZmvTlO8dnskfXTDlgIMZhwH27RY+JrZInKEL5Qnuahs+3arZYFIvuZ3MUsoq
X-Google-Smtp-Source: AGHT+IHBAeLR10K0ZtSVs0fsqvGuHL27TY92W8sG8+M3fiEEU9dcFmjcJmlKa0IEyBd6a02kHlV3yA==
X-Received: by 2002:a17:902:dacb:b0:216:1357:8df8 with SMTP id
 d9443c01a7336-21dd7de15famr19978355ad.43.1738114753973; 
 Tue, 28 Jan 2025 17:39:13 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 22/34] target/arm: Use flags for AH negation in
 do_fmla_zpzzz_*
Date: Tue, 28 Jan 2025 17:38:45 -0800
Message-ID: <20250129013857.135256-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The float*_muladd functions have a flags argument that can
perform optional negation of various operand.  We don't use
that for "normal" arm fmla, because the muladd flags are not
applied when an input is a NaN.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

Since we have separate helper entry points for the various
fmla, fmls, fnmla, fnmls instructions, it's easy to just
pass down the exact values required so that no conditional
branch is required within the inner loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 93 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a1f7743221..a01613f079 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4814,7 +4814,7 @@ DO_ZPZ_FP(flogb_d, float64, H1_8, do_float64_logb_as_int)
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint16_t neg1, uint16_t neg3, bool fpcr_ah)
+                            uint16_t neg1, uint16_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4826,16 +4826,10 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float16 e1, e2, e3, r;
 
-                e1 = *(uint16_t *)(vn + H1_2(i));
+                e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
-                e3 = *(uint16_t *)(va + H1_2(i));
-                if (neg1 && !(fpcr_ah && float16_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float16_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float16_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
+                r = float16_muladd(e1, e2, e3, flags, status);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
@@ -4845,48 +4839,51 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint32_t neg1, uint32_t neg3, bool fpcr_ah)
+                            uint32_t neg1, uint32_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4898,16 +4895,10 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float32 e1, e2, e3, r;
 
-                e1 = *(uint32_t *)(vn + H1_4(i));
+                e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
                 e2 = *(uint32_t *)(vm + H1_4(i));
-                e3 = *(uint32_t *)(va + H1_4(i));
-                if (neg1 && !(fpcr_ah && float32_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float32_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float32_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
+                r = float32_muladd(e1, e2, e3, flags, status);
                 *(uint32_t *)(vd + H1_4(i)) = r;
             }
         } while (i & 63);
@@ -4917,48 +4908,51 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint64_t neg1, uint64_t neg3, bool fpcr_ah)
+                            uint64_t neg1, uint64_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4970,16 +4964,10 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float64 e1, e2, e3, r;
 
-                e1 = *(uint64_t *)(vn + i);
+                e1 = *(uint64_t *)(vn + i) ^ neg1;
                 e2 = *(uint64_t *)(vm + i);
-                e3 = *(uint64_t *)(va + i);
-                if (neg1 && !(fpcr_ah && float64_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float64_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float64_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint64_t *)(va + i) ^ neg3;
+                r = float64_muladd(e1, e2, e3, flags, status);
                 *(uint64_t *)(vd + i) = r;
             }
         } while (i & 63);
@@ -4989,43 +4977,46 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 /* Two operand floating-point comparison controlled by a predicate.
-- 
2.43.0


