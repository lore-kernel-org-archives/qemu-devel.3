Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D050C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 17:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc6yL-0004gm-Ur; Thu, 08 Aug 2024 13:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc6yI-0004fT-W4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:30:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc6yH-0000OR-8k
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 13:30:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1963916a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723138239; x=1723743039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=06z2EHFG/U4CMz/myBEMb7YhVtDbWb9RAzFa3cQeNg4=;
 b=pvKRjDQXLVJZ+07f+IK7ZirQl1VALZFuBbeEIyS9mzEJ00eAI9h/Wv+86fp3xlBrDW
 hAIDTPxReELWi9LMTUxgvSAdDJDEcLh96OFhfz1F0uD/EcIMa12WaCKh3CAxzmNZY9dw
 mnd/iJwoiLM2mZqmuymINYv6AhVhdNaLa1cJpkkg84d5FPvOnhLrSvuKFkwGpw6p44An
 uJsLn91irGInS5DwCIJBYfPNkG6x19Wh4DrSMZ/W4WCoQ3aJJHG931hCVyEodSw9RUzA
 E5Lnxr9df2Xn2EJpJxiDbvSZgSLLvloGlRJarbOY207z4xnU2NmMpttUj8xpolH/LgQ5
 jXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723138239; x=1723743039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06z2EHFG/U4CMz/myBEMb7YhVtDbWb9RAzFa3cQeNg4=;
 b=qufXw085Rx34X2deMiJ+ijrDD7IDCYm8mz/AoO7bOV3dO3pWQ8D8UOv/kEzxm0lrmB
 N8PKh7jlnQicf5h2I9Wg4/LOaVl6YRH+0CHztDdB5f9qv1KRV9Qxxg/4gB09nwsqX2So
 TwkJx7iQTtN6EdeSRfbMyZ2urxNX5z7mUE8lqXqOX8hNPtOMTvK84RHH1VWlUUXw/UzZ
 jxJ3+F+Yu+qNjxmzMjRfioE+OBdToKlxq+VHAY8ONjdeDxkbc35OLVKPjsRrOxmGdS7+
 wsqF2AF376eDrm7VWaJGz2etFQ3IbvVbxif9b38Y+rGBpdzrF953AYZcx/wmyKW2uYmC
 kq4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9kmVzLP5pHGdgplZaeZrQTbbD47KMbFRFoGDycyWwOAXvqfmS7KlhKL+St+JqGigqLI5GSi1KsUwS5hDIrQOQAONcGFM=
X-Gm-Message-State: AOJu0YxuUkXxfjuxswV3IgTEyF0jxMimWlks8WqLMuZdL7i1l8DLXLEx
 Vs5czHLGuUKjqsE0VkcdfJ+3whj3p9jwM6ho1+Mvle+EhupZAfDKQ7U1lFPlCureXHg4Lv32HjJ
 7C36FYQFPH3a9CPHM+GApFWzRssabg92Ms2HoQg==
X-Google-Smtp-Source: AGHT+IFjzLG5AzShGU225kZShmTKC/dim2fRgOLzNjJ9yKehNDz1hi3bCn1Kybgv0Twmnacy70XutVasGPLkMd0I67E=
X-Received: by 2002:a05:6402:50c8:b0:5b9:fe2f:48e4 with SMTP id
 4fb4d7f45d1cf-5bbb3c120aamr2374409a12.6.1723138239072; Thu, 08 Aug 2024
 10:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
 <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
 <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
 <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
 <bf8d2172-ddd3-499c-a164-6b358c6496a7@redhat.com>
 <CAFEAcA_Zo-WmjMZwcecwgPAp_DOfaewV_nDx3QpCzYx7h2Kckw@mail.gmail.com>
 <841a1b53-7b43-4fb6-966b-1f9000292851@redhat.com>
In-Reply-To: <841a1b53-7b43-4fb6-966b-1f9000292851@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 18:30:26 +0100
Message-ID: <CAFEAcA_MT+WMOdDt7qkywY9ZBvMxG7aH8_ztb-mYOtQGBFMFqA@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 8 Aug 2024 at 17:29, David Hildenbrand <david@redhat.com> wrote:
>
> On 08.08.24 18:17, Peter Maydell wrote:
> > On Thu, 8 Aug 2024 at 17:04, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 08.08.24 17:56, Peter Maydell wrote:
> >>> Right, I guess that's my question -- is "WAKEUP" ever any
> >>> different from "WARM" reset? I think the latter is a more
> >>> common general concept.
> >>>
> >>> On the other hand it looks like we already have the
> >>> concept in the runstate state machine of
> >>> RUN_STATE_SUSPENDED versus RUN_STATE_RUNNING, and so if we
> >>> define "WAKEUP" as "goes from SUSPENDED to RUNNING" that's
> >>> quite a clearly defined condition.
> >>
> >> Right.
> >>
> >>> Whereas WARM reset would
> >>> be a much wider range of things and ought to include for
> >>> instance "guest triggers a reset by writing to port 92"
> >>> and all the other SHUTDOWN_CAUSE_GUEST_RESET cases.
> >>> (Side note: do we document all these runstates and transitions
> >>> anywhere?)
> >>>
> >>> For virtio-mem, on a guest-triggered reset, should it
> >>> (a) definitely not unplug all the hotplugged memory
> >>> (b) definitely unplug all the hotplugged memory
> >>> (c) we don't care?
> >>
> >> During ordinary system resets (COLD) where RAM content is not guaranteed
> >> to survive:
> >
> > "COLD" isn't an "ordinary system reset", though -- COLD
> > reset is more like "I powered the computer off and then
> > turned it on again". A "WARM" reset is like "I pressed
> > the front panel reset button, or the watchdog device
> > fired and reset the system". We don't currently really
> > model front-panel or watchdog reset properly, we assume
> > that it's close enough to have it be the same as
> > power-off-and-on reset (and there are some kludges in
> > various places where it's not quite right).
>
> Agreed, there are many flavors of resets, even different flavors of warm
> ones I'm afraid.
>
> To summarize, if a VM does an ordinary reset ("shutdown -r") we want to
> unplug all hotplugged memory. Same with most external resets we
> currently implement. In all other caes, we likely want to keep the
> memory hotplugged and RAM content alive.

OK, if we want 'shutdown -r' to unplug hotplugged memory
then that sounds like we do want a WAKEUP reset type.
(Though I'm surprised that we want that -- my expectation
would have been that the hotplugged memory should stay,
because if you do real hardware hotplug of RAM then it
doesn't all pop back out of the sockets when you press
the reset button on the front panel :-))

thanks
-- PMM

