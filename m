Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E61CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxEp-0006F9-UK; Wed, 20 Mar 2024 10:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxEp-0006Ez-84
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:48:19 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxEa-0003oJ-NY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:48:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56b857bac38so1612371a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946083; x=1711550883; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nTF5BrS1u4Z6GWNnli6/3PrxUPESUYsUcY+e9piSrEQ=;
 b=lhuNiCRTpMw9l0EQSX/4G2plspxIfPBVOZYFy+jE1VCLu/q18mTLZ2HRIAQZ9QkYqh
 lddATnPnMRh2ALJVua6P0JQ/wfVZ0JtCl4X+6l5mX48NKcREzkwkG/rMMvj6smCYKWnk
 /+tbm/p3rHATK0PLJcqIeTgHd+6I8kKzPht6qLNrCyDw5mm09GGTynRsdQtVB3TRl1X/
 Ud/Tewrxni/iK4NWIDHHicNhX9tZZylokoAG3MRXJxsqr5ykA5ffNizy8IoNCMOO7JBc
 aUB4GWTEV8uXPk6Pmd7PTkVCaOp9vQsNj2etyoNOhuHkO4bTV2mIvH86wVpFuWvfNeoy
 Rgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946083; x=1711550883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTF5BrS1u4Z6GWNnli6/3PrxUPESUYsUcY+e9piSrEQ=;
 b=Fj66+RTZmoI9uHsU+I79rLQTP5U1MD5djomcc0UT7xfPieIk5VCkZaG7ZnjEsVhqKA
 L66zodpQcR8dMrSilpbPidgS0AGzvUflWLssOjdAHKoqxcXLDbwQBLY9aRUe3tjj0Szv
 MAyTdjuiFryHK6UUWw68ogPxFH+ZbfigTNGoBc9guhgUMsqZZRuwgC1v8GcMNJN7NAFo
 B/SglAEtMP3CMofY+1RiNyb6rb5EIGaPUNVL6q/zlUojVoqUMk0ORwu2ozPo0b8b3n/V
 GqLl7Ts27U6NWXSEsp/WTKF5pk3wDG0Jz6Ws3Q/YWVbmXUsf3sZ9kcoHSPm98H6D2V13
 0zwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3M3ARKSvl4R7uH67N944QrNscKBq1upm7RfMvxqfRTVeHlpJHzxU/Mt3T7uJfpCQjM+xXQMua3hFdlViyVQV3zDXStfU=
X-Gm-Message-State: AOJu0Yzz/ahBLuY7M2LyLhs5ikYpsuBbAFB9+k+07X0fW4Wl0OaE7ImU
 2sk0vbeMAkDNnsxoi9CTb8diDcLfFPz1NbwcwtedJFcZdQN8retq8rfBFpgrQgkrAaXcUo+VpTe
 DPTbnFBuiGJ/5fq5nwd/hJGes5T4KJQRTvZUTpg==
X-Google-Smtp-Source: AGHT+IHYo05puRv18N3VK9orQYXqgfOJTnovCrbQfX7YsPwwK544U0qJ6eBKk7Mv6sL2fzk5KbZI9PIopKZampvn4gU=
X-Received: by 2002:a05:6402:f1a:b0:56b:a74e:d581 with SMTP id
 i26-20020a0564020f1a00b0056ba74ed581mr3323056eda.13.1710946083003; Wed, 20
 Mar 2024 07:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240308060034.139670-1-thuth@redhat.com>
 <CAFEAcA_L7FQB9dUe1pCTTRN6XKbKa6ne2KZu6=-4YgTDzWW1aA@mail.gmail.com>
 <671fcd34-8c80-4506-8200-076894462bff@redhat.com>
In-Reply-To: <671fcd34-8c80-4506-8200-076894462bff@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 14:47:51 +0000
Message-ID: <CAFEAcA-mFEugZHpgJkGU+HjuqdGm0TdW+yHS=yMEOWdvDwM76Q@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix error message when C compiler is not
 working
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 14:38, Thomas Huth <thuth@redhat.com> wrote:
>
> On 19/03/2024 14.12, Peter Maydell wrote:
> > I think I would prefer as a structure:
> >
> > (1) suppress the "unrecognized host CPU" message if "$host_os" == "bogus"
> > (2) do the "check the C compiler works" test as its own test immediately
> >      after we print the help message (and not guarded by testing $host_os)
> > (3) leave the "Unrecognized host OS" check code as it is
>
> Hmm, another idea: Why do we print the --help output that late in the
> configure script at all? Couldn't we move this earlier, to the place where
> we already check for the --cc et al. switches? Then we could get rid of the
> "bogus" stuff completely?

We currently print in the help what the default values for --cc,
--host_cc, etc are -- which means we need to first figure out
those default values. We also print the default target list, and
to figure that out we need to know whether this is Linux or not,
and what the host architecture is. And to figure out the host
architecture we need to run the C compiler.

We could move --help earlier if we were prepared to make its
output more static and less dependent on the host environment,
I guess.

thanks
-- PMM

