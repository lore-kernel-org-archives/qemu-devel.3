Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D04C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpq9v-0001C6-5M; Fri, 31 Jul 2026 12:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq9t-0001Bh-MR
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:32:29 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpq9s-0003fU-8I
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:32:29 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6682259cb3dso1912494d50.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515547; cv=none;
 d=google.com; s=arc-20260327;
 b=R5AfckarDrJct6uoGsWVUkPOD4WU2q5S/2PoHE1dZAHr8DgVoThDgDHhha5hf1V6ce
 TZ/CwsABBP8Nxgg1xIWH9pzOKM8/DDpvG/J0IIySsDeAHG/KP81/cwqDDUCHpeaZ7BxY
 q858d8F6fyC/agA0d7DzVVpIqBFGu9cnZvmMM9PNyzBYD0LkZ7clNZTKUm3IfieQHnh6
 pXTwEq3S+Jftt29BnKlyXGzMx8ZdT9gjc2gELQURArswTFDZr7qhMEPnmS4Dy47xMWB6
 ULQ/hS2xfM/o8Hoj2rXSsx4lZRljW8fRhZ6chiUPIx4WyO6Rv9aggeqdNbQn7ycdJKGw
 a/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oxPZQp11HYMpU79n/cPA45m6EN8EyAfwvwDLr/JLBak=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=fo7cJgI4afuvntwwgxxQ2Fulx9502gsYCRWuOyak/khVyDIC0WWNFjeQmpuGs18sAP
 s9DQagBIXzCQ0ZsazSOQla5IyMI2dsoCCjEswGiR1Ty/Tg3WUHkDkL9mkv7XF6N8ecqR
 H51rdEDUA57ELGor5RaU2cy2nWI3Slyfdr4Mno68W9cFTLhzvF7wZ1TC6z46pbNTtgYS
 iinafsyAg7r4mRkEnolwlXoXgdIsyvD6P1ahnutCR9FbOnE2kBOcnqEumBMoGFUusQ3z
 sIgEe+cgz0lP/xmDbhd8NRiEoacpjJq+AocxsE3GQVlDQ3MRjvatI6p8D9kQ0CtYc9P2
 IAAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515547; x=1786120347; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oxPZQp11HYMpU79n/cPA45m6EN8EyAfwvwDLr/JLBak=;
 b=nH1optFTyLgVP0T4HkwWb6kptIiGrMgZ2GO5cXK1JtX4SLh2zcwuJzAkWve0GCQ1Wx
 uBDl3MUwxOQklrasiOI2nh95E155YWLH2s6LPyJ3EccCw3dDGFdzQzf3NavRlV4AqLJF
 7OjTQUVDOgEVhHYgfgTkaBhi6KhixqbPlel+7ZFqGnVQWCgOUzK7psTXr6cgPWalLpUt
 pU28Ml5/UJRbwQox1KBmRrPG5iGSAOsiN2jTLX7NTbeyQ24eouFHUQ80WOKSzUlvL3EI
 QrGb3Y87Pjyosycm7on34fAsyqSrrHwifhKxJqKd6jcCyY98AmF8GMt6xgzz2aETWfVF
 YMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515547; x=1786120347;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oxPZQp11HYMpU79n/cPA45m6EN8EyAfwvwDLr/JLBak=;
 b=JGcxz9Mh0W23wHUOg9RsJicrsxQ2pYiC7XEZMfSSn4fWB/cWVgg/24BOdRBocEUAaP
 yOe15GPfvDHTQUbLa4M3ZbzNe0h98mXAuiOsdFf/+7Zn8OttkWcDkWj8AdyzvsLB0LWj
 xVJHz8JKQW+ERRrnDOfXCEbPg0Oo0OiHYC5Wh8KG/6LY+lVoyDVaBqSk5Qfcfxg91UxN
 Njxp5ha7rkJ5nJWfsP4X0SjHExObqBx/qjkHpJchKJsjKxp21lC6ImZMnfNi5fIFXu1Q
 Oid2RzwfQtVmL8WSfx6673pnXWNPOx4wT3AntY+0k1KIVnmiMTXP9SNLECK7crRejZTD
 rESw==
X-Gm-Message-State: AOJu0Yx02p50bohW9D8D9R+BHWRpomkZut5r32A49hECG1FpYkoNweRk
 2d55f6UVve0HKjTdxaL39VQ/HUlbuVEX/gr8JL3Dwl6oGYd3MZwGW7XG6lwowTH+VsqEIGXNPsy
 dcK7FQOWsqtxsoANHklEXXtfaRsWyQIg0RCi24+RP7gRJRvvdZKh+
X-Gm-Gg: AR+sD11CsbcVysn70glqPBVnxHnybHh0emUdXn6dhuPX2MbpDcJxBV6uVu6IbzYQzCs
 vsEZ1/Ybe/p7ivj1K6QLCkmHKl9E/sGhaEaI3uuseMZebLHN+qhY6LdmBa2yPE0nVpSkK8z3wxl
 NUxpf6GtSIdWC2E983pk5BHMhadUK3S0TZfeBau2k1r3moW2pONgf/P6dXdw5V8NdwoUHH0fCT5
 1Q3xS7zyfPH9SV8db7csm501LDmLr2iwj2y5fAEy+MZ71EpJpkQITta+aLkRs8lUgWz96mLrLYd
 eBVE4I8nziOruEJEysUF3SgHBuCCP/gAXiaIGJ722Zv8SF5hTDWgDRXvbnxvztB51aWgJHr06Ng
 62Zlc6cZ4VbB/O8WzjPWDGtZbFYOz
X-Received: by 2002:a05:690e:43d4:b0:664:a8fa:19db with SMTP id
 956f58d0204a3-66945bdfcebmr1671098d50.5.1785515546972; Fri, 31 Jul 2026
 09:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-4-richard.henderson@linaro.org>
In-Reply-To: <20260724030616.76180-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 17:32:15 +0100
X-Gm-Features: AUfX_mzs-YayEan41WbpaN8w0LxLhYKctZ0qLARl5gbPlx-3WpfNRtLqeiCbfhQ
Message-ID: <CAFEAcA9pQJsfj=5Xt-2dBWBEKtTW2rWgQNKQVZBp0sBdR+HDXg@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/arm: Add FGWTE3 FGT bit definitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 24 Jul 2026 at 04:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

