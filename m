Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B714AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqmP-0000MY-13; Mon, 08 Jul 2024 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqmJ-0000AL-1b
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:59:47 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqmG-0006Hx-Sq
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:59:46 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so4175587a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720454382; x=1721059182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s7JXpTqY7x/2nCeSmZ7/HI4msoHcS3XeLCEZ2YFvCtU=;
 b=k6dJxlkXoWGPMBce5k6nJOzIee7VGw2imLv3KwRt/ZF1KB2sSnccrth8n9ZZaXTHui
 qRgYFqoMKDyMLIhryH6XI/bc+ehIK3DLP9g9884cQZt7J+rHLdj4H8c22I5rVnrre94k
 qz+ZghG1+zQPWTtUvoi3YH6j3bj0m6dNNksBEWpwNZWB1V/rAaHEqwiyqdBjgmeBVoAU
 J8NO/t9CKbwzd4mwlOdzqgm71LgVxM1T8/jhnLO2GE2QkdrgrZNzFe7p3m5ewkuhWNrc
 ihiycUd0XLXpEiF9jymdREa+HIhlFrcqfsvFfVefPF9+mac1nHRq63+44T+MeFEJhyyx
 QEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454382; x=1721059182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7JXpTqY7x/2nCeSmZ7/HI4msoHcS3XeLCEZ2YFvCtU=;
 b=MKtzSxG5Lyw24KSH3gxCnMisBjRFg1spVlYjFOLLn1RkDOyNLZx5aDvSm4cPPyCSZG
 JdBbm/IU0pV3Hs0iIp0QbkmTsqvwvaspyMn6T3we3jkMQUp/DKMYd9GSUHSH7HNdtJiq
 4og6qwBbhcX6Zc8c1it9IYa62z+MWS7UebwOfliCrR21FYfyzEptEv8l6guwJBwQVWhN
 pigwTBSRNyeRoOcwN5bK5zHNCbdjoeCn85IWyClbpppVExK+7nVcY5BQuH2nBDfC/lBN
 goWxUusJhcZtoIFxE4Fgsgvx9l5++MCX7GyhtC3IYWWwWlJOojbvlu8KUFhNe4k++g2+
 uUvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXEEZtNGuteJ/+DhmsftOmxbxUpat+Ygqc5C42yGl909n+fR5QpC5QW5WlFf1xBu0csexdSkhC0/Hjhj5afjFymt+i2qc=
X-Gm-Message-State: AOJu0YweuxW6hUPzvFYL2QmQczWtSyc0EYBW3WTJaXTuk+m0DHh74Niq
 vMZid6YuLsnY5UzQx+TjNpLsPAWQQIHIwsFU2MtIYX8a5gwDvNK6JUH3Bh5IukbL1L+S6q76JF7
 kk32p77dozlJpF2wmX/93WTkvyLT7y1ilrX0ItA==
X-Google-Smtp-Source: AGHT+IFFGPGFKifANUej5hr/r+3sS5zXJV0wA/E4cHrXvpYCq2RgyL//gg+QCsRF5cXG5jBEvfdfSQ4QS87zI98fAvs=
X-Received: by 2002:a05:6402:4307:b0:582:5195:3a79 with SMTP id
 4fb4d7f45d1cf-594ba98f268mr28034a12.6.1720454382086; Mon, 08 Jul 2024
 08:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-6-750bb0946dbd@daynix.com>
 <CAFEAcA-Zmc0BQgUiqEgzCvVGWyiPt9bo+Xt90n4wxhJ3_D91fA@mail.gmail.com>
 <Zn98p6CUV0KnIo50@zatzit>
 <CAFEAcA_LN8i66KUkxrgg=CUKJNYM=s9pTYv6w5QQ7PSU1Q3=bg@mail.gmail.com>
 <D2H7KBZF8OA4.3EKIA8NHHJ3MJ@gmail.com> <ZodPOTAcLo1XF4MB@zatzit>
 <D2HBUN5N504E.27WH86Z4HPTKW@gmail.com> <ZoeAutfGIAaNEFBC@zatzit>
 <CAFEAcA-QyGWNqS5saqGMc9f4WVS5mg8+YjUfOczovaT6duZAvQ@mail.gmail.com>
 <ZonXSmp9XZxl_HHp@zatzit> <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
In-Reply-To: <D2JZR5EF6CF1.1DDFFT4TZAD1H@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 16:59:30 +0100
Message-ID: <CAFEAcA9L+ApvH8bptyEi2C7fg=WPYLZecAUBv6mpx0o1-3K2=w@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ppc/vof: Fix unaligned FDT property access
To: Nicholas Piggin <npiggin@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 8 Jul 2024 at 08:49, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Sun Jul 7, 2024 at 9:46 AM AEST, David Gibson wrote:
> > On Sat, Jul 06, 2024 at 11:37:08AM +0100, Peter Maydell wrote:
> > > On Fri, 5 Jul 2024 at 06:13, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > Huh.. well I'm getting different impressions of what the problem
> > > > actually is from what I initially read versus Peter Maydell's
> > > > comments, so I don't really know what to think.
> > > >
> > > > If it's just the load then fdt32_ld() etc. already exist.  Or is it
> > > > really such a hot path that unconditionally handling unaligned
> > > > accesses isn't tenable?
> > >
> > > The specific problem here is that the code as written tries to
> > > cast a not-aligned-enough pointer to uint64_t* to do the load,
> > > which is UB.
> >
> > Ah... and I'm assuming it's the cast itself which triggers the UB, not
> > just dereferencing it.
>
> Oh it's just the cast itself that is UB? Looks like that's true.
> Interesting gcc and clang don't flag it, I guess they care about
> warning on practical breakage first.

Er, I was speaking a bit vaguely there, don't take my word for
it without going and looking at the text of the C standard.

What I *meant* was that the practical problem here is that we
really do dereference a pointer for a 64-bit load when the
pointer isn't necessarily 64-bit-aligned.

As it happens, C99 says that it is the cast that is UB:
section 6.3.2.3 para 7 says:
 "A pointer to an object or incomplete type may be converted to
  a pointer to a different object or incomplete type. If the
  resulting pointer is not correctly aligned for the pointed-to
  type, the behavior is undefined. Otherwise, when converted back
  again, the result shall compare equal to the original pointer."

Presumably this is envisaging the possibility of a pointer cast
being a destructive operation somehow, such that e.g. a uint64_t*
can only represent 64-bit-aligned values. But I bet QEMU does
a lot of casting pointers around that might fall foul of this
rule, so I'm not particularly worried about trying to clean up
that kind of thing (until/unless analysers start warning about
it, in which case we have a specific set of things to clean up).

What I care about from the point of view of this patch
is that we fix the actually-broken-on-some-real-hardware problem
of doing the load as a misaligned access. My vote would be for
"take Akihiko's patch as-is, rather than gating fixing the bug
on deciding on an improvement/change to the fdt API or our
wrappers of it".

thanks
-- PMM

