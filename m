Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBC8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3cc-0006T9-4b; Mon, 01 Jun 2026 10:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU3ca-0006Sn-8N
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU3cX-0004rM-PK
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780324080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzxGVtD8LzmdHy9vSLwx4b0m9AMJU6GxbTYPcOb5Wxk=;
 b=Rv+km5Y+1aW36AQkc29UgH/d0RJiLcHEvNISn7vzpjzwA2kw52iF5RqGgyPROp1BCLPmbb
 ZCnTlBMJd/D8jDtVNw0b3hn2DqbQHiCONMrVO91SfvCu9hn+pTP/w4ppa0ECRPTTMmhcL/
 nxDsZgrSgDtBTLOMPa8saQ44ZU0h+CU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-fQDf4VbzPbWZXBi61igC0w-1; Mon, 01 Jun 2026 10:27:58 -0400
X-MC-Unique: fQDf4VbzPbWZXBi61igC0w-1
X-Mimecast-MFC-AGG-ID: fQDf4VbzPbWZXBi61igC0w_1780324078
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7ddb130b821so55683597b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780324078; cv=none;
 d=google.com; s=arc-20240605;
 b=O8IjGbldpS6ybGzyzCLHSr9HrklwLAgNSDvVFhQ8tU72nTdK9F0/wmNcwNnHKVQV0S
 qd0E2fn3FSPrqeaOeK9YkizvQsYt35G60gQw1yUMjzG24qAY+lN3njdc9tbpkLdZvc4y
 /MhYD3aNB6DMU4+uUCP68HkghywQHnj5ICbSVViMRS9Bvuww1bwTPDXrO2Vc0nGnNmRH
 QbFk4Ou9jInLEylbuCB2xibT/Ogf0NMv51Q6LQ9hHys+U0cdYJGQ88qQroo+b7/5j/On
 f6fpn8e/TV+B+NR0gzbkrBJtYZwZq9p8wJFztLTuGmV8BRuIi2PcAvg+OGp2lWjs51e1
 2Lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nzxGVtD8LzmdHy9vSLwx4b0m9AMJU6GxbTYPcOb5Wxk=;
 fh=WbP5egQ3W9yGZTbT4kGPnTU9opyzDgjYGOnlNn/+Cp8=;
 b=Bx933iX49CWIDwOhlOH8M9u/686wPYk5rYNL16pcRPIiKOgVAS8P0duJZfVLfV7xII
 BgTqq6aU3r11kyrnb1IPMtLFMGOLfTiUpyHV1GsplQyzyIFShE73bJuX05fUQ6xIKRQS
 aH6j3RVSUshKOOdRbMN5jjimfmu4gpDvQCaVV2Z86SbqC3hlv3NSRmHlI2c+Fq3t+TWK
 A4vQrvUZOPIPxZmVKEDHA1BrTIRrQf5XH3aElwOTynmGX7BtpqplMhA9JO46wOde1/ry
 RR5usjzQOZ4zKVuDv1T4tmK+6D6nNlnVBse2vB9ZwLERdVifiEej8muXSvWXO7hjZZdQ
 drvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780324078; x=1780928878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzxGVtD8LzmdHy9vSLwx4b0m9AMJU6GxbTYPcOb5Wxk=;
 b=MzUXgea5n5Yp+ma8NL+SDDRn4H+vvkgNbJ2w72XPaHDplD3FKktaEg2zZgEpIAMMly
 t7QKNoyBS4aMre3vy6Beh3Fc/zX69JzcNcUZLQGoGxF6Hc7UsiR0FBC2u0OKg3FD2an2
 NZtrm7ig20G7Pvw+q+3QDsoiDpcdvlXbRsWdK2XYjKjy5+5bXWon9lsxZKsSjpesxCml
 CPwHwhyhVBo+zHt5LFGBvNIIOjhCPCKuhImn8ruXR+uXs6sO8vjov0CCXy9ABq7bgMar
 D5iJpI7frynhia4aDMvvUscI0ZqdcPeC/3nANQz7zPorkNXhe0MX4zoGg4dzx573lhtf
 MJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324078; x=1780928878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nzxGVtD8LzmdHy9vSLwx4b0m9AMJU6GxbTYPcOb5Wxk=;
 b=Y7NrXu1EFhj01q8hoC1mEQrEI3SEA5FnojsRWC0GSKKzBNpI12NYsT4KvYmW80FhRg
 E11fXTLxen//t5m84Ug9r8KXZgkX9RZOBZd5KxWxzyGIqYNaRbXD5HNPJynXAtnE3E95
 IGb+BPf3a+eRlamT2M/x2n2FLQ9G2pkU4AUABQtl/0orqKIEXLfDnR4zTa6XXYblaloi
 UVo23BRVJXs5pCDJfqXtbk7lTwmjHz3AzKOk/ul+qeNPc9LIkUp85Y9ctVeFygEsYzfv
 uImCVFsqnJT7wCz2Z1pbdJq4aLyF22vcq10/V9gEtmmbfXPYLaVXEXfmKr5N0gHink/y
 7MJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ToCXJzT0w8nTU+pZhDMt4gQYODrLE5HMSEWJmE6yL8r3k2qspX8KbhV3UUA7wgI2ND4JUMrfAe8bw@nongnu.org
