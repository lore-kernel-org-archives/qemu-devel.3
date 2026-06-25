Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADDBCDE013
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsfb-0004y8-BD; Thu, 25 Jun 2026 18:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcseo-0004Xo-UA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcsek-0002Jh-RD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:34:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84236f9b638so111035b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782426722; x=1783031522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZV/kyDu19iK9TBsZjnv9GOAzX5xEKZyDgPuNnON5tvk=;
 b=qfNpEybR8ICcWAkWZ+b8DwbpGXAfO7m1LzFF5C4bx06RTym4hdDEXUlgByd/v06UEE
 vK2ZEQz1iR0tkhN/iHFihm7HZQM6ZFsbl6PhUgSMkwqjInsVgGd8giVsxxCGsVOnRLOV
 iIbkpKF+xZ7XJQAezYRJqOYoSa65AJ96Y8tmRBMi5D92r7zYW5mwByADROiadO/dRVHI
 lPd+fwtj5ZMMUC1w4xP+bLUlVNEQvltTSNMmxzPSqDJU/m2U1dGaGwlgZsz204ZdgNBP
 8H1cZIuefZGxYR1NCATBHnE554UCulsojf8jdb0Q+GA4SbZsQqhAL0vIk7l6oTElOcC/
 gTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426722; x=1783031522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV/kyDu19iK9TBsZjnv9GOAzX5xEKZyDgPuNnON5tvk=;
 b=CblG0qR8F85pQ9V5ipWSRF8lUEePyjQPIHjyhrDPe0WDcv8tzIrA552BlA25t+c7qy
 AwRTfiEzh8TdgqYGkJ3MIY6XSrTleq4ShJkTSw+uXK9NeUz0ix9320SiCNP1yc4Mf1ER
 TYA4WkwvGHT4ECPnqmNQh2JEARgG6FqefQWvQhL3wVH/GaoR/SiMfV0ljCm+vaX54qO9
 oNCJhD217u5bWo0FcwE0dfCBaUzAzvGe+7M3ZADaFufcwzp8lcDwkcliGGuoQRi/AU7K
 0ZdXKNEwixy2LJ0SLZBz6BHuQYGd+ADTpmHfHhQWKCaXbNXODbJIQt0u9ND5Whg4mE72
 Dbhg==
X-Gm-Message-State: AOJu0YzG9MqH4rbmeoaD6mXojbiyKtE7nW1aAkp/p14qxYsWSBnbsZ8q
 dReR3AlU9yc+MWl9RVxV5vMjdzobIiDSXNtHYUhAFDe9KU0T3sizrJgo3a0OkIstVVOEQO8k2lQ
 fxbrC
X-Gm-Gg: AfdE7cmIvP2QqEkFF/dQYoaO0ZgAG+HWQ/s59OfOWNB21It2WiMIfx6LaPUxO9MuhVB
 LqHfb07neZmOsYYzZ4aMxohPLvNTzsLgOr3pc0A0Tsjp3eDPXs7EPnbR12RMevv3JHddFafjbR/
 zZy48j3+oJ/dx/GtbwkWy5mqk4CoJLjY3xv57E83z6RwUFquFn5V1+PR1pOIHU5GFAC9hSUPqRf
 aEuMFnkGKVbiNe6TeP8OaAGcRToCCo6szxexM4NtZ9ZbkQ66opmkMKXeJoGaJbc67IUaN/gCzIL
 ff1dlfhofuXv4roJZVXxzC6eKqf26crmaOQ5x9YbYTe4ZMgxyAyKepKl0PmPGjjQVNsKt3PXXii
 kqoGKXVQTKAzAF7eEhd4hgYZGgZxHqb0SmQRtmm+Rx4uurmNLWD2NdxwQDpVyHtqFZ48wHm5cZs
 1d51l0N+8+A6b5iHV5NZY2WHX3p0Mo9YS4SDZrH4lsoO4Q1If2Ug==
X-Received: by 2002:a05:6a00:278b:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-845b3adeba3mr5133694b3a.30.1782426721526; 
 Thu, 25 Jun 2026 15:32:01 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a412e5e9sm5450139b3a.54.2026.06.25.15.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/15] target/arm: Implement FEAT_SME_MOP4
Date: Thu, 25 Jun 2026 15:31:45 -0700
Message-ID: <20260625223200.763198-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Based-on: 20260625015159.719300-1-richard.henderson@linaro.org
("[PATCH 00/10] target/arm: Implement FEAT_SME_F8F16")

Another minor feature working toward SME2.2.

r~

Richard Henderson (15):
  target/arm: Implement FMOP4 (non-widening) for float32
  target/arm: Implement FMOP4 (non-widening) for float16
  target/arm: Implement FMOP4 (non-widening) for float64
  target/arm: Implement BFMOP4 (non-widening)
  target/arm: Implement BFMOP4 (widening)
  target/arm: Implement FMOP4 (widening, 2-way fp16 to fp32)
  target/arm: Implement FMOP4 (widening, 4-way fp8 to fp32)
  target/arm: Implement FMOP4A (widening, 2-way, FP8 to FP16)
  target/arm: Implement SMOP4[AS] (2-way)
  target/arm: Implement SMOP4[AS] (4-way)
  target/arm: Implement SUMOP4[AS]
  target/arm: Implement UMOP4[AS] (2-way)
  target/arm: Implement UMOP4[AS] (4-way)
  target/arm: Implement USMOP4[AS]
  target/arm: Enable FEAT_SME_MOP4 for -cpu max

 target/arm/cpu-features.h        |  35 +++
 target/arm/tcg/helper-fp8-defs.h |   3 +
 target/arm/tcg/helper-sme-defs.h |  49 ++++
 target/arm/tcg/translate.h       |   5 +
 target/arm/tcg/vec_internal.h    |   8 +
 linux-user/aarch64/elfload.c     |   1 +
 target/arm/tcg/cpu64.c           |   1 +
 target/arm/tcg/fp8_helper.c      |  32 +++
 target/arm/tcg/sme_helper.c      | 390 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 130 +++++++++++
 docs/system/arm/emulation.rst    |   1 +
 target/arm/tcg/sme.decode        |  45 ++++
 12 files changed, 700 insertions(+)

-- 
2.43.0


