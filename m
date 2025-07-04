Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EB1C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEY-0000jD-Ld; Fri, 04 Jul 2025 12:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjES-0000bh-59
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEQ-0006HO-Hr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so633156f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646345; x=1752251145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OSlrzFqQKqu03zPkvyInBmMYbd2uN9rgCw0yQ9re9cM=;
 b=SZYAkBO87OOc3WhLRoxq5aD2aI8UpnszINGuXGm6AhZwlqRbppTBWTmN48zQxmoQu5
 dNyTavyLoD3OXA7hbSus20kWbO1s/5jZqtWAYCTytjfsvu2ZlyawcCvjkGQZz5zCjed+
 2tD9B548u9eUnmdhHELlVpKYHyaC5GyZjLUwOYi6awzWYGQlrw0gJp0WYDcNUJRtuqlm
 n501Afq8yS3y3A/0G1h3mrzZ/o44avi7FJA/RplhjrL4kY95Oc0e5cgxYUiKJWPI1bZY
 Y0ve9hgrkZ2psNUXK4qYrMd3SR5Twe8WOTLB4QxzoAGFuGoZQeDSb4r9izgMe2GIYAAK
 HUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646345; x=1752251145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSlrzFqQKqu03zPkvyInBmMYbd2uN9rgCw0yQ9re9cM=;
 b=lmtn/ghEev98KRxJE3BCwtOdn7XV0w1jkD4eRnyyXVL3EwHkWNqOwRIMfhEdsxT2t0
 5yMaAZXPVOCslYQVLdOb2ZcRmulMboDmhUGw0CHZ+5+L7wGjYoG6fjWtm4LR9RC38JHH
 noHE6O8q9PENdzoyZ0HjcGv+4Cd3xfCik+St5EToyyOWVIBRwnXdEZvEDIuYDIAX1DfY
 We7ZwDfPS0W7pa++RZf2hSWgitYiLlgaANMdEqKPUchT9MLiZp6CJzZGgoYlmSeZ0j7e
 U7U7LrM9aCyWXa8GcJgtrh8/apPOZtEn2Le4a/fpejJRyDYG5PsN6LHssOfNQ99bdZN8
 Rhkw==
X-Gm-Message-State: AOJu0Yyegye8WykkXnFywpH3A9QD7zNfEd0kwWexjc5ZemZPU7pOkLbC
 m06zV+OUuVsuduSQ2RnywG9zRYdgXXFpLfTGu5BtGDskqhE9oeZO+LxlQ8ojAcEVNqdEtRSQdva
 IUOPg
X-Gm-Gg: ASbGnctbrabQNdDhNFQzZyv0CL8r8tb3aYurVO40+4tNxzZCJXTwUkamtd3KlqqGSPn
 YxKgvdOiUAvzKcUHeKn5+697iUkRylMNpy/4UzSle+5gmrT/ck25v+gFT1khBm6Zu7Yykz6W9Cz
 tU4uzEGTcaiqK6B773Ee/lxlbxz1OihNNmzYY9YfteDFdGlP46RtyD7lC0R5U1YHzrTd8gI3lJf
 N0RkZrb8r6SZnfMaLsxZRI9iOG41cjQArbjlXGy+KrKFUrg2OCPM8bVTMjjwQDdxRZtXbvBoh2M
 e491YU/EaXREFR28ADXIKvM7krZcKlMJjmY2Tve98RJJAiHYJcZI7rOiuglOvurC+jNP
X-Google-Smtp-Source: AGHT+IHslByqunm9gn64p2WEIYFOVEoOrpwK+vsXpJlgCVZnxMGbBHe0zL4CFVGptoxL7B31oj2Umw==
X-Received: by 2002:a05:6000:382:b0:3a4:fefb:c8d3 with SMTP id
 ffacd0b85a97d-3b49703db12mr2410980f8f.40.1751646345127; 
 Fri, 04 Jul 2025 09:25:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 046/119] target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
Date: Fri,  4 Jul 2025 17:23:46 +0100
Message-ID: <20250704162501.249138-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
simd_data(desc).  For SVE, this bit remains zero.
For do_FMLAL_zzzw, this requires no change.
For do_FMLAL_zzxw, move the index up one bit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-35-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7e304245c64..b85bd885f9d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7214,7 +7214,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
     return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
                              a->rd, a->rn, a->rm, a->ra,
-                             (a->index << 2) | (sel << 1) | sub, tcg_env);
+                             (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
 TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 8b49577e2fd..e8467823f21 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2191,7 +2191,8 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
@@ -2274,8 +2275,9 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, j, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 3, 3) * sizeof(float16);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
-- 
2.43.0


