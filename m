Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0DCCD98CA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26T-0001F7-PI; Tue, 09 Jun 2026 15:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX22I-0003kh-FS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:23:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX224-0004AL-MA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c27fc587ebso11608825ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032899; x=1781637699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJfpy+xJLZOiImz54Y7mNvfbbMCkdR2h/mEqIv4LlnM=;
 b=Y19brQtxTrKpA36Fs2B7X98iAyiFPuzIvtZR1gtOyKns9FtgSUZ+1l7YUBgYzLW92N
 g0TEAP56Uw3gl6hgimcN23TCDQXP2xPGXRf9FrAGFfN4H/hSDUcir/x6oyKCAy9Fh1EO
 SEqxJSuDTZ3LSjtiy5Rf9uI5zCTQ+4aBB/O0wGg1QXXWYbBByx3+p4YbY4eQtcr/Bnkn
 bBRTFBTWa9fX3KWjuLlQ8qEP5boY4FVqUM4txNvnosNckfIv3Xd3q820f6/WcsUXb8Uw
 lG56EAM51q35izs8IGeS9GDQUDIdTkwpLWL2mgQtIkGmZhijn1Zt2tCGOnESK+6lwmXS
 w2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032899; x=1781637699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tJfpy+xJLZOiImz54Y7mNvfbbMCkdR2h/mEqIv4LlnM=;
 b=mEQWTfVp/YzGAV1Z+Yse0oVYoWwchLdpssPVSeZZFgYEZkE3+rhEeC9mGwca+EJpix
 1rGvSPgKSrbEEw9WUAgpeKKevynObYg5at3wC1SvsrVnwLXctvKV7B92UQPhs2Nn40lO
 GiNHKJ1yKOhf/txxLYDp3FeOXVpYbo6pkYFbLeR9wpCfnibQHlWFnO7Plf30C+NubaJu
 a4ECol59wKunoi1FF+zN4KY/MCmhHAxFErSjoCIFmlrX0sln/SycgW+jS772NCirTZrW
 JUTRPjiZF7wGiLyuRIWwiGLZ0+GRvH1bzBr4CuCVuazRA+Mjrw5omLkveqFhGeo/chhy
 VazQ==
X-Gm-Message-State: AOJu0YxZA5SxDqOVvvIbTKp7jBiyLtumF2RUFmBdzmt7Q8uszGtNNFCp
 FzplmRDitgiUusxWnimO8TcQL6Kz2EUsYuHlrXMf5mY4sKeIdbcXi7F+gS8O3hb5z37sCpcljMw
 E49jbjPc=
X-Gm-Gg: Acq92OF8DMQcbK3rzF9ZCW17yCN1HRFubLs8X9vJggzQti0ucQFyvrPYHDSShj40dwB
 620sayUNpwfeqzAKOyHD1vg69gmNG1yH+egIA6EOZW1qE8meCfCQcH0Y5/RJ5JP6KzpI/zIwZy9
 kFESc1T4mIS7gAtJAy99uktbtrDFG2k33YYIyvNn0AL/SexKvEv1QoVYHhSae9iyk+tTQkDCKH0
 10uHqWnZEsCsmFnXmgzmIu3IOkWLFzR3MG/p6lJLg7uy5r/ruRxeL6rL7qlystiaQNucJGc07od
 asOSOkOpM1SqWGqLuIPN9MYxtAHiwFMkCViI4MCIrfwDLvFz1Bal1V2oawKniRkGliYgxWCZEHJ
 5QUYp4qIB872JBUVj/ZoSTs0IeaqaFUDWSBDbaMuBn6EzN8VkJWsUqD9yuDlZ4nnKQASUpxD/1K
 5X2QS85XvJDrwAYumvuitXhiR7SCjlCU/BlXfMtNI=
X-Received: by 2002:a17:902:e5cf:b0:2c0:d8ee:7d73 with SMTP id
 d9443c01a7336-2c1e8218185mr240638355ad.37.1781032899310; 
 Tue, 09 Jun 2026 12:21:39 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 36/45] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Tue,  9 Jun 2026 12:21:00 -0700
Message-ID: <20260609192110.752384-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


