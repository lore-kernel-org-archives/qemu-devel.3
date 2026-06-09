Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D19CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23k-0004pd-U0; Tue, 09 Jun 2026 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21d-0003Ok-P1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21Z-00048s-Tu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c132ac5ec2so58671405ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032897; x=1781637697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stDW1+UpQH6kvoFVRfp3PC4PNJwkI69mgMy4PuRh8Bk=;
 b=MbwB+IMndPHxPdoxxsYjxP2CtocfJwFz1igIP0TKFjV+AmYioQ3GHhBJlhj05WQ5ob
 dsyT5R0ow50wzhDHBJusPyyE/zo1cDOLyj3lgmcCIIq0F83Lxrqnerf+wPnxbbsKwUwX
 qoOSFKOm72bAM4oA91myt0EQ7eKzMtzuwuvuPRrKpxBkzSJuI5tAV8fS2oDpNUY/CBLS
 9ynTXdWeS/dl51eVdoIv9qloX753VA5eGVAtSmC2Ar0KaCDlTornth2xLxZfoIH9aaDN
 h8r4TNqmZObVUAGYIV6S3j8vEkLSs1u9t0axM6efdmQpAEDaykB1LVboe09sUd+Ota9j
 LAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032897; x=1781637697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stDW1+UpQH6kvoFVRfp3PC4PNJwkI69mgMy4PuRh8Bk=;
 b=paymdzUNTxrKALxuRlkcMsk0UDacXmE86RsWuQohL61NqCIjJs/8KDXiQhgux4jFKi
 U1b5lPFo9DtTbWt6j2/Vci1+rjD5DThHQxoyO5v7J/V95/7Nx/Mtz7MUSG3Zu3h2Rivg
 NVZpbgoK55zm9NbOlv4gqv8CDrd/RlvCzGFSsFuVcCq0LG+M0y8GxfBCs2Dqw0QCin0u
 SsU9LTuBMEW8UFdoaDZQ2pEdEDoD6PpuvkwMreXn46HuhNo4PomkpxjnOwViJ0+1l0V+
 BY0AouXtEXMKx5yTOA7xyAeZcK1K5LasrHYP+U/2i6PB9ocfUDnAoEOq3+5PMWOnzV2a
 c6Bg==
X-Gm-Message-State: AOJu0YxEek53iOy6erlUfvZKlEJ8shA4R1RZMiWyyq/SxYZX73Kpe1Ta
 gJ6dV/EZoQUs2t08X/yiKaJ3tzktHRmOJl05NMd0CeclAAQ7vfT6ZDvfMAstMquFCisrMAhJloa
 QkYCWLPo=
X-Gm-Gg: Acq92OHqwSlM1AiVcFysGhqz5UttzqsMFfhFb4dKnVO28IEocg0wiJBPyUnwHzNznRV
 qsdCLtrb0JWnPdj6tjJBsdjHKyQKKwycB2kcCn6u6Mo0b+xg2Q7j4SB47sMphBdfTRdHFZ8S5yN
 5GsZ4c0KMBX/udxYg0ong9D2jXIM7RMBoKg8Cfky4AGdVN2ClckhDPqBzXv9baeBsn8xk+ySKFL
 YcUIMiwAOxcZcpr7Y7G8z1c6S9R5sVZLTD/RsgfYeqjqPGP/6n/gD/ZPyIpXpp+QrX0gOSKxAH4
 h3WUIZlVfH+LW4cK0VbbwiAxgK+yveUEmuHQVK9rJcmd9eiYMuGnFU9k7zCFp2loBqdI3ERjsrA
 3h376RKBlkWC2efkcCwIYQKF0WC/72y68FZFEbuSu0wzEpGaIzC8WUkM0b+QrKlwm73qjiZ5z9S
 UDju4gAVnwYFYl5+bsQqIgl1Vdw42JiAbQ9Qc443Q=
X-Received: by 2002:a17:902:e5ce:b0:2bd:5ab:af95 with SMTP id
 d9443c01a7336-2c1e77d145fmr243383315ad.0.1781032896803; 
 Tue, 09 Jun 2026 12:21:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 33/45] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Tue,  9 Jun 2026 12:20:57 -0700
Message-ID: <20260609192110.752384-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 2 ++
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 06c14e82ea..a82d65a681 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -226,6 +226,8 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
                                ARM_HWCAP2_A64_F8E4M3 |
                                ARM_HWCAP2_A64_F8E5M2);
+    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
+    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e466ab5b8a..6ad841c51b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1378,6 +1378,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1396,6 +1397,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 41fa9bfca3..78d1938656 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -76,6 +76,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -161,6 +162,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


