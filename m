Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2791D7830C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4EP-0004Ct-CH; Mon, 02 Dec 2024 06:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI4EI-0004Bw-N4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:04:38 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI4EH-0004Wm-7f
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:04:38 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0c92e335bso2751831a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733137475; x=1733742275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XIgWN38KMu5LfcA2A4mfWyrUaVBJ1N/G44J8mNqA9Yc=;
 b=N4aciWEB3SwZFNizn8A6sEElRdnIRdsy3nWj4GqkTYrmGbV+8nP09vwtERc1v4Bv1N
 Fm2hwT9Y+kUiUMACBzFr7CHY3fvjNzbgmEIL/PclMmGIbLk2okjBaLTusg5SbtyoXXOr
 O4iDBWPd/Ysoupj4rgf4xLf5yJywwI25xw/iDN/NwReNg5HjuGE4OfQ7Qcbu6zEPQbJh
 I2ciPGBjOArnyrSBst1FvfmuyrKYDzYLDAvsbNqMvMl1lRa1StZJ/QTageHiOoVdyUSD
 rgd67ke77VclYj9uIt9dJoY1fyOwkc58003GRhDwrMmN8DDZb6ViyTJEeNeRZbG7d1U+
 tzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137475; x=1733742275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XIgWN38KMu5LfcA2A4mfWyrUaVBJ1N/G44J8mNqA9Yc=;
 b=ouPEIZUlkt9YYinuix88mGIhoXqCLf9eIEnIXW9lAHOnR9qRUpWRCO67IbICL9OXDU
 xECZ+qVid2Y+mT2AQ+BccQ+yYyKCYhJDzfluI2i98iCsFHQnM0wgVUl+LsrzYnCwaCIh
 Jk2sDOQEVVZ8N/C5kT02GvxSk4QsjhqP8ZTzgClLtz/t3DgB8eu5kp89Nlm/Gv5FLRha
 7A4xY7OtsqfZ0t5w9c4GcsTGnGbZbqydGwmofe5uOqC11EH64b9tZexQdw3GbqwtKqX0
 fw3aRxiKtLrRK0rzZjDf12qByxJofIJmXdqZZkNg8ao1JlBp55xz6YlnSNo6cMILgRNP
 wg8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAVw3VJg7Vam7USYwHs+auaBXAD0vy11xBxICHdPNOq3iqgcVkktjiwY8avMYbwxPxOl6AvaxcyG2p@nongnu.org
X-Gm-Message-State: AOJu0YyKEq1q0E6TjhkdOs2z9av6gQwlGGJC4V4XWdlHiq7wr5AUfjZS
 qSHy9WVz6pMMoudr+gNarNcOm159s8FdF8NkLHKjx4fzVxlZM+txZ9bgDuKi5/U5vz1FIJmCN5/
 AnwByjFO5iginoRNSMYwwQ9OqGkqu+Bf3Q1qyUa+HedGOlIN/
X-Gm-Gg: ASbGncuUlG7Vadh2bevNQHza0DV9QhGRGVBc1v2ZwAn455MOS4co4W6ouX2REWw8pt9
 Reh8pohagj+gT+VV23nbd2VhVs1EFTyjH
X-Google-Smtp-Source: AGHT+IHrwpLh+sek1XYebFX80pmk3soqyuLKkOSoqt+wQ/9TQa28NiCOQYa5CsQ+oCv8UAZg/eDVa6RxafcpGmkg61E=
X-Received: by 2002:a05:6402:40c6:b0:5d0:bd2a:fc18 with SMTP id
 4fb4d7f45d1cf-5d0bd2afeb5mr16062852a12.30.1733137472997; Mon, 02 Dec 2024
 03:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
In-Reply-To: <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 11:04:22 +0000
Message-ID: <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 2 Dec 2024 at 10:58, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 1.12.2024 o 19:09, Pierrick Bouvier pisze:
> > Hi Marcin,
> >
> > On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>
> >> So RME tests probably need longer timeouts or would not run at all.
> >>
> >
> > By any chance, are you running those tests in debug mode?
>
> zOMG, thanks! Turned out that I left "--enable-debug" in my local build
> and forgot to remove it.
>
> 90s vs 2974s is a difference ;D

That is a particularly awful debug-to-non-debug performance
difference; it might be worth looking into what exactly
is causing it.

-- PMM

