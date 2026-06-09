Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BEDCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28o-0005Rg-F2; Tue, 09 Jun 2026 15:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX220-0003d2-Su
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:43 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21r-000461-El
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:32 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so3909243a91.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032888; x=1781637688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq35P8LUtlgDlG4GlgR+2riqk2fqmkHSrUz4hzTx3So=;
 b=hpA84PC1Ocbfq2Vb3PSyoZnoLlDc8DyXuY6PuzVYHLzgRG5lLTvhr1+lMKRYJYaeFf
 zTceLnaK401xMlPmXI9Ps6/vVdLJql5x2gtdzmH1uVJAqcoHQrU/JDBn0tTNvwu0QfqL
 ijL6TlL3BPpv5Lc7cs5ha1RlJIfjR6h53ttVJsqt+KK6kGHTApVZCK3axTQcXKAKraHt
 iJbq81IQOV0qqh8iYdTQHHohwX/yk+FGyR12/06ay3zjp3ZH41ybK6k2kddZ/kRGMOUe
 RDwvrX0MrPziZs+aglpZj9mVE2l1C45lrfDiuW7wKq8RsYk3WnEbfAf+K3Nxaeg8DiRs
 hkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032888; x=1781637688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qq35P8LUtlgDlG4GlgR+2riqk2fqmkHSrUz4hzTx3So=;
 b=gglhqDTKMxCnGzqh0iyd6c9MprWpou46EWM9Bku6mUT4akcDCtOs6+4Z9ZRtRa7uT5
 OQLpM/gRYWeG4RYMA1GpzfHZ9zNekE5u62vNwJxBSw5+bLd5NwZmvvPxFmHtIZ2sB9Ad
 ybZqy5eubo5397xF83x1+JXVkaENf6wK9DPXrKN4EX6qiylSIdzfihSj6kE+FzYR25mQ
 hGia/1AXeDXlEjDKBrK7kwUvkcPeD1VyUOZPBNxvNuNW3cKZOPvtHx0HBG4dSUgrpu+i
 jFF7e5Ee09soOg2aSPNolpK6LzwzxcMSEMOkHTOH5vrjUKvtmMUQACeayFDUC66GGQ1f
 FaUA==
X-Gm-Message-State: AOJu0YwdbGk10x7Y8l7xq6KcOjESkpUPi3JKF6olTv1syjWSh1fI0GQI
 yEAwQ5iGpisHL/GA60POjpjenS8j4OUebNS5aeny4jEOKHluRUbIHiuZp5lhF9cWoAZEAZ/iWrt
 o3YolAKw=
X-Gm-Gg: Acq92OFddpXi4qbEGeOPaCz+64ri94GD7mSXfKtR/K6uTOwsyGXwvTVK8608Nh45IiW
 VIRYMjBBllrTbpN3Ia1pcdR+Jp59mKHyLHqH8SC3wBd6/qMxw6GVd7XzD8HgfHVkwgtPTF07Puu
 t9jzjt4sD0aKM4cqZ8TeblXkgpHEgmxzXcrbrGDiSOQeQXZYVr7RMPh9VtFSoO/SWS50zVP0Y0x
 o+3wY1Hm41jigT3tMF603DP1dsII1+TjRYz3btjj2zqxf+Yq/3CU1L3l7NbAg21jpaqc6RIX10V
 EQGim2x3qmykDLA0hKezNakQpu8nFmLVO45eSGgteuYD5kHQK2ReH12YItr9lplcMKhV03BEtXh
 g/twwGZ5QWAgFgVJJ2FMVQ7sJ8eoDvKD1hJKyGYVxzC0r7hGWepSXWevCJBs+LQyJSp+XhKSZxZ
 soJojHoJCpZthO9YC4Dh/vNShpyy9M2JDTgZzDoKw=
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2c1ec80a4eamr170464155ad.10.1781032887883; 
 Tue, 09 Jun 2026 12:21:27 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 23/45] target/arm: Enable FEAT_LUT for -cpu max
Date: Tue,  9 Jun 2026 12:20:47 -0700
Message-ID: <20260609192110.752384-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 228b593316..5ed7a7badb 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -221,6 +221,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
     GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
+    GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1a4f50486d..39dc769a04 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 18c6355967..dc20632097 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -102,6 +102,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
-- 
2.43.0


