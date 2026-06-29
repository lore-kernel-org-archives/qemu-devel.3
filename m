Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FBAC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgO-0007Ov-QX; Mon, 29 Jun 2026 08:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006wJ-37
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0007Or-FW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493b5d61302so2326065e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734456; x=1783339256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5TGiIZV0+NuMKKDKuPnWW4YfUP9sTJZqjh/iUot3rJA=;
 b=X1wsNS/47JFcc6fgnNekOVdpZduxiWnp4kuF/QI1PjSJ1WF217VUI+zVk67iylOh6a
 F/N3kSVi09A3/oSdo0/mHC4NVzT/0kaDPIxg8YeXiMxUpwVKqdbzO86Swe3x186jZueh
 IVa/mK7nGfyo0uJR5PHVeTC6ZXQ+08Y29ca8G62rp0mOD8bqy8yYgp4VyB2rGdDKXkVQ
 YdYW7eYdqVaw6uFyEtEqI3BWxY8MWVKeL0dnLCn0bea7bgZjK7d+0JaxdZiDAznWNDfw
 xWSroGDB4vC8lM/fqk8Gg95utKT4KP4VDwUEet/3SjsrhUJ7vVsFEewmt/j4HX82v+ue
 iEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734456; x=1783339256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5TGiIZV0+NuMKKDKuPnWW4YfUP9sTJZqjh/iUot3rJA=;
 b=L5McnHhQXHV4dIzjyE/4LJ3OTDOfPJfv7eQEZYNbbm3b7yEYwvf534Wr1DJm1+OZOn
 5ld75Uiyrz4Tq7dyVtHdIBZUAH654h6ZJzjrYVNVMwzBc4wHYBmGxWK1RpvoSEnEfT0T
 gnQxK85Q/pUjPLjIexgRT0ak1Z7Q5SUmr1kvR30eYea9IxfXxNWy0iiLhI2H2rQDAEc9
 gEac7M/k1Oe2pZgwUKEx9WBQ543uLUTrRd1KssiFeZ/OLI07Gg45LjMhopTK1ZbL4pVg
 Ptb4B5j2eWyMTVdV0E1Flq8UwjRItj+LT+aE7sR5LjcNeia+aHcatfANg3auZN+Dgka7
 jxUA==
X-Gm-Message-State: AOJu0Yz5OStDo/q9whaRXH6qnCob5ZrKzN1I9wYcEegj7ZLT40EbjfC4
 sb3sid8C2rOFu+pSw9L4WGaM3IyQLaPg4iMwm+g9Dl0rfuJIi93p2OfKUm16WSwrRhLLzWXCqS3
 v/mNk
X-Gm-Gg: AfdE7cn78zY/2YRsXi8BSOWs9LVtcdK4pGoxOeRt9QBHKucOvBT1C56zjseBuvcDSqx
 yYvda8gdn4+Hh1l2Ct6KCYwvRQZ2T8YX2xIY8zOh9uqtdJbCEQjrHpsjbfokZ2+OI/XF+fjjAqC
 esd+SXxbglKIDz/ELX9EK8vpOx7iSCFlFChNuKGjdSZxGJjuCdqCJzYwqYgRrRpF1LYCkw9rWU9
 zuDIfAgLmI6nFwyK4YEPwTqyVNihhfwhGf73t/wKPxuW7ooR9F9g+bXfsAlYU2A9YwlHFWge36/
 KCCy68mWEV3zksoRxD+hIuJaknhx67M2XDdH+jfSXc4sihe3dUHKUi3OuasYlbbICjewO7QP1/e
 huyfQ2fCOVyav4xCXnxfPCY2B2nMKuzhpRjKeWp0bd4UL7OCzFF5BZPTM7Xm4Iy0f67BUFlxovi
 xQg37Ap/9XZDGAWbCf+JrqxfyPGcYEwWpoBzxSfDsgF56kN+4dGAUQlYcJTShVrN9KfR6Mzpavr
 A+rXf7u0rgoMplPScrGbA==
X-Received: by 2002:a7b:c346:0:b0:490:b58f:4d65 with SMTP id
 5b1f17b1804b1-4925a1f2e14mr283424375e9.15.1782734454324; 
 Mon, 29 Jun 2026 05:00:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/54] target/arm: Enable FEAT_SME_F8F32 for -cpu max
Date: Mon, 29 Jun 2026 12:59:57 +0100
Message-ID: <20260629120032.1645265-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618041517.573469-11-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0b4623139a..a3a1607ff9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -169,6 +169,7 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
+- FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 0f96bbe70b..20b9838520 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -235,6 +235,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
     GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
+    GET_FEATURE_ID(aa64_sme_f8f32, ARM_HWCAP2_A64_SME_F8F32);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e4a8d7a2f6..e9eda8fbf1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1392,6 +1392,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
-- 
2.43.0


