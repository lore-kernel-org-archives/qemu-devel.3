Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CC4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaXu-0005ST-C6; Fri, 03 Jul 2026 05:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaXs-0005Rx-SY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:50:52 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaXr-0003T3-DB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:50:52 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664b84118d5so574082d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783072250; cv=none;
 d=google.com; s=arc-20260327;
 b=IVIVdGFDb9qU+UwnP57tHgHxd4sPywfSy3IoGMVfBDOQ0kV/18dsez6R4b8pDvk8HZ
 Tom1zZlhdSZEUYkfHCz5NF18ZNEnPUNrOiaqdBr5a9xaR+kSuXgydA4ek3yLwY7vO+7g
 h0X94zG+Y9//1Bwytks1iKNhcd51t73NSw5rWBgDFesq5juthdY0FYLm+9CLFxrOsDiH
 uVOBsl0HK8wM2OoVTvD5VBQVZJz/ASgqUqC3hGQxEcI7eCBAyOmn1dT7rwxe4tAEMfEG
 xWd69Xhu5N3+5NUwOojz3MG4eYyVdVRq3OdIeZ/8jb4sPBYvgakgpeccHn0Kd3ZhbdQ6
 Wplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tiKaSqubvoYPwqNkTtrnfUm6z3Z4YovKUb+vtD0Pzyo=;
 fh=OKRI/HsZ6wqsUszkXNUTy3ZkkaT/mVkDeFQc7nISWtY=;
 b=g6/mDTyrUNwXiSGeUOJ65GycJuRRZnrYif9AgPfTIA3jBbYcajJpLpETccuHck8o5d
 dKLF5Z0OrNb7c9Tp2pIrTOr8MAzZDhfi1vJcExNxkpyD+DuW6NlzcuGzbykIKgFckx4p
 5DU7siJJAwnCtorDmlJgXjUPlaKZ5Ab65QhLPcR6KwOlaSMAAy3RYhYDCuvS9AwU1ftG
 ohOk+sFvn+qEXA86iYgEC+/10nk8vxwEHP+mhCW6ZdtspfwY/cA280r6gLVoqADBbp/J
 i6LmBzO7dIBa1jEWxrpB/AeKFfXj/LEqxD49LjoVBLUfsjSWcgH0Ixsyycj7FO/7pLrB
 8/ag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783072250; x=1783677050; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tiKaSqubvoYPwqNkTtrnfUm6z3Z4YovKUb+vtD0Pzyo=;
 b=UeB/LgkWJTkrrfL50hRCqaLG8hcSqZncB9NtPvnGBCe86JoW02IUYhJ28goHKZZMnZ
 nISplVpFt/aV1sSPabnsywmDYncAnc2dqj/JlgTBN0IEL3Is1NldLwizaHs2Pu/5+WoX
 yM6s21LaD2xJ0HI42xxKF78GRKi/wlt+ZnVlxip1sd+jABwRMTwAYfuIK+Z7NR0wr5kj
 vaU93SQFrwSQ/dbIX4bSN4f2C5loPfbMvV4ePvGlAaIz7bZOTpJvxHYs1NYakF2mQo5M
 k2E/zrK2CmcC4fAVPOjwxRKj5lyZiKN4dgXy9b+fSohe1cNh3jyCPz0q67Yfb2Hkack3
 kyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783072250; x=1783677050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiKaSqubvoYPwqNkTtrnfUm6z3Z4YovKUb+vtD0Pzyo=;
 b=MhdDcWryOt+8FwzMYYEun8wluq1FpNwHDIUzyI3RXTyq8xtE9pH0VmxWIyXST2j2IE
 4J/32S4NFrDDiXABHc1JVAzWOXkZ2Yrx1dJA0WN3p3neNmJtKdCechfqGhLOjQ+jgB6d
 hMF/kw/EoH7JY7ayflBAIeyQsEwJ0vmnDhfjGxI72YHXMMwNez92nxZnsZONo10Py4qq
 7+CtgeorM0wErrpT3hOlPFr9sPuT6Bz/pJy9H8vtRSSQhYkAhKTVEspJnHmw4OLxT+LO
 l1E8O4QC/8xPNgna2VRzQftIHTqhJB8PLib8ETt2kpfZJRJ0ngm8GiiYkDNaWsqAj0aM
 HKJA==
