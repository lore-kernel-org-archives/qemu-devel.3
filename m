Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1A3CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwl-0006HF-Ig; Thu, 19 Sep 2024 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwR-000597-EW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwM-000134-Ob
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso7634895e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751480; x=1727356280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7scyfkuSJmy4vO3ArcLRWxGnGFS5Tga2npXVxbFfSXI=;
 b=gSGIETtnJj499svUM6UhSUYvSrIM3gzUPR9weUsGqXRuoS/FXUbKjyVgwyp9oIObNC
 p41vBryIzq2Xk2FC2ZOdsCklzgraoYJpcuzyg0/FVgw7N/Io8iW2FRE4yd2uClOH/8Pt
 04v4Pq0h5i9IKH1RgdthV7pVPVOxMh2H1SeSZseQwd+BgqQutYx64QnQUWNdlusH82LH
 A6+9NMmLU3iDKPibJEDRYVrSw8f9rNF171ZWVUx6CoB/Ul+B5TIB/4XguF+GGx3vuHcd
 vnE5NkJeom7rOJIzaIpYx9Nqs6A1lk8mKsI5dQrJGzEsVrEmCxPsHGnfK3WhH8+AXi4V
 PF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751480; x=1727356280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7scyfkuSJmy4vO3ArcLRWxGnGFS5Tga2npXVxbFfSXI=;
 b=gaN9JgVVtfOa9iJnAM2wJDO9MYY9kwbmxF0fUKklzjcEY1il8/l3F8H4PBJZkU0lHX
 BPji5bjgUfBolEgRftwNK9m39sFKYMIgOUeE3mR5jEE3ZsqD/UKxk55jsDGWSbCRPUTI
 O2mLNTPC+CSW27GBOQwPIsYdIAg4b1enhkJTWLDPms58uTEEd82bv0HBJvNrqj7Vezq5
 g+1Zzn8d/p0XpLw4nM/lDseiI3oQh0FjJeYA4QLDL7jgmQbTMEAQGMCesNV9NEH+M3zR
 PBGBNG9fneGzWn8eIcV9gNhDuo7hqSfsd3EjbAmBxdIJ7+yq0VD/7zILdcERq4zthtMI
 1eeQ==
X-Gm-Message-State: AOJu0Yz45qYiSb1uxE6Q+i8YsoaYWc1CrapBnPEJjYEYnnyEg8kmzJuK
 yc7rBivHQHHFHahdI5heE9la1dQ+yJk1afSDitaDV4s68nS1mev4LhMtpCcYa03ejdwlgWwziDW
 P
X-Google-Smtp-Source: AGHT+IGTweD6xsS3B15oAVZUsA8mqVrRo46h6oSFNRoCwhdQMdycyhN7j0GVGsamh3NZuWIYTJgIKQ==
X-Received: by 2002:a05:600c:45cf:b0:42c:bad0:6c1c with SMTP id
 5b1f17b1804b1-42cdb54e480mr165111785e9.18.1726751480014; 
 Thu, 19 Sep 2024 06:11:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/38] target/arm: Split out subroutines of
 handle_shri_with_rndacc
Date: Thu, 19 Sep 2024 14:10:49 +0100
Message-Id: <20240919131106.3362543-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

There isn't a lot of commonality along the different paths of
handle_shri_with_rndacc.  Split them out to separate functions,
which will be usable during the decodetree conversion.

Simplify 64-bit rounding operations to not require double-word arithmetic.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 138 ++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 56 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e59236330ad..f4deacd5548 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7019,6 +7019,78 @@ static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
 TRANS(SSHLL_v, do_vec_shift_imm_wide, a, false)
 TRANS(USHLL_v, do_vec_shift_imm_wide, a, true)
 
