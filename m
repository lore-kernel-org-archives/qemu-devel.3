Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13425C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 08:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhlEO-0002Gl-D5; Fri, 01 Aug 2025 04:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhlDu-0002AS-Sf
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:34:44 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhlDs-0000yl-E6
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:34:42 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so1821310276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754037278; x=1754642078; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7YsHZyiE2Lx2Jze+gaY6HgB0NnAHU4eokx9mTEwqGBQ=;
 b=uYbWfbZ+4EYuVgytIxFmm67ukkSm1IF1N2tQyMhj/e2pCBvqoYI8ynfRGMLpcYDzcS
 dCcICVZFwHSweSqEG4wUUVEBvEvdpe9T+TgLDRTMA0sPfJJYQrq0nSCwoUA3KCPoswFl
 rTGWHRZmNJzBnH27r0TIDaqWosgmicvrGxAtk/B7tHY+Eahr8JtGIhwhm4hW8dltVzBO
 SvkubDU8vqQw0FTn9oqOBMHux+8Rom7Vac7DCx/++t/qR9D462zxO1NJpcyotD1/3Jqk
 c8skr5hzQb60LYl6c24J4dhlHNKdy3uuUKgejgyKllibFRGW7PAEw8jSi1RaU01XQZca
 /4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754037278; x=1754642078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7YsHZyiE2Lx2Jze+gaY6HgB0NnAHU4eokx9mTEwqGBQ=;
 b=WSit1nZ8JI3/qjAwW1ITU2PRomETv7e+pjYcs9Vw/kBYj3Qs6a3+2wD3cPZ0cIqmXZ
 50qKhSUydzOAgYtom7n5X0RgL3Dw3yyfuUjP29jMzfOy4/yrsMLxgfE7shZdPYYug63/
 NDpy5zifEgTcfIyN48gJMAEeFsq19UdeQBpU2iQb/QAgOiQlSPDJY84vDsvNYM+W4/q4
 wUWWqEIYMRs1BZ7PNq8U26XzPTDcL4D6yyeTzbDqfdHgxS9p4/Kc0WO869AxiCjYAkWj
 CiOsVHEEOXaCKqwb+3rDamyxk5eyMoUSVR28pMkA52VIJ3ufrYypjMdfAyYoPvZSz6N4
 oxUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTlZeqm10AjwK2eri8zgAiaC2GXwHSwegzA7NMQaXBEZzr7pGHVk7vVR45MjoqgxDuriyTHI0LZ7E1@nongnu.org
X-Gm-Message-State: AOJu0YwplMQ/ez9x/BYAfZ6IoeByO0MqpPDRo2YlYajp+nQo6JSgHINh
 Ryb8d8rbAyAfG8FA/drbKuRdNgsloBxqbda2dSX/mhEw7/syUKr+iRkksX1FKjlPbfO0vSxgb/q
 Wvnr8mzkwxR8oDVXTAuJ59GoabjDUxwVlDDcV0+fRqg==
X-Gm-Gg: ASbGncu/PcftU3ZO0cgO1pHWaq1jgIN526wQZyK5D8FbOOJ9bwR3PXGjmc+RqsNaQEq
 KTrOeUXqUyhLioRzwY32GbrmhbuNVkw8tVWShG5YEEm2qaZyxekhwLHkc36UvMaA0O23dvNcZ3p
 zY3bvb/wRHlZHjazeaduIMCfGqFmfvHezvoROMp6WIGDsktWM3xEE1N0Sff6y0KBb/rkpp6LJ3E
 uU1Pi/t
X-Google-Smtp-Source: AGHT+IE/sNYNYLWEP3QI5jW2RfXUXK2vyKQO49O10NElRWtJzF3L+C9AeKY/zgqcWpP3aZFRK/GzYzYFueLC72dKCA4=
X-Received: by 2002:a05:690c:d96:b0:70d:f420:7ab4 with SMTP id
 00721157ae682-71a466bf17dmr152978847b3.29.1754037278446; Fri, 01 Aug 2025
 01:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
In-Reply-To: <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 09:34:26 +0100
X-Gm-Features: Ac12FXwkhCRV7862qOZMU63eG5MFFnYfvpUQjYI8FvlW2QYCmy56ba-hN4GYsWA
Message-ID: <CAFEAcA8qHUT-0k6chAFZ61J=YZ7xLvhYgqsgtQiCgkfaxfFRxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 31 Jul 2025 at 19:30, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> Regarding the "modern" completion support, I recommend you take a look
> at it. Even though you wrote or reviewed most of the code you navigate
> in everyday, and thus don't need it, it has become a standard tool for
> any developer, like sanitizers or omniscient debugging. It's especially
> interesting since those tools are based on compilers (clangd is the
> standard for C/C++ nowadays) and not a bunch of clunky regexps.
> It's even more interesting when you learn a new language, like Rust.

I do actually have clangd enabled at the moment in emacs:
but my experience is not good, because typically what happens
is that clangd runs itself out of memory and falls over
fairly frequently, or it produces obscure error messages like
"LSP :: Error from the Language Server: trying to get AST for
non-added document (Invalid Parameter)"...

So I mostly continue to investigate code the way I always have
done, with grep.

-- PMM

