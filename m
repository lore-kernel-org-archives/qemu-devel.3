Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B989BC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WIR-0003sB-BS; Fri, 04 Sep 2026 11:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2WIP-0003rW-QV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:57:41 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2WIN-0004NF-KB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:57:41 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c4474028so14143777b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 08:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537458; cv=none;
 d=google.com; s=arc-20260327;
 b=pe+UEcRPdZXImowH1T1gb5n/1fWi/fQUDoaDSKlfA7EGU/SVpnC9ZAYX0GGwrtLVQc
 EspACri8XKYBPmqBqQnFeIhT3BokkpzJSGhQJ7ZBwZ5OwDoipEHoyCW2iJqYpJAP4C+g
 LqbqlJBJEvFfZD7NrrG3uhAYRLuZqzoKsF52hq3+Ra7aCXfHhxfxu33uMDLWUP3ON512
 iB55f9aVqILS2rBsLGZSfI0oQHlD/ktmkb1YBiG9mWXDRlwZTHbuSnB6Tbt8CM1phqfx
 KSQM/KlFLprgO/fWmkZwQTg3bZ4kd9qpNJXk2Wv64DH0lCy8IwTtcVWDgrVb+gihQTDw
 2tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9x+a9V+XCDnZNdlCUrGxrg0BtmLiYzZzQf75J3U5oJM=;
 fh=BKkZNGPK+zH/yZiyWltTc65nmzVFmE/ViI3zR+nbeU0=;
 b=jhChzSbyOM7AED1Srjw2JXj3JI3kS3NR1Y3gu3h87P1QwLEDPMmifLmtwU7Egif3tD
 fQyfMt99MAlXJbJYJGZ9D33zlJmN2fUy0dNT4LQi/Atz/lxbMyVOl06A3Ng1NMgVUMjf
 P0mduoFeWA8W547PKxyZkPA4SV4e/7PU6JmZ7fBwctgjtSV+sSeoxfAdRvy1sYVgacz1
 KCp6uKiSm/SZB8HztDm0xafY3SOB4FmX78W8P2Io1jFHth5p+bQn3jFJP8Wc/qUsI/JV
 mgVU57qJ2tH7yrR9S8+LwN1BBtUPGKifuP/CkipFSJdUqjswOJv1iVsO86zVByQoyn8V
 9dWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537458; x=1789142258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9x+a9V+XCDnZNdlCUrGxrg0BtmLiYzZzQf75J3U5oJM=;
 b=PzJbHxMU39LN7HdPo9WxAeDbpKvBIa82W855b8kHXLoBxs6HAJ3kj3gQU1Rsn272RU
 l680xt2f/o7L19Y7gWGbZupy2r3y9Fs0pCHZI5vy47P5Wuk6qV856wb7NvQ+uVHMiRaG
 HxB1leNHt6BwF/0Y6meMGuRmmOJhXrCTuRPkonG2RdGglwEwMkw1irlRLVeo+Epu+Tmw
 9ySeXzJ3PGzoq+Vaok+LAPmTkIeNaeHBGO5HdQ+JOGR4kng+nIzr4z2zQNyr1vEkbK4z
 C+Of7lXORnR9eh8ym22b03HuIYUtaVEvne3GLqbwMFGCKx0XN8rGRtsXIGo8S9qaPVYP
 s1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537458; x=1789142258;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9x+a9V+XCDnZNdlCUrGxrg0BtmLiYzZzQf75J3U5oJM=;
 b=s/tReTsBl+JQpEUWwJPwZt3mKfUj64H5Z0Z2hzPgFUP1bxlX0M5PZAAcXGEVjNjUge
 MwyS/W6cZILc5OaMxFrTn8zpq/v64kPpfFwieNeq8KB2PhfLZ2wSKpzORuuFB0XDEnQa
 4px0cPkwRTTvUrL03zqAP5zns9Ez+Xt5pv0vvHZ6g2v22FnM6VW5MVJ62tbYJwgmbJME
 /gX0O65bh84eR+YxU9jX4QrbDHBtEg/RhBvwGCfdPAg6xwLO1eph04Wd/QRStR/bhcSX
 yjRVaivXs16DxkAafy43y3VU2/EHQAxbHAvpyc1E5BoDeepjs9qs0j0NvKGS/CL/3ate
 kJ+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMQHUhLoWbEWLahz6anv1it1KtRWurdZqf1A7YAU4WOKwIgBYRwtSP/lPFw8YGAqiTqGykSE2L/B/o@nongnu.org
X-Gm-Message-State: AFuF++mIGQiPJrFKi/3iGQdu2KOMzC06XJuzxj0OypmEZFK6cEbgrd66
 0DgrpgEUNamjpQ+2+Qn6ke68y/Aviatl1W5YCFLqIW13YqnupbIga/V9SiU39W7Enj8ikg/sMLf
 0EkIDeRAv4/YhJbxEepHfYRsFCdn4Dp4R2g1sx8wBKw==
