Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77ADCD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S9-0007xr-8G; Thu, 07 May 2026 19:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ry-0007LQ-Ff
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:14 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rt-000293-Uv
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:13 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so1138359fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197685; x=1778802485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=ZYDPOqrtMwV4ZLPLU5jwO5gQ6iyh1AA9BMSbqDPla055JLGQ7tS1LcrBnS/8WycPnE
 f93JSvMHqz5tWf2E1pLSP4OmgVeyPGXMOLORw20oER9ZTCZIbg/wHOdLg/d6OWk1vaKO
 7cy+7fZ/HMZrLSVB+1JOkmbc61o3s2KM0ZP5IogPeMUrWwIHgCJkeW/meTI4oSrPmZFq
 wswyyetXbkdSmQtG1bgr/3hlh9HOeHxixXJ5o9DqQIb9h0RZsGSpOsNRKkAo+zzCM8QG
 fwQHhXB2UzRIeARgGIHm761aYOt4MmAFP8LiVROedRaMjZG3LMHXJ4xo2bDARIYno7wm
 PL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197685; x=1778802485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=CU14neBPNa2eS6SMouEhGKwiO/8RtIeuc2OU4xVyYuLdO+UWFGDaG87tdMAldIKYsD
 YA+YN/laRL0DpL7Q2NlBAGzv4HiC4vyqO40CSbcKO6mGo2mMSUhyH+9Bdhi8n/oBKpW5
 xFrNTyaVkj+CFBEIOgCj/e2mkuUO+kmizFzZBw8F5mwNfd9sAcuwwU2hYTd80sNX+5AQ
 ALv8rYSDj8FSBPtHs9GLRGhWr0sBTXNOSrFOCFh8t55nLYsfcmtP+NkgnfKEiHdzRHAE
 YgkqRtJE2tOBnm6fIjsEIeCTH0U9BYTX1XpZN2emC6XMvFf5FZWRK01rg6rbg6xjH/K0
 192g==
X-Gm-Message-State: AOJu0YxaphUeF7L9iS9OvdVAUJGpk6DAe4c3t/qC11kN95LDBGo7HYj2
 8VPehmcM51gOtIdN2HPAN5KybdFqju/EAWMAeRNpp3wuu1ZLwY18Y1+a9WifCspAvhMPo/RLm9/
 e1gVX
X-Gm-Gg: AeBDieufKGyiKX9NHNV+2eivC+DuoZ7WyD7loiKEnoxg1UBs0wKhBgWwpvVoG7Bkuk8
 Mc0huqh7AXmHUuSYOxG3ezhjB7dARoyyc3AXfnP8IuZ/1whghnamwu3K5a1NZyjRXcegpSmM+gq
 RF7iMLeaRFnulqwrphpulraY5+KIw9CXIsAxe9/lh33uoZaJhqGsLdJ2M/J4KOdk7EhLd743+gH
 HxMDRaeP/YE6PWJG11evZExl/i/FGzw1EF3GGQeuOwWHH/9Jp2zz0XlSLVON7fACZoEfnDVTlDk
 5BUjNC9hKlGaOjEdyeNa3cIfi8Txayh9CT2qsuwXu4MfMxGcBaJtsnDF0FZzsS9mYoDrW/xWuph
 1MBJm/jjqLbQzqpcd084L3vwvrUH253EdvLzam7/hFBhYtBO8u5W62iF6j7agKHMTVqhty225WW
 9T2hKwAAOnx9OLqgUDioWTqsPe+0U4eWmaB08gfv9GP9CitA==
X-Received: by 2002:a05:6870:8256:b0:423:1cc1:f878 with SMTP id
 586e51a60fabf-43526b03e9bmr2820957fac.29.1778197685231; 
 Thu, 07 May 2026 16:48:05 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 51/60] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Thu,  7 May 2026 18:44:04 -0500
Message-ID: <20260507234413.643512-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93cd7ee1a6..6dec7e045d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
@@ -1396,6 +1397,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a6b48f9c60..bee4e36dc6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -160,6 +161,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
-- 
2.43.0


