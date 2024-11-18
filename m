Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5338D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCz3x-0003X3-RP; Mon, 18 Nov 2024 05:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCz3t-0003WX-7b
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:32:53 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCz3r-0001v5-N9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:32:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso5706495a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731925970; x=1732530770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N+7bCj9310lztWrlfyIYgKtNVhwosjtduQAYk23N6eU=;
 b=RtQHh2TH1hBunUaDHDV+uljJwWg/2UN/NDiXufrU5Yfg7ajVlQGbvikhqikAnPOxlP
 T7NVw0eAxWD885LafvEjK/RD7R1Ym72MkL/qptAIIPmHT3CHLYqlGKPy1rCwrrn2m0hb
 JYe20mrNB9PYklrwv4fjhFgmbSyDNxbj2gNhGkO4c6Gcsw02KuLOOnkllMsjn44hZoFw
 9DTaHtyIFwTNoxCp2QETqZVFXUHv/Q1sJNVYOCBgA5f7Rfh3vZR9J8qY42o7X6L5oyqg
 wgC4hNHZJHn/95vIXvP5FFKUOyj2/wh7Shbtq+qhBSOynX0A7VltGkzTfMJ9ZTAN40VA
 ycKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731925970; x=1732530770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N+7bCj9310lztWrlfyIYgKtNVhwosjtduQAYk23N6eU=;
 b=NVuBslNkebGrqixO8JS1oVv1a7d7nnI8TReYU04WPTa8q6MJ4QggaAVWTDQDTGY13Z
 qKqgT09j8Vt3mTee8W3dPWWSUodKOf/8Oh6m3TacIj87x31N10WMvGnlxbIyDSPumR8r
 ojMNmg+CysNrxXVICf16xONJYqy6CFcMSw8kmk5AjyqeJfiVaLApgk45rQwpQWPbL8Ul
 sbbQTsWY1Zcz4+s+oxQ4qpNdkrh8T47t96QTQdpElygmvh3JJViWXklHVertpCOKN6lD
 I1zjWHaCh34ThNH+54PPy5Cw5iBLMqJUj9a2gSw9vsbY7wJaT7cv7rAZkc470/k68A5s
 KAoQ==
X-Gm-Message-State: AOJu0YwrExO/PP3FSXziY0cS6Y8xxDmAMpDCe58wqmR5hoO61P3txYHX
 UAr2zMm7wxl5JGZPiF6hOnHt8oePdug+4YEC7ri5UJdi+rtIZ3Pf5ZsLfodVgQlHCOhG5lM2flR
 hhDWvHEzaCVrI+5bPc+bhEyOrGhTiUJmqksQ+OQ==
X-Google-Smtp-Source: AGHT+IFpyCpeiVwJy3ozmQth7OGw0sgK077cBKGujtbZOwzHGaMrql2+HSuttnoNfIUBfiNGlsbxzOtDRecJW7GjcUo=
X-Received: by 2002:a05:6402:34c1:b0:5c9:8a75:a707 with SMTP id
 4fb4d7f45d1cf-5cf8fc13cafmr8976934a12.2.1731925970040; Mon, 18 Nov 2024
 02:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20241117001125.497129-1-richard.henderson@linaro.org>
In-Reply-To: <20241117001125.497129-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 10:32:39 +0000
Message-ID: <CAFEAcA_Xk7C4H7_gWynP_46+E=nJBb=190=iJVUPeLbEX-k7Fg@mail.gmail.com>
Subject: Re: [PATCH RISU] risugen/aarch64: FCMP*Z* require rm == 0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sun, 17 Nov 2024 at 00:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Do not generate rm other than 0, as it is UNPREDICTABLE
> whether the instruction will trap as invalid.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  aarch64.risu | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to risu upstream, thanks.

-- PMM

