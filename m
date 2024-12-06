Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0632E77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOlm-0006pW-J9; Thu, 05 Dec 2024 22:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlj-0006o4-Qg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:39 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlh-0004Rs-4n
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:39 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71d5af465b7so463439a34.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454756; x=1734059556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0jKLOU5UZBplVg49+yB8JnyalOGaPnD33fBMrjs59A=;
 b=DFYheKuve0FNnZxOsaQz53EvEEtuPSQlCy3Xtul4Ub3IhxPyvoKJtUiXLQq3wTXUQO
 z5OFbjpc3C4jHANVvM9ox/JgYyd3qAoAkGVobuxulZgQcyzD4E4RWdHsGd6rnOSgAlJx
 8KN6/BdcmiDdXs1sF0t4Rn5ySdxMUzozOiPFcIjJFQP2YLNXLnsPNkQIo3K7KSLe7gXx
 8mw54aG6e1lE0sqXuswHNyQTLilaQU2bmNnfTL0M9GaA7WH00/C433RvSP7sN79+LlHm
 MPyy5r6wbw5aV64pHC3JVoiw01bmC9c429/NHX5x/ddM0dLhjG4A90qQLe6b4Dl23a40
 Gw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454756; x=1734059556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0jKLOU5UZBplVg49+yB8JnyalOGaPnD33fBMrjs59A=;
 b=RYHwBztYjgThJ0CXp9euXHzkCS/YDL+YHsVTiMHjQpHjkV0pUJ1RVyCbX8n98TLFqK
 DUxcw1SGtt8Zq05lINaxs/NXwNYYWVGC/N75EtmDkjVAdkVME1Amg9+hqxWWDBStiKN9
 BUeXBltiuqnrO8jkUtfjM5Bh72DzoD+XpBGT79gSNScrQ26OZCAuUKGHhBd3l2Xc3Pqx
 POa477v216jvl01X3lpm5wFxt8v/TS+mF59iWvAjE0GP/gIfPDyugfWWldl2WlwDzcNj
 7ek+XMCt5h7qjj8CK0d298rEQKqeh7ZiO+OyB6V+6oT0uKFCLgxQsvEUy/NJRr0Kf0dq
 4VFw==
X-Gm-Message-State: AOJu0YxewKH7NWgUCcEv+OlrY6mKx/kFM/jOBRVkAg53Cc1Cf8tzhXqw
 s+r+4D1RZKuP2HRZwpWrRcIWq49hXni7ZEDrkTggayZBmT5CcB5Z2H1ngmnnSvwCubORvMLW9+J
 iONkCpXjv
X-Gm-Gg: ASbGncuJRUx9blGQRvfrwCTdVsVGqxcVLaWLy5hhSWksu5vTYd8IAnN8qzbEsUvJOUg
 HiFuFxVOpgyDsnyszys6sBi4MP91BjI14ijaEJe3JpGzLjB/RmRXDjqH++R0t7LHzkn/U/vRITA
 X2XWjtK1rRUmB3HHO9W6p/wQuRl6LF88vEsMRasFf87+yQwEwuIWv47puwYulRY2tkDPtjbu67h
 Gz1gseHewYPL0rnu/RyzhUtnPmjMbmIBfDWNDdWLtuuj04XsXEuoF2HZe3EgQV68pXaqjv8sHB8
 FrOODmGkhJa/PjyCs3CSg2S32XxHg7OcKoS7
X-Google-Smtp-Source: AGHT+IFlCTYr2LROY3+q9RvBHS8PPbrB6cSftkt7wXf3+Z3v6xUX27og5uYpS+1yw/OOD6MMQyuSEg==
X-Received: by 2002:a05:6830:2a06:b0:703:7827:6a68 with SMTP id
 46e09a7af769-71dcf4f54a1mr838502a34.6.1733454755982; 
 Thu, 05 Dec 2024 19:12:35 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 5/9] target/arm: Convert neon_helper.c to fpst alias
Date: Thu,  5 Dec 2024 21:12:20 -0600
Message-ID: <20241206031224.78525-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 target/arm/helper.h          | 14 +++++++-------
 target/arm/tcg/neon_helper.c | 21 +++++++--------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3e78b90658..db8b8dc748 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -428,13 +428,13 @@ DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
 DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
 
-DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f64, i64, i64, i64, ptr)
-DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, ptr)
+DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_cge_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acge_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, fpst)
+DEF_HELPER_3(neon_acge_f64, i64, i64, i64, fpst)
+DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, fpst)
 
 /* iwmmxt_helper.c */
 DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index c687e882ad..99fbebbe14 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -1180,51 +1180,44 @@ uint64_t HELPER(neon_qneg_s64)(CPUARMState *env, uint64_t x)
  * Note that EQ doesn't signal InvalidOp for QNaNs but GE and GT do.
  * Softfloat routines return 0/1, which we convert to the 0/-1 Neon requires.
  */
-uint32_t HELPER(neon_ceq_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_ceq_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_eq_quiet(make_float32(a), make_float32(b), fpst);
 }
 
-uint32_t HELPER(neon_cge_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_cge_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_le(make_float32(b), make_float32(a), fpst);
 }
 
-uint32_t HELPER(neon_cgt_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_cgt_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     return -float32_lt(make_float32(b), make_float32(a), fpst);
 }
 
-uint32_t HELPER(neon_acge_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_acge_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float32 f0 = float32_abs(make_float32(a));
     float32 f1 = float32_abs(make_float32(b));
     return -float32_le(f1, f0, fpst);
 }
 
-uint32_t HELPER(neon_acgt_f32)(uint32_t a, uint32_t b, void *fpstp)
+uint32_t HELPER(neon_acgt_f32)(uint32_t a, uint32_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float32 f0 = float32_abs(make_float32(a));
     float32 f1 = float32_abs(make_float32(b));
     return -float32_lt(f1, f0, fpst);
 }
 
-uint64_t HELPER(neon_acge_f64)(uint64_t a, uint64_t b, void *fpstp)
+uint64_t HELPER(neon_acge_f64)(uint64_t a, uint64_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float64 f0 = float64_abs(make_float64(a));
     float64 f1 = float64_abs(make_float64(b));
     return -float64_le(f1, f0, fpst);
 }
 
-uint64_t HELPER(neon_acgt_f64)(uint64_t a, uint64_t b, void *fpstp)
+uint64_t HELPER(neon_acgt_f64)(uint64_t a, uint64_t b, float_status *fpst)
 {
-    float_status *fpst = fpstp;
     float64 f0 = float64_abs(make_float64(a));
     float64 f1 = float64_abs(make_float64(b));
     return -float64_lt(f1, f0, fpst);
-- 
2.43.0


