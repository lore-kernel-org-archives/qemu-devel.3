Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C39EC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqJp-0005G1-5x; Tue, 27 May 2025 05:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uJqJl-0005Fq-UX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:09:53 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uJqJf-0004HS-9G
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:09:53 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-604e299b5b6so2464604a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748336983; x=1748941783; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UiSFG+lsyOa0Fug1d6mYfDWsRqD1bMLxeIhYoZ2iV6c=;
 b=OLTlrlp/0zKUdgLYn4KrlBDdBc9VFasfoxJ/fDvOIIMz4fdbuq/HUem1xqAyZbSYaX
 3TRtBB1sHHEGiCw/JiVFub9pKNr9eoAZlxiqWmSFYBYOOBTv3jdBiCk/OGGSdTPeOSYr
 wRjp8KRhoInyyvJjfuB3M0XMdbKymDeSM7pEHoZmhWUXckwj/Ecl/tLw+F9NQWy+IUjL
 nuwpu5VHs53erHfDD4coq1+Mv0oYMZcq3CG0vCLrW14nUYPxSv9uP6V2Xy63OFs67yrH
 l9/giUz1XuvwrolM8HQEcTnXhUSI31cInea5EKUeqxTYxY0Keu+maZf+mpbqSwxwx7pB
 7aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336983; x=1748941783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UiSFG+lsyOa0Fug1d6mYfDWsRqD1bMLxeIhYoZ2iV6c=;
 b=q52RDBHgcXOmuNaGwJG+oK1Ww2fE9avF8Z7tVkbmPe0yr4VEMqrwDiDf7MZmqEV+CI
 XtL4oFinC46RDBnt8ff7EYEERJaPZnti0K4Xt3sadGSXIRFKP7gC19WymS1lJ2V6Cbo8
 kVcNGS7Pupxo6iupQmOx7e2T1QMih2pZq8KzinVTUEhszHIoxCowT5ZJY+kTIoBXhqbF
 doVBR9a6o6EL7OdJ4KQVtQycdX7jRDFqtsNIB006BXwqb1TdxdIRSaU1gbqZ/nvG1ZIu
 dRmLKJIFzy+wYDseMI6eHKo0taOf8i57wi7m+X7RpIutkISEDaisoClzsGp9TO0rQmfF
 /E0g==
X-Gm-Message-State: AOJu0Yz7n16y8LdhW1L7Clh7cZAwNlN7blw8b2e65M4t9DXXLE4F27Tk
 5wMMGtw5llSnyywpJAjClNiruA4Q1TodapoJs3zn5i0HI6UhAkL+BGfhHeIr8m3at0Rotk8AmuB
 F4j1TWVUF60e5nBicUbyxPF53ilsRgTDMI1kwxiXdW+9152Dre0kd
X-Gm-Gg: ASbGncutYs9S5cgEoXoO0TQGtlHn65inPFl8JIubu5O7r6zZ7gGXOu0wIeskhJVHxnk
 Sqj5VsmHGbX++hYzjZDN5h2iAP7d6v1a80X3fe7ljrqKHDk7Zh91cLg+IUd5H7k/r3H2irW26j0
 HaMBSQTcQCVJKviZJQL4HK8idhNO/AsZqWaxxFJe+SS2LQ
X-Google-Smtp-Source: AGHT+IFnFzESeQZThTqYikfwAvgy9snn/lOL8s5mWObfvzR9RHYpsPavJqy8q4vy/3OobYUlhYyyxoaxQGLNpVrNNxk=
X-Received: by 2002:a17:907:94c1:b0:ad5:5114:f538 with SMTP id
 a640c23a62f3a-ad64dc69623mr1622059766b.13.1748336983314; Tue, 27 May 2025
 02:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <04f1cf26-696d-4825-bdae-771e17ae0cf5@tls.msk.ru>
In-Reply-To: <04f1cf26-696d-4825-bdae-771e17ae0cf5@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 May 2025 10:09:30 +0100
X-Gm-Features: AX0GCFuuw3b0eCxEtHns6yE57Af8KuFd0vNOZTa8dg8HOp0x9q7dh18eYPma3z0
Message-ID: <CAFEAcA-zBmTyUkfuN+jTD6RWYNtFTPso=KVu4VA2b-iayAPVkg@mail.gmail.com>
Subject: Re: FWIW: current qemu-user can't be built statically on debian
 bookworm arm64 with capstone anymore
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 27 May 2025 at 09:59, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> FWIW, and maybe a heads-up, but:
>
> Current qemu (git master) can't be built on debian stable (bookworm) on arm64
> statically, when capstone is used.
>
> ./configure --static --enable-capstone --target-list=aarch64-linux-user
>
> this fails at link stage:
>
> /usr/lib/gcc/aarch64-linux-gnu/12/../../../aarch64-linux-gnu/libc.a(setlocale.o): in function `_nl_locale_subfreeres':
> (__libc_freeres_fn+0x124): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 against symbol `_nl_C_LC_COLLATE' defined in .data.rel.ro.local
> section in /usr/lib/gcc/aarch64-linux-gnu/12/../../../aarch64-linux-gnu/libc.a(C-collate.o)
> /usr/bin/ld: (__libc_freeres_fn+0x124): warning: too many GOT entries for -fpic, please recompile with -fPIC
> collect2: error: ld returned 1 exit status
>
> Apparently some code/data size has become too large.
>
> Only aarch64 target on aarch64 is affected, so far.

To summarise an IRC conversation: this happens because
(as the error message suggests) the host glibc was incorrectly
built with -fpic rather than -fPIC. This was fixed upstream
under this bug report:
https://sourceware.org/bugzilla/show_bug.cgi?id=29514
which is likely why you're only seeing it on Debian stable.

In our CI we work around this for the affected distros with
the --disable-pie configure flag.

The error only happens if you've built QEMU with a set of options
that mean that the layout of the executable happens to put a
symbol that libc uses too far away from the libc object, so
it tends to come and go depending on how much stuff you're
compiling into the binary and apparently unrelated changes in
QEMU itself.

The fix in glibc itself is a three line patch (affecting
aarch64 and sparc), if you want to suggest backporting it
to bookworm:

https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=51231c469b49fb383;hp=063f7462dac26487e38b126afcf80dad77da444c

thanks
-- PMM

