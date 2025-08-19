Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7DACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoN6a-0007pp-ON; Tue, 19 Aug 2025 10:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN60-0006dE-9t
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:13:56 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN5w-0003JK-4d
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:13:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb78c66dcso754276666b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755612825; x=1756217625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e/4IN9gxhfvk3QqBPO6AVxfK6wAsJB9l5t+npxnvz4M=;
 b=Wx3G9Zvq36xbaU2wEUhpoNjsS5Hx2cO2T8wWXD/4vDuBb7Cz/GucDt3USLvWd67K0K
 lbWyKo8DAKnUeGL/+6MmoPOq4mKW/yqLMQCoDcG7JFELIfBsY6K/K0m2aR5cy1vbFXOW
 YryndV5ZkZEJ7Py6gAngt5pShsyrJMER0R10QESsrkz9kXU9r7MPPiRqNnl66Tmx5njW
 CxU90s105P6sukG7p6e9L9Zd3lSs0uHE3nkzOAnV/igOgK0xnpor4UkcMapl0SPkFgHD
 9iK7r74pxty3xSh4vudAf28JDRx8UhB1Uqq4PQwgsddzVhpdJJIoEDXfVSB2ZmKgZ0eI
 5ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755612825; x=1756217625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/4IN9gxhfvk3QqBPO6AVxfK6wAsJB9l5t+npxnvz4M=;
 b=aivI5NIc/+2kObesSUl07sGqqYAeevusS45BVPIsNHObxNCS6SqlRtsgevwzx5wofT
 X1mZfmbCJ888x+SmPPN4Ryi0Scro1awcFA1PzqYFjMnZT5VuR5ZKLFpueYy+UbksOYnt
 Qxh1nSG3hqABnuZU9vNhv3I6W7bk5frK7KVVWLtM8ViLiF/7bkw4NomgqO3M4LnTCsjx
 a2F1Y8B3YZFXqJg76uwuutRatDYot1s0piiXRiL/T7uWJuB1QZ5CGYAgj8fHu6YdMnFS
 Y2UYKjugZgQbHp4fODn/C7si2Qt/JtFmrBDMreUR3HJUtiN2DiH7N5EaQjh70bFGPU5L
 6aMQ==
X-Gm-Message-State: AOJu0Yyb7Cc9GbdNwtAqt9/QGC50a95NBVOzZnktRyqRQy2//eOuf4xg
 Tx5N46pBAr45wC2v20Fx+YJe3UyTysEoTY9eFhs4Yu6GoDbnQOuK8XGp7pdKKS/Ju5OhyiNVmfs
 xRqnyTVJV+jR9rnuo4AFqljWVes+eSj6f+EVB0fkraQ==
X-Gm-Gg: ASbGncus0L4hAdWjZqtmzTY6EkcVTHTdIDPG2cbYMPYiO6hNKUQ6nF4FZhdcwTuV/bc
 me8ZDuR60d5xKE0z+4LalnEaZibuEe+AAlw3JougLrqqTggDFV1KKir345HZMTuYI6HZkpEeEAg
 u30yIObQ8tpYj70DfBdqm68uK6N/6DtD3LccLNrrt5ZofQbglp9ZQGE3MuUqfuWl8ceegNp69Uq
 6NJ8kE7
X-Google-Smtp-Source: AGHT+IE8zcc4QKt/k6Wdl2Fn/x1MqvyIZnOKQakvH8DDaTgCz3HYG8SvDzd+PI5Tmsu42oNYo2qZ1vMuUooVTuJyNRg=
X-Received: by 2002:a17:907:7291:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-afddd0d2e7amr286089966b.43.1755612825527; Tue, 19 Aug 2025
 07:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-3-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:13:32 +0100
X-Gm-Features: Ac12FXw6p-P0MdG1q6FnPw_wuQMczeXkW1aTWFlczrxZNLnXMPDgA9M0ih-z24c
Message-ID: <CAFEAcA9jEbtfkA0mvBQupn9YAkHz_YRZ5BgoD9=fzmD8DV6MNg@mail.gmail.com>
Subject: Re: [PATCH 2/7] qemu/atomic: Add atomic16 primitives for xchg,
 fetch_and, fetch_or
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 15 Aug 2025 at 13:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  host/include/aarch64/host/atomic128-cas.h.inc | 57 +++++++++++
>  host/include/generic/host/atomic128-cas.h.inc | 96 +++++++++++++++++++
>  2 files changed, 153 insertions(+)
>
> diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
> index 991da4ef54..aec27df182 100644
> --- a/host/include/aarch64/host/atomic128-cas.h.inc
> +++ b/host/include/aarch64/host/atomic128-cas.h.inc
> @@ -38,6 +38,63 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
>      return int128_make128(oldl, oldh);
>  }
>
> +static inline Int128 atomic16_xchg(Int128 *ptr, Int128 new)
> +{
> +    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
> +    uint64_t oldl, oldh;
> +    uint32_t tmp;
> +
> +    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"

This looks like it won't do the right thing on a big-endian
host, but nor will the existing atomic16_cmpxchg(), so
I assume we don't care about that particular unicorn.

> +        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
> +        "cbnz %w[tmp], 0b"
> +        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
> +          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
> +        : [newl] "r"(newl), [newh] "r"(newh)
> +        : "memory");
> +    return int128_make128(oldl, oldh);
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

