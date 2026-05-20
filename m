Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABC2CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPleV-0008Fh-NZ; Wed, 20 May 2026 14:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcQ-0004LQ-NR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcM-0002FI-Je
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so35733705ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301560; x=1779906360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa3HEHnmujGMzO7KfPn4oNwAR87TmXmXSZa7aCzJKgA=;
 b=HTrue1X2NFEEZYiF7a6KhKHCZpfvunNa/aNrCkPcfizFhhi6pQcSlYmlIxN+cVojwt
 OYu/P7mI2n1mNfF/wvEnjLXYyJoi5XYUMohcRqnjVlbHEj6AskzAUK1cZSf9m0fcPdFQ
 4wvSZkW2gSn7ZzDasFZSzUKBZzdomeW4OgV+I9Uw7CvC4yTY0h9NM9lJQPCIhz6hzxpK
 RHO2QPtPicAMoAyGkKEf/43sFoJ0J0ODWn/0Weg/AQiz5ft/50QaqSWUBAvqRU38vrqT
 ido3Ig3KFXoE4ey3eFfRnNoVQelP7BFJmBbeVo0UwWLQWfHadlVE2nMQnIzy78n3IHWe
 nxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301560; x=1779906360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oa3HEHnmujGMzO7KfPn4oNwAR87TmXmXSZa7aCzJKgA=;
 b=sDmMteUt0bY8HfR5vhvhUj7fxUntSxiTkv37XFuQGg+L5+Y+C3KTcZCOWodsPSq2hD
 F/JrEfvzlEu5ccYqImg3LedDuLf0o6bsebfpHgyGApTUPezC37v5OH6vxYhXaAWlgwue
 ut8rdoQEXFP40tt4RAxsMwvkD0fA9xp89nUSYX1/FbfxjsVp2VZd3EseunLDlnybOZq0
 9W0a0mR0cJ9o/CwgEVT5IiWgIVCzxSzY/ZkvqLcbpExsoGXkkO8W4Kf6AadLPUWVlqn8
 Af6ACAykylX0x8O5J+HWXFa7MeiwHcc66w/QltEp8TuW4KgrneiCvIFOyvPfyXe49TcG
 n/Yg==
X-Gm-Message-State: AOJu0YwjQJ5RhxDjcwjRTst3yeTnDkYkL7e7U2+onY7cseM1IypU4JJe
 p6GKsI2lhkzAR8E+LE7mvguPJe58XmjKNsZ2TeBeQgHgP7+dWcgc6RUIbODY86tiPEl+VfDmx5t
 mve4d6fU=
X-Gm-Gg: Acq92OHjYkOuG7nxxxKxQPHRtGrd2a9Wmk6wAlxUmXUNlRvs7nFahPZsWLEcQqU7F5H
 LYo/s5RPaIkWrnylfy9pk3S/hiHdVk4gVX9FErIFVI4a+hkJBUuOBmALj1YV4uOop/bd3j2XyIZ
 9LYpR+PcQn0QpDX7LMbbUAtBNk4Z5jfOEbKdelNhcnvOS0E6y/6pC+bTssqyhsd0TZbYaCruGry
 vdqZa+qEmfDwewm8q2D3W7x4mcuL7nqeyaSe6Dghy0W6UOXcT4vGX4NokygbFQIjYqnEDgZZiRS
 bd/qqbeG14grbH+8UNwAH28TV/SlPIRvWdsvO9rLvIq5mBiwyJGKYYUf32gae9KLGcNP0DTSCzf
 yEvwHq1c6cBuCW1ZuxFGgCSsqSp9Qs46P7uRFyxR1HbKpA5tTRafMKxeVE0A0rzQNiQTdDowbYa
 sexgw3fzBqFlHXy1RBoTtqNwLs7DkY
X-Received: by 2002:a17:902:8481:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2bd7e94d29fmr170365135ad.25.1779301560254; 
 Wed, 20 May 2026 11:26:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 62/64] target/arm: Enable FEAT_F8F16MM for -cpu max
Date: Wed, 20 May 2026 11:22:11 -0700
Message-ID: <20260520182213.872945-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7a47af9f5a..492f70fc8d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1398,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 83967da12d..2580246a1d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
-- 
2.43.0


