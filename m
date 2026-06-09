Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89155CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX2UR-0004bM-JS; Tue, 09 Jun 2026 15:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wX2U7-0004XJ-1v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:51:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wX2U4-0004ws-Vs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:51:38 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68b482888c3so9489133a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781034688; cv=none;
 d=google.com; s=arc-20240605;
 b=Wv1tnKAjCM9/aLaaneaqe8MsAB8hgGvdOGNpi3AbF0Oktle+L+8yrt6xWpPgRQ0PDg
 6HpknbFCBOsViN3q6SF3IzGaCBkFVu6HoLpgnT9zSHnCUNEJYS0nePKPoIdMK/AsAKGC
 VUgAgGtf7Q2Rq/oAxOhs24qPNlyxR/C+xtCExuDpNO9vb3sJEG1nAcK6RXftBQJuwCn6
 Pld7F1NlKXlDlQ8znDyLuGTglUwSCRcgUiHdPNElmvrnVGe4TUIQIc0k07eL0n3i/5Vd
 skrRO9s42He1JT0M1AhxNgXL8OkrvwMh14e6YngrDwUdrzoO55PhvSQbTQoWkxtxxkbd
 Prvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ig0/pXZWsQZorY6D9vfQ+IHuqaMFt930bQ0floZUUb0=;
 fh=e6hk6AXIeFvRmxEi41Z/JbP32j3aIVDEj6/qG3TvFhk=;
 b=Xq1bhUmWOMEVy+9ODZEq2lMFY7MHAS99yLY2Yy5EmBsUxxEyg6g2eEgFUpDxqXqoQ6
 zA0DYMyQ8b+8ftCHRilqkI/vysuWBjh9BTVXQ4Fu6a4OyMpAwpJ4NfkBWEWRqdsba8s1
 7utL2hd51+SES4CsySFK988PqMqkU8SZ+q2+RY0IKlGTmNZry7KZ5H2ZXQsS6x4PNeXW
 9BtxujkzvEE1S/q2Vo7WWMBFhG69o9qLcUcFqOsX5o/daK6OKjlUeiNRFHPYAPSkEuvZ
 Daq5ukUxII5dprhZ4QwDeBKiDyt89c5VirNqcMKFbGlaYKJitGmD0FhYgdb3/QDzAyPX
 SKoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781034688; x=1781639488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig0/pXZWsQZorY6D9vfQ+IHuqaMFt930bQ0floZUUb0=;
 b=b1SVNHCiOVZH63s6PlQM+Z7DgqjGDQxp9gFjMeYvg6W58GOEN8qaF6CMVr9hM836D8
 D9ndhO4+mR1uvaK4v+qZdwBQ1exYybD0XvnYrglrPMQB3CatiohWDPcY+U7jin+3Dsy2
 cbhMqX15GN2lgMyrB+hp90XBk+/FBIEnvBsqjXJb5l4BEQ8CszXjt3iGj8869Y1vZxa4
 V3JOxQ088XA88kVMkkLHvm4pmmLpKQPhVH26jelWg+tq9HMHq1tJDbIWqH+7pxYzXt1k
 QxRvGmRaXxZpyvMJJkkvjwv22mtsJRk2W9CTRH8+0ZRWUZQc6UpJ/6NGbk9dVniqyFxU
 8gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781034688; x=1781639488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ig0/pXZWsQZorY6D9vfQ+IHuqaMFt930bQ0floZUUb0=;
 b=XlXOKFYSit90BUXkcOhSP/tvrCUj/oj3AFV/7kpTVgfrBobGYPPsBHwmbs9m+T1pxu
 QF1u8RqJ/7M2S4uwSXe1yFyITIkGIr2fF9bKgcxVvMFNHHWIvrsecg8O94QuPAaVcjxW
 XiV30uLfoAW7wwESKmB6GNf6d1+TRQacteEJiWZQcJg3l/UXmGV9/J7fcThb0NBLduBZ
 YiH8vV2CyOj5kXGXjh8XeFIYUzDki1rW60YhWKWGITG8npIYG596U4/48HopINCrrLiL
 q0gmllJm4+TjT8r7pw+HZJt+2BmWF3OdCOlRQ6BdoJ5zivs5NID1CSL9j3bF9yWHnlrc
 VwTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d96ifUD2ndH+6n53n6wvFthfCzK2Ts3a9wzQJDpxWmb1zYgmZ9NrDqVN0gAZLEjhpxHmbUVPu863D@nongnu.org
