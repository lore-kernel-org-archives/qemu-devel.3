Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72031E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAcj-0004Nf-1B; Fri, 10 Jan 2025 03:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tWAch-0004NM-GG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:44:07 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tWAcf-0002rZ-OT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:44:07 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5401be44b58so1810023e87.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736498644; x=1737103444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay1lLUQ2rbQzVqovW/LmgsKUOaCwyRsj175URTP/ETc=;
 b=geBQSCKQrwHk+vYuJ2GGR+PHu8ZE1zbs7nTh2l/uPRLv3i/rq7C3O21yF5sLXBFykE
 MCh21Gx5wKXG5bz+/zpJ1QK5gqFWaE9JyBNBpGnRaszNh7/gK1o0nmXdQYOhk67/iCDL
 zwg2ayqZ0BvXyXpntNA8kfdV4DuqXXJhO71BNaXi+nZRcrhrsBSYtxKOJzRuK2dqULrG
 +YPdvZN0UCyX8BEH4DMRIr6qvnmYa375DKsA98GPV89radADhVW1yPPW5exwZzkzfRfy
 swDg0xn0FlpKUQDJpvl9a+SEgImzE+skFRt/LqwIpvfu6raVxo2KeX/NYqF+tvCjMCaq
 1S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736498644; x=1737103444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ay1lLUQ2rbQzVqovW/LmgsKUOaCwyRsj175URTP/ETc=;
 b=Odi39P4cbI88OUyCDiAjCAj2d4qtSJsGkApfjxsXYN2KlCGxg7Li/HjiE7r7re+dnl
 DSANZ2M/bFD93Zlw9m8wuI7UwrWLdfVhgwNu0jeo7JHzhtS14Ui4dfayy7kEXR/Af8zw
 MUat/9mmvgS0Vwnoz9+8Qwxw0XjchMt+RbBL9aJ4ZHJH1YYCVq9YWfqYdaBUBrO1tuVb
 BMaBoLGIZ9gRaSkLy5gVIzmHOoeDzzvYzHHIkTUqpVzJZwVc0Yttlxa583vCPQJrlITg
 CfIrfuvTIcAxJ/dxCHt0OYSPohnCNsGeBl3pgi1J2bQ8Hh0DWoFXR+KIOq2tpSsMlPCU
 jjpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaW3/yS4ZR2MyyYGjOooiaJ/3CPQhmMWUJcofwdC6bskKQCDp7z4gB7us3kVfGr5g0gq4BLbH0jBTH@nongnu.org
X-Gm-Message-State: AOJu0YxGDk1NeT6/y8KoS+cV85qw5KN1w6mhRijlVowdI104+LkxSU9w
 mVplP5Wd7po4ntCK+CG+TTEFqQXvixZnn/vS+4+O+saXbIWk0VjeJ6Lpwu2PDkW3REVF04fRHuQ
 svs19zZlJid8ECj/9Wqgyz7YreFE=
X-Gm-Gg: ASbGncuVNwav89Frqeo9lok4hKRosXU8f4r9HzrPIg4nZkYGn3nTvqswSEAGsKIbGv0
 qReVCIcxqk8RlSlEdUAfZQjsw5MEkLhsem7Wsh0Jm2xU4DnK7O7H5uWKuqgNtxa7EnTW3HQ==
X-Google-Smtp-Source: AGHT+IGltc3CMig6986sJwxx4fsHX6pfxSZVGv9gelkL3bAg/oTrL5XorvDzVERIQU7d0uzJwDMWnJdXhxEgV9njzOA=
X-Received: by 2002:ac2:4c56:0:b0:542:8cf5:a3a3 with SMTP id
 2adb3069b0e04-5428cf5a5ccmr1890020e87.5.1736498643366; Fri, 10 Jan 2025
 00:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
 <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
 <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
 <CACZ9PQW-RJHvkDzBO1T9YDAPX_6zcEuK3kQAEukybBL0PZEB5g@mail.gmail.com>
 <Z4AQQp_Kes-IRoK3@redhat.com>
