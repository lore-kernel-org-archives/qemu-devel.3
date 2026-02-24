Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56504E9B269
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutBR-0000VL-0c; Tue, 24 Feb 2026 09:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutBN-0000UL-Uj
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:38 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutBM-0005TZ-93
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:37 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c97997b0fso1101332d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942475; cv=none;
 d=google.com; s=arc-20240605;
 b=YTsiqLtY5y3iR2FF2iiL8NlMLFvJpunLFoy+padoP7beb2Znos6M9ICiRiNXrdJEO6
 DWy1qnQ0/B2iBHiYKXZagGT7tJPvrrAnqIYNE12pfDQvRlY48oeh31uMJ1uwtkfmwv3r
 Ud3pY8nAtTSHKZRY58oZXRhRYkAT1UDc3B7/xPQLr2HI3ncqXPIxPFKP0SK/Oqtzaz2R
 54Vu+DTx3uzaq1qkthwKH/pY2zvYlhutGPV806LWUJWAD8dpdsZMNjlVQ8KhT6ZSyzfC
 f21AjN688Ey83jUK0/3I0oukRZCthTPR7YOiiy9H9hg7WvKg0oa3Yd7tb2zXcw15ik9J
 aOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jExjNxw7iDRdeFxQCGnw8+gfYUkL/kgK4mumQjCcmns=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=jIrm8CyeYe24Ml6+YSmJVGQWPe6nuRorQikLhNN9cCAQidKt9wk9rmEDwwnXnORXFG
 jrMZPi2OZGFr2XI5W2FJCd2YtaEYbjjDwBqpD8NVP8vS4SwHZqeWbi5puJH9pNtXfMRi
 VtWH/2M1Gw+JpgBgpl7vDvyCV2jZ2fTByRP9FUwCM/gWSKj0JHj02SxwLbGo5URzsIXS
 m4lUd0eevF8aMblCiYAY0Uzc93SBPy5EpZqjPN3Su81kCshRx1kBn9anmPqtMX/qZKTX
 LU4VuMxMF68hCYpZS24TtjCsTX4BqgsTgONO+4uzQrYBxQwN4PmNBvTAyotjjNu/gws8
 WA3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771942475; x=1772547275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jExjNxw7iDRdeFxQCGnw8+gfYUkL/kgK4mumQjCcmns=;
 b=yyLC7VmSsI9FBGkKsmEQEI4Em264gNe2ph2OIUcdbXaprQL+v4gq8pdfYiG1kIjN6O
 29Xrz453Zd+9j1zn8NFYgoSJRyHDRJZVXeqZ86AHDaxHWNq5USzypTQjW7oykcuneG6I
 6vz6U5AHznddCNe+nF4V2SbRRGhtM63/cbq2qkF7RrsGbE8PqbjRhqna96ditHQXL/y+
 Su8z5g0CnqSZITLeiFzBLEVqcr7h5Uw+YTwASNZQkwiRVkkuf4rgllt5foSMxia4Z0Vm
 RxFmo8OUfcMVq5LtahmJTvxd2LrR33Rax7uNVlsUQz/AoD26oJGDOngh6pP4Iej1RA56
 5Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771942475; x=1772547275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jExjNxw7iDRdeFxQCGnw8+gfYUkL/kgK4mumQjCcmns=;
 b=rM5j88/SWlhykNZgNvgwwGsHzLH3nAbp2aq2vSLqhQ6WVlO5y8j07laHWoTt+7lEOB
 4au57oiV7/7wCvAje2UK4BxtVA8rZz0bQ31GfAnBG+wlZ3tHMJZxBOlp770wHxdUoH1r
 ASIMkWulMcx7PzFkPIriWfwaceo5jBByWZnc5q1xcwagj2g5Lt8ti4XTlBbfXBD4ymp4
 4nOMo1ZVvdBToYvdKeH7xTKprnrnFW057mT0uy4HKxDIA82dEcEN8PPABSG8rrv54lBS
 yl+Fp7o47dQCNN0PiNniGeQyGyoqRREd4EW96422zWgOro8GxcEm5SpPZTLJVQqOTmWm
 VY2w==
X-Gm-Message-State: AOJu0Yy4cKWxyoMTdQ1CQuq9eMAig4P4Stov82CGYQUjAsNCl8ACwJqB
 XZ8IGXVhQ2444HbwmBNg/Gf4WApQI2fARkUm1SqS2geoiE0rLOSoFp7mukGulTsuTW3YOVFi0mw
 0UbPby0BZZvbvgV3hUPMthD3zVwqUEagSdpc+jNBO6g==
X-Gm-Gg: ATEYQzyTnYukijIIR69/y3D5rK0qohsK0H5IZ/qvIe1q0Sd2/3flUBqF9UMXVm94yzS
 MsOY2EUCFj8WRcuKbGqc60rMj5KLzyAlSUWPkxIlW3opXJiuV0gaV7i4E3cmB4nuTTCJr04zYFr
 NbqNexHFUgoCAdHQmKozc8mDUodennAW+w1e3f2/3/GchBYilWJcg1o0D4eyJXf5r+zPGThgba3
 ZlBi3AP2sl4X7PcfNFCBGgorToBYwAQiicsF0Vx//+STG033qAEL2XE11RGu0+mAPLHUfYj/uqw
 wkuR+kXd/FUKkF65pzR4s2F2zNdzwh0gU7g876TBp4nIBaInKakOGI8gtGQOCK4O6a4eKcx/0UX
 J+A==
X-Received: by 2002:a05:690e:e8a:b0:64c:97bc:994c with SMTP id
 956f58d0204a3-64c97bc9a50mr3788836d50.84.1771942474925; Tue, 24 Feb 2026
 06:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20260224013342.2470297-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260224013342.2470297-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 14:14:23 +0000
X-Gm-Features: AaiRm52-b4RsEoynOUtHurK1_eiT1v2hhFZ5K0F-8NJGPQTXYB5Cd001fPj_RLI
Message-ID: <CAFEAcA-UZVMkt5wjTWwws-xNsjw70cUA5ZxhKQmO3N0Q9tkMdQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins update for 2026-02-23
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 24 Feb 2026 at 01:33, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:
>
>   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260223
>
> for you to fetch changes up to bd3d912b77b5d2b13ac7b055cb5ad33d5a86dcb8:
>
>   contrib/plugins/uftrace_symbols.py: filter out some addr2line error messages (2026-02-23 17:32:40 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH] contrib/plugins/uftrace_symbols.py: filter out some addr2line (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260218172356.938236-1-pierrick.bouvier@linaro.org
>
> ----------------------------------------------------------------
> Pierrick Bouvier (1):
>       contrib/plugins/uftrace_symbols.py: filter out some addr2line error messages
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

