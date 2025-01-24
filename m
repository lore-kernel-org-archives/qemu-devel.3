Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80605C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMbA-00027c-MP; Fri, 24 Jan 2025 11:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYg-0004P1-EK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYe-0005bc-7g
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so23503265e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736163; x=1738340963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qyWI57HjjH2UZcir5oGvHNcHt8Rf9+v9mAHzWsQ/uTM=;
 b=av9luihHuEU/a3SeTye2+bM2F3N7RcFi48KwaRBVLe1vMaqNJuSsRzRx8RV8HdWIfq
 0thOM25gVYYVW+lSEtyISjkbxVM4iXp5SGXHRt78CpP6SKyAlCRrcomPGP9e/uoK6cTy
 L1x6TsS/njmdMKaxSeAM+gNPi+ZeKHb8PJocG1psKlUvnwHTvFhJmx0AmyNuXa6SVDZq
 9lwKRH8Oyc6ai4gAl1sJ1p8nXNyD5BVqu1/q8/leBsGnULpTltC+nRHrLgq03AFqNWKW
 ssNFETkb0yjyG6LMGG83VzlwTqdBe+AyMGVBM9MfH4MqEWy1p+c1n/EyoonE6ykIt8ji
 37SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736163; x=1738340963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyWI57HjjH2UZcir5oGvHNcHt8Rf9+v9mAHzWsQ/uTM=;
 b=WvGW9TLmbLyeaGjCVLHEHBc8mh28VCCQe97fzwg4C5YZ2pcNwwwQ7GZuTRlUSTIqaf
 6YKq3kPbQj1/6z+X0baVpYeng+DxNg/EaU77sNHsa9EUV6Bf5/iYT3jsr5WfJ6DBjc+y
 gwyAWLomRMRBpS4tSFddr8xF+VaePH58Jfq3F/Vi3jceElDZtvvjspOE8J7dj5GVGsLe
 pKDJYs4vHidF8vkbCVMrFNFu+xSVgSDNybo90j7Fvr0xbVTEGh2HQkxfLCNfXYJtMAhH
 ExEkOyaH2/LXgjcy4m1Q3k9oehGWbki2IYy3NrGXCRvBEwtUCUt+qLLD9zT7gD2CxsIv
 K/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNZ74clXEpoCJZR0dO+y9eBrTiIb8ekd6aaU+hoCDeuAovghD3xoxe75xUsXgdFAA8CIm6D+T8wdMZ@nongnu.org
X-Gm-Message-State: AOJu0Yw7tEW9RQSZIFugTiuxWylPKlK0hSPRMWHEZkHMwOwxMI9CzeuI
 C1hQRgVv0A33e41nJinHHWQ74zebP9x6mZtOwdqoiAKtw+eqrD4aenZgdjnU0JY=
X-Gm-Gg: ASbGncsVjG2AjbykWUDZ2iIcpZxGLf8J2VQSbu5Hvq9ByO1mwKDkBx/Vjwm2vEszfHE
 MVWxJCw0OjaBkKOSNOGsSx4HW0McY0Y4Wafslrwst5IIDNxm0iphIwkma43Xqckb34zTkbN37NF
 hInF9p6YQy/cwyutJmoTk2uKFZV6TITCTu/Sj+sMlxT+3YyizWMRFcE1NjD1InffiADUx4FwWHQ
 kbZqIXHWutLxegf1Dw4bGCqvyy1dsgiWuMzl7tGzcTd7NvY8PlIrXFLMGiKKerw9ICIGOnbayY2
 /r4o7XUUkX0=
X-Google-Smtp-Source: AGHT+IE1JGIhSIflvPplBp9/GZF6NDphcCqYF/gwjvqaxG4jRJ346gRlBmhCgK3PoR3z4PAze/Culw==
X-Received: by 2002:a05:600c:1f14:b0:434:f623:a004 with SMTP id
 5b1f17b1804b1-438913e391fmr335798915e9.16.1737736162825; 
 Fri, 24 Jan 2025 08:29:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 36/76] target/arm: Add FPCR.NEP to TBFLAGS
Date: Fri, 24 Jan 2025 16:27:56 +0000
Message-Id: <20250124162836.2332150-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

For FEAT_AFP, we want to emit different code when FPCR.NEP is set, so
that instead of zeroing the high elements of a vector register when
we write the output of a scalar operation to it, we instead merge in
those elements from one of the source registers.  Since this affects
the generated code, we need to put FPCR.NEP into the TBFLAGS.

FPCR.NEP is treated as 0 when in streaming SVE mode and FEAT_SME_FA64
is not implemented or not enabled; we can implement this logic in
rebuild_hflags_a64().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 9 +++++++++
 target/arm/tcg/translate-a64.c | 1 +
 4 files changed, 13 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfb16151577..f562e0687c9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3213,6 +3213,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
+FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 680ca52a181..59e780df2ee 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -157,6 +157,8 @@ typedef struct DisasContext {
     bool nv2_mem_be;
     /* True if FPCR.AH is 1 (alternate floating point handling) */
     bool fpcr_ah;
+    /* True if FPCR.NEP is 1 (FEAT_AFP scalar upper-element result handling) */
+    bool fpcr_nep;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index b3a78564ec1..9e6a1869f94 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -407,6 +407,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (env->vfp.fpcr & FPCR_AH) {
         DP_TBFLAG_A64(flags, AH, 1);
     }
+    if (env->vfp.fpcr & FPCR_NEP) {
+        /*
+         * In streaming-SVE without FA64, NEP behaves as if zero;
+         * compare pseudocode IsMerging()
+         */
+        if (!(EX_TBFLAG_A64(flags, PSTATE_SM) && !sme_fa64(env, el))) {
+            DP_TBFLAG_A64(flags, NEP, 1);
+        }
+    }
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b3e4ec136d..d34672a8ba6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9753,6 +9753,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
+    dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


