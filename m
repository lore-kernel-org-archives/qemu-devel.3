Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E7BC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIuD-0007lR-8b; Sat, 02 Aug 2025 16:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIqY-0003H1-Ao
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:28:54 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIqW-00048C-FU
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:28:49 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71b737ec362so17977277b3.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166524; x=1754771324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C9KUIqDCvxI1swWnYg3Mq4qJcUma/9dg3POue+TMlZg=;
 b=a9VK4NvrY2G76fbwSWlsHjmnL/ZUpRLxf+0FYP3m21ZtmJrsOt+Hr7+vEr9oHDD6wk
 Fo/EYHNGWXLEaQIooz8iPxcjhsUZSvsk4/Pwpcq/0UsQ7IqZ7gh452mzfqi/kK8hKKIV
 heBwBGa1bwicwQ8nj2TFvSLWDG9igoc+X/G9w2dCmeCLR36VeoZgbcPUzTJlYmE4WG7S
 ve5nAU/ewaD7ZTBsS8tz9bQ83QZAPURMHdYX6fvFa4fIgjVqOitBYZqXV8rkuQ2xok9o
 PKND5VGerkK+6s8CHcUSvmfvt7/U+KHnxAjqWKA/PpVK8PlUI9Vc4IzkkbK7YbqDp5xw
 G/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166524; x=1754771324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9KUIqDCvxI1swWnYg3Mq4qJcUma/9dg3POue+TMlZg=;
 b=WPzaLI25/zCOTvuXCBjxgV0JIU3CHNzVrvGl37ecBrrX4qEva0KCvhlHYMVHRMjgjg
 Z+wHXdcmZ7assFBLTWhq8kwc1D3fCSO0y3v5638CGHcoLnqpuk8lgckmiPhXNIiZFAFt
 ivZehLN3700tyGmzOFudx2dYha+uAtKyu2rhQJR+AqwEcDY1dpdoEiexaiboIwuPGWzI
 s3CjUjbMIUNMVtK2Amfsci1nNckTkZDFdqpKsXFo3byxxixg7mfPCXwBG8/a5b4MthCf
 ZB1s/399QpMjWmxqJaC/4gYlgc6s/PscDEKj97mH8YJK/4LlbqMIvgiYTZQdAdfG/X4L
 pLWQ==
X-Gm-Message-State: AOJu0Yzk5MRrixgEW7Juf9GYJ1nKlyaztKgPX87lvNRSfbjnaVLBsZH8
 OX0K2gZ/ENtmaZ29OJ1FgzpUPqMqdiGAFJPgwEm77gTHdrhdf8G4kF/kal0veFNqlvGsUz2kSQ+
 73TR6jxfqBD7zG58c4UntoGceFtl75xKQniiAbUgAHA==
X-Gm-Gg: ASbGnct7NGToZREgJNdp48NE4kdvaipnF4n2c13Shx51PeN6TnPFkdaR35RG0mTiNeN
 Ql4M8xe9VjOlb6vNwnD+2znG29FwhRN3sy+8RLhGOaRJmACf+nxMUZ4CPIxbOhnpmzfa3+zMtm0
 duBXk6clvxZ14M5gF/fj9Vtot4L6k2ZA1hsefbh+bOhPuA1nw5ISb2TYfhr2VaZfN3XyWUf+8ku
 Ve6S/ZQ
X-Google-Smtp-Source: AGHT+IGTehLj8DYUBWVyJihIxPHO/XCag12T8hlcWmTmUiZlhzV3Fka4jJmc8IZZjs/Pr/IpMDyyXSgDSUFNJOAu2IA=
X-Received: by 2002:a05:690c:f94:b0:71a:323a:b297 with SMTP id
 00721157ae682-71b7ef23fc0mr54566627b3.7.1754166524473; Sat, 02 Aug 2025
 13:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-66-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-66-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:28:32 +0100
X-Gm-Features: Ac12FXx6Jv5mRzDujsdxp5MFd22zoPFoZIVLGokp_bA61N-ndjmkbyMgYLr49Vo
Message-ID: <CAFEAcA9QQn6X83HVWh-8NZOisgqDZgQQ866X3m6OhrCE-BVzog@mail.gmail.com>
Subject: Re: [PATCH 65/89] linux-user: Move elf parameters to
 sparc/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 30 Jul 2025 at 01:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/sparc/target_elf.h | 11 +++++++++++
>  linux-user/elfload.c          | 15 ---------------
>  2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
> index 7e46748d26..8bd6e3e427 100644
> --- a/linux-user/sparc/target_elf.h
> +++ b/linux-user/sparc/target_elf.h
> @@ -8,4 +8,15 @@
>  #ifndef SPARC_TARGET_ELF_H
>  #define SPARC_TARGET_ELF_H
>
> +#ifndef TARGET_SPARC64
> +# define ELF_CLASS              ELFCLASS32
> +# define ELF_ARCH               EM_SPARC
> +#elif defined(TARGET_ABI32)
> +# define ELF_CLASS              ELFCLASS32
> +# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
> +#else
> +# define ELF_CLASS              ELFCLASS64
> +# define ELF_ARCH               EM_SPARCV9
> +#endif

Why does sparc share 64 and 32 bit in one header file with an ifdef
when the other archs like mips and arm have separate headers,
by the way ?

-- PMM

