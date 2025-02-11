Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F8BC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6u-0000iq-2K; Tue, 11 Feb 2025 11:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5l-0006cJ-Mb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5k-0003D4-5o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso39885955e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291190; x=1739895990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFohraiwXEBOdts8mKG4T4078t7+REeqcOBZpOMeFtQ=;
 b=YqGE5PlA12cKPlSxU2YAW9N5hdiAJKlKWFBWxwZY7MdQTHCSj1cm1JqcLGId9bYSsV
 OSHhhcDeIylZF9PTr5w5zUzNISjw5ly5oWd/HphxiUdEhO2rRZ2MDnD9x33tCMqpAb9Y
 OW7p3Z+0MeTcjTWuSQi7TJDQyNN+GA++ETA6uffD0gTO6BBvo0OVIcfcwmA25tI8xuKL
 IG6zqRLoZMCZM5GKIZR5CDZ7t+J8o7MTq4NrzOJaNOlywO6zb57X8lL0XLPg8LODyruY
 7ak45BZkTpqDgd3tsNp0DFskVUlyWsqY8bLm1OGoNwINrRZHyAWmGq1EZT6z3FivQBiR
 Xqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291190; x=1739895990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFohraiwXEBOdts8mKG4T4078t7+REeqcOBZpOMeFtQ=;
 b=qzlcKupsHqQlqYQLH848QpuGn8EllGuB3SRnD6+/9fh7zarqdD6zKco7lLXFAyziCu
 ee2FYdjJ/09LtNu8JscnVc52cw3mKDcU0tPfuYPLdJI9ZsHpP7MSYLz06FgoCDK+K8qK
 qrQliaOJ01GQGyJpXwLB7Y5MH7jRPsISaBaQslNPC1CRfn8ye6ujBnoNCJ3zmNWHP3+f
 /GvQFeP4CpnvTBDTtw6wE35cNZRx4pxnCIHIURgbf0kUgJ+gvN5hjCzHqnGkbdzMT/AO
 qJ6LHDp7t3errmMg3oagZzoBexT39QdVadIMxndqkpSy9NHJXFEIzwRewNnniI+BZEAz
 Or/g==
X-Gm-Message-State: AOJu0YwyENAbMMe3nU33Cdh3M3bPYPv2umSadG5XhUx5dsLUExq7Mal3
 wDvf97WXb6WzEzjjjmDnpijMDPySb5kTsIyWG6AKJgdXZ5ZrYW0x/5AgjgL4D8t8nCe9ybC9Qxz
 M
X-Gm-Gg: ASbGncs52Vqe4K4IeBmDQvUzRRb1ZS9PSNhb6cqwGCLhbaOd4l4accZ8o9bSUs5b8pz
 6tp2iQ8y4KKqAY8AjHzONW7omTV4xw6g/d+/6cMxoLnlYJsQROP10+6fNlN4i5++wbIUpwNw7BY
 P21OY1fldkjkUnGlROB0LmApjc2fAfXgcYWewMdUTHkE46kszmly7P6rCHBKBR4e9W2oQJsSPy1
 gGUKV/mCpQVKVlc/t23DY/P8YRqzM+5ruOOaGeQe/iVRdlXv+Hqs/IndDJantFyIRj2OtceUcD2
 CfhTUJQbA0hHoS+btCrz
X-Google-Smtp-Source: AGHT+IHVUSreqBCyS6KttnySnO84g9mZksbXTTDR65vHdBvxGY8WYBcKkk3wjTEIsvQBNWAmqzxOsA==
X-Received: by 2002:a5d:6d04:0:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-38de401feb4mr4226243f8f.49.1739291190318; 
 Tue, 11 Feb 2025 08:26:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/68] target/arm: Handle FPCR.AH in SVE FNEG
Date: Tue, 11 Feb 2025 16:25:19 +0000
Message-Id: <20250211162554.4135349-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Make SVE FNEG honour the FPCR.AH "don't negate the sign of a NaN"
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 4 ++++
 target/arm/tcg/sve_helper.c    | 8 ++++++++
 target/arm/tcg/translate-sve.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 918f2e61b7e..867a6d96e04 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -545,6 +545,10 @@ DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_not_zpz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a688b98d284..976f3be44e0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -885,6 +885,14 @@ DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
 DO_ZPZ(sve_fneg_s, uint32_t, H1_4, DO_FNEG)
 DO_ZPZ_D(sve_fneg_d, uint64_t, DO_FNEG)
 
+#define DO_AH_FNEG_H(N) (float16_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_S(N) (float32_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_D(N) (float64_is_any_nan(N) ? (N) : DO_FNEG(N))
+
+DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
+DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
+DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
+
 #define DO_NOT(N)    (~N)
 
 DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2813e5f4871..4d5de2004f0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -789,7 +789,12 @@ static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
     gen_helper_sve_fneg_s, gen_helper_sve_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz, fneg_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
+    NULL,                  gen_helper_sve_ah_fneg_h,
+    gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
+};
+TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
-- 
2.34.1


