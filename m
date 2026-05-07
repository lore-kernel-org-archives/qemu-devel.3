Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23667CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuQE-0003l2-5N; Thu, 07 May 2026 04:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuQD-0003kl-2L
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:49:29 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuQA-0007sq-P3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:49:28 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so461960d50.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778143764; cv=none;
 d=google.com; s=arc-20240605;
 b=PrGW7adJ+3a/4CDEXFrSRToe4ZJPYDByCVQgiHfpztKCsRcMdY7APH65l+qOTZFO19
 0W7AFzxLfR0RmEvflWjov/YY7jhclq3hsRsOpK2yhOb5dYKiwGlv+7RUoHzxqrRQpkVV
 mFKWClG9cY2BofHHkxVT5nOaRcgu9KYTU2gfoLhbrO3W3GU0ubGb3zbsWyo27xVwP3Tu
 vF3lperAhb3ryGOZmG+lZ22GFfEhOCg39/38LoPJHlbmHXzRrl9OyqxLfXOxV7VHU6Wj
 5aPYQ4rA9My58E2VccNly30uEne0QW6ni60chEhaGote/oHorlXMLmvbMoozBxviEZ0e
 99ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jdFnoXX+C5IktOW5SneX0UygQHPqKw98To8qBSKRXcI=;
 fh=mfg7oMYGemPoUnmFBZHENIERYVNJssHnRhsjr68iPcA=;
 b=OO1AjVsWHQW95feqFa++/9dqYda94ZwxvPJY9ywRB2FNK1gwloGjWDj9nmoRY+K7sE
 6LlsXhFMh5iH5qK98oW1F42utwua7TFoeN0F1TTn27lin6THxwl0xs8LSkHZQ1n9roXh
 Na93dPmtt2QTDmlZZPMUM2kwhJE64Gwzd9yHYrPH+FFwHbLALCyxRGntaq60JNG4FF9W
 H9QZgkrCRAQYtD9JMD96SDq6ucdFs0g2JosI256Uit8Jjlk4i0o/mTLV5nEH6UGHY1wh
 oXlJT9ViE5JJKta6ZAquv94ilblYG7pEMC7zwNjFx+4ADvAPEA82CRG/RX9N03YZG3gE
 gUQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778143764; x=1778748564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jdFnoXX+C5IktOW5SneX0UygQHPqKw98To8qBSKRXcI=;
 b=B6I9ydN6FPierHF9g9Kcza/Mlgf/bvYYqi7d9onXKF04Gwz5Yo00lODS87+joFot9T
 fNigzqV7bgjv8uGwF3BDRHAVqJKfYpXbz3h9QdN9Y0aaWlrv4iTU6vMVNBOfHsf3IJyC
 INiiuLRbr99cFDHjW17cicaJBKaOaSe5Xd6wXP/aeexHwthdaTHspTJKwnc+mhqrKfjX
 ZqMSEtEhGy74fq+Ng7kao8T/j6f2n16tvoQlpojSUa7yjYjssFh8zRpGc1WzUq8QrZG7
 cF8FdpICz2UHOscHFH5ZAIovxVsH2mDTuHN4/RJW6wHC4p9/Eyf9hPoVAn3ZxFYL7s0U
 rKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778143764; x=1778748564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdFnoXX+C5IktOW5SneX0UygQHPqKw98To8qBSKRXcI=;
 b=sbva55DfqAHOjJ2D4DEpHIsIXuP/z2vGgGrt8pgkVEPuueRgwsaskh8i8k8AIX+cEU
 6GzeJv1OxMeaHfrwXQkSY5H9FEVmDhzjYdG/ssO46Ua+ODVuR3V7GFH/6dnwm/oC3Tjy
 Q3RLWCSYNlJpx2/xgMPwRjGuun8ppJzlN+HkPb9sPSkqLy7NYg5V950nHiw6VvwdEMZV
 pC2Lro7S50BnCPW//2ncDrTNochRRMw2aDFc4GBbmdrig3qK4h/zLGC5HJjwQ+3lapWh
 ykuwON6ZfAamAYMvFpkDyjpfNgbgB5EWeXgJRSLAVvl4w4JZFz8Ycdaw0tjTLaevP5nf
 R7lw==
X-Gm-Message-State: AOJu0YyzJHkSJkOzyRObA0U2VcU8kBcUI4dCb/euyp4eb6Tc/9DV6st3
 rWZgXfjSWI4TCdB6dBPg+MCAFTTIilDAhoxii5zCr0mHaAudascRCfp3cOqtabgLMvLDEs5kQkP
 oCGRAtBjHHPi6bZWMogDZFOkNtIA8fW99fPZPPruQpw==
X-Gm-Gg: AeBDieu/J6nsW2iVt/nvbMf0YvNbw2gTEgOs/bYW/k6/Kh0BBPqT++G1v7Cnxacz2td
 pb/JfRHmmsT3D304d/wexm1qORMCWg92Dui1ojTAf8Tt+ztDuu+cGVldoSbGl+z0sj9atbaCCsi
 IpEk9ITRumdEbg/cxCIO1VPZYP1+hdWW4GpXpjGgcMSlzzdCfOiIiurAfX3bif+uQ81pVyPeXqf
 M7FcIjNLXz8IGxgfv7rxGQFc0OQ61GPxHzXwLF8ADlKSHiYwERZ1LHIyI4/40hJ8Lp6yiEXQiZv
 vyM8FBj0Ft4rbGrZhcKH1fHGRpGNvtC0Mu/Z1TzDycya/Umu0YHORWKMjIG5mNpL8sXCC+e+lA/
 D4yGuOYKsppatEDWBR+83TWY=
X-Received: by 2002:a05:690e:43d0:b0:650:7551:ba57 with SMTP id
 956f58d0204a3-65c79ccd010mr5255643d50.33.1778143764079; Thu, 07 May 2026
 01:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
 <20260506152247.82336-2-munkhuu0825@gmail.com>
In-Reply-To: <20260506152247.82336-2-munkhuu0825@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 09:49:12 +0100
X-Gm-Features: AVHnY4KbEvhmni225eYuea27C5CxEpoT2vgO8Otih14f9_TB2Pyfn3iF7Xf4M2k
Message-ID: <CAFEAcA-GN0EmDLu0Lz-axmYi-5ZgwgpRYm32gJ2pu913nBH9FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/usb/hcd-ohci: Assert isochronous TDs are never
 deferred
To: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 6 May 2026 at 16:23, Munkhbaatar Enkhbaatar
<munkhuu0825@gmail.com> wrote:
>
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> ---
>  hw/usb/hcd-ohci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 6ed8046fc2..8f4de0066e 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -746,11 +746,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
>      usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
>      usb_packet_addbuf(pkt, buf, len);
>      usb_handle_packet(dev, pkt);
> -    if (pkt->status == USB_RET_ASYNC) {
> -        usb_device_flush_ep_queue(dev, ep);
> -        g_free(pkt);
> -        return 1;
> -    }
> +
> +    /* The USB core guarantees to never defer ISO TDs. */
> +    assert(pkt->status != USB_RET_ASYNC);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

