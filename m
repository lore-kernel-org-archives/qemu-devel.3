Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBA4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 11:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3CRC-0001ba-74; Mon, 29 Sep 2025 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3CR8-0001aU-JL
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:52:58 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3CQy-0008Kg-Sn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 07:52:58 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d60528734so49510367b3.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759146758; x=1759751558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KT86g09EeljO1iYP4AoLfRBmM/8hKWqdpvEgR64FzVI=;
 b=ComxmTUh+wy2r4zD1QuMngOsrZKneyAh3L/2K4GAjD3QwcYU5HoIhsUTthSLGGuii0
 UoI24zb4e4jin8bfZwK4XQGuk0ESILkGpDk8dtNXx6cfUxYUw8TTEN6U0LmacyE8VnlX
 sCAF/eEqMVrHLNXDmzKtfsmpb3muY9Wt/ukoogLa+PNkpEeFPUOZDPZn4GQzmot0aN/U
 IoZtBCW2NS7kmqSvcBaf1VbuvMAsgrLdk0vTxj47wtophEJkwYBBOWppYoPBMLpPtuHB
 Tl/KdWUdLyR7ydQ/KLLZBMs1rM/uGrpIH9jxok/QnIay3WQXMy+ln14ucPMpetDcnZM4
 +VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759146758; x=1759751558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KT86g09EeljO1iYP4AoLfRBmM/8hKWqdpvEgR64FzVI=;
 b=XaquqJGmroGpXqrRIQOoPu3HmRs5nkeYgmnvBRzGvWAbcmzKv6ZeLlnbwAWoISLIT4
 dyTl3Xnqzy2abTHvOcSeO9dB4YCO8r+Ea7XZZq3PTz4qoQJwAjxPKkQQ3Q9mPOpRzGw7
 wqk285rMwxrm4ZXZlAbb44qxIlLuiFGawI5xfapNlAcUhQ2X8Nbywqak6WPo25ZsKO5N
 kExDKWZmv6Iv5AtYh2HosNs1ecDSQGymi5FJSOQMxDs3XlwJQ8ODoLH72nqzLNu8S2iG
 zaQOp7IjFZ1jrE5VR1PcR7GqJX3axZa4be4uM9WhZgQtADznmYgrakgZsc81MvypOj0A
 sb9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq9wMFaitB9La8ciBtW+f0F2cb/fUliEwrWgQFpzZGNZayOlemZ9OzzelVpFnVKujpLU/jiHOFWgOn@nongnu.org
X-Gm-Message-State: AOJu0YzmMICYWnsNRPr2y2fOvCc+wsQ/E1Kh6qgto5j6FBTlT+ajJv6d
 rrS1n2cXRhgIHi/E6W/psanM5BW1PECktXjx1l3BwZlbpw7Ex0aC1yHv+ubn937nrN/06ZBhCfr
 sSO7Tb4NX36Am3X9Ly7qNZOqtaoMBeksbMl7B/PVCAg==
X-Gm-Gg: ASbGncsjME+6DkGoCaV/qMmsppclc7Evw14G220/XHGFfvLY5HdGK72EMe5ZkXX5Qvd
 Pr2i0RpbIaCHO8ouzUeMS6MRrgpDpRx7P92kW7bzWo7EndeFO16Fe7YBmnOckMhSAi8C8ZjsEAX
 R2RdyRofLQEPVUrrH+pdiDGSBlPTV+5f7qas+2TYnxS4VBUM5y95tovaNZe258NlkZmpzKBi91I
 cMWfXZ3D/qJ8VHgkns=
X-Google-Smtp-Source: AGHT+IEIURT99L1oakOXREk7ktif1aKXDIFJ+DTPhOqcuK4rX4eA5h7OVeuuuPRkn8KqY5yFFyyaSq7A64HQL85cqVg=
X-Received: by 2002:a05:690e:d5b:b0:628:3c00:bba9 with SMTP id
 956f58d0204a3-6361a71a3a8mr16970769d50.8.1759146758218; Mon, 29 Sep 2025
 04:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250925075630.352720-1-pbonzini@redhat.com>
 <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
 <CABgObfYauCBr7YVUvGURRy0qGS8NaeLn=r23WFuq2hhzgWmJng@mail.gmail.com>
 <aNpWqRyp0E-68z1Q@redhat.com>
In-Reply-To: <aNpWqRyp0E-68z1Q@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Sep 2025 12:52:26 +0100
X-Gm-Features: AS18NWDV34NuK-_wSEBjPmBv3X9_wvoAdnHjRHJJXpC64yD6IRUhiWUskLBSBxg
Message-ID: <CAFEAcA_N--fwWZj_KLH-OGMf9WMw9Mg6fdq+TmBg37MoT-GY0A@mail.gmail.com>
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 29 Sept 2025 at 10:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Fri, Sep 26, 2025 at 09:26:47PM +0200, Paolo Bonzini wrote:
> > On Fri, Sep 26, 2025, 16:39 Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > > I figure I'll state my personal opinion on this one. This isn't
> > > intended to be any kind of 'veto' on the question: I don't
> > > feel that strongly about it (and I don't think I ought to
> > > have a personal veto in any case).
> > >
> > > I'm not enthusiastic. The current policy is essentially
> > > "the legal risks are unclear and the project isn't willing
> > > to accept them". That's a straightforward rule to follow
> > > that doesn't require either the contributor or the reviewer
> > > or the project to make a possibly difficult judgement call on
> > > what counts as not in fact risky. As soon as we start adding
> > > exceptions then either we the project are making those
> > > judgement calls, or else we're pushing them on contributors
> > > or reviewers. I prefer the simple "'no' until the legal
> > > picture becomes less murky" rule we have currently.
> > >
> >
> > In principle I agree. I am not enthusiastic either. There are however t=
wo
> > problems in the current policy.
> >
> > First, the policy is based on a honor code; in some cases the use of AI=
 can
> > be easily spotted, but in general it's anything but trivial especially =
in
> > capable hands where, for example, code is generated by AI but commit
> > messages are not. As such, the policy cannot prevent inclusion of AI
> > generated code, it only tells you who is to blame.
>
> The policy is intentionally based on an honour code, because trust in
> contributors intention is a fundamental foundation of a well functioning
> OSS project. When projects start to view contributors as untrustworthy,
> then IME they end up with burdensome processes (often pushed by corporate
> demands), such as copyright assignment / CLA, instead of the lightweight
> DCO (self-certification, honour based) process we have today.

Mmm. I think there's a difference between:
 * we think this category of AI generated changes is
   sufficiently low-risk to the project and sufficiently
   useful to be worth awarding it an exception
and
 * we think that this category of AI generated changes
   is one we can't trust contributors not to just send
   in anyway, so we give it an exception in the hope they
   might at least tell us when they're doing it

The commit message for this patch is making the first
argument; if we really think that, that's fine, but I
don't think we should make the change with the former
argument as justification if really we're doing it
because we're worried about the second. And I'm definitely
sceptical that we should change our policy just because
we think people are going to deliberately breach it if
we do not...

thanks
-- PMM

