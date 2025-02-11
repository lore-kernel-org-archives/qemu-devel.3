Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F54C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7Y-0002pL-Er; Tue, 11 Feb 2025 11:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5x-0006kq-Lx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5u-0003N5-Fk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43957634473so1665325e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291201; x=1739896001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=htYhz0lU1fSw0+mws+bcJcnJI70g4/8lJiqmKbiAD3w=;
 b=cpEXFVBqM5gZ7TW8HZvOmHz6rZtaVyRZlqhoVmFeiRlTQDXCgZsIq0FqpoVRKv0rPO
 T0CYNof2GeEDVyRUtd0P1+/uVDFYYlkrrM3Wcoeb1k1KNW8fSYjINBjEsOZ/+efYxnNE
 VIimmV58SA7aYvxcTqvhsx+2ewdFYIaUate39i/1M8Ytj58835HzbpUkCY5FzjjjMcQR
 X7mCp3Z6GBbQEQ8fazHXZDXbbJUFsouOVDf8+kpfdaWcVpU/Fh9dtchcGAlynFYIoGrB
 AEFTw5I6sJGxTfdhtRG2cuY+306t2tWJ123c2+qEEquBfGM3cvDDHUn93rIXwZ823rpl
 NMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291201; x=1739896001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htYhz0lU1fSw0+mws+bcJcnJI70g4/8lJiqmKbiAD3w=;
 b=L5Smt1ITeEpaVm9fxZ8ZIOLI5qO4700tPICS6aoBzrq64+sxX9tyZwZ8ZuIO+StBsO
 mx9ySknxQ4k1CbFNpe6bLt2+1LdtOIEYnIRJ5iwQHi5sklQbpSX+JuyQCdl5y2o88jCI
 daPyrRFUnxqfhMuZ1BH2MGL120hPE1uSLQWbs6YxNLsh7oTHbGbPuyqK+z+F9oPoSmgR
 PNJdIZZE68T+SR/mNFpcZDnNBM1IJyAGAOrSjhyB1G3Rtd5+fmRFs5TE2kmS1FPhdpEY
 +qo7DM4IcltgABmUFcP398RcJPfAy7ldE0uYjJX/khdIFvoNgmyL4lYmq9UwdQNMJ1ct
 iDfg==
X-Gm-Message-State: AOJu0Yzfi5VbkZ44kAmP4GR9yO4TtMh81VajiOsxTWE5bz95Iw9nMkL2
 gquJ+EPnnUDinsdFIkSyInG9f6YWFoEOOeYc3XPi+j0CGzUHIe9RYK60YRnIFY3svs63sFS5+pz
 w
X-Gm-Gg: ASbGncsNEjbceFVvucpzofDoP3W/cBH2dUJwaWHQIQt7ZTY5IIy4iskoOd3NqKmO+Dy
 Ai/hG1HVLCkkSYlpb3ql3xWqXKOj4B+1vQGj7h80RRqfzb+O4Sm8tEyrrJzKrgjHGMvXVl7Vr0l
 rJrfugHb1Bk63O4wy9bFvaFeGTEwLWPaEqKdf37Gsw4Ab5tDCNhxsEK3eCpln1BKbSSGWRK9f8d
 eszuPWdO/AVNGQWbLQ+LGl4GOWrU15+3RYM6RtfAayQ75UihvVwu/bT5P+bpZOxHQdK/gmCnqUX
 z29WhMc0KqX8qS9b2kuu
X-Google-Smtp-Source: AGHT+IG6hBUp1wHb+0QDsKN43XaTHo4dhX/ESL1GtwmRlbK9kKA9k1NiO7D4ok3PpRc23Hhb5MuQmw==
X-Received: by 2002:a5d:4d42:0:b0:38d:bd82:2f9 with SMTP id
 ffacd0b85a97d-38dc935122cmr12803757f8f.43.1739291200775; 
 Tue, 11 Feb 2025 08:26:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/68] target/arm: Handle FPCR.AH in SVE FTSSEL
Date: Tue, 11 Feb 2025 16:25:29 +0000
Message-Id: <20250211162554.4135349-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The negation step in the SVE FTSSEL insn mustn't negate a NaN when
FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field
and use that to determine whether to do the negation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 18 +++++++++++++++---
 target/arm/tcg/translate-sve.c |  4 ++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 90d4defc0d5..bf88bde8a31 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -2555,6 +2555,7 @@ void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
 void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint16_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint16_t nn = n[i];
@@ -2562,13 +2563,17 @@ void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float16_one;
         }
-        d[i] = nn ^ (mm & 2) << 14;
+        if (mm & 2) {
+            nn = float16_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
 void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint32_t nn = n[i];
@@ -2576,13 +2581,17 @@ void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float32_one;
         }
-        d[i] = nn ^ (mm & 2) << 30;
+        if (mm & 2) {
+            nn = float32_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
 void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint64_t nn = n[i];
@@ -2590,7 +2599,10 @@ void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float64_one;
         }
-        d[i] = nn ^ (mm & 2) << 62;
+        if (mm & 2) {
+            nn = float64_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 17016854d87..2dd4605bb2f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1238,14 +1238,14 @@ static gen_helper_gvec_2 * const fexpa_fns[4] = {
     gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
 };
 TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
-                        fexpa_fns[a->esz], a->rd, a->rn, 0)
+                        fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
 
 static gen_helper_gvec_3 * const ftssel_fns[4] = {
     NULL,                    gen_helper_sve_ftssel_h,
     gen_helper_sve_ftssel_s, gen_helper_sve_ftssel_d,
 };
 TRANS_FEAT_NONSTREAMING(FTSSEL, aa64_sve, gen_gvec_ool_arg_zzz,
-                        ftssel_fns[a->esz], a, 0)
+                        ftssel_fns[a->esz], a, s->fpcr_ah)
 
 /*
  *** SVE Predicate Logical Operations Group
-- 
2.34.1


