Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7350CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwi-00063P-0p; Thu, 19 Sep 2024 09:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwO-0004wz-Bw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:24 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwJ-00011e-3K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:21 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f758f84dfbso6799121fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751476; x=1727356276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77EyE8OGWL9B86asGNhTWMqtVOBMqqUs1GAcCB8v5ek=;
 b=HX7+Kvv9wlBz52nNCkX39Qhc7QLEBTZB4SfqFkavGnan9P26LwxT6R8UIgYqLd16rm
 1TFf0bc9mm+BHkT6LaiEwKTWgjDp6M92XLiXuezN7762PDcXYp78yd10aALzAH5KxccG
 3u4OIrA5eMTYOxXrt6upn9kdtwWuWAFaNd5mTJIodWrwQ4lS/3UbCGMNkzyARabcaaYq
 cRI5uhtOjq1bizSORioER/ggSwgYKcOMCwOWfqY9o0i5b4GNEqg8bQQXtEs6rw122To3
 Vh9RMhRUd63kk0eSt0R9DNN2s0HftB4ZlvSxjaCh79aqo7mji4C9wxryIqOwq+8kr6RD
 y4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751476; x=1727356276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77EyE8OGWL9B86asGNhTWMqtVOBMqqUs1GAcCB8v5ek=;
 b=kdUiNZkNiOPRTQ3pNyR/eNgvCosKQP3wzUpAyGEt0Cb08CcI06SwsaNXKruThtKF/F
 kvQH4YmtkFFe6Q8bxs/v7Y/VEMJY8Iphkr7qwfQAwOGv3yPHDe6BU6X7vitNR5keFkGK
 ZTPHV7Oo6RHPy4VMqZqGURuyLRbb+JsN+9C763jgiMuO2QL8aVW0gchQboQ0Jk75MSxT
 bPmjGxYDJemr/IfFoDZMKKNCY5O97688wlRH4rTVQvAeQR1eOSuxPsbJO76LhRTgEkiB
 6TGUVvsWyzK8yYnq2KcEJGrPA2fwjfQuoFsBovh1zzOg1vFYHhi2iD5YmZWkTL66Cu3i
 gkyg==
X-Gm-Message-State: AOJu0YwYUIo/aeIfrxBFQL8cApXGJPmiL7XQjk9vZ7shRThqrOF218Lm
 a2jJPI9RbFV9xmijw88dCl9ryA1tLMs7nF5sQvHgaelL5wuGi5nT4wZ0sP1H9vmzrBi/qUfLm6s
 T
X-Google-Smtp-Source: AGHT+IGXuCpjIYDJ6TuqHS4WTdkluEophD5IzUVMpVgAuryLjxnfpgkaR/XkOGC7U/U8KZMaTctgPA==
X-Received: by 2002:a2e:a987:0:b0:2f3:d8dd:a1f6 with SMTP id
 38308e7fff4ca-2f787f505demr158361821fa.40.1726751475789; 
 Thu, 19 Sep 2024 06:11:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
Date: Thu, 19 Sep 2024 14:10:42 +0100
Message-Id: <20240919131106.3362543-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

Handle the two special cases within these new
functions instead of higher in the call stack.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 19 +++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 16 +---------------
 target/arm/tcg/translate-neon.c | 25 ++-----------------------
 4 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3f0e9ceaa39..45990ae2928 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -514,6 +514,11 @@ void gen_sqsub_d(TCGv_i64 d, TCGv_i64 q, TCGv_i64 a, TCGv_i64 b);
 void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ushr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz);
+
 void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
                    int64_t shift, uint32_t opr_sz, uint32_t max_sz);
 void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index c5fc1b6cfbf..33c5084ea64 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -88,6 +88,25 @@ GEN_CMP0(gen_gvec_cgt0, TCG_COND_GT)
 
 #undef GEN_CMP0
 
+void gen_gvec_sshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    /* Signed shift out of range results in all-sign-bits */
+    shift = MIN(shift, (8 << vece) - 1);
+    tcg_gen_gvec_sari(vece, rd_ofs, rm_ofs, shift, opr_sz, max_sz);
+}
+
+void gen_gvec_ushr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                   int64_t shift, uint32_t opr_sz, uint32_t max_sz)
+{
+    /* Unsigned shift out of range results in all-zero-bits */
+    if (shift >= (8 << vece)) {
+        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
+    } else {
+        tcg_gen_gvec_shri(vece, rd_ofs, rm_ofs, shift, opr_sz, max_sz);
+    }
+}
+
 static void gen_ssra8_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
 {
     tcg_gen_vec_sar8i_i64(a, a, shift);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 53022f4fc08..032bd336502 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10452,21 +10452,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         break;
 
     case 0x00: /* SSHR / USHR */
-        if (is_u) {
-            if (shift == 8 << size) {
-                /* Shift count the same size as element size produces zero.  */
-                tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
-                                     is_q ? 16 : 8, vec_full_reg_size(s), 0);
-                return;
-            }
-            gvec_fn = tcg_gen_gvec_shri;
-        } else {
-            /* Shift count the same size as element size produces all sign.  */
-            if (shift == 8 << size) {
-                shift -= 1;
-            }
-            gvec_fn = tcg_gen_gvec_sari;
-        }
+        gvec_fn = is_u ? gen_gvec_ushr : gen_gvec_sshr;
         break;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 13cd31aad42..a31a78c3478 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1099,29 +1099,8 @@ DO_2SH(VRSHR_S, gen_gvec_srshr)
 DO_2SH(VRSHR_U, gen_gvec_urshr)
 DO_2SH(VRSRA_S, gen_gvec_srsra)
 DO_2SH(VRSRA_U, gen_gvec_ursra)
-
-static bool trans_VSHR_S_2sh(DisasContext *s, arg_2reg_shift *a)
-{
-    /* Signed shift out of range results in all-sign-bits */
-    a->shift = MIN(a->shift, (8 << a->size) - 1);
-    return do_vector_2sh(s, a, tcg_gen_gvec_sari);
-}
-
-static void gen_zero_rd_2sh(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
-                            int64_t shift, uint32_t oprsz, uint32_t maxsz)
-{
-    tcg_gen_gvec_dup_imm(vece, rd_ofs, oprsz, maxsz, 0);
-}
-
-static bool trans_VSHR_U_2sh(DisasContext *s, arg_2reg_shift *a)
-{
-    /* Shift out of range is architecturally valid and results in zero. */
-    if (a->shift >= (8 << a->size)) {
-        return do_vector_2sh(s, a, gen_zero_rd_2sh);
-    } else {
-        return do_vector_2sh(s, a, tcg_gen_gvec_shri);
-    }
-}
+DO_2SH(VSHR_S, gen_gvec_sshr)
+DO_2SH(VSHR_U, gen_gvec_ushr)
 
 static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
                              NeonGenTwo64OpEnvFn *fn)
-- 
2.34.1


