Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3345BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPldR-0006d3-2v; Wed, 20 May 2026 14:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcL-0004JH-4M
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcC-00026s-UT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so52762505ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301554; x=1779906354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=zNTtTz0ZxF0z5TiZy0NLJS+5gRq/bWnGg/GmNQPxSMb1+5+LXGYnyd/l/6dFCVIJ7x
 kSwzD+ChZrPMvPV6bImhE7W5wSPVM5vByiLmUvO22aocEXzFTw0EO6G8CoPaXxVsxdL3
 iSJxANi351M/YNvNdOZspNfS+/RVH2v1H09/tY5y1X2JWUrBC/YHvjc0TeFn8YzWx+Hp
 bgEtmwwq0KqLRtuGa0sS4raTM6D3yGan1NdPc/Cd3vL/ZVDjsOatnxpZbbTkAHPp0RSv
 0az/Sw/9IADTltnM2EPcIjCCMJcqys2xW1reBpU5OpGqpzC6ZVMeeshdMFpiLNiWDKC3
 blsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301554; x=1779906354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WfvM4tnhG/6BVEOEoQSi0TAhQsUGcLPgZYrpPCn+HNY=;
 b=F4uiTmWmfmowU9Tu4ouMlNU/pbhjFscOu0iYmQkn7oXD+ewbqobfDJ8ZlWIHLXUTs0
 /c5Fx/7gam5zvpfGLfkzFMopthW8ZR3yX7JWv2lGP2iRFICMwJcvN1VQB40+Cb+O3pob
 /j7QN7Kw7Ib+Ykybw8jSFepeaG8LAFKk3MGg3fzVhrEmOrH2Po9Ifur9qtRfwqx9sJ7E
 m53CV94ETrzdNIS4TrEcb+7wN2p389yaHQXiu3O0OduTHpxq4T2ORkzA5649Mtd8zvUY
 /v3eRHGgb0coZKwlYVBixFWe0HG+/UGNX8U5d8W+ChPDdWmOaTKp6ZsTdYQCyT68ZlZe
 m2xw==
X-Gm-Message-State: AOJu0Yxy59IEBvoySumAuyd2KSMHIJSEl7GvJe/tpp3nRSD3Ur6gZJ9Y
 9AkoGmuR06lxBl2a7GKX85By3KMotAUxYdsFdyBzf0UKbC4znAqGRPGya7fNNnfMIFyRFLHCMCJ
 lYU91vXo=
X-Gm-Gg: Acq92OENfmTxoYxukeybxDNMNR1SmuuQZkKyT0Vuo2LTj13kQlo0nYvJJfbPCN6ogB4
 HVwHK2XdKDW9amILapszBj6o2idWsWLhfoEFBc3NhT0YIVumNyNYH2MrGkjVIR6gZZydDlcEixG
 vTtffK78ZuO0IbtKm6r5yqZfpuKnvvaoXICC+Va2znIBEdszoDiG7MI7ryK3/LiRvoYoiBcReE2
 VOHjMxGDhIsDq65+AuNaDCukCsyui1n3p4ZnVSQWR8+tV7UDDHNjNQBSmao6KAh2uW8ks/1jqPW
 QGnADp0xuWP9Ou+a/xKODmwpicjthTc9zvTw5KIq52DLSSQjUZHv+fQUAVOQBxiEo6++UgWO4Pa
 kbtB7f7DEfpIRfGgcUxkVA7IuYZwy/XnlJ4LPKYhQNtG9rmtWKv+/HTk8ZAuqMXL/ysXgZagy9y
 lc8j1xGhEXN/m7CXhn2g8//pQzgP9U
X-Received: by 2002:a17:902:d501:b0:2bd:412:21fb with SMTP id
 d9443c01a7336-2bd7e7fa11amr282700025ad.8.1779301553833; 
 Wed, 20 May 2026 11:25:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 53/64] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
Date: Wed, 20 May 2026 11:22:02 -0700
Message-ID: <20260520182213.872945-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


