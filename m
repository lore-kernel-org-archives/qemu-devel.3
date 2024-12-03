Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA4EE69E9F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQ9t-0001XH-AM; Tue, 03 Dec 2024 05:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIQ9r-0001WU-4i
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:29:31 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIQ9p-0001q6-Ln
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:29:30 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso3900958a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733221768; x=1733826568; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f0Q8uqfRhDvrNswbuG1OfIJbALNB3zPXNZJaDrH+yhU=;
 b=Ejt/hAZNWD3ak74+JWjJgeu0atoJIJcLZDYAsm4G09hJDA3d9AfaoO9OqeJM4EM+hv
 +6V7m02kzr/qbgtQb9p3+uVd6P1s5yHSj0eI2yzlhgLYnlPfIqGuXTUYAblUE5AjqIJO
 7YihNJ9klvjrVBSeM3ZXTTEv7ZXvBEZ1BMZsun6E3tXtsjNKa3egE+Rfh/NwztqUsago
 6BoXGCFcDjKqeVgQ5b5rZthkvjmvlIoRU7VMeFp705Svk+H011KNazY2/TTSZq5eUg1z
 WA+0GlHvSegPvNWmeskX/FkV7bad0JxaGYYLUhnEHZgK4S4SWzgzGdrU4nJ9Q/U/hCMU
 sm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733221768; x=1733826568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0Q8uqfRhDvrNswbuG1OfIJbALNB3zPXNZJaDrH+yhU=;
 b=aygbdPU3VARJNT35bbLNKtVZ8zcIg7pP1cMWl+53DKFHq//CZPeppLqHwQh+WoIxnI
 EKMsdhTRzlMn8G60K0dKiw+fzQ5TdFt8CIfPnHp+MiXOTySL21xkx6oFS4UFEIogMvGe
 lECi3B950IN94IKafDhi8hjgEnDWCYhjNAqM28mXjEDLsHZFgQcBxyDWmO3ROCG0jOZK
 EqoEmCIkXvdxL6GvaufDjeiTIHPfV6/FlhOTzxY4AD3YtP+VyXAkPRMNcET6VGjNrt9l
 23Zg5q0QfT13NJaOyfDePtouPspwJMq0xzXX0WsfFIiXCYSDoZDG8gFIHoFDstLDT3Ip
 s3LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrVMtOeqA38EQgNWWNp4vdHJVeCU0Ddyxjcw5pSfYSVum0HnlOzlt2N6MbVRAi1oKuIwYmIaaOksib@nongnu.org
X-Gm-Message-State: AOJu0YymMyASSI0bEVmJef37Chddm8U2eqFQ6/Yc8xGInC+PCmyI7YqC
 mNp+JSIIW3BJxUgQoJDHA2Pj+G2lHwQT6YNjfkst4qxa7du31Zcux1YbLeqFX7Gb4/MYj+t3PKM
 FnNPkMgXyqUrHib6CcjyYhQoiRJr+UgnO6QKAWg==
X-Gm-Gg: ASbGncvB41RF57+OERv8dfcyRNQFnN3LexXwMDE1SZGft6IdPns+uNxLNvmoo8snZhh
 mull4g1vUijOS/t4wgXJo39zlTBMq4kZ2
X-Google-Smtp-Source: AGHT+IGdeUQhGG6ILfuNeFl9J7s4bUy31TXtHRR0DuA6BHZtnhUZ0fTuANdTNGF5Krndlgn3AkMU6lEJf3qwCkiO7nA=
X-Received: by 2002:a05:6402:270c:b0:5d0:d311:dd4 with SMTP id
 4fb4d7f45d1cf-5d10cb81b94mr1276216a12.22.1733221767859; Tue, 03 Dec 2024
 02:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
 <a26e2a3d-d915-4e84-9b8e-dd5935049f31@linaro.org>
 <CAFEAcA9q7advmbws+xx6Mgcg-=072tBfdRReSSqymYz6p9zENg@mail.gmail.com>
 <b16724af-0758-41b0-afdf-8a6eb138dd64@linaro.org>
In-Reply-To: <b16724af-0758-41b0-afdf-8a6eb138dd64@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 10:29:17 +0000
Message-ID: <CAFEAcA-iAkyN7hPJ=ttEBwNDFwOTO8fC1H1RKSLv6uM0qzsCkg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 2 Dec 2024 at 20:09, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 12/2/24 11:56, Peter Maydell wrote:
> > On Mon, 2 Dec 2024 at 18:36, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >> Maybe our enable-debug should produced optimized builds by default, and
> >> we could have a new --enable-debug-unopt for the "I need to use a
> >> debugger" use case. Would save a lot of time for devs, and in CI where
> >> minutes are precious.
> >
> > The whole point of --enable-debug is "I might need to use a debugger"
> > (or a sanitizer, or anything else where you care about debug info).
> > If you want the optimized builds, that's the default.
> >
>
> It seems like we associate debug info to "I might need to use a
> debugger". But, it's not the only use case.
> Sanitizers for example, are usable with optimizations enabled as well
> (with some caveats, as some errors might be optimized out).

Yes, it's the caveats that are the problem. If compilers
supported an optimization mode that guaranteed not to break
the debug illusion for backtracing, interactive debug, etc,
then we could use it. But the best they do is -O0, so that's
what we use. (-Og sounds like it ought to be what we want,
but unfortunately it still leaves you with "value optimized
out" errors in debuggers, so it's no good.)

> I don't have anything against what --enable-debug does, but supporting
> this for tests (and CI) because people *might* use it is a mistake IMHO.
> It's an opinion beyond the current series use case.

If your test is hitting the timeouts for --enable-debug on
a local dev machine then it has a high chance of hitting the
timeouts in CI in a non-debug build because of the "noisy
neighbour" problem where a CI job runs massively slower than
usual. The fix is to make sure the timeout is high enough not
to be hit in a debug build, and wherever possible to have tests
that are cut down so they have short runtimes.

thanks
-- PMM

