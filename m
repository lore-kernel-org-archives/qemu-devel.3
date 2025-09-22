Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA947CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbe-0004f2-44; Mon, 22 Sep 2025 14:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbV-0004dV-5Q
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbP-00043D-Mz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77da29413acso5013614b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566968; x=1759171768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PO0Xi+l8mZtLQEAvQVUzx/DN6qW1/Pe1V+/XNJEzQZI=;
 b=VhbsvFzFPdDRAF1snKzIe9PUajBFEmXDClLnQsEkOAK62HjAycgjiu3wA6TlC9IH8c
 6FxUaRoYc2lpDPOyvP5lKWEoeiRXf6ay5CbMC0AGIIeCUNkp8uxE39gmCrKpF4PDTYjl
 YGInA2Fuf7gRILmrw42QPguUCiMR1xlmG9fUwwq/tc2MB/lPDm1FojU6VyvjLlPavVTQ
 w72d3/DZ/aHCKAUQlzaZ6TspJbgUJPHceZQk6Gb+zJH1PrfTetusZLfD3O53pIvdpZq0
 zw8jXH0CScHJlGbOXBkTp0kTL7706lD0Nl8WpFxVgNlCmIr2lhlml9JWqFwFOnBdppmk
 gwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566968; x=1759171768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PO0Xi+l8mZtLQEAvQVUzx/DN6qW1/Pe1V+/XNJEzQZI=;
 b=u1gn0rKAt3pdb6MBF/FvWOwyYsi1KVwzQnYSgTueEEmYO7THnyLtQY1LaOCahfdxwA
 oG4PHYZ3IKSagOYDjJvQZFZlIaDtyo8rHZyotunbo3hWwHM6GMwRnDCssasWcs47Xlt8
 tn5cwAbPUGJ2tlCPFh6jiVFdasVp7A5Njjnn9VtqwfY51m70S2XK6tJkY8j6GeTDlFX3
 +dpJgME1zMdzpO5ZnSXEGI2dkpT+dBqkD7bnWLDGalrXocFq6ZAxf2w7MakcH8R05TVx
 NBotGkDCBnd93jKcF5Vqa8JpIntiDOaH3ocW41SyQi96avxDPGLgl7de3rZy+bAeJRgY
 ewYA==
X-Gm-Message-State: AOJu0Yzk3JyL/ySvM62gR4tJfpvKtI7QhiMBdVYKNZwYOqm2fuCD85vY
 n+39qu3Qh/XX8FrZXhbndnWJuOaW3lAG9sUF0Tce7tGsn4cIA81pO/O0NyIZZDJf9Cyvd+p4hL/
 CZ3Y4
X-Gm-Gg: ASbGncv3dOJTZb2a/7vliQpnLZAbuLIC3k+wetO+fVzZDSZ4jJAdnMS4mtvvnf0AC+T
 tfc9hFQXvjOb0h6lroZCtdzhCbYpo19mNGAj/p3iAy6ErJGxCqM8dQFGuIs77R/9Wr1xnFr99UJ
 eco+r+LLep1xgwmx457P1bmPjI6N7cPLLhwye+Xm8NfDTycUDWB41qloJILrHC63HCt8X9JrRt8
 ZkVV21Nu9tX/6BlfHsC7CWxoD5K2p8RO3iih6ZNcAsTDtvlXjcwl+64nN5rRvvHrHA3jlr/Tc3F
 Vbe+IsLBGjmcCBeicYAsXxPXr3Bt6OZEsRsHTZNfFBGguddCP95/s37ilGvYrGiUaMdgdV+QWkl
 QSrHz8/xt2RQjyr4Y8Gyfey6YLjsq
X-Google-Smtp-Source: AGHT+IFAoWDE2Xo5VUCA3sTCW37h4xh9J8gZ12D9tXkpg4J86+p1egZF12lbfBiVGMzhlPTGj2OHLQ==
X-Received: by 2002:a05:6a00:188d:b0:76e:2eff:7ae9 with SMTP id
 d2e1a72fcca58-77e4d224dfdmr16519530b3a.12.1758566967868; 
 Mon, 22 Sep 2025 11:49:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 01/76] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Mon, 22 Sep 2025 11:48:09 -0700
Message-ID: <20250922184924.2754205-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 512eeaf551..30226814bb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -929,6 +929,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.43.0