X-Gm-Message-State: AOJu0Yz3capOYag0hpUzUvwLjZ8Q/Z06aoGElvOtZzadC3Vlg6stqwT1
 i8R7ko2oDAsMev6w3tZaLxqRsMmYgln0gQa+1SJENM7ZQIeNHKuIVd0wY2CXRKlGC+5bMLli1sa
 xDim7XYeLfakdpbKpAHnE77/mfXwgaUmROZNuf7roKfxb/fIWlRk70glLrvPfbxKiPoNwwTmpV5
 fwLKaI/g9VxqpCa+EG09PwXfnvIHU9nbA=
X-Gm-Gg: Acq92OFJ2rJDSNm/FUf5V2wF0abkoayXO477jB8gphdHa5ZXdLlcRtKo4B/t5ridjxg
 K2BzrNGAYtZqvLyQDAvcOfy3pm94UI20z8+Rq/P5kD8Zj/8Ko9ifBV68lGMTPNeOn3AM2iQXfrU
 tvCgU52Bu5yVwgCRIayTvpzu0wRg2bCAhDqHfy41eARk8gnNT5AnDox/FUBVO3g80wAsmRcOxpb
 tcFt3Y9WKTnIY66
X-Received: by 2002:a05:690c:600f:b0:7dc:f7b3:8e08 with SMTP id
 00721157ae682-7e05d8d073dmr97402237b3.23.1780324077684; 
 Mon, 01 Jun 2026 07:27:57 -0700 (PDT)
X-Received: by 2002:a05:690c:600f:b0:7dc:f7b3:8e08 with SMTP id
 00721157ae682-7e05d8d073dmr97401917b3.23.1780324077295; Mon, 01 Jun 2026
 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
In-Reply-To: <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 1 Jun 2026 16:27:46 +0200
X-Gm-Features: AVHnY4KkVphEgTcvUaTusVW5m8BJdtQFZnb5ZMHPSTXxKAdxVYyJEGJ_HsR1UR8
Message-ID: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 1, 2026 at 3:51=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Mon, Jun 1, 2026 at 9:12=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > > >  But also because, in my opinion, separating
> > > > > the specification would improve development agility by decoupling
> > > > > specification development from QEMU's review and release cycles.
> > > >
> > > > Generally for QEMU this will be less agility, unless I misunderstan=
d
> > > > what is proposed)
> > > >
> > > > Because presumably there will need to be spec releases then?
> > > >
> > > > So
> > > >         new feature -> spec tree -> spec release -> qemu implementa=
tion -> qemu release
> > > >
> > > > is surely longer that what we have now.
> > >
> > > I see your point.
> > >
> > > However, we do not really need to introduce a heavy release managemen=
t
> > > layer. We could just operate it as a living document, where the main
> > > branch is the authoritative source of truth.
> > >
> > > For the workflow, development doesn't have to be strictly sequential
> > > either. A contributor can propose the spec update while working on th=
e
> > > implementation, much like we do for VirtIO updates. Actually, this wa=
y
> > > one update/change supports the other.
> > >
> > > I guess my point is that a dedicated repository could lower the
> > > barrier for new changes AND keep QEMU's own development speed mostly
> > > unaffected.
> > >
> > > BR,
> > > Albert
> >
> > Something something submodule? Possibly. If you want to make progress
> > on this, pls think of the process, try it out.
>
> If I understand correctly, the motivation for moving the spec
> somewhere else is to replace the email patch review process with a git
> forge review process?
>
> This seems like a superficial change and is not worth in my opinion if
> you consider we'll have to redirect from the old spec location and
> move the community over to the new repo.

The core issue from my perspective is project neutrality and
decoupling lifecycles.

Currently, protocol updates are tied to QEMU's tree rules and release
freezes for example. Since these changes also affect other projects
(like rust-vmm, crosvm, DPDK, etc.), separating them may make sense
and could streamline the process.

>We could actually lose spec
> change reviewers in the process either because they don't know what's
> going on or decide that they prefer to spend time elsewhere when faced
> with switching processes (the people who review and participate in
> discussion do so out of personal interest and as far as I'm aware no
> one is employed to work on vhost-user as their #1 priority).

This is a fair concern. I hope we maintain reviewer engagement. But it
could also be argued that contributors from other communities may be
more comfortable with a dedicated project-neutral home. It could well
go both ways, but it also represents an opportunity to grow.

>
> Having said that, here is what I imagine it would involve:
>
> 1. Michael creates a new repo on a git forge (if he wants it to be
> under the GitLab qemu-project organization I can help with creating
> the repo, otherwise he creates a new organization and repo).
> 2. Discussion happens in Issues.
> 3. Spec changes are proposed in Merge Requests. Michael merges them
> once consensus has been reached.

Mostly yes, though we wouldn't necessarily need Michael as the sole
gatekeeper. We could invite co-maintainers from other key projects to
share the reviewer load.

Also I'd want to clarify that although I am advocating for this
change, I do not claim to have the definitive roadmap. I am just
sharing my view on why this could be a positive evolution. Consensus
may end up being to remain with the current status quo, or any of the
other options proposed by Alex.

>
> It's similar to what we have now in qemu.git, except that a git forge is =
used.
>
> Stefan
>


