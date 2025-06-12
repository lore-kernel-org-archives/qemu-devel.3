Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1143C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdmW-0000mr-SP; Thu, 12 Jun 2025 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPdmP-0000mb-HI
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:59:27 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPdmN-0008IV-RW
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:59:25 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e447507a0so4659177b3.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749718762; x=1750323562; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOH4TOPKfXVTtEum4vcNxqUxilqMWr/Vjh2CfFpD4p4=;
 b=l67PgzAdCXDZqVdJxuY9cTElzEcoUn7NnKn+CQRSH790XT2+keijmkZ/i29NBrpqf2
 CPuhAvLy/bUq6Qomu4R9XIr890bZjcMyVq6CFh0GL7tZJ+s1Aa7PfrlHQ3/POWAdx6dq
 W+NfpSZeBp//tzDYaZCe9RY5tJqe7VzoxfoC9sqLdQWEMG/dVWvuxSvw1D6G8gFW/0s0
 CeDmWC3SgosRE7QTigoxGddfU9ozJZta/WU+AoBEiQE33PP7b/g4wFZVKfen4c/mo80T
 HcbIOuX4vNDMgvcBp274F9gIC1aQrEPfPFWfDN6KYyt0V3MitM5GXNQ6qrDzdWRbKGC8
 4hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749718762; x=1750323562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOH4TOPKfXVTtEum4vcNxqUxilqMWr/Vjh2CfFpD4p4=;
 b=dD+PX+AX9oi7X6KbVqQAAj3HvJAADLDKcYdloUWFoqHoqFJNegyXB1xVyNeMajF1Ph
 wHZbP1viRi2KCv/nablb7jMX0msB59yVyg6L0GGwSgFtT8evaoGZ4WCpbOxXwPPOL6hA
 d0JIP8FojSK/giuJjZMGhuOHRGIqSX1vKRbWJ+H7anX6WgYXUF7pMGyhrgSkNp9I2wZ9
 cganGw/Rp8ISk5HN+7SuMqGZPkCxv8sXIlZ450D5fzF7WsUQQoOFzXL4GRkGwYYH/Wnl
 4FUgEWeKS2zayu9yywippESSv3Lv6hc/lgVxjwhqQ7IFAivlGQ4EYa39ZRcA/3OZoR4r
 TwbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlt09litQlXdrjlCZWZm4xy2EWus1vnInJ4HWcfa2d7Zh1W2gB4lJPbQ0Gh5xdPDZHtElfNI9g0gbl@nongnu.org
X-Gm-Message-State: AOJu0Yy1P2cCNANCqSEL5HHXsZ2PSShl4lbJJgYW8jUyeWvO8KCf2dK+
 iiWlSHgPnFz1CLLKDqPQ+Y30tAZZkgPobjYoKSDyLAy5hIdlLWbF1x6HnafEvBAVjmVO4071l+w
 cRGge6MwmrQU2b7aDPBuyntwkM2cQgI0pOQWHGgy/Yw==
X-Gm-Gg: ASbGncsnCQKNpu82EAv6dMozTKHBmG68nN2hMVfLucPdMa1tWH4l8anpdxs72qIy2Ie
 Zi9q6XWJ0ADX3ORfKda5QVKg/IHyb/Wxz5I4H6+2FlZfL+c+lszjkYPREgAhXBcvw0ifnBhb6eB
 QFRDL50jtIxZLD/NjkTQV+KiYdZZm87DiAzGD22Djshk22
X-Google-Smtp-Source: AGHT+IHE/y8PR2bSWQkpeBdjykvQj6Er7X2jjQT1pUgLSP427cYx3+3qdjUxwK8mMRn/DhX8Rek4iQDr3NF9TU54b+M=
X-Received: by 2002:a05:690c:680d:b0:70e:1bd8:a9c8 with SMTP id
 00721157ae682-7114ed6aa60mr39561017b3.23.1749718761960; Thu, 12 Jun 2025
 01:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250611182902.201331-1-stefanha@redhat.com>
 <20250611182902.201331-2-stefanha@redhat.com>
 <alpine.LMD.2.03.2506112113260.22610@eik.bme.hu>
 <CAJSP0QVWQLK+5Z4DiNVDaz2-YtUUDYRj+roq9rwRS8ZVWYMKBg@mail.gmail.com>
In-Reply-To: <CAJSP0QVWQLK+5Z4DiNVDaz2-YtUUDYRj+roq9rwRS8ZVWYMKBg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 09:59:10 +0100
X-Gm-Features: AX0GCFtGhA8rOG7O6c-9vu0CHs1olgpXspjqdRJI8rhzNiQbhNsNvbl_TP75Oas
Message-ID: <CAFEAcA-GjJ0o37nwNX0+oLJPRUACEbW2KVi1N63fC0Etc1q0kw@mail.gmail.com>
Subject: Re: [PULL 1/1] meson: fix Windows build
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Mads Ynddal <mads@ynddal.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 oltolm <oleg.tolmatcev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 11 Jun 2025 at 20:55, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
> >
> > On Wed, 11 Jun 2025, Stefan Hajnoczi wrote:
> > > From: oltolm <oleg.tolmatcev@gmail.com>
> > >
> > > Sorry, I forgot to cc the maintainers.
> >
> > Do we want comments like this end up in git log? This could have been
> > fixed before a pull. Also the other pull request about uninitialised st=
ack
> > variables had hw/audio/gus twice which was pointed out by a comment bef=
ore
> > the pull that one of those should be different but the pull request sti=
ll
> > had this error. Did you miss these or aren't these important enough to =
fix
> > before getting in git log forever or there is just no easy way to fix u=
p
> > commit messages in pull requests?
>
> If another reviewer asks for the author to resend then I'll hold off
> on merging, but I didn't see the comment about hw/audio/gus. Sorry!
>
> I did see this "Sorry, I forgot to cc the maintainers" comment.
> Although I'm not consistent, nowadays I generally do not fix these
> issues when merging, provided it's a small issue that can be ignored
> or understood from the context.
>
> I don't really mind either way, so if there is a consensus that all
> maintainers should be strict about this, I'm happy to join.

Personally when I'm accumulating patches as a maintainer I do
fix up this kind of commit message. It's generally from a first
time contributor, so the commit needs closer attention anyway,
and I favour just fixing "this isn't quite the way we usually
do things" problems at my end, rather than asking the submitter to
resend. I also fix nits from longer term contributors where it's
faster to do that than to ask for a respin.

In this specific case I'd probably re-cast the commit message
entirely, because the first-person past-tense phrasing is not
our standard commit log style. I would also want to add something
clarifying exactly what we're fixing (clearly "the Windows build"
generally was not broken, or we'd have seen it in CI, so this
is fixing a more niche build environment setup, and it's worth
having the commit message be clear about what that setup is).

> One related point I do have a strong opinion on is that the
> qemu.git/master maintainer shouldn't be expected to do fixups on a
> pull request they receive. Fixups should be done by subsystem
> maintainers (and the pull request must be resent) or the original
> patch authors. It doesn't scale when the qemu.git/master maintainer
> has to make changes to code that they are unfamiliar with. That's not
> the case here, but I just wanted to mention it because from time to
> time someone requests this.

Fixing up a pullreq is also basically not possible -- the
pullreq is signed and you can't change the commits in it.
I don't recommend throwing random fixes (as opposed to
genuine simple merge conflict fixes) into the merge commit.

thanks
-- PMM

