Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09865FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjE-00078M-7f; Sun, 26 Apr 2026 09:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzix-00070W-Ci
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:39 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGziv-0008N6-B0
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:39 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so5286667a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210835; x=1777815635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPMUzDzHKRYKX/hzV0qTrhYipGFAxbdzi8RMy7dDcLg=;
 b=AyVT8ivfhsJpfZ5ira+mMuVH+swu5pN72HikEMm8akGenOHVEAIdps41IqUIFcExFp
 kMgudPdi0Z0AbSfCJss4K3YUGbcgXYQVbilYTfb1M7YRSXHOYsUz9XPCxJBAs5B1ClSA
 FM4vzvhqxx8/I71ZVMt57+0h9MF1NMyYxMlB/GHvokt+25ZZnLR14YKFPRHAMRWsATlx
 2+frLvsbF4oBfx3cNOdSYokit3LdDqutkjSr3hdmtf4pp/NSHm5/hjfg+ix17wrnLG12
 4tUMntMDpxONGB+PpFIm9ui8zl3rX/AIOtJ7tUK06fnTEQpeC/2kZH2mVKfGb1bHR8wN
 d1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210835; x=1777815635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPMUzDzHKRYKX/hzV0qTrhYipGFAxbdzi8RMy7dDcLg=;
 b=tFTt9nypAqkqnc7CT1sMQNgBydgmY0r42JdRpZQD3KDyVT9je+ZdscEj2pAChP7ntt
 PLnw0BW+ssfe2IcO3IL4RhpjhswSCD357zQ5CZ31FxM1Wvs4BWn7Lm/HiV4rXLqei0lh
 f3eF32J6Q1VLiNPeoYX1vj8+kgEY/Xfm5q7/qXt62+gP6x7hn0/liaj3XCwtOu4r1he/
 mnjkLfFgiszTY+7x9A0dYaGRU6H5GyKHJ7sJnsCHpGvRi0KBCMzyTpnvS2wMQqH+2i2T
 gEVqfaiDYLj67FWZIHWFKitWMjlhSL7H5nlaiB+O/tgyiEc72t/hVGvkwwoOl++hyGxN
 FwNA==
X-Gm-Message-State: AOJu0YwgaSW+f2sHwYEKT3gt0fLDWyHwnsC6IHYQ7LLFfVUaZYcZSxWn
 pCszwFolbzccfpgAsidshU72s5XRuyDIFvHMKqYTw0jkrCyvMoryGQ7xChgHS/wRF7PqdR0QVFM
 fYWH+y0Y=
X-Gm-Gg: AeBDiesRCEh5vVupuSHNN4RalHNlfGF0oPQKCex/rWw+59NHn4UIDKaGV4goCs3LMlM
 3Fqc1cU7xLZzXhfPOlwI5MPfSmASx3h1Lsm0QLSVVQaT/AeHL+kjncyyThsCw2cjgn4y2qw1zJi
 l+555tWNfB9AT95/OW8ULpXPhDeNu3a9WpYc2lWaSLfw8F1EKeCTPfysmOgdlYTfywNZmBHGUL2
 jdwP98igfWqI73vCi2ieTH7imXsPBtqpia7n7XAs+yK+MX1boGNdUkTZRJE68JMcI9JTObVXDaP
 42hvZWpHC5l0I4yKsaGubandlAQysdXzMLpV0stFY3meszQaCCur9KSWoJ1Y9U7e0rbqKG3DSl8
 KKSJ7Mw4E7qGlOkpUaR9FAvoOPHEG9OnGL5Eq2Rte1E6TbT+ebMWMiHrwiEI6Vz0Myw2tzxi1eO
 8HSVq6eVq9oTCaIxgeWQ8IgDCa9pLAFKd6XaO5dZLl
X-Received: by 2002:a17:902:8f90:b0:2b4:5f96:184d with SMTP id
 d9443c01a7336-2b5f9e5da53mr294550925ad.5.1777210834983; 
 Sun, 26 Apr 2026 06:40:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 10/84] fpu: Drop parts_{add,sub}_normal
Date: Sun, 26 Apr 2026 23:38:47 +1000
Message-ID: <20260426134002.865628-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop the forward declarations and the _Generic macros.
Add partsW() for use by muladd_scalbn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 16 ++--------------
 fpu/softfloat-parts.c.inc | 12 ++++++------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index aa96ac530d..117c335d66 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,20 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
-static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
-static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
-
-#define parts_add_normal(A, B) \
-    PARTS_GENERIC_64_128_256(add_normal, A)(A, B)
-
-static bool parts64_sub_normal(FloatParts64 *a, FloatParts64 *b);
-static bool parts128_sub_normal(FloatParts128 *a, FloatParts128 *b);
-static bool parts256_sub_normal(FloatParts256 *a, FloatParts256 *b);
-
-#define parts_sub_normal(A, B) \
-    PARTS_GENERIC_64_128_256(sub_normal, A)(A, B)
-
 static FloatParts64 *parts64_addsub(FloatParts64 *a, FloatParts64 *b,
                                     float_status *s, bool subtract);
 static FloatParts128 *parts128_addsub(FloatParts128 *a, FloatParts128 *b,
@@ -1635,6 +1621,7 @@ static const uint16_t rsqrt_tab[128] = {
 };
 
 #define partsN(NAME)   glue(glue(glue(parts,N),_),NAME)
+#define partsW(NAME)   glue(glue(glue(parts,W),_),NAME)
 #define FloatPartsN    glue(FloatParts,N)
 #define FloatPartsW    glue(FloatParts,W)
 
@@ -1660,6 +1647,7 @@ static const uint16_t rsqrt_tab[128] = {
 #undef  N
 #undef  W
 #undef  partsN
+#undef  partsW
 #undef  FloatPartsN
 #undef  FloatPartsW
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index e1ce2be924..6e1800b117 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -541,7 +541,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     if (a->sign != b_sign) {
         /* Subtraction */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            if (parts_sub_normal(a, b)) {
+            if (partsN(sub_normal)(a, b)) {
                 return a;
             }
             /* Subtract was exact, fall through to set sign. */
@@ -574,7 +574,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     } else {
         /* Addition */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            parts_add_normal(a, b);
+            partsN(add_normal)(a, b);
             return a;
         }
 
@@ -760,8 +760,8 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         c_widen.exp = c->exp;
 
         if (a->sign == c->sign) {
-            parts_add_normal(&p_widen, &c_widen);
-        } else if (!parts_sub_normal(&p_widen, &c_widen)) {
+            partsW(add_normal)(&p_widen, &c_widen);
+        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
             goto return_sub_zero;
         }
     }
@@ -1869,9 +1869,9 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
     f.exp = f_exp - frac_normalize(&f);
 
     if (a_exp < 0) {
-        parts_sub_normal(a, &f);
+        partsN(sub_normal)(a, &f);
     } else if (a_exp > 0) {
-        parts_add_normal(a, &f);
+        partsN(add_normal)(a, &f);
     } else {
         *a = f;
     }
-- 
2.43.0