In-Reply-To: <Z4AQQp_Kes-IRoK3@redhat.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Fri, 10 Jan 2025 09:43:52 +0100
X-Gm-Features: AbW1kvav5bNIpsqJ0FwCrV1Oen2ZB4wmOpuObPCd_89yCUAvRPWLY_E9uMQ1ABM
Message-ID: <CACZ9PQV8pfNq46cPcpv7NZ7cx2bEnuhBToa-DEg9oaLHFuGzHg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x130.google.com
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

On Thu, Jan 9, 2025 at 7:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Jan 09, 2025 at 01:56:40PM +0100, Roman Penyaev wrote:
> > Hi,
> >
> > On Tue, Jan 7, 2025 at 3:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > > Whether we talk about multiplexing front-end or back-end, the issues
> > > are similar. In general, mixing input will create issues. Teeing
> > > output is less problematic, except to handle the buffering...
> >
> > I understand your concerns. What exact issues do you have in mind?
> > Are these issues related to the input buffer handling, so technical iss=
ues?
> > Or issues with usability?
>
> While the design / impl technically allows for concurrent input to be
> sent to the frontend, from multiple backends, in practice I don't think
> we need to be particularly concerned about it.
>
> I don't see this as being a way for multiple different users to interact
> concurrently. Rather I'd see 1 user of the VM just deciding to switch
> from one backend to the other on the fly. IOW, although technically
> possible, the user will only be leveraging one at a time to send input.
>
> We very definitely do need all backends to receive output from the guest
> concurrently too, as you'd want the historical output context to be
> visible on whatever backend you choose to use at any given point in time.
>
> If a user decides to be crazy and send input from multiple backends
> concurrently, then they get to keep the mess.
>
> > > > Do you think we need to artificially introduce multiplexing logic t=
o be fully
> > > > compliant with multiplexer naming? It's not hard to do, repeating
> > > > `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still need to=
 disable
> > > > multiplexing in favor of 'mixing', for example with the 'mixer=3Don=
' option,
> > > > i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it should be=
 some
> > > > completely different beast, something like mixer chardev?
> > >
> > > I think it would be saner to have the muxer be selectors: only work
> > > with one selected be or fe. Otherwise, we can run into various issues=
.
> >
> > In multiplexing (not mixing) for the use-case that I am describing, the=
re is one
> > serious drawback: as soon as you switch the "focus" to another input de=
vice
> > (for example from vnc to socket chardev), you will not be able to s]wit=
ch back
> > from the same input console - the input now works on another device. Th=
is looks
> > strange and does not add convenience to the final user. Perhaps, for a =
case
> > other than console, this would be reasonable, but for console input -
> > I would like
> > to keep the mixer option: the front-end receives input from both back-e=
nds.
>
> Agreed, I think this is desirable. If you did the exclusive access mode,
> it'd complicate things as you now need a way to switch between active
> backends, while also reducing the usefulness of it.
>
> The main thing I'm not a fan of here is the naming 'mux-fe', as I think w=
e
> should have something distinct from current 'mux', to reduce confusion
> when we're talking about it.

The idea to have mux-fe and mux-be (current implementation) was born to
distinguish what exactly we multiplex: front-ends or back-ends.

As Mark-Andre rightly noted, input from back-end devices is not multiplexed=
,
but rather mixed.

>
> How about 'overlay' or 'replicator' ?

Overlay for me has a strong association with the filesystem concept. This
would work for me if combined back-end inputs function by layering one
on top of another, with potentially higher-priority inputs overriding
lower-priority ones. It implies a hierarchical or layered merging approach.
Not quite well describes a simple mixing strategy.

Replicator - this can be a good name from front-end device point of view:
suggests a mechanism for distributing the same input (front-end) to differe=
nt
destinations (back-ends).

Two more: what about 'aggregator' or even 'hub' ?
Also 'mixer'? So we have '-chardev mux' and '-chardev mix' (try not to get
confused :)

--
Roman

