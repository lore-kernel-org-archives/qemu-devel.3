Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FABCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUMWQ-0007Jr-Te; Tue, 02 Jun 2026 06:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wUMWL-0007JE-6t
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 06:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wUMWG-0006P1-9z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 06:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780396724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aC5iz3Aggjpr7ZdA5MsghxISg6TzADWIgnpOE51+5e8=;
 b=BmZ6YsSM5rc5RLwKtyQPCE5ILakrHokdk2NSWVzubuydsyZULXQCyGiSIAQU3h2f2awKVs
 9I6SOO1NXhW4Lb6kHTMAHAeAaAl9isT8vgsZvTssErqGoVM2Ppls6I+EheTmi+SYEca4f1
 IiyD5c2nOY+WLm5wTPGSp0t/WYSm+Gk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-NC6BygYeOAOFlJADfD2jvQ-1; Tue, 02 Jun 2026 06:38:43 -0400
X-MC-Unique: NC6BygYeOAOFlJADfD2jvQ-1
X-Mimecast-MFC-AGG-ID: NC6BygYeOAOFlJADfD2jvQ_1780396722
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-43d1e4bca47so1170637fac.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 03:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780396722; cv=none;
 d=google.com; s=arc-20240605;
 b=I6avg83ZdgaQ+p0FYryx1q0057728vAfT0eePnQLBt5ffYR03NUdCJBypvxizDlZuQ
 cCR0u9hHr3DiG6iUy10jqLg5ZvboDAHfLFM6jgWwfmcJzeTpJYkO5WtWJI3UaTxMUGqJ
 qLhwUCEugNGHIcUxJCY1XlPvHdeVFr50bXs0FkE8rDavcd8GRmvIWa8iO2XTRH/BM/qP
 RQ6layV06matjPjNe1PNLfwK+T17YCgBGz/clK3hMZRvpIiME5/kD/+7FDCrRJlG9wCa
 GPKSG8kneshCftm2EMeNS35J/wO9V4YwpFDJIjnuCAccf/R5MRgtO67TM3h/CM3OaBmc
 xP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aC5iz3Aggjpr7ZdA5MsghxISg6TzADWIgnpOE51+5e8=;
 fh=FA2YfaZEdis3oYPuZNwyxgugqwWNzI/0BmXJWsvyUf8=;
 b=F8Yh5SSGoQnU+LOvL+u+L3P5eEyc4uIgh65f1uFzfThLwhz2fZWZkH63KclKIewc02
 xRARDdYBCZLwy7mILddJX/xkcGDFcxvF0UgWXaD8Gy/abNbxtJjfyuXEav/OOaD3j+k9
 kjY9pjAXFdtjYLkoPmM39Z1ExaADyCNMR+0TbZIAOrTsOoKCgiFSWCzSWvHHUizwnta+
 O7lhDar5YYakm7Z+feEa0bMhRZppMHdjwpIHiSi+/BVinJDuMs3Pdytu+5qDq4Xp5J/H
 DIgWnRFzrdSlZ8tp+XFcVSpHaF+ZqJo3eTUID3iLcJGXpDnpwosZeezmxazUjHMFsULT
 /CAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780396722; x=1781001522; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aC5iz3Aggjpr7ZdA5MsghxISg6TzADWIgnpOE51+5e8=;
 b=ZoClcWvkUgTgaPbfnQqNdWHcbteNmkEtw5kQb1DJ8Mwy8RSx/hZ9g13Z/qkwknlKXg
 ymZWXYO1stC+EgRM067/K5vZDvRqbFlZbzPo+e58VoLSEhlGvCTKc5WDH/6webrFltkI
 hV8nc2UE4FHnO+oPOuZGJumcY57476P4b+MKZYx9hXVNmWWRnE9SEoFCO6fSA9dJ4XLk
 oLijNH+eW3OoIn6eP7H8Om0k5BDcmHVvCbqNnuJ1/pCyD2SHG2VjzkHRpIG/H4HDk+Bl
 yZ0KkTnN4RQchbeHEO8n8mUNKV4YyDqXhQuMCzvE8j8QZJVQldOAhH7Ab+w1RbXjQuDn
 Z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780396722; x=1781001522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aC5iz3Aggjpr7ZdA5MsghxISg6TzADWIgnpOE51+5e8=;
 b=dZOsEgYK8KNfgDegNtF7FbdFdq4OwcCcic6to5hGY+3/7ry9ZnaNIWUQmbF1XMqtrW
 4+v1QipW9me5JSnTngspPg9B0ZNyI/O+BQLqxV5m8hukhAExScAvXW3ALMlfgFap2x4O
 NAV8mqyRKWWsh6NE8ONwCXOWmANlc2GVIjkV+TNHnY9nMTqfV+tX6VBquZJTOem7oAai
 vZMr9l+7Pn0GDLvTjT/XhndwS5XMFuFrzQ+M2tyS7YTBvVX67U5zEZBch3UYqE8HTo1/
 0n7milFYCJi5sYAXlkZRTF61/S9QR0VxyMIpNR3ZDcDzDjtnpOVm0Yfg7vHdhXL8kQtC
 TJ0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Iwdeg5r7JGw598oxiOsrDWXu+FaMSw+3WGJSQ/lA8aFRXK1Q+tyFv1jb8SWVjgxD4G08SR8m702Na@nongnu.org
