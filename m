Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ED4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2B-0007HU-2B; Fri, 22 May 2026 18:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY18-0006Lo-Vg
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY15-0002VC-5E
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ba856db1c0so57507715ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487610; x=1780092410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7FgucQIkhCyHgccCw9hpCsmHHiR1DXe5MU7JGwGj1I=;
 b=xMF03GjWtQcxNTm3geILaqSpYgEd4K2fn5Zl5k1Mkn/yKQGv65wO2wK7gG22wRo6V5
 LRU2qqU9jDRdo2TxZRFi0h1egjH5tiy3nGp1b4f0I4I6ITty5Lid1GqYxsEf8vkfjAI/
 jejlgjmDRQM2lKzJrNOeBEbP8KP4SWy71T92LCgsmlRP6ac7ScEYgyu2oRsAg9GyjVjp
 r/aOUqgV8fGaKjOMjWyv6d/xcFO+6g5YURlmTTb3UG0MHDqQVlPIbO9Qj3OfmHEN+8te
 4rNBSCIJCvml8wbUZG3uJgBBVjs1/8PISmSEQgUww5GXyy+/LdnIksWsNJrfK+I6Fzp/
 SUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487610; x=1780092410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V7FgucQIkhCyHgccCw9hpCsmHHiR1DXe5MU7JGwGj1I=;
 b=o1oiQqYWU7tx0PIfTbBlnzIQVqJN+NYqJkIPkRocyKxUzbrLeAMo6pyOMAA1dMh7Oe
 aVkYhVHMzrej759o2OvK3ktoRKf4KaxDu3mEgSavdWiZbLggeuPGuzLnFqLUnwMIu2Aq
 9o3ta+VT0j8lFCT21NDQh0pP+8wYX3Q1mMea85ZjWvAsax4h5s2Io7qG6SPb/QILOsCt
 ktpybC8VpW216keyySQ5mHug/5WZ8JX1YfMlwY+DTULij9JyXx4Mg7TpOGTCpOcnl8DR
 ihDmnk9VjLqNleRrznvBIGQhc6k0h/N8zMcs5ffCfzzMKxBjrUIIE27twaDQNrjj9Mq9
 ivCA==
X-Gm-Message-State: AOJu0YwO/VWOs4/2VJ2InJLQFq/+SbiSMQtMdOt3LdK+xbRwOFYTDsiM
 3FmSuLdfFVA9gI6ehedK4FqreuzeKV/L25PpN+4rYcdMVmYwozrybind9hZSo1He9JCJjMT3zL6
 /ivGo
X-Gm-Gg: Acq92OF5qU2Nrm/Dy9Rrj5AE0zMhBJPrv4UchE47/o1dGME95UZbdJvQTQsXqD+i5Yv
 Me9m0oZo6u+W/+HKWzaCSypcKUsUpz2eM71ZHvEMyeiR44ELW0cOydhHB2tU8f39nUdb/J5VDP0
 uQtbBPu2QBqkopC0xG6IJae5SXTtyfzHjpYwIO2wYHsatdG9bADFcK2YaPX2DXCCOsnHv7dixxR
 kLRNjZanFIsqw3cIAN0zsi5WNXeYg9xAHTJ5H1tSV1HsmfCG45Hb/AgHeRdxbB8F5xu8JdKNm2D
 IAYnmJEszYHJijUu5xMWeOIAU2ZqyE1VcLGYhVixTEz1wT4fwBTL0jgB/n9Zn+MPVqdZsEERpTz
 VuiGLuRauXAIoz9ies1GPhFEN6xByLkQnd1GgrqmkRSB37XhtajLHY016qiXi6VwDA89Pif8UaS
 xuyAN1TecHRhmeqPBnhhAP1lrMNbg0
X-Received: by 2002:a17:902:e745:b0:2b0:6a22:5165 with SMTP id
 d9443c01a7336-2beb0631a29mr56887855ad.7.1779487609599; 
 Fri, 22 May 2026 15:06:49 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 43/64] target/arm: Enable FEAT_FP8 for -cpu max
Date: Fri, 22 May 2026 15:02:45 -0700
Message-ID: <20260522220306.235200-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 linux-user/aarch64/elfload.c  | 3 +++
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 10 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index b5735a000f..7674e308b8 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -221,6 +221,9 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
     GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
+    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
+                               ARM_HWCAP2_A64_F8E4M3 |
+                               ARM_HWCAP2_A64_F8E5M2);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index bc866c5a67..8d0c057902 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1391,6 +1391,12 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8fc4b2a3f2..aa0c0ee1c1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -74,6 +74,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


