Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79015C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz6k-0000XW-SJ; Tue, 28 May 2024 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz6j-0000Ws-Dq
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:51:25 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz6h-0006Iq-S9
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:51:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5788eaf5366so1199160a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911482; x=1717516282; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=So98Jf54H8IWI3ia4EdVZYW+FWjhfKCBBI/z9EMCibA=;
 b=oeD3m48xcNLKHELmyHMjGh1V3JubvfRGWT7S2PXQqhmCFT8Bipb3kFf6qEfyB89zTE
 IRALMjCkhWf24mb+h9JWvIxmAexRMUx9FiEbGFYBvjOat14KGGrSDwiE8/7QOJYnuvJ2
 v4yTMZI48gMLdlNXzNar73q2+1tHCUi8Y7UrlJ6GxT9E0E6EhH+vawEafDhMlD7D+OGR
 HdOOWLwWNkamxiTowQ3gFHwOTeAb3ePLj0GpS+/qR4NHQ/xDHLsZho57t+dLTzjbLpsT
 KUKzQxN8DLEHKZA4ykVjclPqxHdIkotMmkobeuJz35P3xmp8YF/qWu+pngo1NhZnVlSG
 77bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911482; x=1717516282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=So98Jf54H8IWI3ia4EdVZYW+FWjhfKCBBI/z9EMCibA=;
 b=Gmf2dYMDO1gpNZ6TL8tEXQpcE/u9ZnYvBUqDrMlRwwvAw5nLlGvBD2x2GwR2fJutYr
 t1KG+7Ip+xLAPoS2quPD//vg5wFWke+v4UrCiAJXRysO71uhsmQVlp79t8Vmwq87QR9Q
 m+6FkbH7PHH6tpIhnlJEOZxJpXf65hd7SVc9X+s/htGDX/wwPSu31fF6SH2H4tRsyE5Z
 E9R3aTmww2b57arB78XkEeAvf50qvpyn8FkoEFYcpxZctb2Iac21jTEZhJrMaQUF5PKR
 6RS7lxef0Ea5Ltmxhccv+e791EM25I7JpUXjLdJavJGCTcPp0NxOIKO5Ml1RCFCQxpnR
 VUyQ==
X-Gm-Message-State: AOJu0YzcnUD1sEBkz9BOB6aXET/6cAqhcfZTP5DzWoYIAwktgaJA1FGK
 C9xd1gahhaeW3OvXJr7bP+3TEuUC+lUjnoaaT70d74KL2BlXravZMAvw7y7TrwJjE38YG1UbIdQ
 WTwpzbveaMa3mcCOH3v8Jm+tXY08iLwN6LaxN0FSGgVsEhK/1
X-Google-Smtp-Source: AGHT+IFDEAwTB/wElchOuAZis8ZJqO8NrXiAZGnwAioF6N66yoeJVCXe78IOz3OqTO62g+nUDxbwuQfgbpyueIYYAMg=
X-Received: by 2002:a50:cdce:0:b0:579:f196:45ac with SMTP id
 4fb4d7f45d1cf-579f196473cmr1533213a12.7.1716911482000; Tue, 28 May 2024
 08:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-45-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:51:11 +0100
Message-ID: <CAFEAcA-4xMXjVZFGbDjefNabHn2MW=4jFaYD79iq5oV4qyXafA@mail.gmail.com>
Subject: Re: [PATCH v2 44/67] target/arm: Convert SRSHL and URSHL (register)
 to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             | 10 +++++++++
>  target/arm/tcg/translate.h      |  4 ++++
>  target/arm/tcg/neon-dp.decode   | 10 ++-------
>  target/arm/tcg/gengvec.c        | 22 +++++++++++++++++++
>  target/arm/tcg/neon_helper.c    | 38 ++++++++++++++++++++++++++++++++-
>  target/arm/tcg/translate-a64.c  | 17 ++++++---------
>  target/arm/tcg/translate-neon.c |  6 ++----
>  7 files changed, 84 insertions(+), 23 deletions(-)


>  uint32_t HELPER(glue(neon_,name))(CPUARMState *env, uint32_t arg1, uint32_t arg2) \
>  NEON_VOP_BODY(vtype, n)
>
> +#define NEON_GVEC_VOP2(name, vtype) \
> +void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
> +{                                                               \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
> +    vtype *d = vd, *n = vn, *m = vm;                            \
> +    for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
> +        NEON_FN(d[i], n[i], m[i]);                              \

Does this need H macros for the bigendian case ? It looks
like we use it for smaller-than-64-bit element cases.


> +    }                                                           \
> +    clear_tail(d, opr_sz, simd_maxsz(desc));                    \
> +}
> +

thanks
-- PMM

