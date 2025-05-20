Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D8C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 08:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHIOc-0006v9-2i; Tue, 20 May 2025 04:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHIOZ-0006uy-Nf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:32:19 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHIOX-00031k-Ou
 for qemu-devel@nongnu.org; Tue, 20 May 2025 04:32:19 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ff4faf858cso37138137b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747729935; x=1748334735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R5ko3AQWllldMLB3l0RRQ8O+cPIHYq5APXXrhWLd3tc=;
 b=BzvsN5R9yyOUNcB4hnj5+Vf1QHMMydSxlbgvelG23KbxDwocPxs02nwqCmUvij64Xl
 ipcs/mRcfKHaWKFeuPtRKSNdpZ+Xm6acJM2KB4bD/0HK/Ll8qUINpBHttjeB9+gAQftV
 tRUYItOWCyALvqwjtdhq/pnQNzr0SFcgGC43CjdeIpUk6R/VWCD1OKkyt05A424PkUHz
 aKIugJrox4SoDEwnxAEJ14373SBH5OV6VOA5ld5N10GiP0r0iFJyn2hvRFrKxJWnQchZ
 hWEMC1gWDUdwpz2t5+MbkwkUsGfDUJlJceFmMC9pWj7WTTnNkC1ueao1cniJ9z64rI2g
 NY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747729935; x=1748334735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5ko3AQWllldMLB3l0RRQ8O+cPIHYq5APXXrhWLd3tc=;
 b=ZZorzHt7gSKUpzmgWUpTM412DMToSbuihqZhI9PKKYeM28DdAJViodM0dMdJ4TRtMI
 TXtiMGKuuKtdrV0fiTTBv81liol+JP1RC0e6mLoxQ3PaczuRAcKg0Zdex4nxFSr2O7tO
 u7yv46+r8hAETAvT3cd5Hbxe2ABaKM2/tI497BYE1lXvCV/15MoktEs1xQZd9fMWU2Uz
 NZ69pSvokM+DdOo4QZUyY/FuhOk8xxFNbvgcU2P7AXmhv6rySaitDhvLRRNXqkAXHF9+
 nwZhCRzkZ9A2Z2IdKd8WHmRGzUk3JXmDuF+OTtvcHVVxnCAEkF6no1dolP7HfDXYhqba
 hw7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeK/C7YANZ6ia4vLECE80DbZsS9skDEWI1e8FksTpCjlo0l6CslT58kl1hZHXIXVwcT7xmLP32bPIK@nongnu.org
X-Gm-Message-State: AOJu0Yz7KH+1fTQYutpeh7GKnQL6mei14tYJQWdCRpw+FZPHGjQ3KR9v
 49zMMS+128HvSRGa4BTvK34K6qTeYpYAQAIy1hfSKZFG2AEIDBVUX6mSR5Z+Dw66N5UJCfQOLGE
 yZKPQR8cnbBiDPM5vLQ9SZlJp38fB495gcpwZ2gKSAw==
X-Gm-Gg: ASbGncto6/jcxAOWF+sstTRW0Pa/N6K06RHuf8rdHUlKt7WB5YoWWU4fCl2HuSQe7Ju
 uiGffTEkK7MJBdv25XqgtM3Nk1aQ/LfJ4bk5VTjwa6fo/6htzatrjOz11FCuCKuAFdAYqxcXFGY
 jz7PNinwB1AJrRQ0pr9VTeYUKpVfmBU+RSug==
X-Google-Smtp-Source: AGHT+IFYnB3flgPcXVKvsGcZr1zyOhdj1XU9UU6gOAf76qWv4p9uDLIDdgb1WvclgEm0Exz/8vIC8qO/i98yihsA4GY=
X-Received: by 2002:a05:690c:4b8f:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-70ca7b8b759mr231436357b3.26.1747729935637; Tue, 20 May 2025
 01:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250519214903.55284-1-iii@linux.ibm.com>
In-Reply-To: <20250519214903.55284-1-iii@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 May 2025 09:32:02 +0100
X-Gm-Features: AX0GCFtzB1ArJ0kaAvSRLx9e3sJFb-QIXR3AGBW4JP3inr0fr0eJUaC8Ln1i6Ec
Message-ID: <CAFEAcA-zq2SPhu9vvXSwP1FHQTbE=BfO+thy-bta0Yc8LZWUNQ@mail.gmail.com>
Subject: Re: [PATCH] tcg/perf: Placate clang-21's
 -Wdefault-const-init-field-unsafe
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
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

On Mon, 19 May 2025 at 22:49, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> clang-21 complains about the const "name" field in struct debug_entry.
> While this warning may be too aggressive, there is not too much value
> in having const there, so just drop it.

It looks like this warning is only emitted by git-trunk clang,
and there's a proposal to make it stop doing it:
https://github.com/llvm/llvm-project/pull/140578
so our other option here is "do nothing" :-)

But I agree there's not really any purpose to the 'const' here.

> Note: in addition to this fix, I had to turn off the following clang-21
> warnings to make the build work:
>
> * -Wno-parentheses-equality
> * -Wno-unused-value
> * -Wno-tautological-unsigned-enum-zero-compare
> * -Wno-tautological-compare

Interesting. I wonder if any of those are worth looking at.g

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2970
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tcg/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/perf.c b/tcg/perf.c
> index 4e8d2c1bee7..f30c5b489d1 100644
> --- a/tcg/perf.c
> +++ b/tcg/perf.c
> @@ -154,7 +154,7 @@ struct debug_entry {
>      uint64_t addr;
>      int lineno;
>      int discrim;
> -    const char name[];
> +    char name[];
>  };

With an update to the commit message to note that this warning
isn't (yet) in any released clang

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

