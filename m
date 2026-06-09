Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A8CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0jw-00076Z-G5; Tue, 09 Jun 2026 13:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0jv-00076B-6F
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:59:51 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0jt-0006y9-6H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:59:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so11530588a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027987; cv=none;
 d=google.com; s=arc-20240605;
 b=gZBlhnq37KG72Gmst9stvN+gSo4Xniou78tbr50b2Bd9MSpQwZsKKO6ZGuTzFdG+PV
 wm6Wot8WAi+M4iIgESu3WxoOC/VluoCatTNXfp8WHkMRDo3aOOzbOSHC+sCtsspPrcKR
 n15NNPviP2gqXiHG1z8AU5qplFK0j4Bhzk/0mvwC0DmHTeBcf8hSNDFNIyu3oBY6Mese
 usTPnkLVHCOrbftDSHJ+YqOXg/PsJz5Z2Gtli6nvSHvzEzVdcLteB34GUOXZfLtlO2rG
 JlsRnYqkjT7KslOx/yY5JmULZ/9o+lu+ujdgoXRaw6Zcew7xRwawzizNuL3lTBJ7ADKX
 E/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7aYp9B4zJNjJDdh/VtnmDZhyNAqI5EoZpXeey06Ytbg=;
 fh=WnX9CWFlMwX1a0Rrh/JH2KaMTSnm5LyMmSlbhCutGy4=;
 b=NAGIxA4drJrN2kDsDRn2tFCBrz4ZR4n1au5Et9Gm0urps3JeA9AyLZL35fa2rv6BKp
 QQZuruKimbbH+SfNGxQDmDEZ/JB3MmiYieLrRCj0q2V9L3Mp2nJoNAjw/yPLugqWZ/yZ
 rI9qPZFSEElwMm9NQkaGOQMcuvuzwpfv1p9wQtFkh1TURJbhHkSw6qntad0IUU1Pf07A
 lWAJSwBwdbx2dVcljE0l7FdJMAOp5doxV5M94ace7lkd+Ma5EibwUZBEvxazB09e2wh6
 +hphyxYgmL3o6Uje2Ilo7FXcuLC1a/Ktm6G/VlOY5oZj7DvRFxvQxSO/0Txet5wtnFC2
 Uclg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781027987; x=1781632787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aYp9B4zJNjJDdh/VtnmDZhyNAqI5EoZpXeey06Ytbg=;
 b=Kg679lqcWyVwYfaJAjP2R+9ut4ZjShqFtur39bi/NLlZGYiurpzOHCx+SkOL83Sn82
 k6wS9yY2zoPileoj84Z18yN2LB9aNicg0jI9RRO0mhVDV7XDVDgbWn14OGvUxVxJbLtA
 pjDI/+YzasRrQsJ56cFx3pNwMTXuyjHFf4lhSFG7Tcul1lBQ8cgGnr/swQYkf6vlJv7/
 a+bWlyocRNigp/3T/swmZFsHnDqJMzF3DmIHAMlhC/RbrUt3UuoF3zPDpjhN6wJpD2sC
 xmRjKy3/MBcC2C1Hf47NsgrIDMwngPTXvsLE2kl3VPOMU/NgKbGKS5WcJ6qjaVIC6w+m
 JaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027987; x=1781632787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7aYp9B4zJNjJDdh/VtnmDZhyNAqI5EoZpXeey06Ytbg=;
 b=UFFEjOKlKSfbuobAJXgZExoKmzElxbE7SgQ7ZubkKQlIvfCyZgHxPWJ8+lxasn+IU0
 dZXcJ2NX+dDbncX0REf8EVTEPiwln09+Zeh371GfUvhvTjqnQ3m1LmOLRc7H76cMNoiO
 LrDEsAdxOrhhzgQ+QyaWGsupnxX+kDU5vWTJWGrXoaikI1RroQljX7VzKAxyTkfHU2sW
 bhpT1Ypzulnft5hQkRDBDYJs4/hPPAgH83TJyjj8z/oFJrQAkFhaj4k03MLfDbWh0oSJ
 bJpwkCZZAxqDaZpSR53svC4G0C0eea6q5yCbPb2VLxT0YWtx7iBTfq3XPHqG6/49bBHT
 mRrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9umcP26AQv4hKfV4whYxc2ZOp/E8QnJ/rO7/C98P02AhR9gPnclUXi0eVVnlEX1E8Bqh7AQQclkqxf@nongnu.org
X-Gm-Message-State: AOJu0Yw7nS5fuOXB7QOjf25tNY7SEkrQIVvm18a4MpWSBJJe07Ax8Nda
 PSg1H/L6ZRO5GBeZylBHj5ltyEhr7pycOU7g6pjeMLOVbtcmCn+onSU7QcLMAbqjwO1xuGvuhEv
 8oLZecAliMO32Yy3NM9hyN+CYS7S0vps=
X-Gm-Gg: Acq92OEkhk0Pu7lfFcb30gjWH3BS4PvwhW1R6/xcI3sqfEB/SMLXmcfRkBWXk/qklOP
 iQPkAG/MbyX5FOUXqbHZHvmMKGqnnqUFq2jX95x+IbhtP0ykWRbVrGRBbrZFpmg2nf1YyEnXrl6
 76m+1dqdknQXes1651ftHTm3ztkhiIdxmK0LVOu4MEkubq3e5st3d0dr9QGpFccaIFlSIZVNsS5
 Yr5dzK9bIFWzQaVWA2CReoYtH0Xg9OPVvoci7p34RioJWf1uVAPliL6rbty0GjY/ENME/C+TMgm
 Ts6grSd5U6N0B/9bMflQJuIMyWn5ufAus1uSlt0hGOWoMDuH8TUub0FAA7Uj9Xo=
