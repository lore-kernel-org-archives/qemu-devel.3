Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC82CE7AFD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 09:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVeR-0003co-Si; Fri, 06 Sep 2024 05:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smVeP-0003bW-Pl
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:53:09 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smVeN-0007xF-Iy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:53:09 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f50966c478so20382341fa.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725616385; x=1726221185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45UsHCmEIrmow2+eba/n9N2V/RM7GtjWHVVzWNQ9rAg=;
 b=DDJw9CpwATYeImjKuxIpm3T5ltfkpfU1gfQfGkYRpoghXwLjsb1JUjU8sNXi39FdZ0
 lCUDDdBxNPpIi3HMnpsnR2PAOa9coLTIOO+HIQUkyMoRHE5d0saR7I5YaN7EVtewmz9A
 nh3G+hBktnkiJXly6vn3F2Bek3SeEBN2I0gar7IX7mwDE+I8UH7mIJ3oO/9X7HRL+Ch4
 LJNZxWN5Ua53eMRpJ4xhJwAeawSmDjyc5WFKjmP+aayroKZ3BdpWszCSA+8d6uOnMCC3
 3rVBzATgp+35njZMrKQ5tMHbr1nS1yE5DflgSpR9ov10hAMPRaTxUnDpauXPnN63qfEI
 emaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725616385; x=1726221185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45UsHCmEIrmow2+eba/n9N2V/RM7GtjWHVVzWNQ9rAg=;
 b=GOGwpV4god5tjy8k1Id33Yz25zBhFFGVkpWSmgh7qQPM/9fzPq2C8DwgYwMds9xbu+
 dtDI5NSBPyrtUf00NdbH4rLvtNOmNj2ea/h6mzpeO0svTHfL4FzqTooWXFuf6JvsEvAz
 tADDE93zG2kpSh/kABQqhwm7mMMzVfa6hd+EafnPXp/edVZAaIlTz2j2S1T7KJK0FI4A
 xO9Ynzqf++IdpwcHiqvfQjQat41hGwq7S7X8INu3SKrZpJh6vAnSQmc4bAxtuk7Ose4J
 pa44EyARTNuTZiLkOTsx8xOcjerYxYOf5XlVny/9nzM+wK21wiPl1fiyHCIqH/ML2w1/
 JnVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9I1zktgTt1XOHnmpYLy0hx/nqZ1bEdA6wY1v9x6UWpe1nPT4LyORiK3P96JdE7rYVOX5lUZxOaXGU@nongnu.org
X-Gm-Message-State: AOJu0YyKDzbM0MBoe3mNbrqFOijTE+EFAgQtrTy9EA5MM+vS6cVQpKoY
 1gClJF4zvXUo5LrkA92v84OqpnEKf/tTzT7I+Nh8X31iUjqdCZLz71C2cFDjNrLfwyRpw6SORn9
 IUU2eHzUv/ucm7TLgp2SoHbIWjXwOs1+FLyv7a6rcXS4Kn7eZ
X-Google-Smtp-Source: AGHT+IHym2a37pPFDcQ5ggqTKVvXDkIJ0/uAHq/L6UYE7IK6jow51UQPqPGyhUey6gTyJaMSKKkfgDyyLCi1o4QQHP8=
X-Received: by 2002:a05:651c:1504:b0:2f7:52c5:b33 with SMTP id
 38308e7fff4ca-2f752c50c86mr10968091fa.39.1725616385011; Fri, 06 Sep 2024
 02:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
In-Reply-To: <Ztq5068xW640qeuD@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 10:52:53 +0100
Message-ID: <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 6 Sept 2024 at 09:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
> > On 05/09/2024 23.03, Fabiano Rosas wrote:
> > > Hi,
> > >
> > > This series silences QEMU stderr unless the QTEST_LOG variable is set
> > > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
> > > flag is passed.
> > >
> > > This was motivated by Peter Maydell's ask to suppress deprecation
> > > warn_report messages from the migration-tests and by my own
> > > frustration over noisy output from qtest.

This isn't what I want, though -- what I want is that a
qtest run should not print "warning:" messages for things
that we expect to happen when we run that test. I *do* want
warnings for things that we do not expect to happen when
we run the test.

> > Not sure whether we want to ignore stderr by default... we might also m=
iss
> > important warnings or error messages that way...?
>
> I would prefer if our tests were quiet by default, and just printed
> clear pass/fail notices without extraneous fluff. Having an opt-in
> to see full messages from stderr feels good enough for debugging cases
> where you need more info from a particular test.

I find it is not uncommon that something fails and
you don't necessarily have the option to re-run it with
the "give me the error message this time" flag turn on.
CI is just the most obvious example; other kinds of
intermittent failure can be similar.

> Probably we should set verbose mode in CI though, since it is tedious
> to re-run CI on failure to gather more info
>
> > If you just want to suppress one certain warning, I think it's maybe be=
st to
> > fence it with "if (!qtest_enabled()) { ... }" on the QEMU side - at lea=
st
> > that's what we did in similar cases a couple of times, IIRC.
>
> We're got a surprisingly large mumber of if(qtest_enabled()) conditions
> in the code. I can't help feeling this is a bad idea in the long term,
> as its making us take different codepaths when testing from production.

What I want from CI and from tests in general:
 * if something fails, I want all the information
 * if something unexpected happens I want the warning even
   if the test passes (this is why I grep the logs for
   "warning:" in the first place -- it is to catch the case
   of "something went wrong but it didn't result in QEMU or
   the test case exiting with a failure status")
 * if something is expected, it should be silent

That means there's a class of messages where we want to warn
the user that they're doing something that might not be what
they intended or which is deprecated and will go away soon,
but where we do not want to "warn" in the test logging because
the test is deliberately setting up that oddball corner case.

It might be useful to have a look at where we're using
if (qtest_enabled()) to see if we can make some subcategories
avoid the explicit if(), e.g. by having a warn_deprecated(...)
and hide the "don't print if qtest" inside the function.

Some categories as a starter:
 * some board models will error-and-exit if the user
   didn't provide any guest code (eg no -kernel option),
   like hw/m68k/an5206.c. When we're running with the
   qtest accelerator it's fine and expected that there's
   no guest code loaded because we'll never run any guest code
 * in some places (eg target/arm/cpu.c) we treat qtest as
   another accelerator type, so we might say
   if (tcg_enabled() || qtest_enabled()) to mean "not
   hvf or kvm"
 * sometimes we print a deprecation message only if
   not qtest, eg hw/core/numa.c or hw/core/machine.c
 * the clock related code needs to be qtest aware because
   under qtest it's the qtest protocol that advances the
   clock
 * sometimes we warn about possible user error if not
   qtest, eg hw/ppc/pnv.c or target/mips/cpu.c

thanks
-- PMM

