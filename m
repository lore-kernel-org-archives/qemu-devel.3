Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913ABC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6a-00086D-0s; Tue, 11 Feb 2025 11:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5m-0006ci-Lj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5l-0003DN-0Y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4395561ab71so8285845e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291191; x=1739895991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ltVozOB1txcRK3IvpG6N/vre3VyLEVZMby7Yj63zzG4=;
 b=PnBZlSDQqo1tCfsriDcr8Chyk2Zej7CjEB4i3ntdyff8DsnPJjoQIpN7nBAi1CLc5+
 +qg46naHXgsxt/bqlJu0TdLPetrmuXO1LialqG/83hT4vKRdHs7w1J1ZeEHISP+VAf1/
 bWt2/D/O4GB1pnl8PJRCbWJ88zNd7C+SY/iWNYn9DCDo7PeiNx99zjrKzxuaVCwlbl73
 /taaAf5a2yDfkhKWiyaGMU/T90KoOWAnK/gf68FNj4JS9t+8J2Qt74E4e9qp6FWlJjrM
 hSLreCVIKbmKQ7guysIe9PBKzSoxeerQof02CBK4/ih7PN3B2bcbruyDKb7WgT/Nj3U7
 RSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291191; x=1739895991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltVozOB1txcRK3IvpG6N/vre3VyLEVZMby7Yj63zzG4=;
 b=w0iz1PI/iKn5vPfcUtxCllbt2x/rYKQqBEmxNHq0spvcvsL7Q9FsXYOAB/EH8xCXb2
 VvANib3Mau19OZ5mh2m2fHbGsWb5SDQUnEJZcLOCccZ27cNhehtRz3cJGjJPjqd/ye7K
 F5ftzFXxzN/5gC2FfzVXy6J67mpyT3gj6m3qgR97WsgbYd674+yuouQFOwzoY53dqegn
 MWzfoK00fIoOVWkeXfBEi1iJns1KAp8RMJhKfhzmIYDOOMzXrE3jJiA4zO2UOi+aV3At
 Yvxm8KYptwHpeWqkTp8LoH9dnYH0f+2tN57b/kvEgiRfCTk97tCwHMeEr0CcEe3/y4/7
 Qirw==
X-Gm-Message-State: AOJu0YxGovNCmru2kHoR7x3v3oitYvGQPvCwIcHbB766+Sj9ZcQnqXg3
 PHcH8dpM4QNrBQ9WhJSKTKuwDuuwd35xakpAtxCiAkiC9YfwDJtZQGV9UktzO/fgwxSVjeeJoh+
 U
X-Gm-Gg: ASbGncvj97zOgYxcOjtiS/pUKq/aehjI8CbD850Z2eFVolpIq3WGj28N4Ag5V8AQkJE
 OrVKaWMtHVGbUseQfwuIvbJN+dTAAvCNrCGm4oqGHLLE+e5Q55QDRRhmxBqKG3e6xiRF15cx5al
 Um4TmqAGJemsNGUG9AI/WfDirr7duczXogVxkRsNSQ1MqmL0sZCk2mOpAMT/vKXgCASod0Uqir1
 p0C7jS5+shOYc6a/Q+7vn9paUUv3J9AYkSWH8kjePAYa8M+2NPphh0kjO2aXZE5/WBuIbBeYzqG
 xbYEcSGG4dU/HB1Tvi88
X-Google-Smtp-Source: AGHT+IGroL3hhSyM64mV6w3XItWy0ROuhUlVzLyb0+xKwbL6w3msH/GTBdqSab/12dZM68gHefm9JA==
X-Received: by 2002:a05:600c:4f41:b0:439:4c86:9c32 with SMTP id
 5b1f17b1804b1-4394c869da4mr44707805e9.8.1739291191380; 
 Tue, 11 Feb 2025 08:26:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/68] target/arm: Handle FPCR.AH in SVE FABS
Date: Tue, 11 Feb 2025 16:25:20 +0000
Message-Id: <20250211162554.4135349-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Make SVE FABS honour the FPCR.AH "don't negate the sign of a NaN"
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 4d5de2004f0..646d0171d99 100644
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


