Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE316CD5BC4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC79-0001ne-C4; Thu, 05 Sep 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6x-00015k-VQ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6q-0001j5-WE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so7678845e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541266; x=1726146066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UEvZ92Ysmoac5/8gCPMIYUSdZILiX6VcaOGkdAF88AA=;
 b=PNbvC6MDlIV1Dv0o9BFrGOwsVaaLGFI8ixLHUaGJgeiB42XxcMahXkGbH6mwbODK2T
 Pd/xbMQ/c9uc7yuJwS+/OhjMiocqsSsZflMg/nYjkL2gMpjSNMOUY13z9EPO76r3eUSv
 jFJiIoD7YrZyzogdIsumvN2GH6owcggzfNo8OKxkufjfj6M2hQnVMzeUp0a7yMHnnu+W
 Bvr0HXK7f/OjqzUxeVNXxWtznj+pgHeCDmTywCI51xtstIXpelBTQMZmq9OyuQFAjhrf
 D3ulv7B0vlWas1Nn1QeeVGQfnxudmSVJz6jKmvQr/qbpCxjU6hA668dAvKUIlZCTRkMH
 QS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541266; x=1726146066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEvZ92Ysmoac5/8gCPMIYUSdZILiX6VcaOGkdAF88AA=;
 b=InN2IHRVpCKBion0BiBswqM+OONmy3USBDu93pJGkK6pP+wsnlgQ+JQIU3IH6APEFO
 Z0UtiLKkRR7VdxZSVBbadAKpdRh+4q5yglwBurPNa4DBdcwlxZCpi1XNBzm03gldGxQR
 RoKwIaeRounRtE7R6JKGKCPShne+sYR7UixChau5YMLt8byKmyiYiZ8DMn+qbIgmgckK
 hpj72TGHsjZJ1d14usQHZgv6jG21ImcW1X0FzpF4vSPQzkVRqEIT9ARlnk3/TnuEEze9
 dMIip4tyC4uowL9epc3dxE7MZkekz8DDrmq+rqbxt/wv3/RJBU9K4kOaGnEJ1bvNV3bp
 sLDQ==
X-Gm-Message-State: AOJu0Yz3IWtyb07Lq3D+Y+AxTPZHF0MIEgK2Fq2YgXJlqwJuqFOO0oWK
 UVRmksz8eE6bKM0UzgAK/FTVjcoe1z9zTr42pkopMIT9LF53y4BkpAignWFbiAcqIoTdEBqqfsu
 /
X-Google-Smtp-Source: AGHT+IHYDOjQI8NoP9J8J4y2vVy9IYtSu5jtwcqETA+fBl+aMM8nizQClnQ5dFzooNdp/yZhFPEDig==
X-Received: by 2002:a05:600c:3b29:b0:426:593c:9359 with SMTP id
 5b1f17b1804b1-42c9a3938f6mr22208325e9.32.1725541266080; 
 Thu, 05 Sep 2024 06:01:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/25] target/arm: Pass env pointer through to gvec_bfdot_idx
 helper
Date: Thu,  5 Sep 2024 14:00:39 +0100
Message-Id: <20240905130100.298768-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
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

Pass the env pointer through to the gvec_bfdot_idx helper,
so we can use it to add support for FEAT_EBF16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  4 ++--
 target/arm/tcg/translate-a64.c  | 11 ++++++++++-
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/translate-sve.c  |  8 +++++++-
 target/arm/tcg/vec_helper.c     |  2 +-
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4466e796cb0..e197b5b1d2c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1029,8 +1029,8 @@ DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_FLAGS_5(gvec_bfdot_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3813c75895b..c7876513c72 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6410,13 +6410,22 @@ static bool do_dot_vector_idx(DisasContext *s, arg_qrrx_e *a,
     return true;
 }
 
+static bool do_dot_vector_idx_env(DisasContext *s, arg_qrrx_e *a,
+                                  gen_helper_gvec_4_ptr *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_env(s, a->q, a->rd, a->rn, a->rm, a->rd, a->idx, fn);
+    }
+    return true;
+}
+
 TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
 TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
 TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_sudot_idx_b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_usdot_idx_b)
-TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
+TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx_env, a,
            gen_helper_gvec_bfdot_idx)
 
 static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 454380f01d7..7de157c539c 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -391,8 +391,8 @@ static bool trans_VDOT_b16_scal(DisasContext *s, arg_VDOT_b16_scal *a)
     if (!dc_isar_feature(aa32_bf16, s)) {
         return false;
     }
-    return do_neon_ddda(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
-                        gen_helper_gvec_bfdot_idx);
+    return do_neon_ddda_env(s, a->q * 6, a->vd, a->vn, a->vm, a->index,
+                            gen_helper_gvec_bfdot_idx);
 }
 
 static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e1dd6617e8b..eb77c943c8f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -265,6 +265,12 @@ static bool gen_gvec_env_arg_zzzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
     return gen_gvec_env_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
 }
 
+static bool gen_gvec_env_arg_zzxz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
+                                  arg_rrxr_esz *a)
+{
+    return gen_gvec_env_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index);
+}
+
 /* Invoke an out-of-line helper on 4 Zregs, 1 Preg, plus fpst. */
 static bool gen_gvec_fpst_zzzzp(DisasContext *s, gen_helper_gvec_5_ptr *fn,
                                 int rd, int rn, int rm, int ra, int pg,
@@ -7128,7 +7134,7 @@ TRANS_FEAT_NONSTREAMING(UMMLA, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
 
 TRANS_FEAT(BFDOT_zzzz, aa64_sve_bf16, gen_gvec_env_arg_zzzz,
            gen_helper_gvec_bfdot, a, 0)
-TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(BFDOT_zzxz, aa64_sve_bf16, gen_gvec_env_arg_zzxz,
            gen_helper_gvec_bfdot_idx, a)
 
 TRANS_FEAT_NONSTREAMING(BFMMLA, aa64_sve_bf16, gen_gvec_ool_arg_zzzz,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 01b36fdd786..a2c62a86d84 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2828,7 +2828,7 @@ void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
 }
 
 void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
-                            void *va, uint32_t desc)
+                            void *va, CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t index = simd_data(desc);
-- 
2.34.1


