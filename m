Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B1ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAJ-0002sN-HC; Mon, 09 Sep 2024 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAI-0002mk-8e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAG-0007jz-Gt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2068acc8b98so41331105ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898975; x=1726503775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkXBvyX56rezRPuXpFz/dXJhKRh6RJ5INCTz9rG8X5g=;
 b=Yj5jeshkmtI/So4cnhKkjy95PMFLfE0cSDsL6fijmd8oQWcnDvDoWo+cWqT6iw3Ue9
 Wv/3c7fkc6QhaIrnF/hyOsTTj4JB3MvqiWKAObQtbqkqY1fqpHF1oQQojUecHo2JZieO
 SaHAkHjIqM+uMQQkjlQBPJcbXiDTV2NNvgX+sOcc7kYb33iCRq7ujvm9zbzd5ICqKSiV
 LtLrtCaRhZS9E5PkllIUTNTzImMk40eADpzzTuumFGVqWkdteU7ZWFjEXSVZWQA3MDON
 RTRfYLk+XSLdRpLvoOtBHb5M8EE3AA1uypI5kklm0BVGAKiJ7vnaTUutyPIyD6ZrSRPn
 iYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898975; x=1726503775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkXBvyX56rezRPuXpFz/dXJhKRh6RJ5INCTz9rG8X5g=;
 b=keWMa7Rf0KuUqr64qLbvCDDXzcryEBjhdau6+CXgfQUkXxFeebIhx59J+rm/m6zhxM
 o2si4NRdHgIxFOPNLqKBVoYAVgeETY9+87aVdCmu8nzqb3Xq3wdT6qYLH8MqsK1KoWY1
 gDkrcK1BGIkejk6Xl2CBMLzdscoNbXt3sAJYe2gKaLyov26W/ZkIXujbPlPfpa5WHXDT
 woS458n3AiP8py4EH+0Ovn6qh6C1mqx5fdJ5ysPlOYKRTOiw2wilMMLyCjHhEv9OzEB4
 gfhiAYyjR05nWQ/vVTx82dfQ8k400x9EVgKnxUQVcNLWriLo91Zrqe4f9Msj+vqZgS/D
 wkRA==
X-Gm-Message-State: AOJu0Yz9ESrbCYftW+lAjOHmkZQ5LZtL1G0PF/iA8KoT8r3NxfA/60Xf
 Y2hS9sMZbbF/OBvKJaXvkxkTULngMfzO9wyVnijkmX19PUNjIowHq9EowBJAAZokFmpQb5oEoIg
 E
X-Google-Smtp-Source: AGHT+IFSHZLdVnZIMDBYlzNDinx6jPOq7wRn1mYY2t9SLn/JE1i1IVE8J6+V2acFi2DFUDR4qephQg==
X-Received: by 2002:a17:902:d483:b0:200:abb6:4daf with SMTP id
 d9443c01a7336-2070c1073c8mr102930145ad.39.1725898975079; 
 Mon, 09 Sep 2024 09:22:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/29] target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
Date: Mon,  9 Sep 2024 09:22:24 -0700
Message-ID: <20240909162240.647173-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Handle the two special cases within these new
functions instead of higher in the call stack.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 19 +++++++++++++++++++
 target/arm/tcg/translate-a64.c  | 16 +---------------
 target/arm/tcg/translate-neon.c | 25 ++-----------------------
 4 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3f0e9ceaa3..45990ae292 100644
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
index c5fc1b6cfb..33c5084ea6 100644
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
index 53022f4fc0..032bd33650 100644
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
index 13cd31aad4..a31a78c347 100644
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
2.43.0


