Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A3CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSub-00081J-HX; Sat, 30 May 2026 19:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSuZ-0007uW-Bb
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:16:11 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSuX-0000Iy-Fw
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:16:11 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36ac67f489aso4597594a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182968; x=1780787768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/Tioi3dpsi0F/SXE2FE6voGg8/eCNvGNXOCYhrTQy8=;
 b=fjHRewbTzULSBHNvJKnSZvFopCvOjXnvkM/3qhBwgigBGYpFxcbvlW5O5iXyK6M1dt
 u8mCc44TaOfbOFScsBD/VhtqElo/079NVMWGRv86Fxh2xi5NylRCA3wSRm6B3hpB0fRb
 c9Ph4yfnGHElfnLfwUIVYRY6uc7nCuGiW2jXsTaUjwOKDkZBI5pvHCqYaMBnCJPGqU+I
 0RyYeW96I5uY2iVgXEo54UFbQxd5I7GOR3K0NdxdXjAqh1hLiiNE1hPcImHVgfsnCpNk
 tKUmD3rdAII3Jn3qASSusK7yivsJCJr2kD6T7DpnSrwPVWeuiFc6iAkzAjgg2nkk9Voj
 s2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182968; x=1780787768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/Tioi3dpsi0F/SXE2FE6voGg8/eCNvGNXOCYhrTQy8=;
 b=s1hc1kKC1dSo/AQItR31sxKBZD8o1GBpiV/0KT5UHBhK4JIfjFhsVym8TzHJ8qM/VF
 G3ba8wTRCQxeIa7HcOzFEnOY1zz6ip55tiRRsQMHAAR1Y95sYbd+3ybgFjsOyER3SqkA
 VsxZ25C4ClDnroRh2XIPcDx3G84K2e/EykME80/WVnODSlVV3bYWVsN0pnOU5EFkx9Q6
 nAJEzpMsiUDJtABXuJZG7p2+/PK1damFT2Zre2UDXY535y53+avLOxx6Pb1oOR4fn6ed
 EEwQRbgjlOIMI3r7ozQOz8Cd1xbyAOm+NF5xY3sv9RVhK1ijTCgFvd9vFxhe+Pa6EmwO
 FeAg==
X-Gm-Message-State: AOJu0YzJLXk+DSLYy4iUVD0vRKOoKD5SjqRTGgljKbVNxkFPigNpCCs8
 95zvbmR+jVkhgMfK++xJvP8Z/NVCu+r4nPWANgs5QDJGl5KV+LDHbPPoxWDO6MQIS9EtIjuYlgG
 VPrFjKic=
X-Gm-Gg: Acq92OEdDuE9VlovdPC2CVP5XG0VsJCZT1GkMZHzI8hhxv65k2ymnWcqeUyjVWsNInl
 4dNYi/79v8xgxbxVGiSStPpfLli7Moo6AvcjCK6EpcPOwOYUqrdpZLLPXdYeTx83N0mJ2smayGz
 mjjLnI97yGJVfqv23kbkMRaQ3KWYN719fxrGp8r8WeohCXZtc3wQtjTs9jt5yNi5z1QMhval1kU
 0WsIeZpz+q+z+XdOMNCgOHbqYpBup/PsgOoqMOOQOt6B2wit7XaZympeeE6W7N/5ilE+vVmr3El
 JlAaoJp12AhMQz7+9VmF1kdibX+DtP23W6RkzYzPdpgeX9wrxgQXNQi3HIoi7AdzHLkSENcSHJk
 M/Nd5Crb4D3p3+pJdtUD0h3FlP/RRSEBnsFEUu2/MSJ++GCFgClRdhfP/XBbd7iVSG332xy4RT4
 W+/Zy4LGp02YnjQpHuEzpdKPW8CqLKZGr/J/xCGbs=
X-Received: by 2002:a17:90b:3606:b0:36d:630a:c4e4 with SMTP id
 98e67ed59e1d1-36d630ac782mr1664470a91.3.1780182968027; 
 Sat, 30 May 2026 16:16:08 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc0c3d44fsm6370038a91.17.2026.05.30.16.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:16:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 41/41] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Sat, 30 May 2026 16:12:29 -0700
Message-ID: <20260530231229.400441-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
index 7864765ba0..4887a3a7b7 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -172,6 +172,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
     GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
+    GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 15dafb9aee..15c1ece4b7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1399,6 +1399,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index dcfb4f2073..64b2a87e1a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -67,6 +67,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


