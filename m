Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B3C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTLc-0007wq-OU; Mon, 24 Aug 2026 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyTLY-0007vj-5a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:00:12 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyTLW-00029F-C4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:00:11 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66c70d73210so4239925d50.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787572809; cv=none;
 d=google.com; s=arc-20260327;
 b=NP1qlTs9ZlK26UDZEBCTpwF9FHppWAhY6ZyrQzLOriw16Wnnw2VmVepNdnWviPcXi7
 PgKQa6dSD62BqioeLenyxele7gE8nV51vDi9vmldFIKZPy22V3VfpX1Cwj+AN02ahE+6
 RYCoZbITqqRx7M7QJITkChbJ7N4RSh5rXVc7yBNzSn3UmtYdLgOWGcdYCee4VitlWfxP
 gxZ+hLUTRaKch4+4bMmR+5BNCsirF8VjOvBrTMGlpBGEdwzOEqVs8uAwgWXAx+ughQar
 8bWcvOJWsl4bQncWeECWWK485umRuNwE1qElU0s+eL/6GzviWSseWSHDVRcWPGS/4jnu
 YABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7xFnL5Pc40yCzfE1YJsiBq+Rb2wjSkgDgGlIyuJoJ8o=;
 fh=N0UvAA2z2rd1kSMvCxub3jEpd4bXEat/O+sAuDqq8oY=;
 b=KHzBfw6jupgA12AJ7eUsxwE33A/FV+G+nhx0cEJuCGSmB5kO6q/bGnDmZK+K/HnP+T
 VGmi0H9tR1ktUeEK0wBe5WbjQnkOPonenMkvWlcF3FG/gkF8ZQ8Gcq+j490lg13RC03z
 qLRbFy8Ytn0AxyFfOnWJ0JUW81YN1W/uNW2NNXSjp4zY2n/XXbbSS7UkSGAlqqcN64jX
 QUy778mIuZdX8VV6Wv+/sTKFq7YZIYLvFIS3YRwgwNlxUpGCyubxuE07BDPvEB5R2LQW
 XLEg0IrOzTOGaUAcYqMFXxL0f9gdUQ7Xee8OtnPgpZggaRUhDGDAqZLaqVR9Oybi3kwh
 zxKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787572809; x=1788177609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7xFnL5Pc40yCzfE1YJsiBq+Rb2wjSkgDgGlIyuJoJ8o=;
 b=iwNL6oZNtqcp30x3EdJEnOYAR+H7ahkP5tphB9XovKXYFKemrVMZebc6aNOesR7vWo
 jwfmOZwAYQ4eLpthOb2Vwgifq1tzrdEe0jqeo34rHY7RmMzOMcMe/vZaXKPvTdVVfRWQ
 LX7PGpzk0hzpiuqgxA3Zy+bZoFMmxsFw5NibGA8U3oDa4+bXcseZQhPJbTlapJhVrVmn
 lKSln9+mOI7NuZEzL7uRU7eSC2jogVUjXduwFVXxGDNvIUuP8oAlMT2w00sJCgmRQ5sK
 DNbZnC2BENkHKoal0dQPQ5bHAGNL0+4h8+/rwhsgIKZ5DYLIHr8dDMphA5yUuToqTc+4
 di7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787572809; x=1788177609;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7xFnL5Pc40yCzfE1YJsiBq+Rb2wjSkgDgGlIyuJoJ8o=;
 b=O1OwEBNwJvo29yzZqfjnaYAVAlRz6Vp1YVTtFUPKCLet3T+M63FwEj27ERZKZNYrii
 DgYBdlT7fP4tJMpNekTNL8UamDnOQ6cU64DGPTJ+tQ7DRVUrZ6I/SnBM/iNCwKPQezP2
 7NNUM4spICv5muKxZ6gSdeLkpE861gyoJ1V+E+OSyGp8rWtwz1WBjlCjAAAd52MoSq68
 GMGxdXB46oF08U3/HQBUaJr2NNcJZ4STa4cpZpGFlGn1t8lmtbjMSps851qkCPcG/aH0
 0EEkH8leDbKS4XspKFGLVv7LB4aFvom0zGUyslwTvwnVeAVuXhTTtw9830/8R8SdpyNk
 rIOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUOHXaJq2cYxlrUpwKTkzk2fTQbdE4Sm5rPjBgDrZqYeTw5UebBKwR4+6MQ7+kMNe/yjeorWOVFk3/@nongnu.org
