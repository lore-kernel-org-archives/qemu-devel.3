Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A9EE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 17:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIWzB-0004kM-UI; Tue, 03 Dec 2024 12:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIWzA-0004jl-9F
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:46:56 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIWz8-0004tv-B4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:46:56 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d0bde80b4bso5682959a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733248012; x=1733852812; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rIgzebc7Ut/Z/kOC4QNifJHH66qu4x+BvNy4EkN7pA=;
 b=jZJXJo1AnSuYfYI3sKIcp7iuGQNUpp0apVdYpLTyTUfxTEQtQY/GgeeC63wn06GtvZ
 76zCd5Snij3+u0wyLZfIa0z1J8QZS796YWfLO9EKYtyAWvm4Z/jpi1SW1HyKRHF3/4jc
 zDlzjP9XEdjj3V64LmRcVkgUbTIAKRQOsrHX8l71wEWvfe2eW9ozANZHwAYxxqHYEPUh
 aDde384GS1bl08w5oRMxOwuhSMyPp4FAcUvoWzhBtzzm3e+UT5zDeo1jde7qMXMbLZPY
 yzZrPZK76B2khJ8lamfLKD/l68I471lTi/rU9+J+5TSmD9ZIS6PToxO5O+CqKo8bp2C4
 ehBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733248012; x=1733852812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rIgzebc7Ut/Z/kOC4QNifJHH66qu4x+BvNy4EkN7pA=;
 b=Sjb9j+zp3586140kLLoKsaleUvO9gRoxN0vmCe8AyRVJ1WdAZR7iLkugPL6KEgoZOb
 AYWn5FdDm2mEqI5vjBLxzGkUpmb5SxBnOznYD0hOOXRxFA89TqT0UL8OdESKs95Zs/OV
 itagHGztfHCzh1SYJdvXos3RT+zaa9YgIDnuiPsticFOEB7EAoiRwb7LSaDoRpA6Phvi
 T2Xl/rootyGMQOwH5A/uEyx0pzqoUq7LbKbq89ORKUkNbYfzovuym5d4hmAJ1kERvmet
 L68fYsB9QN5j63M61CEGg0CxiRRCU116IyJ1nyjLu5BkFS8V31mWSi8p0ExkdAYo4fEI
 9ZMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2GBDiJtOdi63hnB/b6lcvUB1eLSY5AQ5MWrlWyWUiKnGiCCuWRTpRr1Odj2ftjf0vYK/kz+APmEy+@nongnu.org
X-Gm-Message-State: AOJu0YxzlE0jJVZPvfF7A7sl/xA36TPS0UNRRxMEqYbyST27WoJFnx8A
 VEYs27lvAFDLpaWfjEBgtpUm0j4bnll0rbFlu22yPkBIlm0H/nB7x1wKsbSicWj00VFkLNjww6i
 wsK+U9zeKt3RhHQsZgNJliuIQl7ZV3JsSt25NVQ==
X-Gm-Gg: ASbGncszCKORT5woWB9JXftIMr95x2kRDxqtELyiHGLZiYnd9e0tmawpO9RQHC7QzIt
 1R8qm9++Kob5nm4NzY695AF1L8cVFfXqm
X-Google-Smtp-Source: AGHT+IEn6BDoT6C1oeYvB9vs7b3ZLGw5e/k6Wnc9bxvUP5fvHSXE01jTBFQtKS7wkaZc4D1BHtAMXXurj6JzzGoo4Ww=
X-Received: by 2002:a05:6402:3506:b0:5d0:d2ba:bf33 with SMTP id
 4fb4d7f45d1cf-5d10cb5cc9dmr3646909a12.19.1733248012345; Tue, 03 Dec 2024
 09:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
 <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
 <87zflcbs0l.fsf@draig.linaro.org>
In-Reply-To: <87zflcbs0l.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 17:46:41 +0000
Message-ID: <CAFEAcA_Mmf0fH8biPaZz9c1bw6UdmEvVWhdjUduzPTqH4njnhQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] docs: add a codebase section
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 3 Dec 2024 at 17:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> Present the various parts of QEMU and organization of codebase.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >
> > I like this; it's something I've thought for a while would
> > be good to have, but which I never got round to trying to
> > put together. Thanks for doing this!
> >
> > Mostly my comments below are spelling/typo nits and
> > other minor stuff.
> >
> >> ---
> >>  docs/about/emulation.rst               |   2 +
> >>  docs/codebase/index.rst                | 211 ++++++++++++++++++++++++=
+
> >>  docs/devel/decodetree.rst              |   2 +
> >>  docs/devel/ebpf_rss.rst                |   2 +
> >>  docs/devel/index-internals.rst         |   2 +
> >>  docs/devel/migration/main.rst          |   2 +
> >>  docs/devel/qapi-code-gen.rst           |   1 +
> >>  docs/devel/testing/main.rst            |   9 +-
> >>  docs/devel/testing/qtest.rst           |   2 +
> >>  docs/index.rst                         |   3 +
> >>  docs/interop/qemu-ga.rst               |   2 +
> >>  docs/system/qemu-block-drivers.rst.inc |   2 +
> >>  docs/tools/qemu-storage-daemon.rst     |   2 +
> >>  docs/user/main.rst                     |   6 +
> >>  14 files changed, 247 insertions(+), 1 deletion(-)
> >>  create mode 100644 docs/codebase/index.rst
> >>
> <snip>
> >> +  Block devices and `image formats<disk images>` implementation.
> >> +* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-u=
ser>`_:
> >> +  `BSD User mode<bsd-user-mode>`.
> >> +* build: Where the code built goes!
> >
> > The built code doesn't have to be in 'build'. We could say:
> >
> >  * build: You can tell the QEMU build system to put the built code
> >    anywhere you like. By default it will go into a directory named
> >    ``build``. Sometimes documentation will assume this default
> >    for convenience when describing command lines; you can always
> >    replace it with the path to your build tree.
> >
> > ?
>
> I always recommend creating a builds directory and having multiple build
> trees under it:

Indeed, that's what I like to do too, but I don't think this
document is the right place to make that kind of recommendation.

-- PMM