X-Gm-Message-State: AOJu0Yw901wptPHpPlnM7kC6697yQCWteV0uGjAyassDiOw9+c9/aZgz
 UQGIHDN2se+tmZean3ez5FdqAf6084YF1OL1eFnoMuSwTRrMpW/EFiCdvLIZmrPKxMncjTlSh76
 ApKsvOMRHhG/BDYl6CAUrYLpa976JkpfGi0KXIUvYUakxkQKEnzSDMw6gn3BUmR18aEJ0aP5ab/
 smFDNrE4SEoHpBVPe8sGdeu6p2HydJNCQ=
X-Gm-Gg: Acq92OGouCKqlhOo4JTawqde3lZoo8UDWDSv9ufHeixkiHctnRSKfsLBnPCDnKLbhC3
 C/9MBU9K/PSZZs12nIAsgDzt3h2x/eaLhRlUPzrNV8I5ZJG1p/NejfRlR138tv/niwDqnToL02U
 2ugbEv31DpPg75FTdH6Yz0armzRLj62t1AVbelBD8tms/6KY8qFQbW86MSJ49sRojwsFPaYU1Q/
 HWGy6lno/8uivAu
X-Received: by 2002:a05:6820:3409:10b0:69e:2bf1:764e with SMTP id
 006d021491bc7-69e2bf18005mr2353150eaf.44.1780396722197; 
 Tue, 02 Jun 2026 03:38:42 -0700 (PDT)
X-Received: by 2002:a05:6820:3409:10b0:69e:2bf1:764e with SMTP id
 006d021491bc7-69e2bf18005mr2353124eaf.44.1780396721589; Tue, 02 Jun 2026
 03:38:41 -0700 (PDT)
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
In-Reply-To: <20260601160352-mutt-send-email-mst@kernel.org>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Tue, 2 Jun 2026 12:38:27 +0200
X-Gm-Features: AVHnY4LwCPFkOEUqnK9xhjnkZufXzEPxXFeGjqHBNfHWEOFKaTSPvElmkH6Bxhc
Message-ID: <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>,
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
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: multipart/alternative; boundary="00000000000026eab7065342ea29"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000026eab7065342ea29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Following up on this discussion: Albert, Stefano and I are organizing
a BoF session on vhost-user for Linux Plumbers Conference, so this
thread is very timely.

> I get a sense that this is about politics in the end. Do people feel
> they are not represented and would like to have more influence in the
> vhost-user spec?

I think the core issue is that vhost-user has grown beyond just QEMU.
The spec is now implemented by rust-vmm, cloud-hypervisor, crosvm,
libkrun, and others. All of these projects depend on the spec as their
source of truth for interoperability.
There are also concrete technical friction points. Let me share some
examples from rust-vmm:

rust-vmm SHMEM PR https://github.com/rust-vmm/vhost/pull/251
We had to wait for QEMU spec acceptance before merging the
implementation. The spec update was delayed with the comment
"should get picked for the next round" after QEMU freeze.

