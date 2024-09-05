Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1D2CD5BC7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC70-0001Df-Th; Thu, 05 Sep 2024 09:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6u-0000yQ-Cg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001jF-6H
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bbd0a40faso6783195e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541268; x=1726146068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gb8lVmPrQ0oPSchhOZdAI9RN7s16BrWzuHYxkg2Mfqs=;
 b=aQfTejeLUtYQx62GFyZypbn949Z7M4mklvfC2DC71cbbR/g8VQj4k+BXqzYx0wWI+f
 rfkKVuxFL1h5D0MWaMGfysx4lGMylBi76+P/nBmAvyHaVXckN4fkm+SueFpIlVvFpSWn
 hk2P6QBsSpOgrHzDMdxLb2IM0jHxiQl8QbF53JSkKz4+Xgw/G9lmk6o0fSIFj6IIEOvK
 EzQK0MAkuGK0PcenYsTFlzHj+J3YzcLj96IA14c5XYg1srsBLPlJKgvYjA32I5/U8GiP
 FPnMx3LH9335Kg7hyeFrAX9QS2OZT2cq8fsojEUPMW+E6k7dTA4kDS2Sa0+WqqAjuonB
 Qttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541268; x=1726146068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gb8lVmPrQ0oPSchhOZdAI9RN7s16BrWzuHYxkg2Mfqs=;
 b=QRSXKuTniFYxQLqNmMta5JyBnwFQsSUwkp3rdNkE3XhppbXr5z6t8gykfkWnix8wSB
 yM//WvcMR6asas78L2z5ijdN/2gAMoHSXePdLXhYZz7dsps0+cZ8/krw+dgTThYyI3Kp
 ITLeoMoZ2dG7ohaoXT7vOkxQqS5bIXYmBCyOtujkR+JbpgW/iKUiLNM7p4ytxSw4Nl87
 05Q/s+grgEgqLI/T7G5/D0H5xVNc8t5Oi/lc0De0IEnajaIVFitSZ6I8spcT7VDFSU4R
 8OUuU+6NhYWU0EpdVronqDi/68JTv0p892DAxtEP9ZLtoF8ZaPJYRR2iVXVRsex9tm8+
 wpoA==
X-Gm-Message-State: AOJu0YyVA290M789kGGGHGqnmAcStcOC0gHFfPLdb9IxddG2pBWlnupd
 drXbwiaNm2UWBgs28fkQLvRHiI5vN5Oy47MhmIjzkH0tG2JfhH+t4C+052W5VvWmwpfWAGtKp/A
 p
X-Google-Smtp-Source: AGHT+IHZ/09UEH2JGNzPnI9bi5Zd368thDBhzfhBwJyJTtppDHfiC9fspfbgV6e7IQnOfLuybqFf3A==
X-Received: by 2002:a05:6000:1147:b0:374:c283:f7b7 with SMTP id
 ffacd0b85a97d-374ecc8f661mr8584121f8f.21.1725541266702; 
 Thu, 05 Sep 2024 06:01:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] target/arm: Pass env pointer through to gvec_bfmmla
 helper
Date: Thu,  5 Sep 2024 14:00:40 +0100
Message-Id: <20240905130100.298768-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Pass the env pointer through to the gvec_bfmmla helper,
so we can use it to add support for FEAT_EBF16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 4 ++--
 target/arm/tcg/translate-a64.c  | 2 +-
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/translate-sve.c  | 2 +-
 target/arm/tcg/vec_helper.c     | 3 ++-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e197b5b1d2c..b463be38c52 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1032,8 +1032,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c7876513c72..6d5f12e8f55 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5637,7 +5637,7 @@ TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfdot)
-TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfmmla)
+TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector_env, a, gen_helper_gvec_bfmmla)
 TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
 TRANS_FEAT(UMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_ummla_b)
 TRANS_FEAT(USMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usmmla_b)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 7de157c539c..13cd31aad42 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3730,8 +3730,8 @@ static bool trans_VMMLA_b16(DisasContext *s, arg_VMMLA_b16 *a)
     if (!dc_isar_feature(aa32_bf16, s)) {
         return false;
     }
-    return do_neon_ddda(s, 7, a->vd, a->vn, a->vm, 0,
-                        gen_helper_gvec_bfmmla);
+    return do_neon_ddda_env(s, 7, a->vd, a->vn, a->vm, 0,
+                            gen_helper_gvec_bfmmla);
 }
 
 static bool trans_VFMA_b16(DisasContext *s, arg_VFMA_b16 *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index eb77c943c8f..9e2536dfe99 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7137,7 +7137,7 @@ TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
 TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
-TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_ool_arg_zzzz,
+TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
                         gen_helper_gvec_bfmmla, a, 0)
 
 static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index a2c62a86d84..616ec54bb77 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2847,7 +2847,8 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
+void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
+                         CPUARMState *env, uint32_t desc)
 {
     intptr_t s, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
-- 
2.34.1


