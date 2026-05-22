Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FB5CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY3B-00030D-PP; Fri, 22 May 2026 18:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1X-0006sa-IF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1S-0002yZ-Bd
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so51855135ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487627; x=1780092427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BHVbECGtWD4DzHCzhYB2agsFfNWuyph85yygpzdM98=;
 b=eSNlw6nSJ8Vr4Q2G/8OVcmhCu8ap3Yi+r9u822BIskGs1QbTRh69dwfCgAcgCSijV6
 /3932qhx0L1LitmSQqcRK910d/itxQtwJi3PF99TL4W/pK0WfTQE8JURgHyQ1breScXt
 cwrel/4uhPAFCDBcc4k4ue/Zw5YhhMPcZKaQNOMnOV+/xLXFEWZXDWBEmU7yz1nfkBhJ
 WJaSHs64lAqEwERaXjYPPmGqWpZlJKDH9KfVPzhqGAu8Lb0SF1nl+U2fVxfaRTB36v7C
 uuyWdAqYvhoEkw6FNAWium7ttw4yltLLcAETFmYVuifpSKKIYHe6WcvVTBpL/VSVJ1zK
 Y3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487627; x=1780092427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/BHVbECGtWD4DzHCzhYB2agsFfNWuyph85yygpzdM98=;
 b=DfdbIoRABvGj7/V9oVtNPapsdrt1a0Id4bT+z0uWbJnYYdgcMCOcxUgaEfmB6Fgy93
 1dx/VZUZOnhlgrkhgVu7KZCTVN9mPw72Qtp198I9WqgKvyKLeadmkzyYPAxVNhwN6iTG
 xQ6MMM4prWmVSsFDKYc5COBgiAQ4qfn5CMz2vVs2TJd+Ts2Rn9blrSXgHEiNTS1SuOw9
 N/vx1uJ61GB5aVWrG97p9S6hxkkB8KcuLxlKOShQh9n8cuGihqrru3eiV8UTrTMhJuTT
 hztDfMTbdRLpdWZl9zDgd+NuQBsBqYTtqBCHnJmbznZDeRmkuHqkJ6IwAXEPHPLZDfml
 i4VA==
X-Gm-Message-State: AOJu0Yw6E9NxAIbdX1GO/bY1L3Tgc23ThwfKT8fVB7mL+63hcRF3lhng
 7huB9Z3NW7RJLuhT+cP0sy4yAxQ130ET1vwwKMa6ofs8dxOLpHY+ja1+hDfedreRfLlOsTQ1jd0
 kH+iH
X-Gm-Gg: Acq92OF193/oeNS0ph9mT3KDyngpuRzV216tz2Fik2JvxBP/Wo9ZNXsBg2FI+jjhJ/T
 LVNxPsUmfPTSV7i7A6aDTpa3ZzAxXpASyIHns5Zho6hUqqfXJE4nEELsJg+Ry/hhoaZqd9e7vq/
 GPhP4qdiQ3dR8qP5q0ChhWMTGNvwI4vBeAxDmZbzzZ2/VvfIViZXxt8tGxGuJEov9sJxZS9edmV
 l8D6W5FvV/2pdVgItmErK4cmGXuaeLjiYgWKMZkXzwIFgP699T5t+76PKcKasKszbFWdL/26jmG
 Qt37nT3DhD0YEzMJ18bIidagXURqmn6/MTtT71UTMUpUV/xFNZo/+yFTpknMxATZQNG6Lat3V9I
 aK1oeo9fFD9v+zdHg8Rq2MUQ0pHL0JOj0Cx8nbsersQoY4RTX4WWojXJzAiSiqQBp5o6gMYFYHf
 q8kpAAQGtfzdra4Dy/GPHUGANWWs8b
X-Received: by 2002:a17:903:2388:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2beb07e9e15mr58671185ad.27.1779487626980; 
 Fri, 22 May 2026 15:07:06 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 64/64] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Fri, 22 May 2026 15:03:06 -0700
Message-ID: <20260522220306.235200-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 160a6c7769..c086eff927 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -171,6 +171,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
+    GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7a47af9f5a..492f70fc8d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0091b8d337..5974e9ebef 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