rust-vmm PR https://github.com/rust-vmm/vhost/pull/339 : was
kept as draft "waiting for QEMU spec changes to be finalized."
It was eventually merged when they decided the spec was
"stable enough" even though QEMU hadn't finalized it yet,
which felt awkward.

When multiple independent implementations wait on one
project's release cycles, it raises the question of whether the
governance model matches the ecosystem reality.

> Why is the current system not neutral and how will the new system solve
> that?

For example the virtio-spec has OASIS governance where changes
are proposed and merged independently of any implementation's release
cycle. Whether that's the right model for vhost-user is worth discussing.

> You bring up project neutrality and a model where Michael is no longer
> the sole maintainer. It will be necessary to propose a concrete roadmap
> and also to explain the concerns about neutrality more so it's clear
> they won't be an issue anymore in the future system.

You're right that we need a concrete roadmap before making changes.
More reason to discuss in the BoF - to work this out with the people
actually doing the work: you, Michael, Albert, and others who've been
deeply involved. Maybe in the end the solution might be to "improve
QEMU's process" (like Michael's submodule suggestion) rather than
"move the spec." or something else? that's what we need to figure out
together.

Would folks here be interested in joining the discussion at Plumbers?

BR,
Dorinda.


On Mon, Jun 1, 2026 at 10:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Jun 01, 2026 at 11:18:15AM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jun 01, 2026 at 04:27:46PM +0200, Albert Esteve wrote:
> > > On Mon, Jun 1, 2026 at 3:51=E2=80=AFPM Stefan Hajnoczi <stefanha@gmai=
l.com>
> wrote:
> > > >
> > > > On Mon, Jun 1, 2026 at 9:12=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com>
> wrote:
> > > > >
> > > > > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > > > > On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. Tsirkin <
> mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote=
:
> > > > > > > >  But also because, in my opinion, separating
> > > > > > > > the specification would improve development agility by
> decoupling
> > > > > > > > specification development from QEMU's review and release
> cycles.
> > > > > > >
> > > > > > > Generally for QEMU this will be less agility, unless I
> misunderstand
> > > > > > > what is proposed)
> > > > > > >
> > > > > > > Because presumably there will need to be spec releases then?
> > > > > > >
> > > > > > > So
> > > > > > >         new feature -> spec tree -> spec release -> qemu
> implementation -> qemu release
> > > > > > >
> > > > > > > is surely longer that what we have now.
> > > > > >
> > > > > > I see your point.
> > > > > >
> > > > > > However, we do not really need to introduce a heavy release
> management
> > > > > > layer. We could just operate it as a living document, where the
> main
> > > > > > branch is the authoritative source of truth.
> > > > > >
> > > > > > For the workflow, development doesn't have to be strictly
> sequential
> > > > > > either. A contributor can propose the spec update while working
> on the
> > > > > > implementation, much like we do for VirtIO updates. Actually,
> this way
> > > > > > one update/change supports the other.
> > > > > >
> > > > > > I guess my point is that a dedicated repository could lower the
> > > > > > barrier for new changes AND keep QEMU's own development speed
> mostly
> > > > > > unaffected.
> > > > > >
> > > > > > BR,
> > > > > > Albert
> > > > >
> > > > > Something something submodule? Possibly. If you want to make
> progress
> > > > > on this, pls think of the process, try it out.
> > > >
> > > > If I understand correctly, the motivation for moving the spec
> > > > somewhere else is to replace the email patch review process with a
> git
> > > > forge review process?
> > > >
> > > > This seems like a superficial change and is not worth in my opinion
> if
> > > > you consider we'll have to redirect from the old spec location and
> > > > move the community over to the new repo.
> > >
> > > The core issue from my perspective is project neutrality and
> > > decoupling lifecycles.
> > >
> > > Currently, protocol updates are tied to QEMU's tree rules and release
> > > freezes for example. Since these changes also affect other projects
> > > (like rust-vmm, crosvm, DPDK, etc.), separating them may make sense
> > > and could streamline the process.
> >
> > I don't see a reason to block vhost-user.rst changes during QEMU's
> > freeze. If Michael sent a vhost-user spec pull request during freeze I
> > would merge it.
> >
> > > >We could actually lose spec
> > > > change reviewers in the process either because they don't know what=
's
> > > > going on or decide that they prefer to spend time elsewhere when
> faced
> > > > with switching processes (the people who review and participate in
> > > > discussion do so out of personal interest and as far as I'm aware n=
o
> > > > one is employed to work on vhost-user as their #1 priority).
> > >
> > > This is a fair concern. I hope we maintain reviewer engagement. But i=
t
> > > could also be argued that contributors from other communities may be
> > > more comfortable with a dedicated project-neutral home. It could well
> > > go both ways, but it also represents an opportunity to grow.
> > >
> > > >
> > > > Having said that, here is what I imagine it would involve:
> > > >
> > > > 1. Michael creates a new repo on a git forge (if he wants it to be
> > > > under the GitLab qemu-project organization I can help with creating
> > > > the repo, otherwise he creates a new organization and repo).
> > > > 2. Discussion happens in Issues.
> > > > 3. Spec changes are proposed in Merge Requests. Michael merges them
> > > > once consensus has been reached.
> > >
> > > Mostly yes, though we wouldn't necessarily need Michael as the sole
> > > gatekeeper. We could invite co-maintainers from other key projects to
> > > share the reviewer load.
> > >
> > > Also I'd want to clarify that although I am advocating for this
> > > change, I do not claim to have the definitive roadmap. I am just
> > > sharing my view on why this could be a positive evolution. Consensus
> > > may end up being to remain with the current status quo, or any of the
> > > other options proposed by Alex.
> >
> > I get a sense that this is about politics in the end. Do people feel
> > they are not represented and would like to have more influence in the
> > vhost-user spec?
> >
> > You bring up project neutrality and a model where Michael is no longer
> > the sole maintainer. It will be necessary to propose a concrete roadmap
> > and also to explain the concerns about neutrality more so it's clear
> > they won't be an issue anymore in the future system.
> >
> > Why is the current system not neutral and how will the new system solve
> > that?
> >
> > Who should be a co-maintainer?
> >
> > Stefan
>
> And also, qemu currently acts like a reference implementation.
> Which is something.
>
> --
> MST
>
>

--00000000000026eab7065342ea29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>Following up on this discussion: Albert, St=
efano and I are organizing<br>a BoF session on vhost-user for Linux Plumber=
s Conference, so this<br>thread is very timely.<br><br>&gt; I get a sense t=
hat this is about politics in the end. Do people feel<br>&gt; they are not =
represented and would like to have more influence in the<br>&gt; vhost-user=
 spec?<br><br>I think the core issue is that vhost-user has grown beyond ju=
st QEMU.<br>The spec is now implemented by rust-vmm, cloud-hypervisor, cros=
vm,<br>libkrun, and others. All of these projects depend on the spec as the=
ir<br>source of truth for interoperability.<br>There are also concrete tech=
nical friction points. Let me share some<br>examples from rust-vmm:<br><br>=
rust-vmm SHMEM PR <a href=3D"https://github.com/rust-vmm/vhost/pull/251">ht=
tps://github.com/rust-vmm/vhost/pull/251</a><br>We had to wait for QEMU spe=
c acceptance before merging the<br>implementation. The spec update was dela=
yed with the comment<br>&quot;should get picked for the next round&quot; af=
ter QEMU freeze.<br><br>rust-vmm PR <a href=3D"https://github.com/rust-vmm/=
vhost/pull/339">https://github.com/rust-vmm/vhost/pull/339</a> : was<br>kep=
t as draft &quot;waiting for QEMU spec changes to be finalized.&quot; <br>I=
t was eventually merged when they decided the spec was<br>&quot;stable enou=
gh&quot; even though QEMU hadn&#39;t finalized it yet,<br>which felt awkwar=
d.<br><br>When multiple independent implementations wait on one<br>project&=
#39;s release cycles, it raises the question of whether the<br>governance m=
odel matches the ecosystem reality.<br><br>&gt; Why is the current system n=
ot neutral and how will the new system solve<br>&gt; that?<br><br>For examp=
le the virtio-spec has OASIS governance where changes<br>are proposed and m=
erged independently of any implementation&#39;s release<br>cycle. Whether t=
hat&#39;s the right model for vhost-user is worth discussing.<br><br>&gt; Y=
ou bring up project neutrality and a model where Michael is no longer<br>&g=
t; the sole maintainer. It will be necessary to propose a concrete roadmap<=
br>&gt; and also to explain the concerns about neutrality more so it&#39;s =
clear<br>&gt; they won&#39;t be an issue anymore in the future system.<br><=
br>You&#39;re right that we need a concrete roadmap before making changes.<=
br>More reason to discuss in the BoF - to work this out with the people<br>=
actually doing the work: you, Michael, Albert, and others who&#39;ve been<b=
r>deeply involved. Maybe in the end the solution might be to &quot;improve<=
br>QEMU&#39;s process&quot; (like Michael&#39;s submodule suggestion) rathe=
r than <br><div>&quot;move the spec.&quot; or something else? that&#39;s wh=
at we need to figure out</div><div>together.</div><br><div>Would folks here=
 be interested in joining the discussion at Plumbers?</div><div><br></div><=
div>BR,</div><div>Dorinda.</div></div><br><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 1, 20=
26 at 10:05=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.=
com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Mon, Jun 01, 2026 at 11:18:15AM -0400, Stefan Hajnocz=
i wrote:<br>
&gt; On Mon, Jun 01, 2026 at 04:27:46PM +0200, Albert Esteve wrote:<br>
&gt; &gt; On Mon, Jun 1, 2026 at 3:51=E2=80=AFPM Stefan Hajnoczi &lt;<a hre=
f=3D"mailto:stefanha@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt=
; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Mon, Jun 1, 2026 at 9:12=E2=80=AFAM Michael S. Tsirkin &l=
t;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt=
; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve=
 wrote:<br>
&gt; &gt; &gt; &gt; &gt; On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. =
Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.=
com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Mon, Jun 01, 2026 at 02:32:11PM +0200, Alb=
ert Esteve wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 But also because, in my opinion, s=
eparating<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the specification would improve developm=
ent agility by decoupling<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; specification development from QEMU&#39;=
s review and release cycles.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Generally for QEMU this will be less agility,=
 unless I misunderstand<br>
&gt; &gt; &gt; &gt; &gt; &gt; what is proposed)<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Because presumably there will need to be spec=
 releases then?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; So<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new feature =
