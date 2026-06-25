Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DDFCDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmaw-00025v-80; Thu, 25 Jun 2026 12:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcmaf-00020P-Ja
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:06:09 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcmad-0007dZ-Pi
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:06:09 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662ccb916c5so44211d50.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403565; cv=none;
 d=google.com; s=arc-20260327;
 b=KziAdH3gCBMPPoFZIbxAvd9MokXq7QglxI9dTpMNokkx+YVFMg45jnX5AH7hnqMTRh
 ssrarg3O0Cyr/+Jm81ZoGqUQGBk3n8YEW76QfmkssaC8nCQyR+fD7DezlY0Hn3YhoROr
 hPdMYcGHLWUazFK++PtN6QYhV0tJ2RPgYAyDViOPgcrV1uY2JxZsnKilFc83T6u9xY6Z
 e2NjrRXmrAJQSVSLgSy2PEmLOLJfrPaGThPJNn7m7SGpxb4+lMeb6af9qEL+Crz4RX6y
 Plqzxg2P0MVuKrYakrqFuDnh1qL3DLleVfPSfxyVawwG7ZH2z2a51j+XtGcx33Z7SGSQ
 kI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QeHjQaUesxtoFEA3EFIYiZ4f+OcFtUO1/5RgAXYKaI8=;
 fh=OKRI/HsZ6wqsUszkXNUTy3ZkkaT/mVkDeFQc7nISWtY=;
 b=TVbd2RkNOM7UNzIhozENJnRQJq+4ifmSmqpPqbyyuL9vAjLgpvpw7EXTL5+xHGQEwl
 Z01B4XImN6ih0L3Ji+Nk49C4UqJxHiLB/QzmqAi4uZ3us7sscTAU0UlfHwQ/VW7r7ND3
 CTy5sWESHGaXVriKVEAxAibv05bqxofrTZzFLztOjO/WnpgG6xY7/+1SbK0XTS8o785e
 MpeRTAN8hzTTBxtKaS4asF9D4KuTIiQuyHU4C3udt77Q/ZIZ46Evr9z32d+5pgFy+QmE
 tqCThPTaQdCxJz25+uoKueaYqn6HtXGN3cQtJcj3HBsxAQt3xrz7OZTwjUOB9FM23DJB
 2Q7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782403565; x=1783008365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QeHjQaUesxtoFEA3EFIYiZ4f+OcFtUO1/5RgAXYKaI8=;
 b=GJtTqGglfSs5DjmdGZGLkWT8n4rZUc9cJ8ucAHHpRrhvG6Mbz1fCE51V6UpQ/eAgpC
 ct7wKYE4nwW9lR3wSBr2MS6uVsA9zr9ZSZCaqKHJLEWZdrOPt82jr7jnFdSIvGCYKKcp
 uOT1N1fIAvo2o0RUQpknVWP72CAix2mJv2ypJsELQTfSHop5XkQIx9AKc2eiCyI1aAMM
 1Xu3Zf8k5Q3G5wseO1Xj6ebd3MXvTSbYHVCGAQQLUDZjkUVo3qdEzphWiL/JYxiSHRt6
 WRzbInVOQcvVoSuK4rDH17XLl+rwwXYpXnk8UKUiW/LlAcKUGIc0bi8+fKtpl7bf8840
 MzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403565; x=1783008365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeHjQaUesxtoFEA3EFIYiZ4f+OcFtUO1/5RgAXYKaI8=;
 b=tMA3GIRQyJx4soq65kmx+yniIghiFv2Cgt3HqLmd6JJ+5ZwhjYTRauoy8Ym8sgISmq
 lGVprKlswWQJeRjHqOy2ytuIhSXD8PaHsm7xPOjRd4pf8fmvFFHowqZqbeuTi2O0pP8g
 0iUJrarHxRKtvaqd5PbQvraDXsM/dfpp5kTGmopo5i0JOxaG45R27RBz2NTHmH5jxwkC
 FCogsCQPPzlAnaprT5ENCuS17CT46NYhx8VxcS+vaink3qvWmRaCSihmElcgOwmsFdwz
 +G6oSYZ4CmlaZpsUhzIKCoFWMqJjmbZd6fxNAGMJEXvEH2iV9v9Ls29yzoCbORQPoDUo
 zZjg==
