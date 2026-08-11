Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A7DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjar-0005o7-4Y; Tue, 11 Aug 2026 06:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjap-0005nr-At
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:20:23 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjan-0004Gg-K0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:20:23 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-80e2cfe6918so32245257b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443620; cv=none;
 d=google.com; s=arc-20260327;
 b=JFt3R2J0K+5E63prxrCF2TEODg6GaDYBv0ZTfpa4VAurbe03JelbjjVHbs3USIquW/
 bfk7j1xD5m4RO0rQc+hWU1MwyFOO7ZwIloVSNUMr1dD+Dk1n1KrpWaexyb93mpBKiyLQ
 eaRMdswkoIFWKvTbD5kNpn3S0Spoc0r+H/VCsnqzHyhgGOJ1oHqR9oeI4l6Tg2bEW/Yi
 JvcBRpGeoMRr3dZZQKumoyXvk46ECvfTrdNIpYMBwnLL1cWgHtivF7WSvNnDThy3yszx
 7Vt/c9zJSi6alBs1yChSWcaejSjzMlfgg00G0IsrlI9viqyqe1nm+stPNP/H6PE1Cd8z
 lPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PuonKHifZBM2j0CvU/PMoKGu2t0baagafZqtaczQrOM=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=OZiAI/MzgodFpCoebDQchF1WkkcqQSkzZqCzf4N40MPpxr3fonKNNb7MyBPL2yRfxn
 SQ46YNS/eZgNaSmVoFXXQZSdunjhssvAwKyqpfy3RTMNrn4SdgU01dQF5gtVrrICkBYP
 xtE4YexhXqiPdQR5MhRcNkuKgGF97GFxiZM4DRAjhjrIUPwtDZBnKZCC4CMTncOuGmkk
 tI7AVk5ado0Ip/Do51z/Wat66Ddfn5AikVUcp7e+S4EB2HuP/gY0CC+twXYrRhrKgl/c
 pr+RMdtEn56eHlr4eIo08dnn7No8OHAp85F4ktht/OzI3T1MXVX8GJsne4otzmKmZYhz
 6d1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786443620; x=1787048420; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PuonKHifZBM2j0CvU/PMoKGu2t0baagafZqtaczQrOM=;
 b=xywRZgX7C4sRLnriSvBc+xKCvrnfRrqFQ8hSVHOUu3lbIL1T0KNzuTt6Why+bNZfL2
 WmeW2996m1SPy/Re1Lbeicy+Da4j5K4D59Bch/VPEMdZ4G5NT6ExzPoaxPuCshddB0L1
 3ce+TsGRq/IwcSO7YRaIayShmhyySqeWt74ATHheTHgRNu5tp5HCo2qvxCzSe8ustflA
 CF2SIE8ECqznouoe1hvP+zhMtDSk4tsz6CM0SX7Y2/HzDYVrq3djoxSG3nS00Pqv6ihh
 69yvRL14zbUKqdjRgq6hin18mAs8fQqSP+MGiW0yxzkvoJw4UXbe6YGHx/sdVaZHqxus
 gIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443620; x=1787048420;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PuonKHifZBM2j0CvU/PMoKGu2t0baagafZqtaczQrOM=;
 b=UxyWT4s9EzZ3DBxELIbB85Yx3W3faUDw2w8J8VGGc0LbZl3gUyZsw27UoOmGpqSSxn
 XjivV1Hf5vGIJjsTqOkG2k5KaC5KSmmiLV5aEXzBspQUhUPgglc+sHfWOvU+2MviTDZn
 f194LguvY4iBFRfOdBuGqaPB7ev39SGaiVvRk8Tet4I8WWr2y4s8wWR/LJGp/yAebt1S
 utGta9cVOW8sDkycV9ZAYa3wtJ/vnVy9xHxMSZUtfIGQczaer3F9azzXwNXiVtDA6rUg
 RbEAJ///fN3x2sJrHRdc8buKNyuxmkG49Kb5I3hKDLEJTVjBZazM/qUrDm8huU5yw7Rk
 lxwQ==
X-Gm-Message-State: AOJu0YzEkzua5Xxt+j3UdpWKeJniE6BFVx5Ba0JpPWV6XkqfUx/OSqPE
 23FD+ksq0BEMrEAeFrH0pI6mZLPV7xMff94d4dQtB8nXgP/m1CrePaE/JRY4Y+7amZqzEii3dzo
 2tUPiQMOSla3thz4AzW4RRNHqJcL12FgsfETn/QdBCA==
X-Gm-Gg: AR+sD13I3qL85GIqBPoFKYzjxi47c7UDDhP4oV6h+aYNq9MJsS+EWY+8yQpGfUQjRxz
 ueuNpmTiftdIXN6nco3jE6WgeTELCuWu1SuylxWHLBjPDygdN4RaxgoKIBAKSB8LfY8OxOQmm0R
 wQbKNZA8G1PV/V/BlMVJn2Z+z/Eng3GJYBD4oayFi95yPRAgfqxZg/FR5TcGP70IE+N8trS7mFN
 wcogKYIuPaHhps3b0YMfzXOcGQGlN5yxp2ZpeBgKu+5bmOEOk0f8sa8stIBDTmZrlSi8wKfQgPr
 WmGOj/oakmceJ8Cjx4Efe3UAyl0va7ru21hoSoh1w/hGyA4EcdtGg1aY4+ZIwHFu/MVg24KZK8l
 vFlq2wHebkpBGjXrRUTcdU3ZHj9cw
X-Received: by 2002:a05:690c:601:b0:81f:653d:4992 with SMTP id
 00721157ae682-82f2b9a060bmr16289517b3.13.1786443620018; Tue, 11 Aug 2026
 03:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
 <20260805191257.11303-5-simonxhy0404@gmail.com>
In-Reply-To: <20260805191257.11303-5-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:20:08 +0100
X-Gm-Features: AUfX_mxdX_fy376zf_-zPF-22lKYyRi-_KVZW51c79anogmGuxazCI9BwpN3NRk
Message-ID: <CAFEAcA8EB0az05AwqZHWavX=XPz_sKKCV+vb2VC8s7H-qLXgjA@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm/mps2-tz.c: add AN547 AHB PPC EXP1 DMA ports
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 5 Aug 2026 at 20:13, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Page 42 of the AN547 TRM defines the AHB PPC EXP1 ports with DMA 1-3
>
> AN547 TRM: https://developer.arm.com/documentation/dai0547/latest/
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
>  hw/arm/mps2-tz.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 81e64a91de..d6d178642b 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -1113,6 +1113,14 @@ static void mps2tz_common_init(MachineState *machine)
>                  { /* port 7 USER AHB interface 3 */ },
>                  { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },
>              },
> +        }, {
> +            .name = "ahb_ppcexp1",
> +            .ports = {
> +                { /* port 0 reserved */ },
> +                { "dma1", make_dma, &mms->dma[1], 0x41201000, 0x1000, { 62, 60, 61 } },
> +                { "dma2", make_dma, &mms->dma[2], 0x41202000, 0x1000, { 65, 63, 64 } },
> +                { "dma3", make_dma, &mms->dma[3], 0x41203000, 0x1000, { 68, 66, 67 } },
> +            },
>          },
>      };

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

