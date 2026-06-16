Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EA2CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSiF-0003ex-H3; Tue, 16 Jun 2026 08:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSiD-0003ds-BK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:16:13 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSiB-0008RT-ST
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:16:13 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6603d8697d2so4254439d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612171; cv=none;
 d=google.com; s=arc-20240605;
 b=derYc0zBaAd3fGf2DoR1lNUA7PcLiBZRfBdNkHghlZZPtOm8voQkWg+RSqbbjCuTVF
 OM8EaqAaDEw+IoGLSac54P9OKEJDrZOze1XoUZvCz/Q6ANvntne/i9lRc1/8NcZ3Ll4/
 +wQZ/sYHs4XnbtQ8JngTXFAz5hT+szkkijSaBYjh/u6W+8OSoGiDU5iii3Es/kWpejMl
 KT7OeV2G2mHCXM/Zdd4kbPxCKlQRzfhrmjf5haRq91OlTBAREDYqkvhCCSqFbmWfV1GE
 bMm8YaHyvX7eElICQ7ceIWIOwUAQs1DVTID7CwcUlqi7KZbGLfL3RiA5NWnCO1rgOOIz
 E+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1LGtA8GqsFNVJsCOCEhJUqllq+0Rhz/5RxwwAC+enBo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=i2OCZ7l5eEsSuPVXthAzxu51wCy4rhKSfrYYxUHnUJ00kC7rWBU83dtB60Pe6vnl6e
 ETe4rOYqFVS3ArkHJMd0Jz77VGcHieP2EVAE01W3Dn7jiwVXgeBmxledFTNnYKN2E/Vw
 o8qew3L9kmKdcDvXRC9LCfz/EpKcVizQrrjXbT15Tov6VRIT6LP07sX+/IP1aXxpfX97
 jovUv1hjCLBjujJ0hnYT0DYekza2ggVONc+bRGR7NaPlzUZ4e77Sg2mSG/AXQEh8Orup
 smLZUWVdeImDlLlgekH5hCLPC8fRnStbm0vLdBruguY+AEnN3Jz27RMXczUozNKTYc4G
 y9rA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612171; x=1782216971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LGtA8GqsFNVJsCOCEhJUqllq+0Rhz/5RxwwAC+enBo=;
 b=VvJmOCcLFqkSQJtsY/GAzglK39tqb+GLgnV10YoTRNumDPNdmEdLgw5IZugoJadZpr
 ct8Bt06ztR9mZEeNK196o5YWEPOXIB9Or524T78PUliERa3cur6llWqJc+cgogR9lCgR
 tfMGNLPJxs1OPqMldU3hAnMPG7o/TBat8ZuJXIrSom6mcxtLz3DU7BdlABShJks/elA3
 P7HIYpn+aOOaAPN1aSq4eafE5GLu289AXP8J5ZN1FNCNbmlsedXeKfC3xsbEo4i9+Ulk
 ensvx4z5CWPS2FJaZBRhSVe1KPQcbQnfDM5J517R22oBBCK6P2uPF1gfyVNilAZZsUQs
 BYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612171; x=1782216971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LGtA8GqsFNVJsCOCEhJUqllq+0Rhz/5RxwwAC+enBo=;
 b=R/IUvNQG2yOziqXVe7fT/14GirZDPghNI9mLYW9qGKL9fXJYcU4d7PdmlJ+cog7oBD
 HQcrwt8rf5m3D9/o6jfFdZuCPPa2VgcbllRHFHUEfum96s4+m5+MKbM9cDa+zHxp9yII
 PfSbT6W5jYETOwBab95h8ljOVrj2E9cLtbQLDwD68GnBTFH5NMuxnVJBCUppa1V4vWut
 KZQCgIQalKsVDZliDP04pme8ZGkqBqvh4eA4Q7sbGAqI6MXZ7j1ARF+yR5G+jsCnKFj9
 JGZRlCXxOImspqu7fZlLG31LJQGYb5mRDJrHMhZp3G6MDK+P/EyMdV6v+PlrlfhM0Y27
 aq5w==
X-Gm-Message-State: AOJu0Yz05IwD7BjxW3FaxWPO3wGJWxF7ezsYpZocPm87u/WgYj/cw73m
 jzYUQXN5Gtv/8cPCRA2iqiR+trKLFPoCRl/CxZAHBLFH8vDNyq3GFd2MJjs/0byRgUQJw5AEA5E
 noKu9v/ZEXFIYOx1eaMQWFDniNyEflb1NSZhkgsC4mA==
X-Gm-Gg: AfdE7ckvzCNwN+uugtqTWM6ntV5MUYJ6W4pMHs+pw710LnzwJjRGnBgydLayAX7C/Eb
 l11woKmE9HfPayK/crHm7xCX9ccLcz7k/7xTEZ6TXVHtUuixeJ6GI+Kas/tBR53MHnXvE1wJ+ut
 lJEJtT0ej+MmqSB5zJpSyWN2OO8g/Uh0Hk+0j+If1xGvJXOOaf1Nra5dHYEQw/cTxgCi5lwX9BO
 1AiRSIb8thS1uTk81eDhO+qq4AUGbce/gLGK3rpvW6axvl5ifLPNwusE2uzjiwQiKuqPYCnmxTS
 cHJKwGVRLDISgs0us/8BFg1DX/kBDHtyE4AkZO1p7HlPiPxasbJKTH82no36I7UGXUqLMbuc6O4
 Tjw==
X-Received: by 2002:a05:690e:4402:b0:65c:2a49:8843 with SMTP id
 956f58d0204a3-662b60db2dfmr1650085d50.19.1781612170441; Tue, 16 Jun 2026
 05:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-4-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:15:58 +0100
X-Gm-Features: AVVi8Cfe_lespnGxiO1KiLppVEK4Q8Htetx6Le7RK6n949oPjN7EtQOiwlvfUYc
Message-ID: <CAFEAcA-TNb_YT3dM4CHM0+AOziYApt1yz4n_dVnuK524kfbjbw@mail.gmail.com>
Subject: Re: [PATCH 03/25] target/arm: Enable zeroing in DO_ZPZ macros in
 sve_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 5 Jun 2026 at 00:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use the low bit of simd_data to hold a 'zeroing' bit.
> The simd_data field is currently unused and always 0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

