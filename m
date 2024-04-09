Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D6DCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCJy-0002Bq-23; Tue, 09 Apr 2024 10:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1ruCJu-00029R-Re
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:19:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1ruCJr-0007eI-P0
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:19:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so3796480b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1712672365; x=1713277165; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKNwH61ogJYZeuk308ZpQ6diRlo1mDu3aiO1U5w7UaQ=;
 b=a7hGt4kX7LUq/vmFAaEOd3jxkNnxx2R6qAw+pCB+jno2hdokFnGT5d9hhAIJif+oSr
 zHTHrv4l0ThRenvX+3GVtFT2Yeb849DF7UEzLINFM+H1mtKSSU+yNt4PV+H5cBSO9zyx
 B63UbXUGzlVMmYzjX7VJcGbP8kwtCx4o479ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712672365; x=1713277165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKNwH61ogJYZeuk308ZpQ6diRlo1mDu3aiO1U5w7UaQ=;
 b=lZlBMy0WdAdBsh4iEzmE4HVN6xmgvIe4s7L763OidHBTmtHsM+eJVbHmry2BssYErN
 Vb4UCkGvcicVNhSMMDFZoiUljIPO/3B8h3TXSUqmuIXDhpILKR7k4iRYxjwmxYFmfpsr
 wsc8c+mnp00C5G86lZafbPjjU6rVv+bkWoss5yCmpBjhajaX3g0IzXIfkK5Qcxm+/yw0
 /DibWdd3woylh8dcXzrm2mAnqrbiYJyzaquR+KOG3+Y6qBg1EDmxN9VBZoPjT/6ULaO5
 Bkj9eWiFysdQnWSVnUZ75e/vtwOQmIfWk0Zm5ygeEGMMfbcZpMfnK4eMzd3UW0vHTYMQ
 JaFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxZyDFZk9ayfouxQnjodIc4rBdJD/A2+2QX/B3gERZ/At0ioi9z08QXw7WDcrZIXlvdhRshooSgqFmoYjy60MzCIlF2Qo=
X-Gm-Message-State: AOJu0Yy6qUUZZNy4zCSqPj4Pu05+7gAzDA13ZzW/OcjphU+pbtTOP23q
 GI/h7X8W3xUVN96xHQM5i6kfb/cl2x4VBBd0LojLbz6z8TNbAELaHiW5EOOU++tdyP2vhEbdTaz
 4Dna790jUtVi9WKLsUc2R0l9xenc5p07YHnFW
X-Google-Smtp-Source: AGHT+IEYZXNObBVw3ngDHwROEzFvrdey38md44MZZx9KaPUyg5O0H88Zi9oOToDjnG+ra3FB9wi06t3tsYpNugg/X10=
X-Received: by 2002:a05:6a20:3241:b0:1a7:807:ca2 with SMTP id
 hm1-20020a056a20324100b001a708070ca2mr11980431pzc.29.1712672364737; Tue, 09
 Apr 2024 07:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
 <90f07634-1600-4654-8e36-7ac9e2f457e8@perard>
In-Reply-To: <90f07634-1600-4654-8e36-7ac9e2f457e8@perard>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 9 Apr 2024 15:19:12 +0100
Message-ID: <CAG7k0EqJvVZJUNaf31Jd1ZfwvOon8saNbtHofon=VvB6gpj9qw@mail.gmail.com>
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Anthony PERARD <anthony.perard@cloud.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=ross.lagerwall@cloud.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 9, 2024 at 11:20=E2=80=AFAM Anthony PERARD <anthony.perard@clou=
d.com> wrote:
>
> On Thu, Apr 04, 2024 at 03:08:33PM +0100, Ross Lagerwall wrote:
> > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > index 1627da739822..1116b3978938 100644
> > --- a/hw/xen/xen-hvm-common.c
> > +++ b/hw/xen/xen-hvm-common.c
> > @@ -521,22 +521,30 @@ static bool handle_buffered_iopage(XenIOState *st=
ate)
> [...]
> >
> >  static void handle_buffered_io(void *opaque)
> >  {
> > +    unsigned int handled;
> >      XenIOState *state =3D opaque;
> >
> > -    if (handle_buffered_iopage(state)) {
> > +    handled =3D handle_buffered_iopage(state);
> > +    if (handled >=3D IOREQ_BUFFER_SLOT_NUM) {
> > +        /* We handled a full page of ioreqs. Schedule a timer to conti=
nue
> > +         * processing while giving other stuff a chance to run.
> > +         */
>
> ./scripts/checkpatch.pl report a style issue here:
>     WARNING: Block comments use a leading /* on a separate line
>
> I can try to remember to fix that on commit.

I copied the comment style from a few lines above but I guess it was
wrong.

>
> >          timer_mod(state->buffered_io_timer,
> > -                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REA=
LTIME));
> > -    } else {
> > +                qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> > +    } else if (handled =3D=3D 0) {
>
> Just curious, why did you check for `handled =3D=3D 0` here instead of
> `handled !=3D 0`? That would have avoided to invert the last 2 cases, and
> the patch would just have introduce a new case without changing the
> order of the existing ones. But not that important I guess.
>

In general I try to use conditionals with the least amount of negation
since I think it is easier to read. I can change it if you would prefer?

Ross

