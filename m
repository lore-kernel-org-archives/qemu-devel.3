Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37922606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wNA93Fil
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzEm-0004Lc-5j; Fri, 27 Nov 2026 11:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzEg-0004JG-Rv
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:55:46 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWzEb-0006ZF-VH
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:55:46 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67be9601f31so7129048d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795798535; cv=none;
 d=google.com; s=arc-20260327;
 b=KHHxrfZrPSMShtWSBxZ5xhmhAVujNzbiro4NstulxP2VUaIZfr78N3eyhcEq0UKnFA
 Blbod7K3TMojwrKWd75mptr633gceSq9D5vFALZh/2wDUF5iDET4yuyXT/V9JABd6viC
 hnCLju5nvXKkv3Rel8qZzshawvaeSK4czsZ6anTpSurBYdlaxYQu5AiY3/o3p/yjK4zJ
 kXNa4ciu6gaGFknBDvAgwGig+HPqhQALcLm/ehznku+qun9VvZe1WzLTf3VOrVAnCvyH
 iG2ybAYKBux6k0nyCAzBzjgyCaRgF8ejprRBzxchJ4f6fYhAa4igXL0n+IJtA5odXaKb
 7oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2b+WA3m5mvi9l8IPTEQke84rbNOd9dJMOetYnkSU9c8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=YJB14CiIE5Riza+pPjBeIVf0+ovQVIe/xI6DsM0kjj2InDJfI2vXbvvxgvv/1PMU4S
 7L3O9cShna97vQodW78nzyVOpaZLdMT/p5i6wI+dgg49K5Da7c3TPr7r8dbsy7RsNuZ3
 KMBIEqmkk2ixqvdxETJsZbb6PKCRYHkzuTt8PWgjuv52GX2lPTTMl9zzNxwxS/hJ2ng3
 J9zwGk+0Ja6QgHG7Hk4GHS4iBQeVp8Xz2IinT2n3w40iiWB7raDrljMzMtrXD31jL+lx
 k+0ua22mNrRcC6I5I1yHAV781uxTFiMRx0FCtnCQeP2O26gTHbEhd7bQ3UajHWqYQ8mW
 pfOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795798535; x=1796403335; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2b+WA3m5mvi9l8IPTEQke84rbNOd9dJMOetYnkSU9c8=;
 b=wNA93FilKk0KJxMLGdXpoufXrrfGcxnDPBKezZCMFjwgeAFWwAbWxAoxanOn2EF12E
 z7ssOZf5cFT7w5+V0OcbaHzx5prXJUVVqEC6kI5yOGwJMzh5uhA917HSglN10w6mTYSg
 cd2OR0as/PxKT5p4mgVdwNxVE8HGOFOIrSLPeuy7luX2XXdGuFsvFd+7L08GtnjHYeDn
 xlEGM8JlTNUMuBJSolTqdcfNI5z9w5yi7sFMo2iyMt1G9u+YI+p4pp2tz0op2kseQLgf
 8+GmpgqeLsrEnZ8CVTm9nF6TXuil8hPIqCLxsWQ5qW2MYDf5JmQXX4EuEJiG4AVQ7BLj
 8cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798535; x=1796403335;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2b+WA3m5mvi9l8IPTEQke84rbNOd9dJMOetYnkSU9c8=;
 b=EX1ryLOaZjFwFwD9xS7Q9HGcgwn7DJFJn2iJv1bDZbM5O21edoNEHfAdeOxQ8h4Kns
 3mbJt3+djzsIvHA7RVPeaAAvNSEQxDYNjcWuSTMuOPRylC0yW3TrpE/Id0XPv7btiZpO
 UIsxNzgGNw7CihSN6rs8pgZ4j7gGNVs7GmMWq95rHbX3WhC63MwBvr0C2LxQ+XcaRuUx
 PdmAM1iH7D/NecWLuOVqPq/mlE/5rWhsxOMM02DJwmxnCbstOMummjQ1+feKZxKlWkvz
 IAUrFCJ1TmUrVhbHVPOg4zVCtcV1aXUE6+dPUNuItkwy40S/VuzStwOY+T3/Z749aszC
 vk/A==
X-Gm-Message-State: APuU4Z+4u+1rXh39VijMy1zcmd4hFyc/8AJCLBbs/b0ziEtY62slIG2y
 3KuUreGGegSD+7ptngcdMnhPYaYCC3njKGMMsU15kR93vIzVQmGnv9pzUKs8Sl0evHvI9BASEMi
 DMfOZqu3Aca8RKDmaPjp7GMdRcskLmUbxW20NfXTq5A==
X-Gm-Gg: AZFdTZc3U/qekWVe6OzTNpzKw+6L8YkEkRYRphzVeQ+A3hyNQELfshgEdxQiElf6opN
 L2YFM18uUBWJhypqZQdxTT/USVVNUGKHGNYg+u2NDxKRjZSjj4HndX2k7UjjQ+6FRsaW7bOBvlq
 vaCuy9695+4deuhb17KliK5OYxFdS92nBPcoRzSB3o1qQO5GJ7JIHKpHjBrd0UUyjKzL0LT/7lP
 itLK0jLNT1916M5JKqgiXeYt/+jcdMGnDdqC0SG9gT0Bx5uLwV/fo48BvtDePa/fDMbeW7rf0DA
 6+Owg6PEyq/BX9Eygm/PBGT3zaadUu8LZL0ln7z7Zk1LEpV5kWT2rqiVgomBhlI047AgeJeHStg
 ZfM2nr+nI2RYpZQInOwIWjXGQ5u1tn1zscBDR+elApYHhATBOlg99GiomUNjXvXX03aspDDyT52
 IEHfqCs3+6hSH0FWfQXR9L8tFSPtWkfLyACCr0lgswKw==
X-Received: by 2002:a05:690e:43d3:b0:672:9f72:7c0b with SMTP id
 956f58d0204a3-67df45165a6mr5261749d50.109.1795798535355; Fri, 27 Nov 2026
 08:55:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-8-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:55:23 +0000
X-Gm-Features: Aa3M54otA0wjTcv396cKdSb0A-anRAScMb5hkL-TuqHLKHgAx29yS4hOUhszqHY
Message-ID: <CAFEAcA8CezC2fr3c=PMpG+h_5+wNTh7rAprgTzCK42ZFoi7m6Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] target/arm: Use DISAS_TOO_MANY for simple TB breaks
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index e66ccdff6f..0f6331a695 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2420,8 +2420,7 @@ static bool trans_ISB(DisasContext *s, arg_ISB *a)
>       * self-modifying code correctly and also to take
>       * any pending interrupts immediately.
>       */
> -    reset_btype(s);
> -    gen_goto_tb(s, 0, 4);
> +    s->base.is_jmp = DISAS_TOO_MANY;
>      return true;
>  }
>
> @@ -2435,7 +2434,7 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
>       * MB and end the TB instead.
>       */
>      tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -    gen_goto_tb(s, 0, 4);
> +    s->base.is_jmp = DISAS_TOO_MANY;
>      return true;
>  }

We already use DISAS_TOO_MANY for some other kinds of "just break
the TB" (e.g. various trans_MSR_* insns) so this should be fine.

I notice that the end-of-tb code will do a gen_goto_tb(s, 1, 4)
where here we have (s, 0, 4) but I assume there's no requirement
to not use TB slot index 1 unless you're using slot index 0, or
we'd have seen it causing problems on the existing uses.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

