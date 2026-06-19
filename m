Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D8CCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVR5-0003d2-Uo; Fri, 19 Jun 2026 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waVR3-0003cX-Ev
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:22:49 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waVR1-0001Bi-W2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:22:49 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7fedf0e99bbso23240837b3.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 02:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781860966; cv=none;
 d=google.com; s=arc-20240605;
 b=JgnlCTPv7txZpUX59hOMh4oHzUGwvXKpw66DnWn0NqUyd4pU+/v9YO3Z55qnx/4sda
 yvt6+8dO1P0ffFlJKDQLGIP2pRCTJDbED1ergPIyQ+PNoe8u5EeK5CE5V1quS2PqJXzP
 1M9zdDlBLt1o2TkvEaN4JG0CdKsWtC0J6chIcURSas3SyF6kOy22yfv+JoWcHB9NDFlq
 eekqqpkbpSpH5PhGShlF9svzgWfJOxumlKpXiGBk6f84B23fzlZO6iuWntiqRTqePd5j
 kN30vd929Kb7IzN7zJosttTSArRcsaN8YyReL+IgqV9TUx8mA16WThcfdPJdYYFps4jB
 ieJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mL1U0s31dQTdtCCEyAaZj0ifb+OPR+IPq8pciKUx0lk=;
 fh=dyXUG63CgbyaPc/fac7FxJ3H9TbAYXMnk3EgI2o4tdI=;
 b=aEjZ7ZpXPxwgqb2zqUIC2Xyhuvbq4wuc++FrX1dP9Q1gLHyUe9CZJVxaxnEPCzkGm4
 ZhLAcIwOYYwixdMT3TVh1sKhIrCC1B86f8dwECybTbObSeFvPzkmbpaOMQsErHFWnkS8
 vTD7G0pnXZwAdoy6KM2GtWgs9s97gePmhzrYVUiJpo5aLqkAK3GeTIJgPQRAvnhHxFVN
 8udJHADzDkRn7xCjEuUlDXfNqEh+G8z2Isxyy7PYSHcCdPIdEDmCk+wTAVczP56wvuje
 OXmwIpD91NlpBYH3Fx8mygQWKKBTtoAVouRhT0WlAmmyPyLzybuumuCpFF7Z/KAJFeMI
 /X7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781860966; x=1782465766; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mL1U0s31dQTdtCCEyAaZj0ifb+OPR+IPq8pciKUx0lk=;
 b=sOBKcgAh/DoJsbnUq1tayn43N4H3xjvCZA5xmdGXm8GZ52r+foNTeXsbGxNaNEhRtz
 YuEd+iggE7xTpAyISpMFfFn/Y3IIX50dREPhrw58UhZsmQREoOMIl4idqi0uFvxheSzf
 cjGCzJHeR8sVMpJJkI5y9jYltn6QZ8k1pkhHGZkpmOirDNgs1O0DMYbOJe0xwWUcZ2cC
 Kd9wDeyNWdOQOKNdcz8u4XU3t/8ea9AancH8bprRbV5ChkmQgyLU5WMNZxDdLhJM1ky4
 YkYZmZMAEF+8KrWIS7WWjE1u9Dj1XhbuThoEmag7b+5pRl+aQ26G+lcxf8vPvVT2vHje
 H5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781860966; x=1782465766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL1U0s31dQTdtCCEyAaZj0ifb+OPR+IPq8pciKUx0lk=;
 b=CWMPwiPDH1uLExh90POR12XyAXRcEsm1eOq0NcYZJQxzpbVsxiH16zBUQMZBLLir1W
 UFcsu3LUX68lHCLxLQtVVgj5ewuECA6ksQqjVAD8GZ7pRismMcYosMJukWpdgvMLZaL4
 YNDxgDkOdZCIWCs68lylfLTmipp3jK9WrWeNWM8IsXscdoRhfZ6rqQauW/L3G550Wtws
 Gy5V09h3j87NHTb+ywAQNIOwnyeObzo50rV4G0nqndQa4YzW84INMFLQyj5ITOKxGFYV
 trGkTB7u7gT2oBNm6EvBUW4J5j6Jc1Nye290PvyWXzjsK+76Bg0eZjLqwSM5XYkuWYq1
 rG9Q==
X-Gm-Message-State: AOJu0YxYDEnihXg0EtfO/KmYWu2EbFH94odKEzViDRJDiw8XTA/GTPK3
 sbe7hG9BDNpQeh9W9daFNkUAv71ToR99FcYPPInLkFAFjPgDD5eso7o4fCFl107NU8zp7guZ0UF
 VPuzloXY18uYhxa1y6wtrzW94ZeZHrpFCzcJDNM+opw==
X-Gm-Gg: AfdE7cmiR/L65JAHARnV/QDg02TBv6+nHr9VXGU72gTPapISyPRo2JCLnW2+bLKh6HV
 p4wq/WUMCsuwuBHEaF5kaYpIOeFqK3Ggdra3mHD4kCLNduXSIUGme0HgldrzOafpJspIPzJahfo
 DiSus0vRY6jKOpnRwBSvu/eeB5Rk+EtFs/ZIHnrofjkzUmZEiOi4VR9IjVVHhfvWfHfpqImi02h
 WjlOXRILNgJJnjJ9KnL2NJj3W4pqs3y83emyrqjztTrWSRbeR+F2v6aZHxQViqxeuDXiqlgSUpm
 O/y5jqKoDzRqGmIKNPIzyzmR58+PyKj9cJHGFCcpSTTUUhV4BQjL2WTD
X-Received: by 2002:a05:690e:d45:b0:660:5dc3:3fc9 with SMTP id
 956f58d0204a3-662ffd21e3fmr1952835d50.19.1781860966378; Fri, 19 Jun 2026
 02:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260619080934.237834-1-christianslima@proton.me>
In-Reply-To: <20260619080934.237834-1-christianslima@proton.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 10:22:32 +0100
X-Gm-Features: AVVi8CcwWkOZ1ewkvoH5AruyWOYB9hkXoD2B5uIY5zH_xf6qt12wj6XLc1qt0pM
Message-ID: <CAFEAcA9bzM19ny_wGKahRETFEp2_Od=O_TdPFxAkXnr=9Xvwiw@mail.gmail.com>
Subject: Re: [PATCH] audio: converts malloc to g_new and free to g_free
To: "Christian S. Lima" <christianslima@proton.me>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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

On Fri, 19 Jun 2026 at 09:10, Christian S. Lima
<christianslima@proton.me> wrote:
>
> Following the qemu coding style change malloc to g_new, the advantage
> are that g_new can catch multiplication overflowing size_t and allow
> catch more type errors because it returns the type itself.
>
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>  hw/audio/fmopl.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)


Hi; we already have somebody working on updating this
set of malloc/free calls:

https://lore.kernel.org/qemu-devel/20260428162048.2995097-1-luc.fast2004@gmail.com/

thanks
-- PMM