X-Gm-Gg: AYBFou3IkweJ5johSAwVKcVwv/nilu9EDvAfCfB/rrZQ04YUe6BgVBn1OLNX3m2QXF2
 0g0DWz9O7DjadaLGnm0P/oXip9i7LpvqGYYN3ZsQDH2fN0BVqtl5kESlLLc9BK7H9MOtHWd7ctK
 BWMjKwJ2D2N+7umtW+4+ce82mqrl+Sqd+cp62E4XrViD1g/Cstfogl1X4QSi2237hnOqjuy2Ihu
 2UHZWxijheaV5vcQROJ4vkiTx3Z26z8FjDHeAwOPftYAQPZKj0hPoO7SEzWdVyj7+fvWn/TIl/F
 SzSM6FYJZKtNTj8Xe8TPnhcpkI4bUyEraJI5ObLEOvu/Y+XgpuioeAU4nhvF2G0iPnj5IxpJPoH
 fAgMf8QLC3VjKYSJfXJULHAFtoSsgDhPiCT5YgwM=
X-Received: by 2002:a05:690c:f14:b0:870:107b:6359 with SMTP id
 00721157ae682-871246a70e1mr40941217b3.15.1788537457684; Fri, 04 Sep 2026
 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <18f4fdf4-1e8a-449f-a003-3bff20499a29@oss.qualcomm.com>
 <87h5k5owco.fsf@draig.linaro.org>
In-Reply-To: <87h5k5owco.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 16:57:25 +0100
X-Gm-Features: AcwNN1XE4CyLYGIF92hfZ0gbZM4pifKjPmbcheth8Ebwj6XNdKo7RICYpYMXzYg
Message-ID: <CAFEAcA-ive77P5GCVLswnz64VehJ3b8ewYK18KEs9bANSAzRQQ@mail.gmail.com>
Subject: Re: [PULL 000/105] move check-tcg into the meson build
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 4 Sept 2026 at 16:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>
> > On 4/9/26 14:44, Alex Benn=C3=83=C2=A9e wrote:
> >> The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f=
3fc7a:
> >>    Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu
> >> into staging (2026-09-03 16:43:24 +0100)
> >> are available in the Git repository at:
> >>    https://gitlab.com/stsquad/qemu.git
> >> tags/pull-11.1-check-tcg-meson-040926-1
> >> for you to fetch changes up to
> >> 26395b536c3ec0a857dffd6548d8ef49479dedad:
> >>    MAINTAINERS: add maintainer for tcg/tests meson infrastructure
> >> (2026-09-04 11:38:01 +0100)
> >> ----------------------------------------------------------------
> >> tests/tcg: conversion to meson
> >>    - remove unused variable from multiarch/memory
> >>    - standardise checking plugin output
> >>    - bump minimal meson to 1.6.0
> >>    - introduce meson plumbing for check-tcg
> >>    - return error code if docker probe fails
> >>    - add CI/self/mem test to gdbstub prot-none tests
> >>    - use raw opcode for fprcvt test in arm
> >>    - remove unused variables from gpc-test
> >>    - teach probe-gdb-support about mips
> >>    - identify or1k pc register
> >>    - port check-tcg logic to meson (all targets)
> >>    - update documentation
> >>    - add Pierrick as a maintainer for tests/tcg
> >> ----------------------------------------------------------------
> >> Pierrick Bouvier (105):
> >
> >>        tests/tcg/riscv64: add float reference files
> >>        tests/tcg/riscv64: user tests
> >>        tests/tcg/riscv64: system tests
> >
> > Some of these likely need to be updated for the latest RISCV merge:
> >
> > $ git diff --stat 99e54ab5e7a..d2843fbf802 tests/ | fgrep Makefile
> >  tests/tcg/riscv64/Makefile.softmmu-target |  14 ++++
> >
> > $ git log --oneline 99e54ab5e7a..d2843fbf802
> > tests/tcg/riscv64/Makefile.softmmu-target
> > 883a4d4da4d target/riscv: preserve vl on element-zero fault
> > bbdccc84fc3 tests/tcg/riscv64: Add tests for rv128 [ms]status
> >
> > (not sure if this can be done on top although)
>
> Merged inline, see v2:
>
>   Message-ID: <20260904150826.2331577-1-alex.bennee@linaro.org>
>   Date: Fri,  4 Sep 2026 16:08:26 +0100
>   Subject: [PULL v2 000/105] move check-tcg into the meson build
>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

Thanks; I've abandoned testing v1 and am trying v2.

-- PMM