X-Gm-Message-State: AOJu0Yza6+VTmkdJTIELNHa4G0kYUTX1odC7q2yAE+GhV9iJpnPzMwOn
 VTIaKS9K08llarXa5hmYWd2oWSWagYGQSlqcC+4FlDeICx+0693lSPWuPKh4VwwvSNAcRJiUTYF
 H2OhdC4vLbdik6ZycgBOGXD62IkqkeOrKqSweQHzWrQ==
X-Gm-Gg: Acq92OHwzCHc2TfBQ4kmrvzrBQS3gkqtZybRdoAhCTi6wXLjkEeFgm0xJ4u6O5HyYLy
 CQ8T0samoWtNuEEyE8VdJbuXq5surxjrDIh321Tqvg+xRk6FbLUOszy2NRy52oR5sJudEDwNwJO
 AsLTEEXCFh/Tyk8CBKUwX4QOGM56sq1Ig783njENKuGgGCquSeAUYFKIMfGVlz76HOCWP8joyAe
 QaYSHVuMSvO2050wB62vUYv62sz9yV7Pzqm8MT5HpaplcBmdqUGYjzGWI6M8o3ow8oBrDLQh8xa
 jOLg7LQbHMCHEXljsL/htmWLKjf3+b0lTJk0No+x1fvilRf9t03giAjc37BAlcf5WnYNWe68a9B
 HHQ==
X-Received: by 2002:a17:907:972a:b0:bec:4799:3ee9 with SMTP id
 a640c23a62f3a-bf3a6108947mr920968466b.5.1781034688350; Tue, 09 Jun 2026
 12:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
In-Reply-To: <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 20:51:15 +0100
X-Gm-Features: AVVi8CcEu1waGAErJyoOp3SURyjh7iEDKCVBUkSkYcDBSme04cFBZFpqVgOmaY4
Message-ID: <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > blocking vhost-user spec changes when qemu.git is frozen:
> > >
> > > The simplest approach is to keep merging vhost-user.rst changes durin=
g
> > > freeze since it does not jeopardize the release or introduce
> > > instability.
> >
> > I'm not enthusiastic about having "this one document is an
> > exception to our freeze and release process". Because it is
> > only documentation, it is in the same "we can be relatively
> > relaxed about allowing in documentation changes" boat as
> > most of the rest of the docs. But docs changes can break the
> > build (e.g. if you mess up a rST syntax thing), so as we
>
> CI prevents broken rST from being merged (there are multiple jobs with
> `--enable-docs`), so I'm not sure this can happen?

We've had oddball "only with some version of Sphinx" issues
before. I agree it's not likely, which is why we're pretty
lenient about letting in docs changes. But at the point where
we get to "only really critical regression/bugfixes now",
that includes "not docs changes either".

> > get closer to the final release we are going to get more
> > strict about "is this change really necessary or can it
> > wait a few weeks?", and they must at a minimum continue to obey
> > the "no changes of any kind between the last RC and the final
> > release" rule.
>
> Why is the final release candidate special?

Because we must make no changes between it and final release.
Anything could be a cause of a regression; the week between
last RC and release is there to catch any last minute problems,
and if there are any then we would roll another RC and give
it another week (or at least a few days) for that to be
tested. We don't put in the regression fix and do the release
without that extra RC cycle.

This is the way we've run releases for the last decade;
it's not a new rule.

I tend to view the specs subsection of the docs as being
for things where either QEMU really is the authoritative
source (eg fw_cfg), or where the spec is for something that's
basically moribund and has no better home. If vhost-user is
a cross-project specification that it so active that it
cannot live within QEMU's release process, then I think
it deserves to have its own independent home.

thanks
-- PMM

