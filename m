Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5V5-00051N-Qh; Thu, 08 Aug 2024 11:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5V2-0004yw-9r
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:56:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5Uz-0001K1-W9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:56:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa7bso1332651a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723132580; x=1723737380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P02hG9lShVCLksrVZQ2xSltVeDwuK1FmUQcIgYK3rSI=;
 b=WoKOJQbFp9QTF50ndyETXMPL0vxFEPuOe7sye3FCPqexL9S3wwRxdLTJgRe14W11/G
 6cex9FOBFVh+eTunnCFNvbqMfzogvlykmQONzSqsN/nKCrntsaZyr7lUw/wCoi/Yj5Md
 m87xPVPEZP4YyJDnOq4NIajDdIIpH2OhxB+3MArJ7bFzMoVec3qsFG1L6F0vfu2MvTcp
 7Zl/w4dwC2niapWSLuYYCj6cwRVlKFyQYMUkHcSD7IrqacY+udOx5e7DnqUkuV9Eydcx
 XcVDYP/BMnVLO3LkV/dWX+wPz6q+Er3/zKJLYT0+TmD1c2tYJXaytb912RovPpvpmETz
 5C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723132580; x=1723737380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P02hG9lShVCLksrVZQ2xSltVeDwuK1FmUQcIgYK3rSI=;
 b=oLZVWV7kenJcx7p1WEnml8oAbnQMbWpct3arC9IGc+YZi44Bfq1OEW9eNgO8kYXX8f
 kmp8jzvmoicdzG+8ICmJrmDksxaWd4JYnTEOulLvzTksbhtb1C9nk3HZN2B1nI8fety0
 pY9JZ6aPcvifn680DMIn1rGQbLAuSz1EiENCFEjq3gsRufuNx6mEBeTdL1lxV8UWsAjV
 2fV3NXkC+3IGrcNrFQujH2TcCI7+jghJQLomKBRPRJ8CdU8d2B56J60aLuq409a1T+js
 8EuUzJP45TCq+/2MDhr8Gf4NLoRAW0JI8Aqzo/RRO48omEHpSGwtfEsr1Mswzm8c1rsc
 sUWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiZri22vZ/LC9ffqF1mwbq96bcKkZUym9AjvJmX7HO3FHA06QWXRcl35GksQIzKRBWnoqcgndekE1I@nongnu.org
X-Gm-Message-State: AOJu0Yz2ssPK5o5buOJebOFf2YnHZrCJDgRoN37vhLCqmF6izleyp2S0
 rAL2r6Fl8X0z8RUlMmK7P9vS6aVeV0c+dzyhWIbekM7GqPlgjhYl5GK7wOXm7JmSmW/AKQmb/+C
 n3uIulJ///ZfZejRBe580kZ6BrfU220T9jmeOaYotHSUaV/AO
X-Google-Smtp-Source: AGHT+IFlwIpJqbSqql64yxBxDc2JYhDev/fJlM+3nW8yFvguPvbmlim9+rvzDtc4rFDDF7UqqF2k6DyD79Vo8aQAoS8=
X-Received: by 2002:a05:6402:1d4f:b0:5bb:9afd:8d05 with SMTP id
 4fb4d7f45d1cf-5bbb23f70b1mr1801323a12.24.1723132579990; Thu, 08 Aug 2024
 08:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
 <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
 <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
In-Reply-To: <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 16:56:09 +0100
Message-ID: <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 8 Aug 2024 at 16:31, David Hildenbrand <david@redhat.com> wrote:
>
> On 08.08.24 17:28, Juraj Marcin wrote:
> > On Thu, Aug 8, 2024 at 2:18=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >>
> >> On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
> >>> +``RESET_TYPE_WAKEUP``
> >>> +  This type is used when the machine is woken up from a suspended st=
ate (deep
> >>> +  sleep, suspend-to-ram). Devices that must not be reset to their in=
itial state
> >>> +  after wake-up (for example virtio-mem) can use this state to diffe=
rentiate
> >>> +  cold start from wake-up can use this state to differentiate cold s=
tart from
> >>> +  wake-up.
> >>
> >> I feel like this needs more clarity about what this is, since
> >> as a reset type it's a general behaviour, not a machine
> >> specific one. What exactly is "wakeup" and when does it happen?
> >> How does it differ from what you might call a "warm" reset,
> >> where the user pressed the front-panel reset button?
> >> Why is virtio-mem in particular interesting here?
> >
> > Thank you for the feedback!
> >
> > I have rewritten the paragraph:
> >
> > This type is called for a reset when the system is being woken up from
> > a suspended state using the ``qemu_system_wakeup()`` function. If the
> > machine type needs to reset in its ``MachineClass::wakeup()`` method,
> > this reset type should be used so that devices can differentiate
> > system wake-up from other reset types. For example, a virtio-mem
> > device must not unplug its memory during wake-up, as that would clear
> > the guest RAM.
> >
> > Is it clearer? Thank you!
>
> Conceptually, if we want to avoid the "WAKEUP" terminology here, maybe
> we should consider talking about a WARM reset -- in contrast to a COLD on=
e?
>
> During a WARM reset, memory content is supposed to stay untouched, which
> is what we effectively want to achieve with virtio-mem.

Right, I guess that's my question -- is "WAKEUP" ever any
different from "WARM" reset? I think the latter is a more
common general concept.

On the other hand it looks like we already have the
concept in the runstate state machine of
RUN_STATE_SUSPENDED versus RUN_STATE_RUNNING, and so if we
define "WAKEUP" as "goes from SUSPENDED to RUNNING" that's
quite a clearly defined condition. Whereas WARM reset would
be a much wider range of things and ought to include for
instance "guest triggers a reset by writing to port 92"
and all the other SHUTDOWN_CAUSE_GUEST_RESET cases.
(Side note: do we document all these runstates and transitions
anywhere?)

For virtio-mem, on a guest-triggered reset, should it
(a) definitely not unplug all the hotplugged memory
(b) definitely unplug all the hotplugged memory
(c) we don't care?

If (a) then that seems to push towards calling all these
cases of a "warm" reset; if (b) then that would be a
reason to make "warm" and "wakeup" different.

thanks
-- PMM

