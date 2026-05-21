Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE20CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6Ty-0002Jj-DE; Thu, 21 May 2026 12:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Tx-0002JO-5G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:42:49 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Tv-0003AX-I2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:42:48 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6587cee8b57so7428314d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779381766; cv=none;
 d=google.com; s=arc-20240605;
 b=eRfG5ReWj+kCrb7zcPZ0pZRfCIWucqzV7p0h7HVPbQJCbN7krtdzfUq290LyTE0r+r
 Z7Z0CjzQT9O6vTioTSmXHdPqCsMSh4miPn4w7MtK1LyvoOvVeZetkwLvvXji0C9q0UjD
 kkIhl7nVIvIlnYvnQZ1aIYxgJ5gGkEkDIeAEmQNr47Txjb7wC6z06QtMqb7RlLwLIIU8
 WyoR8Tjr6cWbS33O2VWR3/6uIyHFm2mSptOAH2CVsXReMJKbyQOo0yD3FcjVdKrsilIT
 /QO/DZ5GzAPWXPPJWKMybRvenKgpAEDdJjDwMi9ZHw8MJblVeTGEq6LlIdnbALKgPHhj
 2gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ERQHoPK48RtEl3HMvfGHVAAti7bwRuPobKLgXU+qz28=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Pxo3WbAUfmrnMDuq8XJYDmL3nwkZcM2pNErUXVrVjUv4sBGqHAOs7gem8tl9tTb3LA
 cqu1TjrRHHr01jZt5FzrYDHv8fr28TeD3LTau5AueVZYGE+ZAzeP9vbizdm0zu4Pag5r
 avw8nBYweopt8cRWWuzaBdyfvgxGEz1NV6BwK/0TzA8OnNO7LItYF6pMED6RjwQT/kV7
 iy4zqsK9eGcN7T+PqMbLewl+2KJyaZ53KW9mciBtB9szgPoasTMm441T232H0DawH8gE
 R37NL4ahD4I+xMtx35taananq70gYyMJkq0UGyOF+nzlZlUIf0+5G6H0nAFQIin/PmnT
 ioWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779381766; x=1779986566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ERQHoPK48RtEl3HMvfGHVAAti7bwRuPobKLgXU+qz28=;
 b=Wkyhmb9FGbWiiQrulnjH29QnGlB4r7L52+ht48D3pdDqbpk7C8Fh2yHqOAyZHWhYYF
 MIV3N5H0DBva3mQsvFFvdRdbdVXEF3UfA5lSmi6EXeVXHtIHGdDMAfY8YGLKEdHTprAw
 2MjNB5T0iRWo62a/3hGCd08UWdiOe7jHgp+2NfVoNJGKvUpr3O14fGoPcigC6M7FTptv
 PlJl0xaw3FpwuRi0w7t+YIgkjdjoxE/zFP1kGV5srUCXVN4aXOMTuF/Kr8AXBYbdebHK
 4QW39TybwQscjoUsC8UYzlASnl4pdsT6w2Fvc96KLnhWLk6BYRiqBU16hd4RzdMkUHXW
 iZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779381766; x=1779986566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERQHoPK48RtEl3HMvfGHVAAti7bwRuPobKLgXU+qz28=;
 b=gYVCqkGIhdDzRk9EGxvZTFzY88/K4KiMfV3/NPbai50pFJQY6MtHVql9JuedLCi5Cf
 DoZK723LVkiyt0NdqOPPLGJNO2vDyn7l6H5kP3qM7Wr98QPa6Q3cJCaKxIDhJ9RnGc9A
 vUFOSUV+jDM5yYgrSpOeNIV3Ne96q1bu3GVJTFcgcUD+i0+XRXHotEjoLyJYNr03M02t
 0qqsYPUhrJsAABWtFOn9+0gVZRXTir0061YcGwYzcDmcjG8gAG98BAlAM3ZEXKQWWjSH
 Fy2yd2I7vd8pTscN7a0nCFZMfobxrPn9w4W4v3pJSOxJ5cjMZO3LLqIN+VPhtCjdMJma
 yXrQ==
X-Gm-Message-State: AOJu0YzqShovJluYKqfyHfhGT2cjdPU9yrnA7sON+VCRsai5GHRWIX86
 XoBmEIazWVeDC7idWTCiPFAK9LC/2nJS45cq1bOPBjBYWN/JWmJEvaopExRMdw1N/y4AHnPjkXD
 ApcY2KcnfW45AQGjS+Og+gxmOlGKsQlpgeGqg+qz7uA==
X-Gm-Gg: Acq92OET2p7NcCwaZnZE4YNHy+XYhKPRvSTViVNVBu8x6EjEGlc1R2A12yWsLPyf4hm
 hBuS266fuVVha+U5g8IZEaUd5SkhAJxqK0Dvn4SvxOtDl6dNxxJqhTEv0CHOAi3D5FWnukJ/e2/
 denn7QHqn8Jyz3EhK1T4yAIcP1fiwZxx0Lw/EWl3nt74PCdCYZarWRdyeC/FnMiUv33M/UHHG/6
 YqH+sM0ZYc4xNrf5U3+KeeNRFB8SlVkrQYtlnLlYrx/Pd/3gZHDrLAQxikIFbpBtC6oRMgnqQ03
 S1KJX9wRgKvTU1QcMx0e4vBOrLmx3YH6FuJuYgjPgNYZq2SK3WIpaDr1+yETsM2cCME=
X-Received: by 2002:a53:c044:0:20b0:65e:44a3:ac3 with SMTP id
 956f58d0204a3-65eae440399mr2459751d50.50.1779381766228; Thu, 21 May 2026
 09:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-64-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 17:42:35 +0100
X-Gm-Features: AVHnY4JBq3C2LiDBD92Bk71FZ76hfB2ehhtSG6ohY_YD7UAiyt_GMFFg5FZ0D-E
Message-ID: <CAFEAcA90jtHDCXGuTUUu7ErLcH=wMCPmqOEi3X-n2WriLoWEkw@mail.gmail.com>
Subject: Re: [PATCH v6 63/64] linux-user/aarch64: Implement hwcap bits for fp8
 features
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Wed, 20 May 2026 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
> index 3af5a37776..0934524be2 100644
> --- a/linux-user/aarch64/elfload.c
> +++ b/linux-user/aarch64/elfload.c
> @@ -218,6 +218,20 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
>      GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
>      GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
>      GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
> +    GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
> +    GET_FEATURE_ID(aa64_lut, ARM_HWCAP2_A64_LUT);
> +    GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
> +    GET_FEATURE_ID(aa64_f8cvt, ARM_HWCAP2_A64_F8CVT |
> +                               ARM_HWCAP2_A64_F8E4M3 |
> +                               ARM_HWCAP2_A64_F8E5M2);
> +    GET_FEATURE_ID(aa64_f8fma, ARM_HWCAP2_A64_F8FMA);
> +    GET_FEATURE_ID(aa64_f8dp4, ARM_HWCAP2_A64_F8DP4);
> +    GET_FEATURE_ID(aa64_f8dp2, ARM_HWCAP2_A64_F8DP2);
> +    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);
> +    GET_FEATURE_ID(aa64_sme2p1_lutv2, ARM_HWCAP2_A64_SME_LUTV2);

Accidental duplicated line?

> +    GET_FEATURE_ID(aa64_ssve_f8fma, ARM_HWCAP2_A64_SME_SF8FMA);
> +    GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
> +    GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
>
>      return hwcaps;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

