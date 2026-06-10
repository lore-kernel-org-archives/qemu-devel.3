Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532B8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLyL-0000gd-BR; Wed, 10 Jun 2026 12:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXLyK-0000fc-Mk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXLyH-0005x8-WE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781109604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTDy24NH9UYxoxlXw3NE4ckF+IEz98PI/ULotuvtC0s=;
 b=HshnndjEnvKwoNkpXYhf0TzQID3C14m0Ian3jGDh19GDCoPud8Q0YDIn4TW2J0CfA68JRW
 0MYWMpF8kADjQj8+RGRdZ5UpjCI/ySl4t58xHJbIjstShz9EriroBvtRrYz8Dq1ejjLgfi
 b5sy3qh5Snb1dAPEm5Ve7rBDl7K3LKQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-15bLSF9WPFSU_nR9bm1VFw-1; Wed,
 10 Jun 2026 12:39:59 -0400
X-MC-Unique: 15bLSF9WPFSU_nR9bm1VFw-1
X-Mimecast-MFC-AGG-ID: 15bLSF9WPFSU_nR9bm1VFw_1781109597
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6099A188EB59; Wed, 10 Jun 2026 16:39:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0455936512; Wed, 10 Jun 2026 16:39:47 +0000 (UTC)
Date: Wed, 10 Jun 2026 17:39:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <aimTUHRIOFwYXvpw@redhat.com>
References: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <20260609163536-mutt-send-email-mst@kernel.org>
 <CAJSP0QWP5OnSaed4xD0FomwVSs1mN7e_U2jaM9KPFEy2bWPrVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWP5OnSaed4xD0FomwVSs1mN7e_U2jaM9KPFEy2bWPrVQ@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 10, 2026 at 09:03:39AM -0400, Stefan Hajnoczi wrote:
> On Tue, Jun 9, 2026 at 4:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 09, 2026 at 03:44:49PM -0400, Stefan Hajnoczi wrote:
> > > On Tue, Jun 9, 2026 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > > > I'm not sure if anyone brought up this topic on qemu-devel and with
> > > > > Michael before. As I mentioned in my reply, there are ways to avoid
> > > > > blocking vhost-user spec changes when qemu.git is frozen:
> > > > >
> > > > > The simplest approach is to keep merging vhost-user.rst changes during
> > > > > freeze since it does not jeopardize the release or introduce
> > > > > instability.
> > > >
> > > > I'm not enthusiastic about having "this one document is an
> > > > exception to our freeze and release process". Because it is
> > > > only documentation, it is in the same "we can be relatively
> > > > relaxed about allowing in documentation changes" boat as
> > > > most of the rest of the docs. But docs changes can break the
> > > > build (e.g. if you mess up a rST syntax thing), so as we
> > >
> > > CI prevents broken rST from being merged (there are multiple jobs with
> > > `--enable-docs`), so I'm not sure this can happen?
> > >
> > > > get closer to the final release we are going to get more
> > > > strict about "is this change really necessary or can it
> > > > wait a few weeks?", and they must at a minimum continue to obey
> > > > the "no changes of any kind between the last RC and the final
> > > > release" rule.
> > >
> > > Why is the final release candidate special?
> > >
> > > > And definitely if a patchseries has both
> > > > QEMU code changes and documentation updates then that is
> > > > going to not get applied during freeze if the code changes
> > > > don't follow the freeze rules.
> > >
> > > I agree that code changes cannot be merged.
> > >
> > > As long as the vhost-user maintainer is confident that the spec change
> > > is implementable and stable, they can merge the spec change on its own
> > > without code changes. If they are not confident, then the spec change
> > > isn't ready to be merged yet.
> > >
> > > Stefan
> >
> > I personally have been confidently wrong enough times. Maybe others know
> > how to do better.
> 
> There is a risk with merging a spec change without a finished
> implementation, so no one can get it right every time.
> 
> I bring this up because a clear guideline would help implementers know
> what to expect.

I'd be inclined to require non-trivial spec changes to have an
accompanying impl that is broadly feature complete, linked to by
the contributor as a pre-req for merge.

If an impl is not ready, then by all means send spec proposals
for the sake of design discussions. It can evolve in parallel
with the impl, but the spec doesn't need to merge until the impl
is broadly complete.

A code impl does not need to live in the same place as the spec
though.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


