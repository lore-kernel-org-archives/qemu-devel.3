Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8E3C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBGC-0007IJ-W3; Fri, 11 Jul 2025 06:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaBG0-00077S-Ju
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:45:39 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaBFt-00089Z-Dg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:45:30 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so1908001276.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752230720; x=1752835520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfsVdgjRwbzcESc4fVfB5MLZD8EyltNALlb5RJELTbs=;
 b=t2/Mlrv4zscnk3QvijBusHtWf8i3GwQ8VPvjZp5xpRcn1cJVnGHjpMLHjlIffyeDae
 PX6AEh9GPbU3KD/9yU7XU46GQXv50S6Qojbr1EYivqiv/TGtHG+WZRqmijb30mfx+I6i
 cX18nh/jXsSnFhdQ4iam8+pe0JaAIqJog1RcoV4BiTh8z4u2MevL0jPx+QdTshxgLBor
 m0y7WNpAhnUY3NQh1DzXhOPDXtuJupew2LbN3ttCwcGoVoFHg+gzu2zvQAX2s/fYh1pf
 NEe8TcIL2+SEnMe2LXFXXru0otQvQTqzfHfEaB6PhD1dXUGUP7eqHFKtXFw6mSP1iOaI
 f+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752230720; x=1752835520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfsVdgjRwbzcESc4fVfB5MLZD8EyltNALlb5RJELTbs=;
 b=aKx8MUgCvWPTmdJH9Zuw2+VafmWmHyWWfviKDuZcRkbV7JbJC7bexihsbVi3BkPKsu
 GPP//Py2FekFfhvsrcguPHwC4/N7gmDpvwwkFMo9dT6ypEzs3ZOsvXb4Vd8QBJ0k8cVm
 EV5Ziha6jFjXTrv/xVyIqOiVpttrqaP2bNaHI//2TY7OsnQXhWClZ1s8Obw3ETpkTqp+
 UhFHSTZt8iFJYkwIiafkd/7GNSzgPw0Wz+WqzGch93BNneZsT+5YSGojgzCwQiFjQyXX
 JpotyQ/F/DtPdIn6XgF+zSp/91QUFCPinuJ+/2BTgSuDxgROW5mtcv+DMGuueCeYPOPI
 HRvg==
X-Gm-Message-State: AOJu0YwNhZXlZyqj9Bj2n2hQvLE9xZG9xfo429y4bUkmzd2fxdgle/v1
 o+n30eNiV0mdSck3XRQNrEql8QcHD2mzSqp2BMi39K+BV2E9jYXKlRkOCgscxqFhWso0+9iqXBk
 O1fPHRIy2WFMEHzcXzvkbqu0lkj0/v+aCwssSa/5hiw==
X-Gm-Gg: ASbGncveFnJ3uVCh3Nks9g17Tey59vnXGQ1V0qldAbMu68/QFH4Ms7Hvm9PdYacsxPx
 hHZu6/FfGDH7BxHMAuF8XAW2tlfJTzjRFkJpCUnwAgtykn0caljb4CjdUC7p1v7xLY0SkGTuH0E
 wyaUDYUYZWtQ7AdGXpFkIl0t+xEajpHroSyxZGWPwCv1iO7g9dFNZk0HqmCFZ3q3AC1cyDgtMa9
 Gk36fUh
X-Google-Smtp-Source: AGHT+IELHePNp06r4857ulIbZuUv6jdKGcgkYtXG0qdpo7+Q36+gVuuXtFAXyTY1VqzzdyYy0oU6hguqC6p9aNBvmnU=
X-Received: by 2002:a05:690c:9c08:b0:70e:404:85e5 with SMTP id
 00721157ae682-717d5d7e0b7mr53663547b3.11.1752230720192; Fri, 11 Jul 2025
 03:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250617203435.41490-1-shentey@gmail.com>
In-Reply-To: <20250617203435.41490-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 11:45:08 +0100
X-Gm-Features: Ac12FXxFgqkLCM3VXQKl9eruvHaEAa-CHJNcGaXOsfVetxc7ku2LLglQ0IE7hio
Message-ID: <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Tue, 17 Jun 2025 at 21:35, Bernhard Beschow <shentey@gmail.com> wrote:
>
> When compiling QEMU against fuse3-3.17.1 with --enable-werror the build f=
ails
> with:
>
>   In file included from ../src/block/export/fuse.c:33:
>   /usr/include/fuse3/fuse.h:959:5: error: redundant redeclaration of =E2=
=80=98fuse_main_real_versioned=E2=80=99 [-Werror=3Dredundant-decls]
>     959 | int fuse_main_real_versioned(int argc, char *argv[],
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>   /usr/include/fuse3/fuse.h:885:5: note: previous declaration of =E2=80=
=98fuse_main_real_versioned=E2=80=99 with type =E2=80=98int(int,  char **, =
const struct fuse_operations *, size_t,  struct libfuse_version *, void *)=
=E2=80=99 {aka =E2=80=98int(int,  char **, const struct fuse_operations *, =
long unsigned int,  struct libfuse_version *, void *)=E2=80=99}
>     885 | int fuse_main_real_versioned(int argc, char *argv[],
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>
> That is, a fuse header triggers a warning within itself. Since QEMU adds =
the
> fuse3 include path via `-I`, the compiler thinks that the header is part =
of the
> QEMU project, and thus raises a warning. The compiler can be told to igno=
re
> warnings within 3rd party headers by adding these paths via `-isystem`. F=
ix the
> above build failure by marking fuse as system dependency. While at it mar=
k
> every 3rd-party dependency as system dependency to prevent similar issues=
 in the
> future but skip glib since that results in glib include paths to be omitt=
ed from
> bindgen in case of a Rust build.

The problem with this is that -isystem does not only do "suppress
warnings in these headers" -- it also alters the search order
for includes, in a way that can sometimes cause problems:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D70129
So this isn't completely risk-free, though I think meson tries to
avoid some of this by doing something a bit more complex than a
pure 's/-I/-isystem/'.

We would also lose the warnings about e.g. use of deprecated
functions in our dependencies.

All that said, this might still be the best tradeoff.

thanks
-- PMM

