Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E06C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 13:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGb6-0005zL-JC; Fri, 12 Apr 2024 09:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvGb4-0005z6-RB
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:05:38 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvGb1-0002l4-Hv
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:05:37 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d6e23253so988640e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712927131; x=1713531931; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1MOjo/tesYJzjRcZzNY5Ac0a4FIQTuccTizRqRwbbA=;
 b=YCP97QkqbDvGJVRh1PU9N62ECievdnVzJZqhUPQ7DkA3Z1QjcGcTyVQzouXE8XZGRq
 CbYnu6kx8bN1m0fYHKftPdjF6ftguV+7jWP7AVtlz2qImp6rzLpxGyLV82RR7tjDE6Sp
 sAdW9i82s6eb9/XSZybKTHbZdE9MDahsN3JYWWW7cFGe/pVA2KPeXyUQN39pysAB5sus
 bC6jdYeud+xdvlo3FFg4uM9bSQQZ9v4KaW/fq1sX4bf5LSZuvW8IDdymouz1GSmksr6P
 T7tS2hQL113P8x6cf63hKozhGLRlR8OXHVlaqfvRj1Fhx7O/mWvWGL5UhTEFkJSL+RGf
 sP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712927131; x=1713531931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1MOjo/tesYJzjRcZzNY5Ac0a4FIQTuccTizRqRwbbA=;
 b=tSLZFoJ/BuLo2aoAb3nJxv11xdgm5ltqmzs5xUFStCA3B2jLvC1lqYS9IHhHTFVeIW
 dB44AElPmjld2zlnd0gSp8jed0R2fR1livZdrZINQVNpZznxKFEREDF/jfO+bJKObMGk
 Hbl+zA9CN79ND5tdZ2Rpgm+vmh1hKTGBBIwnU0dZXrvQOpj1QHUFgjtkP2PSdgpXRFw5
 peMiII67ZdFrmuoSOxcLY6Fphqq8AyIzkaQW9Lb3RERmcuMuMNrbee47Ewmhhao7NpHe
 +p93cS9aGKADyz7ugNGRwPv8AcasLQlQT1revGRsD+3K9NYqRnU+4EXSSw08l+8lZ2Cq
 oVxQ==
X-Gm-Message-State: AOJu0YwWGePT5LBTskt89XgrEbU5lHS2doYapfMQjxxNu8E3bpDuTdhT
 KOlY0t0gBdClujbBfp+WLFeSEZ1Fr8aDzHZ0kYxOCJQocvjHRfY3lG6v2x1VgxF1/chRnY0nHS0
 +2uPkNPHESagT7a12RGXduHU+f85IBlfYXcbg3g==
X-Google-Smtp-Source: AGHT+IHCvbLMUBQnCbRWRkVGKQ1qlf/B11KwegLOT9WrjIFQe1Rl8wsOSPrvMmCTGsnjp6afk6k7a4nodGqW3Sn9zLY=
X-Received: by 2002:a05:6512:3b97:b0:513:df6:dcd3 with SMTP id
 g23-20020a0565123b9700b005130df6dcd3mr2948751lfv.48.1712927131533; Fri, 12
 Apr 2024 06:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
 <6b384586-c7ad-4b6c-a1f1-8a8d8b0ad526@linaro.org>
In-Reply-To: <6b384586-c7ad-4b6c-a1f1-8a8d8b0ad526@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 14:05:20 +0100
Message-ID: <CAFEAcA9+LXUg_u2QFuYMbhxeqofD3iC4CGHo5WXL77QMCOYy8Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@dahe.fr>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 11 Apr 2024 at 18:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/4/24 15:43, Peter Maydell wrote:
> > On Wed, 21 Aug 2019 at 17:34, Damien Hedde <damien.hedde@greensocs.com>=
 wrote:
> >>
> >> This commit defines an interface allowing multi-phase reset. This aims
> >> to solve a problem of the actual single-phase reset (built in
> >> DeviceClass and BusClass): reset behavior is dependent on the order
> >> in which reset handlers are called. In particular doing external
> >> side-effect (like setting an qemu_irq) is problematic because receivin=
g
> >> object may not be reset yet.
> >
> > So, I wanted to drag up this ancient patch to ask a couple
> > of Resettable questions, because I'm working on adding a
> > new ResetType (the equivalent of SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
> >
> >> +/**
> >> + * ResetType:
> >> + * Types of reset.
> >> + *
> >> + * + Cold: reset resulting from a power cycle of the object.
> >> + *
> >> + * TODO: Support has to be added to handle more types. In particular,
> >> + * ResetState structure needs to be expanded.
> >> + */
> >
> > Does anybody remember what this TODO comment is about? What
> > in particular would need to be in the ResetState struct
> > to allow another type to be added?
>
> IIRC this comes from this discussion:
> https://lore.kernel.org/qemu-devel/7c193b33-8188-2cda-cbf2-fb545254458b@g=
reensocs.com/
> Updated in this patch (see after '---' description):
> https://lore.kernel.org/qemu-devel/20191018150630.31099-9-damien.hedde@gr=
eensocs.com/

Hmm, I can't see anything in there that mentions this
TODO or what we'd need more ResetState fields to handle.
I guess I'll go ahead with adding my new ResetType and ignore
this TODO, because I can't see any reason why we need to
do anything in particular for a new ResetType...

> >
> >> +typedef enum ResetType {
> >> +    RESET_TYPE_COLD,
> >> +} ResetType;
> >
> >> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
> >> +typedef void (*ResettableHoldPhase)(Object *obj);
> >> +typedef void (*ResettableExitPhase)(Object *obj);
> >
> > Was there a reason why we only pass the ResetType to the init
> > phase method, and not also to the hold and exit phases ?
> > Given that many devices don't need to implement init, it
> > seems awkward to require them to do so just to stash the
> > ResetType somewhere so they can look at it in the hold
> > or exit phase, so I was thinking about adding the argument
> > to the other two phase methods.
>
> You are right, the type should be propagated to to all phase
> handlers.

I have some patches which do this; I'll probably send them out
in a series next week once I've figured out whether they fit
better in with other patches that give the motivation.

thanks
-- PMM