+static void gen_sshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    tcg_gen_sari_i64(dst, src, MIN(shift, 63));
+}
+
+static void gen_ushr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 64) {
+        tcg_gen_movi_i64(dst, 0);
+    } else {
+        tcg_gen_shri_i64(dst, src, shift);
+    }
+}
+
+static void gen_srshr_bhs(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 32);
+    if (shift) {
+        TCGv_i64 rnd = tcg_constant_i64(1ull << (shift - 1));
+        tcg_gen_add_i64(dst, src, rnd);
+        tcg_gen_sari_i64(dst, dst, shift);
+    } else {
+        tcg_gen_mov_i64(dst, src);
+    }
+}
+
+static void gen_urshr_bhs(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 32);
+    if (shift) {
+        TCGv_i64 rnd = tcg_constant_i64(1ull << (shift - 1));
+        tcg_gen_add_i64(dst, src, rnd);
+        tcg_gen_shri_i64(dst, dst, shift);
+    } else {
+        tcg_gen_mov_i64(dst, src);
+    }
+}
+
+static void gen_srshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 0) {
+        tcg_gen_mov_i64(dst, src);
+    } else if (shift == 64) {
+        /* Extension of sign bit (0,-1) plus sign bit (0,1) is zero. */
+        tcg_gen_movi_i64(dst, 0);
+    } else {
+        TCGv_i64 rnd = tcg_temp_new_i64();
+        tcg_gen_extract_i64(rnd, src, shift - 1, 1);
+        tcg_gen_sari_i64(dst, src, shift);
+        tcg_gen_add_i64(dst, dst, rnd);
+    }
+}
+
+static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 0) {
+        tcg_gen_mov_i64(dst, src);
+    } else if (shift == 64) {
+        /* Rounding will propagate bit 63 into bit 64. */
+        tcg_gen_shri_i64(dst, src, 63);
+    } else {
+        TCGv_i64 rnd = tcg_temp_new_i64();
+        tcg_gen_extract_i64(rnd, src, shift - 1, 1);
+        tcg_gen_shri_i64(dst, src, shift);
+        tcg_gen_add_i64(dst, dst, rnd);
+    }
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9208,69 +9280,23 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
                                     bool round, bool accumulate,
                                     bool is_u, int size, int shift)
 {
-    bool extended_result = false;
-    int ext_lshift = 0;
-    TCGv_i64 tcg_src_hi;
-
-    if (round && size == 3) {
-        extended_result = true;
-        ext_lshift = 64 - shift;
-        tcg_src_hi = tcg_temp_new_i64();
-    } else if (shift == 64) {
-        if (!accumulate && is_u) {
-            /* result is zero */
-            tcg_gen_movi_i64(tcg_res, 0);
-            return;
-        }
-    }
-
-    /* Deal with the rounding step */
-    if (round) {
-        TCGv_i64 tcg_rnd = tcg_constant_i64(1ull << (shift - 1));
-        if (extended_result) {
-            TCGv_i64 tcg_zero = tcg_constant_i64(0);
-            if (!is_u) {
-                /* take care of sign extending tcg_res */
-                tcg_gen_sari_i64(tcg_src_hi, tcg_src, 63);
-                tcg_gen_add2_i64(tcg_src, tcg_src_hi,
-                                 tcg_src, tcg_src_hi,
-                                 tcg_rnd, tcg_zero);
-            } else {
-                tcg_gen_add2_i64(tcg_src, tcg_src_hi,
-                                 tcg_src, tcg_zero,
-                                 tcg_rnd, tcg_zero);
-            }
+    if (!round) {
+        if (is_u) {
+            gen_ushr_d(tcg_src, tcg_src, shift);
         } else {
-            tcg_gen_add_i64(tcg_src, tcg_src, tcg_rnd);
+            gen_sshr_d(tcg_src, tcg_src, shift);
         }
-    }
-
-    /* Now do the shift right */
-    if (round && extended_result) {
-        /* extended case, >64 bit precision required */
-        if (ext_lshift == 0) {
-            /* special case, only high bits matter */
-            tcg_gen_mov_i64(tcg_src, tcg_src_hi);
+    } else if (size == MO_64) {
+        if (is_u) {
+            gen_urshr_d(tcg_src, tcg_src, shift);
         } else {
-            tcg_gen_shri_i64(tcg_src, tcg_src, shift);
-            tcg_gen_shli_i64(tcg_src_hi, tcg_src_hi, ext_lshift);
-            tcg_gen_or_i64(tcg_src, tcg_src, tcg_src_hi);
+            gen_srshr_d(tcg_src, tcg_src, shift);
         }
     } else {
         if (is_u) {
-            if (shift == 64) {
-                /* essentially shifting in 64 zeros */
-                tcg_gen_movi_i64(tcg_src, 0);
-            } else {
-                tcg_gen_shri_i64(tcg_src, tcg_src, shift);
-            }
+            gen_urshr_bhs(tcg_src, tcg_src, shift);
         } else {
-            if (shift == 64) {
-                /* effectively extending the sign-bit */
-                tcg_gen_sari_i64(tcg_src, tcg_src, 63);
-            } else {
-                tcg_gen_sari_i64(tcg_src, tcg_src, shift);
-            }
+            gen_srshr_bhs(tcg_src, tcg_src, shift);
         }
     }
 
-- 
2.34.1


