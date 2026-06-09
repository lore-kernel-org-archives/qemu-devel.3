Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84410CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1cn-0006e8-30; Tue, 09 Jun 2026 14:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wX1cf-0006cd-5H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:56:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wX1cc-0007ux-S9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 14:56:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so51302735e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031380; cv=none;
 d=google.com; s=arc-20240605;
 b=WvPiEIn3nStCznB15UTVbptjI5FDrbgQcwToVK6U4Da7HUZLmKLOJio1ZOK+QnmGBM
 DKM/FKoWJuYLcESm0V3XwrxDH/uo6n1wD7RfHCVEm7mcR4hE9QoepGVKf98BJyGXeycQ
 phpomUds5RWGOdCF+X4ePssXlo4qKJ0X5GYAMX3QBURdtWPwhi1pl8y7Xpr4rJKGRwRl
 gAvCobMkDnjPFqX3G4CoYFG1/Xs3MN6/F88r5yYlPf3lzwLYodSsooGRhgK3nFyHti8i
 5j5GU9Qkv1DLONM7hZqUN07/AZx4G0JeA8yAGKkiOPjdwwfsH+fbtIWyhm/mMLd8dcjP
 xH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9jUp3iBPByccIet06cfjPUK09NvRBqzcZDFuywo9mHE=;
 fh=ROWYArGxYRxVBKQEsMYQsoqlDmWXiqpISk5IiH3K8ZU=;
 b=fHZhmDq87FmnhqUW8ijgkvr4UdCW/7wlIpMIwwP/53TQXT3vZfJvsr3IS0+Bhm/pmx
 L+jYJC8kBPK3mT79OfEydmG5TzTr62R3Lo9MsGnOYpXcafIpVhWoh9oUtZggcQ1oE2xm
 n0N5tKSv4vndKUNSASNeOeYzDvXpVTT+CXbBW+p1S1uNItxT5oDqQ0Lm3Xdj2JGLGoba
 /A9KGlnRMfgddNo3xbDt8mvogUXpGM1eiWzXpOuGcyqKvwwopls/HnkiZQXjvDvZEEpu
 ePvEFHF5+Gbqs8rHhPPfx+EkUrHft+9T1q/9Q1AxMqFi22UHnTpyuNMY21ggymac876w
 nWEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781031380; x=1781636180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jUp3iBPByccIet06cfjPUK09NvRBqzcZDFuywo9mHE=;
 b=MVIr9CrIzf44tV2pQQtJwXaDi8AY8euuAS23npmr1HGJpv8X4RvrZAE/33IOsOfwt9
 X/360dZ29RvQUV4BaAfcrwTDzOKBfFqhQxuSZHRFdoOd3WV46FDc9ce22miIFpSOg04m
 LogBYzcYKwwLT+dOWxLtvqUYwX6HLKGaXWxMZKYgVaI555WVmCrcdSK78wfS04vfRYlC
 NKNHir9pjpnsriaJb+CyIxxe1ZeCjlXhHVwcJGAwSsgc0TDKdtQq/HY0Cp2r4t4g7WTd
 hPBQTEdV2pxVxFEhQAn9FqvrzGeDsmeWyavhv3NL7423LWtV+6mhS2MVyFTbzG+W8tzf
 HEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031380; x=1781636180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jUp3iBPByccIet06cfjPUK09NvRBqzcZDFuywo9mHE=;
 b=LryQjQHIHofRrgx9STdbWqnZPLIUbLX4jPyg1j7Q4k6mikiV9vkMXEt/cDPrTpXRWg
 8G68wsLKwUEFzBvegFgdesE/ckJa9TDNQzQEBykkkqB8CRzCSrd0m+ywQR5O+6n7uI2x
 RZk/+TjaZfXqfmdyf2JdxFMZBdb60KfCD1sTClNwpZPJIuYn87a300WxiOkliqqvGCmY
 17JQQXMhNbwXJyJaEn3ec8Ft8ZqyV6C4PBl92Hp4bmmiRIuUKRDdr70/e/7XPk0GJ06s
 6CQASj2e/U+IavX6xaMStHM2wwj74R2CCNdAcIageqd+bK3bKdD3RQxDjhlJ0ZjFyT8i
 pGqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+maoRRxfKPpIVq/oKPvsJjxfpuJqD9sCyMLdKldjrG76MHcGN8bi+dbykucSRTNpBZ8uiouHtekEmC@nongnu.org
