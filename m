Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06CDCA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfr4-0001j6-Pb; Mon, 05 Oct 2026 06:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfqC-0007M8-QT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:22:42 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDfqB-0001XQ-5H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:22:40 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-677dbe051d4so657357d50.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791195758; cv=none;
 d=google.com; s=arc-20260327;
 b=afHfGPNRwFW9/kzv2kRNIgqgInJ60K8lncbeIR0xCR15r+9RZaEGA5RfaMp6ZDxfjO
 rzmkafgRuAmFt2i3B7Te9IrdElqUASpXXuzSOfBApQWxw/EP72OpGRnu8KjAFDKlI7ir
 z2owa06EH/joyIzOOm2QPrpWA9/xNdBiUaI+AXeXOie+6shaEPni363EAalWHvkiGc9R
 Leca6cYxjnU+85LBUqSvp5ky6MPOyXpjsg0N3SVsOLbDeNSfYmvJaabtTKDudmaIp2d3
 rAbJYpKG8Zm04Age08q7CezlR3KNrBF8k+ff9665XEm65Wz6o+06loctK8wfa+H6vAF8
 FbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R15Oyss9wprL0XMCOr44LJEYKtBT8GUKIm/MY0njC88=;
 fh=fYbink0dv2K5JH7y7l0ooFc+Kby/5lHeieI3AgvMwzs=;
 b=dwQQV+COfZJ58HHqX2iEvLV3rqunAbjxRzMVHIXKku0P9vOQIaJdE83LVlOBbfmaAS
 5FCy0NJmSa59PQoKc5o1nT1Uq2maJ960BOdAh9BfiBrfOwFX6oyTkbUDu7qooDfq6oph
 49uVvjmFMHOnc4+eyGbBPDOvYtnxw7TF7NBmO4bOGxLjD6HeZOyXkplipk3hhrT+MKA9
 t2E5Hf2j5o47VXhucN43xvhoNKQJXt50C8Lgn0KmR1V3NP5/DkCImAEmkwH2DoVQyhOs
 M4IN0GpvjeaEw4UHBime/r7mnu+Hp148FZ7d7xdHYgoIVFo6NkUnjKTE6gWNs8TVO97w
 u3iA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791195758; x=1791800558; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R15Oyss9wprL0XMCOr44LJEYKtBT8GUKIm/MY0njC88=;
 b=mOoz1JcgpfByB2SiTgDciNB/TKzYPLR5UiI9oAv8wLpd7W/UedPpLH/5L3JaVI71/p
 Aj3RpefqD5jRSTIL9T2eqH5DrKY/QTYThQhJIHskHDp2fO2uvbsHq8i9aXZztVGhruW1
 b2lPjo/5j08gW1wI9yfqryZ25OILHv+J4ZbHgDgw44VpDObiOOfPokWG7SsDVCRcGThs
 SGOkwfd2vwPDe3W2pjOXuySmdsnNAS/EtbOWsTfHnH+IWHGsQWJmhH2waqs5NvsG7G3e
 ysaQeIwXY5YotnJJbrqRiRY+CW17szN0vfDkDVkPZtrpzW8Dnvs3yMWVF7jd4W+A3nFj
 D+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195758; x=1791800558;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R15Oyss9wprL0XMCOr44LJEYKtBT8GUKIm/MY0njC88=;
 b=ibUxLbMzY2DzdUbJkuuvfgYRGFZOZ9bvi2VbmKas2D/IU5PeJITmxb7ETRCpXD+DQK
 +ESxjmhrBw7kitdljrgBzqoJxyRQZ2MA6ysUC2DN8TjJkwAR+LapXxXlnHbOxgfp0mY9
 wvfxJgj7HsvTSuCveW7r2if8OFrnfjH4GgIE6kbHG4W4rmsLO+Sa+6yymVN2BYgcCE+v
 pGxR3tw8FcXgVCWEy+gvMGKV8rlul5LXeHjh9J7Es3ar4JRrQ5kxd818iUVTVGIZWOaE
 W8mjeU4jNr3Fcu5tAOAQj7gTsmO83xXH6m03D2Yj+SAwh1UZpb+TMmzehWwlVQrWO/g3
 nPWg==
X-Gm-Message-State: AFq9FYI8mMnMn6X5sh4czv226OtMTqd0C+4ZZS0oZTO+8YTHTXYyubaj
 /SxaNsIpOTsKKwqkfwtGyJO5tT4vxz2yCJ5GmKy5Qz7JTxf0inAo7o5UswyZhW9cNnhHIXQWtZQ
 tR0/rMo9RNirePnWnNHPAHzPGOqLkGIUBh3kHBupy5w==
X-Gm-Gg: AYBFou2U5PuTeLU6DJK21Ytd46D9MLkhrkojWRCfOqVLBWXydbLEJFlFBylxXLTt86w
 lz5vFMhaqNp0j/K0NE0BA7Fn1+hOo11mfSEQySQ6B9FdHtgJR411Sr0wcHLJXXRF8/5P7HBzf9r
 dPC8ZNbOPPTBhYuDptxN2WYH0WPE0FWtLYYp7fNW+shtT0sbSVX1DJVbAX485UXrQE5qa4rsPOe
 dfGElIOiQT8I9zSC1NuTE5D9yWZjNGc4e4W+KWqzWKYBV+RrkBGX0igodOblxuTfbl+NfwUT6Db
 saXY8/04NJH9JHqlzl31TnrE5vlWTTTCH20kbIKX8ID7Qh/FQMEVDHxpIXIWNAlbTHtcQ7MBBRp
 nww6/lhev7imabdb4HV6Ty2yMHiRvd33lPVgXhBU=
X-Received: by 2002:a05:690c:ec6:b0:8ac:4531:829f with SMTP id
 00721157ae682-8ae950f2eccmr20411047b3.66.1791195757822; Mon, 05 Oct 2026
 03:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-4-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 11:22:26 +0100
X-Gm-Features: AclHuK8SdaXN6tAyevNCJpW0NivQcZopKzKr8TuUr2SreUOv3VLx6n3GSAEpdmY
Message-ID: <CAFEAcA82eVaZRLFph3_7jcad+oTWoh8sBp5XV=BTQnACAh_iCA@mail.gmail.com>
Subject: Re: [PATCH v3 03/31] hw/watchdog/wdt_imx2: Clear WDT lock on reset
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 5 Oct 2026 at 11:18, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The WDT bit gets reset and becomes writeable after power on reset which
> imx2_wdt_reset() represents. While the WDT bit in the WCR register
> already gets reset, its locked attribute wasn't. Fix this inconsistency
> by adding the missing unlock of its locked attribute.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
> cc: qemu-stable
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/watchdog/wdt_imx2.h | 2 +-
>  hw/watchdog/wdt_imx2.c         | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
> index ad36b8820d..fc01fc46e7 100644
> --- a/include/hw/watchdog/wdt_imx2.h
> +++ b/include/hw/watchdog/wdt_imx2.h
> @@ -85,7 +85,7 @@ struct IMX2WdtState {
>
>      bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
>      bool wcr_wde_locked;        /* affects WDE */
> -    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
> +    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
>  };
>
>  #endif /* WDT_IMX2_H */
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index d897ff6e52..a15f452d48 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
>      s->wicr_locked = false;
>      s->wcr_locked = false;
>      s->wcr_wde_locked = false;
> +    s->wcr_wdt_locked = false;
>
>      s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
>      s->wsr = 0;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