-&gt; spec tree -&gt; spec release -&gt; qemu implementation -&gt; qemu rel=
ease<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; is surely longer that what we have now.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I see your point.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; However, we do not really need to introduce a heav=
y release management<br>
&gt; &gt; &gt; &gt; &gt; layer. We could just operate it as a living docume=
nt, where the main<br>
&gt; &gt; &gt; &gt; &gt; branch is the authoritative source of truth.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; For the workflow, development doesn&#39;t have to =
be strictly sequential<br>
&gt; &gt; &gt; &gt; &gt; either. A contributor can propose the spec update =
while working on the<br>
&gt; &gt; &gt; &gt; &gt; implementation, much like we do for VirtIO updates=
. Actually, this way<br>
&gt; &gt; &gt; &gt; &gt; one update/change supports the other.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I guess my point is that a dedicated repository co=
uld lower the<br>
&gt; &gt; &gt; &gt; &gt; barrier for new changes AND keep QEMU&#39;s own de=
velopment speed mostly<br>
&gt; &gt; &gt; &gt; &gt; unaffected.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; BR,<br>
&gt; &gt; &gt; &gt; &gt; Albert<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Something something submodule? Possibly. If you want to=
 make progress<br>
&gt; &gt; &gt; &gt; on this, pls think of the process, try it out.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If I understand correctly, the motivation for moving the spe=
c<br>
&gt; &gt; &gt; somewhere else is to replace the email patch review process =
with a git<br>
&gt; &gt; &gt; forge review process?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This seems like a superficial change and is not worth in my =
opinion if<br>
&gt; &gt; &gt; you consider we&#39;ll have to redirect from the old spec lo=
cation and<br>
&gt; &gt; &gt; move the community over to the new repo.<br>
&gt; &gt; <br>
&gt; &gt; The core issue from my perspective is project neutrality and<br>
&gt; &gt; decoupling lifecycles.<br>
&gt; &gt;<br>
&gt; &gt; Currently, protocol updates are tied to QEMU&#39;s tree rules and=
 release<br>
