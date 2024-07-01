Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F1C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCpV-0003t0-4e; Mon, 01 Jul 2024 04:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOCp9-0003Wu-KF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:55:48 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOCp7-0006DN-9e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:55:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso3295820a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719824142; x=1720428942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kDVUi2EGUfUyzo6yp0OUfg0RKoJ41ci/1qDOi6uLZCM=;
 b=iNF9kfhC67vy5bRn7TXo0rrKyYieY8N5fqjYqw82INwXFGCJ2Ud2MGhxucsS061+1x
 8H7nPIPvJALN5hPd4PeWd9XA8EASw9/lpkpcy4jDZbISq1fI5Y9y6d88XXot1sR1kREi
 DxkX5g031GKLuroBX53E1TmYLshYUvSJSRZudL/EEznaNwY9hfM3vK4JwzISbPGMjdFA
 hu+9iQAmuTeriAxhLaXWjSSR+ncnIS2R1KImxxRiBniKUoBFA4Zadlpenp9KpCZ0fdvh
 ErpKvGDPrXvrFVfugKtY5bx0g5RtG46sFXoni6o2KSzXbsL5cyCG8nSviu/1v6E0JCBE
 9yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719824142; x=1720428942;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDVUi2EGUfUyzo6yp0OUfg0RKoJ41ci/1qDOi6uLZCM=;
 b=BOald6dQuCAhLvEp2GF8xYzcA+SHlVEkcI7tBFIXkHgIMUhypvDen5ZOyC4zdwzeC+
 gjh3U8RxfKAI+Me9/IE0Op9Zx6SwBnKVHen5Ud2s46b8YRASaL3WR9OoiSKcQZGxTkV4
 kqaueis5u8y5L3UIfiYKFTGxWBdCeZMmYevVqPTqbbeS0z6GBP7ukCGyLqUItv3Y+UHR
 EVNFIi7Am0XzlwCmxtXwqq2jHZkrP55zrReCaRhtvGuJy8XjDx4/HolgAem/6KUfjXdp
 FWRVWShYTWyTvsOgn10uZ5bCdh7K1Q0ITsCED3AOVfjOjdvSEwYr701xqAJ15T9n4tjE
 f/3A==
X-Gm-Message-State: AOJu0YzHQ5VxlMB6RN6NO80UwAdEZgs8lu8H014nESc5ohTffdFP+M1M
 +/OST5FfygbE1bgxct7aGcEcav++/wcRJqaTcaDLdQfuLNsqMv71PSma54bJDk0=
X-Google-Smtp-Source: AGHT+IE/C6bKK/uRY16/TE67PgoMmLdRES8kKcbkZbOIwKeZzLLT7/oKkzNhiYHRErtnRTHqYiCQSg==
X-Received: by 2002:a17:906:8883:b0:a72:9059:6cc9 with SMTP id
 a640c23a62f3a-a7514451ab7mr287696266b.33.1719824141515; 
 Mon, 01 Jul 2024 01:55:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0657a6sm312593866b.129.2024.07.01.01.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 01:55:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20E5B5F877;
 Mon,  1 Jul 2024 09:55:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  mark.cave-ayland@ilande.co.uk,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] tcg/optimize: Fix TCG_COND_TST* simplification of setcond2
In-Reply-To: <20240701024623.1265028-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 30 Jun 2024 19:46:23 -0700")
References: <20240701024623.1265028-1-richard.henderson@linaro.org>
Date: Mon, 01 Jul 2024 09:55:40 +0100
Message-ID: <87v81pqynn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Fix a typo in the argument movement.
>
> Cc: qemu-stable@nongnu.org
> Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c               |  2 +-
>  tests/tcg/x86_64/test-2413.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/x86_64/test-2413.c
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 8886f7037a..ba16ec27e2 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2384,7 +2384,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *o=
p)
>=20=20
>      case TCG_COND_TSTEQ:
>      case TCG_COND_TSTNE:
> -        if (arg_is_const_val(op->args[2], 0)) {
> +        if (arg_is_const_val(op->args[3], 0)) {
>              goto do_setcond_high;
>          }
>          if (arg_is_const_val(op->args[4], 0)) {
> diff --git a/tests/tcg/x86_64/test-2413.c b/tests/tcg/x86_64/test-2413.c
> new file mode 100644
> index 0000000000..a0e4d25093
> --- /dev/null
> +++ b/tests/tcg/x86_64/test-2413.c
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Copyright 2024 Linaro, Ltd. */
> +/* See https://gitlab.com/qemu-project/qemu/-/issues/2413 */
> +
> +#include <assert.h>

This also needs:

X86_64_TESTS +=3D test-2413

in the Makefile.

> +
> +void test(unsigned long *a, unsigned long *d, unsigned long c)
> +{
> +    asm("xorl %%eax, %%eax\n\t"
> +        "xorl %%edx, %%edx\n\t"
> +        "testb $0x20, %%cl\n\t"
> +        "sete %%al\n\t"
> +        "setne %%dl\n\t"
> +        "shll %%cl, %%eax\n\t"
> +        "shll %%cl, %%edx\n\t"
> +        : "=3Da"(*a), "=3Dd"(*d)
> +        : "c"(c));
> +}
> +
> +int main(void)
> +{
> +    long a, c, d;
> +
> +    for (c =3D 0; c < 64; c++) {
> +        test(&a, &d, c);
> +        assert(a =3D=3D (c & 0x20 ? 0 : 1u << (c & 0x1f)));
> +        assert(d =3D=3D (c & 0x20 ? 1u << (c & 0x1f) : 0));
> +    }
> +    return 0;
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

