Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA07C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE5-0008Mc-If; Fri, 04 Jul 2025 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE0-0008J2-JK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDy-00067H-O8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso7850505e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646317; x=1752251117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PcqEQ5aYdp2E4FjnhQYUUiKF9jfZH90kYn9RZsT1ETo=;
 b=qefEFw2SMETwi6+kjAu7sCMDFvYND5p8vL8nvJLUbR0U5wYSyvRH9wxrd3+XSIy7Wq
 ThcYAWaiDUW2/nAFxAi9YnJrBpyia3Gjvdj33DnZoUB/s2SlHPrwgw9h/1VUEE2ZEYN0
 T1ba2RSNqo+5X8o00NkKCFoE/cIiNTig7KxmWgufDrNerduMa/qGuHHR62fFrZz+11m/
 ELe1rrTNx1iU31vshlg++1FnBo7eG65TBUeWQab5u8hXuR1J6IzI1t0nbukq9LAp5vTG
 ckjTwzMhVyEHx02d9ssnOB6y2HxeuUrWTirgu2BRV/J6aMVGRFHuM90r+o1eWod6UUTW
 Oz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646317; x=1752251117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcqEQ5aYdp2E4FjnhQYUUiKF9jfZH90kYn9RZsT1ETo=;
 b=xBuC7uny6HJahN1Fg1n97Y4y8cKgAYad12hE3JDTosgvNK4IA1BRQmZ4rD5ffui94N
 nVrEf5bS4kZTeaUzdSGg4bnN8Ud4m1Y+YQJIu/qTSsEJpj3M99nm9gPB/911OmBiGzp7
 SbruywWZWYH2sUPz3CFF6P8EUzyZVN91ZogF9rafZpLcZDGEaQFdSO7OkUnEMjWqK88K
 K2BJZFBCOVLljd7KCpy7pNJVVj2k8C6S/QggQJG18YkREwm98ionpepdjKeDkoqCpmMU
 HNxvZ2vM1wSMg01hwMWQzafW8zCc0ofQlC77olAfDR15OKNxnAPiAWEl3Qc1bdmtXz8f
 lKYg==
X-Gm-Message-State: AOJu0YwAno+nl070hcthxFk5APXKC3dgTG+s0s6rE49KTfvUYgXm4BDj
 fboLWffx+/37rciUikgVtqJxYZyT4MaKV1WSF7fgNCYw3EitdOI98I8aasdjBv7pR8bZ1FB/uJW
 xUE1u
X-Gm-Gg: ASbGncuUiO3yV/Hiq8gJC7kVWv3ReVhF36owFrz/OP4HJJK3tDodTmOzn2UXzTAlFwy
 3LZVBP3Gb5ekRTQ6NT2HrkIWY7mmai+5z+qYVidiP1gvLY+19RmyddxJ142G40aVpa6RJROWHF6
 gwyUn7URP1KjB6J083ggyvLUYHqwiKtLPWjViRG5QhSn4uTBsXaYdil9WebkDR0zzoapO0zX9u2
 tOST5DkaEHURAk5l2TuyZQrkVbQYI70L4QFusqOxJ3hpffaLsGmVKBTO+h+b5Z0pKOxZVQTpnoR
 pQKZsjlLpuQOdTfS0i5ZLex9ddk+q5tvtMwx+2xL1gYzloiuhiEzTj8tKIwS1H2GxSAT
X-Google-Smtp-Source: AGHT+IE3OSMiZZRlY6gmKtMCZsEvupCwB1AmoRa5qKe1TNF5E7o0xKmtDmwpO8KbKJwDrykbW3260g==
X-Received: by 2002:a05:600c:1d27:b0:453:9317:8aa0 with SMTP id
 5b1f17b1804b1-454b3195611mr30009195e9.32.1751646317276; 
 Fri, 04 Jul 2025 09:25:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 015/119] target/arm: Fix 128-bit element ZIP, UZP, TRN
Date: Fri,  4 Jul 2025 17:23:15 +0100
Message-ID: <20250704162501.249138-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

We missed the instructions UDEF when the vector size is too small.
We missed marking the instructions non-streaming with SME.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 43 ++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f3cf028cb92..588a5b006b8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2352,6 +2352,23 @@ TRANS_FEAT(PUNPKHI, aa64_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
  *** SVE Permute - Interleaving Group
  */
 
+static bool do_interleave_q(DisasContext *s, gen_helper_gvec_3 *fn,
+                            arg_rrr_esz *a, int data)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        if (vsz < 32) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                               vec_full_reg_offset(s, a->rn),
+                               vec_full_reg_offset(s, a->rm),
+                               vsz, vsz, data, fn);
+        }
+    }
+    return true;
+}
+
 static gen_helper_gvec_3 * const zip_fns[4] = {
     gen_helper_sve_zip_b, gen_helper_sve_zip_h,
     gen_helper_sve_zip_s, gen_helper_sve_zip_d,
@@ -2361,11 +2378,11 @@ TRANS_FEAT(ZIP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(ZIP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, vec_full_reg_size(s) / 2)
 
-TRANS_FEAT(ZIP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a, 0)
-TRANS_FEAT(ZIP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a,
-           QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
+TRANS_FEAT_NONSTREAMING(ZIP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a, 0)
+TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a,
+                        QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
@@ -2377,10 +2394,10 @@ TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(UZP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 0)
-TRANS_FEAT(UZP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 16)
+TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 0)
+TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 16)
 
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
@@ -2392,10 +2409,10 @@ TRANS_FEAT(TRN1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(TRN2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(TRN1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 0)
-TRANS_FEAT(TRN2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 16)
+TRANS_FEAT_NONSTREAMING(TRN1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 0)
+TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 16)
 
 /*
  *** SVE Permute Vector - Predicated Group
-- 
2.43.0


