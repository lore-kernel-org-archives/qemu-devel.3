Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C129AC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMgq-000782-GK; Fri, 24 Jan 2025 11:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZa-00065c-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-0005pY-LP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283d48so16770405e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736203; x=1738341003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KUOVCjsqK9P972q7q40ePDcGfBy7iqRLI3g1W6aCg3E=;
 b=tsRBJL1qQ+rGlAs/eUK4Wtm0TkWIiXYOhvEWI/EIhRAveKQkwQZKhuzdOD3YrhI2kz
 6S/cTYreYpjh9nJNetFH6qGgoNqo49QP4r9uZUSs6MFaOiF6cxNuoPD300F6a2OsKCKC
 bAbZA/8xunfb4Fsq7HRJ1OUtPvci6XcpAXF1gcvr0/gFsXWXlF+o0F4aVhYEazbqBjdM
 ghrvasx4dtgJbkhlP0BXkrwAm/HByezGIH81a62v6ULZwt+u8j9xTLUDfVnwx0UCCaW8
 OxUr6GMWqJMQmPSdkjfhR+N1YEAisva9833ZT/0BhNUriIIdM3p2bEmOs8p/0Alhfk0z
 /t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736203; x=1738341003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUOVCjsqK9P972q7q40ePDcGfBy7iqRLI3g1W6aCg3E=;
 b=L3/ZfXoKdLqGm2oS9zw8p/N3OqKHxKy3GQNchj7FDz1Xwhb9O/pI0ev+yqmk9A2Bpt
 veZSzNEp8CnEaIZlte+ArgBlrqZOHf12LhLjelzAPG5nMBYVR0zuLhethSizRH8573lG
 5s9/I2kWKfwrALWzxJjNmusGWMYCJDslJ+dj7bDjMeHhC93EzrGAOaKV4XKCpPom1bOX
 d4Ee8N9ylBcAn9GYWumlnfkZmnoJI1kDhk5aWrWQ8W4eTa/CqLOl0gKwdVaO5sszCJKn
 TTC2djecyK2KC0JCEyWIvr6xaAqnillbRhths9N8TkP9/B+hvTWrwcnm7CqjAuolgPGQ
 KD+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmXitjxJbuxgRsJuK3l6b26LO5QE7TQfJbgSRGL6bMAlBKuS8KRQKO3+HRcazSN29nnh0lqWd8KoIy@nongnu.org
X-Gm-Message-State: AOJu0YwWJi6LE0fEzbPL5ob2crAmHP74VBKcasEJvDGRKw1zfwwRQPOA
 fOIv9jTMh9zr/oh686xVSUQWD9inkF4mPJ6BtC6eTVH44Ac3Y1JuDEPk2/uhZoIJH7cK2QGPbc4
 Y
X-Gm-Gg: ASbGncvndc4DAUAaGAfGwOuZO3DLBcHqaFniuhxtCyBXBv2qbquOgh+ijFrpH3qW/LA
 E1bETzcVKsGYS7T3cvYha8i/gI4YYlROTgTh3CmFJlqx5qeo54TMyt8wZmiovfjlA8HE64wbC6k
 PhvY0Ow8WLfZiWc1wKJfEuoTcx6NXjenzrBixy5C0QaQcf2+OK8N/ckDEETfQ6l0lRA2RnHjCFs
 xHoeYaqWLHqHcJXhm4iVDcd/PRrtk4/wfVZ0U8fGRcSShw9TDF33Cm/H/2HhoOn0aY+UGA7Jtrc
 QPc1ILoefoE=
X-Google-Smtp-Source: AGHT+IHwhWPGOFxghycHSN0YT4AYdMPDbMR38SLMJwAcr9sucXl4B6KaYd+/9j/jz4Wq8y36KynDeA==
X-Received: by 2002:a05:600c:1da8:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4389eca3ca1mr301479515e9.17.1737736202805; 
 Fri, 24 Jan 2025 08:30:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:30:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 67/76] target/arm: Handle FPCR.AH in SVE FTMAD
Date: Fri, 24 Jan 2025 16:28:27 +0000
Message-Id: <20250124162836.2332150-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The negation step in the SVE FTMAD insn mustn't negate a NaN when
FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field
and use that to determine whether to do the negation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 21 +++++++++++++++------
 target/arm/tcg/translate-sve.c |  3 ++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a39a3ed0cf9..3f38e078291 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5143,13 +5143,16 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
         0x3c00, 0xb800, 0x293a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float16);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float16 *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i++) {
         float16 mm = m[i];
         intptr_t xx = x;
         if (float16_is_neg(mm)) {
-            mm = float16_abs(mm);
+            if (!(fpcr_ah && float16_is_any_nan(mm))) {
+                mm = float16_abs(mm);
+            }
             xx += 8;
         }
         d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
@@ -5166,13 +5169,16 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
         0x37cd37cc, 0x00000000, 0x00000000, 0x00000000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float32);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float32 *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i++) {
         float32 mm = m[i];
         intptr_t xx = x;
         if (float32_is_neg(mm)) {
-            mm = float32_abs(mm);
+            if (!(fpcr_ah && float32_is_any_nan(mm))) {
+                mm = float32_abs(mm);
+            }
             xx += 8;
         }
         d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
@@ -5193,13 +5199,16 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
         0x3e21ee96d2641b13ull, 0xbda8f76380fbb401ull,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float64);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float64 *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i++) {
         float64 mm = m[i];
         intptr_t xx = x;
         if (float64_is_neg(mm)) {
-            mm = float64_abs(mm);
+            if (!(fpcr_ah && float64_is_any_nan(mm))) {
+                mm = float64_abs(mm);
+            }
             xx += 8;
         }
         d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2d70b0faad2..26bdda8f96e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3682,7 +3682,8 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
     gen_helper_sve_ftmad_s, gen_helper_sve_ftmad_d,
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
-                        ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
+                        ftmad_fns[a->esz], a->rd, a->rn, a->rm,
+                        a->imm | (s->fpcr_ah << 3),
                         a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 /*
-- 
2.34.1


