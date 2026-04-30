Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042B6FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFB8-0000Rt-Iy; Wed, 29 Apr 2026 20:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAY-00081O-Mv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAW-0006cg-I0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso190961b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508535; x=1778113335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=q3gALxdR4gZZy8lR0ybDmFSJpYUpcjx2vwIZAZdOe9rhH2ZANkXhKS+2V2VRTny0LH
 x7yX3eaDIwQ4pSk36Kc+KE2FydpluN76pH5P0sQqwK5g3Gw0jJijbU5Z1Y4y3ggVznOp
 rzcdUD1t5leoRbskV5LlGEkbDsIFYnu1hslpOhaBz43mhJ2oV/iz2Xn6nuLzc8fdO7oH
 /HbFcI4iikteAwNsbkYU6kHRHSWZKAI9VShx/EzmWDW7kUNVfJOViECqk/lLxoT3rLYe
 HBqzhpi/pv5J7di+tY9Z5Ofzga+hvA/hNFpp4yx1y+pcJQiBEn9EnuR2XAk10EDspywF
 IuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508535; x=1778113335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nTIDtuillPXckV86mcaM2Utf4vRJVw8yqCVUR2w2Jkg=;
 b=RXr+XmMubz/u2DmseHxZycnIbSy7WzcS++oZyHmy/YuAJ3HuNhlU0qE8FAj048ikmy
 AGbF7srKy8yttbTHZxv9rG8rksRVXFRJzwv3bGW7ZoL7B/mcXZc6mI5eHtTAdDtPCz2x
 oOwQy616ca3Ks312QSnOofb0eOKGpsI9u/TI6DaQILeqAPnEd00u3aXCAvKdX1th1H+o
 rGx3UjPGHqpacuY+38agdKT5PnfS6xtDMLsdtJothR7WaRm2qdXC+qR8tRWuASLVF1Ae
 3tgh09yQC0d+ZOUrdklRY/7Cnp6ekW25KiwGult8v0eol8osvqHmIrH7Qj+fkTv6Nito
 KhgA==
X-Gm-Message-State: AOJu0YzlytG+qkWlnvYV5PYsDNODe/FAoKbNjiNQ4yAeHXi6VIlOncEl
 b+fvPSAmaSsfWtrgyfdazGebdLIVgB7tB9lQxhS6HKSBVgEi/NnMJiUBsPot3E5X4boIMZ4Umwb
 SaPy9n/w=
X-Gm-Gg: AeBDiesDxaimsdSXOgwso0YOKa7wuXAmF38WjzSrOQ5I+BvQkIKIpIXdIOIRUoCE+Wl
 ojbwOFFA1uWiGmD+/8x96tBXbb5afwququ4Qvt+1U6bNh3dknBnAXbl+QMtwaTOMer9vPJBeM8j
 8aHzCXSSSravJnBV5gscl8cH/357x/1D8/UnKVhKHU7sulU4fg8TrqFWQbFsxzl6UeI5z7QE6ql
 dl2G/aI3mwc+PcwPTjavzLdRpqI5hQIQi2VG51kgQuKt8ui1tl9vpyZpB5I12T10wKwkqlHgse8
 e9TXALnO7czRiFadFiZr5BBweC9GnB0sn3r4+rDYvFpSd9C+2JPU4uv7t+eQ5KaOKpc353B/8NV
 ZxerHAdVWtJ8UWN99fK+NLMOnZQV3/lZnCfRIaEc9acNvPzB8JdfIi0GvJNewsMXsq5h31EiTzq
 lX1t4hGlLlBQJLHifr5de+GhbJg+WZKUVheITks5It
X-Received: by 2002:a05:6a00:8e01:b0:81f:3bcb:af2a with SMTP id
 d2e1a72fcca58-834fdbd238emr761543b3a.26.1777508534797; 
 Wed, 29 Apr 2026 17:22:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 38/47] target/arm: Enable FEAT_FP8 for -cpu max
Date: Thu, 30 Apr 2026 10:20:37 +1000
Message-ID: <20260430002046.59739-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/tcg/cpu64.c        | 6 ++++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 7 insertions(+)

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
index cf8771d541..b6f0ca9351 100644
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


