Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E192CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp6d-0006G5-2N; Mon, 20 Oct 2025 08:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAp6a-0006CL-A4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:35:16 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAp6R-0000R6-Vb
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:35:15 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63e0c6f0adfso4393193d50.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760963705; x=1761568505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQAoilAjBcDCKGTGqZZ98OivUN223MWls7lmhQrOdTU=;
 b=OsFzUwBIw5od/CrES7nO85yi1w/BlKb3FqFUAKSNBVyv5/8leEDnsY05APlHIKK9zj
 5Zlq1DmZ3j2ONelB1PvvK7g1oQuhITfYKOBlQcbZhTjFC23O9eHt4Mr3tRbAgg20nhqR
 DCP7tIQbCnOFWxDZ1Da4Sm/fZqD+bZtkYhE2j5hHa0CFrRFW4f7cjbXtB0AkZV3pfbE6
 gvJpeVZasnV241Iwz79koIRgEiowHiJSDv8eRtqGWbhBeLGDbgbtYu1x4bgKA4AJ2wwi
 jE+zl1Xbpfd4EBFG0W1ZDmFuHXDxxrO7EVUkWnjmdCbacMgjdnjiCGOwiK4BmSC4nh2g
 V3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760963705; x=1761568505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQAoilAjBcDCKGTGqZZ98OivUN223MWls7lmhQrOdTU=;
 b=Il17jC3lDWm0s9syd+AMF9oes9H9LRcjd2AWfJIhVwOflY1IsaDRbSHmwmhU5Y0NqX
 uT6vhsOuyPUIF9oAKr8EJnAeWoRjMp2xXKPxnjGIc4lDJ0HKOH9ku6mbkjfa+dmh5eh3
 PDdZTGS+nBTF2Cg+SfWDWldFZIM5amcgBKL6mYbajCKE7ueT4AtE99DJbMzTdBZbNVbL
 6VkeoX9vvA2qv2QZiKpj+AkiMpCasOpS58nT+6ZZQy9O2pHnEuPtjlT4ROjFpJBB+g3N
 mpYyBJoPWgoSkQ3Gk9BXGACombAOKTugEFoP//rcnJ2CoxOZSYCLpyw+/qipNff2wopy
 RS3g==
X-Gm-Message-State: AOJu0YxNM3IkLnjJ/s2tkQKlETru8Uz+hM+KeXTsma+kp1uLnn4zTZ0N
 dcfglR5k+FWhADa7qgOGu46yXSSFDWcuX/P5bDXr1ipXjcMhmHv8s7W2cm0619aXnQbT42Te2Jl
 jQqnsjrnfeG0a/mkHI1Jl3RrBBgfxAvX+mOn8IC/Vzicui5hLWgrL
X-Gm-Gg: ASbGncu49heekQBB5qaO9oZ5bwOmZGp+ifq7zD9mM4NebrNU9/TCBTYOUCgj22DlLJx
 N7Dk20HVWbUqF+hhcUrNxpdwncsO1mngEOI9A9YyU3+t82SG6/BpvQodl4lbSETU3C1OOnq+2pu
 u7qQU0/zPeH8rea9ZO0RLZgjBu607sEb3u4mNVi0aClWYsUDrSBNPU+vFJ8l3vnHY3jzsR8BgiY
 UUhpyLZlpYKmBEElm6dbHVQUW2l7XAw9rm62i7D7SqzojfSiRWrQQ41A8uUQNq86+JWG0OAbLFl
 vLFKIMs=
X-Google-Smtp-Source: AGHT+IEUUUeUEHdTVFB6lvU+m/SZqyrx6pCsxthNvWu6aYke9ysuFNJFd2SX9Wr17H9IMIoVsimOtneycEDEQJWYrUc=
X-Received: by 2002:a05:690e:d56:b0:63b:47b3:4fef with SMTP id
 956f58d0204a3-63e160e9866mr10038577d50.14.1760963705406; Mon, 20 Oct 2025
 05:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-14-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:34:54 +0100
X-Gm-Features: AS18NWDYhpjchLWD1YLekr9vNDWMhc2yupizqFSTYU8-uVkWv7cRa0Xt3ycyGQs
Message-ID: <CAFEAcA8bB5jbc1bEd2zUJUDj8=q0jfWvfcUwdUPW0Upbr3u8_w@mail.gmail.com>
Subject: Re: [PATCH v2 13/37] target/arm/kvm: Assert no 128-bit sysregs in
 kvm_arm_init_cpreg_list
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

On Tue, 14 Oct 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> KVM has not yet enabled 128-bit system registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4f769d69b3..3e7738592f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -804,6 +804,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>          arraylen++;
>      }
>
> +    assert(cpu->cpreg128_array_len == 0);
> +
>      cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
>      cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
>      cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

