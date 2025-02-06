Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C9C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80t-0008LT-Gw; Thu, 06 Feb 2025 14:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80P-0007Ih-Ab
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80K-0000aQ-SJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f50895565so205035ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871859; x=1739476659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogwZ1cQjO9+u/pCRTY5leFDQ2fKRdmFX0siW/iyyt04=;
 b=KdQvUDOowrILlKzFXc1VhU9lpu4txbPRbT8ANQsBq2nxJuWImDOiQjR89PK010CW6E
 t5rhW7tPBK4BAnc+lvDZMqGex9WwgHTmll6kQzqXke/wujSm30yW/5Qe/5vADJZ2HW2q
 0JYILEhx85dUOmvTEnFS2fhtQLRFQzeEujBeiEtVrDPC866QFfZXK42MViZSygviqKM9
 HGn5UukzplmTZBaB7ZlCZNjAET5K7gHLuz2TR/fAFRGaLKJurKfvbq0JZpycD9YygsWU
 z9vy8zuVf/bPjlIHW+kw+ABOUv878mlv6BTQlNYo/ZXqH17Lv4KMZO3jYZzI51JUbEiS
 7Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871859; x=1739476659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogwZ1cQjO9+u/pCRTY5leFDQ2fKRdmFX0siW/iyyt04=;
 b=MIwBLsRaLOGgcBjB5rMj4YASbujXraTaAtqbJ+MaSmvu9MA03UzfVwglo14fIR2VzP
 ie7vTx45AO5Qp1rkqAZVfdDCWJlN3NRVZGHZGJy+80EhYFYm1M26POxM7LZDO6sTNF/h
 IQAL7alrlfLLenqHmBcQyGNOAaKWDrIHA5VfLyz1F4SClJtiy+vEyVKQzqvs7lJLpcjg
 sP56VH1JlpA2M+MAPS1OwMIFUoJ1qM+vzjBrtwkSRA335HjdQa4SkgThQWXMg/zZDIdW
 mnwZ6c5fgk3+6zJ3btC+yn5y3/gByt+dpAjQV3jWCVQqIU9dKjjbW79Ajc7b8ELHpFrb
 RVtw==
X-Gm-Message-State: AOJu0Yx7EviPf5HeQ9tkAI4Xa4W+m9KCwbUXko50cbs5e+t1/JgInjZa
 cAf8faMMz/OaBCkrgTKHMYp2viG5vPrjEZVipkHo0P3+eE2dKGsekaKKZ7ih+BlmDyKBbsTkxBx
 s
X-Gm-Gg: ASbGncuAOr+8QLBV/JoQy2pqU9BX9o4sMDk/atlkChGs4l47DlULywQx3wVHEzPocCN
 ZcI/ceq8NmsRqXFvHlLDU7uUgimrMbI+24RsnUE+14kSyrA9EhqZsNHMNpATegQYoZui/kdxDzp
 BFUOABz0H6NM2yxB6fhfcbSqQ3+wnL8Q0Q4ONQteavln3MMVTq4w504LASUl/o5G5j729H8+HBK
 MGq0A6/0Hjh/PwfjfycZr5qJrUbKm9IJ0M7k7allv6iX8ZtXVHFiafP9FVx0niwAv+xyQ/V4M2L
 +z8ewLHucZ2go4nsUr0Rz0EkGd5g6BPVoa4jfgET21sYNs4=
X-Google-Smtp-Source: AGHT+IEh3ToBXB2mXRsOvZJy7pr1lA988X74fq5/eLWmk+xvl5VPjIcT7CGleJ/+Qw7hzuRy9C2lEQ==
X-Received: by 2002:a05:6a00:230c:b0:725:e4b9:a600 with SMTP id
 d2e1a72fcca58-7305d4f0412mr919708b3a.16.1738871859186; 
 Thu, 06 Feb 2025 11:57:39 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 30/61] target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
Date: Thu,  6 Feb 2025 11:56:44 -0800
Message-ID: <20250206195715.2150758-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
simd_data(desc).  For SVE, this bit remains zero.
For do_FMLAL_zzzw, this requires no change.
For do_FMLAL_zzxw, move the index up one bit.

Read fz16 directly from env->fpcr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0907a4e9e9..e56ef6ad68 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7168,7 +7168,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
     return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
                              a->rd, a->rn, a->rm, a->ra,
-                             (a->index << 2) | (sel << 1) | sub, tcg_env);
+                             (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
 TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 671777ce52..16ddd35239 100644
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