X-Gm-Message-State: AOJu0YxvYLVkqm80C6SHwcxRKMl50hMS6xtQ5v7asiQC5tTVWxXRhoio
 TYviswFVtKzAyVVojkHb5faGlrT5kfJC/N6KiV8UVqukG/T+8ZntssFMi93fS9VHvVf9eP6P11Q
 vb70l5ziC7sC0ifhYrlixDyH0VhBwqC56wxFf5IPnKQ==
X-Gm-Gg: Acq92OF3FH8aMnE/1SJ7iyM7NumW1X0WGulanOX/67OsleIGDvZEOY+X1SFHvyoiep5
 flDw903kD/G+YxaG56Nf2IVF4o0QtNW6VDtDFeUAaCta4TvihYm/Opsq+HWyJjiyGVx0RaWuufD
 E3VML/Tcvj0W3i+z9Zay/TpdVBJkZqOh43BxnNHvq2rUCwUAuC9LOkbvVDpQy0jYahGwqZC7D8W
 9WmEJpP6KCmwaEc8MTcyk56D5NvL7W5Ns6ckcPWKAciUALG0cuXOHKUe8AhTxQXVBTdR0TtPS63
 5NChcvpkW1UAqQWHNSUX1uA2Ytpb3BVHs+ajx2esDQ7WE69AJyt+zQYJZi4r
X-Received: by 2002:a05:600c:609b:b0:490:5466:8576 with SMTP id
 5b1f17b1804b1-490c259854emr346044955e9.1.1781031380105; Tue, 09 Jun 2026
 11:56:20 -0700 (PDT)
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
In-Reply-To: <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 9 Jun 2026 21:55:53 +0300
X-Gm-Features: AVVi8Cez7LrzR4UFcqFbMTZkIa6rqxqltEz6H7-ttHlixGU_miD6q2bZoE9M5-g
Message-ID: <CAAjaMXb8tnDuBBgVkVk31AYaWKpWhas7APWtSyjcrMFMYc26jg@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Demi Marie Obenour <demi@invisiblethingslab.com>, 
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>, 
 Matti Moell <matti@qti.qualcomm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Vishwanath Seshagiri <vishs@meta.com>,
 Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

