Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0A2C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOg-0001vk-1e; Fri, 04 Jul 2025 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM4-0004VK-Tj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:34 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLz-000862-CZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:32 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61390809a36so178744eaf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639126; x=1752243926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmkPVB1raZaAazvEIlQJhAAcR4Wu9MbnTOBPTi5jEm8=;
 b=GXLKokaKt6X6kIIk4xuws5zZ954ZCmVseYXcsjCoNp1+f7Gsm5/aGCoXM4YUr3Ywtg
 3fTmDRAyRiVKAIKLsfnfsBjA/fAzKtkUHl5DMkmhhfRv+LkP+XO16frB7mjTD6fwxS5t
 090KQb30PbUrep/30K6UGJUnw7yijuNIMvlls2ICIuAw8YZN1WToRV5GDi3NJZC+PQAW
 ByqCdAUTxxO6Z6V6NCBvHy2baFCBbwYU+7DM26iF1wknkAs2IUNkSmlv+ydqcB1TD+s5
 IuYBBydRgNoKOgNL6RqC23OsAEMSKZPM9pnCrN1kOFu6+5TBthNgHDPwzLfnMC4Yxotf
 swEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639126; x=1752243926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmkPVB1raZaAazvEIlQJhAAcR4Wu9MbnTOBPTi5jEm8=;
 b=kFOYrQYIiH6mEDoSMgeHOqmnF9ob8atK8rRGC1WpXRCf8CWqyxLSXUCfI80yOjn8P4
 TNR4XcTQbj/+vNAU63okgxyZZ40aV9eZ6VF/PGAd0dejZNi3RE/dE5RFVlHsYowZhx6D
 ZztGFahIM9JF1DDUWyv+QBs5RlfObwNm3v6esE4ZENEupXOCyx9vBzj80arCFOIdDw3X
 bVkEAG8bAv29OWnuDi2u92UrxXLtY8aFZ0zkudh2LfDTkHwGJUwA1a3NJ2hfZGFsa4T4
 sLKYWvsLmv72PjF3eis//gZKHsO894RSKe2+/hiTfsyNDr0AK+jqqTvfPf/sDqCHTLuw
 KtWw==
X-Gm-Message-State: AOJu0YxRS1GRBpk1bfIOye1kFK7WncJNKz6AqwXLhc8VrdtimDdsr680
 OxqI1DRmW3BhULAdb/CKTtE8t+z2n3Ex3rQtIcp7Nrd/SJF/OBbhBmxAxsr7Ya5Cu6yhS461WFK
 jerqQNTY=
X-Gm-Gg: ASbGncs2pZodZ4zrqR0qNlQ3oK+fKP/bXrzieCJaMsfFNDXf2hScLmM31mY5ZWw3dZc
 hjzdSNn6bQjGBqhghF29f8oKIgNW0XZfVjOVyjq3lMrG8dkSti8/TGWMAWIWNIk0h1ObSBB/JZv
 Tkd0a7ElaDiRgkBZBpz2EVjVU2QjCP3D/ht3cEt/fib2CEQCeVbCP/oVe9NSpxJ0YQolhKNIewC
 wGcPvQaYQfOr2Q4SnPH7Dron2EMMwIcrquaaIrY45WScP8TKR9eeOdSmxzmceOtAbcDQxQ5MWq6
 YgY5QB+UNrTQlH9Ujf141UQcqX1brwuY0mExaCCgqS8FpLIfndFW4BqZ5KpG5WlLEq2o5xBPEy9
 VBSfLXI0nm9MYf0xGd/gzjSRqf2JPe+n4oud2xghnl4BIYo/j
X-Google-Smtp-Source: AGHT+IH8ZqXub0qchl7IkW9DZ0ZOWQsZX99q329JsjXQcZUYz2E6Njm1hD6kuU/Lr9u83ywNDwm4Ew==
X-Received: by 2002:a05:6820:f0c:b0:60d:63fe:2472 with SMTP id
 006d021491bc7-6138ff9d991mr2057287eaf.1.1751639125449; 
 Fri, 04 Jul 2025 07:25:25 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 067/108] target/arm: Enable SCLAMP, UCLAMP for SVE2p1
Date: Fri,  4 Jul 2025 08:20:30 -0600
Message-ID: <20250704142112.1018902-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

These instructions are present in both SME(1) and SVE2.1 extensions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ac4dc7db46..ff70bf27b0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7375,7 +7375,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(SCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
+TRANS_FEAT(SCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
 
 static void gen_uclamp_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_i32 a)
 {
@@ -7426,7 +7426,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
-- 
2.43.0


