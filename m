Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE66C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7U-0002Qd-3b; Tue, 11 Feb 2025 11:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5y-0006lG-JJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5w-0003RZ-4k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dd93a6f0aso2125549f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291202; x=1739896002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ASVY88i2oauOolvO8/0wqltOHxMQRKcsKtCuzMkgfrU=;
 b=KzLRAWuXHMLytuqJaKObffrmTYIVbaBRbMtagkTxbXffCL2s6ftkiblxI4b6g2GzBR
 5q38W/insTR31xQ/BrwN/9biFqVlOZr3tVY3HsyFdFPBn1s0VkeHy3s2hn7MYNoUz8X5
 O1vmo8oUAs6pYOOKsvLDhJEZx5kRI38Kuqb6+wYFCau9gCTUuTpu6pkEv0WpoXivzaCD
 8tdrmUUO5E5BwXzwpKDiEj473SdCjyDwfHwUwhj2W0O0yXYzzRf+QuEbWJ40GxpArLnE
 CETj+HCZxcL/0G8xYqVWlAe0Q19UuPsuGaLsaJ9HDYRPWNhUFHKPUwIfBQpr6nb9fpgy
 Vw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291202; x=1739896002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASVY88i2oauOolvO8/0wqltOHxMQRKcsKtCuzMkgfrU=;
 b=GvxwcLtOJgn2lMpP/qfDDUGpKM1PZpvQvZzp1d7UXQwHM2AeoBAhrFYWJV1WmRTa5w
 0lg3hMW9nfZlAeF3LJeq6vFH3MoWXIiz/Ncex7aOt5qkSfQdpvAo4303sRxhMiBYgMS6
 lJaUzwahHTHgUf7ZRboT1B2UpoL489tAzp5jf1+ECpFq6PI4XHqQZixt3rQFHR+paZHr
 der1O/HxYKs4znIPXkSZj90LxS0SZVECc4bStsf5lXBGsyDT+jWcBL6BGLyiFQOb9GZ/
 zJ2y0edDEn49vQQLs1wIEnkkazXZUc9v1IqmHboNzA08kId8T0ILKMdKZ7gHlIei17fa
 I41Q==
X-Gm-Message-State: AOJu0YzsLdiv7WIArsL8FFAYjbMnD02Y9QnJzJmyQwwdO9wHZaiSIbKw
 0iUw7SHl/Q+Gzf2dyhKNL2jRn1VB4VU4mj6yfpPKughyCF2WPo8Wu0K207lUvoDQ8EVHxG3vd8S
 0
X-Gm-Gg: ASbGncu91DboclvgLBLgvfa2TerpbN8vDI3l3LFCzEnTR1UNo5SDUciTQehFmgMnzV8
 GfiDf/fgL0Bw+yLlQThkFKT7ZqMukFM2f2a4uj8EiP51GpTMb/+lfcxX0PPxPLUWbu95D7SeVG+
 yJ1C6b2PZWGJ0R18olfaiFHN/zMQQxEbvWwNxpEkWjyBIFrI8avK6s7BecMtSXsmm2MCItcmDIK
 DDpvkLuU57IBNtwRmeJRgBihXw83AvJl5HGMzRgU1319NvGc33z4r+xk2lyOqEkaA+nty8NbJyP
 Dtv2uoas2Z2yiI7ZZqei
X-Google-Smtp-Source: AGHT+IF3awg3fFfJLpJeUUSH6Z9ks4udBmNLQHZzuM1pd1Uo09U/KMEENBDpbHzSQcUz7acvfUvNDA==
X-Received: by 2002:a05:6000:18ac:b0:38c:5cd0:ecd5 with SMTP id
 ffacd0b85a97d-38dc9343fc9mr14985304f8f.38.1739291202357; 
 Tue, 11 Feb 2025 08:26:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/68] target/arm: Handle FPCR.AH in SVE FTMAD
Date: Tue, 11 Feb 2025 16:25:30 +0000
Message-Id: <20250211162554.4135349-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The negation step in the SVE FTMAD insn mustn't negate a NaN when
FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field,
so we can select the correct behaviour.

Because the operand is known to be negative, negating the operand
is the same as taking the absolute value.  Defer this to the muladd
operation via flags, so that it happens after NaN detection, which
is correct for FPCR.AH.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++++--------
 target/arm/tcg/translate-sve.c |  3 ++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bf88bde8a31..c12b2600bd7 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5134,16 +5134,24 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
         0x3c00, 0xb800, 0x293a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float16);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float16 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float16 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float16_is_neg(mm)) {
-            mm = float16_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float16_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float16_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5157,16 +5165,24 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
         0x37cd37cc, 0x00000000, 0x00000000, 0x00000000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float32);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float32 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float32 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float32_is_neg(mm)) {
-            mm = float32_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float32_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float32_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5184,16 +5200,24 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
         0x3e21ee96d2641b13ull, 0xbda8f76380fbb401ull,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float64);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float64 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float64 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float64_is_neg(mm)) {
-            mm = float64_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float64_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float64_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2dd4605bb2f..410087c3fbd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3685,7 +3685,8 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
     gen_helper_sve_ftmad_s, gen_helper_sve_ftmad_d,
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
-                        ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
+                        ftmad_fns[a->esz], a->rd, a->rn, a->rm,
+                        a->imm | (s->fpcr_ah << 3),
                         a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
-- 
2.34.1


