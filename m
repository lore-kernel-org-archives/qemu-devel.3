Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5AFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jKx-0006GT-Tb; Fri, 03 Oct 2025 13:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jId-0002kg-Fc
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGr-0006KF-WE
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-27ee41e0798so35660175ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511311; x=1760116111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiCT5dQBsrJwFNdO20PuzR3mmYBkgwB4M5DIVawBldk=;
 b=kVORDFVK9ZN6pUjfjYg/1kpSikrfaR9y3B6oNV02j3hcIxv93+5zfNyDtLn3GeiXpU
 bhMW0MtnpUpwsgJBnG1nz3zvo86ca4m8yaWUUivgDX8ts0XwU8RIRdsJua2RcgqKNiza
 82YnvXUjcUn+NgpSNK37jASssjof3N9jBf6/8lEKYc7rd2Ew1Qu49/gS5BWnnMthO7cZ
 DIZ3peTmMJwe07i9U6lWcdBmo/7GwPanMBx1NeejV/+8a3g2FM011aDXG8i52b7wPgCp
 N5EIPq4t3OHiMGw6PBKreNAQ4PSD8pxrxyfkCXIm1j77tooFKbT8cdIMPyDWVJC1m0ga
 SUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511311; x=1760116111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiCT5dQBsrJwFNdO20PuzR3mmYBkgwB4M5DIVawBldk=;
 b=wvgNwXex3jAuyX1ju6alT+IZuEqN8EqckJOBMXpTXwdDXTM+0gBvd+LLnpJBevX9nQ
 NmE9gie9OFYFedS7Net4kwJTDzQjz/eUFGLz7Td0vMaC+o0TKVP/lTA3d2BuxxzkRe4v
 b1r3rDzuoabkVdXCoODfLk6ECR4wqCicnVgpkszDiI4lqS3twnChFWpmVzFtlB2EY5s2
 42vFU5TC8GS3nNkPctR5kesrz+US1lSjp1bFPnmIsARwZry7urw++RbyE7q/ZR+BaIUw
 cmUKPBWiAokXJo+WZ91eNTQK7JPQtscCWTuPCVLCqFv/rV9EFsogwKLeR6f1krW7NVHq
 MzLw==
X-Gm-Message-State: AOJu0YxmEPiDdozCtwSuBk6/iZwvWFvz3LSe8ai9zz+phnd2wYBWCql8
 wVptC7Ut0l3Q8hQaplq8nHooRgxNuSiYjxpX/To84FDDcPdtFT+gzRznbKonGP8tbxFBXbnGYus
 9QYxId3E=
X-Gm-Gg: ASbGncv9upLvNFO5DVAcUMzDSu70/lnaWF/3opZv3sEDeFh3WpbeKNfmFbZHB+qBcvn
 xYZ6NEXRmb2S2XuOb0AWFYm5aI1alx4cL2XI0oHPojN06F5aXmv+gw0khVURL6UH4pk9gW3Q51H
 4ZABz/8JuIZ9tORYezoos/KFs1Gz06BZBnDANTKqyVjlFxBJaww/uCPfZJ0MXGfVyaRhrCz+E5i
 zugO3F8zqebhx55fxzVna8UTIUkRUkh4i2xyYnhhejA5+XBHL+fnIJeanF6JisyXuNk//u0VLJm
 0wXG/3I2Bve7dx+KgK8AaPFkPlRkIj40WzKfiOdmIZAbAsBd3GhiYcmOE7KzwVsF8mU+syldA54
 EPb49BB+jVzv5Q1Bm4iTktbXRtxeCvkLvl+i+pavq5kwyGEpJeUlxQkWI
X-Google-Smtp-Source: AGHT+IGBfZOwfdVo8b128Iac4erzaJg/9GVaFV+7WXd7Nz6oJG5R8saOYTuuU5Tb+ao/fZ9GVT2jIw==
X-Received: by 2002:a17:902:fc86:b0:24b:182b:7144 with SMTP id
 d9443c01a7336-28e9a5655f4mr47966395ad.7.1759511311459; 
 Fri, 03 Oct 2025 10:08:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 34/73] target/arm: Make helper_exception_return system-only
Date: Fri,  3 Oct 2025 10:07:21 -0700
Message-ID: <20251003170800.997167-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    | 5 ++++-
 target/arm/tcg/helper-a64.c    | 2 ++
 target/arm/tcg/translate-a64.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 85023465b7..b6008b5a3a 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -80,7 +80,6 @@ DEF_HELPER_3(vfp_ah_maxh, f16, f16, f16, fpst)
 DEF_HELPER_3(vfp_ah_maxs, f32, f32, f32, fpst)
 DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
 
-DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
@@ -145,3 +144,7 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_2(exception_return, void, env, i64)
+#endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 71c6c44ee8..6d77fd0113 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -576,6 +576,7 @@ uint32_t HELPER(advsimd_rinth)(uint32_t x, float_status *fp_status)
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static int el_from_spsr(uint32_t spsr)
 {
     /* Return the exception level that this SPSR is requesting a return to,
@@ -787,6 +788,7 @@ illegal_return:
     qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 78b2881a15..43c9bfef93 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1870,6 +1870,9 @@ static bool trans_BLRA(DisasContext *s, arg_bra *a)
 
 static bool trans_ERET(DisasContext *s, arg_ERET *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (s->current_el == 0) {
@@ -1889,10 +1892,14 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_ERETA(DisasContext *s, arg_reta *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
@@ -1918,6 +1925,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_NOP(DisasContext *s, arg_NOP *a)
-- 
2.43.0


