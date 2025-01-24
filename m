Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMfZ-0004S7-85; Fri, 24 Jan 2025 11:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ7-0005ol-3l
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ4-0005kR-KM
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361c705434so16685675e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736189; x=1738340989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vkN1tvZXYem3cLB2r+/GaeAu/aQPELpTO9bRu2GSjS0=;
 b=QA9ekjkF/0amWxMUvExS+Kru6TyW1dA2ONt43UHo27G2TEW2kcpkarY30KKZsqlzEh
 PUWM4vwyF/WEqY1V2rHnhn5X9MlJfQ1nImIE2nF1dc1pJDrJ58xDPEcxYQ4pYm6dMxqJ
 sF8Nd5cH92/4iIec2qWt/o635Yb5Yn5f7GeQcmhOrxMb0By1oNz0ALmjtZHuf6lJ7FW6
 MYHfvHAGSvbbzZLZspzzTduRMo4cDHAbJRV4+uVeewgNEqNkmtUTYwLFciMC2cYJxu71
 1Z85ECxr+AC5Ye5+Y1jMBReLuQ/IdQfJE8Kw4tAR/zvdiNmUHdy/1/b/EZhHLTX3CvXT
 3lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736189; x=1738340989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkN1tvZXYem3cLB2r+/GaeAu/aQPELpTO9bRu2GSjS0=;
 b=VKQYe0pMoWBRsSX+xpQFrVB2EbP8O/sAMsPo/XFRNCsgP1VoDsQ3iGtoc7mkN8eao+
 2yIlRGZJ50mwOVEQajoNhDDYwRzzu4YC6H6sQRVfMrfzPN3oUJRxGfnu+14XIzqGmSQ/
 Zl8o+7rHzxvmeNas3dn/jzDfIGiA7SwFP8H60xBXOrcGl80UwBxWJvjH9xv0j5DyJPCO
 jfn68Fqlbf6uktQwYXaG1tD1adu/wxLxZk6mnJieN0N8JrBSvi4lRlf+S9adMBwQC0fE
 cp0b5pd2fhiD3QY4Zbw1Dau8RGMPynyVWIQ86LkwLfXcfhERnS2Z0vt/EszQYJFFCFv+
 3G0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhP+kE8NUFjg0G0Wt6Sx4Fn4UNOzJFxvrrbBrLiTp58ysgb4wdNa5y7eisOHArau3gNsxzsYgdRYgJ@nongnu.org
X-Gm-Message-State: AOJu0YxX+MTkA7MZSFo7oFHNHDcQ/xmkJDV+Mq3+KThXOUshKeUBrZX7
 C6BGq6yhNPqtfMn1OOIYnhh9hLRIxIRyQ39Z8Z3ZJerkW4B9w1hw1JOqr0OU0GCcY6SB3vj9CCR
 1
X-Gm-Gg: ASbGncvuq6ACO7Zj6+5rjVF4s3dcKQkeyuqFa5jXPwfsnrIKq+ErQQqo8nV2mQwbo9L
 oGRhaGvK0eqgr1/zYEz0jQZiJVgOhE6oHpNDhmJBk4ksOSQkuuAK01na9VYqPwPV/yp/I3glz/Y
 Df5/6FZBT5UZzZeFEtDkoXGqxYbQqiPefjdGr+NLu8Sn7BahjbWqzBdjjOZCESZa1yIGwAT7rsM
 jGVbBRDAYE86pkXwB4jcmjD1YG3WUVuj7o4GEBEK+YTZvk/FLzS/lYbozWyMd9iplma9qObW3nm
 WxnWRUkeYNc=
X-Google-Smtp-Source: AGHT+IHV6x/5JSu6/3+gWnGp8S0C/Fi0gKaZeL6jNA3HgWeSkhu4RgEg1nlrZDLE9akXiC/H9ew9dA==
X-Received: by 2002:a05:600c:1f19:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-438b9cc072emr73449355e9.6.1737736188906; 
 Fri, 24 Jan 2025 08:29:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 56/76] target/arm: Handle FPCR.AH in SVE FABS
Date: Fri, 24 Jan 2025 16:28:16 +0000
Message-Id: <20250124162836.2332150-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Make SVE FABS honour the FPCR.AH "don't negate the sign of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 4 ++++
 target/arm/tcg/sve_helper.c    | 8 ++++++++
 target/arm/tcg/translate-sve.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 867a6d96e04..ff12f650c87 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -541,6 +541,10 @@ DEF_HELPER_FLAGS_4(sve_fabs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fabs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fabs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fabs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fabs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fabs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 976f3be44e0..5ce7d736475 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -879,6 +879,14 @@ DO_ZPZ(sve_fabs_h, uint16_t, H1_2, DO_FABS)
 DO_ZPZ(sve_fabs_s, uint32_t, H1_4, DO_FABS)
 DO_ZPZ_D(sve_fabs_d, uint64_t, DO_FABS)
 
+#define DO_AH_FABS_H(N) (float16_is_any_nan(N) ? (N) : DO_FABS(N))
+#define DO_AH_FABS_S(N) (float32_is_any_nan(N) ? (N) : DO_FABS(N))
+#define DO_AH_FABS_D(N) (float64_is_any_nan(N) ? (N) : DO_FABS(N))
+
+DO_ZPZ(sve_ah_fabs_h, uint16_t, H1_2, DO_AH_FABS_H)
+DO_ZPZ(sve_ah_fabs_s, uint32_t, H1_4, DO_AH_FABS_S)
+DO_ZPZ_D(sve_ah_fabs_d, uint64_t, DO_AH_FABS_D)
+
 #define DO_FNEG(N)    (N ^ ~((__typeof(N))-1 >> 1))
 
 DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c173627ad49..c234a4910dd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -783,7 +783,12 @@ static gen_helper_gvec_3 * const fabs_fns[4] = {
     NULL,                  gen_helper_sve_fabs_h,
     gen_helper_sve_fabs_s, gen_helper_sve_fabs_d,
 };
-TRANS_FEAT(FABS, aa64_sve, gen_gvec_ool_arg_zpz, fabs_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
+    NULL,                  gen_helper_sve_ah_fabs_h,
+    gen_helper_sve_ah_fabs_s, gen_helper_sve_ah_fabs_d,
+};
+TRANS_FEAT(FABS, aa64_sve, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
-- 
2.34.1


