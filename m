Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F620C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTiQI-0001N7-Vi; Sat, 27 Jan 2024 08:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiQH-0001MG-DW
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 08:08:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiQF-00023q-H2
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 08:08:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso24206865e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706360914; x=1706965714; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1pgZK75SOarRa2avmbbV3uXh86OWA2x/LDn9R/KXW4o=;
 b=V2gWyczwhKO1Bz+IkBVdrQlMF6A7/tQ229pCEip5224+dYlFVDndXssuFjZhPUb87G
 Z/f8v7FHUa6wDTNfGh6bRDSe1iHpDfVnbM/beHg6/l90Cn6C49DjeucRFXN2lqy5rqAp
 FuXrHFak/sVakKnDQZD2KJAM7zYonmBSDW/THnbcntU1+5tYCBFKx4yrHYMhYzSNb2R6
 NB3lG2np7sZQ6u/Mf+viyPQFTKn996PvqbJ1o9xPBpoUBjzA+2ATSHfwz+xy+Li34rA8
 el3OrxumrBAJdMaTbUH9df+viuIX/ya2AFD88LYWB1ErI1heDmJpiyYbZgeLCSxDb5/y
 Pnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706360914; x=1706965714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pgZK75SOarRa2avmbbV3uXh86OWA2x/LDn9R/KXW4o=;
 b=BvgQuJ07dTzCs1bdz4QjEPlDIn1B2bHr3yvq0z5fh0aAa8VQK3mq5THkK53g8z8Win
 MwaNZy0sgfencGhQMGG2kbH1cj2odXoBu5oxZJUvPPdped3cUkDdkVgot+YmGPFFbnAs
 Qpo5R2cWGKIFdxhUZ9aoNh1bKqVp6hSKXLwUP6QtfHNFUANEcc2jvPAUzJnIMOjfLMmC
 a6wOi+I5hbW0VnvTpBjsFwCSbBATra/TgNlToKPUzjfdPfSb/MDD/L9CTjuc1uvODDmE
 kx5QkOfktgUdr8HqbKq0ec3PQNUI0+UzkfAqh0Hzwdm9h4Kq+aha5ID5YXQRx0QsEoqp
 acYg==
X-Gm-Message-State: AOJu0YyR2V8H4e+edleIJjXt28Fl9tbpwhWvo/2wsJHrEZ4VGqiI2KEJ
 9oAZhTCaZsCAe23TiFibqghgzVrQ770ay0w6Lio+v+PBiZsuo6h3UIO50HPKODlTKXRiApNicd0
 kf8WckwEfMQ5oLi77zABDtANDbBF0ArdwSUNGBQ==
X-Google-Smtp-Source: AGHT+IGEd5/p/5CqwnAf6j4xSWV2gyBeX7CL1NOmiAF73chwVL81wQlrn3GjMgCu6qxhF5wphiCbpWxUgNHDtlsaMKY=
X-Received: by 2002:a05:6000:88d:b0:337:c39a:1fbd with SMTP id
 cs13-20020a056000088d00b00337c39a1fbdmr797511wrb.42.1706360913091; Sat, 27
 Jan 2024 05:08:33 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
 <87le8byg5f.fsf@pond.sub.org>
In-Reply-To: <87le8byg5f.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jan 2024 13:08:02 +0000
Message-ID: <CAFEAcA-kTwM2U3VE0rX-hZt-5AAVPz7Vc-WEwwqndz+Liie=3Q@mail.gmail.com>
Subject: Re: spapr watchdog vs watchdog_perform_action() / QMP
 watchdog-set-action
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

On Fri, 26 Jan 2024 at 20:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Hi; one of the "bitesized tasks" we have listed is to convert
> > watchdog timers which directly call qemu_system_reset_request() on
> > watchdog timeout to call watchdog_perform_action() instead. This
> > means they honour the QMP commands that let the user specifiy
> > the behaviour on watchdog expiry:
> > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-141
> > https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-129
> > (choices include reset, power off the system, do nothing, etc).
> >
> > There are only a few remaining watchdogs that don't use the
> > watchdog_perform_action() function. In most cases the change
> > is obvious and easy: just make them do that instead of calling
> > qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
> >
> > However, the hw/watchdog/spapr_watchdog.c case is trickier. As
> > far as I can tell from the sources, this is a watchdog set up via
> > a hypercall, and the guest makes a choice of "power off, restart,
> > or dump and restart" for its on-expiry action.
> >
> > What should this watchdog's interaction with the watchdog-set-action
> > QMP command be? If the user says "do X" and the guest says "do Y",
> > which do we do? (With the current code, we always honour what
> > the guest asks for and ignore what the user asks for.)
>
> Gut reaction: when the user says "do X", the guest should not get a say.
> But one of the values of X could be "whatever the guest says".

Mmm. Slightly awkwardly, we don't currently distinguish between
"action is reset because the user never expressed a preference"
and "action is reset because the user specifically asked for that",
but I guess in theory we could make that distinction. (Conveniently
there is no QMP action for "query current watchdog-action state",
so we don't need to worry about reflecting that distinction in the
QMP interface if we make it.)

-- PMM