X-Gm-Message-State: AOJu0YwybtU0X771XF0JWgYP/Gm5T8NcSBh4KgU80rD752q3hzfobQ9f
 gHKrCIIHEGDjrbNIYMIrPFTM2E8cGsooJZov7Tqh8KJjBwM7g/0Cd6sFz8f3b7ICU2hazwe6nTb
 aiczpl5O2RoohQh96H3lMsLegNXWSriX5yPPt0ctzvw==
X-Gm-Gg: AfdE7cmabrl5wtfvKnM/xhArAksBGbHw3b2/HQmgBi4UBcDXEWXPJaCkzMGDRDvEvDn
 juezv0E8LzzkoSmmo1tjGJHbEr7g1nq5BuoRfqfQoqLrvTv36n9T2No83fEbcOTVx6xVPSCN7Xo
 EIovwSXxIdKVZO4vOZbppw3dHM0kk7kpFv0v8PZqzkdvDvWxHvAEnNyHPRcyZt4TU5lqJ7isxRx
 1O9IJawyvbOdGMbFGDjthqEPGmTRxd5mnCoVqb3riIPxg5J1eUUp/t1S+HOyogf9vgLxgsjo9Ox
 FWT8zsHa/E11t6OwKi8qe2mksFHBPxi5UjRMgVGl5UVbI3Q75UNUtCW6DqzXsS/aE2g=
X-Received: by 2002:a05:690e:408c:b0:664:a7f7:eec with SMTP id
 956f58d0204a3-665219555a9mr8833933d50.16.1783072250059; Fri, 03 Jul 2026
 02:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260625161855.5132-1-163wangjack@gmail.com>
 <20260625161855.5132-3-163wangjack@gmail.com>
In-Reply-To: <20260625161855.5132-3-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:50:37 +0100
X-Gm-Features: AVVi8CcH523shzouXeTW7C3-MHTgnU6MDoDimAJxKjjzlYQS-cBLLZUfca_BUv4
Message-ID: <CAFEAcA8cyj87FWcJkT9=yUCdX2=Zh=2ZV5bu8jco4=PUwG5iXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/misc/imx25_ccm: Replace DPRINTF with trace
 events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 "open list:i.MX25 PDK" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 17:19, jack wang <163wangjack@gmail.com> wrote:
>
> Signed-off-by: jack wang <163wangjack@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/imx25_ccm.c  | 34 ++++++++++------------------------
>  hw/misc/trace-events |  9 +++++++++
>  2 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
> index a6665d5535..d051e8a2d1 100644
> --- a/hw/misc/imx25_ccm.c
> +++ b/hw/misc/imx25_ccm.c
> @@ -16,18 +16,8 @@
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "hw/misc/trace.h"

For trace headers, we recommend just "trace.h".
>
> -#ifndef DEBUG_IMX25_CCM
> -#define DEBUG_IMX25_CCM 0
> -#endif
> -
> -#define DPRINTF(fmt, args...) \
> -    do { \
> -        if (DEBUG_IMX25_CCM) { \
> -            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX25_CCM, \
> -                                             __func__, ##args); \
> -        } \
> -    } while (0)
>
>  static const char *imx25_ccm_reg_name(uint32_t reg)
>  {
> @@ -118,12 +108,12 @@ static uint32_t imx25_ccm_get_mpll_clk(IMXCCMState *dev)
>          freq = imx_ccm_calc_pll(s->reg[IMX25_CCM_MPCTL_REG], CKIH_FREQ);
>      }
>
> -    DPRINTF("freq = %u\n", freq);
> +    trace_imx25_ccm_get_mpll_clk(freq);
>
>      return freq;
>  }
>
> -static uint32_t imx25_ccm_get_mcu_clk(IMXCCMState *dev)
> +static uint32_t imx25_ccm_get_mcu_clk(IMX25CCMState *dev)

This is an unrelated change, and it causes the file to not compile.

Patches should change one thing at a time, and you should always
test them before sending, please.

thanks
-- PMM

