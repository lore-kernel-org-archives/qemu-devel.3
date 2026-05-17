Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSr-0000f0-LK; Sat, 16 May 2026 20:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS7-0006ze-T3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS3-0006pq-Gg
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:53 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c828daf83e2so414305a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978030; x=1779582830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=QdPtkVlrc7puKAqTg3IkZIFyN3+GQ7HlZJNUuISC+jW2cGoIL12/BWm86FHOgDZKFD
 AzfJcpqLmryBchQVJhQvEXbAP1AGSitvhRU61p+egNF8tOEd5dIrC/ZQHva8EtyU5J3x
 PQa0Z9WCgV2eBWZf5cKq645hngOt6GjsAyeOQfZRD7KkMHsQchF6mwbf+LFkD+4AunmW
 G4Co7CbXKr1O0lyB3uIOPzjfdSJ+6hfFDo0u32ZXqQcgO0ZzJwwUNyBHwGxKnXsMOMlX
 T7kiDvrpA+fdgK1ze5jFelKyFqx1hKswN3E37qLYcaKE2vSKG/xzzVu8fck+ckS0bot9
 tWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978030; x=1779582830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnvL1dEdpYA1y9JJcxfkHku7n0bLCdQETh28Vu/3wxA=;
 b=jOBPDkvly2HeAGwnpOQGeVbD5tHUPfvR/VxBBcAroDg8WXWIRXC4Hp2c1EHS3mIdEp
 qqW7iu7TMlTvWLH9C+/G8xt/z3a2916aVLHktcf519dxP97xounhpF94Z+4mZt5A/Ln+
 g7Ww4LgQHJ0MrRrZw9PPphyyC1Lhp5/uZQegG1hd2qIUM1N+sKYBLRPM9to54SqHUecI
 t0nOP0y6H2jhAqi0rFvm1r1NqoQpqvS6HWLuogOWujK4oNsKvXLovPD9HPcp+tYP5szR
 6SWDHpoWS515geoXKUwQYhKwwMho2tqtIA8zMoD9v2CwSmPYvSWDM7t3ap9juXzaGX3O
 OvMg==
X-Gm-Message-State: AOJu0YzekhYNWDg6ye8fe3Rc+kfrBGDqtb07E2XdznytophTRHZ6SyGg
 i9h94xTqP9zKjreAHJEnCz0AUJU/EsdfdK4Nsl7SysvYlDqmx97JHqxEeFdGVx/I3AyODEjjcuE
 Ne5GU
X-Gm-Gg: Acq92OGe3N3L3fwAB8Ihfj13DOKH1SmfxEUsAV0eNL8+LPzME9CGw1eBdCN8WHcnZuu
 xNCFowNlFtUKCIcGMDQlkZbQi2M7VqM/pqNgvHyigUNpxChMSDSRm6RxMUZDLsNz2W/AuIjDqKs
 u4xP79Pp22rRzO23Wfe02Z8QjW6srvrUNj5KEXFbvR+T4ZlyQzDvjtmHWPPtKS4DQ8BhRPSxFV9
 vbtNStkQc3goRP5ApV7GZGH5qcmnevLyIdJP8T1WL3Fo80Sz8vR94QoaWux0lS/1ejnYO5+XDfp
 NOstbb3IOyqRVdsMwVJgWx5t4sJ7w5+bTGP+Ivtm7km9r4eaRqrNBDdTlT4yzrU2iOX+jZrRLwf
 1Jpnv9ezEs6i/KDiuqDu1sLEMrsSO9pONqdSuSGPMF8js8lEDBCAbQZUhdfvCZLdMKpTs5zbAio
 oG8R62/xNO27slwWwqe1zfx17AzSQ3
X-Received: by 2002:a05:6a21:3294:b0:3a2:d79c:415d with SMTP id
 adf61e73a8af0-3b22ebbf030mr11725403637.30.1778978030092; 
 Sat, 16 May 2026 17:33:50 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 49/63] target/arm: Enable FEAT_FP8FMA,
 FEAT_SSVE_FP8FMA for -cpu max
Date: Sat, 16 May 2026 17:29:48 -0700
Message-ID: <20260517003002.321430-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
index 90214a355a..93cd7ee1a6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
@@ -1395,6 +1396,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0dd6b554a0..a6b48f9c60 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
@@ -159,6 +160,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


