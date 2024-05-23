Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5DEC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6CD-0003nf-P6; Thu, 23 May 2024 07:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1sA6CA-0003mY-B3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:01:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1sA6C7-0006vR-P4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:01:14 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2bdb57f496eso896276a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1716462068; x=1717066868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91U11pUevJarFFJNYMAR2AcdGvDfJkQNRP9NpdObBVA=;
 b=sFNTd+J/T2VX2EizzoogaeEr0kwd58AowWtBSoaDRd7CuDSWpP9+iwRbAOf1io5gHd
 7PmoB8lffwYHsW68NtXYk1syir6j9yQU5jpfAI9d2dMurW2O//GTxWyAd985RWHncDKO
 Rj1wBSbl6l/R3DTYEpQV04SQ0mlzQC7NOUONc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716462068; x=1717066868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91U11pUevJarFFJNYMAR2AcdGvDfJkQNRP9NpdObBVA=;
 b=gQ1C6Xut8rWl/4WHhLVdgclVdp8i8G9a71u4k3TYyP9EvuurQA1G19KBNfEuvbQSZy
 tz7oNrCFP3x3BVEwCaxqwtyCCtUV5PduxifIp0fASi1XeC8wP9L131PU8FzIvKKUL4UP
 7lI39BL40CQa69l1E9zGutvgfSa1VDuKxj1j/OmQF62eUILO6JkNp+nqpVSvBrFZRAX2
 x0l63JgULFtMS0TS/b9HfzfsC2FrASingtk5IOIE0Dd/jAH3NMrH9PgcuO2zbHxLACIh
 VviTIZVYhKdM3XdNIMkYXK3rE+n6QF80Kecdg3rZVkx2E2SG6uxMxSoNPgXTfXU6DgNU
 aUJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw8EI6jOLKiKogUZRGjszhJZG7b1Xr8TJRxTORENbnvDyqtZeZaERFcG1y9g+qUxto2JLVlJFoWQOwJO045eak9gRMUl8=
X-Gm-Message-State: AOJu0YwTG1oF5ZqEkvvGri0Pb+7Miprt8wUbncP77iYyhly7FRAS7ZY0
 IwFOqIIy8tpGvi9Vi+wdwxnK0ZDCIfMf0Yv3LNc7XeokQyKrLR7V5DNZv0PwIbCAmhtTdeVppZe
 LRB/nVIzrWJbBW/VB5RqIrFrKyoTNIdSXeW97
X-Google-Smtp-Source: AGHT+IGvuyeyuzWjiUToY5J16n8njwnJeOg1DbjbIwk+JKoOUqhMoTuOFFBMO1x/lFU8L5/TrbpAdDsGw6w6Iw9iSQY=
X-Received: by 2002:a17:90b:1003:b0:2b3:79ad:856d with SMTP id
 98e67ed59e1d1-2bd9f5d6291mr5469546a91.48.1716462067785; Thu, 23 May 2024
 04:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
 <90f07634-1600-4654-8e36-7ac9e2f457e8@perard>
 <CAG7k0EqJvVZJUNaf31Jd1ZfwvOon8saNbtHofon=VvB6gpj9qw@mail.gmail.com>
In-Reply-To: <CAG7k0EqJvVZJUNaf31Jd1ZfwvOon8saNbtHofon=VvB6gpj9qw@mail.gmail.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Thu, 23 May 2024 12:00:56 +0100
Message-ID: <CAG7k0Eo29eoZc+vgH+uDYe=YKiHM0a3jm6hoW5j+Wyc5kEh8tg@mail.gmail.com>
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Anthony PERARD <anthony.perard@cloud.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ross.lagerwall@cloud.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Apr 9, 2024 at 3:19=E2=80=AFPM Ross Lagerwall <ross.lagerwall@citri=
x.com> wrote:
>
> On Tue, Apr 9, 2024 at 11:20=E2=80=AFAM Anthony PERARD <anthony.perard@cl=
oud.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 03:08:33PM +0100, Ross Lagerwall wrote:
> > > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > > index 1627da739822..1116b3978938 100644
> > > --- a/hw/xen/xen-hvm-common.c
> > > +++ b/hw/xen/xen-hvm-common.c
> > > @@ -521,22 +521,30 @@ static bool handle_buffered_iopage(XenIOState *=
state)
> > [...]
> > >
> > >  static void handle_buffered_io(void *opaque)
> > >  {
> > > +    unsigned int handled;
> > >      XenIOState *state =3D opaque;
> > >
> > > -    if (handle_buffered_iopage(state)) {
> > > +    handled =3D handle_buffered_iopage(state);
> > > +    if (handled >=3D IOREQ_BUFFER_SLOT_NUM) {
> > > +        /* We handled a full page of ioreqs. Schedule a timer to con=
tinue
> > > +         * processing while giving other stuff a chance to run.
> > > +         */
> >
> > ./scripts/checkpatch.pl report a style issue here:
> >     WARNING: Block comments use a leading /* on a separate line
> >
> > I can try to remember to fix that on commit.
>
> I copied the comment style from a few lines above but I guess it was
> wrong.
>
> >
> > >          timer_mod(state->buffered_io_timer,
> > > -                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_R=
EALTIME));
> > > -    } else {
> > > +                qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> > > +    } else if (handled =3D=3D 0) {
> >
> > Just curious, why did you check for `handled =3D=3D 0` here instead of
> > `handled !=3D 0`? That would have avoided to invert the last 2 cases, a=
nd
> > the patch would just have introduce a new case without changing the
> > order of the existing ones. But not that important I guess.
> >
>
> In general I try to use conditionals with the least amount of negation
> since I think it is easier to read. I can change it if you would prefer?

It looks like this hasn't been committed anywhere. Were you expecting
an updated version with the style issue fixed or has it fallen through
the cracks?

Thanks,
Ross