On Tue, Jun 9, 2026 at 8:59=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Thu, Jun 4, 2026 at 12:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Jun 02, 2026 at 12:38:27PM +0200, Dorinda Bassey wrote:
> > > Hi All,
> > >
> > > Following up on this discussion: Albert, Stefano and I are organizing
> > > a BoF session on vhost-user for Linux Plumbers Conference, so this
> > > thread is very timely.
> > >
> > > > I get a sense that this is about politics in the end. Do people fee=
l
> > > > they are not represented and would like to have more influence in t=
he
> > > > vhost-user spec?
> > >
> > > I think the core issue is that vhost-user has grown beyond just QEMU.
> > > The spec is now implemented by rust-vmm, cloud-hypervisor, crosvm,
> > > libkrun, and others. All of these projects depend on the spec as thei=
r
> > > source of truth for interoperability.
> >
> > vhost-user was always an effort spanning multiple projects - that is
> > fundamentally the purpose of the vhost-user protocol - so it bothers me
> > when it is framed this way. CrosVM implemented a vhost-user front-end
> > years ago. Features have been added to the spec that are not used by
> > QEMU because the spec is for all front-ends and back-ends and their
> > different use cases, not just QEMU.
> >
> > I'm fine with moving the spec to a separate project if it makes
> > day-to-day work easier, but it's not accurate to portray vhost-user and
> > the work that has been done by people from many projects in this way.
> >
> > > There are also concrete technical friction points. Let me share some
> > > examples from rust-vmm:
> > >
> > > rust-vmm SHMEM PR https://github.com/rust-vmm/vhost/pull/251
> > > We had to wait for QEMU spec acceptance before merging the
> > > implementation. The spec update was delayed with the comment
> > > "should get picked for the next round" after QEMU freeze.
> >
> > I am happy to merge a vhost-user spec PR into qemu.git during the freez=
e
> > if other projects need the spec change.
> >
> > > rust-vmm PR https://github.com/rust-vmm/vhost/pull/339 : was
> > > kept as draft "waiting for QEMU spec changes to be finalized."
> > > It was eventually merged when they decided the spec was
> > > "stable enough" even though QEMU hadn't finalized it yet,
> > > which felt awkward.
> >
> > In this particular case the QEMU patch series could have been split int=
o
> > just the spec change and the QEMU implementation with a note in the
> > cover letter requesting to merge the spec change right away. I don't
> > think anything was fundamentally blocking the spec change, although
> > maintainers might be skeptical about rushing something that is still
> > work in progress. There was a lack of communication here.
> >
> > > When multiple independent implementations wait on one
> > > project's release cycles, it raises the question of whether the
> > > governance model matches the ecosystem reality.
> >
> > If the experience with QEMU's release cycle is the main point of
> > friction, then that is easy to solve by merging spec changes even durin=
g
> > freeze.
>
> Hi Michael,
> It has been a few days and I want to make sure we don't forget this
> discussion since rust-vmm was inconvenienced by waiting on QEMU's
> development cycle.
>
> I'm not sure if anyone brought up this topic on qemu-devel and with
> Michael before. As I mentioned in my reply, there are ways to avoid
> blocking vhost-user spec changes when qemu.git is frozen:
>
> The simplest approach is to keep merging vhost-user.rst changes during
> freeze since it does not jeopardize the release or introduce
> instability.
>
> Another approach is for Michael to merge patches and publish his vhost
> subsystem branch. This is a common approach that Linux and QEMU
> sub-maintainers use to share merged work before it reaches the final
> repo.

> As long as there is a guarantee that vhost-user.rst changes
> merged on Michael's vhost branch are stable, front-end and back-end
> implementers can rely on spec changes in Michael's tree without
> waiting for qemu.git/master.

I think this is the sanest and simplest solution. vhost-user.rst
changes do not need to go to master, a guarantee that they will get
submitted as a PR against master is enough.

>
> Moving vhost-user.rst to its own repo also solves this.
>
> Any preferences?
>
> Stefan
>
> >
> > >
> > > > Why is the current system not neutral and how will the new system s=
olve
> > > > that?
> > >
> > > For example the virtio-spec has OASIS governance where changes
> > > are proposed and merged independently of any implementation's release
> > > cycle. Whether that's the right model for vhost-user is worth discuss=
ing.
> > >
> > > > You bring up project neutrality and a model where Michael is no lon=
ger
> > > > the sole maintainer. It will be necessary to propose a concrete roa=
dmap
> > > > and also to explain the concerns about neutrality more so it's clea=
r
> > > > they won't be an issue anymore in the future system.
> > >
> > > You're right that we need a concrete roadmap before making changes.
> > > More reason to discuss in the BoF - to work this out with the people
> > > actually doing the work: you, Michael, Albert, and others who've been
> > > deeply involved. Maybe in the end the solution might be to "improve
> > > QEMU's process" (like Michael's submodule suggestion) rather than
> > > "move the spec." or something else? that's what we need to figure out
> > > together.
> > >
> > > Would folks here be interested in joining the discussion at Plumbers?
> >
> > Plumbers in October? How about scheduling a video call in the next few
> > days instead of waiting. That will allow anyone to attend.
> >
> > Stefan

