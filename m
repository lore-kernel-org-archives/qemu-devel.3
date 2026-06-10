Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E51CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXIbK-0003Do-Bz; Wed, 10 Jun 2026 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXIbG-0003CY-Pd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:04:07 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wXIbD-0001Me-5x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 09:04:06 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-137dd3af345so6252164c88.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 06:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096638; cv=none;
 d=google.com; s=arc-20240605;
 b=J5KFJz/NJPh9eFTnrVJtVDcSX+GLjyoXMqrEyuCubsoddQ9uUJIbvRZIti/e882RBl
 sNB7t4ygSBD18oFUCXHZTBUkwhvZ4ZtUWr5T6vQldglPmR7++sPKpyieJ4BkpHMfxXBz
 VW7Qo3nkptj6nfLcDv7nSLCUnTNEw0dK1EUxXuiTfDNP6n5qwvrGDSLpx2TTqTAwslwe
 0tK3tfK2m+8jKo7TaZ5YhjGCS6m+84LJUULu9vVxRp9fTaDg/55wWSDxAIlQjV7JyLWg
 5VFFkUKDTvPTHcFrBAc8py4a94pgfRc8fr9kQafLfEeFmBkV3nkGvDGdS0MjDBXx80DU
 5Udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DGy7NJFxbEuGnZDoYMTZb09JgAqydwha4NlrmYKOvUs=;
 fh=Stjjlb+8LpyaWW/wTD/79VzzZEi6C5FXUuNfOPKIVYw=;
 b=YPAwhHWjDXn8ulnUNlPfDR7ISZ79IWgeYbOUfZQxrITlyJ/eXo4d+yxr/YtV1gmBhm
 obwMLva0j59AQCUrEYZ3Lyxad2yAWllPyEsw8ZmqBGYEKaXukBFmn9kPfE0aEK1Gy73Z
 sqR3/Irb20aOruYOVNjT32LUogIg7a/dHPXXkYjgT7X6R7/ycJiWqW/9RHqGgH4a6DpK
 BEvBHRrE3dG4RF3GleizOfgplN5eztPKor0gZQJX4i8IkMlm9XWlP7lRQ6eHyxroOQRP
 3Z3GqlnpedUza+nIANlqmlKlATfnb/CwkpXAGNsWUyk6TXGPUZHYMf1Eiun0aiLVIvie
 pe+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781096638; x=1781701438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGy7NJFxbEuGnZDoYMTZb09JgAqydwha4NlrmYKOvUs=;
 b=fhFHM1U+RPaA8lpdzXkTa01zT/H5TLh4ABkdxI+SbXBEvOeVwM3wxD6ITeHNYI0FWM
 y+zSBnUHJMpSU1ay7Ql/VKiBx+VeLMk1dl0H/bcZzJvvzM/dJ5LbPOkvMJD3+tTyWy5D
 kEO74SXwU3OgVEsIjAGXY8vrLC4JFE4lf4ZGfXd7NILyrzncl4gjf91ngU4pEzIvoHB5
 9cfDLM8hz8DMBYdF1s0Td7NdC9Ay0gfsn/A/D9f4gqTiNstSoieXEAiTM9cUrjyHhJdJ
 0MWmCPJrERJ9rrypxUKCK81Z0vpvDgV/rUcqlCWjMVFJ9oFJ1DLb/9eJoh+Py+/jD9c0
 huZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781096638; x=1781701438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DGy7NJFxbEuGnZDoYMTZb09JgAqydwha4NlrmYKOvUs=;
 b=N6zYHJx8bKAsfKMhqd7G3Vckfi/c/qhFuWqfMW7btV0G0Qro09O0wY77CcGajY3DO4
 5WntyTley3pbuv++uC4ATS+VVFiOt6WwjJ5CkXNckeSGGE2F/KCmjXpXIJ7V2BaneP34
 MlNhKbSEPLDoNY5bGAFYKvKSRvJkbrvk+AK7/TMAmPdIFQwNvpNAQ+Mblp9PN9g1rM+0
 T1MA0sEbLWYWzb9l4JXb18VjgUyqyiAUTfmQJqfVPEh8nFJHYuBOGsDUtePgi2/pwaQ4
 twqgvgqD6wxx5XPt0BxbkGJZ6sfaE26c9pyJn+f7hWvSR/nBxpy3jIJJexMDBLF9Lomz
 Ac2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HWGY8yCtaJ2qlAU3W4rbYr5g9nT16Azz75sSL5bg1n+EYURW8cfIqgVwXFAHW6CCEAUdFSRQXSg44@nongnu.org