&gt; &gt; freezes for example. Since these changes also affect other projec=
ts<br>
&gt; &gt; (like rust-vmm, crosvm, DPDK, etc.), separating them may make sen=
se<br>
&gt; &gt; and could streamline the process.<br>
&gt; <br>
&gt; I don&#39;t see a reason to block vhost-user.rst changes during QEMU&#=
39;s<br>
&gt; freeze. If Michael sent a vhost-user spec pull request during freeze I=
<br>
&gt; would merge it.<br>
&gt; <br>
&gt; &gt; &gt;We could actually lose spec<br>
&gt; &gt; &gt; change reviewers in the process either because they don&#39;=
t know what&#39;s<br>
&gt; &gt; &gt; going on or decide that they prefer to spend time elsewhere =
when faced<br>
&gt; &gt; &gt; with switching processes (the people who review and particip=
ate in<br>
&gt; &gt; &gt; discussion do so out of personal interest and as far as I&#3=
9;m aware no<br>
&gt; &gt; &gt; one is employed to work on vhost-user as their #1 priority).=
<br>
&gt; &gt; <br>
&gt; &gt; This is a fair concern. I hope we maintain reviewer engagement. B=
ut it<br>
&gt; &gt; could also be argued that contributors from other communities may=
 be<br>
&gt; &gt; more comfortable with a dedicated project-neutral home. It could =
well<br>
&gt; &gt; go both ways, but it also represents an opportunity to grow.<br>
&gt; &gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Having said that, here is what I imagine it would involve:<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 1. Michael creates a new repo on a git forge (if he wants it=
 to be<br>
&gt; &gt; &gt; under the GitLab qemu-project organization I can help with c=
reating<br>
&gt; &gt; &gt; the repo, otherwise he creates a new organization and repo).=
<br>
&gt; &gt; &gt; 2. Discussion happens in Issues.<br>
&gt; &gt; &gt; 3. Spec changes are proposed in Merge Requests. Michael merg=
es them<br>
&gt; &gt; &gt; once consensus has been reached.<br>
&gt; &gt; <br>
&gt; &gt; Mostly yes, though we wouldn&#39;t necessarily need Michael as th=
e sole<br>
&gt; &gt; gatekeeper. We could invite co-maintainers from other key project=
s to<br>
&gt; &gt; share the reviewer load.<br>
&gt; &gt;<br>
&gt; &gt; Also I&#39;d want to clarify that although I am advocating for th=
is<br>
&gt; &gt; change, I do not claim to have the definitive roadmap. I am just<=
br>
&gt; &gt; sharing my view on why this could be a positive evolution. Consen=
sus<br>
&gt; &gt; may end up being to remain with the current status quo, or any of=
 the<br>
&gt; &gt; other options proposed by Alex.<br>
&gt; <br>
&gt; I get a sense that this is about politics in the end. Do people feel<b=
r>
&gt; they are not represented and would like to have more influence in the<=
br>
&gt; vhost-user spec?<br>
&gt; <br>
&gt; You bring up project neutrality and a model where Michael is no longer=
<br>
&gt; the sole maintainer. It will be necessary to propose a concrete roadma=
p<br>
&gt; and also to explain the concerns about neutrality more so it&#39;s cle=
ar<br>
&gt; they won&#39;t be an issue anymore in the future system.<br>
&gt; <br>
&gt; Why is the current system not neutral and how will the new system solv=
e<br>
&gt; that?<br>
&gt; <br>
&gt; Who should be a co-maintainer?<br>
&gt; <br>
&gt; Stefan<br>
<br>
And also, qemu currently acts like a reference implementation.<br>
Which is something.<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div>

--00000000000026eab7065342ea29--


