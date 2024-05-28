Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091D9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzH0-0005Fo-VF; Tue, 28 May 2024 12:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzGf-0004we-6J
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:01:47 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzGd-0007iS-Dn
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:01:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-529b22aabc1so1108926e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912098; x=1717516898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pHpodULsqsdzeSAudm3146gsyzitGajONPimXbKis+M=;
 b=P53QVAl6LSdMhfSk6lEEvoKqhAbcuEsYw44OAyFu0AJKd+VLBVc3QflfET+PCx0+MM
 AZPoUc7AUzNQc4LCc0Hp15UcUhquUpV0/W+EsDgE7bKp156leZUdEAEeDzu9uC3rXlu3
 xJmLtELD4iDL3onCf9Ws/Lpt7hSRQHKct51DUp/0+TTlP++5JEYgI4tB1k1KhHPFMfQk
 AnbeP6BCXbBZZ+uWStmztIRU+qqzE89voGS9hCg+UequaQtueuYhOI9FVeWcnoeWv8cP
 E2N6Efkh18HD0+6O5IpQzSUAuywaMK8Hiye44UMB4MN8XXbOniZdDzHReDGQ7hbbH0l6
 4/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912098; x=1717516898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHpodULsqsdzeSAudm3146gsyzitGajONPimXbKis+M=;
 b=CCwOhn38gQDpFVNGKL2+AYLuL7oq5e5xo8ivOajP8oFbqL3UHw6/EA/KHwvYnKwX64
 dTr7LSefq9nN6BIdijGq3vTOrBbSjBiBxoGVoOX3eK9LBPvF2spGRfpe+JQy7hbm2A27
 8qKiI77KkbmiTWiMrM3sTHD0GtZLO6jOhRfKaBX2e3HDz3tHnANRgoWYADApwg2zBW4g
 Hdf+mfL798ooIQSvorGbstKfjvlF/oahy7Z9sNBaRC3SxDT2Rt16zqXzBHAy8OqQB/rG
 YaaNWpU9WY69okExEh4z8bNzl1UD+pfrTg4bZpPs4Nc6iYhNotucTec/U/GlqQc9OARu
 d21g==
X-Gm-Message-State: AOJu0YwfOamrJEJhfoGkq+l5xJGbTLnoOhteS6Vg55D2wKYtg3T3yQEk
 wclTTaoir6FfOSMu89UBvLTMrEu60p0yxEFkfQ3VQPW+8kcuahqeorVUCwgXpiJBlxXwnp4sWWJ
 jlJGSrNvKPL2pq9uLQE7dydGmmY2zCx5CC4rZRQ==
X-Google-Smtp-Source: AGHT+IGiIYvNrr+BiU+r9V94MG6IsPSsGgD/3M+vrMXGR3d1dIh/vnR8p+1CPPejzanX6q6NCmVRrb8rrDvjkhIM4F0=
X-Received: by 2002:a19:5f47:0:b0:523:a5b3:5e1d with SMTP id
 2adb3069b0e04-52964204854mr7471049e87.10.1716912097604; Tue, 28 May 2024
 09:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-56-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:01:26 +0100
Message-ID: <CAFEAcA-CADhoCNyvERLq8-+huqqrg-VUDRhcS02+1kDpNi=LDA@mail.gmail.com>
Subject: Re: [PATCH v2 55/67] target/arm: Convert SHADD, UHADD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  2 ++
>  target/arm/tcg/translate-a64.c | 11 +++--------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

