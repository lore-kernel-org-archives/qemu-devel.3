Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40807C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV6-0006eI-Gm; Mon, 27 Jan 2025 18:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUq-0006RS-O9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:24 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUo-0005eE-NZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so8838740a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020381; x=1738625181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk7p3KoLMaA8jIVTStdirSWe3SnWd0+FSfM/mtBWd+A=;
 b=nwKEgd41n42P9Z/QJibebnIX2HxAlpXQcQNxebz2zAwvvlLywnEg2utCEBJRP/UDCI
 WhEqfabPHoeYFdQntw5G4hPCv5jn7ifvO+0Ykr5m6J/64FeM7udrs3MmICSW10MYvGT7
 JIXOzkwu9Cicn+Zd1h8t1DXSlekQTEVV9G0pA7WMBoJf3LiK4zOwR7Ji3YVdlBD4ZgMs
 vhei0TbL0iWm+YfZQzy3NWFlibEdDWcIDpHYuKzhoc3B9OZRWEbd8GuzVjE6Oho7PouJ
 bPd0445KQuORt1hnruJaor04aP+r2DUFK/jy6kZ2Hg9e587kleEmdWTJfP+fhgd2ThBy
 8QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020381; x=1738625181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rk7p3KoLMaA8jIVTStdirSWe3SnWd0+FSfM/mtBWd+A=;
 b=lpGL3uKiDmpAqFzrDuIawZoyUq3UvIoe0r6/XvM4QjKJ7NfZTpZHETe6uFsZzYMHMS
 EP5B0ivWh6q3sFR3euCTiplXw0NcZZtMo92KUhNOpKsgi21SLJAtW145tySZNPDEkRXe
 R4ThtxvO/R3L0mvzCV+RK9sHdIfVUy6Bjgh7HKBoqXdU3JhZ/Q5YmP55NGibLZfy5+VG
 q3vRj3NXqxfx0dsOzK0YVhfz6+A0vZ//SyDu6nu7K1//enQJexYI0NXzmfk+fyi9n1HL
 MHFYXKBhswUU/dqH6x5NHcPIsMs7OzixCqogM89PYytS2piT5swKURdYR3kgCxZDbjzQ
 7nxg==
X-Gm-Message-State: AOJu0YzdX85i2ad2RivVf3ZLs9klHbcCYY495GS26J58t7gFxUi1ltVc
 iKm607UROap2r3KQWj+oABDWuBH9k5DQvpTjy8S4/K2fAIh4oWMUJbjEBl/Yv7V/A8vrE5qTlgr
 x
X-Gm-Gg: ASbGncu/29vVoxr1YP7kXPREvqEUEupPhe9of9d66oCSWZutVJcZEwiSCHV0FlvN1sW
 +9qClrHqBfgBY4edEGK9Jkx7Pl76Wog+hnXMD1IUfIz9koNEBLLsXzMO0kG2F+hQP2HjzKIrWqs
 gRs0Q5+Ah4H+BPaGBe89p3vF511/QnHw5bRO7GXO/sq26GedPo6tHHbT+HV3SvH2dVUcmzDtjF7
 f7YTy10NnvNl9yWBOTLARMpYAQfSyE3zp6qB5kUIRwLrtzzEZLxq9LkopzEfTWFXCU4Y3JSkiSW
 bEfVuAHsaHKQ8Ps1kQ7jcApe2ylnFQ0ifjef7yM=
X-Google-Smtp-Source: AGHT+IFU94cLxvKmOhaHXwjQSRam6lo6NR0YcI352psZGNaelhug4Mas7bemCuoZwIPipodGnhPsfQ==
X-Received: by 2002:a17:90b:2dcd:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2f782b17a01mr74838549a91.0.1738020381450; 
 Mon, 27 Jan 2025 15:26:21 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 20/22] target/arm: Use float*_maybe_ah_chs in sve_ftmad_*
Date: Mon, 27 Jan 2025 15:26:02 -0800
Message-ID: <20250127232604.20386-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since we know the operand is negative, absolute value
can be had by negating rather than abs per se.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a2ff3b7f11..970947e1ca 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5150,9 +5150,7 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
         float16 mm = m[i];
         intptr_t xx = x;
         if (float16_is_neg(mm)) {
-            if (!(fpcr_ah && float16_is_any_nan(mm))) {
-                mm = float16_abs(mm);
-            }
+            mm = float16_maybe_ah_chs(mm, fpcr_ah);
             xx += 8;
         }
         d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
@@ -5176,9 +5174,7 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
         float32 mm = m[i];
         intptr_t xx = x;
         if (float32_is_neg(mm)) {
-            if (!(fpcr_ah && float32_is_any_nan(mm))) {
-                mm = float32_abs(mm);
-            }
+            mm = float32_maybe_ah_chs(mm, fpcr_ah);
             xx += 8;
         }
         d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
@@ -5206,9 +5202,7 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
         float64 mm = m[i];
         intptr_t xx = x;
         if (float64_is_neg(mm)) {
-            if (!(fpcr_ah && float64_is_any_nan(mm))) {
-                mm = float64_abs(mm);
-            }
+            mm = float64_maybe_ah_chs(mm, fpcr_ah);
             xx += 8;
         }
         d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
-- 
2.43.0