X-Gm-Message-State: AOJu0YxUGamh1jYHg1RJSQweQJCHNeJpA3Lerxp+2JlM9xkthywQaPQn
 34elQ8tEG/hj+vFeaeO4oaCWEha9//24ubKoe5ltARdbK7bmYgTVRnkwffAwlta6AFSMmCmmQi+
 AaUKH4Rk64I/cQJEK5+CX1zGAF7V7KBsEv0J4Ie8myg==
X-Gm-Gg: AfdE7cmRCesfdHG1jcPEPCDsfPTVAoJd6Ul2O2WZh2bjQ1WjFhGuWy6TnmsUpDui2dz
 qkCMWVuu/i1iJp9olG0YBLx0/GIbEFnVwxfKAYG9y7hQfXeHs+WRLHSf4pryUceySBQxyLLqW39
 Qs+GL6vB9Wm23fSXOnrP6JO/7CL6xFIt8YzWvYK4kst77fjyymjml1Lu3yfgS6dDwEuM1noGpv5
 pXgXMQh5WTczuh/PxSqQcvUsVp5eEpVCKMz3/0kGcwryVx7HstFhg9GrpLAWntH1KQYJB9RTBbz
 v5UM4D5t96uiGNtpHlE0f+IoyynYK64KHPLeFh42Ro1ZH69V56p1LxWQ
X-Received: by 2002:a05:690e:a4f:b0:663:1eda:55fd with SMTP id
 956f58d0204a3-6648814d08dmr2379257d50.22.1782403564667; Thu, 25 Jun 2026
 09:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625160144.94565-1-163wangjack@gmail.com>
 <20260625160144.94565-4-163wangjack@gmail.com>
In-Reply-To: <20260625160144.94565-4-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 17:05:52 +0100
X-Gm-Features: AVVi8CduGVMrab7GZhwmcenA_Shg-LM-ebFezrTCoJon3JeZz5X8cS4boiut6nc
Message-ID: <CAFEAcA_TRnKpjNXuXTDOOSjpqOv43Hzfd8_MaAp8P36O14C5nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/misc/imx31_ccm: Replace DPRINTF with trace
 events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 "open list:i.MX25 PDK" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 25 Jun 2026 at 17:02, jack wang <163wangjack@gmail.com> wrote:
>
> Signed-off-by: jack wang <163wangjack@gmail.com>
> ---
>  hw/misc/imx25_ccm.c  |  2 +-
>  hw/misc/imx31_ccm.c  | 33 ++++++++++-----------------------
>  hw/misc/trace-events | 10 ++++++++++
>  3 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
> index d051e8a2d1..4ca4cb6672 100644
> --- a/hw/misc/imx25_ccm.c
> +++ b/hw/misc/imx25_ccm.c
> @@ -102,7 +102,7 @@ static uint32_t imx25_ccm_get_mpll_clk(IMXCCMState *dev)
>      uint32_t freq;
>      IMX25CCMState *s = IMX25_CCM(dev);
>
> -    if (EXTRACT(s->reg[IMX25_CCM_CCTL_REG], MPLL_BYPASS)) {
> +    if (EXTRACT(s->reg[IMX25_CCM_CCTL_REG], MPLL_BYPASS))

This has lost the opening { -- does this even compile ?

>          freq = CKIH_FREQ;
>      } else {
>          freq = imx_ccm_calc_pll(s->reg[IMX25_CCM_MPCTL_REG], CKIH_FREQ);

-- PMM