X-Received: by 2002:a05:6402:4490:b0:67f:e9d0:d819 with SMTP id
 4fb4d7f45d1cf-68fa51527c1mr10103073a12.22.1781027987238; Tue, 09 Jun 2026
 10:59:47 -0700 (PDT)
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
In-Reply-To: <20260604162853.GC115597@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 9 Jun 2026 13:59:34 -0400
X-Gm-Features: AVVi8Cc7zgTZQ5yrcR_PG3eZbdCbzy-kitmhSn9nH4uOrx3wVgCmfAVt68pdNXs
Message-ID: <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
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
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, Jun 4, 2026 at 12:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jun 02, 2026 at 12:38:27PM +0200, Dorinda Bassey wrote:
> > Hi All,
> >
> > Following up on this discussion: Albert, Stefano and I are organizing
> > a BoF session on vhost-user for Linux Plumbers Conference, so this
> > thread is very timely.
> >
> > > I get a sense that this is about politics in the end. Do people feel
> > > they are not represented and would like to have more influence in the
> > > vhost-user spec?
> >
> > I think the core issue is that vhost-user has grown beyond just QEMU.
> > The spec is now implemented by rust-vmm, cloud-hypervisor, crosvm,
> > libkrun, and others. All of these projects depend on the spec as their
> > source of truth for interoperability.
>
> vhost-user was always an effort spanning multiple projects - that is
> fundamentally the purpose of the vhost-user protocol - so it bothers me
> when it is framed this way. CrosVM implemented a vhost-user front-end
> years ago. Features have been added to the spec that are not used by
> QEMU because the spec is for all front-ends and back-ends and their
> different use cases, not just QEMU.
>
> I'm fine with moving the spec to a separate project if it makes
> day-to-day work easier, but it's not accurate to portray vhost-user and
> the work that has been done by people from many projects in this way.
>
> > There are also concrete technical friction points. Let me share some
> > examples from rust-vmm:
> >
> > rust-vmm SHMEM PR https://github.com/rust-vmm/vhost/pull/251
> > We had to wait for QEMU spec acceptance before merging the
> > implementation. The spec update was delayed with the comment
> > "should get picked for the next round" after QEMU freeze.
>
> I am happy to merge a vhost-user spec PR into qemu.git during the freeze
> if other projects need the spec change.
>
> > rust-vmm PR https://github.com/rust-vmm/vhost/pull/339 : was
> > kept as draft "waiting for QEMU spec changes to be finalized."
> > It was eventually merged when they decided the spec was
> > "stable enough" even though QEMU hadn't finalized it yet,
> > which felt awkward.
>
> In this particular case the QEMU patch series could have been split into
> just the spec change and the QEMU implementation with a note in the
> cover letter requesting to merge the spec change right away. I don't
> think anything was fundamentally blocking the spec change, although
> maintainers might be skeptical about rushing something that is still
> work in progress. There was a lack of communication here.
>
> > When multiple independent implementations wait on one
> > project's release cycles, it raises the question of whether the
> > governance model matches the ecosystem reality.
>
> If the experience with QEMU's release cycle is the main point of
> friction, then that is easy to solve by merging spec changes even during
> freeze.

Hi Michael,
It has been a few days and I want to make sure we don't forget this
discussion since rust-vmm was inconvenienced by waiting on QEMU's
development cycle.

I'm not sure if anyone brought up this topic on qemu-devel and with
Michael before. As I mentioned in my reply, there are ways to avoid
blocking vhost-user spec changes when qemu.git is frozen:

The simplest approach is to keep merging vhost-user.rst changes during
freeze since it does not jeopardize the release or introduce
instability.

Another approach is for Michael to merge patches and publish his vhost
subsystem branch. This is a common approach that Linux and QEMU
sub-maintainers use to share merged work before it reaches the final
repo. As long as there is a guarantee that vhost-user.rst changes
merged on Michael's vhost branch are stable, front-end and back-end
implementers can rely on spec changes in Michael's tree without
waiting for qemu.git/master.

Moving vhost-user.rst to its own repo also solves this.

Any preferences?

Stefan

>
> >
> > > Why is the current system not neutral and how will the new system sol=
ve
> > > that?
> >
> > For example the virtio-spec has OASIS governance where changes
> > are proposed and merged independently of any implementation's release
> > cycle. Whether that's the right model for vhost-user is worth discussin=
g.
> >
> > > You bring up project neutrality and a model where Michael is no longe=
r
> > > the sole maintainer. It will be necessary to propose a concrete roadm=
ap
> > > and also to explain the concerns about neutrality more so it's clear
> > > they won't be an issue anymore in the future system.
> >
> > You're right that we need a concrete roadmap before making changes.
> > More reason to discuss in the BoF - to work this out with the people
> > actually doing the work: you, Michael, Albert, and others who've been
> > deeply involved. Maybe in the end the solution might be to "improve
> > QEMU's process" (like Michael's submodule suggestion) rather than
> > "move the spec." or something else? that's what we need to figure out
> > together.
> >
> > Would folks here be interested in joining the discussion at Plumbers?
>
> Plumbers in October? How about scheduling a video call in the next few
> days instead of waiting. That will allow anyone to attend.
>
> Stefan