X-Gm-Message-State: AOJu0YxS5ilOe7o012IMl/3Ufvm+moazbu4AkDzFrne0GPUzdoPaM0kD
 cPqpvUxa0ilc3m23aP4eNj3rSSXQGUCoEjqZNW1PCsD2ykCVoXGQ88ie/MwLetCr/GQeVAXHpv3
 OuCBt+kkvv86GG6HudhBBRlpHuiOLC+M=
X-Gm-Gg: Acq92OFELTxcY8gWGZBbP5usjHY/iVoxH1dzUDCtQIgOHd/EAI1/XoWYN8sKZqdKCLf
 noXrIQdkJQGBHmuNN7Kln5uRVtNoIaeVaPYoq42ododO4vMNys0T6Ajsv17+REdPRpI5v/1KT0c
 SkOJlTk7y86ybtgCBGMKQWVmqGh3e7XC94KS6Ah2OVXhaqIRu9uSZryQQm6faMkwpcGKuDfhNOx
 hm+eDSIAT7DC8FCjgmj9ewJM+9KvynuUk2BQsVWFhgogTSlmjAtHmYetzMVGnLZgsa9JZjA+zzF
 AOFMyQ1EP86dt0/0/qUuSdmZyDFCfSvVCWb2eKmSAAlyRBjkPra2
X-Received: by 2002:a05:7022:ef18:b0:137:567:14c4 with SMTP id
 a92af1059eb24-1380670b670mr11670808c88.29.1781096636142; Wed, 10 Jun 2026
 06:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <20260609163536-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260609163536-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Jun 2026 09:03:39 -0400
X-Gm-Features: AVVi8CduYNpJsNy_uMDzca7Ymgvafjv4X8VRS9VZcL9CLY1zOakFMSLJ5YH2p9A
Message-ID: <CAJSP0QWP5OnSaed4xD0FomwVSs1mN7e_U2jaM9KPFEy2bWPrVQ@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=stefanha@gmail.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jun 9, 2026 at 4:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jun 09, 2026 at 03:44:49PM -0400, Stefan Hajnoczi wrote:
> > On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > >
> > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > >
> > > > The simplest approach is to keep merging vhost-user.rst changes dur=
ing
> > > > freeze since it does not jeopardize the release or introduce
> > > > instability.
> > >
> > > I'm not enthusiastic about having "this one document is an
> > > exception to our freeze and release process". Because it is
> > > only documentation, it is in the same "we can be relatively
> > > relaxed about allowing in documentation changes" boat as
> > > most of the rest of the docs. But docs changes can break the
> > > build (e.g. if you mess up a rST syntax thing), so as we
> >
> > CI prevents broken rST from being merged (there are multiple jobs with
> > `--enable-docs`), so I'm not sure this can happen?
> >
> > > get closer to the final release we are going to get more
> > > strict about "is this change really necessary or can it
> > > wait a few weeks?", and they must at a minimum continue to obey
> > > the "no changes of any kind between the last RC and the final
> > > release" rule.
> >
> > Why is the final release candidate special?
> >
> > > And definitely if a patchseries has both
> > > QEMU code changes and documentation updates then that is
> > > going to not get applied during freeze if the code changes
> > > don't follow the freeze rules.
> >
> > I agree that code changes cannot be merged.
> >
> > As long as the vhost-user maintainer is confident that the spec change
> > is implementable and stable, they can merge the spec change on its own
> > without code changes. If they are not confident, then the spec change
> > isn't ready to be merged yet.
> >
> > Stefan
>
> I personally have been confidently wrong enough times. Maybe others know
> how to do better.

There is a risk with merging a spec change without a finished
implementation, so no one can get it right every time.

I bring this up because a clear guideline would help implementers know
what to expect.

Stefan

