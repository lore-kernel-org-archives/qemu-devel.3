Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F42CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9k9P-0001Ay-J0; Fri, 17 Oct 2025 09:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k9L-0001AO-Gd
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:05:39 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k95-0003j6-Gz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:05:35 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63bcfcb800aso2107401d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706319; x=1761311119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KuBZKmjoBlsw1oUgNA9R0/DESgCD3LzDHTcsDPY6GZA=;
 b=tXLFa4E1rtHf2d6IQG6qE6Ts+k7J9KPM3TlExZaHn1EmWZz8Q9u+6Q5ozBOUuT/vy5
 iVWcXCxCKPUFd4CD8K546hvZY64Uc7zaG+tJBx6ZEjoJDx2S33rVm/A088RRe4L0mSrN
 wtdX2jeq8+JJDNlLLhrjT4pApM3x/KP61vzDIT37/nW0aoHyKcRIlH6zY06X9ZAtbpb5
 wXPPVuRA2BmVnfsFmo8tvvMWhap6mCA4U2xBSUOeWNMCchcjA/QXPBKnIQ0A6UWZeUgS
 B2XwW/7HI4zPWPIap6TRR6XLX3IWNCkUWRPhBqN+G2pMpgiX2XriCPDhaOh7H0KrWZo9
 xlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706319; x=1761311119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KuBZKmjoBlsw1oUgNA9R0/DESgCD3LzDHTcsDPY6GZA=;
 b=Z4BeR5JIyzWzjufj924EPhb0e39YEJgQf+FMq4072e+z6fOobyqAmYBJu72z5O8VUS
 F6ae0jKPO/POjLZY0B2Hz6U+uxEq3ChSHngwz/CgYu4OYoh0gKHTz47XrPraRjLbopu1
 rOGRiAs6cLVXqomTOHHX/AbucofJRz22gV4iOM5cWTMFqcCNL1354Dt0iabXxa+X0p3G
 BTbNZpVnXiooWvfIzn3CzrDEo6eXXcuHNidihBv9h5dFLIPkEA4GZevXg0LytiqXaXHs
 LCwbEn/zoGMuQmo9sn4UgDwfga6o+fHVJee52N/V+dxT27mLru+NisFVbw9DYUvpB0W+
 MNpw==
X-Gm-Message-State: AOJu0YzF5y0Ol8eSZ2BjukyJ2jFOHBsQDrIcVMHfAYfIsKgQFB1uc548
 6u9aKtZIByzK3JYRhFCngFDv+QVVK5olsJ2d/4o+gOT6RDnfYKtdI0uXtgjz3R/U+1+/UAXxBsC
 Ra1KiLZWGwwIBaMaDbRnQRNuV8BE2Nx8YoZvnL9hafQ==
X-Gm-Gg: ASbGnctZ16Vk0SQiEf2fOLLdlJoNSADS2ScYN/d0hQKkPsGINVTg1MFL37wL82PK3iu
 o8H3+bWg+qQO5+ZKOfunrbXinDDnFhGdn3aEiRs1MfFQLrWrQbJzul1CSS4pWe7O/brTDXGxhXD
 CM/XDiI3FZG+P2VC006lhdX4QMnZ2X3iMzDOUubNZkfTFeEbqcwt+cx5P1BGcXN0MkpxcZVO06I
 lMiGqFws37EBJtWh/mRI6Y3R/95YcwGnJOWMc+6uYhVUUA2KIxlE1lP7BhJuIqjLDhx6YQz
X-Google-Smtp-Source: AGHT+IH19t8SFRumLoN+BuL4EHLU42mChpBHIMBiuO/r2HdZ2RgjgtDfljTnDFNkQwzegu2NMcEtFJmgWNy0PZF+Ja4=
X-Received: by 2002:a05:690e:140d:b0:63e:2471:96ff with SMTP id
 956f58d0204a3-63e247198fbmr133819d50.60.1760706318417; Fri, 17 Oct 2025
 06:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-6-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:05:07 +0100
X-Gm-Features: AS18NWDYmmqOTLdlzswdY2NG5BQ0Mvgmh8sfOdNV1i334C8SwkCr9Wqbzj5iEfM
Message-ID: <CAFEAcA9KZcuMenU4yKeGBc7EtWu07-ELHO-SwG+dYKGN-B3zUg@mail.gmail.com>
Subject: Re: [PATCH v2 05/37] target/arm: Split add_cpreg_to_hashtable_aa64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 at 21:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename the existing add_cpreg_to_hashtable_aa64 as *_1.
> Introduce a new add_cpreg_to_hashtable_aa64 that handles
> 128-bit and 64-bit views of an AArch64 system register.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 61 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3b06704963..c240edf182 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7668,11 +7668,9 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
>      }
>  }
>
> -static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
> +static void add_cpreg_to_hashtable_aa64_1(ARMCPU *cpu, ARMCPRegInfo *r,
> +                                          uint32_t key)

I prefer "do_foo()" over "foo_1()" for naming this kind of "internal
part of some other function", and we have a lot more do_foo than
foo_1 in target/arm.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

