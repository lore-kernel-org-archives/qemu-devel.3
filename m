Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F240CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPld4-0005nx-8r; Wed, 20 May 2026 14:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcO-0004Jy-5p
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:08 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcK-0002Bz-Jq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:07 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80148ae949so2154706a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301558; x=1779906358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuGasVrTDp5bV7ix67mPvlZpXL4SBKk180Og/sZBgEE=;
 b=ikCmdbvPpacFphfOKz2IfMFxCnwBgIB3O231WWkg2xclCdOHl9Clj1bE1T6mqUnHV7
 U05kR3Sv8g3rts+jehi8ZDZnz8zsoRpaQnTIjOfC/uAWHRG+3V0JJOfpsenZ4yVv/cg0
 X20Lx8Dh5672Iuv9LkLenADm4Y8AU1gfy/+Xfzl7nShzHly+VWcUG4zU3Gcm9TN6ae4h
 vAkPOTm3Iaszt9wezvqRHHi47y1iZPRCUEYC2ky4tSFYn8sbe6q8ShZLTPmUS56Hasbn
 o2AHOmHsaCEhZWNysCW/0REFFP++oPDsbSV45IG6fmX810xGsxLsLix3NOytR+4Kyagf
 BH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301558; x=1779906358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PuGasVrTDp5bV7ix67mPvlZpXL4SBKk180Og/sZBgEE=;
 b=MVGHC6kmTmmn2fQWSIK5yBZ6q8YBb4uSTL3tgnV6ZQ97R/uas06Xw7GjsO3FonNRca
 dov20cdols4euf/1m74F4L7tFySQZaiQUtVqJ8stghp5Ng8gUsPl4cUDXP7UPORyBEkq
 2yIL5xyBemnvM9jFtvA6ijpSdRE5AkIHWwCo0zbxk/is8y0m4UkVqgbWDxJLaaDW3f4W
 BOlMaxJkVzHRhu96DveDYycpZnMy/l4gQnk7IayhnDTRyaOz1etF8170RDJciTA1w4+i
 sdIA8yKG8gEH56JyX2NvQkUUnlW5mBtkfTGMN/39fNpCBUVHfvFqpCPTRL0xBOVb5WVc
 c+bQ==
X-Gm-Message-State: AOJu0YxZMNItRH8td1/JGWHLswDOtAVfMVU2AvP/yut+uXgcXKFzuvIF
 0SXuzoXT3F8PDy0+aCJ8IxoI3awkevmSM88qgo+fVbaTsTZPo7aQFMlwY5nbEPOmnsWXxnvfMED
 sXGTg2Ko=
X-Gm-Gg: Acq92OFvUMi6D51vIuAzkC6yPEodDfnxk9LqYOldUY4IalNHDyf5X4td3AZ7GB8hIqO
 zxCkaxd5ykoYTtWaxs6kMlI3KY9PhryYHna48X+Ixc+22BDdvWhAuQryiyvS+v45Za01P5A/Tn8
 QXrj/sW/e0Gk9w3K2DFmRgP9WjcAK+uMfMV8K5NBQiwVpx30AQ4/yDkxvJwRQyUuAUb+2w9RaAm
 iJQy+NbSM9aAjc0wSsBebzV9UUkGSxfyE0KgqnuawYaF5NhkBUaqX5mNBjfhfsvS04vO8EyzmPR
 bBtOQghnciz8OqAae7xMlRqbT65Mykdx0iTO+ZqzfKCkN6PfLxqCwsINcT7iDyyPUXA1PFhj7sL
 ehZB4uyvLpami8ooqEdAzdxoFtsiSpqdBLZ2nvv3R2iTilX7z8Q8sw2RKOkuoQYMk5gAkLMGY4o
 pAhx6+I3VbihVNYEAkFQPvpnF/lcZZ
X-Received: by 2002:a17:902:d2c9:b0:2bd:b50f:c1bf with SMTP id
 d9443c01a7336-2bdb50fc703mr189938475ad.38.1779301558341; 
 Wed, 20 May 2026 11:25:58 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 59/64] target/arm: Enable FEAT_F8F32MM for -cpu max
Date: Wed, 20 May 2026 11:22:08 -0700
Message-ID: <20260520182213.872945-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a43b6367a4..7a47af9f5a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 875716d18f..83967da12d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
-- 
2.43.0


