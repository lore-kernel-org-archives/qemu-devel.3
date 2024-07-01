Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A69AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sODdW-000168-S7; Mon, 01 Jul 2024 05:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sODdV-00015Z-00
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:47:49 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sODdT-00082t-5P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:47:48 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a72517e6225so307449966b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719827265; x=1720432065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8aPuzSx4/Yr7A7zVTVhGVXA0XQTd7JKLBBmFzMDAc/E=;
 b=cG7EL8XnpnDGak2j59ZcsGVsaHhSBzQ55DUtt1nCvydzRmclTP6i/zSPxMh1b95c8f
 fhJY/npoA7iflOxKfDKP2H40YvVZs5i25YCH8gwGFYbymFESYCiJSN40yaPb4PShCNMV
 8l8EtrEvk3e759yHnLztDbBO5010DjwnBKcyw+c/Z+de13fgyf2pRVz9mMLMtVCLe5Ol
 MCqoXACpWCCG3iR6Tj4tW9xnA18JA4Tyr3L4q1JY5E1sv0ZzMLrZxszhysBnJS9ol2mT
 Lp5lQhVWBXTlKAU388khtGy5MhEaDBdF7ETZn1eInKnYVTCnfecU1S8S9oePhjjNgEyf
 2r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719827265; x=1720432065;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aPuzSx4/Yr7A7zVTVhGVXA0XQTd7JKLBBmFzMDAc/E=;
 b=c3c2KzwC2QQHaDugxz0NthHHAfaKNBtCKGVhfssfJKj/2rm+/a5BJ/JNG7OVL3tefT
 LD8ba+v2IuFpeyQrazmwaMW/Nifu8MnFIHlqncECLJr9A6mOSMPKhkvyG0VpBbynPfIK
 O+U421mlg5FJKCl+QNinViLjjPFRE5qWa0rvc0RSkJIRI/nBSjThntrghyqJLZUAPENn
 EHA1aU+Cil0LmP+ToybQwtR1qZuXLwqmE4fljqnGklH0gCfowfm8UT6ty5b4UjrLwZ4X
 +eHbWMgW6TOChZnHEf1+6qdkExFcpsVyw+/Zo8xM0E75YtUDOe7Z0XN9xKd4+AQ5BTJ0
 XSHA==
X-Gm-Message-State: AOJu0Ywk67G3UXUiLJp806AVr48RRUUuIQOjxhOBDeImCvaAv6cEz5J0
 +S2xlDvVppbq5/8JrL5KWGE/gg+1TXsIUNLRlhUfMPmu6gb5zBNbCDVxsfbZ4YU=
X-Google-Smtp-Source: AGHT+IFBgKYBz7gQIsVpe6axZ4R3HR5/ANu4CECGx7A607lPUWn8EPDQcwxyTr/HTX5BraS6ZHSU8w==
X-Received: by 2002:a17:907:3f09:b0:a6f:4ae3:5324 with SMTP id
 a640c23a62f3a-a7514438c75mr449077466b.40.1719827264921; 
 Mon, 01 Jul 2024 02:47:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1cfd3sm319911466b.10.2024.07.01.02.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 02:47:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92B6B5F877;
 Mon,  1 Jul 2024 10:47:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  mark.cave-ayland@ilande.co.uk,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] tcg/optimize: Fix TCG_COND_TST* simplification of setcond2
In-Reply-To: <20240701024623.1265028-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 30 Jun 2024 19:46:23 -0700")
References: <20240701024623.1265028-1-richard.henderson@linaro.org>
Date: Mon, 01 Jul 2024 10:47:43 +0100
Message-ID: <87r0cdqw8w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

The compiler complains about the mismatch between long and the unsigned
long of the test function.

Anyway dropping the previous fix and just using this:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


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

