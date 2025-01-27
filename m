Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34531C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV3-0006b6-2b; Mon, 27 Jan 2025 18:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUp-0006Pn-56
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:23 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUm-0005cz-TE
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:22 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso6664626a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020379; x=1738625179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GA8OMBaKoWm1dr2kAwaJfnYaqSkCIQYp9JiJNnvOmTg=;
 b=aLg6F0KIigLpi7r1VWb8KqsJOUeN46EAZufzL4pEwo8dBOwDA7ak0YZregDcNZw4EW
 2g1x0eWFZkY7TU+pwmHn8rx4X59WdZlFKjZcU0olgCyb2u+6eSxtuNy/n0p35ZzcIddH
 AXAyxv6sOqA2gY1Nx5a4K7a5S405PpqqstFlBGQS7x6SX6f+zO893ZF6Wd6P+bL6/PNe
 ZGo8GNLp2XwARm4BWM1DGWLKSPfD2IPycL3TqF6dY1wSFY9hKwuM1Cr6ehZQUk9YR2yR
 1qoQ0LCet3Sj7l+WhfV4wy5uWTZwNCN8PZ2hrNsbGT7zzbk8B3E2Obh38n1CvQ8Z6K/w
 p4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020379; x=1738625179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GA8OMBaKoWm1dr2kAwaJfnYaqSkCIQYp9JiJNnvOmTg=;
 b=jjZQ2+ObNQ05gtEPmdziswf/aUqmCsZFz9J0uBGT2l96qXGNvVQjQX2IxLkNvg+Otz
 XrZxBahZKTucnffSHMD6sk4l5SVX/wyL7gtCeunDIiaOsezfGR11R+H8hRRVevoahd++
 Dgu7nGvEPu/jzQPtkqzJbDvjrteO9zoF1UKhvuhoStnprxNNLXDSX87J1PacQQwrgm0H
 53LmEJYgXT2g8Z6XxiFjVUz4klJIM43UzsZZ7HBnVN+zh7/oVml+T+9UViDgOwI0HbgZ
 fSEJ5B58vqHVoRN4jQ+W5CJ4UeQ2gq7/uleV4nWjWily2piWslbb6do1S+Zmxwc5H5kX
 nxsA==
X-Gm-Message-State: AOJu0Yyj4RW4+iATMm8YgGKwxF1nBDwheG0iCYCJmdpzRrcfqbHrpzcA
 xd8K4b2B/dCTh+Fxe7B65UgpWe21jSFUKPcVZ0wuuARyCLZ/zFqajIiqT6d54w5v5FeLAv5SYUP
 +
X-Gm-Gg: ASbGncuKZtztkrAKQdXGmmMjMwTmuALUS+DMEsyDtbfhaTgjqaSWZ4hM6EIKjtqJuCm
 VvUx8OwH5vi9pbBcdWN7PQlb3sDqd2mzDyH/8DubMDcohY9SZOk3EcrwTff6swyEvw3OkSOsuwu
 OSP+lDaYtosh1guco697mLi+f+w4O2nlAV7AG30EcTmTReo9YxL8nPhgZK4rsnX3WAMchGsk5Wi
 OY7qHjzSiLawSa2u3uWzIw7B/5FZRZ/B96eHc5F4YmISzb3e969ewivOtz8AmeddIbKK2A9KmIG
 6modb5JmX/rYYWrY8Q4wnXWWa9AQZZZxvenEG5A=
X-Google-Smtp-Source: AGHT+IHlHZgW5gSVlJBt6WkZYrHnsLYYH8YkLLzteSlctKlFQ+oCEpG09Gb5rnvxTr4L6pfMPk6Y5w==
X-Received: by 2002:a17:90a:7187:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-2f7e201ab8fmr41113910a91.18.1738020379539; 
 Mon, 27 Jan 2025 15:26:19 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 17/22] target/arm: Move float*_ah_chs to vec_internal.h
Date: Mon, 27 Jan 2025 15:25:59 -0800
Message-ID: <20250127232604.20386-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 20 ++++++++++++++++++++
 target/arm/tcg/helper-a64.c   | 15 +--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 094f5c169c..a673935f48 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -20,6 +20,8 @@
 #ifndef TARGET_ARM_VEC_INTERNAL_H
 #define TARGET_ARM_VEC_INTERNAL_H
 
+#include "fpu/softfloat.h"
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
@@ -265,4 +267,22 @@ float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
  */
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 
+/*
+ * Negate as for FPCR.AH=1 -- do not negate NaNs.
+ */
+static inline float16 float16_ah_chs(float16 a)
+{
+    return float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_ah_chs(float32 a)
+{
+    return float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_ah_chs(float64 a)
+{
+    return float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba21efd0bb..dc96c92a21 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
+#include "vec_internal.h"
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
@@ -208,20 +209,6 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, float_status *fpst)
     return -float64_lt(b, a, fpst);
 }
 
-static float16 float16_ah_chs(float16 a)
-{
-    return float16_is_any_nan(a) ? a : float16_chs(a);
-}
-
-static float32 float32_ah_chs(float32 a)
-{
-    return float32_is_any_nan(a) ? a : float32_chs(a);
-}
-
-static float64 float64_ah_chs(float64 a)
-{
-    return float64_is_any_nan(a) ? a : float64_chs(a);
-}
 /*
  * Reciprocal step and sqrt step. Note that unlike the A32/T32
  * versions, these do a fully fused multiply-add or
-- 
2.43.0


