Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D72CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3TM-0003Vg-MK; Fri, 26 Jun 2026 06:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wd3TL-0003VG-4V
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:07:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wd3TJ-0002lT-Bg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:07:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so6697705e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782468459; x=1783073259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhmVoVsRENWb5+GuFKCUUtYHw1Ak22nPvmBwAoCV7ss=;
 b=cpVTl2mTV7R1Wmf45FdHkzLGpuKX11rNb16D21Dgtu8UGib4O4+slJx8ItgETqPeRj
 eG3coPBtxAauVNR7oQHLfOdccy+cVxDfv9UAiOWmX+9vyNt8fNV00PAsUMPYzMOgmZ8m
 3KgjIcGwbhZK5gyvpu6BVs/W51FXn1/4o22Adk9IrU9U7YB6/BjYy1Prnqu1pZy1kQet
 rY6LNIB1DgQF62swC57HNrDnVpfDZgztO2dsKmPU3Mb4K8HfXkqhsGUTPX7+t+kKNQ/e
 vXlTXkcTcVzWOgvAy66K/gNWaKBLpsnbMYkkuzQhgQvR3K7Bxur1XqPqFOT6b3Oe8PPN
 4nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468459; x=1783073259;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HhmVoVsRENWb5+GuFKCUUtYHw1Ak22nPvmBwAoCV7ss=;
 b=P0aTRpB4IU2A+Sx10v5KSE6DJ+SFqCTkOWsyNfqshXuhv6QTqfRnY4oe009u4YS/Qs
 O6I42i8mXAfi2StthXU8viQe8Tr+gFMkvH0mHiAjPh1WK4g/8dl5XZp7FZqUo5hqCLf/
 qrZAFzTwVU/Ex02mETuh0IdHi4Ve/rYaYxIADG5CkgK5wjrpoegDjcWA85FUjzsfSJvA
 PpxfBVmovKwTCib+7Cu49yhMjcB9sXonnu73nudv/0fKniMwhAgQUWekh+/TltImQSuG
 9LEELYR4vhCx+JmAb8Z7Ik2meWJu+3IDFugjLM0pzxge32vmVQ7rib/7CUHWb4b1kROg
 FrFg==
X-Gm-Message-State: AOJu0YwfoP2YdZgLRUx3boRRV7khxemMoUSegKTj54KRJn6RnuB8gbhm
 45X9OsD/fsPZrLTXE9xxVo0czfCSf0C8nZ2sSYGFQphiEGXOhH/PTIVgDeAUpxF67ybLPQRYpik
 6me9giok=
X-Gm-Gg: AfdE7cnT16FNVsWfFFTHLLUnHUGRoHjZZE+p6fTg6Q1bxEl3ABQqCxG/t7cS42VfIL2
 0PhpDExdRTiW2ZUYdarxkiqFgAe+paz3XM1xP9IxL7gi5jBkUaROOOGkln8MaiRvgUoV54vWy7J
 H6wKdJrQT5fJtZVl/nRQ0BB4h/+zp5/G9Q3aCp/R3psYKa/GW0fQZC8j7kHynJyKu2Av/wrliOW
 3holjaYM3XyRMXazDKgZNj+3fFq2adkMeWMhxj0T13z6k84/VKGjBY2ai4K1mYfsa7xPE5pfafn
 OMr397Gwpvsfpr9QM0uaSrSJBfGtR/LAoFVQtsYsesp/tDm5hgleAv2VyGuGbboAo3VFAvO3hZ4
 HPU4bjd8mP0ORJ3Yr7bZzpq3t+vYaMO3r+iKQCnDMEVjV4ARoCqgezBO3bypCbM85eIHLtQmtJP
 DEStGKBj4O9gxK
X-Received: by 2002:a05:600c:6386:b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-49266885895mr85505615e9.23.1782468459386; 
 Fri, 26 Jun 2026 03:07:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fe31b0sm73394545e9.4.2026.06.26.03.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:07:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C34135F867;
 Fri, 26 Jun 2026 11:07:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] target/arm: Implement FEAT_SME_F8F16
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 24 Jun 2026 18:51:48 -0700")
References: <20260625015159.719300-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Fri, 26 Jun 2026 11:07:37 +0100
Message-ID: <87se69haxi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Another minor feature working toward SME2.2.

This conflicts heavily with master - did a bunch of stuff get merged
that broke it?

>
> r~
>
> Richard Henderson (10):
>   target/arm: Enable FADD/FSUB (half-precision) with FEAT_SME_F8F16
>   target/arm: Rename SME FMLAL/FMLSL patterns
>   target/arm: Implement FMLAL (multiple, multiple and single, FP8 to
>     FP16)
>   target/arm: Implement FMLAL (multiple and indexed, FP8 to FP16)
>   target/arm: Implement FDOT (multiple, multiple and single, FP8 to
>     FP16)
>   target/arm: Implement DOT (multiple and indexed, FP8 to FP16)
>   target/arm: Implement FMOPA (widening, 2-way, FP8 to FP16)
>   target/arm: Rename FVDOT pattern
>   target/arm: Implement FVDOT (FP8 to FP16)
>   target/arm: Enable FEAT_SME_F8F16 for -cpu max
>
>  target/arm/cpu-features.h        | 11 +++++
>  target/arm/tcg/helper-fp8-defs.h |  2 +
>  linux-user/aarch64/elfload.c     |  1 +
>  target/arm/tcg/cpu64.c           |  1 +
>  target/arm/tcg/fp8_helper.c      | 58 +++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   | 72 +++++++++++++++++++++++---------
>  docs/system/arm/emulation.rst    |  1 +
>  target/arm/tcg/sme.decode        | 66 +++++++++++++++++++++--------
>  8 files changed, 176 insertions(+), 36 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

