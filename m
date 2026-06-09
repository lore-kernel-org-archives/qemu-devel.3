Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEEBCD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsjs-00015g-46; Tue, 09 Jun 2026 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsjq-00014v-9z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:27:14 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWsjo-0006Ww-RN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:27:14 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6611669cd16so2807658d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780997232; cv=none;
 d=google.com; s=arc-20240605;
 b=C9j3+IgaJLQim3ycRDpRb6JbwHVtHVixkMJp3ndL4pvNL9JqbaiIh2AfAiKpRh+dDr
 uC6ZSt589JyrboUbc2ggE+G4yvBdk/DW+LDm4SUotj2fDpPPTTjL6coj4FzQpZxjCopA
 pOBF81SmbFjoefOvoHGBIR+kbx8S9/W04f7nnhmHmbZMfidA1Jk8a7UdZ544l9cReFVT
 yoRroDh6inSW7tT243wJSOZvYIqCBAm0FD9rUEMUrj1d6cM32mM4TRQrlxUqVxcFXCk+
 E51aliFnXyvPRtp9SYdLufnVc2BLhgu8+ZzQ3VyPwx0edXd16VlK9VcoxArprRbXMItK
 ocjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MxK2rRk3HDVkvxhS45QhnfI7H4yHr2mFuvqZOZ8U7II=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XjKt0HmrUh6YMb1WbcfLKZesYr2YwIARGN6/9QQ7Y8HZ0GYqI8pXMw41VC9vRAaKzb
 7SWUhX8hw7YFZMTiEy7YD4i5OF+74iWOXFqx9f6cOzZElD/S6ntr4yoLPO5NMWEmxPHF
 o4gv1yOr057eW3Ew+CW7nwJ2iUSqohz5odqOFmn/yDH2VIXnLQfIlv4vfGxBl07tgHpu
 YtsL/dtucqoafRT0caldnh1AXm+jyve2dXyEGhCeCc2S3NLHHX/vJw9I1aR4kMiu0zM/
 EXi34NSDo6Jbp5GiffrBTuyNXtIOtNbkGZDY/JoMWcWaA8XckoYtEIytc8b5XyuwOlmk
 78Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780997232; x=1781602032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MxK2rRk3HDVkvxhS45QhnfI7H4yHr2mFuvqZOZ8U7II=;
 b=HXL76e5OMyu1tqNFIvPXbwW/nWjWxmwztQ0OOG7SvAAdCVCcR0kKnYidfaz1wRLCz2
 IP9lVNHXot9rF6TH8sHQVtw0bDglJ/VU125DeRuhRuQbTNN7MvOM0IvdK8Av0rne1zvx
 0S1fS6gBl7TnVea9MSSCEAOWcc3BitcMRVffABWeZgJMmPTHYu03NIClqB5pjo2R7aKB
 kygTxRuXT55O5ee+E+AtKuGXc/0iVeDFkgT9RhTEU0StZeJmDGPXdhbp+G0wERcG/sJV
 U4nDPB7cVZHU0nBE/nmk3p0Gl+h7DgI6u/DWlVkcjc4b7Iyj5mckTYUUzHb3Ji8Noa+B
 GbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997232; x=1781602032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxK2rRk3HDVkvxhS45QhnfI7H4yHr2mFuvqZOZ8U7II=;
 b=JU+rUS2ZBe1jDNbtXo8CckOXS8Xl6mjyNSzxxWtFq/QwKIiJbrzjBfbB4bDM7CUyLA
 HwTL3CteWXKP1i/8kIQP8eeam2BCucYEZp4kJP+0wp9Miw0WI8zlKf2uu/Hr1uDbuNKJ
 YDUyrZB141/OO336QHMfQhUd0RbpV+eG7gs+XQ1qqUIn3U3PtBZDLOuf1n0uSFHl4DLI
 LSCsWOQfoASmhfz0uqK7r68wESrmvD7vGgeKFJhtNkprCE0Hpbt5KrUlPMcPkKeS/P5k
 Naqeemxq2y8soG4zYe+V3ELj8ra0T51yDlUD9AlAj4BltNSYCbHQ3lwGkMVF+OZT3Q9k
 echA==
X-Gm-Message-State: AOJu0YyRW8EiwhJ1q5k9fpWIZh3X/Te5fmFTLRcY6GUx3MZeCXL89mPk
 M7yudHG7jjIJl/mVu9r5HCWU5C1VgkleaheBIc8wN6CFowLPTuxY5QTzVdnBYRio+YyBqqTtpq6
 MKl0U31sbBcm03RKVgajfx2XjgSeZfEUNlYNR7nVlmafsM3Q4kJqr
X-Gm-Gg: Acq92OEuZiYcH44dQXiquJYnqmYumyGw8BB80+tfLA7rHb0hy1LuXAx4ir4tasMy/Cc
 mCSjtPxial10/Se+/myQwEwqYP2nOcc4PsotTyoGmPXN5e519LQLPh2TXVY+l4KJGnNJnbw/ysQ
 375JYYjTMbNzYRjdC13+eTAMQo+v5tq39hVq4UrkexjaupZigN0NIB4TX9bs1NBxk9rQhj0aMK8
 Rz4FaH5RI8BnwWdp4nKSBKWwnyEM2czKT+enEyJ/aFwKtsFrM0yEfkNuPMTTeAA5ZsOZxOVZ9gp
 daQqItyoka22gempj0gu+8wc2kBT5CdgLba/x7WIZqCKaO8DR5XbwICr3B1Fy1ftLESRHrXVj6h
 QIw==
X-Received: by 2002:a05:690e:1908:b0:656:30a1:70e2 with SMTP id
 956f58d0204a3-66106e00e6fmr17508024d50.6.1780997231629; Tue, 09 Jun 2026
 02:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-25-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:26:59 +0100
X-Gm-Features: AVVi8Cc4e6jw8A52mjHvofKyjhshZ6DcfRDzUubsxZpxvsoq21njmIC7QxT_gOw
Message-ID: <CAFEAcA8uBEDRwqjUDgtk7TmDsKwrBn4R-W2jSXZz6vuSD5HWuA@mail.gmail.com>
Subject: Re: [PATCH v9 24/45] target/arm: Enable FEAT_FP8 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 3 +++
>  target/arm/tcg/cpu64.c        | 6 ++++++
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 10 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

