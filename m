Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042ACD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2jf-00039m-Fj; Mon, 15 Jun 2026 04:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ2jd-000397-Ek
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:31:57 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ2jX-0007ah-IG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:31:57 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-660e9ea23cbso1451125d50.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 01:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781512310; cv=none;
 d=google.com; s=arc-20240605;
 b=ecxV6wNoKJgHOaWWybRQP1oJRooQCrizC6BQxQXWn76aKgayraKlfW1Id2rBqHH9GS
 rPUYrvVBb6BluCVBl75K+EoSJXaO2pWpo6LK85ySUg26Rv65yJk5hXek0ewZK9FDQrdn
 ik5yBxkJ1wjB43AGz/GXzdlYPq9rZpLQA9YNdESqeeovkPV4uWcWmYPktjP1TqyQdd4g
 pxyoFs6xoJGGT7g3ToHrNojFuy0n8Su0awX5d5Py0yM13oirrJwV8SNvy19ceC/34Rlc
 qnsVydad5HDHf/XuqIQ9EDcN154HfHs3YtpunZVrFdabim+nY3DjBPnfjjDt6IdvbRcE
 Fg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XvG3exdGiJGNjD45j3sqsnKPQTVp+Y7bsmGB6J34xnw=;
 fh=68mqwDFpODVwdiMusuH4A+K4xHWzgiUbQ04lc3CN9gI=;
 b=DfOCr1aUzRhIqsigRXbbF+P26zdM4SOzUGi5qlrDhJq+x4P6kSiDCClKcy9tNpsI0I
 YPFfWcDl1Urms4FGXK/N8feXh9jlWyY4PXZLhJzmU0ArJMBP6dKf8JRwKCuZh8x69/4p
 KUubQFQV8e6d4RJoIsvEQnmGX6CHx1DMp2i2RkXBsbvA38Q4/+sN/tqOdwjzW6xVTZFg
 B4b01b5DRtLFZcOkhr3uudcgyVkUmp2KL9bPl2XK8cv1eim/Lej3LIDdM6AFlT2oev67
 zIEojq8tpEwEt9UetjdSjVXn1MZneBKFNteN3DW54pmdD1CYjzvUZgsL2ImO/024SnSC
 ag9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781512310; x=1782117110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvG3exdGiJGNjD45j3sqsnKPQTVp+Y7bsmGB6J34xnw=;
 b=Vhu4aC2TQEKO5bgxQiX3yV1TJA46VV2bPjOlGrEUEBZy4WH5qvW7Sq+5l20zvWeSOH
 NK9vhwuxYwLGHLY33v9wJcWBNb5poujGQJgEYn2GG4YIGmqDDiTPC5PF3UFC0u1e8C/s
 3izpFUH8Hga90a45lv0aVbjdArGgB0aOCimbTkhSIo1c8slzOQFuqVC+1WW9iS36FSkJ
 276+OsjQ0AghrBglJI9ddcZhJrdgk24YIZQYxfw4bfKELa0E5RDU4HV+VHsKewalT/Fs
 ApztY8ACZe4xIV8aMe5QsV3vPKsORV+Vw824oQ2Cbr+/kjT18iHDqe3LoIuF7hmWQEeG
 YG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781512310; x=1782117110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvG3exdGiJGNjD45j3sqsnKPQTVp+Y7bsmGB6J34xnw=;
 b=GKQbGYg5Pwu5HCzq6uw6GHckmq47YnfeO3ab8VpQ20+hXJGiCIkgXP+FDwOrgO2ANu
 AqCLq55Qn0yaxnFrrBF1q2+jWGXOcyQx/TQkftX3roqtoo3zVbUXDsm47CLCgnJhVNNu
 oNhrUkrxCRPw8cEU1mTkGqTE+/3BeU0jBrHWRZrCrvFW6EvYFP/3AKmMZ27Z105brQBV
 ubW/WU6TDbTau8NLShMhhws5DFxG4Jl7CEFhqggsRYUkpyTvKK7mGnXt41Hb/XGR/B6L
 i6FjgEzKmsQkjH373juhdMjMD9F8UNdJk8T1wX5fU6Al0t90irZMNthAFakauDU5vxlt
 XONQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WE/WIoj6FZANaq3cGicxx0l6MAATGvFryvwsPjuaTP0SioEHIPnv4Zz1HuKYF36AsEIrF6gVu75Ap@nongnu.org
X-Gm-Message-State: AOJu0Yyj6G+sT4sjXOKGyHCddaGFyQN3HKOVfuU+z7PNW+OZkngb98uF
 4db99PzaROyfHMIusSWDs3IHmmiY2LI3PV4wmbdlHGvoXxrYSTbt2jwOoNsGOQh1PqjiKTHRkNb
 BObAs4sLpWIAgnC2BglzAVKF5Hj2/1uaU1CgKlTHtRg==
X-Gm-Gg: Acq92OHeYc7IfwSv3fUpS1/ad3IIAWdHh7b9RcVhd7fW/J6m1/YMMSbd7C1a+oVDYm6
 Naq41srzQ5V39pxTUw34Q9ag2y9m0CjxVCfPyQ2X27iP12pSv7aQf98xJDSPXO/R++5lLGGTVpp
 FQUafJkUlrn8HAp7QCJWhrzCQErky3NwZc02Lv3J8moCgm2chG+M/w2a9671J4R9+Q3LZcOXTsb
 Oa/R84KJnFS3JCJHKwxTH4FxFUkN42QegmMgsBo2jnCsf0+xmwHCqT1ihD7bDXiiqQlPj1r/CEC
 4syvLoymxBZEcMIPP3PgCVxGJPB1FXpEuKxiyAnm/C1Rtn/nZAuiqeVNGhjIFfyiGIM=
X-Received: by 2002:a05:690e:190c:b0:661:1be:161b with SMTP id
 956f58d0204a3-6627837c3bbmr10865707d50.56.1781512309811; Mon, 15 Jun 2026
 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
In-Reply-To: <ai-z14dMCK33_pis@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 09:31:36 +0100
X-Gm-Features: AVVi8Cc4gi7a_SUgEXm8D-PR5l4cbaN47lQ8aHYhgFhq9Vs4k4PQZLPga7J-chk
Message-ID: <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Do we know how many examples we have of embedding objects inside
> another ?

It is an extremely common pattern for device and SoC model
implementations; we've been recommending it for years.

> I would much prefer if we forbid the embedding of objects. It is
> horrible design practice to have some QOM objects which can be
> freed via reference count and some which cannot.

That would be a very large amount of code to rewrite to the
new paradigm. I don't object inherently ("you have pointers to
your child objects" works better when they might be implemented
in Rust and might play better with being able to create
machines and wire them up on the command line); I'm just
noting how much work it would be if you wanted to make
embedding forbidden.

thanks
-- PMM