X-Gm-Message-State: AFuF++kjRCUfWatE/IR82UArzU2Gy6nRoQwJH6PRsAKKqq+0WbMxAdk/
 bWvX992bHLqq3sW6oUNu8Kvm/TI6YxXKVb6dv1S63dmgHICyo5seJBY4xZ+s6k9Tjacz3X5rr0R
 7o58J8yl10z823+5XrU/pX1T5G0JoM4Wskzy913vY6w==
X-Gm-Gg: AR+sD10j9KKq0DcscosI92pvI7/S3PYoZLQVB6W5Tr+i5xS6nMsoxcECxZLmsA0m687
 Xb7w3U9t3Lnqd2K0BYB83AOzSw38tGmWjfRHwz8F/JNy34vfOFCjEVhPoBmv00tX4b7Bv+qLWq9
 jfJsMPVq9IXVcSh5ULPR/NpSYPkSuwOsTGhj9UjWi4tlcMi02IVgXNLxPLmDLMsm2rnfzVhJYEs
 xYYN93g8QPOm3j1coU0wLf4vsShNQ7jAwO1BGdH9cWlZqUS0bZDu4/kaFaPdlVS3JPlF7N1QhFO
 IHKEpsnU+wV1nralaB/3g2jMvbua4x/IOwE1RbhB8Ht7XXWxYZZxgIfyIzcNTJ/p3a7FxzcEXs1
 mkXpE42kHQReY3RCAsFHRL7lXQ03U
X-Received: by 2002:a05:690e:4292:10b0:66b:b123:edf7 with SMTP id
 956f58d0204a3-66cf2219b06mr4411334d50.41.1787572808554; Mon, 24 Aug 2026
 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260707110300.1918153-1-armbru@redhat.com>
 <20260707110300.1918153-36-armbru@redhat.com>
 <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
 <87o6erssjf.fsf@pond.sub.org>
 <CAFEAcA-bN5aRaZPsiZoT_zpoZkiTgUupGnCn4OaWNG_rMRw7=g@mail.gmail.com>
 <aowtji-323FFQ5AH@redhat.com>
In-Reply-To: <aowtji-323FFQ5AH@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 12:59:56 +0100
X-Gm-Features: AcwNN1XCv7-bOSGo-nHuW_0EXS-vzoi-Jk3DGn3SBk5SG1VHG2ewVYOfReZh1s0
Message-ID: <CAFEAcA8BXcc061gnSNH3Me6r=atMvBSOq47GrtMfKqZJNCZXfg@mail.gmail.com>
Subject: Re: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Krempa <pkrempa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 24 Aug 2026 at 12:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> On Mon, Aug 24, 2026 at 11:58:52AM +0100, Peter Maydell wrote:
> > Mostly I mention it because otherwise I think the typical user is
> > going to do what I did, i.e. replace "-mon" with "-object monitor-hmp"
> > and then immediately get a different error from QEMU. The warning
> > being more precise could save them a step.
>
> I was thinking that the user would do 'man qemu' where we have
> docs for "-object", for each object type including "monitor-hmp/qmp",
> which are shown taking an ID parameter.

But they only have to look at the docs because the warning message
we just printed doesn't give them enough information.

FWIW, I did try the docs: putting "monitor-hmp" into the online
HTML search produces as the top hit the "Deprecated features" subsection,
which also doesn't give enough information (and doesn't hyperlink to
anywhere else that gives more information[*]), and then a lot of
other irrelevant hits because the search seems to be word based
so it shows you everything with either "monitor" or "HMP".
At this point I gave up and started looking around in the git history.

[*] partly this is because hyperlinks into the qemu-options.hx docs
are awkward. We have syntax so you can say "SRST(something)" to get
a linkable label at the top of a section, but nothing more precisely
targeted than that. (I think that ultimately we should consider
splitting out "build manpages" and "build HTML docs" into completely
separate sphinx doc source trees and sphinx-doc runs (with build
time fiddling for where they share content), because sphinx really
really doesn't want "different docs formats are different content"
and it shows up in various places including this "it's hard to
define a label in content that's shared between manpages and HTML" one.)

> > There's an argument that the deprecation warning could look at the
> > option the user actually provided and emit the exact right new
> > option to use instead. But I don't think that's something we've
> > ever done before for deprecations.
>
> Essentially we have three distinct places with info - the deprecation
> message at runtime, the deprecated.rst docs, and the qemu.1 manual
> page. It is a trade off between how much effort we want to put into
> each area.

One of these is the one that by definition every user who needs
to update their command lines will see, though.

> For humans I anticipated they'd be mostly using -monitor / -qmp
> convenience options, with -mon mostly used by machines which are
> already familiar with -object usage already.

Mmm. I'm not quite sure why my scripts use -mon + -chardev rather
than '-monitor tcp:...'.

thanks
-- PMM

