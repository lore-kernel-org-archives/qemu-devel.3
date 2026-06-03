Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F515CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIU-0007Cx-0O; Tue, 02 Jun 2026 23:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIK-0006wC-NW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIG-0003m5-8I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-842319576d5so1742788b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457363; x=1781062163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHI88UZH/QpvzAoWJgsor4QkwAmJpwIvPrzZJogLIPw=;
 b=SPgRcQdia8t311B32VPLNkrrkiYDKGprseHolGQel7riS0m1R14mvb1m7SZR5J3nP/
 JBCKS/byj5qovRIcIUO//74pUouXV6e5DUHaG5v+5jlJx4rG0CVhwfPSFmKQCkI+dDkZ
 aM07s/9cui7ulwKYiQ0fugtgDDG9CDBzO06Cv+tqLhFiqLVPRhLuxrJzRSJPVsHbggUr
 GProyW0Pv7itBHrJ7oM3P+qILQsmwT8+NSkqkz2y8XpgVa08bIUJ0sZn+/k4osAlhQC6
 ItOsKVEJM41ZSsvA2E+26x5UBvOhNUD/PBKGAsuod+Nib/WjM7eMj9Vx5X1yP09VpBmd
 ZjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457363; x=1781062163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IHI88UZH/QpvzAoWJgsor4QkwAmJpwIvPrzZJogLIPw=;
 b=E6rvft5Q49eW6bUJxtsRByngdEzHGp/QZHvvEyvTU2d0h0bWImcpCEFWJXWuf1IAwW
 Xmv90ZnPfIzROIYHb1eIhQCL3QjZ3G1ohlj9ucKcaiqbeZI6V3OhZwtolBQnDBHuRkZV
 be9E2E+/E5bScfwDmHpK5iXw2UtJpxBeJ+ygC1v7YuHXZCIKFoaUYAxG05PRcT7XWfrQ
 X6Dpb2UOnh135rN2JSKqbnGNdApNl6QQgeFZvPClpFNxjSwnjcTON+KOA6ZaTxIm7D9v
 EV6enjwAsGFmFj9Crk04oVsOkYkbXEGYxMRjaycGoZm5AH5uwc03VN1/qd7d9W4F+wAG
 HwYw==
X-Gm-Message-State: AOJu0Yw1g/VSznFySM7ewvC3Yr17U7D0nCl5nPniLfDNxb0ixUTK0CqA
 YFvTOGgObajHKPx3Dr+E2v7F3aBstKcFIYtTzqcyTpHDDYDykOVlC2bOxW6gu+TVXtPSO0j0yce
 ncoDrwLw=
X-Gm-Gg: Acq92OE8Mk98Dq2DxOhKWPo69ppiGPx7G+CW/97cp97dEWSpIhTwWmoTrCj+BPQO5PK
 Hzeac1zjnU6J1nv8mXaPS1BeEOZEr+VXFFx+tvI/Tu4NgMkYVJy9sgohZ27covj2XXjWRAIP67A
 Re9EofmhejoK27c7kXr3X0BWYlE+ZaqRUaPIgJ2B1Ce7OoCC6SLJqbIjagP5P8Ye7RCakiFAYU2
 p4npE+sWM3rNkWXhlWnTFpiqMGb69iA9T7R0UfOQCOCfIACu8mPIX4zuM/ryiMpf/8X/z/jC5vO
 ntcBdWWYwbumaQUiqvMpGK9dI5DuTWtEh1P3Or7tZvjlWRxJnRfBVToJNbsGt5ykt/puAtNDMMZ
 rYUE+Lo8bemwgrDD4ITR1mnMfNWiAIAr+agrHyzILGvn+9T2Mrhq4/2lybilweuCORNTgB7laAE
 EIHowEW1+G2f2RTfKB4I2rHDn3CMZNVwGM2apksKo=
X-Received: by 2002:a05:6a00:ab85:b0:842:5da3:9b8b with SMTP id
 d2e1a72fcca58-84284f3d67bmr1436865b3a.36.1780457362629; 
 Tue, 02 Jun 2026 20:29:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 36/45] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Tue,  2 Jun 2026 20:28:45 -0700
Message-ID: <20260603032855.106930-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index a82d65a681..be33fede6b 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -227,7 +227,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
     GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
     GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6ad841c51b..1e2d1311b9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
@@ -1397,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78d1938656..8d786f9dae 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
@@ -162,6 +163,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
-- 
2.43.0


