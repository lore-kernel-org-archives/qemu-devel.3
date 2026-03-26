Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E1810A62DD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5lO4-0006aI-Lc; Thu, 26 Mar 2026 10:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5lO2-0006a0-5x
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:08:38 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5lNw-00020C-W6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:08:37 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64937edbc9eso998888d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774534111; cv=none;
 d=google.com; s=arc-20240605;
 b=OwFXazFDNVR2Oo6YNuNU8foDnBQRUOl+YBDxH+rEu4sj5ZwtalQ63ZHLS6GTkBaaSf
 4hJWznjzURUrsxH9uaXQJP81aTg6zTrcXH9cexBV7JTFY4x9Ro+s/xCACdEkWKdbS7m2
 U3Yu1GSYDdpIF9pN9mphXQFyqaS64NmG+f0c0sTIqj9rPWhNnQxxskISYfyOpxNvNmdj
 UOjENK2CXK4Q3O4rnqXAm2tq1JvL9dApUHWOa3ZlPB7TtrMbXyrW35q+Y0oZp9p5Zhbg
 JritGBMRa5NoQQY+LDmTgoVGVBSwnPFWJY3/DzqvXbjeCAyD07lV5PwiWcG33PCzp1r2
 URTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6oY6K41kf3rD6fOOqNbbfqTCS4Lb4i4C9G2iA4MzDP8=;
 fh=fYR8bRev8Wzx7uYhwTqhbTeBJ8SUkF9YThyZrglG7qM=;
 b=gnSiWe+bzFPYfPJcbCn8BWlxay2S9iOabrVPk/UYFnCUqkzpMMztfH/RrGzQTvOd1U
 LdbMeCcL4nJ32tYVfoiWqsqr1bWsRtp18lJY4NiY/WqDBlKnouZrNEIdzUXsCi7lbRWN
 sWw27EGEq3wsmh5Bx83AkksIvOPc6JzR0iWcAhOrwbY9r5EKJHDdNcAs80KqXptKbytG
 9NIuNEFTpL1u9keZj10qsOfiO2tKbvJ9yALxRxlbuKWS2plhVheuOW7vwHHt+qmfv4eG
 ADFKWMT97BVaoyRyh+MOXXlV6gYHUrrEdd0J1nsHPDF5sZlrkanWvIWwsXYNvE2643TE
 ZjBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774534111; x=1775138911; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6oY6K41kf3rD6fOOqNbbfqTCS4Lb4i4C9G2iA4MzDP8=;
 b=FpJHKZ5den88x4Wz8/2cKrNU2EvKd0ehRJHnsR1yCx6UqkBVH2ytiJdlbq5kjDSD4o
 yA9s0NWBdrf8dOfWZco4KFhcToJDfN4iqwDYCkioQGBrrXPYLGgzEMk2dLfMsWZ4W7o9
 /XEV7q/q6zSfYckrrxywwEpMlfaAMnZyt1EeTvuKIA+UVzwDiaPPwVlIFT5wUKegJjMx
 N8TiaTKc92nK4IyU0qpqwJUNcaquWYEtKwzVCyraDq10+eevZnWi+OeAh4/9qov2OjQU
 LMdSr0VgRN91X3vf4+jA4iznGku9/mteUSE6JKrmKx/9wB3XF/deWOdSjkMqux1nk0Hf
 vbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774534111; x=1775138911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oY6K41kf3rD6fOOqNbbfqTCS4Lb4i4C9G2iA4MzDP8=;
 b=WnW39dF2LNAb1MDg0XaQgUOupKh7C3iyFMf36BfyfpQIpwrWfZ46iOHsJmXE94Q4aV
 GIc0hMOYC7DO1v5TPyVAEZbQtZa2wVweTgzMzi2luYwfKcOaElavOs7koW8Bt33Ye2bF
 Pw+KTaws8zUig0Omv40klU/weviKrJ2ielMFySSosHAg0mr+5z1Xflt+d/sd2QdjAT3L
 k0i2aReYWTqA+7+Jbda8sqG0iLkDFca5HPLUpi324hq8qhViaEP1q6QHP2wsckcdwg94
 FbEeKHFpQqvSgRBfCIu83G0oCJGREBkdAoLl3DGqBYINitCRabbWMQHnSgVZKn8tkzpS
 vpJw==
X-Gm-Message-State: AOJu0YynZRJ3tZcidObDDSNhfi3Q6pnCo32mnN52WqpPDVQOU5B8wqov
 LmbT4+qaFzLCv3n95sY8txZuowlcGraZrUD0QM096Qq7xS8JO53ajgSHmXrXNQEOKnMD/q8k4eV
 SjAxrtFjAVFlow0copBoyy+byW3I9rIBLC/IfpeWQ/g==
X-Gm-Gg: ATEYQzzHWwN2tYX8OuIUnX5+SZWqcIk5936HwP8OyDN3j1vCgjHN48/hVN5YklV+5lS
 mw2JWBfLaLH8iaFrBBtyvF9ORy/7+EcPdg2/BOqxnjMaaeGYKcO0Y05dFt9YeT94lvePB5maX2W
 8zGqOz8pI8nJbsMVOmmQ1qVKINOF223WQRyj052hSGF7S3eqMHeEPaqC9+lxCUeVeMpeUFq1tLj
 mGQdRD4fGTF18ixRZ9qoD/WlwoFSU/cB2lROZ7Vv33Qu8137mGrnm66tURCdiP/v+OWPBhAAXSM
 wp6OHDSU/wGPXnzjDdlJSdwer9I30jJeuVoeOZppAQAV8O4FSzRxlhwsO2j5UYtlPPA=
X-Received: by 2002:a05:690e:2451:b0:64d:29a4:c933 with SMTP id
 956f58d0204a3-64ee614916bmr5852194d50.56.1774534111249; Thu, 26 Mar 2026
 07:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260326135109.67394-1-mohamed@unpredictable.fr>
In-Reply-To: <20260326135109.67394-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 14:08:20 +0000
X-Gm-Features: AQROBzATtJ11nNg-NqL8fC3sblAiB88v_SdvbEwReTZUkJe23V3KQMpIF-HkPCU
Message-ID: <CAFEAcA9c48xRmOXc7rVnSU4G0v=snP1_LUMZHKkDMYzVd_GfYw@mail.gmail.com>
Subject: Re: [PATCH] docs: add WHPX section with initial info
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 26 Mar 2026 at 13:52, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  MAINTAINERS           |  1 +
>  docs/system/index.rst |  1 +
>  docs/system/whpx.rst  | 83 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 docs/system/whpx.rst

> diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
> new file mode 100644
> index 0000000000..a3a7ecd38f
> --- /dev/null
> +++ b/docs/system/whpx.rst
> @@ -0,0 +1,83 @@
> +Windows Hypervisor Platform
> +===========================
> +
> +Common
> +------
> +
> +Windows Hypervisor Platform is available for installation through
> +Windows Features (`optionalfeatures.exe`).
> +
> +VM state save/restore is not implemented.

Thanks for writing up this documentation. A suggestion
for the structure:

I think it would be helpful if we started the documentation
with some introductory text:

 * what is Windows Hypervisor Platform?
 * why might you want to use it?
 * how do you tell QEMU to use it?

before we dive into the details of known issues with our
current support.

thanks
-- PMM

