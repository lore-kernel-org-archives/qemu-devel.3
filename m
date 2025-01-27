Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D474C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUy-0006WB-7L; Mon, 27 Jan 2025 18:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUq-0006Q2-1q
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:24 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUo-0005dJ-Iq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:23 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so8614068a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020380; x=1738625180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TizWhFZw5JvY75vssZ/TpOwGEzqE+NmThakWyt0pk6I=;
 b=xUR5UQEmekFH9j9tUCpnwqjXSp83stB2naM+WCf0SbdQFH0znz0o7ddV9/hmrGaVss
 RtBMpt9YWe/oc+jMLh9m+mtqE+d3K8wUhfjrqwLf34dW9iGVvsCA8lQs09d4xb8EiwR5
 MJnFhI/HYoaVFisyMwY/bQSN+I6g7Bg8xcBsFFA16DJ8u2TI8/LSqaJ4r4MIGIUbZwIT
 wzcLLY0I+6BlcQdHkFTFfSGatPMPUOPWP1XNQl25Y6LmvHYpqIe0mwRXcZxx/h1OnkY/
 huJVOag3AUKHyZ4+v8/vsjWejOhShz6KmJWz/IYXhAhpbiyqkY+BFEPMY+VZugIJqJXP
 NHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020380; x=1738625180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TizWhFZw5JvY75vssZ/TpOwGEzqE+NmThakWyt0pk6I=;
 b=f8gmHzNzFcdYFs/4iHspPKSn+Gy5O4/q1TvZopSFSF3ei4QDjGtFO3D74vNfv9X0mE
 3MwlRHkpF3TGTSERUKloGicjhUEj9FNdHH+C687lb/QWjNHGYhTNywqMjBpV3koiuShI
 ip532aRRN29zW/fcr1VrMhJZZ65kTJ3KzkMWXDQ4JJiPil0NnBm32uZeOpNYepWyirh7
 uRDtiGLUe2MVGL9VhsZfyub+njMKjU7BS5N5L55Rl2uWKRb4NCP2nJoboacSyt0e+XmE
 PAVgE1VPn7lHxsAykWFK83bwagwRUqPpoQ5wmEDPbt/LwX72M9zLUudUFGb22+xxWB9H
 RO3w==
X-Gm-Message-State: AOJu0Ywo529uIw0nOaJ9PyUCheIFIpiMkXO1kBEzwT0oNl2vXSkt5XFU
 mM0X1ADgk5v5G4ADXNg3MAvjtwx7tRAdz1pTDTNfJJ0Q42pvAZO59uKNQ0xFEMP1GWHaKe5CO7X
 O
X-Gm-Gg: ASbGncuVKlcVIi6cX0a+QPeFb9uhL/UB/vAWysQwriyt1khwaHSqCSdKl2bYRpL+yzS
 mg1ETcmfzLgZwHgfken0tPDEfZh+g+rlrTWuwA2B3LtRNK/a/jPYtdSnnSVzxC7LlWp8bGvIFRA
 dTktl4hbnAh9FXOd/1Ks5sG4vrF2xhjWphAqC7s0srUBGqrsiLjS0Q49a4urvFhJ3gQBF9AOH8U
 pw42y+3tpkphKEw1+TG7to8rf0Uj6UujCXEuvwsEp8IrN7FSPehGRn6XEt0f/Hx4i5Z3BAmSZz2
 6w3lTR0MNYAPYKHcukgf76WTOF3ELmt/6m/3iZw=
X-Google-Smtp-Source: AGHT+IEWm401NBv6oDLfJOs1xV7reqB0lvhrq3oMcKSE1Id34a6uZUV7hhmjMV7hdrLYaLxEW48N3A==
X-Received: by 2002:a17:90b:17d0:b0:2ee:6d04:9dac with SMTP id
 98e67ed59e1d1-2f782d9eb7emr56653302a91.32.1738020380282; 
 Mon, 27 Jan 2025 15:26:20 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 18/22] target/arm: Introduce float*_maybe_ah_chs
Date: Mon, 27 Jan 2025 15:26:00 -0800
Message-ID: <20250127232604.20386-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Add versions of float*_ah_chs which takes fpcr_ah.
These will help simplify some usages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index a673935f48..6b93b5aeb9 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -285,4 +285,19 @@ static inline float64 float64_ah_chs(float64 a)
     return float64_is_any_nan(a) ? a : float64_chs(a);
 }
 
+static inline float16 float16_maybe_ah_chs(float16 a, bool fpcr_ah)
+{
+    return fpcr_ah && float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_maybe_ah_chs(float32 a, bool fpcr_ah)
+{
+    return fpcr_ah && float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
+{
+    return fpcr_ah && float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
-- 
2.43.0


